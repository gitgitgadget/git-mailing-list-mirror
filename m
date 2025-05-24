Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010012.outbound.protection.outlook.com [52.103.67.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA9D3C1F
	for <git@vger.kernel.org>; Sat, 24 May 2025 02:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748055409; cv=fail; b=H7404n5KF5E9QhH+hOjzc39TkJrD94dlYuTqxOQWActB0NNF9SzoBLnxOqNBXwLHDb0BFujOMuZJWL05O6t/ycl1xMo2L6kpScTbb5Og9y7YGA+nEN6Y8b/UGXzDSI8+pR2NEoA8mMjjcROgDEKWJcXLcfZjxOHQhtZ/z8jSqAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748055409; c=relaxed/simple;
	bh=n+9TUIua9veF2n8Squv/VJlIQKVumEPWW0IMGVFgiBw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AivQjLxbirwL1bXFcyAlNtlQ4L8WeOXNaX+da4aCTo90SvrBCW5/F4sSblCjgbOTR54A/xqzAwan9FdfHg75ZIr3s4RU+dlvkcqNWRnGMEb3/z70mTWI738+PT+ST+sUd8LGP0Z2/00MjuSlvu3D2ZYUCzR9rgQVyaruya/dAC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=t6THOngf; arc=fail smtp.client-ip=52.103.67.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="t6THOngf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jKE8kIqS11aWaKDT83qmKAXVP+ntAACBcyn69Fz4lRDNboNm+smowiIikt9vV/E/8RUCzB7vbx3r9vvLnfe1vx1YDZgguli5qLIRY11wwSmTeK0Iw59Q3shq+5FX0xnonF/9WkVWBTtCl5zY7y60lsNEr09xJ3A4L3CrBUuqTDb21Gmz8W2kbyxZXkcLtfJyGXbv9pLykinQcFBeYVRaxVFPQpXRKaswyupIiL6SJVd7WLXt6LLdjq7gyr4PFxWlYcdjT9T4AZ+wElNDB7WmtxDQl3aamJPELpVvmyUvdYdNtucRtgghJFBhtohoTUl//UmUAzi6o22FVYqxCfPsAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+9TUIua9veF2n8Squv/VJlIQKVumEPWW0IMGVFgiBw=;
 b=dZygFDwmvcV8hrMtkUVIqvPA58OgXkQQgCWbiWDVNiZsqx7AAQqVlmQjwLn4rszyMK4OJNn/4QUI/Nb1UQTTwdPWub40i8P9x2k9hAhB2p9ImXw0NJl2cnyMHo4LNTvBJTLSoZqoz7Nvx9h/IdJdtD+0FLLYcirAGFMljUvdcnpgDJl4gJ6F4Pxd0o41Kw+cc7PiO2BI7jNmKeUWALlmUPCcaiW1rm24O8PJngnvFUfAi8eDWs3cKge1GAZG9PKXR8bSV3/kDR65/hT/7bwFDL2674TX43jgo3TF0gzvUGdvTw0Q5DcsDjdOd6lRUfNnz1vSz+dfk4e8e1wbIcM7SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+9TUIua9veF2n8Squv/VJlIQKVumEPWW0IMGVFgiBw=;
 b=t6THOngf9gsoNTWOX0RLFz6hOUGCEKylRHh5AgL94/Q33D55I2cPIAvW8mHlL7RVHsnposqo9NQJLWrbsNrhOIDxM3VOcoViPz+ZvKBWDHI26f6qTowOu3bjzjWEXMdGrgukMED+bXMcr0eX3oYbsRob0T0idEh01UsaCJyXt4+PSOEE6FBlZAC9DeRvasrtxWAGVhIxfPDWDjFlW3ZsVCf/RhD0rU6yeJr+8ix7ie7yXiKdi5Ia6gOuWH+pVdA7gUCKpi9ytl/n6cpmZpca0jY0Og10bvOIUOkoqsozwSXzsjPxqV3HKOBLR22JbjuUMApbPSn2FAeIXHRgCY8GCg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7901.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 24 May
 2025 02:56:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sat, 24 May 2025
 02:56:42 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Julian Swagemakers <julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>, Jeff
 King <peff@peff.net>
Subject: Re: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Topic: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Index: AQHbzFd61yj/UtZ5jECrkiAGlKoDQw==
Date: Sat, 24 May 2025 02:56:42 +0000
Message-ID:
 <PN3PR01MB959739D5935F0BACD724FAA1B89BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7901:EE_
x-ms-office365-filtering-correlation-id: 6ab2a997-3d7d-4adf-dccd-08dd9a6e9d1c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|15080799009|8062599006|8060799009|7092599006|6072599003|8022599003|56899033|4295299021|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?RUxpUldQOTROSXdsTyswUmJieVZGeFp0dkczcklzZTlKVElsdlVoSlNMa29r?=
 =?utf-8?B?RVZQanFQdC9DWGI5ZllvdXpIcXhrYnZNVjJNVmJlZU1CZUFqeWVYcHZCKzNv?=
 =?utf-8?B?RmpjM1lTek1iTTdzUlJKQXZKYjgxd0tOVDRjUFZNOVV3bExKMU0xSGsxVTVp?=
 =?utf-8?B?QnJUQmdsUVMyblYwalZzc1UxUmo0d1ViVGJ4dGpSMTYyeGloWUhKL1ZYTHYv?=
 =?utf-8?B?WHNuQ05SQmhqNDVSUktsa3haQUwxSzFRMnlTb3dFNW9LcXgyQzZsRkI3dlcv?=
 =?utf-8?B?ZjhOSTQ4eitCZzUrOURRRTl1V3o2MmZ2eXB4YWRFdms0Z0tMOHg0MDlPSDZB?=
 =?utf-8?B?SEEzZEhJMlBleHBoOVovbmlSWENYMzB4eURPdDNVbW50OUFOYnVWL2RQUFEw?=
 =?utf-8?B?cS8ybzFkeG82TFNKcEJJbVFsNjFjRURqajU0bDJ2RWhYRFk5QUNoK3BsUm9W?=
 =?utf-8?B?ZFIwQmZma0hZVFJYTlp3OFYxcjJ3TmQxUzQ4aTh5dVN5TnZHakVCcW9TdVI4?=
 =?utf-8?B?Y3IzVk51dk5RKzY0aWVlSlEya3o4OU9qN2c5UlZIT3JsbHlmS0F5ZXpJS1ov?=
 =?utf-8?B?QW8wcml1RlpKVG9hL0Q5V3QyZldmSjJNaUtGN2pGLy9LVGxBNHVYQkFGZTZR?=
 =?utf-8?B?cnJiWXVFb0tCNUpqbURWeVBYenpvekVpWWkwWWN2RnhpMFFKUEtOTWFpZVgv?=
 =?utf-8?B?Z01QcktMeGNTcWxSanlwRTBFLzZPTjk2VUlEcU5kTWZVWEx2TXNSSG81cWM5?=
 =?utf-8?B?VytsTkFudXN6dVY0OTIvRVRsZ3g2SXNaTkVYenVrWHd3L0F4a1RCc0Y0M3Jz?=
 =?utf-8?B?eWc1SUQzdXZENWw3RXQ5a2tKeFNGTEdGNXBzT3RTV1c4RWtKTEZRbitucWFl?=
 =?utf-8?B?WGsrOGg0NllkdHB2NFdMU29KSnR5SmhvZllZVHM3N1F5ZTBteXhzQkxuODBL?=
 =?utf-8?B?N3RSUCt1M2MvRUtPczZQUGx1M1lhVllid2k3YU1NaGdKMmVPMkR1UUxKb1dj?=
 =?utf-8?B?TG9vMjBJaWRCQy9ObjNtb01ubXY1bmYxVlVIRktwWlJEaUNUTGRvdzRBZVZ0?=
 =?utf-8?B?WHR2V3kzZE1tOGNVYnZpejZ6TE5hcUczZW1MM3diUklORjkra1VQb3QrM3B6?=
 =?utf-8?B?MXdpckxEK2VDK1M5V0RuM0RQYU85MDBLSG1HVFlNUEcwMjhWWmlUMEFKNFBj?=
 =?utf-8?B?TE51T1dHUEc3dmhzc2ZlWGlZbk42MnlYUFgwVUdxV1o5blFDVmxKNktTSVN1?=
 =?utf-8?B?ZHBWSnFpUzRsNkpSbmpYV096ZTBZNlR0SDg4azlvUzJncFVlWTVsRzI1LzhN?=
 =?utf-8?B?ZFo2UG1XcW5jd2k4Yk83dTErQlU3RUIzMjdZTW5IODVKUStWaG1TaGJraWpR?=
 =?utf-8?B?cjRKLzBqS1FpL1Bhbktaampxb091a1NqRTJQMW52dnoycmd5aGtWK09XaWpr?=
 =?utf-8?B?SWlpMkhSRktVdVVvZW8wQWpKeG1YYWVzMUhBN1lLc1d2WlZjZ2Z4YVlSVUly?=
 =?utf-8?B?RkNvcUlSWkUrczJraCtMcitlbVNEVEpVQ20vZk9VOHBNeDdoYjRaUXZtMkor?=
 =?utf-8?Q?ZkMyQU+7RU+8ykjWrfiueBlDA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFJqODUxSWhyMG5vdk5ER3FOc29LY0hXb3pLd1JKZDNucDgxQ1g3NkxlY0p6?=
 =?utf-8?B?Z0JjYXZiaHA0djgvYWJjR1ZYYnFMa3BSNUgvL1NTcmw4R3Q1bWFPNjBHM1pD?=
 =?utf-8?B?Q2hJeTN5MzFrUDdzWmgvOEwvVnlPZHIzS0NxaGxVUStyek9QZnFuV0hQZE1O?=
 =?utf-8?B?NGJSMzk0MUpUVFhmc0xjV0FNQmJsZ3ZBaWZFYlBGMmcvLytpazVLdHpWN29G?=
 =?utf-8?B?Y0cvWWgydVJ0M3JYdmp5Z0NpZ2ZSYi9mYUJEaHJ2WGgvNGRLd200dkZud1ZF?=
 =?utf-8?B?WlpYWlBHYnpSRzZ0dW1KWUExZG02Zm83OEZxa1lUSm9MeUE0UHVSRkF6YzFX?=
 =?utf-8?B?VFBSdmVRSkhEVDUzN3RpOUFDY05tenV0TTdqTUlKV3F4dzZpamNiTVJkcks4?=
 =?utf-8?B?Q1RLOFBQYk5tUy85Q1cyYnJNb29aZDlxb3dYNmlpUlEwRk83NE95RElmQWxY?=
 =?utf-8?B?MXZ1dGFNd1hyTDBpWXdIQnNNVWgwWG9WN0dxcTlSMDJqcmNkWjIyaVhZOVhJ?=
 =?utf-8?B?OENDeDlpTndxUk5ibnF1Tk93OXh0RCt0N3Q2Y1Znd2t0dzRUR0V1YkhZY0V3?=
 =?utf-8?B?TWN4L3p6bFZnK2cyNm8rZUJMcTVqWU0vT2ZQSlk0R3NnamxUVVhHNHZTcmpK?=
 =?utf-8?B?SWdlNjIreUhxZGhXMThOUHdaMXNDZlFHK0lmdFVpWmxlSm80UG1aNjNrdTF5?=
 =?utf-8?B?cldNWmdCYTVSRmw0S3N2ajZFK2UxR1lxYno4MUtsQTU5VFVSeFRmNGJiSmFV?=
 =?utf-8?B?Z29SWHlyckVDTVRsTTAyOEhLU3VIekg4dm9MZVNNaGF0dlE0QURiVVZFa1ZY?=
 =?utf-8?B?dktXRWdIMEY0YlBWU1FXaUxDNkg4TmRLVGlHZzc4U1N2SU85V3AwMDBQS2da?=
 =?utf-8?B?RWlRU2R6bDVPWG1XZmpCUmplVjlLVjkvK1crMFRFYU5KcWhmWWRRc2NCQ3ZR?=
 =?utf-8?B?ODhITE10TzlpTTdobVNySHZNQ2QzZXhUb1RNT2Q2MHVZNE9RYXVsc21xQXpX?=
 =?utf-8?B?cERPWjVVREhIbjNHc1M5MndndUYzUzF5NEhyVU9GNWtyRDdpVTFRZGFlMFQy?=
 =?utf-8?B?Wk5GcnpqMkNYeHNMMmc3Y2dONFhHbU4rY1g3ejNnd3JYb2RJejdLM0NQM1lX?=
 =?utf-8?B?MWU2RXVkMmVEbmwvM2o3Y2VaQ1ZQeXd1T2VHMlBjRTNIRnZJQ0xCQ0xtNDNp?=
 =?utf-8?B?NVc3M2VpM2RSY0I0THdzU24yQTh6VjEzY1V0U3BrSzhTMVBiRUlMSnNqSXp4?=
 =?utf-8?B?bzF3K2JyVUs4bTFpSE5ibWljR002YTZUNGNNc0kyLzU4RTZpTWVOa1IxZDFv?=
 =?utf-8?B?REcxRWMwclpYMmtETkxZZDZkOTI1M2lIOVhMSGx1S1RqMzZBQ0VTNTYrdEJx?=
 =?utf-8?B?MXAwVFdKK3piM2VQUzU2RHIrbkYwK204MS9pbEd6MnVLbjM5ZmxyMlcreWEy?=
 =?utf-8?B?SS9DVyt6cnJweVRVeEhSSmZaendINnlvUExHeEd0Ti92S1Z1Yk4xUk80TjBz?=
 =?utf-8?B?NkpIQmZaYmxvTjdOUFIyNVdlWGNXZVNhSmVCSDZJcFNaMjdra3o3L1hDZGZh?=
 =?utf-8?B?b2hIRnRZRkVtOUhRWi91Njl5aGZFRzZsc0Z1THJ2Wm5qTDNGZmJWV3FDZ2pS?=
 =?utf-8?Q?XsJVid3vdQVxOrm7N3QzEpXdn2cMKQdK7YzKWuGzKW7M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <2D23C8AA86B91946802D90687E63F0C3@sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab2a997-3d7d-4adf-dccd-08dd9a6e9d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 02:56:42.9317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7901

DQoNCj4gT24gMjQgTWF5IDIwMjUsIGF0IDM6NDnigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBTbywgd2hlbmV2ZXIgdGhlIGZpcnN0IHBhdGNoIGlz
IHNlbnQsICRudW1fc2VudCB3aWxsIGJlY29tZSAxLg0KPiANCj4gVGhlIHJldmVyc2UgaXMgbm90
IGFsd2F5cyB0cnVlLCB0aG91Z2guDQo+IA0KPj4gICAgIyBzZXQgdXAgZm9yIHRoZSBuZXh0IG1l
c3NhZ2UNCj4+ICsgICAgJG51bV9zZW50Kys7DQo+PiAgICBpZiAoJHRocmVhZCkgew0KPj4gICAg
ICAgIGlmICgkbWVzc2FnZV93YXNfc2VudCAmJg0KPj4gICAgICAgICAgKCRjaGFpbl9yZXBseV90
byB8fCAhZGVmaW5lZCAkaW5fcmVwbHlfdG8gfHwgbGVuZ3RoKCRpbl9yZXBseV90bykgPT0gMCB8
fA0KPj4gLSAgICAgICAgICAkbWVzc2FnZV9udW0gPT0gMSkpIHsNCj4+ICsgICAgICAgICAgJG51
bV9zZW50ID09IDEpKSB7DQo+IA0KPiBUaGlzIHNhaXMgImVudGVyIHRoaXMgYmxvY2sgaWYgd2Ug
aGF2ZSBzZW50IGEgbWVzc2FnZSBhbmQgb25lIG9mDQo+IChudW1fc2V0IGlzIDEsIG9yIHdlIGFy
ZSB0b2xkIHRvIGNoYWluLXJlcGx5LXRvLCBvciB3ZSBkbyBub3QgaGF2ZQ0KPiBpbi1yZXBseS10
bykgaG9sZHMgdHJ1ZSIuDQo+IA0KPiBCdXQgaXMgJG51bV9zZXQgPT0gMSByZWFsbHkgbGltaXRl
ZCB0byAidGhlIGZpcnN0IG1lc3NhZ2UiPyAgR2l2ZW4NCj4gdGhhdCAuLi4NCj4gDQo+PiAgICAg
ICAgICAgICRpbl9yZXBseV90byA9ICRtZXNzYWdlX2lkOw0KPj4gICAgICAgICAgICBpZiAobGVu
Z3RoICRyZWZlcmVuY2VzID4gMCkgew0KPj4gICAgICAgICAgICAgICAgJHJlZmVyZW5jZXMgLj0g
IlxuICRtZXNzYWdlX2lkIjsNCj4+IEBAIC0yMDYwLDcgKzIwNjEsNiBAQCBzdWIgcHJvY2Vzc19m
aWxlIHsNCj4+ICAgICAgICAkcmVmZXJlbmNlcyA9ICcnOw0KPj4gICAgfQ0KPj4gICAgJG1lc3Nh
Z2VfaWQgPSB1bmRlZjsNCj4+IC0gICAgJG51bV9zZW50Kys7DQo+PiAgICBpZiAoZGVmaW5lZCAk
YmF0Y2hfc2l6ZSAmJiAkbnVtX3NlbnQgPT0gJGJhdGNoX3NpemUpIHsNCj4+ICAgICAgICAkbnVt
X3NlbnQgPSAwOw0KPiANCj4gLi4uIHRoZSBjb3VudGVyIGlzIHJlc2V0IHdoZW4gd2Ugc2VuZCBv
dXQgdGhlIGJhdGNoX3NpemUgbWVzc2FnZQ0KPiAoYW5kIHdlIHNsZWVwIGluIHRoaXMgYmxvY2ss
IHdoaWNoIGlzIG91dHNpZGUgdGhlIHBvc3QtY29udGV4dCBvZg0KPiB0aGlzIGh1bmspLiAgU28g
d2hlbiB5b3Ugc2VuZCB0aGUgZmlyc3QgbWVzc2FnZSBvZiB0aGUgbmV4dCBiYXRjaCwNCj4geW91
J2QgZG8gdGhlIHNhbWUsIG5vPyAgQnkgdGhhdCB0aW1lLCB3ZSBoYXZlIGluX3JlcGx5X3RvIHNl
dCwgYnV0DQo+IHRoYXQgZG9lcyBub3QgcHJldmVudCBmcm9tICRudW1fc2VudCwgd2hpY2ggd2Fz
IHJlc2V0IHRvIDAgYXQgdGhlDQo+IGJhdGNoIGJvdW5kYXJ5IGFuZCB0aGVuIGluY3JlbWVudGVk
IHRvIDEsIHRvIHJlZW50ZXIgdGhlIGJsb2NrIGluDQo+IHRoZSBmaXJzdCBodW5rLCBubz8NCj4g
DQoNCkhtbSwgeW91IGFyZSByaWdodCwgdGhhdCdzIGEgcHJvYmxlbS4gSSB0aGluayB3ZSBuZWVk
IHRvIGZpeCBtZXNzYWdlDQpudW1iZXIgdGhlbi4NCg==
