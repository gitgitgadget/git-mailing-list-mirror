Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010014.outbound.protection.outlook.com [52.103.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C8621D59B
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495770; cv=fail; b=EZposK1aUkVqKfPPO2wo/ktP453mHcBc75kVBdZ+6V62EvJ6kXe2ldEVBj/hspAgnw6D9af2R/t5N3FV2MHpQcz2DbPn/WNmNbJkvUcMV9VkUsvdd23RqUI5Ngv/fFTXsYgFGG+YX9/nNKRzJmJuhv8iE0cE68PWky49jc9Jr8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495770; c=relaxed/simple;
	bh=tcyVG2T6z+30HXs8FqApHB28qRXKShN8/isgDWeH4HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lY5HkNocI4334X+NIDu6zps+7PVvYAwTWFVy4f6kHdFaCRALLUnPqfTb32I6XT2IimaHsSQ5BaY5nbkskr3+TTjOK5xvrclpgIEd8aN/7W+Z7s9yU2LNLUpOHQ3anZqdKpfpH2mtspbGRkhnZgtbjmbH8l+Fm85gTVqmwk7OPtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hob/azuq; arc=fail smtp.client-ip=52.103.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hob/azuq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2DEXZ7NkvKb0lAvJVMFZveBha93HdqdNZkX0qfWt2f6thTNub2NsooNzA7gBTofiChpvjFuJ0rF1ZP0Af3x9TbJpHDn+O9yzFmmBJJQG0CfMfywgc7eVYhRuM7xAzhBrFInEEOuU+NeBTKBfXqRGsI+QymnVhqlZFE285cSF3WDJ85A37CG3xfY3JUtgHVKKpETlGw9vmZie+TbIaJFbltS6BpcS+J37tT+goj6Iptjga8k/d0CgiWpg8+f9FGqVVE5A3nQE9lO2fwjDmwrc5QT33XAoA6jmgxsRnpD9VtgRU0h/YmQ4U4IG7onHYa/vzHx8/CqRGpm7NeMqlkn3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcyVG2T6z+30HXs8FqApHB28qRXKShN8/isgDWeH4HQ=;
 b=UnlBhnIyoiIe/QiIDGwMyefSqu3QNixye8vHqNC9z5BO3qAkHo4fG/bBYNc/GZ9C23LfFbnE/Qf73k+5MMB9NRSl/215ZzbYGb7VpFpZKStgjG9qALG6qJ6eVk7YIfz+PMs5zSpFVEmG1yQXOneTW+DpuVTK4VqTX621RVzXrH+cFqtOnb9rhUJ3urdHp/xDnbUw2Evrq8mEL5D3YrrUZBH/mQmgJ5EEQQAEYr3s+8S0sDfClSRAcfXPvAN5ZbSD3dHzVL0twnSTBBChyF4g3hzrLxzU8GA/pvMiGPcgOMLCb7raI07eq4eVl1h5X+0O2nbldw6735SbZRE4YMEY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcyVG2T6z+30HXs8FqApHB28qRXKShN8/isgDWeH4HQ=;
 b=hob/azuq67sRPrHPHYA6wD74DChOWlpDxW0s0rdo9UjLIL95RVWV6kb6Koxx4X7KbX2Tw23BTQVfTd43vRLN3hHYJBSqTOmFpqNWBMa5pC+qf8dbt0kKOAwM24ezt1FqOfAJUoUFEtZsU/tV2uz7x+Jhr/hKqRDEW6jUUOnKwAe8xEGFScV/Oz/Yn/RPIYFlPUDc/I3qOmBNNE6CeO1NVGWmBZxZ8kUleX8QMVHMr0RaVS0L8O6vDQGrCAfCvCZe5ReJWZ/R0OeDVMxMj8LUACcvQJRAI5REUIU9C2k4jnTOXzpZesfV7st99+MSdxRROP3EyrHqGgp3uu7oYxOVbQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB10329.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.27; Mon, 9 Jun
 2025 19:02:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 19:02:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v16 08/10] imap-send: display port alongwith host when git
 credential is invoked
Thread-Topic: [PATCH v16 08/10] imap-send: display port alongwith host when
 git credential is invoked
Thread-Index: AQHb2Q8m/bU/mfD1LUWjLHTmvnLqt7P7LjmdgAABz7g=
Date: Mon, 9 Jun 2025 19:02:43 +0000
Message-ID:
 <PN3PR01MB959765D8A6621F155F7C756FB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AF90BA3D4B3295ECC278B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq8qm0rbgo.fsf@gitster.g>
