Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2570199396
	for <git@vger.kernel.org>; Thu, 24 Apr 2025 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466297; cv=fail; b=rdFrD5lJIutIX2bEj7TovCppNksHLLEeEM95YpGqTc6XXGtonWgK615nBtW91AGt4l4uoaZQJW08dqZIl64Ak2c/AFP/sPapXcPNqIBAjrTMaRRxmjabz9lF+OKpT3K96G/gleHvGNWAljxcPqK4aqiwtLtPFZymFBcfOI5a1vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466297; c=relaxed/simple;
	bh=H54YuKBtt/qDv5xA/QQB2E8p6cmphGeZyd6R7Cvues8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ug3AUt5BMNqg1lRXFKM74/kATr49yztngRLe5sMbCnxqzVvm4RT4H49IP+v7uFY0bSkEkHNSQrRR+XoMKeXjztktRhKCWJYgKy2KJ85NeJ1Ud4BghrRtIoTASPzoXrM1VpN3akf4kovKLdht0Wxip0+dAqTjED+qoXjWLEqE76A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bK3GA0Jq; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bK3GA0Jq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gerVpnTwZwPa9bwiz8/PaZRJx8PZYdlB6UI/vLo5I4irJ0M6AaLzpUfS0zhHtPJjTOvN0cNEuAtv6KtREKRPhn+tF53677CAKBATZ/viIxaTXniYxAn3emkVRJbJ3vEbSrpEoDibOsV5KMGLw0YzKa8SueS5xk+6qXNf+lYH0pRVNF4fE3gYiNvyO93zAZRtyuvXJa9FNTyYTnQAKe89oTnslbyxS44/ofTVFxQmcJzgL130s6QCCQpEcTF5V/LXHvlWZrGNr8uN0mXoMoGYvH0vo/aQDquqyt1meR/Jxeqhin0TLSCDEB99M00sWTroBwz1hgbSnsyvYbfrlsIPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H54YuKBtt/qDv5xA/QQB2E8p6cmphGeZyd6R7Cvues8=;
 b=HEjdXf6DiOTe044hxlRrLWId8ReQddlsoKJpIt7IOMI1GnHsdRCOASAr3L4538NNStV9RPCcHPIW15srIx0N/HezfnkWAq4XJgPAylKA3KJ46iuEQPgZZabOixaliDWSXmUCnNj3s23ugmmILfIqBE8Q6hy1MMQURP4enKTqg6/+GcM8o8AquceWNE5r/0FW6zTSFmyHbbLNocN0kcEgAf8cbXCJA3cayybczJ/w7CsxmRsE0UPWbaJelxizImh7uJWXu3DLGmb/KiU9pWz3JLFl0bR2LK0QRhvTFQVxQ6DgaM/qs/qGYWN0sU4VciboZbTRVWDFsWCCf60ng54OPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H54YuKBtt/qDv5xA/QQB2E8p6cmphGeZyd6R7Cvues8=;
 b=bK3GA0JqKdSpx+V69PyZt5b8dUIbzh6QknRTMOmYzAhC+btUqkfaY2XOo48bEwcSHKtvGGjFuqO6UntkxtjLGfkdamFfEYJfr6nuuJVzJ5osKTVAbjOZKV6SiFgEiahrHkI5WH3Ovby/m4meweN28e98SivLHRoT1sDwOQZApQdFqZcDcRDeR5T/dhc9y5D7kjXMx+xef6d6TdpLhEbdcZbzr29k8jJyP9zDVNjzkoMtMpImN92/RabzS64D7hl2pkDN/bF8RRL+yFoYEaPziKfSY2n3OKLiahZDzXnYj54+HmLvD2O/llIJeBri4sF+oO0iJRYKsg1sdi1pJzflHQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9308.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 03:44:51 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Thu, 24 Apr 2025
 03:44:51 +0000
From: Aditya Garg <gargaditya08@live.com>
To: M Hickford <mirth.hickford@gmail.com>
CC: Julian Swagemakers <julian@swagemakers.org>, "git@vger.kernel.org"
	<git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Shengyu Qu
	<wiagn233@outlook.com>, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v4 0/3] send-email: add oauth2 support and fix outlook
 breaking threads
Thread-Topic: [PATCH v4 0/3] send-email: add oauth2 support and fix outlook
 breaking threads
Thread-Index: AQHbtEtQDqngO5A9Pkq9nz5HUnJsMrOxufgAgABz54c=
Date: Thu, 24 Apr 2025 03:44:50 +0000
Message-ID:
 <PN3PR01MB9597F7E2E8CE429D5958C060B8852@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597A83D537E3AE96144227EB8BA2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <CAGJzqsmgPfju6NLU9j9qSnJzdnKerGN4cks-e8JzNBx44A0vOw@mail.gmail.com>
