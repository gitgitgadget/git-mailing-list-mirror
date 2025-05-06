Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA428F51A
	for <git@vger.kernel.org>; Tue,  6 May 2025 05:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746509820; cv=fail; b=jQUjtW7bE+EJ0+ANvso/VaI0oCBaUZ9rGYcR7U9oYkuYNMg5kfIZc9xp+b8n6NBCR6WV8a9Tc2qnkUAw7+o4my9p8HC21MUr5qcaATtjatdIBIffyyUu4r9xWxkgos0fnXjbS4k+rz+MGYNyotWqui9L+bcSjaQp5/jaYkMcYEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746509820; c=relaxed/simple;
	bh=mtx1RQFfkRIoLZuMMb+8X4M7z0lbiyuHpsHulsNuPFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LMQaeSmQN7ITm6eZ80608dQejufsQdhkck9jF2I9KwavWEDaRIUIdFSR9kE4AshmBehJ855CLsURUQvXrfWH1zSiNtInkueDOkfpI6gen3hl/KnIJ0iNGlS12coCuGrDtelCr/t4VZ+dUtR/kF64iqVjWcaXcOZdlXKGDn2kpMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=TnNBuLeR; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="TnNBuLeR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lk0uBbg+uHMx+tca/RM2k4qV3XBwg+gXv1/1XMj5j4Ww8W5i9JtEEiXuEFnkFYrYZeKgPaz8VE/RO64mUvjLjFhddBX0Za4+4YAwnzAScqJN5MLqyG9lON0FEdrI631jA68TLWlWL23XLAbPhYEQ/i5LMsphDLjKj/bdDRIZVmCxbi+KVpa2Y9z9HIwk1ULINEQscASF+miuEjhNTDEbTLqsU8KfUXV4Daa/ye2I4azMsaC2RmEWUwN0J+ErnHvW20MDt21e6OTBRfobvpTuM0w3AEx/rs4l2GB+xdBYz5o3iA4BB+wkRTztI/Nk9CozwJxv1wkC31Pvrq07sjb1Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtx1RQFfkRIoLZuMMb+8X4M7z0lbiyuHpsHulsNuPFQ=;
 b=NcXJ7s6h/nGGbG+VlqRLB+p3JGwBezKj24zx5ouRtfKS34nys73u3ZKaDlCIngS0EKmATTSE2EoJQTF+MTtZrR0yR5bgGcWMXim4JOLH/mhBZhaNZryUR1GnKtjdebLeOCcLlExAulN4Djp04Z+ToaLMHdMp5t9gB/o/cTTUUl29S62XlAOrp83VJ4FXuQByFluMLJ5DT0s2zqJs25VYkB3kX6OaOucqsho81EzTy4e5Lj/YWqq92BVoPQlZDkH5qwZLfQr3b1gIDGA9iOPdZcg0bb0U//A6dTMNQXMOlTma0TNvCqiRbvsinuop1EiQmVVJoMc/d1OpJqqbL2eZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtx1RQFfkRIoLZuMMb+8X4M7z0lbiyuHpsHulsNuPFQ=;
 b=TnNBuLeRM+ngtz0Qg7F0Eow/xjnsCa9jwM7XLaslzjhidIWcQdRbGb1DgqQczze7CFYH4tnFxl9UQ7CpUiX1qLjOc/OWlzk/9AsKFIkRi8gg9aJDFfynz2YZ16noCI6agluixb7PGNhvzW0PA4jgzWanco7g622EhlAAFwiTtQV0cE0eRUNb0DlXoDOhgjqISqdQoHJCyH5VPQxFYQ41xxpFLcec9qSTbMUj2drO4s0vTWHGIZls8Mz73racHx18Kkg5CyF7enCUzSXHRo+4RWFLcSdYKizW3iS0zO4O+9fTdn5CbIIaplrR6T62YKtQ/fiLrXn+r8pr0m0XzEdDMg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9323.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 05:36:52 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Tue, 6 May 2025
 05:36:52 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, M Hickford
	<mirth.hickford@gmail.com>, Julian Swagemakers <julian@swagemakers.org>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 2/3] docs: improve send-email documentation
