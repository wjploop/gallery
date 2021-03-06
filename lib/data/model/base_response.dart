import 'package:gallery/data/model/Page.dart';
import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse<T> {
  final int code;
  final String msg;
  @_Converter()
  final T data;

  BaseResponse(this.code, this.msg, this.data);

  factory BaseResponse.fromJson(dynamic json) =>
      _$BaseResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

class _Converter<T> implements JsonConverter<T, dynamic> {
  const _Converter();

  @override
  T fromJson(dynamic json) {
    if(json is List) {
      return json.map((e) => null)
    }
    if (json is Map<String, dynamic> && json["type"] == "page") {
      return Page.fromJson(json) as T;
    }
    return json as T;
  }

  @override
  Object? toJson(T object) => object;
}
