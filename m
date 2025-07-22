Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623831DDA32
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753202212; cv=fail; b=YOweMPcVxFRV95lw0zXrgeeZxbyOtUYMbkaE44h4mLqJxM1N2SK+NFpY+2VAz6+4oRYwGU2Bau3wxm1xOV6wGh7QAHlAXgngYDx+1EOjHhKhDREGa4MIUb7LlnlsBTbEmzrwdpASDqqqKk3Ams7iGXMhNQm61GlAU60DkbNzO6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753202212; c=relaxed/simple;
	bh=SVLtbcy/5EvRit1FYvC8r0mdNJ5bG/yeyzA46zOf2Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SG30lmtdvS3rnYyYfjSlPrCQij36qAWWv7CN9+EzW0fBsaGORZUNQvIbS8Cmcpfv1JtiCEFq8PzNyMDTNYqEtZGa0IrJ4CrJR5odM3lPDv0C07gaJci0tEsTfNiGSVl99SlyPJZQn2RBCkCRX1vj1iePSX7KVpe/4hs9WVeYNFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=PM5nZNFx; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="PM5nZNFx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUAAPV2omhw+bLy0qFjKMFtY2wdyIoUflj9+y+WHZCUfYhQyioE3kzamW860yCrTVe1rbeDjiuPZbGN31qh1zpKPFZU33O7ih1Ku9/TpKqrXdSjSryGqGH16O5SPpN3qtrZ1J36Wi5yfmgYB1KaqnR/vO3LfvkzHmTE0jAk2behV7z+EpMFUYm8RtwMAywCjz0AL6iN6qBNdShrkSsZ4KdPHb2sCIsUG0kwlk7k8pdgLJTM6MnvuLpkDpe72jtEdVrnZ00mbNpVdMfTEjbMWua5+ZJ85hFq1m2bURm+duc8h7e58frt5MeAimkHFjqZ4hjbJe5ylzIW1/ayEwk/8LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVLtbcy/5EvRit1FYvC8r0mdNJ5bG/yeyzA46zOf2Ek=;
 b=g5cE7fn2gGbMAszODC88AStBoT3E+ICJO/v2q8zYGlRFX40CxpwyDqss3KUoC+QKJV7BZE8xpz/tKsPULTORrEN9trndBVY1uytYUXE86sif66us6/qzUor17cE3s0KCAfOOHSc3RlYah/of2V1F84ef1CvTmsLZIYQykkdOqZDs0hnsyF1gx4tuWtrpzi/yQxpKlkxMyKoBlPZ7EIeVlzLR7udu/seIs5ZC6hyaHS+S6M72dmHWE+11BBW1inHWMuAX+DDob88ZZzxK3pcfkrBRMzAcxIonm3vKzHS6Ej5KhjKs6byvI9+fAqz2Cfhs4ZKFbVfbOnK6qjDZI34jgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVLtbcy/5EvRit1FYvC8r0mdNJ5bG/yeyzA46zOf2Ek=;
 b=PM5nZNFxIT7g1ikp3O26OSwJWiEaOi9xmmqLSrq029Z97OOqlWXktZ7C4VlrYfsjaHxd8BlZUjWyNLm3f0y8J91TVx/4cMCizhxDiF1nWx1efbsw/2V27PjQZ8aYbRfRdVPEjkWluAd1T21GHOhBWWYu3hqvKzWMYqpQvA8bB9Zks5ibVmvQhvn85ph0onaA9WYtaCrQo7J2973vzX8cJeDaXc57dbSQ/o4XvtRhK8EZHmZPvrPn3bwSFanqe9zriySlqBBVSwqL2hSdaroJ9Na0qXsBRx9+RIT94g8j2bGpUvi5kD7KlBikOlE4MkDmqjQQWECrRIWg7a7DujZoDw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 16:36:46 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:36:46 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
Thread-Topic: [PATCH v2] send-email: add ability to send a copy of sent emails
 to an IMAP folder
Thread-Index:
 AQHb+icCP6QpV1qJFUuwKA//pz1KNbQ88vHdgACMowCAABmiW4AAEj4AgABWuICAAEZaQIAAD2iAgAABVgA=
Date: Tue, 22 Jul 2025 16:36:46 +0000
Message-ID: <12F1986A-F7CE-47A4-8F30-2664799BE2FA@live.com>
References:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
 <xmqqpldtxsp7.fsf@gitster.g>
 <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq4iv4x15e.fsf@gitster.g>
 <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqo6tctez2.fsf@gitster.g> <8596251B-7A3F-4220-8759-B75FF63964C0@live.com>
