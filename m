Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010013.outbound.protection.outlook.com [52.103.68.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB7A4A0F
	for <git@vger.kernel.org>; Sat, 24 May 2025 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748055445; cv=fail; b=Tw1l7kUNqUbbN01U9F4d073XunRis6t9stHc7Hnrn1pGZcC1J69muunbveSKjaSzBEiU3PNPDalsaUXRxXLDCN0A3PSKtnLSpnMzbCINU1R2AsEZd9FLuDniOuQAwyFGMyTHM47Q8II4llc7a5MN+dqVKqzQyKNM0CuEjy4oClM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748055445; c=relaxed/simple;
	bh=RhkxLEMtzCBIuYxswrINPp5wwJXAo6oBOmqGXmyXdcY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=AxUlpUaA035qFfciSMugQhxhEC3FTn6yS5/cVWHrK29Frtfx2WQZjFDkea2ID14JOqIxEDIRtf3aB3IRW3azAR5DrMYOyNT31NEoUgDGvF5jysVeNerwZ3mIpx5De0UkyRFSfWqZIB7t5xa49okIfZQnNh67Z7Qu6CWYWL+ysq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mkHMDU63; arc=fail smtp.client-ip=52.103.68.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mkHMDU63"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CePiuyUMI/TNjOCi77DZ/r7KjWayeFK8O080Ev4s6+/phCaCr/roFS5V/QXfQWfNtJSrcx7a+aGBPL2g870JdY64V12ku5N/cXKvg3fCAJjudzsSmL7epB4SY0Rv1xngv+4RJSeGoZ7BkUZycYZKDD5GMluwq8HDfg6Z6A8pafJNBSLBnaWUlJLF/Eaaiz13hiH2LAHfNYV+abkOJOWa5jZOehp3uOJIv8rSCjTq8yVaSUYTcYpuNY2Psr48SOVxUXNKah5vWRRyaPdHwstoPp+bvjSR4uCSWaYA/7p5LUMsA4e5+LNsR/KFMRWfrtVk7b5Hv0OZIkelfHFQbE8dgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhkxLEMtzCBIuYxswrINPp5wwJXAo6oBOmqGXmyXdcY=;
 b=qxrgfc3jQ0R91JZHcwNmtGlIFNs3tNl+BGeexm6k3lbm5e8seJduZmdSdHpVW4R9taQvGFGCaxOPjhcsr9b5yWcyj50wOvFJWaHVDyenIhcBcSsbnad2goEGcT3GwbHBrj/kAjAPF95T0VaDAHQGXwsfc3UOzEJUSrrviZ1y0GVzpU9lDO+BO3S00/dXe/fcytT6nmUvsasY7ARUCvUUkr6l6uYWzupN5yNGvw9jCArdUd9lM+6z/ZL0YMoQJoUk8xHIVeuAvNiN3AEjpPJnJYfh/hcLxy7MA2QGvD/pn5lD+qTj+UzWtB9zLdBdd7ecbqcCUaqVRAL4ilCEVWkrVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RhkxLEMtzCBIuYxswrINPp5wwJXAo6oBOmqGXmyXdcY=;
 b=mkHMDU63w09WQqPBrHNmNBk4nG8qReyVzYbVaDhMR2xuTFbUNA24a3F8OQrWuP36SUuF6KOo6GjNVt1U9TAAZnuODRMURBnDLvaq3tHTZGMwUA2WPW0x8JCjoqS9j+BCn6n0zgzWQOsvYFcIRgNf+AzT8XT52YWIXvMld/mHb6chP7Yz2VlD9AKjIYSaEBmVhFiUZZ7BUjLF/AUT4qQthXAgpTGDM4ObF4lKRy5tZAt+9uqXlyLWgOnST5YyZjVPTCzsdH51EECW+quPIguno4HKSeygvTiLDr6XNUC5K4SMEMrOhZsbOasQLYWtdDTiTyYfe6TNS82hV4q0+ArwaQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7901.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sat, 24 May
 2025 02:57:17 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.022; Sat, 24 May 2025
 02:57:17 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Eric Sunshine <sunshine@sunshineco.com>, "brian m.
 carlson" <sandals@crustytoothpaste.net>, Julian Swagemakers
	<julian@swagemakers.org>, Zi Yao <ziyao@disroot.org>, Jeff King
	<peff@peff.net>
Subject: Re: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Topic: [PATCH] send-email: fix bug breaking shallow threading if the
 first patch is edited
Thread-Index: AQHbzFePHx4PliBicEGPVwfxbO+Nnw==
Date: Sat, 24 May 2025 02:57:17 +0000
Message-ID:
 <PN3PR01MB9597B280D9FD284E1B097380B89BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7901:EE_
x-ms-office365-filtering-correlation-id: c19cf0c2-e910-47b9-5a32-08dd9a6eb1f7
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|461199028|19110799006|15080799009|8062599006|8060799009|7092599006|6072599003|4295299021|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?NVpGdzgxaFg5cWFKUDJabStqYW5jSVdLaEVwQWczN1BDNUhieGhsZml3L2RX?=
 =?utf-8?B?NGpFcnVqemZtZWYrL0ZOMTloVXdLbEc5RjFrOWttZVk4NDZaMytEK0ZNaWtN?=
 =?utf-8?B?T0Z2RE93KzhwdGVDTWIwVHBSWTRBZi9HeFVkK0UyelNiOXNWUVpRU3lLbzIy?=
 =?utf-8?B?YzdVYllmeVRselRiTnc2ZVQvOURURU01THRIV29qQ2Jnc1A5WE1JVzMrZExz?=
 =?utf-8?B?dFEraUxCUDY1cy9GT1h2UTZQZ3FXQU4vbWNnd0U5eFN5OXFrS2NsNjFJTGta?=
 =?utf-8?B?cVFHMWpPUTNGZGZhUFJPby8rZ2MrVWxvNm1uVE44WXpHYlg4Ym42SlFoaFhF?=
 =?utf-8?B?M1V2ejNYRVJTOVllVExaWlgreTNqQlBZend5em8vMkRhdldqVFc1dytGTk40?=
 =?utf-8?B?V2g5dGVDbjgwMk45V09kK2lhT1AyTTNBWjRKSTBJRG1HcU14VU1jemppMndk?=
 =?utf-8?B?S3FjdVlIdjM2N1MxV0ZWaGgzQ29WSEhxL3d2SC9QdUpJcDhuVGpvb1ZNejNj?=
 =?utf-8?B?bm82NkYyYi9wdEZBQlRxbVdxN3c5Nk0yL1dTMTZMSkpQRUF2S1JlWnJWbnZx?=
 =?utf-8?B?a2pvQk1qSGNyYi9MNU1mL1lMQzk2RHh6VlF4Qk91UzllYmRMZVZLVVBDVzJT?=
 =?utf-8?B?M3dUdTIrbmtMdUs5ZDlIWCszWm9PZmNzNllQeXhTNGRkZlRHckpDd0FUYWhY?=
 =?utf-8?B?VGdvWXFTWlRBYkJGcnVWVlFPVmNVZWJ1SkZrQ0xWUzc5c253bUhwbFpHdWI1?=
 =?utf-8?B?WUhDdmI2ZU9xYjM2TTdOSk1xc0Rhbis4YzlJMExoTFpmbWJSanY0QlNNTTJq?=
 =?utf-8?B?TmJBNGdtdEtTT0R0RjRmczNoeW1KV25mbmVQa0x6cmx6OFRpYjlhcEloQ2s4?=
 =?utf-8?B?OUtDZGE3ZlAxWC9FQkV3TkhyZVpIdzVlbEFRSFRxTEJiQkphNmNPeDNIRjJn?=
 =?utf-8?B?NG1wNGQwOUV0MmtwclJScDVKWENSQ3AydjRiS0Y0L0R5MjdLTHNoWnBlM3J6?=
 =?utf-8?B?NzZ6aGtxOXFubnhKWGxwQVAxdXJOdkxYUzZQOS84VzRLNHROa3dmSnF1eDVZ?=
 =?utf-8?B?czd6NHdEUFh4eHR1Y3dxYUtvU1BKOG5IWVVoREQ1cFpJeUN5ZDJ1eWQ3dTZE?=
 =?utf-8?B?c0FJOEZCWWZpb0lFL3VXNi9Jc2xmTTBtb0lXRWV3a1NDcXBCeFE4S2xpODNJ?=
 =?utf-8?B?b21Vb0wvWlJGWVVaN0V2dHJiYXExSHhGSkFEaGFFN1l3UmRZNGdMRzdDVUI1?=
 =?utf-8?B?QVVvY0k0a1VIdXd6K1hiR0VBRk13KzNrdERBNTRMTUlxSDF2bUhMQjdUMlFa?=
 =?utf-8?B?Ym9NNHRJMHlETFJBcW9JWXduTlpMOTg4eWxYY2ZQVzFEOEtqdHFNcXZ2QW1D?=
 =?utf-8?B?TVFtb0JFV0F5WVExd09PdWl6NWxpRjdrdUpIbUI5ZXQvWXVLTFU0YmUzd28y?=
 =?utf-8?B?dGg0U0cwWE9DYXM3KzMyUVRNOGdCbFU4bVNhbXU1ckF5akcrbWxGVHZ4YVZ5?=
 =?utf-8?B?RENUODdRMjJVSWFNLzkxU1lsVGtqM3k5aFptZnlUMGc3RlJ4S2poeFoxSlJ6?=
 =?utf-8?Q?tUj1b1izaJFYjCQ4u1PGXcWW0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VzdQbnpqSG14OGtGS3hSK2FoaU82ZkpSQ3pHR2pla283UEJlTWdBQ0JqU1hV?=
 =?utf-8?B?NjZDMHFud3lrYVcxOEw0UlBjVElqVERYRVlGdDg5VTFaUmR1Nmx0UXhSM1NJ?=
 =?utf-8?B?WktaNFVNamNnZUlPMTJRQUJvZE5iMFNsU2plelhtaFZ4Nmo4cXVPWWRKVnFO?=
 =?utf-8?B?MXd0d0hyYzg5ekIwUHp0SktiY2xaM0dUWlIvd0hSZU1icU9hYVMwTGVabDdB?=
 =?utf-8?B?YnN0MnNKWGZTZHF5N3RIOGN2TFd5QzhYRWFNMkQ4bXRaTFRWQU5TSXVhMitn?=
 =?utf-8?B?ZVBmdWpWNEZ3R3FIdU43eURkZFVxNjd3a3VBcmRkODFIMnZZY2xxU2lienZu?=
 =?utf-8?B?eFVEcldGME1OVEJPMG4zbVlMOVM3THZOL2lEanR4ZWx6VGNkdVdmamJvWTlT?=
 =?utf-8?B?MkZKbjlHN2ZaVXpoN2dBWU9zUTNqeW1ieG52bld0aXNrdTRhQWpRWmUwdTJX?=
 =?utf-8?B?S0RKQW83dnB0QkpsR1VxclIrRWo5c1ZxRDBKbC9GdFlwR2wxTExpNEtEUjli?=
 =?utf-8?B?UUlBeFJOa0NFMXlJWGc2OXJhc2J6Zi9nZ2wxbXRLU1ZHcGN5Wm82YlBRSmhy?=
 =?utf-8?B?N2VyUWUvNC84VC81VlRGUThNY2hJTHhCdjZjOTRrV1JDbkNGZnI4ZHFVdUE1?=
 =?utf-8?B?VVM2U1QrQTVzQjk2VUF4YjJBaG9CUFpsZDdrcmNEWnlad2tkRXVhVDhuRXMv?=
 =?utf-8?B?ajFzdDdQWjVxaVdYQkpxQTQ2cVhkb2sxTEZxWHdOMk5YUFhSWWsxL2NMY1Z2?=
 =?utf-8?B?OXQ4VXB5NkhvZFZUbnNCTXRuM0hXN3EvaENXUm9rSzJEaXI1TktQNDdmd05W?=
 =?utf-8?B?MzIvU0hyMTFZbEREQTNLRjQrMFVEWGl3QllvbEFMc0oyYmdzc1NaUlg5bUJ1?=
 =?utf-8?B?SnFvNE5SandqZVMwcnpYUHJ1SkFlSEFSdnFPMXd2enRaRmFSWG5sNDFUbUw5?=
 =?utf-8?B?SHI0WUFEY2N1RzFDc1pXbCt4cm9pUmtiV2NhdWd5azlLa2hsaWNQb0RZS09X?=
 =?utf-8?B?TlR4U00ydU1zd1R6QTVudDQxYnd3ZlRjN3ZRYWp3N0pOSkVpV3ZuRk9PTVBy?=
 =?utf-8?B?REdFK0NIVGY5VEIrQVduUzF5Rlg4Uy80UVlpSHRCUGVvYk9HY0dodVM3Tmhu?=
 =?utf-8?B?aklteXJVcVZpYnBhb3NvL0RoV21EdXY1bkw4bjBONHBoVEtPYlB2eHlaZ0dZ?=
 =?utf-8?B?RnZMSFNWYkFyTGdYQmRvenZTRUt1bUxWd1lSRFR4bTkxNzV2QmQrcGgzeEpC?=
 =?utf-8?B?OWVUQVBHNndURElBSmxZSzhQR1duWS9JYWZnMjkwQWJOWVNqeGFxOFladDht?=
 =?utf-8?B?MW1HcU1yK1ZuTlFETkhiVXlhYlQ2ZkFTZVUzVEJUTzhORk14V3dBTGI1RTlR?=
 =?utf-8?B?UkUwcjZ2MFFlc0t4akdubnExTHQwUGNIQW1zbU05OWxsUTc4eWRzaUd4QmxK?=
 =?utf-8?B?VjRGcWJ6aWZLeDdZc1M1N3FHak1RUmM2dkhlSGlSTVY0R3hjeDM1SjVnN2tt?=
 =?utf-8?B?d2JQUC9ITVlzUjdpeTFZN0NSYkZJc3NGcFdoYmkxKzlFL3ppa0VqU0dvMXh1?=
 =?utf-8?B?Nk9VMnNrSDdEVi9Pby9GdHdHQ2xSU3BuK1BFTXhDT1o0azlEV1BIK1N2ZjVi?=
 =?utf-8?Q?OhDU977Z5A7AWfIQKKj7jgJRuuQj3vtr/Fl9lAY69uIc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID:
 <68221F03A6C0664EB4BA70243B0E96A2@sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c19cf0c2-e910-47b9-5a32-08dd9a6eb1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2025 02:57:17.9022
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7901

DQoNCj4gT24gMjQgTWF5IDIwMjUsIGF0IDU6MDjigK9BTSwgSmFjb2IgS2VsbGVyIDxqYWNvYi5l
LmtlbGxlckBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IA0KPj4gT24gNS8yMy8yMDI1
IDg6MzYgQU0sIEFkaXR5YSBHYXJnIHdyb3RlOg0KPj4gVGhlcmUgaXMgYSBidWcgaW4gc2VuZC1l
bWFpbCB0aGF0IHR1cm5zIG9mZiBzaGFsbG93IHRocmVhZGluZyBpZg0KPj4gc29tZSBzcGVjaWFs
IGNvbmRpdGlvbnMgYXJlIHRoZXJlLiBUaG9zZSBjb25kaXRpb25zIGFyZToNCj4+IA0KPj4gMS4g
QW4gLS1pbi1yZXBseS10byBtdXN0IGJlIHNwZWNpZmllZCB3aGVuIHNlbmRpbmcgdGhlIHBhdGNo
DQo+PiAyLiBXaGVuIGFza2VkIGZvciBjb25maXJtYXRpb24gYmVmb3JlIHNlbmRpbmcgdGhlIGZp
cnN0IHBhdGNoLCB0aGUNCj4+ICB1c2VyIG11c3QgZWRpdCB0aGUgcGF0Y2ggKHByZXNzaW5nIGUg
YW5kIGVudGVyKS4NCj4+IA0KPj4gSWYgdGhlc2UgdHdvIGNvbmRpdGlvbnMgYXJlIGZ1bGZpbGxl
ZCwgdGhlIHRocmVhZGluZyB3aWxsIHR1cm4gb2ZmDQo+PiBhbmQgYWxsIHN1YnNlcXVlbnQgbWVz
c2FnZXMgd2lsbCBiZWNvbWUgYXMgcmVwbGllcyB0byB0aGUNCj4+IE1lc3NhZ2UtSUQgc2V0IGlu
IC0taW4tcmVwbHktdG8sIHJhdGhlciB0aGFuIGJlY29taW5nIHJlcGxpZXMgdG8NCj4+IHRoZSBm
aXJzdCBwYXRjaC4NCj4+IA0KPj4gVGhlIGNhdXNlIG9mIHRoaXMgYnVnIHdhcyB2ZXJ5IHNpbXBs
ZS4gVGhlcmUgYXJlIG1hbnkgY29uZGl0aW9ucw0KPj4gdGhhdCBkZXRlcm1pbmUgd2hldGhlciB0
aHJlYWRpbmcgc2hvdWxkIGJlIGRvbmUgb3Igbm90LiBUaGUNCj4+IHJlbGV2YW50IG9uZXMgZm9y
IHRoaXMgY2FzZSBhcmU6DQo+PiANCj4+IDEuIC0taW4tcmVwbHktdG8gaXMgbm90IGRlZmluZWQN
Cj4+IDIuICRtZXNzYWdlX251bSBpcyAxDQo+PiANCj4+IElmIEFOWSBPTkUgb2YgdGhlc2UgaXMg
ZnVsZmlsbGVkLCB0aHJlYWRpbmcgd2lsbCBvY2N1ci4gTm93LCBpbg0KPj4gb3VyIGNhc2UsIHdl
IGhhdmUgZGVmaW5lZCBhbiAtLWluLXJlcGx5LXRvLCBzbyBjb25kaXRpb24gMSBpcw0KPj4gbm90
IGZ1bGZpbGxlZCwgYW5kIHRodXMgaXMgb21pdHRlZCBvdXQuIFRoZSBvbmx5IGNvbmRpdGlvbiB0
aGF0DQo+PiBjYW4gZW5hYmxlIHRocmVhZGluZyBpcyAkbWVzc2FnZV9udW0gYmVpbmcgMS4gQXMg
ZmFyIGFzIEkNCj4+IHVuZGVyc3RhbmQsIHRoaXMgY29uZGl0aW9uIHdhcyBiYXNlZCBvbiB0aGUg
YXNzdW1wdGlvbiB0aGF0IHRoZQ0KPj4gZmlyc3QgbWVzc2FnZSBiZWluZyBzZW5kIHdpbGwgaGF2
ZSAkbWVzc2FnZV9udW0gYXMgMSwgc2luY2UgaW4NCj4+IGNhc2Ugb2Ygc2hhbGxvdyB0aHJlYWRz
LCB3ZSBqdXN0IHNldCBpbi1yZXBseS10byBvbmx5IGZvciB0aGUNCj4+IE1lc3NhZ2UtSUQgb2Yg
dGhlIGZpcnN0IHBhdGNoIHNlbnQuIEJ1dCwgaW4gY2FzZSB3ZSBlZGl0IGEgcGF0Y2gsDQo+PiBp
dHMgJG1lc3NhZ2VfbnVtIGluY3JlYXNlcyBieSBvbmUsIGFuZCB0aHVzLCBvdXIgc2Vjb25kIGNv
bmRpdGlvbg0KPj4gZm9yIHRocmVhZGluZyBpcyBhbHNvIG5vdCBmdWxmaWxsZWQsIHRodXMgdHVy
bmluZyBvZmYgdGhyZWFkaW5nLg0KPj4gDQo+IA0KPiBXaHkgZG9lcyBlZGl0aW5nIGEgbWVzc2Fn
ZSBjaGFuZ2UgdGhlIG1lc3NhZ2VfbnVtPz8/IFRoYXQgZmVlbHMgbGlrZSB0aGUNCj4gcmVhbCBi
dWcgdG8gbWUuLg0KDQpJIHRob3VnaHQgdGhhdCB3YXMgaW50ZW5kZWQsIG5vdCBpdCBkb2Vzbid0
IHNlZW0gbGlrZSB0aGF0IHRvIG1lLg0K
