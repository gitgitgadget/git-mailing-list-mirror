Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010007.outbound.protection.outlook.com [52.103.67.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80027814A
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745898268; cv=fail; b=EuVu2r0SL7I6TUhpjSrrgd6ar3jGktwwGWGggb0q/Ny83HDp46af51tHhhEW/tf5HqhROkQK7iU5meHBdltaFW95zQAMuK7u+6cKmIAoB3vXjkemjXEPGUE7kl5HbAwbGKZwpy6GkwpdjnCsF7TDunBD280Z+fmt/fm7V9QM3hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745898268; c=relaxed/simple;
	bh=q9/PBMQrDjx0Y/E6ekAU/c995my4TK/5y3nCHk1VLMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZhZ0tWSZwFoRXTDihVm/ld351pjVqmA5F6pLUoKZE7dsAJcyx04eQqD6eyIBMYRPQWkcGM73kv4vJ2rWJv4IOUdg4vJ6/WZwJU4a3/+MkFRF1UvfqSn5d7yvXG0D5qqtVyE0gPy7/xi0grp+AdWjjjufwC/IGp9AHMW5wZZl5fY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PkgAvMyM; arc=fail smtp.client-ip=52.103.67.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PkgAvMyM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOVxmyAmAgzmcpbYr+vEYPhWwheJuY3GIttJcq7WJMeE8EKAY9EkRXLfRQi25K83Mjpao4NM1BDxFXXN3QaE8QIikyn3CxDjU7PRVzkegjwMUrdsRC5rDT1IdRXMhaGlmcMqucOmXOwq+qP2jrIK/Jfj/zHs70NDlBrHQgp0CCzNIhyh6RXq6nBZhoJa6FCpvdhOgpxnVuuELd26ZDans/4N351+SlmBzWfzmHcUE3lum9TTcmsKwDmrho5EtegQrqTRloWIQTVY2doinA0tV1y+HjkBQ/JY2s5OdYrkeUtBW+MEFMvcptDNtrvy8wNEYPbzmIkpOcz7760lOKO6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9/PBMQrDjx0Y/E6ekAU/c995my4TK/5y3nCHk1VLMM=;
 b=ZowAJIghyeD17bGyUQi8ljRHqXza1GhMQcwlOTaCBxGvgXz+DnP6pCf8JhTzXZhUaUQ3RAl12tB7m3FFmgmuEGL84GrSXN+JHFe9iUaKTdc+371AnuRHwvNW/qKmi7Ow6ykg9rBMZ1L+nUVZct9+RUbhvNENCWT33sNkGkXPaqswsAQu8NyMiVbe0rB3RsIeMGIn6YyTfyJpETWYg+zjO+IZc+0x3PsJdlgqcLdpov97rBkjWnLd9eiEg02GI56PwTCIP/3o4e6K7agA+M8fPkGXmcjULN7bvhn6bp1K1Vo858wAd2hOGK7YCV5h1QjR1g3slVZMskiJHA1vYK2ukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9/PBMQrDjx0Y/E6ekAU/c995my4TK/5y3nCHk1VLMM=;
 b=PkgAvMyMr9nZgMD+6CEn91Ul8boqi6UCzAPWG3HZWlCWosK153vthGje1oc+oshS2m1dwWhOmpPpBRQANGrzEGLcX1D5Jsbf5JxRMzkt5qX2fEPVLGAuyKb86KNE+oHQWjxBUL6hQMFlkCUuXCTdTb5SL2c0e4w346NNYJP19CFotprFxhSbDcP3rUI/68ARoZKTdziRuKeh3je+wQEdoG6tXOYsoGMHT8IJVpWyCQIofn/tfXYh73Au7m5tWxtsRWFDh2/hZ8FG/zSQdgflNFLKCEqYtITjhBg2C2G0206YovI60Zx1ZU/hq076UYwJMqBFoi2ok9lWyjU8oYE/EQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4251.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 03:44:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 03:44:21 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "ehuels@gmail.com" <ehuels@gmail.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "julian@swagemakers.org"
	<julian@swagemakers.org>, "mirth.hickford@gmail.com"
	<mirth.hickford@gmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, "wiagn233@outlook.com" <wiagn233@outlook.com>
Subject: Re: [PATCH v2] send-email: add --smtp-outlook-id-tweak option
Thread-Topic: [PATCH v2] send-email: add --smtp-outlook-id-tweak option
Thread-Index: AQHbuGcoCT9P23L66Uq1g9xpWFUATLO5jLRrgAB0d9I=
Date: Tue, 29 Apr 2025 03:44:20 +0000
Message-ID:
 <PN3PR01MB959780FDD3C37D037ABA59F9B8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597D897A65B4B59BA6FA93CB8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqh628au94.fsf@gitster.g>
In-Reply-To: <xmqqh628au94.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB4251:EE_
x-ms-office365-filtering-correlation-id: 7d42ec4c-6379-4f85-9c97-08dd86d02039
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8062599003|19110799003|461199028|7092599003|15080799006|8060799006|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?WXVobWlGMW45K0R5am1TTnVmL29LeFdZdGhJNUdBODd1WXJpYmFiaHU5N2Zl?=
 =?utf-8?B?S0RMdTVRVDFRTlk3TDV0YjE0b25oVGhpVVl4a3kzelBDSDhNejF3VmdXZnI2?=
 =?utf-8?B?eWxycHNtY2R6NlhpbElDeit3WnBzR1F5RG1UOFpta3dIZjd2WFRyc1NPOGh4?=
 =?utf-8?B?S2tGNWt1akIyMDlTczVTTHVqK3FjU2I1VXZXM1ozeDJ0UndSL2dWV1g5dmE4?=
 =?utf-8?B?UXRwblZHOEgybzRCTnJEOVdxOFg1b3BLczU0S3Q4K0RWZ0cxcm02WkRYYlBq?=
 =?utf-8?B?TlpJT2lkRGZ0VFAxbE1SMlVrZnlQUEp4Mk1wMmlpRmlQUitVcWRPK0tmTDVM?=
 =?utf-8?B?dkEzWk1xeXVyeXVCNEZFQitkZUF0VG84R2Qwd1ViUWltakZ0MXQ4NFZqNWlp?=
 =?utf-8?B?K1hlWkY1TkZ6Rm5UNXBtbnhqZk4vNmNiYkJZT05paXkyWkQrRm1nbXRVOXR5?=
 =?utf-8?B?YkMwaXJRM20rVHhqZ09aTThCVlBUUzlWUW51T3VxeFBrWmRPdzFOK21NQWZE?=
 =?utf-8?B?MFV6MDQyYjRtVjRZSk5RYW5pbXplKy9rdkgyQ0xlRktzeXI5a2xXdVNoWmY4?=
 =?utf-8?B?VG53UExnRHBvR200cXkyaTkrU3hScncxVC9mUy9yWkN1bTdKRGdtanZOc3oy?=
 =?utf-8?B?YldGVHd0QjJNdVZmZ2dXWE5EdmtUd3c3UjFnekxCM0lpeU5YY0MxRXkzYmI3?=
 =?utf-8?B?SUsyNVJqaGRMTGVJdHhzQ3NQTkYvM3pRZnhrcUp1MUs1VnBabDI0aGkvS1o5?=
 =?utf-8?B?cHIyem9BaEFhRWM5dy9CTTRJZUp3N3ducjNpQ3MyR2d3ZEorZkUrTUxWcGlR?=
 =?utf-8?B?QVFxV09pajBCbFFrSWQ1NGdmRXVqck9FUEt4bjZPYXFvNTUxakNubDI1Zjly?=
 =?utf-8?B?cnJXcDVWdzk2SG1LdFZCRS9ReTdYM21peW1YM0tSeU9TMzJSTkROOVFKVVlX?=
 =?utf-8?B?MnBtdFMvNEwvaWU1OGVQNnJUYnV3MmVDcWovUktuMU5ISDhzNnE1ZUg0amwy?=
 =?utf-8?B?aGlVVHdpZzRkc2UvYmd5V2ZHMUxXMTBLOXlFRVF5cWlNeSs5RHBrMElRREVS?=
 =?utf-8?B?TXNnWklaNTBjaEE5S1ZWVkczd0RlN0E2UEJ5ZXIvUkl5WkNtemNpbW1XVmVO?=
 =?utf-8?B?RFJvT25HZVJzK0xUam5ZWi9GREZZNSt3cnJkNWk0TEZmMVU3ODZPL1diUlZw?=
 =?utf-8?B?cTRRaGsyMlY1SUZVUC9zZjRvWWlxY2xzRW1EMXYrMDkxRWpLb0dnNTI3MXA2?=
 =?utf-8?B?ak1VeW1aQXFrSlNLWGhYVHhlVHZIZEcwUVFFTmQrY1FoZFpjQlRUTUVScjk0?=
 =?utf-8?B?K25CZjhpUjFIeVQ5QVZPT2pZQ2E0OU5WS0xYZURJcjJnSjZsWC9tWnZBcUVY?=
 =?utf-8?B?TG4zNGpMR2d6dVZ0cmdvS3BBRFQxRjAyc0Rsb2pTYkY5MkkvVjE5dm1zaFk0?=
 =?utf-8?B?VzEzMU90N3NjZzhqNW9BRnJVYmRaTWJNV0xmYkJESkNBSTBRTS96VEE0eUtL?=
 =?utf-8?B?Y2xqRVhyU096cktxNXZyYTFaTjRlUXpCaktwRmlLQ3JzNktLRmM0anBPa2hq?=
 =?utf-8?B?VVRsdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGpncnhLSlpSY2pYTjd4SktnQlBZVDhGVTZ1aGtTcGpjZUxUaGlTUW13TEQ2?=
 =?utf-8?B?OHlUNncwWG1veXpaSUxMNzIxeWZ5S3g3eFRWYy9NZGxDRHEvZmNDZ1AxaUE0?=
 =?utf-8?B?VVUxRnpwSTZFVnFWaDkzZHVlMHhUSVhKSmFrRCtsMzNxY1JRTXBQbjNyMS90?=
 =?utf-8?B?M0dFY2RYQUxpd0l3b1F6UmVTNFpnUWkxWHVmZlIzZ1VJcWpuaytraHFrSWNH?=
 =?utf-8?B?NG9XbC9TTXIzS3I4eStwYUQxYm9aZXVsektFb2Erb2ZJb1V2bjYrNXFWMWM1?=
 =?utf-8?B?VXBjd1dxRDhjTGpvcUJabWhpT2llNkJKZzRDZDMyeGw3b1BvRDRaRW1QNlE0?=
 =?utf-8?B?SVAyOG1idXd6ZVNlV0dKOWpEMk5BS0dtdGRxd0IrUmpBZExPcVdPUERTKzMx?=
 =?utf-8?B?bnp5VnNxMXRpNVBKYTdRUzluSExFTk02aWhyU1lKV0tjajZBNDNHejluSVV5?=
 =?utf-8?B?MXNsYkk2S0l0Q2ZqbzlnQlZhMEFvUi9PMnJPMmpQSXVqdkJBVWxjbWliQ1Fn?=
 =?utf-8?B?eTBZTWJBeHRrbm5PM1k2SloyK3NVZ0VVa3lDNGFmc1cvWHkxalozQkEwNUQv?=
 =?utf-8?B?L1NrSGdReEdZRDZ0YVlzc3dZM3dMYkloK2VjU0luekRyTW5ZL0E3cFVUaklG?=
 =?utf-8?B?QzlnSkhDY0wzK0pjZTBoN0tOMDArKzQ2eUQyTkd4dExycnl6cUJFRmhxYXYx?=
 =?utf-8?B?NVpjQTV6MHpZZ2drdXgvVHl0U1BYdGdCdk5kdG01a3JFbmpISXpab0FOdkpq?=
 =?utf-8?B?UkxIcEdueitRd055NDZMbnlOVFFiTC8yOXFuUkV3cVYrRWIwanlIREg1Zk1J?=
 =?utf-8?B?VGpPMmd0c1haL0pjc3JWRDhYaXhIcG9USXNTSGpTRm9oQU9OVHo1ZnRIUDYw?=
 =?utf-8?B?TmV0UHRyRjY4TUNPeVU5YTlVUHZaYVJyVFZZWEpIWmQ4Y29DcEUxK3FMMWFx?=
 =?utf-8?B?eUZpYlFYTDBaSHdVN2RWNjdxa1JmRktObFp4VVAzQURGS3lFc1VlK3l3cmsy?=
 =?utf-8?B?c2llclloaDFiaks0ZzhZOU1qbHdKZm8zaHlUeGtLdUgwQkMrN1hKYm55Wmlx?=
 =?utf-8?B?L1FWUG9PR3ZaTWNNbndKMHJMZ2lJaXZvMUM4bnkySmlSN0pwTVovTERCRDVD?=
 =?utf-8?B?cG5wSHRmajhiVEZHeDZRMy9FRTdkemZzV3U3QVBaU1VFQ0g4aHlPUVlHSUQw?=
 =?utf-8?B?bCtyZFl4MEtRNkFwR2M3bThNSVQ0V1N6TVVqQ2FmQTJud3pDNkNlL3ZDUkE0?=
 =?utf-8?B?S0tzeHJKZDAzTGw3UFFnTmtvV2grbHJJaUlsU0hoM1ovV3ZXWU0wSFY3KzBt?=
 =?utf-8?B?VkxwVFNpSnNWMnQzN0dyS2ZDUFE4cnRkbEFjTlhaa1NvWGN1ejZCMmlSV01Z?=
 =?utf-8?B?dGNOZGZpc21LYWxSdGc3Z2p3N1JsTW12UGl0UE1Wa0t5VzZNVmo4em55bkhL?=
 =?utf-8?B?NmJlSEd4Z0h3K3crM2FKSGw1TEJodDd5SmhtMUVTVDJuNW5KejB5UUQwcjBC?=
 =?utf-8?B?bmRMTHN5eHNJOGpHYUUzRktkMDRkMTlRbDdudHVtR1l0akdmYXcyeWhGcU5h?=
 =?utf-8?B?Nzg5UElUVU9pZVNRUkx4b1NGTlpwbmdFaTJhYVdONFZ2R0dvWG56ZCtsNDFl?=
 =?utf-8?Q?QagrtBWmpVQXrDdiwt/KA16v5HZv07OxfyztqNut/KQ4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d42ec4c-6379-4f85-9c97-08dd86d02039
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 03:44:20.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4251

DQoNCj4gT24gMjkgQXByIDIwMjUsIGF0IDI6MTfigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBBZGQgYW4gb3B0aW9uIHRvIGFsbG93IHVzZXJzIHRv
IHNwZWNpZmljYWxseSBlbmFibGUgb3IgZGlzYWJsZQ0KPj4gcmV0cmlldmluZyB0aGUgTWVzc2Fn
ZS1JRCBmcm9tIHRoZSBPdXRsb29rIFNNVFAgc2VydmVyLiBUaGlzIGNhbiBiZSB1c2VkDQo+PiBm
b3Igb3RoZXIgaG9zdHMgbWltaWNraW5nIHRoZSBiZWhhdmlvdXIgb2YgT3V0bG9vaywgb3IgZm9y
IHVzZXJzIHdobyBzZXQNCj4+IGEgY3VzdG9tIGRvbWFpbiB0byBiZSBhIENOQU1FIGZvciB0aGUg
T3V0bG9vayBTTVRQIHNlcnZlci4NCj4+IA0KPj4gSGVscGVkLWJ5OiBKdW5pbyBDIEhhbWFubyA8
Z2l0c3RlckBwb2JveC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBZGl0eWEgR2FyZyA8Z2FyZ2Fk
aXR5YTA4QGxpdmUuY29tPg0KPj4gLS0tDQo+PiB2MjogUmVwbGFjZSB0YWIgd2l0aCBzcGFjZXMg
aW4gIm91dGxvb2tpZHR3ZWFrIiA9PiBcJG91dGxvb2tfaWRfdHdlYWssDQo+IA0KPiBHb29kIGV5
ZXMgOy0pDQo+IA0KPj4gKy0tc210cC1vdXRsb29rLWlkLXR3ZWFrPShhbHdheXN8bmV2ZXJ8YXV0
byk6Og0KPj4gKyAgICBPdXRsb29rIHNlcnZlcnMgZGlzY2FyZCB0aGUgTWVzc2FnZS1JRCBzZW50
IHZpYSBlbWFpbCBhbmQgYXNzaWduIGENCj4+ICsgICAgbmV3IHJhbmRvbSBNZXNzYWdlLUlELCB0
aHVzIGJyZWFraW5nIHRocmVhZHMuDQo+PiArKw0KPj4gKy0tDQo+PiArLSAnYXV0bycgd2lsbCBh
dHRlbXB0IHRvIHJldHJpZXZlIHRoZSBJRCBmcm9tIHRoZSBzZXJ2ZXIgb25seSBpZiB0aGUgU01U
UA0KPj4gKyAgc2VydmVyIGlzICdzbXRwLm9mZmljZTM2NS5jb20nIG9yICdzbXRwLW1haWwub3V0
bG9vay5jb20nLg0KPj4gKy0gJ2Fsd2F5cycgd2lsbCBhdHRlbXB0IHRvIHJldHJpZXZlIHRoZSBJ
RCBmcm9tIHRoZSBzZXJ2ZXIgaXJyZXNwZWN0aXZlIG9mDQo+PiArICB0aGUgU01UUCBzZXJ2ZXIg
YmVpbmcgdXNlZC4gVXNlIG9ubHkgaWYgTWljcm9zb2Z0IGlzIHlvdXIgZW1haWwgcHJvdmlkZXIu
DQo+PiArLSAnbmV2ZXInIHdpbGwgZGlzYWJsZSB0aGlzIHR3ZWFrIGlycmVzcGVjdGl2ZSBvZiB0
aGVTTVRQIHNlcnZlciBiZWluZyB1c2VkLg0KPiANCj4gSXQgaXMgYSBzaGFtZSB0aGF0IHRoaXMg
aXMgbm90IGp1c3QgYSBzaW1wbGUgYm9vbGVhbi4gIFRob3NlIHdobw0KPiBleHBlY3QgJ3RydWUn
IHRvIGtpY2sgaW4gd291bGQgYmUgZGlzYXBwb2ludGVkIHRvIGZpbmQgdGhhdCB0aGVpcg0KPiAn
dHJ1ZScgbWVhbnMgdGhlIHNhbWUgdGhpbmcgYXMgJ2F1dG8nLg0KPiANCj4gSWYgSSB3ZXJlIGRl
c2lnbmluZyB0aGlzIGZlYXR1cmUsIEkgd291bGQgcmF0aGVyIG1ha2UgaXQgc2F5Og0KPiANCj4g
ICAgLS1bbm8tXW91dGxvb2stbWVzc2FnZS1pZC1maXg6Og0KDQpJIGFtIHRyeWluZyB0byBpbXBs
ZW1lbnQgdGhpcyBmZWF0dXJlLCBzaW5jZSBhIGJvb2xlYW4gbWFrZXMgc2Vuc2UuDQoNCkJ1dCwg
SSBmZWVsIHRoZSBwYXJhbWV0ZXIgaXMgdG9vIGxvbmcsIGFuZCB3aWxsIGhhdmUgdG8gcmV3cml0
ZSB0aGUgd2hvbGUgc3ViIHVzYWdlIGR1ZSB0byB0aGlzLg0KPiANCj4gICAgT3V0bG9vayBzZXJ2
ZXJzIFtETyBUSElTXS4gIEdpdmluZyB0aGlzIG9wdGlvbiByZWFkcyB0aGUNCj4gICAgbWVzc2Fn
ZS1pZCBhc3NpZ25lZCBieSB0aGUgT3V0bG9vayBzZXJ2ZXIgYW5kIHVzZSBpdCBhcyB0aGUNCj4g
ICAgSW4tUmVwbHktVG8gbWVzc2FnZSBJRCBmb3Igc3Vic2VxdWVudCBtZXNzYWdlcy4gIFdpdGhv
dXQgdGhlDQo+ICAgIG9wdGlvbiwgY29ubmVjdGlvbnMgdG8gb25seSAuLi4gYW5kIC4uLiBhdXRv
bWF0aWNhbGx5IGdldHMNCj4gICAgdGhpcyB0d2Vhay4gIFBhc3MgYC0tbm8tb3V0bG9vay1tZXNz
YWdlLWlkLWZpeGAgdG8gZGlzYWJsZQ0KPiAgICB0aGUgZml4IGV2ZW4gZm9yIHRoZXNlIGhvc3Rz
Lg0KPiANCj4gYW5kIG1ha2UgdGhlIGltcGxlbWVudGF0aW9uIGJlaGF2ZSB0aGF0IHdheS4NCj4g
DQo+IE5vdGUgdGhhdCB0aGlzIGlzIGEgY29tbWFuZCBsaW5lIG9wdGlvbiB0aGF0IGlzIHNwZWNp
ZmljIHRvDQo+IGdpdC1zZW5kLWVtYWlsLCBzbyBJIG9taXR0ZWQgInNtdHAiIGZyb20gdGhlIG5h
bWUgYW5kIGluc3RlYWQNCj4gcmVwbGFjZWQgJ2lkJyB3aXRoICdtZXNzYWdlLWlkJyB0byBtYWtl
IGl0IG1vcmUgZXhwbGljaXQgd2hhdA0KPiBnZXRzIG11bmdlZC4NCj4gDQo+IEJ1dCBJIGRvIG5v
dCBjYXJlIHRvbyBkZWVwbHkgZWl0aGVyIHdheS4gIExldCBtZSBxdWV1ZSB0aGUgcGF0Y2gNCj4g
YXMtaXMgZm9yIG5vdy4NCj4gDQo+IFRoYW5rcy4NCg==
