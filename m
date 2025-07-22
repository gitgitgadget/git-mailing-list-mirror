Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1473522338
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202111; cv=fail; b=jeVgORJtKyela1KrqflPlnCMrNSDzMlnMjTi5bv2GCLPWI3dlBt5Uez9Ln/aXiMRYk5dq4NTxYe1cxNzR6LqrQgBHtOkfqfA1zFLPs0LsP5zzGw/nihWz5l+XWLQE3SY8TEdkq+t37kqQLToDdviDNIJkMlR936SwAB/wd5rtoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202111; c=relaxed/simple;
	bh=Y7RROJTD6UScMhACVcuMOT/IfvJLVGpPGt8R7IuVeyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q6qKH5CDkgwtKgKQ8svbJwMhq730l2z5BcOEFiNuPxsw+vOvdB7i/BsPHvbQMuRzU9G3viNdSfyUbi8rJoxBdcV5fbAI0YPin3+b/GC6o1gpHXKFw1oPb1+iD2GV4IXH88w3i5uIs2KPv9MgFQ0vMMAY4z6+45zUrl+y98vXgNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=dJNbdgWm; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="dJNbdgWm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyORgDWq9t7WYMMTCXtsTwVnnrkXZ8h7wdmOWKaoR8NvxZ4Wkuyu9TOVJWT4YzkLKgjekM1gy/fWCSUFtj6AuCpM6lJKElTfczhQAfUUdZsi5XHX6FYZuNc67N4HxM2RSeaEhI7SVng3590QUNsgbrG3Q7VAIZ2RaoIQG6zQpkzCqpzeJ49YQdmt3rLJaDCPqfnfe7e3a65Iigz6mTLW5WOOVuhGr8vQez6xhDznZUxuPAxdULplp3QEvSKACU+cVVI8ooI0rn+L0Sc4m3/qQhVYqB0h0+7aTDMdJYcSaTmxCsDm1iAHopkcokxn2vp/XoShYgT273WzsuhKliLqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y7RROJTD6UScMhACVcuMOT/IfvJLVGpPGt8R7IuVeyk=;
 b=ETeT3OfOkPa3XoYPy8IzXj9Fx94I5rB0mhI7wr1E15nyrqJs4/L/EW8GotaHVdcTnIReG47qpznAsp1HrgWTwURApUKTOBu/HLkcKD/ZKqCRyGvGHgdLcrk4/SqppJDKrs0Qd09KpGtFOlmUOgmQXHrgK6GCxbKLMLzVumkIY/iyOmBBBxFRXQZFIgpzSuXja+zNIFvMkOsnhtd0UwvtZJHx4mmfEBXwn+chpt/8AXsxOX/avmflftHxXSW7FRVrp4tLiEoQ453YPgR+A2orL4TUfLFVPTojPpXXyYAGnfn5NLDG390bRgXGy+XrzLYrUf1PHJFbsmHv0bSBKJuMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y7RROJTD6UScMhACVcuMOT/IfvJLVGpPGt8R7IuVeyk=;
 b=dJNbdgWmMqzmGPyh6RlfxYV8lbRX62tHHSvldeCMsbY2TtviHLpWQod/5HNH0/AZ+Dypz18mzrweWg1yv84uF5Q0yWx3mvvvEL0QsTiQ87v9APKbqALhvE0N+8dYsSv+DBDA3ntPK7gYbh35L8uIVvghzqCBlgvYt1/6xFxgvKSKe4lkOicOUMRvnAd9cUmH7dOhfHnL8Tz9we9CtWbS0IcFSFosU+lwE32beFbN0JbDVmf2syobMrBgvSN5P4FWDUstYHTaYh2HfpVAq634rI85b6u9vDNGFnVfxk9rP3Hi8AiaOHk3mq9XvIihw4P+4mUGqAeLj/YOBrb/pXPbrA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 16:35:05 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:35:05 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] docs: explain how to use `git imap-send --list` command
 to get a list of available folders
Thread-Topic: [PATCH] docs: explain how to use `git imap-send --list` command
 to get a list of available folders
Thread-Index: AQHb+v3Wa5SxIaVoCkKYr0nlsf4E7rQ+SdVUgAANSYA=
Date: Tue, 22 Jul 2025 16:35:05 +0000
Message-ID: <06DB740D-4A94-4588-8666-DEF29C46538C@live.com>
References: <20250722114246.20422-1-gargaditya08@live.com>
 <xmqqfreotegx.fsf@gitster.g>
