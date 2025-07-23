Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49283C2E0
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293004; cv=fail; b=BVqhqfFBmdXpV0zrITPW5h/OUIierJj0QOdGtEHPiQV+rNswYdtHx63E9WU6JJZYgSvPqv5ajdU1OuO6z28uxSYRZR9fg6tNrLQEi5ro6H2nfsNkIGhVm+lbTZZTFlyh1E4lg+L/wNMrGUfESQOzSRls0VPuAYpbZCXO/an84pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293004; c=relaxed/simple;
	bh=eONyNLjZGnlwGKsSsiNSayXDcalhfZTf8zsFCzZ3ty4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mFmrzVVmHuohBrpVhlpcDNn++7P1loBnFZd8CPp1tnfsv2vQTUTwMS1Ai9v63VNpzfv+K19ks7AoN6I6fp4atJIKjc7L3CqTBEHtEjOV8rIJdEAEgeeHuohNdhoIhUJSwaYhnxdV+3xJ3D25pzpAiNpTdee/foqkBOQB93uEtFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dHJUxYkk; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dHJUxYkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXu5+bxvGdIwVkz/sP9qt9/r1ZW+4m4H4UeZe57gcnySrjCEy2+jYyZ8rXoAQLpODJMJEBYaLm5lokgDpTdvJPVKluBchnDBYPIdxUoeeFdS4zTLode8U2hZV0kQEvSwwO1YfJJuUeOkp8/mZT5zkZuFpL6vAk3+P9TYS4jEf0RVdtoAsywU/c6toTRogxbjicUBzd1U7rD5lFp4TXf7UPy7UqwirV5Buw4hqUHM87LCAfTiM1YPRwWuPGpBh/9PYHtVauDvZHQ6gZUpa+a12yVJ6JcAQn5u8BBwsGiqPhqIR9OMm9C+Hzlt67lu+hviAC5YHDbrltobYAEjSoMuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eONyNLjZGnlwGKsSsiNSayXDcalhfZTf8zsFCzZ3ty4=;
 b=kAR1FDmJM5pztmMcYoTKykMSkXLUytlRQK+OErkDqShT6mhrxPwGGtunMsTS/EDXlK55S/XnnyCuqVVwuvSGg6Lv6QwRcA9eZwt020YMdDkkz+mMKPwFv67TE4fXK6QTOWGMI5LKn4BTExyXoFVCwN3gF7zApVoW+0/NRwkamwbgG7lB6LHfNrqg5bYPdKQl0cvkvWJ7VQBp1OiplKHl5jofrpHYjPXBjNSl9fawkawkPtTtu3bWMMXupV+Qo95hrAY3ema+KgquyZBm7IHFoTCc+BMJmb1t4MxFJyfx8yTl53C/w9C+D1MN5KEUEAT06Rik89eVZqHj3Lm2ajMI9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eONyNLjZGnlwGKsSsiNSayXDcalhfZTf8zsFCzZ3ty4=;
 b=dHJUxYkkIPEEJft7r6ns34bI1izcAqRhauUIEJkmOYY/fawGb8qKbENR3Z6fJFDA+0EqYmpxlJ2olSjLeTVU+9EXaWNb1IQYkqmzJQV3oRSc+MF/neuHhm0HlSE6R4Mb4hiWTROzDDjp2pj6q1ND5eV1yQe6OBcvhGTX/Mo2ui6t5sKi81Sk28PwSgWvBvpzmV3cqtTV34Bm2KLqy5mVsiXz1J7zxAfbzThP+YWaKESu2lffIYcKhhhjD6Fp5KOYk7LJ2dS+dCamflYlPSPp0D6CJryn9+uYZKAmS8Ee5CgxAPjoPWP0bQ3iPpd5a6zURp3+G+QVks39IeSLCRDh8g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPF0177A60C3.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::84) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Wed, 23 Jul
 2025 17:49:57 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:49:56 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, brian
 m carlson <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] imap-send: add option to mark sent messages as read or
 unread
Thread-Topic: [PATCH] imap-send: add option to mark sent messages as read or
 unread
