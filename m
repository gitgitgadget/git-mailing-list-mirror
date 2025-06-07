Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010007.outbound.protection.outlook.com [52.103.68.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072A4A31
	for <git@vger.kernel.org>; Sat,  7 Jun 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749316398; cv=fail; b=KPwzp572Egps1BslfktGemV9C/ykP1kXcF0a/9npeDXZkzo2fKLnHG9hjCYI2yjlrRRGPvrI16tkwuFNSCdaT6aj82Vx3nVSJIk3RpoNI18+3PDXkKEOkdR/JLQPOumcjIxQKTdU5ShBVpPrd6IT9aulRGwRi5H/dXg5iFmUerI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749316398; c=relaxed/simple;
	bh=2/Rk9ecQwFW6YsBlvis+cbIMFH8VMklG3mI2Ht9K3xM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhZzxZp6yqc/aNzt8qVa6Dn28eAhK43hCLWkSW39SHTNtTJkzCZ30gxsrkleidYaVEJNoCGo5gfmQ5M/uZnsO8E5QoHxpyG677alG6g1JdKt1BNKHzX2r2HUZE89LSIhRePo/obsPdV6L976/ybIhx2YHGIsMqvbVueWQQaI7jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Jlq/DF4U; arc=fail smtp.client-ip=52.103.68.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Jlq/DF4U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te3kSizRdve038vo3rgA40CSyfYjUgzh6c8KF7vNbqQ3OoABmqXLf5xpk0YVDNphnuWa98+HMKZy67NNEsYhTgw2zPvaTUimf57NlIF3zTwIT8Ijr0zSUgmduCjTsOnPQUQvN4EhMmKJ3JKMQJp4s2d0DAFnWd/0YhkD6w53voRKwlJjHSGLtKGe5T60QI3/j7LB0Vp3XswL5bgsdxkBHkoyJtI4aTxO4GPFw7nm0W8wNmVbRbG+zn3sB8MTd8oNZ6s8TRCdjcNNyAAOF9dTS8OopUOAy9kDBdFRevgF+Qs+N36+qRi960mOuBTKbW9HaLp8Pvz1RUnaqLTV12G8fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/Rk9ecQwFW6YsBlvis+cbIMFH8VMklG3mI2Ht9K3xM=;
 b=Y+Ox8qYsrCvOA/KqOl788HIUxIoTcJ5gvRjjCjrfkXNY2dFRvW5W089jZb37U7oWrbdkJ0OfqlTcoR5HP9vgCQGvilBehFhAYxNOWPeFbQjivWcvNQTvltCBfMtMRanDyvLt6fR5QMtAVEB7affrY/PQysWJbtkkutdaIF+CDPDd76DeCmNApq5pCDhbqvFlJxHSF4bj55qxu7j+E30Zp5a8ThJGO7BcoG1G2eHv1MAen7B/hxqmkgrrx7ceSL7gxBcBRy6tTJjnpsKvcxobwsWpoe5NfzKmskdm8scGgzIre48s6r8wQCgKO7xi8Jrh728Ivy6EK2a70DnFtiBvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/Rk9ecQwFW6YsBlvis+cbIMFH8VMklG3mI2Ht9K3xM=;
 b=Jlq/DF4U+JWCty7xam5bOUA6XqbqYA2/nn9n4XOZ2DEGf+Ipyd1HrDkMNeqfue/TAy7adpFMWBuxp9jscaU3RvrHi4bRizERt+gxyGdG1+7bqClf+BsL/QUlAUcelIhXuvxD56vPGn0141Nhyy2Cfucez+4EME3KBEvMp5esP/K2TTcffdEk7j30uh10M2B2FegxFQiA78MSnd34Bu+eudW5bI27dq4kK9tKMmE9YCA53TvFAihvB2Pxj2+lzFhCWVoZ5N+STovrmmv3OinqZhDsIEOaavfP5VPZjiDD/Wx/leUv+zQW0ALpnebtt5RsSnOJwW3RKOtFp6eXSAal2w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAYPR01MB10697.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:159::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.24; Sat, 7 Jun
 2025 17:13:09 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sat, 7 Jun 2025
 17:13:08 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Topic: [PATCH v14 05/10] imap-send: gracefully fail if CRAM-MD5
 authentication is requested without OpenSSL
Thread-Index: AQHb1x7RwmU6j68CikiCTe6h/Egw8rP31HOYgAAcK7U=
Date: Sat, 7 Jun 2025 17:13:08 +0000
Message-ID:
 <PN3PR01MB9597C03C260EC7F5F9237A5FB869A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB959732DB7232FFE1ED7D38F3B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqy0u3zhxl.fsf@gitster.g>
In-Reply-To: <xmqqy0u3zhxl.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAYPR01MB10697:EE_
x-ms-office365-filtering-correlation-id: 1153bfc6-940d-4e8a-1519-08dda5e6931c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|461199028|6072599003|15080799009|7092599006|8060799009|8062599006|19110799006|3412199025|440099028|102099032|56899033;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ty9yQ1BiN0JRekQzenR2TVVrT0MxcS9nT1liVm5nSW52aUl3cXdYTVFqUUp3?=
 =?utf-8?B?MGw5TWVvd0ZPMTdsVW1ka2thdjJnS2RiWG10VkhQQnlBNUtDRU9VSFRWRTA3?=
 =?utf-8?B?RUVCRWg0d3lVTHRHRVFPeEt0ajRVTndjRFVVTnRRM2ZTRXcwOFVydTBHRWtl?=
 =?utf-8?B?eEFIT2xabzVuN3BlV1c5QThsd3BMa1pONUN3elp6YXRYZE9aTytOaDVma003?=
 =?utf-8?B?RVRWN1hybzdZT2lSdjdTeEZ1RXliRVVWWDdKUG1jWmhuWUZQYThzcFErdFZ0?=
 =?utf-8?B?T25SWnhHMDNZY0FvSklpUEI4dGVjSnZJOGxrTWxaMFIzR1U0TmRldHZYNHF0?=
 =?utf-8?B?UTdYUjllMDl2R3FaQjloZ3JLczlSWmRERVBabXNvVEFCRVU5T05VOTM1bmMw?=
 =?utf-8?B?ZWNETnJDNDdodTBhcWN4TUxGV3VDM1N6bU4xOHZZQ1NsaElyZC9Tb0gvWlIx?=
 =?utf-8?B?NmU5dGE4Y2hONktNK3B6Z01FeEI5QWtodXNLUG9UNDlUWGo3MnFTbFhDRktR?=
 =?utf-8?B?WWRlVTIrY1JFVksyNGJVV3NpMlRndzBNQVhCUXFwUFppNTlXQSsrTjJQK0hY?=
 =?utf-8?B?Z21NMHB1MFVrTkwyWTkyNWFVTFY3WTVwOVdtUWNwei9CUnNjb05WdFFFSmlU?=
 =?utf-8?B?Q1VQejJueEZnZjYxMmVFU2o4SG53Z0xIT0k2YzQ3VzNoVDh6U2NDVGRsVENn?=
 =?utf-8?B?VTVRejVSdTdOWktwYVZGR2xYYjh1ZlkrY2dVWGkydGVVclRvT1ordGVQemFh?=
 =?utf-8?B?RW5OUENXM2ZpZGdzY1Vabk94VndmQlBhM0sxRnI4b3A3Qnk0cHhTbWNNbTNt?=
 =?utf-8?B?TTZjenFtdW9vaVNBRlpCdHpiYmhLUmNhdXdDcnhuRkUyWnNpTmhrOEJrc3F5?=
 =?utf-8?B?bGVuWitGZUk1NXdzcEdydHExV3FsVXZvd0wvbWNrc3JhdUVyS1VsWlJ1SFRB?=
 =?utf-8?B?NmM5VzVpVmlpcWRNZy9JS3ZsN3N2TVZ0VmVSVklWVTAySW81c2lodkJRL0Fm?=
 =?utf-8?B?czFmK3pqNTJma3NpUnppRzQ5WTBOdFo5NGhsbEVvUWFuVXpJSUEyTHRlOTVT?=
 =?utf-8?B?eGkxbDhoc3o1OWhqelc5S2RVeUoxVVR5N1J5K2RiMTVkOEIzUHdmUW9xNU0v?=
 =?utf-8?B?ZFZzOGFNblFoMG55OWQ0Y3oxVytFY3hBRDZGKzdQUC9YUDNJQzhPZStYVFk3?=
 =?utf-8?B?NGQ5WEpVdWFKZjg2OGFPQjB4WldlWWNQcXFBQ0xuTUUxcTQzaG9YMGJGMGQ4?=
 =?utf-8?B?V0M2VTJxWWRNWm5pRFJSVDMrYW5PZ3d2SEZwZGRYZE1lOTRmdmt1QWpTRXlE?=
 =?utf-8?B?OSs3MWtBQWRnTHFQbEtqRCtyMFljNkFHbkg0MmcyTE5nS20vZnUyR3hLNWFM?=
 =?utf-8?B?K0RwK2E3QU85cU0xeUxRV2FiUHVGWS9WNk5LS0l6bUs0MllXODVFZzIrZUV3?=
 =?utf-8?B?NXZ6Q2VkY1pkTVg3VUhBWGt0MXpkclVsVkU1QTN5RGxmUmFIYy9iN2JJK0ti?=
 =?utf-8?B?MnUwcGdvYlQ1TVVDbUpHYkNVNTFmMVNVZWN6U3hQeC9iTGFpZko1Mkl2Y3VT?=
 =?utf-8?Q?m6PHEAMj6CJT3bkDILSgylaRE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MElmN2ZLRzEzN2M2Y2c2YURRMmVtUzliV0VYUURtQUxhRGhpTTl2eEdxSG55?=
 =?utf-8?B?NWFteUpQUlFOR2dGSmFKZmtxNHIyc29BTjNqd3VUZDNValZ4dllpOVJNWGFR?=
 =?utf-8?B?YnZlWHdhWEhKZ1QzWnEyVURsQ1JJMGh0V2grZGEvcERXVW1WMVFNUGgzdFEz?=
 =?utf-8?B?MzNnaG1qR0pna1M3UVppZmZHVTAvZHVNSmdwM1FCWVNDbmF1S09aTE1QUFh0?=
 =?utf-8?B?Y2pGKzYvVjFLTUxMaHF4Nm5lc1laQkxjdXF3V3M5M0xYM0tYcW1kbVJqZE9y?=
 =?utf-8?B?MzBTUGpxK1MwSU5ydytFTzR3MXdMOVJiSVM1dTdIQm1tS1U0cVRycW1pZS9y?=
 =?utf-8?B?ZGFqa1ppQVBVTXVWV0J0RTB6NysyYi9GUVNYMXpwL09Xcm1JWUlVKzA2dVVz?=
 =?utf-8?B?MjhoTEtOR3ZLRTNrVllIYzFFYngxbHhqa2xZTkFoWit1YnFuRmY2cXI5b2ta?=
 =?utf-8?B?d2NCdVZhaWdORGZkb084UEZqT1BCN3ZtWVByUmMrQytTekRGUml1bi9ORjRx?=
 =?utf-8?B?RUNPU2FpZTJkRyt6U3Bzd0tjRGRpSWVsdUQrSmFDbWxBOUYxQU8vbkZ4eUR3?=
 =?utf-8?B?Q2tKTUVvVjZoa0NHZW1xV0lVcmlEaTVRbVRSajdEbmJUVHY3ZmJPNzN2NlRO?=
 =?utf-8?B?aUx2UEhCNFVuR3JhSGdWN1ZIOWdGUXd0VjhXblN4VzE2S0RuLzdiOFBxU2ly?=
 =?utf-8?B?cVRld0drbCtPcmQ0MEJKMnk5QURQaTdwZjFOVENpa1dma2pSTlhraGdaWWRU?=
 =?utf-8?B?YU1WemhRaS8vaXFWSnhQRU0zbUFZVzJJcmpHekR0OW5SQnd1eU5DeFZDUnMy?=
 =?utf-8?B?K0pRWUU1blpSWmhtaWFuUzZyeHM1REUrMEJrak1sSmM2ZGJDOS9qc0k0dFc4?=
 =?utf-8?B?MjNyTWVvc2Y3T0sxOEZ3SUJpWFpySjZXSmNFUGEwa0V2RVZTSVhZSmpaTkJ6?=
 =?utf-8?B?Q09iSjVFREpyeHVkT2QvYzEyS045UnY1TGRCYTlpQWo4T2h2T0VRTFdpcnFI?=
 =?utf-8?B?aDJ3SGQxeHVHZHFZSm9PWEh4WFpTNlo2RDI4eDJzWFVVbWQ0MzRIbnFmV0po?=
 =?utf-8?B?TW5iNVRyQXJSN3FYUXNDRmNXbWQwazdEMXpBTVNmQVpRdUVDUHFOYWNpQ2p4?=
 =?utf-8?B?WXRKdStEUlNpWW9vbzFPUmdLRDNmWTBsRExVb2ZkVmthVTEzS1ZyT0RvOVVC?=
 =?utf-8?B?SmxkVWpoYUJDdzZPV0NkVnhCcVM3VlNpdjNtREdnNTkwYnJabGpSZWVzb055?=
 =?utf-8?B?blpTc1Z1Vm5ZWnZocS9WOTNYOXgreWxBOVgxS1grSVdIeUFWWWszS1poazRu?=
 =?utf-8?B?cERodDZoT0MrS2VvU2s5NXlIZ3FCdEVRRFFwc08xWmdFRHJteEZXQXdtWmgy?=
 =?utf-8?B?Ti8wWWhFdkx1YmR4NW1Nd05WUVdLMC9rMkhkNG41RlJCaVlZSTgyRmg0Y0ZP?=
 =?utf-8?B?a3J2RVRvOTF5VW5FYUlOMkt6ZW5hUUJzN3NFdnl0SlRCelpLbnNsWWNobEd6?=
 =?utf-8?B?TEtHY0pJcWVoZklHcFVWMjhyZVdMNnlvcS9PY1BLMDNUMVBVQnJUVFo3ZE92?=
 =?utf-8?B?WDJJVDJzTjB0N2l1elR3NUtHdnVWSTVRaWFrK0NxRXN4NnpjNG9PbGorWGtG?=
 =?utf-8?Q?nxQ6g+JWZG9ii1FCEgYbJG8s7SmphCr32EhPcvTtmAb4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1153bfc6-940d-4e8a-1519-08dda5e6931c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2025 17:13:08.5453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAYPR01MB10697

DQoNCj4gT24gNyBKdW4gMjAyNSwgYXQgOTowMuKAr1BNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+IFVubGlrZSBQTEFJTiwgWE9BVVRIMiBhbmQgT0FVVEhC
RUFSRVIsIENSQU0tTUQ1IGF1dGhlbnRpY2F0aW9uIGlzIG5vdA0KPj4gc3VwcG9ydGVkIGJ5IGxp
YmN1cmwgYW5kIHJlcXVpcmVzIE9wZW5TU0wuIElmIHRoZSB1c2VyIHRyaWVzIHRvIHVzZQ0KPj4g
Q1JBTS1NRDUgYXV0aGVudGljYXRpb24gd2l0aG91dCBPcGVuU1NMLCB0aGUgcHJldmlvdXMgYmVo
YXZpb3VyIHdhcyB0bw0KPj4gYXR0ZW1wdCB0byBhdXRoZW50aWNhdGUgYW5kIGZhaWwgd2l0aCBh
IGRpZShlcnJvcikuIEhhbmRsZSB0aGlzIGluIGENCj4+IGJldHRlciB3YXkgYnkgZmlyc3QgY2hl
Y2tpbmcgaWYgT3BlblNTTCBpcyBhdmFpbGFibGUgYW5kIHRoZW4gYXR0ZW1wdGluZw0KPj4gdG8g
YXV0aGVudGljYXRlLiBJZiBPcGVuU1NMIGlzIG5vdCBhdmFpbGFibGUsIHByaW50IGFuIGVycm9y
IG1lc3NhZ2UgYW5kDQo+PiBleGl0IGdyYWNlZnVsbHkuDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6
IEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+DQo+PiAtLS0NCj4+IGltYXAtc2Vu
ZC5jIHwgNjEgKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+IDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCA0MSBkZWxldGlvbnMo
LSkNCj4gDQo+IFRoaXMgaXMgYSBnb29kIHRoaW5nIHRvIGRvLCBidXQgSSB3b3VsZCBoYXZlIGV4
cGVjdGVkIHRoYXQgaXQgd291bGQNCj4gY29tZSBhIGxvdCBlYXJsaWVyIGluIHRoZSBzZXJpZXMs
IHBlcmhhcHMgaW1tZWRpYXRlbHkgYWZ0ZXIgMDEvMTANCj4gZml4ZXMgdGhlIGNvcHktYW5kLXBh
c3RlIGJ1Zy4gIElmIHRoaXMgaXMgbW92ZWQgZWFybGllciBpbiB0aGUNCj4gc2VyaWVzLCBpdCB3
b3VsZCBuZWVkIHRvIGludHJvZHVjZSB0aGUgdHJ5X2F1dGhfbWV0aG9kKCkgaGVscGVyIGF0DQo+
IHRoZSBzYW1lIHRpbWUuICBTaW5jZSB0aGVyZSBpcyBubyBuZXcgYXV0aGVudGljYXRpb24gbWV0
aG9kcw0KPiBpbnRyb2R1Y2VkIGF0IHRoYXQgc3RhZ2UgaW4gdGhlIHNlcmllcyB5ZXQsIGl0IHdv
dWxkIGJlIHF1aXRlDQo+IHN0cmFpZ2h0LWZvcndhcmQgdG8gcmVhZCBhbmQgdW5kZXJzdGFuZCB0
aGUgcGF0Y2gsIGFuZCBvbiB0b3Agb2YNCj4gc3VjaCBhIHNvbGlkaWZpZWQgZ3JvdW5kLCB0aGUg
c2VyaWVzIGNhbiBhZGQgT0F1dGgyLjAgYW5kIFBMQUlODQo+IHN1cHBvcnQgb24gdG9wLg0KDQpJ
IHVuZGVyc3RhbmQgd2hhdCB5b3Ugc2FpZCBpcyB0aGUgaWRlYWwgd2F5IHRvIGRvLCBidXQgc2lu
Y2UgdGhlIGNyYW0NCm1kNSBwYXRjaCBjYW1lIHVwIG11Y2ggbGF0ZXIsIEkgZm91bmQgaXQgZWFz
aWVyIHRvIHBsYWNlIGl0IGF0IHRoaXMgcGxhY2UuDQpJIHVzdWFsbHkgdHJ5IHRvIGF2b2lkIGFz
IG11Y2ggY29uZmxpY3RzIGFzIHBvc3NpYmxlIHdoaWxlIHJlYmFzaW5nLCBzaW5jZQ0KSSBmZWFy
IGJyZWFraW5nIHNvbWV0aGluZy4gQnV0IGlmIEkgKmhhdmUqIHRvIG1vdmUgaXQgYWJvdmUsIHBs
ZWFzZSBsZXQgbWUNCmtub3cuDQoNClRoYW5rcw==