In-Reply-To: <xmqq8qm0rbgo.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB10329:EE_
x-ms-office365-filtering-correlation-id: dca41f85-e813-4f60-3bce-08dda78836e2
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|15080799009|6072599003|7092599006|8062599006|8060799009|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?QVhOUjRkN1ZlRHo3Y2NjaEYxOTVBZDZPRkJ2SjZyeWMzTldzbkRUVUplWXRm?=
 =?utf-8?B?TlNoZFh3bFNwcC81eEM1Z3pONDhuL0R6c1lPbUZpdzJRSUtBQml5RG5nUHpN?=
 =?utf-8?B?YU8wdFZhckxhREMrN25DZ1A4QnR2ZmQzcGRPbWJXYWVxU1JjWHNRRW1JVVBu?=
 =?utf-8?B?Q1VvdnFXcHZEQTkyQUZJZ2cvYitlek4yUkF4UXlUeUFjdWRqSk40akhEMFRh?=
 =?utf-8?B?N3I3R3pFYVZiamdmcGdzaWtlTXZmZXR6RytQcGhuc1N5QnNwSExtczBKVTZD?=
 =?utf-8?B?SzBnMDJWbVhWZ0hYMmQvUkxLSHcxSFBWejV1c0lhb1A1eDcwZC9VR3pEWHVa?=
 =?utf-8?B?SDU1eWhnRFB2TDlSTGlpQnlCTE9aQXJWUm0vaDYyZEw3WnNrWXFwTTB1cmVI?=
 =?utf-8?B?VDVVVTM3TklDMGhUZVhIaGlyOUlYVFp6WVVrNDVmTkptT1EzcXB0anRtSXVs?=
 =?utf-8?B?TVQrcFlZMkVuNnYwckVXQnpnUmFjZTRvT3BPN21MWHYyd080VnNWT1kzUlRD?=
 =?utf-8?B?TjhuWXpuQkxtSDAwMWFWcnM3TFh6ME5pNDQyQndPUXdDZm1qcGpaampmckNj?=
 =?utf-8?B?SERzS2dkaUFSUWlTSFplalZuNUZ4WCtnaFlaK1FZMWFGRThVNlRPM3Z5Rkgz?=
 =?utf-8?B?WG1KV0VwRFNCUHQzT2FnMXBBbGtKNmFLNWVhcm5ickl6ZFNTZXRuYVhHcGwv?=
 =?utf-8?B?dDhULyt2VExkZWRxREVuSEZMRTZCeEpkK2tzYWtYUEEyNnNJSVpGNUhHVFQ1?=
 =?utf-8?B?c1dLMnB0VVZzamE3cGY3V2k3Y2pRZjFmanM3QSs2MWh4NkFhVnVHWlBuVERy?=
 =?utf-8?B?T01UZ3FkcmRvdFR0cThEKzFVN2xjZWlJTktxeXgvK0NRRW92cGdDcUpxQnAy?=
 =?utf-8?B?QUtsbldacXk2WlhXUkJ6aTVzU3R1U2J1UGFyRWxyVFBHOXl4ek9reHoxYkxK?=
 =?utf-8?B?cThqVElsUWFWR2JvWUhvdldkSGVrdlI2UkNaTGFZUEZCNWYxK2hoTTI5UlFY?=
 =?utf-8?B?Z3k1a1ZSUkZkWDBNRkdWZWhaRHBXcDVvMncxUlFMNE50Skx4QXZ0TlJPaHpw?=
 =?utf-8?B?T08vNGV4UkVMaTBoeWtBeHI1eE5TSTUxaG41VmhRVDduc0J3L3pPenM0eG1t?=
 =?utf-8?B?WmtLcWhPWXFiZmM1YTJhUVNGSzJuYUVRNFVBRnNMc1RXNVRVRktjVzBZdEVz?=
 =?utf-8?B?cGtUakJNZTRoT21wNDBlWllXUWRYVUxTdGJoTzd0SEUveWE3M0JNT0RKR1d6?=
 =?utf-8?B?WWI5K1hvSmVxOFRhK1k0UVMzOElCUU1zM1ozaHFEWExDR3psTmJyZFNITE84?=
 =?utf-8?B?eDU4WUoyQUpmTmRJUUJodUhQYXovcGdSME52cFQ1UERtOTdFMVFxMkl4ZmVp?=
 =?utf-8?B?ZzErSjZ6RHRveXYyZG1aL2I5aWJhZSttQWovb0QvK0tieE55clV2N2Y0cFdz?=
 =?utf-8?B?dVBNdWt5YWZSMlAzSnlSYWV5a0hGSGZoaG1HTERrNnFiOE1ZSm4xMDQ4STlP?=
 =?utf-8?B?M29NZ1ZpN1l5aHlFU3dLTFFuclBpUGRib3ZTRkNlcSt6VWo0dlUxZVJJa29I?=
 =?utf-8?B?ZU9QZz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SEZLY1R1WWtibWR4THdNZWJIYStTV21zTS9ya0V1Qm9hKzNQR1N5UTRtZkt2?=
 =?utf-8?B?UENKb1dvek5hSzlXMFpaOU1lWi9Ta3NmdTQyTkY1Q0NnOU9HN3lSNzhaRklt?=
 =?utf-8?B?Zmt3eWhxaGovazBNSm5BamEwUE1qOThDR1hQTnhiakdHU1JqNXFYMFdwQ3N6?=
 =?utf-8?B?VU5FU0xkTE9rQnpGa1dVN3JiTW9lN1NDMnJvdFF3TldGemRReGhSSy9rZENL?=
 =?utf-8?B?YTlLcWlpZmgxUnJWUzRXYUxjOWtpZ1MyNEozSmlzNTZSYWdJbmhpN0RtaHFn?=
 =?utf-8?B?SmJtanVLN212RDdRWkhpZFhIYVlUZHRzaWlBVTF3OFUxVDlQc2piTDA0TWlF?=
 =?utf-8?B?LzdLd0RWZjdtbERITk1ycXJLTUlMWmU1aHdWNzdXeXRtU2lpM1plamFmeTVJ?=
 =?utf-8?B?WURpNW9XM1BoVDZ2TmEzUER2Rlo2Tjdva09uTVAxVFc5b2lERDQvbXVtUnlO?=
 =?utf-8?B?MndqcUFlSmE2UTRZMTdIVTNlV01ZNm1ueDJkRjFYVkM0WDlPamY0aEgvdUdO?=
 =?utf-8?B?ZEVmSE9XZVpNL20rVGx5ZHdUMnpQaFlmZXFENXFtQTVGckFzT1lMbUNlVkhy?=
 =?utf-8?B?cFBaU01UVW9ZVkxRZ3lxRklOai8vZGF4U1MyN1hsSXEvaXR6R0U3SjBJRW5I?=
 =?utf-8?B?T3NYdVZLL1pscGNsTmZ6VnpFNHFuSTByTVZETFhJbmJqQytXT3pVNi9FRndP?=
 =?utf-8?B?eWltT3hNek91eFVtSUVOWDhWbE0wSW1lcUtYU2Mybm9ya1NrYWlxbmg5SWhW?=
 =?utf-8?B?eXNqWjJVdjFRd1lJOHI0bHQycFFZdkNDeDBwMU5NZ3p2VlgzRllsSlRERCtq?=
 =?utf-8?B?WFJUeGpLVzE1LysrZ2ZLczBJaEJhdkF2TFBsQWpoQmJYNXRsSmJOaVMvMCsx?=
 =?utf-8?B?ZVhFZ3g2Q0xBeHFhbEhaaUQ4MFY4RVFyc2RYTG55bGxZQ2Rva2xGOEdtKzNO?=
 =?utf-8?B?VWE2aTJTVWd1ZllRc291MmdZTGUvWEhrVUdJOEdMQkNNc3R5UXA3bjgvblNy?=
 =?utf-8?B?aS9kUXBYd0Jobmp2NE1MSzVoV3JsWDBvaG96b2lweFVkWlFKNTA2ejd6dmFR?=
 =?utf-8?B?c2NrV1FmSnF6dTAxNFM5TUlIV2pjRWllYjJHdWc2K3RjUitXZHVUMkpYWVc4?=
 =?utf-8?B?dGpMVzAyTUJBQW1jTUZ3cDFldkJEQUdYVllEcE5BbEhtcW9kaFJYREdUckkw?=
 =?utf-8?B?MTZUOE9UQ1lRSS91elBBQVp5NHZOZkZ2TnZTMzBocU5aYUdZaGpoUkJiL2p5?=
 =?utf-8?B?NDRJWmIzWUR0R1RLNnExR3IvSlBrOEd5ajczVlpXT2RERzJLUXhsenhySXA1?=
 =?utf-8?B?ekFZWCtMWkNFSWI3d05mS1BabGFOOGhRV1ZBcnd0Q0ZscjFaeFZ3SGNPRzJD?=
 =?utf-8?B?K2gzSXY1ZCtrd29vdHBKbWJtdXRHZEhuQ21QeFhWR2UwQVlULzhBbEtKWE51?=
 =?utf-8?B?ckMxanhSOHg0a1hFcVpoc1JHcFYxVm0zN25VN1BwbVNPVzhMaWZ0V2NWWU5N?=
 =?utf-8?B?Q0pYSEtvdWNocmZPU2RRazBDZkNJNHNOOTBqbjBxN3NmdzZXVU9NWVlDMDJ1?=
 =?utf-8?B?Z05QS0htNWZ3M0VVQjJXQ0FGQjZxUDQ4aThIVWJkUHNoNkMvcW9JM0JNYk1K?=
 =?utf-8?B?OHJhU1RhOUpkdkZudmZENEl6MXNDbmhhRHR6cldwdDdQWEtGY2ltcE1iV3lE?=
 =?utf-8?B?MTF3UWZPeGM2S29zQm8vZXArcjA0UHJnWjBBMTloNElZYXFOT091WE4za0ZV?=
 =?utf-8?Q?u7NjrO10oPEg5dgnl4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dca41f85-e813-4f60-3bce-08dda78836e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2025 19:02:43.4524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB10329