Thread-Index: AQHb++jOmQ0vxoX9v0OfgtBUJTYt4LQ/+4kDgAABC8o=
Date: Wed, 23 Jul 2025 17:49:56 +0000
Message-ID:
 <PN3PR01MB9597A554CAC46F584AFCEA36B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN0PR01MB95888028E0BD985DA07B9C60B85FA@PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq7bzyol5w.fsf@gitster.g>
In-Reply-To: <xmqq7bzyol5w.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PPF0177A60C3:EE_
x-ms-office365-filtering-correlation-id: 1486ec02-830f-4e5f-f9c5-08ddca11562f
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8062599012|8060799015|19110799012|6072599003|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?VlJhOTdpTUVIVVcybDhOdnpNd1ZoMlVFcytKdjdHdjE4YXl5aXMrRndlNkZX?=
 =?utf-8?B?bk00ci9FUzY3aGQ1N0gvdm9SaU95Skp1TkJmRXRPWXJKT2RIT1duYlN4eXN5?=
 =?utf-8?B?R1JwU0N1cHh1Z1pYR3JNaExnNllHcUxINjVuZDFZZzFPNkxRUzNqV0VqN21r?=
 =?utf-8?B?YmlWVFNoSzlBR2l4NWRvODRaVVE2UnI1WHJwK2dTSTVBUFY0RFIraGt4MkZJ?=
 =?utf-8?B?TFFEZE1nZEFCZGNHbEdlc0lBekN4dWNiSFZ5ek80b1FoV0xVUDczZnhIdUdH?=
 =?utf-8?B?d1dEc3ZFVTcvaVRJckZJR3JFakw0V2QxdXIya1I5bVMzSmduQTFXU3ZZSUpI?=
 =?utf-8?B?V1M4NTF2c0s2RWd2dXZZL0FucGJzZjBORTc5aUZJQktxOFhHeVpySmJKbEtR?=
 =?utf-8?B?a0hnMVpBcTVLc0piRGV1Mm5JMXk4R0UzYk96RGpJQ0RxR09IZkVacU5CeXEw?=
 =?utf-8?B?ZXdCWXJWOXJiSFMwdFg4aVJxNDYxQ1NnTndkcnNncTh0Mjg2K2xMeC9aaGRH?=
 =?utf-8?B?R3hkSTh4ejl2SFY2c05GZDNvNEdTakFjbmpsejJMMkdyRzk5d0t4K20ybE9p?=
 =?utf-8?B?c09QVjZMdmY1Z2RVdWgrc3RZOFpHbldzZXZMNDhLbnQxa2ZRWFd0SlFSN1Ry?=
 =?utf-8?B?WXRjcVBBMC9EVk5XRzJrNklBMGY3eGlJMFV3OTMzS09EYVBzSm9lUVpWb004?=
 =?utf-8?B?a3d1SWJsWWVuTVJhUTdPZm5IT085M0xBblB2Q01pMGNMVk81NEJ1ZW5hU21E?=
 =?utf-8?B?T05OOStTbHhrbTV0bG5iMzJEY3pXcDljeDlGbW5zNWlTMUFWYWk0R3RxanRO?=
 =?utf-8?B?ajVUYVpJZm5yejEwbmxQUnFPUldmdlJhdDVTSFUzc21lSEs4S3M1YlcwZ0hw?=
 =?utf-8?B?L3FvaFZEWGJUNzFoaG5hSHo2UlNMNEkzR0tEcytwUHRnTVpBMW95Q09NYUcw?=
 =?utf-8?B?VWdvZWNzY1lKRWVJMVI3Zk1FcjJ4SVBKdHVRellNK3c3MnNydERVUkZmb21O?=
 =?utf-8?B?K05lQ0tvaTE0QzFDaUlybHpPMjU3WmFPVHJ4enZSaWQ4MUw3MktjbkZvQWRP?=
 =?utf-8?B?U1Zld2E2WktuUVBQMFR6d0NoRnZXMVpNZ20raGFaNEZiZlova0orZUJrSS9o?=
 =?utf-8?B?YkJQQ0t3RjBYYWsraTZKc0lxZ29SSHJxQlUzdVBsS1hqc041dGNyZklZdU1w?=
 =?utf-8?B?K2FhaE8vV1U4S0plMHBwQ0pqUGsyc0h5UkxDQTNqVXllSkRCankrN2xTemZy?=
 =?utf-8?B?cVp3NHJ4WWFuZXd6dGRrd1hoblY2aDhHc0NrOGE3cmE1U1RNdFBOWnN4Nzhu?=
 =?utf-8?B?WFhXZkorditRVDJQRXpaM3FucVVZMWNCNTNiNHdjek12Qm1meHM3MUw5bWcy?=
 =?utf-8?B?R2lsZHluYkI4aFZaZHNFcytCdHU1Q3VhY2cyTXhIdUdnaVltNnBzZXJnSWJl?=
 =?utf-8?B?M1kxblFvWnZqdnIyMGtQdVl4eHBUdlV5dko2VjJqMi9xRDd6UDFGWFliS2Fv?=
 =?utf-8?B?K2RnREgxcEIxTllsNzdFQmhFM3RKNHN6UFRpZHNla1FKd0NJcWtNZEE2dUp1?=
 =?utf-8?B?UjNoQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFpQZ1BCTjkzU1ZLR3hKeWZSR25NZ3d2WE1XTGZydm4yUzJ2N3hMZVlyY0FE?=
 =?utf-8?B?ZkU5S0c1UTdjMXlLZmtXRWVnSUdhS0tqRjlFK2s2WnMzRUpyOC9zc2R1eFgr?=
 =?utf-8?B?R2ZkVXhZL3NmQVZiU1dnYUVscUVXdlVMTC9xZUZPUUZoS2tzcFJCT1RaSUdK?=
 =?utf-8?B?djE3N1oyK09tUEJsZEFUVXE5VDVxMEl6aWdySmR2KytYdFJqOHNmRUpKU0Vs?=
 =?utf-8?B?T0FTMmpxQXhuUlBlTndNWHE1VHhsTC9ZMmtyckVGakJHdnZpREVocHRxbnox?=
 =?utf-8?B?VDFYeGhDa1lRT1RPaXRrRlp4Y0Zrb0lDVCtobEhEMS9RNmNpQlhtRWIvVTdV?=
 =?utf-8?B?N0RSVmVNV3grb3laRW4yQTFwMU0wZXdXQStLVzR2SFNtbHgzWjRmclhiS2lF?=
 =?utf-8?B?QUFVcUlhTkJQOHY4V25LVGpvOVRQUG9XSGVadERmbTZFZmlMQ293cjNRU0ZM?=
 =?utf-8?B?bGk0OWFEbEdLemlwcHh6YUF2TDJNcGxCR2ZyOGkrTGFXYTF2ZmFkL2lETVpO?=
 =?utf-8?B?QkJVZ3VKbk9rSmlvNGIxSjNPN1FtNFBIdjFIRTBCUXNkVVB0TytrWjBMRFZE?=
 =?utf-8?B?YjdFelZtY3liTVArRWh4TkV1RnZybEI0OVNVZkFVSXY4N0VTZVJoSjdFaVJ5?=
 =?utf-8?B?aVYxVkRUb1NlZ1pROXNzMVdIb01FMzVndnhZb0ZlWHdDTjRPYzVaVjV0RCtr?=
 =?utf-8?B?VVZEdU16U0NCY0UvSTFpZ3RTMzFnRmtRMHNadEdDa3djSXVEdU1HcU5BaEJx?=
 =?utf-8?B?SlFxeDM2TlZIWGMrT29MbHVvbDJDeFJRQ2NrNmIzaDZkSTJTcEZ0SEJnTVp6?=
 =?utf-8?B?MTVJMFAxN1B2dXFWVDUwQUY1SzdyamMrcEVhbEZtZWRIVjdUQ0dBWVBnVkEx?=
 =?utf-8?B?M21ZT3UrS1BXMjNTa0tNSjByN21FVncySmxWY3FYa25nc3ZLUmRtc2toeFp0?=
 =?utf-8?B?R3FSSC9mSy9ORmxjMDBLblo0Wnd5cEJockRocDBzYS9zWDBOWGtUdll6VUwv?=
 =?utf-8?B?S1lUK25WNEljVFZaQXFDRTlHUHU2bzFGUFhyWU5oRkcwcjlCUFQ0VFg0WWta?=
 =?utf-8?B?V1hLSDNwTGdBSng2empBNWR1YVdKZ3ZWM1BxWTVtd3lZczBOMGtvMWdiQldC?=
 =?utf-8?B?a2R5M3JFR2R3enBOcHgrUUxLcjdsWTlzOUJZZkVCYWZyVTdoWG1qTlI5ZFY0?=
 =?utf-8?B?czFPekhpb21GcmdjbkJNb2R0SUg4RkNOOWJRYkVBU2JXMnRWSUdrQ0U3aU9i?=
 =?utf-8?B?SExyb3ViTGtVK3ZKZzB1NzkxV1NpV3VacU9QRUN0bmh2MGFETUd1aWhmZkE4?=
 =?utf-8?B?NjdUR2NXQ0p4VzQ5WUNYVEtMOHJMZnBlWUVMWlVHeE56eHF5S3M3TWlOcDBK?=
 =?utf-8?B?d1dOZFdSUzhGVVFPM1R4bldnRlZXMEJtV0pJc280aTlBenJpUVJoQ01lZGpL?=
 =?utf-8?B?VU9WNktYa21jQVo0ZlFvQlBmT3JsVVQzYktrWGZOWWdVUkd4SXFUcHhoK0Rm?=
 =?utf-8?B?cnh1QmRGS0ZqeDUwbTNzenFnaFRKOVJnRjlTeUs0R1EwUHdoTG5qTklDTG4w?=
 =?utf-8?B?R1FDd3hnc1FLOVNYL3N0ZnJrbDdrYlpEQlR2RVB3cjNNZlBzczdVZFQ4Z2Nu?=
 =?utf-8?B?ZEw3Z1gxdE1WQnlYZzd5ZXN1Rms5UXVWS1dzRkwvVE1ycHZ1bll2S2hLQks1?=
 =?utf-8?B?d2o3QkZjY2hRcUVSNGRJSkl4eVgzcThNajZpOGdrVXhuQXdwQzMwdmpXTGdF?=
 =?utf-8?Q?4z66b6EYtAu+gAPKt8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8880-26-msonline-outlook-ce67c.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1486ec02-830f-4e5f-f9c5-08ddca11562f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 17:49:56.5208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPF0177A60C3

