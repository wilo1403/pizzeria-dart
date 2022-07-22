import 'dart:io';

void main() {

  Pizzeria _pizzeria = Pizzeria();
  String sizes_pizza = '';
  _pizzeria.sizes.forEach((item) {
    var id = _pizzeria.sizes.indexOf(item) + 1;
    var type = item['type'];
    var value = item['value'];
    sizes_pizza += 
'''
    $id $type $value
''';
  });

  print('''Welcome to Surfer Boy Pizza
   
  Nuestros tamaños:

 $sizes_pizza

  Ingrese el número del tamaño de pizza que desea ordenar:

  ''');

  int size_validation = -1;
  while (size_validation < 0) {
    //get pizza size
    int size = inputData();
    if (size < 0) {
      continue;
    } else {
      size_validation = size - 1;

      //Verify pizza size
      if (!_pizzeria.verifySize(size_validation)) {
        size_validation = -1;
        continue;
      } else {
        _pizzeria._size = size_validation;
      }

      int number_pizza_validation = -1;
      while (number_pizza_validation < 0) {
        //get numbers of pizzas
        int number_pizzas = inputData(label: 'Ingresa la cantidad de pizzas:');
        if (number_pizzas > 0) {
          number_pizza_validation = number_pizzas;
        }
      }
      _pizzeria._number_pizzas = number_pizza_validation;

      //calculate order
      _pizzeria.calculateOrder();
    }
  }
}

/**
 * 
 * Class that verifies the size of the pizza and calculates the total value to be paid.  
 * 
 */
class Pizzeria {
  //Pizza sizes
  List Sizes = [
    {'type': 'Grande', 'value': 6000},
    {'type': 'Mediana', 'value': 4000},
    {'type': 'Pequeña', 'value': 2000}
  ];
  int _size = -1;
  int _number_pizzas = 0;
  int total = 0;

  //Get sizes pizza
  List get sizes => Sizes;

  // Set size
  void set size(int size) {
    _size = size;
  }

  //Get size pizza
  int get size => _size;

  // Set number of pizzas
  void set number_pizzas(int number_pizzas) {
    _number_pizzas = number_pizzas;
  }

  //Get number of pizzas
  int get number_pizzas => _number_pizzas;

  //Verfy pizza size
  verifySize(size) {
    if (!Sizes.asMap().containsKey(size)) {
      print('Tamaño no valido, intentelo de nuevo');
      return false;
    }
    return true;
  }

  //Calculate total order
  calculateOrder() {
    if (_size > -1 && _number_pizzas > 0) {
      total = Sizes[_size]['value'] * _number_pizzas;
      var type = Sizes[_size]['type'];
      print('''

******************************************

Resumen de pedido:

Tipo de pizza: $type
Cantidad de pizzas: $_number_pizzas
Total: $total

******************************************

''');
    } else {
      print('No se pudo calcular');
    }
  }
}

/**
 * 
 * Function that requests a data from the user, validates if it is a number and returns a value.
 * 
 */
dynamic inputData({String? label}) {
  if (label != null) print(label);

  dynamic number = stdin.readLineSync();

  if (int.tryParse(number) == null) {
    print('Debe ingresar un número, intentelo de nuevo');
    return -1;
  } else {
    // print('Numero ingresado: $number');
    return int.parse(number);
  }
}