In-Reply-To: <8596251B-7A3F-4220-8759-B75FF63964C0@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: 559740d1-5db2-44bf-32c0-08ddc93df2dc
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVduMHpWUG9ONW9YQTdWREp2SnU2Z1B1MXJKb3RpZEZZbERhMHhUSVU2azFS?=
 =?utf-8?B?TlBFVE9pWTZPVE80NVR1RTV5QWlDbUNENDVkUzRlSXlrZkZaKzZtbm9uYmFi?=
 =?utf-8?B?K0p6OG1Ed1pEcnd4clBNbmdkcFhEdmNjMmViSnFQWndOb0MyMEZERU1WVklq?=
 =?utf-8?B?c0d0cnc0eVdZc3Rtb1plYXd6SWowQkp2UERqUlFnWlpnWnhsdk1lY2IvRXdJ?=
 =?utf-8?B?TWtsbnNMa0twMEJGbTNGd0t4dDFRNXgyTTV5OE5tcVRCcVZYZk5xWXZrL2k3?=
 =?utf-8?B?RU84L3ZGSFF2NHJUaXpka24vMEtBcnRBUXBlTEZqWFRpTTl5MjdvVmtpU2JJ?=
 =?utf-8?B?ME16WWhXYUJXU2hocEZsSlF4d0xXWHlUdkVUUWp1K2xwa2NtbHJxUWhsQ0tG?=
 =?utf-8?B?RisyZkZDZlRoTEEra0dlRzVKcHpRSFJ5N1ZVb0MzdHR6YlBiUEViVHhUbDNw?=
 =?utf-8?B?d3BFWVlabDJDdkczeHkzZGZYdWFRT1BmTTR4ZTVhVE5EVVFCdzlzcHBwWlpS?=
 =?utf-8?B?RHBBY3AyWlpDczVhcnZNMHRab1NnR3hpamRJOEVGNFNNZEh1RVJSZEF5RUw5?=
 =?utf-8?B?UlppREw1M1RYanlXMkI1dnQwSnZEa1czZ2RDaVBadzRCY3FJLzhSODI5VGU0?=
 =?utf-8?B?SUJ1MVFYU1BLSCtVRmlia2ZyczBKQjBsUXFDSTF0a21vYXhqT2Q3RW9tbm5B?=
 =?utf-8?B?K1VTZmRySDM2RFdjYW5ONXRUaC9CNkMwdkdvTEtnc0dNSkhRRVJjL1k3Z2hJ?=
 =?utf-8?B?Mi83TkxQRjlJWFpSSFgzVC9BVDlJaVhDZkdXSWtzUjJOK2pJL3NZbGhiYjAy?=
 =?utf-8?B?bk53NWhwNFJmZnpERlNVemJxVHBtUDlJVGQzKzhuVG15Y3FvTUQxMXIyZERF?=
 =?utf-8?B?MTV5akF2U2NzaDNqZGMwbkUyUTdDeXpxbDAzVEJwUktCUE9ZS0JDYUFtdlB2?=
 =?utf-8?B?YmNTNVhUYnJobWltckRiRnkxUGk3RjZHdlU1SUJNeUVoTFJhY0J5dFN5QVFi?=
 =?utf-8?B?Yk54Y0N1aGZ3bTI0VWxEc2pFejVvakp4ZE9Da1lNWGtTNUFMemgzSVcwWE42?=
 =?utf-8?B?MlVRSWYxdjRjeGJWUlQ4cWhLeVdWOHpWVlRYYzZEWnI0d0Rqc3ZjQTd2Tkcz?=
 =?utf-8?B?ZXZDZzJQZWw0ak9RcnJyTEN3UHVMUzFPOUp0elQ1d0EzeEljZHNBbzlQS1dy?=
 =?utf-8?B?L0ZhekEzTXlrcXVKREk4czk2NWtuemV6WWs5Wi9OSjVwbWFJYjJ0dHBtYjJW?=
 =?utf-8?B?TjBIWnFNQTBuVkI4bVJYUC8zOVV2ZTI0ZXQrZkhsMXVUeFQ2WGJZV1BWSUZO?=
 =?utf-8?B?U1NTZE9HUDEwWnM4RFdQK3VmT3hZTjh5Q1JZbWRyUkFuK2RNUkNucTVxUmdx?=
 =?utf-8?B?M3hnT1QvQThRblE9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUxVZDBubzhHb2tTZW1XVUF0NS9ERjNYRHVLblF2aUJkTVQ1a2QrWkZSWkk4?=
 =?utf-8?B?MmdvWjhoRVltTGdEbkM0UzRlczM3VStYdG5rS1BWeHp5RmpvVXpYVGZkY2hq?=
 =?utf-8?B?ZGQ4U0t0N2locjBZeEsxYkFGRThmY3ZiSFZlM2o5NGlNdEt4NHdQMjlhVllE?=
 =?utf-8?B?YlVvN0pXNW85T1NNTVNKU2w1QzlHSiszam50aCs2S2ttWTFST0tBWjg1ak1x?=
 =?utf-8?B?cEhidWxlRHh6dUE1dndSTVFjUlZoN2ZIbEVKQ3NSMXdsMEE4YnV0WnliTDRm?=
 =?utf-8?B?eENYNEw0SUx6Z1hWS0hRdVJQdjBqQTJsSElVdUh6RlpsWFhtYUhRMVM5dngz?=
 =?utf-8?B?WmIzTHRzS2hBZlkxcFFNd2pFWWF4Qi9LTGxOSm4xNmNHZmg2b0Myb1BtVmEx?=
 =?utf-8?B?YzB5OVlHK0xtVDY3NG9Vb2dsQjRkc0FDampyNHBEeTJBUDRtQUtHU2o5OGdt?=
 =?utf-8?B?LzJFV3BrRHJYL2Z0aUZJUDBzckdFek0zUldQdm4xb1BBY0VwRXVTb2tlSXdh?=
 =?utf-8?B?Sjk4ZjVCOVE5TkI0N0wwQ2xNenJQYmdiWDJNcDRVOHB6cWFaelNMejIzM3Zp?=
 =?utf-8?B?VE5IV3g2VnFRUUR1SC9kWFR1ZGlVY3lldlRQL2U1elRXZGhxcG4va2l6SzdS?=
 =?utf-8?B?N01RZ2VZQmY1M0FqdWJOcDMybFkyY0hFV1RHbi9pTTE2OHlGK0k1S0xERkFS?=
 =?utf-8?B?TTlwbmJJRXRMSmZXVlVhbkl4amNPcm5BT0IyUFBjc3ptNnYxWDlsR0dTL3Bx?=
 =?utf-8?B?bjlnM1ZmZTFjUGhZN21QM3FUZ1FGcEpYWHI0aGxGbUdEM3dtK281d2hnM0Y3?=
 =?utf-8?B?WXhpSzBTZUhxdFlPKzB5dzRERmFRUHA5akN2S1Y3Mm9tb0gxWTJvaE5HRWxW?=
 =?utf-8?B?TjdyaW04UG9KU0ZHMnM1b0RFR0EzTVNHZjBsUmZubHhrR0lnNG5YUHBlM0Ix?=
 =?utf-8?B?YWtqTERpRldpZnQvbktFZlRtWmR6WTlrT0RyUWtlQ1FYYUE1SVptSHVCZW8x?=
 =?utf-8?B?NEI4cXcxT2Nmakd6dGdBTHlZNFRoYnNXRmRwS2MxQnNocmh0VndVVmtFRHZo?=
 =?utf-8?B?NjJMYVZEVUI5UkwveEJjSXFoK3hMMFVrSWNSR3kyUnlQMnN6VmNpUStKOXc1?=
 =?utf-8?B?bDZTZ2s2NW5CaEdBbXF3SDhUcXkvbXhDQmNNOG03SjFuMXNSVkZ6RHFwNGF2?=
 =?utf-8?B?aE5TU2xMenVwdG5yQVFQVFdGNDcyc1lzUHRHaWljOEd4OGkwT3FZc3dYdWFC?=
 =?utf-8?B?WU9jK0MvN2VMc1IrWWZqU3pFVWs2cUFzMVVoMVZwOVJNb1hkbHkzVC81Ymda?=
 =?utf-8?B?SUdLeFFHOGg4V1piSStMS3FycWtKSVZxTVZwVnlEblFidEp5MTVoZzd2eGlG?=
 =?utf-8?B?SkcrL1V3RVlHTWhBY0FpdGFqcjJIMkhhbmxqTG45V1I1aHlHSXdiQWNmNW1Q?=
 =?utf-8?B?cHFiZnA4Yk1zb0R3R1Q0SmR5U0d3SUZRNkxPa0x0bzRFRnFhM0p4anM0VGh4?=
 =?utf-8?B?eTZheUtoelVhN0tlSmxpUVNXbVRkcGRvRlZQUkNva3FSWlc3MlJ0eTFLTENn?=
 =?utf-8?B?dE4rUG5ZRTBYblcyaVdPZThveUJjOW42OFRXSy9Dc2JGanJRQ21JUThiZGF5?=
 =?utf-8?B?K2lGSTRKMzl4TnBHWk9DNFNDbXVIWlNUc2xVZFFhdTZpOGJRQis1K0RQSVBi?=
 =?utf-8?B?UUJCdW84bHVaWUNQN0hLWUN3M3hVSnBoVkJVV0NnY2w3YnBCS2lTQUVtemVw?=
 =?utf-8?Q?pkGWLwt7hDJDUst/pFeabUBem+Gc4SeNzO5HUla?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73C54F153A451A43922E397E81C51CE4@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 559740d1-5db2-44bf-32c0-08ddc93df2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 16:36:46.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