DQoNCj4gT24gMjMgSnVsIDIwMjUsIGF0IDExOjE24oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gVGhlIEdpdEh1YiBhY3Rpb25zIHdvcmtmbG93cyBh
cmUgZmFpbGluZyBiZWNhdXNlIENVUkxPUFRfVVBMT0FEX0ZMQUdTIHdlcmUgaW50cm9kdWNlZCBp
biB2OC4xMy4wIG9mIGxpYmN1cmwsIHdoaWNoIGlzIGp1c3QgMyBtb250aHMgb2xkLCBhbmQgdGhl
IENJIGhhcyBhbiBvbGRlciB2ZXJzaW9uLg0KPj4gDQo+PiBOb3Qgc3VyZSBpZiB2ZXJzaW9uIGNo
ZWNrcyBhcmUgbmVlZGVkIGhlcmUgb3Igbm90Lg0KPiANCj4gSG9sZCBvbnRvIHRoZSBwYXRjaCwg
d2l0aG91dCBzZW5kaW5nIGl0IHRvIG1lIG9yIHRvIHRoZSBsaXN0LCB1bnRpbA0KPiB3ZSByYWlz
ZSB0aGUgcmVxdWlyZW1lbnQgZm9yIGxpYmNVUkwgYWdhaW4gcGVyaGFwcyBpbiBhIGZldyB5ZWFy
cywNCj4gYXQgd2hpY2ggdGltZSB3ZSBtYXkgY29uc2lkZXIgYWRwb3RpbmcgdGhpcyBmZWF0dXJl
Lg0KPiANCj4gSSBkbyBub3QgdGhpbmsgd2Ugd2FudCBtb3JlIGNvbmRpdGlvbmFsIGNvbXBpbGF0
aW9uLg0KDQpPaw==