In-Reply-To: <xmqqfreotegx.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: 2caca39d-2b31-4081-47e8-08ddc93db6df
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVVnd2ZEcGRzQnFyNHZDYUtwL2F3YTBkQW5rUFM4czRSdURFTUUwTUhLSHR1?=
 =?utf-8?B?ZEZFZXBsdXJWR0pBelBjQ0RSZnhqWEdpTGUvVkp6S1QySWVtaXJaVlJtV3dJ?=
 =?utf-8?B?MDdWNS9UU2h4KzBiYXQ1eCtXQmNCU283K053ZGwyejBBb1MybnBya2JZQk51?=
 =?utf-8?B?OWRvcTljMUpsR2RRakdqSFFaMGVWektoVGZFeGZ2ZjRmR2ZvZ2hnelllT0ht?=
 =?utf-8?B?RlhMMzlxSStac3ZZL1NmcGY0K2NWTzJvWCt5Tzk0NVRaenNPV2l1MERqVWlR?=
 =?utf-8?B?ekRFZ0FPZmRaNm5ZeUozcmdWenFLVjdrMmJ2TkhSK01iNEpNbngwVDhyOVZw?=
 =?utf-8?B?Ulp6QU15WHZ0SkpMQ09tU214VzBQYU8rTVpqaDdtR0hQaGNTb09XS285eXhT?=
 =?utf-8?B?TFJZRGxzTVdxL2ZjR0hZazNhMnp0SVZCY0gvWjJlVE1PMmdOaG05Q25ES1Jo?=
 =?utf-8?B?bGdLcGtveUNITzFjMDh4YTVDYm5tZDBEODJwWkNqNGRpQWlETTMrRFFyM0NB?=
 =?utf-8?B?VU51Vm4wMmlqd1oyZlNTczd2WWpyV2J5SGRrOE5zQ1d3Und2bXpBUXBzMUZI?=
 =?utf-8?B?bEVnelVURWdkeG05T0lvN2NlU2RJNWhYOG1mQkNQbTJGdllFRncySmRTZ2tP?=
 =?utf-8?B?YnNVYjhaZVFBS0xVNlhjeUI4YjFxSUdzcThOSmplVlhDTkJHeHVYcHNDbW5C?=
 =?utf-8?B?Ynk0cUtvempJb3EzejZVSk9oTHdWVlIxZmRoUGFxdm84NUpocmZwWEMxN3RF?=
 =?utf-8?B?VjB1aExNK3RKa2kva0NnYjN6YnJZR3NqcXNSelhRQ0N5dk5GdXBMdGxIMGJl?=
 =?utf-8?B?eCtERFBOWlRxVnFaeHViZ2puUlZZT0QzSzBoWWpEa25tcXJua1dtTE5LNFBZ?=
 =?utf-8?B?NlkvNTduYWN0NzRiVlpuRE12YjFuMHFBUzNTUjd5cUpnb2pwL21CalhPdmxh?=
 =?utf-8?B?UjRSY0txWXRBQkNYL2xoa0JqVy9FcytXVWxjNHErb0hJWG5qSmx2bU9ncUQ4?=
 =?utf-8?B?M2pYb2grT3l2a2VDK1JQYTZCTUVrcDdEeU1wNDloajdZdkx6c29WWFdOZUhE?=
 =?utf-8?B?TVJyVWFDcHNXWndIbWxSK2Y3REpXRnI1NkVVTkxJamxtbVV2bitSeXI1YlhH?=
 =?utf-8?B?S0VFWndqOU5ZZ2wzQ1kxNnJpNk1IM013KzFtTVFMZm45ajFtcG8xbXp2YTMw?=
 =?utf-8?B?N2tjSFFaUkNqQzhrYTJlUjJCdk9QYU4vUFZ4eUs0aHRhck91WWlORkd2OHRZ?=
 =?utf-8?B?NklwL0hkbVFZTDA0U1lsdzVPc3VUT0tOdmtVVDM0UWNGSWxYZ211VGJQTktq?=
 =?utf-8?B?Zmo4NGxlcWlEM1hsTmxpQ0hhVVdLdWt4WENXN2pwcjZtUnBmWjdwQXhXc0Zh?=
 =?utf-8?B?ZllFMkFnMS9FcVE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0hWci9EVHA4eVIrTFdjb0RJYUQybnlNdmI5RXkvNnFubFh3WCtUZ1I0UG9R?=
 =?utf-8?B?SjIrWUdMSnZSWndTNWF4emZ3a3N4WTdSdEJjemZ0MDJBbmJ6SVd1dlZodG5F?=
 =?utf-8?B?LzBsd0lIWVVVUXNoMytxRUhVSHZYN2RYeUdqL0lYRldTekRHUVBmbThoYzNq?=
 =?utf-8?B?bVh3bm5VaUlOOFhTbldaMEt5M0ErRmwvSUhQeEdicUdZdHZpNmwwOUZ5Nm95?=
 =?utf-8?B?VkJoUk91cEY5blNSMzlZNitxRkpRZFhDQng1VForYzg3NllvKzNBYmZseEVh?=
 =?utf-8?B?aGtwQVllUThiYzVhc2pGREhacitNYVRaeS9RcTlpQmp1ZC85ekdhMFpTQVZT?=
 =?utf-8?B?R0Y3cy9rSGtmdHhTWVl4a3pIV29nbGN5TndKSUcxeWQydGh1Z0p2WHlTUXNE?=
 =?utf-8?B?ZHlLMFBuSldxUVlRK1o5S09GU2I2N3hOOTZOaE9GVHlHdytYbHQ3TmRrWStB?=
 =?utf-8?B?TkNJT1ZLV1loR3Vic0EwWXgyT0NjMHA5YWNDOWxlWElyd0Z1RzNRNDViUVJ2?=
 =?utf-8?B?WC9oazJweFNUMDVkcDIvY3U5SFAvVldwSzQ4eFFVVjBQUHVCL21ReUsremVv?=
 =?utf-8?B?QkQ5SERVTkVmOTBLSytyY1ZnRFYzWllHaXZnMldSQmQwN013dDAwZnNha2xU?=
 =?utf-8?B?S0l1WVlwWXBHL1hMNUR0MEx2V3g0ajZ0dFNob0pVOWNtZ2g1K3VhU3BuNUNQ?=
 =?utf-8?B?eVh0WXA1WTlRUVNzM1phR0t6QXhhbmpNcHI0SGdzbFdoTElCQjJVRUdwWVVH?=
 =?utf-8?B?NlhUMGlvdXBvbnVzYWJTVElQT0NRbjNnK2RTRHpxaWpXeEhhZExBNjBOUFVj?=
 =?utf-8?B?TzVyaTlIV0xUa2JFZ2JCelRDVkttM1NRZTA2N2MyVVpiOEVuNkppL0ZLMDZ0?=
 =?utf-8?B?aWxsM2tTa2htWHFZRDVncU1ELzFuUHBEanpzTit2c2dlaVNRTGF5Z2lQS1M3?=
 =?utf-8?B?ZTVmUmM0SkZwMFYyUmhZTTNFeEFtKzZ1YU13UERrTjh6QjdCbnU5cER3RjRs?=
 =?utf-8?B?NWthd0I1cjlmbFRmVks3YVljam9WMkxob3Ftb1ptWGtjODJlVTZHSnM3aVFo?=
 =?utf-8?B?Q2V0cGtlZkRndzF1VUsrY2JHb3lJZm9SSlNKTlJEZmIvbUpFSld0RXNRbFFG?=
 =?utf-8?B?MG1yK1RpZUp5SW5nRFB3UXhDWGc1d2VvejRJQ0lyODRadEQxTXB1cVVEL1dP?=
 =?utf-8?B?QVVxMEU2UTQwM3FaSWRSZ2FOMnY3ckZYMXNPenF2VUpBVitQMUZNZVlwRDdX?=
 =?utf-8?B?M3Npc1lsNXZQWVlHRGhKaDdiSzlqL0tyZUJ1bVBsYkFRZmYrbUpaVE12V01T?=
 =?utf-8?B?cEVudEtRT3JUSUNsZmpOVUd2MVphUjg3TEhzci9PL1dMNnpnMDIzejkzaUMr?=
 =?utf-8?B?SXRrQnFQT3I3OVloQzBYTjJKQVRzTkxqNTF5NGFCckRDQm5GZTZDLzRaTVFj?=
 =?utf-8?B?V09qc1Yva2xPNXRjSFFIT1pVY0VrYXpsdUhINzArV0JvQ1RKNWxhTEZoeGlK?=
 =?utf-8?B?bUF2c2FBSkFOaGlzVmlhaHdIYlJZa0FnVldKeDdzSUJ4akNXUFpKTkJNZHMx?=
 =?utf-8?B?b2ZkZ3RHdWxXbmxVUmlFcituSGw2REtBZ1FSOUdrOHkzTWRQamF1Nm9MU21C?=
 =?utf-8?B?NlFYWnhMczgwc004SHo5a3VNYWVZVVN0azlRY29HRlhySWlmbWxac21WbGty?=
 =?utf-8?B?RHJTUUM0T01vWUQ4OFpXSVFIL2FxWHZSS1ZEcVhObkswZGlxUmJZZzZ3THhu?=
 =?utf-8?Q?YHL81nz21XBordEiPggxhoutcaEYd85Kj/fxfuo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B40429A2ACA2479C666C9DC0E12440@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-8769-5-msonline-outlook-acae4.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caca39d-2b31-4081-47e8-08ddc93db6df
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 16:35:05.4599
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

