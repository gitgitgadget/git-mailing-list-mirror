Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011035.outbound.protection.outlook.com [52.103.67.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D37E571
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749496826; cv=fail; b=ZW7Sl5eJpIhX0OWTkLOtk7Rv26P3+iytAqP58r38ZXHdtsPokMF5Qr82RYXxg7d8bF8iZx89hYKjhwU7klX/xVBadFv022OKP4wUpxJPMUc7+r37cszr0oO3qRk4eA8nL6SYBcBrP6/eXI9vPgiTRBxeyAWAudp2THCaGFMw7ZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749496826; c=relaxed/simple;
	bh=A8myn5I/1AbevLORTgA0uO9w/gJbqstXDmIKr/cjitk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cahUhKjhMeiluWCpfj00krnTa4hCC42w932nhcjY5nI8wdmrD7rrw/vvMFgdwrZaT58A0gsvPJQYVWVFe7Vwu3GE0itOTDx67F8nRKWy1TmQrP4QtBhAn7vfjEOiD6dHzqL6kxvrH5Rvzdmwvz9X/FAfhYElzB15a3g2ibL6TyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CoWqcUwr; arc=fail smtp.client-ip=52.103.67.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CoWqcUwr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFzkAisw++Y488MkQKiCmLL0MXD6GwW5JR7OPmQvfck2Nh8iaAyAi/UZyDNhdoM9PwLk7Gk6flq70iqNV7iaUOzdDB4diwk/WCI5Q7qY4dqQI/iwwi+h33WAuZA7md1wPNQfq4wYuzSAUHiNnhByHl2eWk0jnTjc+4Yr2Bb06RR+/rWh6QzJSo628IbN0X7vCOReWFn5UjNszaTNpy/qM7vlJX3U4IFB063gBNKGmcTzG9soCTHNn2U6R5zWBMJXz/mX5RjJ+fZGHuq33m3CFJ7we3wmhNgdBDoFZ2UDrwaY1WOwmqjk/1/fCSDvRKnD0NmWTRk8tkjd8CyenZE/zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A8myn5I/1AbevLORTgA0uO9w/gJbqstXDmIKr/cjitk=;
 b=RPoGt0YGLoEPRBxFLcyn4aFpjf2EU/B4uub6JSZZx76L5dTik04+fYeW1Cp30cQdOwop7cbAbicjBCt4U3NMCgqWZoT36AHwOcQAKOl2ZBH3q5jKwACFOpPq+V4sDlnZE1qZr1q2djlD0m7ehnYg4pvnTM6/s+kTEaG/qPijLj3rztYe7nmMbs49swEjbCHmnIkQsc09UL4lAJIeG3R2kwJMBs45CgPc1FDxNKQ92vTMAYk8Ff7MUBuO+Wi6okfmjVjjwyKArqRL4ClgT3M1PsBoLkNYRiS4q2xAFUpO3ZB8NElw9zKP+dnWuU667XTuHg5q8LmqxaWkFhHrWU7eLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A8myn5I/1AbevLORTgA0uO9w/gJbqstXDmIKr/cjitk=;
 b=CoWqcUwrURAkruPSRk/x7r5Yr2XNl65A+XypfYk3T+fobbRqyBvzBDBvjqhto9c1es2H/UB15XbV0mTUNxtDJkv5kks+KHpclbJLEOSbQMVOFtIUL1gSfg+8hI5vXIbmx9Xvxnc/QVaAwVA6oaHGlFu4WoK6OdOm2nmjFx4mEdqgAboCXKicANbLThq6b/rdsFnVRKR53uPc8fsL4/ZJ32CK91ehEPZ0JI8wAaoEbaWiVGZhe+ZmKyWhBbsaOVIObazfahQYu4s289qMddT3YQ7vtoVKSbJ6R3SUa+rzOLe53kgJafLBaGbNedUzy9r/jHmo/3e5/VNGxsXAutlgXg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9778.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 19:20:19 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 19:20:19 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 03/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Topic: [PATCH v16 03/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Index: AQHb2Q8lGJP7P+dAY0W7hGyorgrFf7P7M8Q8gAABL9c=
Date: Mon, 9 Jun 2025 19:20:19 +0000
Message-ID:
 <PN3PR01MB959747D02A97954CE46F4F27B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597E68428E7483061E39A63B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqzfegpvyu.fsf@gitster.g>
In-Reply-To: <xmqqzfegpvyu.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN2PR01MB9778:EE_
x-ms-office365-filtering-correlation-id: b1538dfa-5942-4e18-65fd-08dda78aac84
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|7092599006|6072599003|8062599006|461199028|19110799006|15080799009|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?VVB6MjNNNFExM1RselE2ejBJSkRHTFU5M0dyQkVqU2trMFNOQUc3Mk1PM1d6?=
 =?utf-8?B?ODlsU1FmNnhwWmtxZ2JSVCt2Z0QrUWRFM0ZVR0JabU4xMXdndUJiUXkvYnl3?=
 =?utf-8?B?OUxtZGhkS2ZZd0lsZmNGdVg3WGw5SjNBaDcydUpzSEJ2cE90SFR5czNDeXUr?=
 =?utf-8?B?Rjd3bUdSZHBvc3VkUGFnby9WMjh5Tzk0TmJYVkVRMDdqUlVMVU5uU0NPM0Nv?=
 =?utf-8?B?RzBQNWs0WGwrSWpEeEpTcmRvTEJOQi9iUEFEUklyMGRzQVdDTSs4aU1kemg5?=
 =?utf-8?B?YmpjZ296VEI1WFp1b0FuNi9XclNQZkY2cDA4NThkT1laOVRYdndUOEpWR3J3?=
 =?utf-8?B?OFhOM0dPcTNMOUgyb1A0d1VFTlgrVkQvRlNsTnMrSXBaOFdqREVDR1FZYXQ0?=
 =?utf-8?B?OGZWUEh5eWhXV01XT3I2dDMvcEpycjNxRTdGR3lBT3djMGwxYWk3VDYrZUxF?=
 =?utf-8?B?QkRSbHErTXJmb2RRUUZiU3huY0NGRVRiRzBqWFpXTmJORXZpMzB1Q3JBUnl3?=
 =?utf-8?B?NkVoeVcxbDFzcXA5WW8xS3FDLzlwUldhc24wTk14UGtZdVB5U0FSeEVhc1VQ?=
 =?utf-8?B?VzlGYnJWMjIxSmJUTFhaMU1xZzBGYk1GV0o2Wk5rcWNCa0xhTm1PQzF2YWVB?=
 =?utf-8?B?bzJ0eXExRkIzZkhkamJUS3NoODBrelErVmswZE90V044VjBFOWN0bnRNb0t1?=
 =?utf-8?B?NXluQzJFVWtOdEZUUGJFWEVDRTVQeDU5QmQ1OXI0QzN1dTNpazlXWFZCUzc4?=
 =?utf-8?B?cU0vTkM5S0ZPejFja3N1TkxQN0VRcUZaQ2ltUEp3czRrUkc4M0YyamRWempX?=
 =?utf-8?B?bjdLYk4yUnlmZ3IySHRzZ3hOaEZDUFFwNEc1SFIrTEdZNzF4L1pBSXN6TEV5?=
 =?utf-8?B?aCsrUXVFeHcrZitzRlhOMHRLRCtKTXZEd1NEdUhVOWlLU0srN2ZER0twcmhF?=
 =?utf-8?B?TDJUN0x3NUF4T2puc0hzdDNaYjBab0Zhc2tvdy93U2lYbjF0YVVZTHIySmFJ?=
 =?utf-8?B?cUFmZzlWYnlOYU1MUHdaNW50TGZENFNVb3gyenlsY0tzWFk1VjNGVFRiTy9S?=
 =?utf-8?B?OE5OQUE2dDhJS09nVXJ6cXZ0OEFGUHBEL0hqMGhXbVFSaHhWL1liWnA1M1ZQ?=
 =?utf-8?B?eEVUSVRNWE0wR3NsWTBSNU5jTFAvcTNHRDhhQWg2eU5vTk1UZTFtbm1TQjJp?=
 =?utf-8?B?N0JhRk9iZHBwVXlyd21NSXV5RkJZUTVXa2NKdnZZcDlyb3Q2Q1lCemw2cTk5?=
 =?utf-8?B?NmluNHlNU0lGeCtXd0FjQnl1dlFoVlcxTEYvVEZjR2J1MG92MVJwdWZ3RHdN?=
 =?utf-8?B?OU82SE1QeTZoMnZrcUNMVGd0TkFCYm85czZQenNIcTJSWjJTTXhtT0xWdjc5?=
 =?utf-8?B?RzluSWVvSjR3blFjRlIyekMzV0dVbTcyV2JuWWkyTXlWaHdibVNWcFBhSllF?=
 =?utf-8?B?N1Fuc1d0OWlheVZQZU5PYVNDNlArSUZESUJIWTZPL0FDMEJiTEU5N3pSWjll?=
 =?utf-8?B?UmlMQ1Y5b3lycDAySkJJcm1iRTNXaEN0RlpOZ0ZoRDlhR2tjSklvVjNFdW5S?=
 =?utf-8?B?WU1pdz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1d4V1ZQR2tNZmlWQjI3OFl6Wk1SK09aQUJkOE9YcDBLeDF3czJVZFdUQTgx?=
 =?utf-8?B?UTZaOEZ3bE1hWE9lUDI0cVA1U0xJOE9KdllMMTk4NW1IOFpMaCt2SjdDSU5s?=
 =?utf-8?B?S2ZodlY4ZURSc3IzN0U4TURuUXpFZGRYeGx3Q2tEZm95SFRJWnFBMk15dFNW?=
 =?utf-8?B?cVplYS9ZZmZtZjhldmxwWTJhejFuL0s5UkFHV1JzdEVtTStBSTAvOHFxSEpR?=
 =?utf-8?B?ajgyUk5YM0JmNHVqTnJLLzY4VGthZ20yRHl1UEZCeXBIaDcrQitCMUhxUzN6?=
 =?utf-8?B?Y1RNWVNheEFvSHlqWXQrMk13aWxDd3pjMC9zMjYxUmFSaUxNMFpZZVN3QkFJ?=
 =?utf-8?B?YlMrR1JuTnpLc1B2WEMwR21RRjlodk5IS1lDeXVQUWg5MDdPTGRkSkRPRWNs?=
 =?utf-8?B?emxLR21zcS8yUHpyNDhtd3dxK2hLSlV4MG4yZXZHM0ZIbno2a3VZMnF3Ymo2?=
 =?utf-8?B?OGFFa3BHTjUxd1ZEZzVINjFuRXJwem9LR3hrSHBUMVYwbXFOcGpET0ZTSnRI?=
 =?utf-8?B?SzZPdlpLN1NsbFJxb0FBQ2NlcytTK2VyalArcEVxMzZST3ErMWZNTnNhbmhu?=
 =?utf-8?B?N3c2M2RacFpqN3NKQ2lGV2IwUzQ0Q3lERVJkcVIya3NWMVJoQ1h4eW5kRnh5?=
 =?utf-8?B?cDhwRlgrQ3BaNXNBNldqMVI1blczYlNFV3FJYkVGaC9mRVpnTXAvK2tJa3dL?=
 =?utf-8?B?WmpQUGJDNWtxUlZ3WFAwUXgzMDY3dFNaV1NMVlZvQTB2N2d5RTNFbHd4RHJY?=
 =?utf-8?B?VGRXWUVzc0V3SzhUaFd3SUkzKzVtcGFvckUybkhjMDhaRmpVT3VaeUh4QTEv?=
 =?utf-8?B?S29vaUdMbmM2QjJHa2JLRFFsTmRhOXRNUlU3UUZXbVNtRzZKOWtwZjBYcFZz?=
 =?utf-8?B?RDcvQTJvQis4UGRKTEppeC8zMldCN2xPeWlkT1c4V0FNMitmdzduOG4vOXJ6?=
 =?utf-8?B?NE9yUDh6MlZadjJzNkVCUnNGUFBNdU14cGYyU2VXam9vYktBOXhJazUxU2Iv?=
 =?utf-8?B?Unl3K1Z2Uk5iOXBjVTZtM2gvYjJoYU5HTUxOVVpFUzhjaXFVR0lYL083ak5B?=
 =?utf-8?B?c1FHcy9VS1dJMTZ1L3ZBVzFCeTVoRGhYTUJjVEI3b1RWeUhpUTRsbENzMDFL?=
 =?utf-8?B?S1I1ZTdzVC9YS3NDRFByL0UyZk54MnMyRkY2dGhjTm5ZbEdZMzFzWVJoSUxi?=
 =?utf-8?B?N2tqWllNeWVMbmFqK0Fadk11UHFNSVlBOWxFVm4wZkpMckxTVENSVmFycHd2?=
 =?utf-8?B?bUJUODZNNmJMYnllQ05YODNUclcvKzgyakZ5dzNYYmJiNzNrclhBVDlqUVdY?=
 =?utf-8?B?RXJEcVdzQmlJcWJTWlVLTG5qdEpxUExHREVPdmpIUUFkSTNuTVdJV2VFMnVn?=
 =?utf-8?B?Rld0OXBWdnpDUWpRZ1ZtcVpnV1JFbGR1K2ZlY0xvVnR4Z1ROU3ZjZnc1WXhy?=
 =?utf-8?B?Qng5bGFacjdzZG5Fd2FSZTcwZDF0VVdzOVFaQnNPenJNaDhUVHhxdkNLQ3o1?=
 =?utf-8?B?MFRHSE1SalNpTnAwWnUyQjFHMmJmcFhMUWE2dmJDaGFVTXhLaVBzclBXZmx5?=
 =?utf-8?B?ZGdUMDVtVVU2a0pJSFZCZXM3T1gwYzM3cFAwRWVpWHJsQW1RT09YcHhncFdQ?=
 =?utf-8?Q?Lg337GO1Cr76kAfgIJ8MICO6w9grk/UMKbexy4zdwZrg=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b1538dfa-5942-4e18-65fd-08dda78aac84
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 19:20:19.7894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9778

DQoNCj4gT24gMTAgSnVuIDIwMjUsIGF0IDEyOjQ24oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gKyAgICAgICAgICAgICAgICBpZiAodHJ5X2F1dGhf
bWV0aG9kKHNydmMsIGN0eCwgaW1hcCwgIkNSQU0tTUQ1IiwgQVVUSF9DUkFNX01ENSwgYXV0aF9j
cmFtX21kNSkpDQo+PiAgICAgICAgICAgICAgICAgICAgZ290byBiYWlsOw0KPj4gLSAgICAgICAg
ICAgICAgICB9DQo+PiAgICAgICAgICAgIH0gZWxzZSB7DQo+PiAgICAgICAgICAgICAgICBmcHJp
bnRmKHN0ZGVyciwgIlVua25vd24gYXV0aGVudGljYXRpb24gbWV0aG9kOiVzXG4iLCBzcnZjLT5o
b3N0KTsNCj4+ICAgICAgICAgICAgICAgIGdvdG8gYmFpbDsNCj4gDQo+IE91dHNpZGUgdGhlIHRo
ZW1lIG9mIHRoaXMgc3RlcCAocmVhZDogSSBhbSBvbmx5IGxlYXZpbmcgYSBtZW50YWwNCj4gbm90
ZSBhcyBwb3RlbnRpYWwgI2xlZnRvdmVyYml0czsgSSBkbyBub3Qgd2FudCB0byBzZWUgdGhpcyBm
aXhlZCBhcw0KPiBwYXJ0IG9mIHRoaXMgc3RlcCkgYW5kIHByb2JhYmx5IG91dHNpZGUgdGhlIHRo
ZW1lIG9mIHRoaXMgc2VyaWVzLA0KPiBidXQgc3J2Yy0+aG9zdCBpcyBwcm9iYWJseSBjb3B5LWFu
ZC1wYXN0ZS1idWcgZm9yIHNydmMtPmF1dGhfbWV0aG9kDQo+IEkgd291bGQgdGhpbmsuDQoNCkdv
b2QgY2F0Y2guIEkgY2FuIG1ha2UgdGhpcyBtaW5vciBjaGFuZ2UgYSBwYXJ0IG9mIHYxOC4=
