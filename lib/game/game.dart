import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
// import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'package:squish_them_all/game/actors/player.dart';
import 'package:squish_them_all/game/level/level.dart';

final screenSize = Vector2(288, 208);
Vector2 worldSize = screenSize / 100;

class SquishThemAll extends Forge2DGame
    with HasKeyboardHandlerComponents, HasTappables {
  // ? makes the type nullable.
  Level? _currentLevel;
  late List<Image> spriteSheet;
  late Player player;

  // Todo: change gravity back to 15
  SquishThemAll()
      : super(
          zoom: 100,
          gravity: Vector2(0, 15),
        );

  @override
  Future<void>? onLoad() async {
    await Flame.device.fullScreen();
    await Flame.device.setLandscape();

    // This will make sure to load and keep a reference to the spritesheet before starting the game.
    spriteSheet = (await images.loadAll(
      [
        'Angry Pig - Idle (36x30).png',
        'Angry Pig - Walk (36x30).png',
        'Angry Pig - Hit 1 (36x30).png',
        'Angry Pig - Run (36x30).png',
        'Angry Pig - Hit 2 (36x30).png',
        // 'Checkpoints - End (Idle).png',
        // 'Checkpoints - End (Pressed) (64x64).png',
        // 'Fruits - Apple.png',
        // 'Fruits - Bananas.png',
        // 'Fruits - Melon.png',
      ],
    ))
        .cast<Image>();

    // Basically this viewport makes sure the ratio between width and height is always the same in your game, no matter the platform.
    camera.viewport = FixedResolutionViewport(worldSize * camera.zoom);

    loadLevel('Level1.tmx');

    return super.onLoad();
  }

  void loadLevel(String levelName) {
    // This will remove the current level from game if there is any.
    // See what happens without it(~)
    _currentLevel?.removeFromParent();
    _currentLevel = Level(levelName);
    // ! does the null check. Like,
    // if (currentLevel == null) return;
    add(_currentLevel!);
  }
}