Thread-Topic: [PATCH v3 2/3] docs: improve send-email documentation
Thread-Index: AQHbvdIHVNNF0fQexECuSqAmqwnoRrPEtmX1gABfs8E=
Date: Tue, 6 May 2025 05:36:52 +0000
Message-ID:
 <PN3PR01MB9597EF61B4CC43595DE4341BB8892@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597BD33DB2C4F3BE9E5F4C6B88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95971776178BED3516DA03DCB88E2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqldralil9.fsf@gitster.g>
In-Reply-To: <xmqqldralil9.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9323:EE_
x-ms-office365-filtering-correlation-id: 68e571b4-8ccf-4a1e-794c-08dd8c6001a0
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|15080799009|8062599006|8060799009|7092599006|461199028|6072599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?N3ptTkMzdVkwMmNncGVZQ0xyZFZRSThad2lKb0NQQWllRkR5ME1mMTNjTXpO?=
 =?utf-8?B?ZWF0bTM1eWpTVVlkMjVkMGVLUWhCVXFacUlCc3Ntd2l4aXFyVndkYm1uS2pi?=
 =?utf-8?B?Q21BRTZKWE84azJvU0JNbXhCQzJSZGZma0VybTR1aW5KYUVHYjIyUlp6dHMv?=
 =?utf-8?B?Z3VuTzZFZFZlUjNMNjBRQnlPcEVDR3orYmtBbzdhcXBIczIyLzd4N2k2aEEz?=
 =?utf-8?B?Nm5HK2JJWU1kdGtoTi9PbVEvKzBYQmVvNCthYmJGeUc0L0xLVHV4T0xOQnJP?=
 =?utf-8?B?Q2JwTytYd0NjdFBFcXhlOHd3UTJpNmd4aGlla3BXQWc5enVHeFhleWhWbGtn?=
 =?utf-8?B?WWcweElpV0hWcGFlTkxYOXV2NWFFeFdsMC9hYzFvSkdyN3g4Q09KWVNTU3Jp?=
 =?utf-8?B?dVRxVUNnZEZRM2traVVGZWMvREtoYlI1aElWdkUrWTJuSjExQ1d2V25NVkF6?=
 =?utf-8?B?RzVPcXVMdFJ2K2FlS09GRnVQZHF1WU9wRTlleDZNTnRvK3VuODl1K1NDWEZK?=
 =?utf-8?B?di9Hd3c5TVZ0OXFOeXl4OHhpZGt3ZG5vdW5UQ2xOdHdmbHAwRDlJNEc5amRj?=
 =?utf-8?B?bkhQVWRoLzZyc1FUMExCVVg4QzhFWC8wdkRyb1ZtVTZaaERrVkpjRzQ2Y0hq?=
 =?utf-8?B?NFJaZ1czcm9xSi85OUtTcTZEWTRRZHByTzFRZGx4ZmtVQ0F0N2krMW14ZUhO?=
 =?utf-8?B?R01uem1MMzZpdVIydlpzcEpIbk9lamFlZ2pJR0czVHZBOEorOFFxeVFSV0dC?=
 =?utf-8?B?VE84dmZEWlh0RWtuOXRBd0JzaTl5aXFPSkJqRzI2MzU5aEE3NU96NzNlTFow?=
 =?utf-8?B?b2FHZDltYzRQMTNhb2czRUtUL2FNa09OM0ZnQlpkWSthMDNQdXU1aWRkZUpO?=
 =?utf-8?B?YmJDY2NGM1NCUUJCaVFicHhUODN6T1o3YTl0cEpwUEU2V0VhVkFXa2tBS2lo?=
 =?utf-8?B?QnpsQTlkOTZINTc3V0NROWpoNDhtcDNlL1pGdkNMUDRKQVd0OEhsYzk1WlBy?=
 =?utf-8?B?cGtUcmo4K1FSei9xSHR2R1NQaUxzblFBZEw3NjBmRnVGQ0o1VmxmQmVYVkxv?=
 =?utf-8?B?RzFmWnFYNXBJeGJmRmRxY0t6NnJQTEJEek9SWS81V3BLSURiNzZCQmpnOTgw?=
 =?utf-8?B?T01EbFUwMHZXdytRZFlrYVlBNTRLS0RwUjVPTnBpcERDaUEvS1krYkxrNXNn?=
 =?utf-8?B?VzF5eCtSZ1VrT1JKMjJPSjFWcHBUYVp0T0RDaUlZa2ttbVZiMEZHWStWelJr?=
 =?utf-8?B?T29LQ3k0N21ueUNHVW1iOGJHVTdnZkZJUGlpVENnSEtLZnptSW54c0Z1WkFD?=
 =?utf-8?B?azErL0hLaXJtM2FVWFZhbnNIK2pubnpHMnVFOGNrWnU5QmpUSVY1eFY5aEYw?=
 =?utf-8?B?NDZJeE5tUi9rVHg1OWJNZi9lSkx5SjhoSWpBTTJ6bVZOMFlVT3huaUtXZ0Iw?=
 =?utf-8?B?RUEvWWM4bC9rV28wTm9vYlpCd01STW9qNW1iVzRpZldkQmhxUUZBeEpJRU92?=
 =?utf-8?Q?AhbjM8IdhEz/fPFvRereXCSJR0+?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2t2SmdScWVKV0VsUW1uZ0I0TGU1akxMUnFVekw2eFM4YkZpNWFnemZLbmli?=
 =?utf-8?B?WDFxVjZCT0ljTUxwN1RiZ3hGSmlwVTJBYlZXclRUVWlNSlRDMmo2L2hoQm5s?=
 =?utf-8?B?bTB3aStFYXNHWWxESzJ0M1JIQnV6MEY0RGRJS21odklxNmd2QjE4MGNDS2cw?=
 =?utf-8?B?ZzROeHFjbWx2WkRxdStkWE00N0tvTFJrM2JsSmVBY0xWVmtiY3ZPUi9pOWZz?=
 =?utf-8?B?cTBIN0xvUjJLaDZZcGpwRy9lWHIrVktwTmxYN0lVTUVpcXBUdWFUV3lTRklN?=
 =?utf-8?B?NDJNU2NUOEdFZFhBbHVTcjM3YXpPSnlVWm9VbFdOSXBGWUZTTmpKTi94WGkz?=
 =?utf-8?B?dFcrNWxwanZZejFMMW1MSktpYk9KMEZyZW83UU9FaURHY0tnY3UwdGlXamdT?=
 =?utf-8?B?RGRIR1ZqU1FOTmtOOU42UlJpS2FseEpqVUw3YkwrQ2llN2h5Sk9tWFZ6NndN?=
 =?utf-8?B?bTBOQ1RUWWc1UlVZaWtLTHcyRnVJMlA2QjAyendsQVo1UHlRRElSbjVTeUZm?=
 =?utf-8?B?WnR3bTRpODRTbFRDakNiY084L0NqM3JQWldaNTNpV3R2bTRGcWRqQUs2Y21l?=
 =?utf-8?B?Ty9OaG5rRSt4czBlYjh0YWdJd3JUREVoS05zNndZQTRKaVlncDJQeTZ1Yk16?=
 =?utf-8?B?YnBUcVRocXlabTlYdjB2c1E5OW8zVnZVbWRGK0oyK1V1SWw0dlVTbUpXN092?=
 =?utf-8?B?NHREdVZ6QzdORmJFOGlXNHd6QkJYT3ByOGhuMmZtd0hqWi9IR1J3bjN1SDk1?=
 =?utf-8?B?eVkrR0lqL094M1J1VTRtTTBRK24zVnpKMHhpR1Y2bTJSWGZBV0k1Nk9xSkdP?=
 =?utf-8?B?cFQ5N2NKcHhIeFhGYWlyMmhXak93dEVOSkNRZEZjY3QvWHVULy9taUtTZUUw?=
 =?utf-8?B?SkhLdS8zSGlOWitjLzlTbGI3d0N6U3FrZjZqWXJSNjB2ODZXcUdZZjFuVFZh?=
 =?utf-8?B?Y3NsVDJXMWNZQVJPRDl2Q3B0MU0zQzBtODlncDRkNW5Qd0VJM0JseE1aTzVj?=
 =?utf-8?B?MC93WS9NbzJsK3lTbTZmU2hOZUxlZlRqR0ltNHROb25EY0xUUmlNL0xlOHI1?=
 =?utf-8?B?NlpKaG1pZVFOTDBuekdiY0tlVmNnT2Mvc3hwRkN3ZmdDSWpSakdKR29sY1BW?=
 =?utf-8?B?UGNVSzRobGpGOWZFNWRUYllBSS9hWlBXUlo5YUNvY2E5OE5NNEIvMUFlbVZ3?=
 =?utf-8?B?Z0NOeEtualNuWTc3azFqRU95c2lnTkRxWEpDbUZuVFNaQm51ejdSL3hLWEdM?=
 =?utf-8?B?U25xZDh6Nm1XTmpnZmxOamV4UEN0UmxCZUwwVEIvTDhHUXI2Skx0QjI5amF4?=
 =?utf-8?B?dHNmNzZ1SlVhV0dkZVVTYnFDRXRBaUhCY3plRkFxN3NjSy9CWDNZakdZMmlO?=
 =?utf-8?B?bytac3kySjVsU09SdEtyVEF3Zm94blVES0FnRnFkcnJmTDFMMFRVa1M0ZkFH?=
 =?utf-8?B?TmYrTEU0Rml2YmF5dEN2REF0MXM5QUJHdjVCcjFHOXNxNXpOTUprajVLZzB2?=
 =?utf-8?B?c0xTQ3MxYUVuTEZLell4YWJvNjU2MUFPY2F6MzdOYmpGNmhXNkxwdDM1TENn?=
 =?utf-8?B?cHE5YnBSY1E2WWtGaFV6S2NrUzRvZXJaR2FpNFl6cUNZSUNrOU12SS9WYXRn?=
 =?utf-8?B?dDZuM3N5WVNISzErNC9Zd0dxRkltYko1VDRjdStuNnpSNkUxU1VoMUI1RVBI?=
 =?utf-8?B?bFFzZ3dNbVJ4Ui85R25uSmJCMlF5eDRuRlQ3NnVSWXV6N1pZRVliSFFqSEdo?=
 =?utf-8?Q?8dTfcrKmWptR+kK4wk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e571b4-8ccf-4a1e-794c-08dd8c6001a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 05:36:52.7976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9323