DQoNCj4gT24gMTAgSnVuIDIwMjUsIGF0IDEyOjI24oCvQU0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gRldJVywgaWYgbm8gcG9ydCBpcyBzcGVjaWZpZWQg
YnkgdGhlIHVzZXIsIHRoZSBkZWZhdWx0IHBvcnQsIDk5MyBmb3INCj4+IElNQVBTIGFuZCAxNDMg
Zm9yIElNQVAgaXMgdXNlZCBieSB0aGUgY29kZS4gU28sIHRoZSBjYXNlIG9mIG5vIHBvcnQNCj4+
IGRlZmluZWQgZm9yIHRoZSBoZWxwZXIgaXMgbm90IHBvc3NpYmxlLCBhbmQgdGhlcmVmb3JlIGlz
IG5vdCBhZGRlZC4NCj4gDQo+IFNob3VsZG4ndCB3ZSBkbyBhIGJpdCBiZXR0ZXIgdGhhbiBiZWlu
ZyBzbyBwZXNzaW1pc3RpYz8NCj4gDQo+IElmIHRoZSB1c2VyIGxlZnQgdGhlIHBvcnQgdW5zcGVj
aWZpZWQsIG9yIGlmIHRoZSBtb3JlIGtub3dsZWRnZWFibGUNCj4gdXNlciByZWR1bmRhbnRseSBz
cGVjaWZpZWQgdGhlIGRlZmF1bHQgcG9ydCBleHBsaWNpdGx5LCBzaG93aW5nIHRvDQo+IHN1Y2gg
YSB1c2VyIDo5OTMgZm9yIGltYXBzIGF0IHRoZSBlbmQgYWRkcyBubyB1c2VmdWwgaW5mb3JtYXRp
b24uDQoNCk1heWJlIHlvdSBtaXN1bmRlcnN0b29kIG1lPyBJIHdhbnQgdG8gc2hvdyB0aGUgcG9y
dCBleHBsaWNpdGx5DQpqdXN0IGxpa2Ugc2VuZC1lbWFpbC4gSSB0aGluayB0aGUgRldJVyBsaW5l
IGNvdWxkIGJlIGV4Y2x1ZGVkLCBzaW5jZQ0KaXQncyBtb3JlIGNvbmZ1c2luZyB0aGUgdXNlZnVs
Lg0KDQo+IA0KPj4gICAgY3JlZC0+cHJvdG9jb2wgPSB4c3RyZHVwKHNydmMtPnVzZV9zc2wgPyAi
aW1hcHMiIDogImltYXAiKTsNCj4+IC0gICAgY3JlZC0+aG9zdCA9IHhzdHJkdXAoc3J2Yy0+aG9z
dCk7DQo+IA0KPiBQZXJoYXBzIHNvbWV0aGluZyBsaWtlDQo+IA0KPiAgICBpZiAoKHNydmMtPnVz
ZV9zc2wgPyA5OTMgOiAxNDMpID09IHNydmMtPnBvcnQpDQo+ICAgICAgICAgICAgY3JlZC0+aG9z
dCA9IHhzdHJkdXAoc3J2Yy0+aG9zdCk7DQo+ICAgIGVsc2UNCj4gDQo+IGhlcmU/DQoNClRoYXQg
d2lsbCBub3Qgc2hvdyB0aGUgcG9ydCBpZiB3ZSBzcGVjaWZ5IHRoZSBwb3J0IGFzIDk5MyBhcyB3
ZWxsIHRoZW4uDQoNCj4gDQo+PiArICAgIGNyZWQtPmhvc3QgPSB4c3RyZm10KCIlczolZCIsIHNy
dmMtPmhvc3QsIHNydmMtPnBvcnQpOw0KPiANCj4gDQo+PiANCj4+ICAgIGNyZWQtPnVzZXJuYW1l
ID0geHN0cmR1cF9vcl9udWxsKHNydmMtPnVzZXIpOw0KPj4gICAgY3JlZC0+cGFzc3dvcmQgPSB4
c3RyZHVwX29yX251bGwoc3J2Yy0+cGFzcyk7DQo=
