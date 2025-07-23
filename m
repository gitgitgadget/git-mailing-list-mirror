Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010005.outbound.protection.outlook.com [52.103.68.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C55215055
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 17:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292025; cv=fail; b=izjfEtczLxe3gG362JgNQ+9M+gKKODDnbxsLf3ytPAZIq+5LN7T29ROeisz3MrDA3nBnzsLyi81576+xJo0Pp0NwLbNCLVuRKiD9ZL5vW1whQmtYGEbm8HBRqBP9wm4pbzL9iVvYpnjfkSzMo25gQaupCmoRo4CGqDjMA78UKCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292025; c=relaxed/simple;
	bh=TmcXHxvpqIOmb4ivzobUNRiLreV9lSExhTTv5J8VenU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWs1SNacu69tyGKDoDy6YRlF62cRu7bNXztnXGBmbukVR0tUQwqPn3OQBMWosz7v3OZgtEDRp0KYNLSlMpt3xYdpqdbP7K14gjWYKMvlrpeDDQoInX2hk8L7eY/4EF21JIvHFUHhq6+s0sGS/Jwlk1A+lQ1ez6/Nb/89f7lT+nU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=W6qk1vVI; arc=fail smtp.client-ip=52.103.68.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="W6qk1vVI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/02pEFhKEvztx7aRCRzfIBKy/7dYLg50Qjh6N2SdOSwDFl/N9L3OiqCcujmSsfZm3asoRvai7LGIYGC3Tn2tY86bBwngpbIKVNb/8n9kuxvj96qCUifEIl+sJtIHBkYLDpazD+W8+OdpKEOMHAqd168JYItJ5EDpjMFIvr3nyzrwhf2IlADfV8p7Yiz54gcnQ9fpAveg4kdv5+7PLU8H18EgGKsuDLGE3iVaXTqQbNJnsrxaOAPyfwRku8XHQsZQHf+0bY3W1Jz7CC74N6nAcVp7UrwrGVRqxDOGiDubnB1zFiNYwxqCMjk3dF5NjJLQ37vPDEkL/7isK3EObQspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TmcXHxvpqIOmb4ivzobUNRiLreV9lSExhTTv5J8VenU=;
 b=gVfWk2+Dq3r1JK4m+sB/Vn31+nzmD1hAkPYtii+5+IBVZOrWBqGl50en95D1pDO80c8MBGQMB6+VaKrY6zRDmLX/2r0S3YUIK4pxyYvqRyCAY0wsOxR88VnAiyotPwkfCjAIYPDjs87Nh6euREj6z3/XlbQLJJj73wty9Z2QT5uEsnEp3e70O8ZwO7KGs4i475TESfTsxgVq3niFbH516meyQ2n+TZMyMi9YBJMbU1fsFZOE4NiDhW6nIN2W8OWY/aa30VBvHBem7x62O1fJk2MaHKmuKqiV+mTo6ZyWmITwiGEl9Eag0yfVbnWgAPATsSj8+g04+sBk6GHWz1sULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmcXHxvpqIOmb4ivzobUNRiLreV9lSExhTTv5J8VenU=;
 b=W6qk1vVIXjnfa+5ykEWS42PlnH1XWdYdG/7ETF+VbsJ2METGbUrq9yGfGv7LbUBRKtYdlVXFaSyCdV20+y8/OJ9h0KTSejeT5/siAVvFEcuTsplsEhlsfpWwgORuhOsScOdRxSP4NNXFJet5T5BchY6p3p6/Nkj3rw3FGgLTlgElnRRxep/iwTJadM5UaYOl1sHKOcY+a4KGIbneIdelPWwVoyZxveGkMISX+2tqv7eeaGxFXcD4HJ4nTy1u77oTJP4ihNHiA3JCh7klKrfjM3O1KgaQKarVnvwIbO6eC9JG+/VI06HItm5F3+kbEzN0jHW37pZCFokqe/IyjXsd0g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB6380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:75::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 17:33:36 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8964.019; Wed, 23 Jul 2025
 17:33:36 +0000
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
Thread-Index: AQHb+81kOsb3aqbVj0WTwu91w6cBzLQ/9hKSgAACKMs=
Date: Wed, 23 Jul 2025 17:33:36 +0000
Message-ID:
 <PN3PR01MB95970E44092A27F47AF25CF8B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <7108764f437a25079c95a25c227eb79f9f4aee6a.1753273554.git.gargaditya08@live.com>
 <xmqqecu6om3t.fsf@gitster.g>
In-Reply-To: <xmqqecu6om3t.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB6380:EE_
x-ms-office365-filtering-correlation-id: 80b94a57-d1c1-456c-954c-08ddca0f0dfc
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|19110799012|6072599003|8062599012|8060799015|102099032|40105399003|3412199025|440099028|10035399007;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFRTOE50QjEyM1BYQ2tTSTJiSkErSi82MUV5RGlIaFFjOHJTR29xSlU5QnR1?=
 =?utf-8?B?dzlFMVVrMFdzUHMydzZ1aTlsYVZ1dE93MlVoWjBxWHFmQXZDbCtXVFI4MzI4?=
 =?utf-8?B?MXpSUGRISjdRVjBQNTY5YVN5Y0FzQ3NvbE9nSE5nNUlFeDkyZjZnYUVVekk2?=
 =?utf-8?B?QUYzN2hYd2pqUWE5QjVVbi81QXRsdjkydk1HUW8zelBjVW5OL29NZWFKY3ZH?=
 =?utf-8?B?Q1VrSDdvYVllaXkxZ3NHRk0zYmtmdXl4K05VejYrZzBtMUhPYXVBcFVRemhI?=
 =?utf-8?B?bXZwT2MvWVFHRkU0SnUyekdzK0YveEVHNDdsUDhTU3hsNkZ1WU1vYzVmUUdH?=
 =?utf-8?B?ZmkwQzhLMlcyamlpS1NzUytNM2RqWXBJSU9KNXRjV3VOalQxN0tXc1oyNlNQ?=
 =?utf-8?B?RU9nSzg0cGYzNmg5endNQ09GdldnVjR3RGF5S2tjOEx3bUM2S3pUMVhKS0xp?=
 =?utf-8?B?Wk4vMzlsaG5PbWZDR2NPY3l3UGtSbVVHOG9QV1ptWjM4WEdSMW8xdkxzSzhC?=
 =?utf-8?B?MTJkMUs3YWtyT2dxN0tpcjlud1RVcEYwTmM1Q0RmcC9kN29OdXgvSnRKUEc0?=
 =?utf-8?B?N2VNSGdrdkxOLzJmc016eVVPTDNtZDl4STIybVREUU1pRzRxMWlZZ09zdE15?=
 =?utf-8?B?dnFUdFpKYlhaUVByRTlsNHdtekg5UldndHdTYTJ4NzJRYzBNWkVSZXRFbHl4?=
 =?utf-8?B?MXU0YkoxRTRGTDlmbWcxQlU4RS9XTEVZSW5USXloM3ZURjZ6MzdOUGgra1Z5?=
 =?utf-8?B?V1R1d0h6ZkphcXlCa0xGcG0reWQrSVQ5aDQ3aEQwUEtxRjIwR0VpeUVTYnhi?=
 =?utf-8?B?WDNJblk2alhiTjliVU9MQnhyT1BGVWRnc2FDWjZ5Lzh6cWJOdE1uOG93QWV4?=
 =?utf-8?B?Umx1N2hRWmZFcnEvS0dyanNGY2VuNVBYbnc1Q05LaHVtNm5hNWxRMlIxWWxX?=
 =?utf-8?B?Mm9BbzZMYXA3TUljODdyb3NDSkZhRzhRVCs2U0poMFhpd0Zlb21LODQzUXdE?=
 =?utf-8?B?dFVOOXV4ZDAxNENqemdLbFU1VXdWNGFLUTRIZ2p2QTREd3BaU2lqSk1BK2RR?=
 =?utf-8?B?NDJKUzZZZCtXdHpIZEowTllkWHRXRzNDSTZSYWQyR1RwNDB2eWFKTWhoV0Zt?=
 =?utf-8?B?aHNzbXZ4LzlxNzhLZkZtQUFFQmpYR1N2YUR6aGdDZGJIME8zOWtlM1dobGhF?=
 =?utf-8?B?b3h3RHhsbEFhcTY5WU5ka1pRY3lUczdwWUxTZU5wNkhtOGhQMHdLcHlWU1Q2?=
 =?utf-8?B?VnJnOWZIRnVoMUZMWUU0TmRwQ3FPdlJUZTQyUmZCWEt1bGx1M0ZBaERRV3Jr?=
 =?utf-8?B?MnBKZzQ2QkRiYkdQUHBlUXYxUUx4akF5S0NJUElHSjEwdHp0aWVoRnBTZFUx?=
 =?utf-8?B?ajB6alhTcE5WUUxaVDB2amp6TnBodjVRenVXZGV6Y2IyaGl1WEYva0F1Qk5u?=
 =?utf-8?B?WUJJcEsyRVIvaSsvOEFucGw0akJUK2xrWWtpRnZ2RTRLU1dQTFlibmU4TnQw?=
 =?utf-8?B?Tzgza3JOZU5jdVJIR1BlMGlCempUWU9QNGd5blh0Ni9RbVRTc1o2MW9BQlpW?=
 =?utf-8?B?MktYZnJoUDBqa0dsc0RKVk9mQ1FCQU9PNmQyeEJrSGM1Z2dCaElhb3hLbHJG?=
 =?utf-8?B?bHhrRDNPQmRTMndFM2Q4TkRNK1BWWXc9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y0IzS1hTUnZmU3pGYldYcXVEZXp1NDZHdVlXZXA3TnZ2WnhidmRjb1VLM2RX?=
 =?utf-8?B?RFAzRnQycGtQVjdLQitpMlV4ZnE0aEkvRkhXa0ZwNDY5a01RK0p2eUZRajdK?=
 =?utf-8?B?ZFpRb3MyUmdjejZFK2NuYXlnZmZ4eGJ1Wm1VYUk0cnlIQ2lHYXg3MXRjaWlE?=
 =?utf-8?B?RVVmeXlHS3liWTVCTFRVNjAvZE9mWXQ5ZDQxRXlFbDllZFlxY3hGbWptUmFT?=
 =?utf-8?B?aUhRNHphT1lnbC96Z2lFYVBMNkd4bTZWTzkrNVlxNDNsMXVqR3hIYU9oVk9Q?=
 =?utf-8?B?dm1oc2xqdkZYZlkvOHoraGdaSkNKYzlDcUFiYVBnSG5DNmNkbnlkTEozZTRL?=
 =?utf-8?B?OWlyZWllNU9zcm5FMDZPOTA3S3RrTkw3UVJaaUw0RzVMeWoxU1owYi9kY1Jy?=
 =?utf-8?B?Qy9ZTVlOT0ZSazZBL1dKRHZaOXpaN2pZZkxiODU3cXpTRmxrcjJESDBnTlkv?=
 =?utf-8?B?dkZ2NkM4VHg1M2dkNDUxMGExQnYvL1UwY2Y1UFcyczZLeXI3dmZUMy9Db0di?=
 =?utf-8?B?VVV6aDdqdG16Tkc0ZStrWWNRazRMRVZzN3Y5M0tWMzJWcG5PWkJSZURla0k4?=
 =?utf-8?B?M1JLa2VYTG5iQWhrYnFKOE5yNnZudkUrUVZSRWMzbGRHSFhCRC9PM0hURXcr?=
 =?utf-8?B?U3NjZVoxOHJ6Y241OEVOZnF5R09uVkdRVk5XYlZ2dGY5UGxSekNOUzluQlJ1?=
 =?utf-8?B?bDBkYzNtTjMza3Y0Z0lxWkJvcEp3Z1RoRWkwdUJWNzBQVEZYakFzZGpseXNi?=
 =?utf-8?B?cC9Vd1NKNW9uMEpNYnU4MldSazJRbENSVmlTVU9rOEFXL01VM3FxdlhVRlVT?=
 =?utf-8?B?S3Z6M0M5N3FmMWYvZ0xaWnA4M0Vod213Tk1ud0oySGVXSy9tSm5jckhsT3My?=
 =?utf-8?B?UFFCUm03ZWdZYUE2YnhIVi95TzVTeEpLclpWOTVjcFBOMkpGejFrY1FEUnBR?=
 =?utf-8?B?Y05FbEY5K1U3SytTN0JvT3VxNUdCZXlaSUJNUTJsa3Q0RXl0ZFJnOEhSUmw4?=
 =?utf-8?B?QytxL25na2YvdXZIU3c1dkQxQXVURVJGYm9oZkdBaHRlT3VpM3ZnTlRmVWFT?=
 =?utf-8?B?L2taUExmK1c5RjN5emZ4RWFMc1lrQ1dGa1lPZVIrZjkyTTh2dGR2ZHhOb2s2?=
 =?utf-8?B?b1NtdkdYY2FYNUdsRXZmVDQ0SGZ5b2p2U0lOVVJJaUl4WUtIUkFsS2JuMWJD?=
 =?utf-8?B?UVlCcXNOYzFDVy9vZE5LdDBqT0R3VXFGOW4vOCtKSlJXQXJwdDB3NXMxVXBZ?=
 =?utf-8?B?R0FieXhDbTIrYnR1ZzdaNFpzemNDQm5idEcrOS9wYmpwQzJ5VU1haHpCVkRr?=
 =?utf-8?B?UXc4ZjFPSkRmQ2ppeTRvOFAyNTdLd1YvR1J0TTJuKzhEQzZRaGZ6ZzQzRGpV?=
 =?utf-8?B?aldqVi9oOXdRN1lrZWx0Y25YQzh3VUJ4dmhrZEpMdFVVYjBKTlFiTEFUSTFs?=
 =?utf-8?B?MnRVTlA4MXJYaWxTaUdWR0N4TmRsTngyMk1CRElRejJybHFBUnVZRkVUZDN6?=
 =?utf-8?B?S09zUTMxbDhoTDMzM21iaFlYS2V0Z2dHNmhJdW50Nm0ycUxsMHQ1V0Z5K0Fy?=
 =?utf-8?B?amg3OVp6QWtlTzB1QWFybVIrU0gyQWluWU0ySTVsM25ZY3NDRjNUUnVXVXlv?=
 =?utf-8?B?QTcyZ3lUNzBUMVZEaG5pQU56dHpFVTJTZlhtWU93WDRpSzB6dk83TXJsYmVE?=
 =?utf-8?B?bkViSlVhOTl4eE9weUFsWmx1WEdwRDFoNlVzaU1yTldsbk16aXIwTmNFOThC?=
 =?utf-8?Q?VuFKXFk3EwvH6gi1nU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b94a57-d1c1-456c-954c-08ddca0f0dfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 17:33:36.4066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB6380

DQoNCj4gT24gMjMgSnVsIDIwMjUsIGF0IDEwOjU14oCvUE0sIEp1bmlvIEMgSGFtYW5vIDxnaXRz
dGVyQHBvYm94LmNvbT4gd3JvdGU6DQo+IA0KPiDvu79BZGl0eWEgR2FyZyA8Z2FyZ2FkaXR5YTA4
QGxpdmUuY29tPiB3cml0ZXM6DQo+IA0KPj4gK2ltYXAubWFya0FzUmVhZDo6DQo+PiArICAgIENo
b29zZSB3aGV0aGVyIHRvIG1hcmsgdGhlIHNlbnQgbWVzc2FnZSBhcyByZWFkIG9yIG5vdC4NCj4g
DQo+IElzIHRoaXMgc29tZXRoaW5nIHVzZXIgdHlwaWNhbGx5IHdhbnQgdG8gdXNlIGEgc2luZ2xl
IHNldHRpbmcsDQo+IG9yIHdvdWxkIGl0IG9mdGVuIGJlIHBlciBpbnZvY2F0aW9uPyAgRXNwZWNp
YWxseSB3aXRoIHRoZSBuZXcNCj4gaW52b2tlciBpbiBzZW5kLWVtYWlsLCB3b3VsZG4ndCBpdCBi
ZWNvbWUgbW9yZSBsaWtlICJpZiBJIHVzZQ0KPiBpbWFwLXNlbmQgdG8gc3R1ZmYgdGhpbmdzIGlu
IG15IG91dGdvaW5nIGZvbGRlciwgdGhleSBzaG91bGRuJ3QgYmUNCj4gbWFya2VkIGFzIHJlYWQs
IGJ1dCBmY2MgY29waWVzIHNlbmQtZW1haWwgc3R1ZmZzIHZpYSBpbWFwLXNlbmQNCj4gc2hvdWxk
IGJlIG1hcmtlZCBhcyByZWFkIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Pw0KDQpTbyB3aGVuZXZl
ciB0aGUgdXNlciBjaGFuZ2VzIHRoZSBmb2xkZXIsIGhlIGNhbiBjaGFuZ2UgdGhpcyBvcHRpb24g
dG9vPw0KDQpBbHNvLCB3ZSBoYXZlIGEgY29tbWFuZCBsaW5lIHdheSBhcyB3ZWxsLg0KDQo+IA0K
Pj4gKyAgICBEZWZhdWx0IGlzIGB0cnVlYC4NCj4gDQo+IElmIHdlIG5ldmVyIG1hcmtlZCB0aGVz
ZSBtZXNzYWdlcyBhcyByZWFkLCB0aGVuIHRoaXMgZGVmYXVsdCBpcyBhDQo+IGJyZWFraW5nIGNo
YW5nZSwgaXNuJ3QgaXQ/DQoNCkN1cmwgYWx3YXlzIG1hcmtlZCB0aGUgbWVzc2FnZXMgYXMgcmVh
ZCwgc28gaG93IHdvdWxkIGl0IGJlIGEgYnJlYWtpbmcgY2hhbmdlPyBBcyBmYXIgYXMgT3BlblNT
TCBpcyBjb25jZXJuZWQsIGl0IG1hcmtzIHRoZSBtZXNzYWdlcyBhcyB1bnJlYWQsIGJ1dCBkdWUg
dG8gaXNzdWVzIHdpdGggdGhlIGxpY2Vuc2UsIGFzIGxvbmcgYXMgcGVvcGxlIGFyZSBjb21waWxp
bmcgZ2l0IHRoZW1zZWx2ZXMsIEkgZG91YnQgcGVvcGxlIGFyZSB1c2luZyBpdC4NCg0KQWxzbywg
d2VyZSBwZW9wbGUgcmVhbGx5IHVzaW5nIGltYXAtc2VuZCBpdHNlbGY/DQoNCj4gDQo+PiBAQCAt
NDcsMTEgKzQ3LDEyIEBADQo+PiANCj4+IHN0YXRpYyBpbnQgdmVyYm9zaXR5Ow0KPj4gc3RhdGlj
IGludCBsaXN0X2ZvbGRlcnM7DQo+PiArc3RhdGljIGludCBtYXJrX3NlZW4gPSAxOw0KPiANCj4g
SU9XLCB0aGlzIHNtZWxscyBwcm9ibGVtYXRpYy4NCj4gDQo+PiArICAgIGlmIChtYXJrX3NlZW4p
IHsNCj4+ICsgICAgICAgIHJldCA9IGltYXBfZXhlY19tKGN0eCwgJmNiLCAiQVBQRU5EIFwiJXMl
c1wiIChcXFNlZW4pICIsIHByZWZpeCwgYm94KTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAg
ICAgIHJldCA9IGltYXBfZXhlY19tKGN0eCwgJmNiLCAiQVBQRU5EIFwiJXMlc1wiICIsIHByZWZp
eCwgYm94KTsNCj4+ICsgICAgfQ0KPiANCj4gV2h5IHNvIG1hbnkgYnJhY2VzIGFyb3VuZCBzaW5n
bGUtc3RhdGVtZW50IGJsb2Nrcz8NCg0KV2lsbCBmaXgNCg0KPiANCj4+IEBAIC0xNzAyLDYgKzE3
MTAsMTIgQEAgc3RhdGljIGludCBjdXJsX2FwcGVuZF9tc2dzX3RvX2ltYXAoc3RydWN0IGltYXBf
c2VydmVyX2NvbmYgKnNlcnZlciwNCj4+ICAgIGN1cmxfZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9Q
VF9SRUFERlVOQ1RJT04sIGZyZWFkX2J1ZmZlcik7DQo+PiAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1
cmwsIENVUkxPUFRfVVBMT0FELCAxTCk7DQo+PiANCj4+ICsgICAgaWYgKG1hcmtfc2Vlbikgew0K
Pj4gKyAgICAgICAgY3VybF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1VQTE9BRF9GTEFHUywg
Q1VSTFVMRkxBR19TRUVOKTsNCj4+ICsgICAgfSBlbHNlIHsNCj4+ICsgICAgICAgIGN1cmxfZWFz
eV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9VUExPQURfRkxBR1MsIDBMKTsNCj4+ICsgICAgfQ0KPj4g
Kw0KPiANCj4gV2h5IHNvIG1hbnkgYnJhY2VzIGFyb3VuZCBzaW5nbGUtc3RhdGVtZW50IGJsb2Nr
cz8NCj4gDQo+IEFjY29yZGluZyB0bw0KPiANCj4gaHR0cHM6Ly9naXRodWIuY29tL2N1cmwvY3Vy
bC9ibG9iL21hc3Rlci9kb2NzL2xpYmN1cmwvc3ltYm9scy1pbi12ZXJzaW9ucw0KPiANCj4gQ1VS
TFVMRkxBR19TRUVOIGZpcnN0IGFwcGVhcmVkIGluIDguMTMuMDsgSU5TVEFMTCBzYXlzIHdlIHJl
cXVpcmUgNy42MS4wDQo+IG9yIGxhdGVyLCBzbyB0aGlzIG1heSBiZSBPSy4NCj4gDQo=