DQoNCj4gT24gNiBNYXkgMjAyNSwgYXQgNToyNOKAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+ICtJZiB5b3Ugd2FudCB0byBzZW5kIGEgc2luZ2xlIHBh
dGNoLCBydW46DQo+PiArDQo+PiArICAgICQgZ2l0IHNlbmQtZW1haWwgLS10bz0ibWFpbGluZ2xp
c3RAZXhhbXBsZS5vcmciIEhFQUR+MQ0KPiANCj4gRGlkbid0IEkgYWxyZWFkeSB0ZWxsIHlvdSBu
b3QgdG8gZW5jb3VyYWdlIHRvIHJ1biBmb3JtYXQtcGF0Y2ggZnJvbQ0KPiBzZW5kLWVtYWlsIGFs
bCBvdmVyIHRoZSBwbGFjZT8gIEp1c3QgcHJlcGFyZSB0aGUgbWFpbCBmaWxlcyBvbmNlLA0KPiBh
bmQgZmVlZCB0aGVtLCBwZXJoYXBzDQoNClRoaXMgdmVyc2lvbiB3YXMgc2VudCBiZWZvcmUgeW91
ciByZXZpZXcgOykNCj4gDQo+ICAgIC4uLiBob3cgdG8gc2VuZCBwYXRjaGVzIHRvIGEgbWFpbGlu
ZyBsaXN0IGZyb20gYSBzZXQgb2YgcGF0Y2gNCj4gICAgZmlsZXMgeW91IHByZXBhcmVkIHdpdGgg
YGdpdCBmb3JtYXQtcGF0Y2hgLg0KPiANCj4gICAgSWYgeW91IHdhbnQgdG8gc2VuZCBhIHNpbmds
ZSBwYXRjaDoNCj4gDQo+ICAgICQgZ2l0IHNlbmQtZW1haWwgLS10bz0idGhlcmUiIDAwMDEtZml4
LXRoaXMucGF0Y2gNCj4gDQo+ICAgIE9yIG1vcmUgdGhhbiBvbmUNCj4gDQo+ICAgICQgZ2l0IHNl
bmQtZW1haWwgLS10bz0idGhlcmUiIHBhdGNoZXMvMDAwWzEtNF0qLnBhdGNoDQo+IA0KPiBldGMu
DQo+IA0KPj4gLSAgICAkIGdpdCBmb3JtYXQtcGF0Y2ggLS1jb3Zlci1sZXR0ZXIgLU0gb3JpZ2lu
L21hc3RlciAtbyBvdXRnb2luZy8NCj4+IC0gICAgJCBlZGl0IG91dGdvaW5nLzAwMDAtKg0KPj4g
LSAgICAkIGdpdCBzZW5kLWVtYWlsIG91dGdvaW5nLyoNCg==
