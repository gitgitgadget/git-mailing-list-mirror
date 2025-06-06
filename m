Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010013.outbound.protection.outlook.com [52.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9717FD
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 04:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749184860; cv=fail; b=pSKbPoj5Rmo40IKkpuWIJ8l8uzol8jqsLDJ5psN4+OX41FQ2rVrRox8mslfVjqxT5xzVQRBjeSQ10shf1TEOigA/QxZOfxGB4bZUJuFZbiYc2ZkQ4xkXYxE3D+mQ5O4MzUOzg/9qQUzjrQAusV4QQJtE07TU0IqgUlLaYXpVzYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749184860; c=relaxed/simple;
	bh=2ugdFnT91gyjAmruZVziLL2+JUHHqwH88Xdvayw/piE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oDntlZI7BCwtLtX/mvi/wElqekp4oOad2jcsfKVQT+EKEWikxpC3rTGIOIuEWOTLW92scYzvmS9AmEbi4y5Ftoe74f+CLY9f6vAGyLGpDBj4qV/oq5nelLhfptGQQQzeG0FjB9NDxp+PVcwZi1jytXYpDoBicrXueK/3gM/xtvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=IL4FwGKS; arc=fail smtp.client-ip=52.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="IL4FwGKS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2LBhVET+rCWUm6xrg1Q0vcrk9rOGWGWwobOgKi0L1oMiuAJvzVthpUDRssxk7k1CFiDfOyXhUjzuBNdnZfIHRuq/xNXbEnrYQn3V41S4+gFPkmy/lO9bGF1v93o//SjS+ehFrnPwKqX9ZYSv6ftdJXPeioW2UpSFM4NVDDyKwg5nmoTSh26aZMxz7p7Z3pzAWR/ACET18VJeGUvfnRhwHGqJGX4Icp/F9SStPzGDnGY0yh0hj6dt/G77JWiWuH1hW7sMfZLqgaVoxddbw2ee3iZ76U7ZTwA5L6lxODUxMRWrmcduTiEmLC1o8ikjllCRl9+oxcFVu2V2zkIqPFMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ugdFnT91gyjAmruZVziLL2+JUHHqwH88Xdvayw/piE=;
 b=yBxorEBPofzIyffKbi+BMQZx04x0ai69zqg1CFi7dg15Ly+omw4Bt3qoyDXs5oYgWN2GyAvpWLnGPeam8yMLIDO030JXJcBKjfl/QxoJQDKdcjDbjq6hmrMbiunJYx1rgNZnH7Tr3fHL7NDjjxIycX36hg+ST51tQibYt9CNgx0/Eh63IYnYelR7UBEJALsEdfImECiovPlNzUjCWWHyik3w5HM1O93tDzj9t1sUel+KyZPyUSF2B5oz488/JFxdRfBI1Q3QRZIHKRzyLhufN5mBjcr1J9x4TC7U85T2irgM/vXo2E9EM4TxA5lhg9nybf9T8idRqwY6MwG35Woa6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ugdFnT91gyjAmruZVziLL2+JUHHqwH88Xdvayw/piE=;
 b=IL4FwGKSPV5P6Qqd1TJnQs/Yy3fZFXF6QyvGQOMxFJmWQ+9P/NES1zbhxL3Osu6w5Qq8NQsV/Gcy6yc3XK5CV8alwkPw0u/AXt29riemJNzQKwA73vUQ+MD1NvndZeXclMWGdst/m/lbJYcPonqdTMA8baSRc9gTvHgcDLhdr836uk5UT+YhOW0daw1veLwv7/EQnBErRBUyB0gkCDJdsm27eLT/39PB3UsC9Fw9FIiC13XLCgFZy9GdC4owFOv5pX5kSeHKI+/iEHap/KZAkV9pZdJfW9XUTtG0Kz9xZ6/6tG62wGThFv1xtBDzI4zcfgb+V3ppnUKPHReuh6IyHw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10276.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.23; Fri, 6 Jun
 2025 04:40:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 04:40:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Topic: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index:
 AQHb1fXClSX0hMaoWkio+rC4u/XbAbP0w146gAAL8ICAABmoa4AAkS2AgAAS3jSAAAFvYA==
Date: Fri, 6 Jun 2025 04:40:51 +0000
Message-ID:
 <PN3PR01MB959787F6C64CDDD94BB6CA02B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <cover.1749112640.git.gargaditya08@live.com>
	<0d28e337cfe7ce3c52490544875474b3502d2081.1749112640.git.gargaditya08@live.com>
	<xmqqy0u687ww.fsf@gitster.g>
	<PN3PR01MB9597EA16029BEBBF4B966212B86FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<xmqqy0u66n46.fsf@gitster.g>
	<PN3PR01MB9597D25829C2D0A4342DA311B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqldq55vxr.fsf@gitster.g>
In-Reply-To: <xmqqldq55vxr.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB10276:EE_
x-ms-office365-filtering-correlation-id: 65737385-7ba0-4473-e528-08dda4b45131
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799009|7092599006|8062599006|8060799009|19110799006|461199028|6072599003|440099028|3412199025|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTUrbjltNzM4OVN1TVppbGNBeVBFb1dPTkNFOU1rRXptYW1nazVuYXB6L200?=
 =?utf-8?B?WS9nUkRIS2dpVjhhQjE4MjkxaEI2YXExUmNZdmhDcUhMaFUwVkx1ZmFtTGRl?=
 =?utf-8?B?VTk1MzN2dWRiRmVXUGdTdlhwM1c0UXR2TndWOXVka2JTY3JQK1N1QVFHN3Ev?=
 =?utf-8?B?SVB4ZHdZMTlweU8yNXNBK3JpL0dsTGRzUFhLb0V3RDJIRThWeXgrR0xpb2RC?=
 =?utf-8?B?S2licWZpZE1tdHg5MnhqYVFNY1hDSTF4bTR0WFdOdzhsTjluUW5QWHRrR3JP?=
 =?utf-8?B?WGdLK3ptanRGQjFGekZsZEhsejdzeXVJelZCalBWOFBmRFM5YjRHSzFLV2RM?=
 =?utf-8?B?eXl2VFNoOXRFU1YzTUhXVlpCQkVkM1NCTWRnVW5oUjNpS1YwOGt6V3BTNlQy?=
 =?utf-8?B?OG5qZy92NHdaeWN2SGthNy9pU1l3aFlyUjNkSmF6Vnl5TXluSHVsUEhRY1Fu?=
 =?utf-8?B?c1VYTGZPQzJIM1RqeElMRXp3S2NiRXVoWWt5MElXWXRYQTBjYXRKMVpZTk1t?=
 =?utf-8?B?UW1UbmxsNXRsTjJNSU1wYlZJY0Y4OGh4eW53K0NwM0ZLditHT0toTHhSZjk3?=
 =?utf-8?B?aUk1RXczcVdOKzYwbW1nN2d1Zm1DbTZrZ2pXaitzNGtzS2tuK0V2UnhWYTI3?=
 =?utf-8?B?TXlPVVJ5c1BlM1ZXdW91SnlYT2dtTDZBUnkxYjI1R3A3dWZhMkEwbjQ3ZTNw?=
 =?utf-8?B?SlU3b2hjLzcwM0RQaVJnb3FMczUrL3I2UEtGOStwQUV2MkhZSHV4b2RGYktU?=
 =?utf-8?B?bHVIRzhHUFMvUFVjckpSeEtuZjNITXhDTVFwL0RnNWJ6L0trQ3lzeHJMNUZs?=
 =?utf-8?B?eGtMeGZKYXVRTlVub2xHbzM4eDRORE1taUJuMVdRMUdMeXByTkIxd3JhRkZv?=
 =?utf-8?B?QTIydzRiZUlNY0xWYlFGZmdsRjZtN2t1Uk9rSnZHN2cwTzFsbHVPRlQ1Y1ZX?=
 =?utf-8?B?SjdoZGY5YWMvTmwrK0RPZXRzc3F5UENsVjRBeHBJcXprWW8rcEpJNHRjdFdz?=
 =?utf-8?B?Z2ZHZTVyNFpoN2NwWVN1clFOK0t3NjJJU1FOOVN6VGJjOHVLM2oxUTZDTHAw?=
 =?utf-8?B?UlM1c3RqdGFXMGc1c3A5ZmZqK1Uvc0xkL2V1cjM1em16MzhGbVFHNU9Kd2NS?=
 =?utf-8?B?RU5sOTFhV0pnQzJFYTR1T0c4UW51ZlZWNWN3c3ZsYjB1azRQSXdPakFGR2M4?=
 =?utf-8?B?TDV0akdTU2tzR0U5K1VRYy81TGk5QVJRMzlzUG9JYXBGaDF2VVhYWi9ZSlpx?=
 =?utf-8?B?alRnQ21HNm9nUUxkYmhHTGVpTkRNWGRyTkx3QnVldmpqWDRiOUxYUWhWcXVN?=
 =?utf-8?B?eHNOcXB6dWh5VTJMUEtBOXd4SENqbkd3L3pIRmVRRkk1V0l2V29xb0VEMEFa?=
 =?utf-8?B?V0ZhUjZMa0t3VForYjBDbHJWRjNKVHo5cFpBanpVekZtcEMreGxvRFhCKyt1?=
 =?utf-8?B?bFdPdzU1RXdvc1p4cnllcCtBaEY2VWNIMnloSHhUcVp6K1d2S3pjWTBGZm5X?=
 =?utf-8?B?d1lrQVpUSkJ0dE01SUxmZHgxVSthUmx6RzlTZFlRZWFzV2xMSGxMeVltTWw1?=
 =?utf-8?Q?2Pv+BuGjPflkoWaXeHt5rY5Cw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q01KL1grSS9TTmtpbE1ORituNWdWTEU1bVBhM09kbTRlR2p6bERuNEw1VnpB?=
 =?utf-8?B?elZNSXpJT2hjeUVpcW5UZmZrVHFrUHVvdjdjL1VBVjZuNFJPckR1RzZubU9X?=
 =?utf-8?B?MWMyZWhzWnVDekF3VjBBTG9nb3VyRUJMS1R6YWcvL3VsWHdoOTY3MWFQT1pZ?=
 =?utf-8?B?YUNTOVE1SXlnMFJGY09IWUVOdEJYeFN5UGZMbkg5WWRZSWVYZVFUdzZoR3pj?=
 =?utf-8?B?czBrait6RnUvQnRYUWFqalU2bFJHTjFRV04zdUlSSTJjNGRBZ1dpMVBtbHJM?=
 =?utf-8?B?TENFMEU2NjZBdXFaMndlRVdlaVVWM245RDhtdnVTODRwZWNlZHNieitubnNJ?=
 =?utf-8?B?YW5BZXphMnFkWkxrSTMzQ1ZlZyttcU5IWTRRbTh2UWdCdEJCSTN5aWQzNzQy?=
 =?utf-8?B?YmR5YUFheFdXb1VCVE50TFB5c0VySXhhT3BucTZiOU0wK3IwOWE5cGNWQ3dv?=
 =?utf-8?B?Vk5YSWloVWFyY2IzYUVJeWZodWJmeDc1ditKajcreDJ4K0FIK1JrSUtzNGVE?=
 =?utf-8?B?QzRQZ21jVW1GSnNHeUc2emM0V3hHVEFQUkZSak1pcVk3dWFMaUI3OTRRbCsv?=
 =?utf-8?B?amRvQitvdUdzY2JtdEQrdm1jMXhHc2xyekFuY25NcnNaY05YR2FDUWpobWpU?=
 =?utf-8?B?d1QvY1U4VnJ6LzduUmszdkgzREFjUVNmOXJUOStCeFF4L2tONnhscVFVL1Ux?=
 =?utf-8?B?a2dLZ1lUUUlzZ21JWWRrU1BmN1RlNlh5OTBvbXJNYUVlU0V1Vi9ETmp3K3B1?=
 =?utf-8?B?dFFzQnNvc0FSWXFHNjR4ZDRyWFNNa0d1azN5VXArdDRBVVdJOThDS0JFTmc1?=
 =?utf-8?B?eFpjSVU4U0VYcVV1WjBiTHg5SENNRDdKdE5XZXM3TUtVb0NhZDM2SWVMUlpE?=
 =?utf-8?B?MGQ0RjhCL1doaXlHaGQvaENIUzNlTzlZamJTaFRTeitZcjcwVnkzNFpWMWxn?=
 =?utf-8?B?Ry9mRld1OTdiY0EyWDVPOERKeXp1UTkwLzdSS3VXcXNFdGtpdExSdFFGNStT?=
 =?utf-8?B?c1N5aWV4R2k0anl2b2NrVjEveWxHaS9TdGVsbWZjeTdNb1NHeFp1ZlQxR2xr?=
 =?utf-8?B?dGljS3h5bnBKTWpMRHJhNUErUFJGbTNNLzNmdGZFSjhNMFY4TW9ESFV4bGFD?=
 =?utf-8?B?NXBHK2dnQVZZVGU0bTZTQTk3VnVWWGtzYVVPbXU3V2FkYTl6QStnMDZJZmxY?=
 =?utf-8?B?MjlpOW9xdzNEUHo2WUZQZzNiZFYzMjVCSjc0TWw1Rzh1MnNwbkZCVDhkMGgy?=
 =?utf-8?B?TlBSN2tvQ2gzVVo1ekM3amVoT21HTjBTS2Z4eUpnYlc0SjhHKzcxREg2ZEgw?=
 =?utf-8?B?MnBYc2NBQmNUaEYzYjlmTFl5aU0wbGoyUEFhUWVWWnpGcHlGSjVBRDhqb2Jy?=
 =?utf-8?B?MVppYUVoS0RaVnhaSWUvNm8xVDZTdU9wL2xoMFJUZ0dwbjlJKzJsQklQeG5P?=
 =?utf-8?B?OU85LzVNWlJSUUZBTVBkY3RMNGFWRDJWVXg5K0U1SFFSQzhUMVVKNVRtWmoz?=
 =?utf-8?B?TFpqUnZrdzZ6TXFMamM3M2lkdTZPWFQyZ0tuL0lZT2lYVDhwcEJqcVlRdGZh?=
 =?utf-8?B?NmxiU2hON2pnbjJYSWlZSFVnckpPVEowVVpCMVBpWUFJalA3R0dnSW14di93?=
 =?utf-8?Q?CVK+RwQUYxheZXL0GglUO1d7uYcYNBNufnThh96KN8Eo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 65737385-7ba0-4473-e528-08dda4b45131
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 04:40:51.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10276

DQoNCj4gT24gNiBKdW4gMjAyNSwgYXQgMTA6MDXigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+Pj4gV2hpY2ggbWFrZXMgaXQgc291bmQgbGlrZSBpZiAo
IXNydmMtPmF1dGhfbWV0aG9kKSBpcyBlbm91Z2g/DQo+Pj4gDQo+PiANCj4+IE5vLiBJZiB0aGUg
dXNlciBzcGVjaWZpZXMgUExBSU4gb3IgTE9HSU4gdGhlbiBpdCdzIG5vdCBlbm91Z2guDQo+IA0K
PiBUaGF0IGludml0ZXMgYW5vdGhlciBxdWVzdGlvbi4gIFdoeSBhcmVuJ3Qgd2UgY2hlY2tpbmcg
Zm9yIFBMQUlOIG9yDQo+IExPR0lOIGFuZCB3aGVuIG9uZSBvZiB0aGVtIGlzIGdpdmVuIHVzZSB0
aGUgcGFzc3dvcmQ/ICBXaGF0IGlzDQo+IHdyaXR0ZW4gaW4gdGhlIHBhdGNoIGxvb2tzIGJhY2t3
YXJkcywgaW4gdGhhdCB3ZSBzZWVtIHRvIGFzc3VtZSB0aGF0DQo+IGEgbWV0aG9kIHRoYXQgaXMg
bm90IFhPQVVUSDIgYW5kIE9BVVRIQkVBUkVSIG11c3QgYmUgUExBSU4gb3IgTE9HSU4NCj4gKG9y
IGFueXRoaW5nIHRoYXQgd2FudHMgdXMgdG8gcGFzcyBDVVJMT1BUX1BBU1NXT1JEKS4gIElPVywg
d2h5DQo+IGlzbid0IHRoZSBjb2RlIG1vcmUgbGlrZQ0KPiANCj4gICAgaWYgKC8qIG5vdCB1c2lu
ZyB0aGUgbW9yZSBhZHZhbmNlZCBtZXRob2QgaW50ZXJmYWNlPyAqLw0KPiAgICAgICAgIXNydmMt
PmF1dGhfbWV0aG9kIHx8DQo+ICAgICAgICAvKiBtZXRob2QgaW50ZXJmYWNlIHRoYXQgdGFrZXMg
cGFzc3dvcmQ/ICovDQo+ICAgICAgICAhc3RyY21wKHNydmMtPmF1dGhfbWV0aG9kLCAiUExBSU4i
KSAgICB8fA0KPiAgICAgICAgIXN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwgIkxPR0lOIikpDQo+
ICAgICAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfUEFTU1dPUkQsIHNydmMtPnBh
c3MpOw0KPiANCj4gaWYsIGFmdGVyIGFsbCwgUExBSU4vTE9HSU4gYXJlIHdoYXQgdHJpZ2dlcnMg
cGFzc3dvcmQNCj4gYXV0aGVudGljYXRpb24/DQo+IA0KPj4gU28sIGNvbnNpZGVyaW5nIHRoZSBm
YWN0IHRoYXQgdGhlIG9yaWdpbmFsIGNvZGUgZm9yIGltYXAtc2VuZA0KPj4gd2FzIHNldHRpbmcg
Q1VSTE9QVF9MT0dJTl9PUFRJT05TDQo+PiB1bmNvbmRpdGlvbmFsbHkgYW5kDQo+PiB3YXMgcnVu
bmluZyB0aGUgQVVUSCBjb21tYW5kIGV2ZW4gaWYgYXV0aCB3YXMgc2V0IHRvIENSQU0tTUQ1DQo+
PiBvciB3aGF0ZXZlciwgSSBqdXN0IHByZWZlcnJlZCB0byBub3QgY2hhbmdlIHRoYXQgYmVoYXZp
b3VyIHNpbmNlIEkNCj4+IG1heSBjYXVzZSBzb21lIHJlZ3Jlc3Npb24uIFRoZXJlIGlzIGEgdGlu
eSBwb3NzaWJpbGl0eSB0aGF0IENSQU0tTUQ1DQo+PiBtYXkgd29yaywgYnV0IEkgZG9uJ3QgcmVh
bGx5IGhhdmUgYW55IGZyZWUgU01UUCBzZXJ2ZXIgd2hpY2ggdXNlcw0KPj4gdGhhdCBtZXRob2Qg
aXRzZWxmLg0KPj4gDQo+PiBJbiBzaG9ydCwganVzdCB0byBiZSB2ZXJ5IHNhZmUgaGVyZSwgSSBk
ZWNpZGVkIHRvIG5vdCBtaW5nbGUgd2l0aCB0aGUNCj4+IGxvZ2ljIG11Y2ggYW5kIHNpbXBsZSBk
ZWNpZGVkIHRvIHVzZSBhIHNlcGVyYXRlIHRlc3RlZCBsb2dpYw0KPj4gZm9yIE9BdXRoMi4wIGFu
ZCBsZXQgdGhlIHNhbWUgbG9naWMgYmUgdXNlZCBmb3IgcmVzdCBjYXNlcy4NCj4gDQo+IERvbid0
IGJlIHNob3J0IDstKSBCZSBsb25nIGluIHlvdXIgbG9nIG1lc3NhZ2UgdG8gaGVscCBmdXR1cmUN
Cj4gZGV2ZWxvcGVycy4gIEluIHNob3J0LCB5b3Ugd2FudCB0byBtYWtlIHlvdXIgcHJvcG9zZWQg
bG9nIG1lc3NhZ2Ugc28NCj4gY2xlYXIgdGhhdCBmdXR1cmUgZGV2ZWxvcGVycyB3aG8gZm91bmQg
dGhpcyBjb21taXQgaW4gImdpdCBsb2cgLXAiDQo+IHRvIGNvbWUgYXNraW5nIHlvdSB0aGVzZSBx
dWVzdGlvbnMtLS10aGF0IGlzIHdoeSByZXZpZXdlcnMgYXJlDQo+IHN1cHBvc2VkIHRvIGFzayBx
dWVzdGlvbnMgYW5kIGFzayBmb3IgY2xhcmlmaWNhdGlvbnMuDQoNCk9rIDopLiBTbywgeW91IHdh
bnQgbWUgdG8gYWRkIGNoZWNrcyBmb3IgUExBSU4gYW5kIExPR0lOLCBvciB0aGUgY3VycmVudA0K
bG9naWMgaXMgZmluZS4gSSdkIHByZWZlciB1c2luZyB0aGUgY3VycmVudCBsb2dpYyB0byBhdm9p
ZCBwb3RlbnRpYWwgcmVncmVzc2lvbnMsDQpidXQgaXRzIHlvdXIgY2FsbC4NCj4gDQo+PiAiU2V0
IENVUkxPUFRfTE9HSU5fT1BUSU9OUyBpcnJlc3BlY3RpdmUgb2Ygd2hldGhlciB0aGVyZSBpcw0K
Pj4gYW4gYXV0aCBtZXRob2Qgc3BlY2lmaWVkIG9yIG5vdCwgdW5sZXNzIGl0J3MgT0F1dGgyLjAs
IHdoZXJlIHdlDQo+PiB1c2UgYSBkaWZmZXJlbnQgY3VybCBBUEkiDQo+IA0KPiBUaGF0IGlzIGEg
dmVyeSBnb29kIHRoaW5nIHRvIHdyaXRlIGRvd24gZWl0aGVyIGluLWNvZGUgY29tbWVudA0KPiBh
bmQvb3IgdGhlIGxvZyBtZXNzYWdlIHRvIGF2b2lkIGZ1dHVyZSBkZXZlbG9wZXJzIGNvbWUgYnVn
Z2luZyB5b3UNCj4gd2l0aCB0aGUgc2FtZSBxdWVzdGlvbnMgYXMgSSBkaWQuDQoNCkFscmlnaHQs
IEknbGwgYWRkIGl0IGFzIGEgY29tbWVudCBpbiB0aGUgY29kZS4NCg==
