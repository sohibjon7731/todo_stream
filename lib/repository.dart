import 'dart:async';

class Repository {
  final StreamController<List<ToDoModel>> _controller =
      StreamController<List<ToDoModel>>();

  final List<ToDoModel> _todos = [];

  Stream<List<ToDoModel>> get stream async* {
    yield* _controller.stream;
  }

  /* Future<List<ToDoModel>> getTodos() async {
    final data = await controller.stream;
    return data.toList();
  } */

  Future<void> createToDo(String title, String description) async {
    final newToDo = ToDoModel(
        id: _todos.lastOrNull == null ? 0 : _todos.last.id + 1,
        title: title,
        description: description);
    _todos.add(newToDo);
    _controller.add(_todos);
  }
}

class ToDoModel {
  final int id;
  final String title;
  final String description;
  ToDoModel({
    required this.id,
    required this.title,
    required this.description,
  });

  ToDoModel copyWith({
    int? id,
    String? title,
    String? description,
  }) {
    return ToDoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }

  @override
  String toString() =>
      'ToDoModel(id: $id, title: $title, description: $description)';

  @override
  bool operator ==(covariant ToDoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.description == description;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ description.hashCode;
}