DQoNCj4gT24gMjIgSnVsIDIwMjUsIGF0IDk6MTfigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2
ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBUaGUgb3V0cHV0IGBnaXQgaW1hcC1zZW5kIC0tbGlzdGAg
Y29tbWFuZCBjYW4gYmUgYSBiaXQgY29uZnVzaW5nIGZvciBuZXcNCj4+IHVzZXJzIHNpbmNlIHRo
ZSBJTUFQIExJU1QgY29tbWFuZCBvdXRwdXQgaXMgdmVyeSB2ZXJib3NlLiBIZWxwIHN1Y2ggdXNl
cnMNCj4+IHRvIGFuYWx5c2UgdGhlIHNhbWUgYnkgdXNpbmcgYW4gZXhhbXBsZSBvdXRwdXQuDQo+
IA0KPiBUaGUgZG9jdW1lbnRhdGlvbiBhZGRlZCBieSAwNjdhOTFiMCAoaW1hcC1zZW5kOiBhZGQg
YWJpbGl0eSB0byBsaXN0DQo+IHRoZSBhdmFpbGFibGUgZm9sZGVycywgMjAyNS0wNi0yMCkgaXMg
b3Zlcmx5IGluc3VmZmljaWVudCwgc28gbGV0J3MNCj4gcXVldWUgdGhpcyB1cGRhdGUgb24gdG9w
IG9mIGl0Lg0KPiANCj4gQnV0IEkgYW0gbm90IHN1cmUgaWYgInZlcnkgdmVyYm9zZSIgaXMgYSBj
YXVzZSBmb3Igd29ycnkuICBJIHdvdWxkDQo+IGFncmVlIGlmIHRoZSBhcmd1bWVudCB3ZXJlIHRo
YXQgaXQgaXMgbm90IHZlcnkgZnJpZW5kbHkgdG8gZW5kLXVzZXJzDQo+IHRvIHRocm93IHJhdyBJ
TUFQIHByb3RvY29sIG1lc3NhZ2VzIGF0IHRoZW0uICBCdXQgaXQgaXMgd2hhdCBuZWVkcw0KPiB0
byBiZSBmaXhlZCBpbiB0aGUgaW1wbGVtZW50YXRpb24sIG5vdCBwYXBlcmVkIG92ZXIgd2l0aA0K
PiBkb2N1bWVudGF0aW9uLg0KDQpJdOKAmXMgbm90IHJlYWxseSBlYXN5IHRvIG1ha2UgaXQgbW9y
ZSB1c2VyIGZyaWVuZGx5LiBSZWdleCB3aXRoIEMgaXMgYSBQSVRBIGZvciBtZSwgYW5kIGRpZmZl
cmVudCBlbWFpbCBzZXJ2ZXJzIG1pZ2h0IGhhdmUgc2xpZ2h0bHkgZGlmZmVyZW50IHdheXMgdG8g
ZXhwcmVzcyB0aGUgc2FtZSBvdXRwdXQuIEFsc28sIHRoaXMgbXVjaCB2ZXJib3NpdHkgZ2l2ZXMg
bmVjZXNzYXJ5IGRldGFpbHMgdG8gbG9jYXRlIHN1YmZvbGRlcnMsIHRhZ3MgZXRjLg0KDQo=