In-Reply-To:
 <CAGJzqsmgPfju6NLU9j9qSnJzdnKerGN4cks-e8JzNBx44A0vOw@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9308:EE_
x-ms-office365-filtering-correlation-id: bfd27a06-193c-4103-d55c-08dd82e25e1e
x-microsoft-antispam:
 BCL:0;ARA:14566002|6072599003|8060799006|19110799003|461199028|8062599003|15080799006|7092599003|4302099013|3412199025|440099028|10035399004|102099032|56899033|1602099012;
x-microsoft-antispam-message-info:
 =?utf-8?B?RkQzaHdLTE45U1RiMWM1dGM5Z3gzdjZIQi9KMVlaYUdkaWJXOFhnRmZrOGNw?=
 =?utf-8?B?NVR0K0JwemJ4b3BhUWkwWnI4SGsvcmUvMklYVk11K3pNaVVHeERIOW4ySDF1?=
 =?utf-8?B?M0IyYzh0bUNoVU9tTXY0dXI2NzA3b0dzNnoxQkNnLzJHYldmcy9WdkZJOHNV?=
 =?utf-8?B?MjZuejdRT2k5SXM1UUxDL1NnS3A2Z0x3dkF3RDk1VnVKdEo4QjZPdFZla29j?=
 =?utf-8?B?S04vbGhSejMxcmxnUlFsRlMzdjlsenRRZ2VuQzVQQWlMYmFpdC9waEZZbXZh?=
 =?utf-8?B?a0V0S1hWWFk3MG40RkdCRG4xcWtXdGpYaG9LRlhsUElYcXRvKy9VKzMzRVh0?=
 =?utf-8?B?OWszYnhnSWsrRzIvSlhlRmMrMnV2UnhZZk56ZU1nNTltRzJXS2ZSRGs1UWls?=
 =?utf-8?B?Z3lOSkhFWTRKYWN5ZW1vNFArTk5OaDh0Y3ZndG5oY2ZGTDRPNGpvckgxMk4x?=
 =?utf-8?B?SzcwdEM2UGpjQWhzR3VrZFZsUmxxd3cxUFdQZlh0TUhKQ3RObEd5OUh6cmg1?=
 =?utf-8?B?UmhHWUN3d0swT1JOaXFRck9vN0Z3Ym1admd3UTNDNHJlOE50V2k4ZlljVVZy?=
 =?utf-8?B?TFdBQW5zMi95cS9mL2xoUHgvS05uSFlPUEtQRE9ySUtiQ0JWVnk2NE05cWUz?=
 =?utf-8?B?Skpsd2tmMHgxV3M2ZFN4ZFByKzNDNXJ6OGpOdHd0UXhCeGtrczZKSlp4a1RC?=
 =?utf-8?B?c2pRbjBXWUdXNWdDYmpuQW5EeE96ZFJvaWVZSmVDWHIrZTNpQ2ZlbXpqN2J3?=
 =?utf-8?B?M2JQVkc2TlIrZ2hqOHhTSGhFb21YS0dYYzlLR3FoZnRzRTh3cjJERzh2QkpW?=
 =?utf-8?B?ZTUrWnJ4QklhQzVkQllQeWN2RVZNdlZ4VnY5OFl6U1FPaWNYVE9lbjlwVThw?=
 =?utf-8?B?UDNBekRUb3VzSnlkN3JlRk82ZEcrK1l1MFlTV05oRXBwWlp3c3k3QnM5SkZD?=
 =?utf-8?B?aDlsQnBhUHZLcEViOFJPRm1zRmUyUWhCUXVZOHFqelZhTVNyR00yVktzU2dQ?=
 =?utf-8?B?UWVZOW1GS2plQlgzYUk1S3ZZdkFuTCtTS0JKbHVxQVFxNGN2Sjc2Q0E4cTNZ?=
 =?utf-8?B?aS8xT3NjQUJ6NVhiNS9uY3FJM2lvcDFtNFdIQ2JueUVuRTFMQU9NVTBSWEVU?=
 =?utf-8?B?S20zeUc0bXN3VFoxakg5R2Z3SURmTUJEYWJuYTBFRVBQYU5Id3BxMTdWV0Q4?=
 =?utf-8?B?R201YThxUEd2YXNmY0VuZFhaSDMyR1FwTUJGcm1oUG81STlOdGhmZVVIR0ht?=
 =?utf-8?B?K2J0VWVYSjBVcmVua2NZWWVhSWk5ZTRIekxqc2Q0Nlh3ZFpJdWJ4amdOc3JH?=
 =?utf-8?B?em1XM0ViQUMrTm1aMk52T0pjTE5MQWhGUWRXemx3MUpPQ3c5bStBWmZyRHk0?=
 =?utf-8?B?VWNmOGg5clhHVHZTYzJHem4wRUxKR3VyOG42OGxPRms3U3JucmY3TFdQcitT?=
 =?utf-8?B?b2xpMHlJMVUxemFSY3hJWTYvV0RVbndmUXlhUnBoVGtkVEFaZjNPL2YwekZk?=
 =?utf-8?B?bmdYNTZyalE4czQ0R3pQazdHOFk4Nmo2Mzc0Y3pRNWM3c3RjS0tjdXA5MkU0?=
 =?utf-8?B?UnZIaGQ1SlRPa0JzN2ZNSWM3bCtRMHVkVnVmZWowTXlrN21CakxsMTg5QnRU?=
 =?utf-8?B?YllKTTdCUkw0OTc0Ukh0TjI5UVJTbFZKcy81ZXNORyt1bXM0Z3RUSUtHVnkw?=
 =?utf-8?Q?h5B+X7LAuEw/B0j7SY3m?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SzlVb2NqSHVGaWNUYXNHbm14b0pPUFU1NFJKR2hjaFVnTjQzZnZRS3l1czJO?=
 =?utf-8?B?UUhzOExWYmJpWkVQTnRTV0cvM3ZHSC9VTDBiZFZ4aXFIc1JFa05GdG1CZmFF?=
 =?utf-8?B?SjlIRTJtRU9LWVlYenhjcEtydjFIK0N1MW1USmJIVFI1RmVwMnFxSTVUbUF2?=
 =?utf-8?B?ZnpHaGd6VVhwRGZpK2pVUkxKbGJZQTc5STE3TnhUMEFNMFBJVEQzaTNmdnUw?=
 =?utf-8?B?M0ZiQmVFRDlINElKV3VJU3BFT1dsU3lncWJUS3FObU5ObWF2aXlaK0pHU0hw?=
 =?utf-8?B?b3RoZE9FcitQSTBFU0N1RDBPOWdxMTlLaFpqV0Jjc3JTcTM4ck50MVd1YzNt?=
 =?utf-8?B?WnY5aWJ0QWlmemNWLzR1VmM1WHQ4Nk9TMWhzdHR6QitMWjN5Z09NekZoNExJ?=
 =?utf-8?B?M0hnWHBjVVFSeHJ6c1IxWFpiTVV2VWRKRVJuZ1ppSnN3MStKRlhXR0QweGp6?=
 =?utf-8?B?TUdVMm9RNzlpcGw1bjdlYmpUb0xDRXhoM3Z3QkxXSTk3SlRCdUwwRmFhTEZz?=
 =?utf-8?B?VWgrK2xuWWMrN0VjQm9IY1dYYWNBbG40K1d2ckF3ZnFYQnhZenpNNEEvUHNB?=
 =?utf-8?B?NWxwNnpUdmpqb0d1cUpaQlRjZDlaaGNsT1Q1Sy92bXFuMytZMzdxUkVCMC9m?=
 =?utf-8?B?aG45TVVIcmk4aGRGTjc5UFltMnJXWDk2WjhSTFYrV29qQllUSGJ6eVNZNzFL?=
 =?utf-8?B?UlRpemtveDlROGUvY1AzNGlEVHR4SlNXS3IyYlM5WS84c3NkbVN4dGtIdGhh?=
 =?utf-8?B?OCtCZ0Q3a0VYdUFFOTQvK3Uwa2JpN2dwanhiL20wUEZmT2tKMExxUHdic1ls?=
 =?utf-8?B?WjBOR1VjYUtmWDNGb0tycEltNnFqakZ6QkN1eTZ6Nkc4eDR3Snc1eVJ1QlBH?=
 =?utf-8?B?SlVPS21MSUgwNncvVDlyTU1ocEhUSVRraEVEaHRYeDUzQUNnMmIxb2p0ZTYx?=
 =?utf-8?B?V1JKVU0wWTBnS2liY3B5ZXErUy9RUksyMVZPc2ROV2F4MldzcHFOZ1FwOWo5?=
 =?utf-8?B?NXR0Vi9pcEdDejVpSUJ5TGJZb3V5RE1pTVhCVVFmVmw5bHQ3bDVieERsYXR6?=
 =?utf-8?B?Nk9BazBHOVBlMFQ4aDB0YllNa3Q0UTZQVm1qZlowbURqdEpsOFBKQlZYVXgw?=
 =?utf-8?B?c2NOTVFHcFp2RVY3TVNnYmNLRkRQQ1NGVzJ3dUx1NGYvTDZ2TjdMazNEWWhv?=
 =?utf-8?B?WmYrZWl1NE44clRvd1VBZUpJbG5xNythRklMZitPS1h5QTZkb2hnNm16NzUw?=
 =?utf-8?B?NmxoM0U1eUFSelNXaXJ3Sm1nVWlzejB3RFN5TXBuZlFGOTZ0YnVPWkhXZ0xm?=
 =?utf-8?B?UWlTcHVsVVkvN1FJTDRSbjd1ak9PekV0UHlkM3k2Um8zK1N1eDUxYTE3UkEy?=
 =?utf-8?B?dGg5emVCN09Yams0cDA1TGZVRnpPdk5TWjdzWnVSS28yVFBVempoYkxZSFlX?=
 =?utf-8?B?OXdkaGl1QUhVUTFlbEl0bFZZNnZzaHllRlpUMDFNYWtVZGhEcnljeGVpbk5C?=
 =?utf-8?B?aXI3WFRycHRIL0RWbm8xemw4bUR0dDExM2xIU2JEKytuVlJuTVMrTzU1b1Ix?=
 =?utf-8?B?ei9SdHFIdk5pN29BWGlvaE9rM3JCSS95d1ZVV3Q0ZGdBY3IyNU03MkpFMEFy?=
 =?utf-8?Q?zR8y3IERfrkuptdQZ1+fI+p9YAM/F/ZAv8MffnLdNbU8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd27a06-193c-4103-d55c-08dd82e25e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2025 03:44:50.9254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9308