DQoNCj4gT24gMjIgSnVsIDIwMjUsIGF0IDEwOjAx4oCvUE0sIEFkaXR5YSBHYXJnIDxnYXJnYWRp
dHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPiANCj4gDQo+IA0KPj4gT24gMjIgSnVsIDIwMjUsIGF0
IDk6MDbigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90ZToNCj4+
IA0KPj4gQWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBsaXZlLmNvbT4gd3JpdGVzOg0KPj4gDQo+
Pj4gQWxzbywgYXMgZmFyIGFzIEIyIGlzIGNvbmNlcm5lZCwgdXNlcnMgY2FuIGFscmVhZHkgZG8g
c29tZXRoaW5nIGxpa2U6DQo+Pj4gDQo+Pj4gZ2l0IGZvcm1hdC1wYXRjaCAtMiBIRUFEIC0tdG89
c29tZW9uZUBleGFtcGxlLmNvbSAtLXN0ZG91dCB8IGdpdCBpbWFwLXNlbmQNCj4+IA0KPj4gSWYg
dGhlIGFib3ZlIGNvbW1hbmQgbGluZSBpcyBzdWZmaWNpZW50IGZvciB1c2VycywgImdpdCBzZW5k
LWVtYWlsIg0KPj4gZG9lcyBub3QgbmVlZCBpdHMgZmVhdHVyZSB0byBkcml2ZSBmb3JtYXQtcGF0
Y2ggYW5kIGRvDQo+PiANCj4+ICAgZ2l0IGZvcm1hdC1wYXRjaCAtbyBvdXRnby8uIC0yIEhFQUQg
JiYNCj4+ICAgZ2l0IHNlbmQtZW1haWwgLS10bz1zb21lb25lQGV4YW1wbGUuY29tIC4vb3V0Z28v
Ki5wYXRjaA0KPj4gDQo+PiBJIHVzZWQgdG8gdGhpbmsgdGhhdCB3YXkgYW5kIEkgd2FzIG5haXZl
IDstKSBCdXQgc3VjaCBhbiBhcmd1bWVudA0KPj4gY29tcGxldGVseSBtaXNzZXMgdGhlIHBvaW50
IG9mIHZhcmlvdXMgc2VuZC1lbWFpbCBvcHRpb25zIHRoYXQgYWxsb3cNCj4+IHRoZSB1c2VyIHRv
IHR3ZWFrIENDOiBsaXN0IHByb2dyYW1hdGljYWxseSwgY29tcG9zZSB0aGUgY292ZXINCj4+IGxl
dHRlciwgZXRjLiwgZG9lc24ndCBpdD8NCj4gDQo+IEhtbSwgeWVzIGl0IGRvZXMsIGJ1dCBpcyB0
aGlzIGZ1bmN0aW9uYWxpdHkgaW4gdGhlIHNjb3BlIG9mIHRoaXMgcGF0Y2g/DQo+IA0KPiBIb25l
c3RseSBpZiB5b3UgY2FuIHVzZSBJTUFQLCB5b3UgY2FuIGFsc28gdXNlIFNNVFAsIHdoaWNoIG1h
a2VzIG1lIHF1ZXN0aW9uIGlmIHdlIHJlYWxseSBuZWVkIHRoaXMgZmVhdHVyZSBvciBub3QuDQoN
CkJ5IOKAnHRoaXMgZmVhdHVyZeKAnSBJIG1lYW4gdGhlIG9uZSB0aGF0IHNlbmRzIGVtYWlscyB0
byBJTUFQIG9ubHkgYnR3Lg0KDQo=