DQoNCj4gT24gMjQgQXByIDIwMjUsIGF0IDI6MjDigK9BTSwgTSBIaWNrZm9yZCA8bWlydGguaGlj
a2ZvcmRAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IO+7v09uIFdlZCwgMjMgQXByIDIwMjUgYXQg
MTM6MjksIEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyb3RlOg0KPj4gVGhp
cyBwYXRjaCBzZXJpZXMgaW5jbHVkZXMgdGhyZWUgY2hhbmdlczoNCj4+IA0KPj4gMS4gSXQgYWRk
cyBzdXBwb3J0IGZvciBPYXV0aDIgYXV0aGVudGljYXRpb24sIHdoaWNoIGlzIG5vdyBjb21wdWxz
b3J5IGJ5IE1pY3Jvc29mdC4NCj4+ICAgVGhpcyBwYXRjaCBoYXMgYmVlbiByZWJhc2VkIHRvIHRo
ZSBsYXRlc3QgdmVyc2lvbiBmcm9tIHRoZSBvcmlnaW5hbCB2ZXJzaW9uDQo+PiAgIGF0IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2dpdC8yMDI1MDEyNTE5MDEzMS40ODcxNy0xLWp1bGlhbkBzd2Fn
ZW1ha2Vycy5vcmcvDQo+IA0KPiBGYW50YXN0aWMhDQo+IA0KPj4gQlRXLCBJIGFtIHNlbmRpbmcg
dGhpcyBzZXJpZXMgdXNpbmcgdGhlIHBhdGNoZWQgc2VuZC1lbWFpbCBieSB0aGVzZSBwYXRjaGVz
IGZyb20NCj4+IE91dGxvb2shDQo+IA0KPiBOaWNlLiBJIG5vdGljZSB0aGF0IHBhdGNoIHY0IGlz
IGEgc2VwYXJhdGUgdGhyZWFkIGZyb20gcGF0Y2ggdjMuIEFueSBpZGVhIHdoeT8NCg0KSSBqdXN0
IGRpZG4ndCBrbm93IEkgaGFkIHRvIG1ha2UgdGhlbSBhcyBhIHBhcnQgb2YgdGhlIHNhbWUgdGhy
ZWFkLiBJdCdzIG15IGZpcnN0DQp0aW1lIGNvbnRyaWJ1dGluZyB0byBnaXQuIEkndmUgb25seSBj
b250cmlidXRlZCB0byB0aGUgTGludXgga2VybmVsIGJlZm9yZSwgd2hlcmUNCnRoZXJlIGlzbid0
IGFueSBoYXJkIGFuZCBmYXN0IHJ1bGUgdG8ga2VlcCBuZXdlciB2ZXJzaW9ucyBpbiB0aGUgc2Ft
ZSB0aHJlYWQuDQoNCj4gSWRlYWxseSBhbGwgdXBkYXRlcyB3b3VsZCBiZWxvbmcgdG8gdGhlIHNh
bWUgdGhyZWFkLCBhcyBhdA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9naXQvMjAyNTA0MjAt
NTA1LXdpcmUtdXAtc3BhcnNlLXZpYS1tZXNvbi12NC0wLTY2ZTE0MTM0ZTgyMkBnbWFpbC5jb20v
I3JlbGF0ZWQNCg==
