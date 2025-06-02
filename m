Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010009.outbound.protection.outlook.com [52.103.67.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E302C324C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 04:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748836897; cv=fail; b=KImcAy2eBpPnSCDBJqhLLWc8uopMtumELC0U3Kan59zWTa9VOQ/bl9/CxSY9lC+hM8Zx2qdIIXPeh+pLHlm4CvFx/AkiiI276cVYjoCvia90qz3U+wyePz0NlXne/OfgySQOsiylTnxh5aeLGxWJ7GIGo60tBNy4/IXj/4xLFD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748836897; c=relaxed/simple;
	bh=vnn8pkVpxv0f0q5MOUnM9xRTfRjGQSs3e0sF357XP+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h9AuRLA+WK9gu25SvKpxTJ75MnPaoj8lr48jP+EcZ+73VCck64h1+azZfeSqg5ahJhMC+n86UQSHuvNcKhk59H1CQ5GG+tLsVkTEk064KsPC9piYxFukJSSAD83fe38gSV1oSbYm4n88SdDhJxV66eyKnDBIGBMMCVKGvX4snZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=R3DBKGzP; arc=fail smtp.client-ip=52.103.67.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="R3DBKGzP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF6ntFeBQNqabdS8F43Lxi3hg989z1NZMAY2vF7tyOefZOf0zEKww2YBqZuJNr4G1b+DeNc6sFrnAzVQqVUpxSPvCPHbC6pBLavHrIldstn1pfbiAp2KJnRRWRboF70KtT5rvb72AJB0RGXiO8QwkSpLu5vRpEsLZJ4is9aS+LC3dNN+A98sYMsVcsxhKaDF2iah8klFbnJLewH4p3xCe2Xj8IqA37QnI3n5ilcLPlCwBgTKB8N5g24j46XR6CoHffqK1Bur5ku9Y44vNV7x2rfVAPQJB2++BK5nwJ6uEiIBhxuNlOQfq5ZvB1Sqf8Wde6go43UbG8sM0NFj3gxrlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnn8pkVpxv0f0q5MOUnM9xRTfRjGQSs3e0sF357XP+4=;
 b=ceMr9sVy7cZXRmFWhZA2erYVb8E54BUiFl04aeooHqOnlPTx6XYHK9Jyxc7bkGpj7gj9MJBrEhb2PT+syN3Y1P8wXxjfyHKUKK8udZtDQZ7jt3j68e2OMrETPwwPXLTtedo4XgnnMatWKCsniuLhJp34PC7674EtDPDnIr7dge7nqdvBLy1oBDv9kUAWGBfJrIc008j76Ohu10oCNAuylJTav65JPNUc1gN+lqgoYcoiw3qiq6eRjuJiIIziGc40hTcNn6T2vuuj0NEM0HgpSWsmsAUG51XDWQj/vfENm6NwkV58vSy0KtskFOgmEnotm/MvFzLXI7jfw0e9pLvOgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnn8pkVpxv0f0q5MOUnM9xRTfRjGQSs3e0sF357XP+4=;
 b=R3DBKGzPe8217rKt471AqX/a4WCpdgsAgpQ0KpC7xXsRpEq/VPUpvgsuHj7QppE+kUT+tSJCx+NjclMisaizbUE4PAC/gaS2y4MTYhKHAjmFBLdz4NKzeTSL20mdbJlrlLDo1bgzIV5uEx/hSMvk1CG8RZ+SebPCBK4Q9bWACIgx9q/6jN8n5PsU6ZdawBO+l7bDf+ByoKnjMDKA2qy1DfSmI4ylTw16KZEFmHMKALeobpvd/vvVjVcXXjj5Y/hOABDYiZmJab+VAGb06/49BVOZi8OhfZKIclmGKPnghnjuA7nMX6sFIherxHbwIXOcuusWFkGBRlKdYB+1kLRV6w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PPFDF4D545D7.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a04::330) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 04:01:29 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 04:01:29 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v11 3/9] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Topic: [PATCH v11 3/9] imap-send: add PLAIN authentication method to
 OpenSSL
Thread-Index: AQHb0tCaO1p5+hstIUCR6JHCq6tqVrPvBKj/gAA7vjU=
Date: Mon, 2 Jun 2025 04:01:29 +0000
Message-ID:
 <PN3PR01MB95972182C2CDCA1BDA80B0F4B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<20250601083821.2440110-1-gargaditya08@live.com>
	<20250601083821.2440110-4-gargaditya08@live.com> <xmqqldqbvvgu.fsf@gitster.g>
In-Reply-To: <xmqqldqbvvgu.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PPFDF4D545D7:EE_
x-ms-office365-filtering-correlation-id: 29c692c5-6175-46aa-916b-08dda18a271d
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|19110799006|6072599003|7092599006|15080799009|8060799009|8062599006|461199028|440099028|3412199025|19111999003|12091999003|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?N29mVTJCNlBrZ3U1U0xDQUxVRURoT0hEMEdEazZOU2FUaHBhaG42SkJTYSt5?=
 =?utf-8?B?RTd6dHhKWjI3TnBiWW9GSHdlZ1RSZGtISy9BdUh2aXhFbUtnbXRSK1I5emo2?=
 =?utf-8?B?RjdUSW9KY3pPK0JkSlRrV1lJbkJ6QVkyVllxQzR4SmV2MUtxd2ZEazFnVUla?=
 =?utf-8?B?TzgwQkVXWm0zMnJ0b1pkZDhIL2xKclg0VzRtSys4S05HWk5pdElqbmIzbyt4?=
 =?utf-8?B?VTVFbXpNMnFaQ0hURVR1a01IeXhnT0J3a3hNRTQvSGFGMmthWHJFMUE4ckhE?=
 =?utf-8?B?UCszSFpFTG05TFU3TEVHa3o3Q2hvTEF5UnpEY3h3WG5JaHZrNklMYVM0b3ZX?=
 =?utf-8?B?VDhkajNqVVRwaHE4SmwxZHdVUXVHSmVSZ1hnRS93NGJESzJVaUxwVVhpeWYx?=
 =?utf-8?B?TGsyTmJXTzVseW9NaWNCNW9ETjJRQUhwQUkvaFRlczI5NGhmQ2IrbVNuM29o?=
 =?utf-8?B?OEUyWHFwSmpQejdwWUNMd1RkdzJCMFFsUFJlY1JWUEw0T3UxTWRZN1Ivdm1P?=
 =?utf-8?B?STZMUnRONklIN0IycjdzZWdRTVBSYWFEVXhXVlhNTXVKMWVpb2ZzMVpUd3c1?=
 =?utf-8?B?TzI3eEVUa0NLZlU0cStZcVhKY3h2ZlZkeHdiS05qZUlZc25CdVhLSmM5V2VM?=
 =?utf-8?B?VlVCOUk4WWRxMTNPL0RlZnkvSVcxWmppSjloTzI2TThUcHR5RlZQbjhudUth?=
 =?utf-8?B?c1JRclRKWFNELy8wcEt3UTdSbzNxUEl1RHhCT3RXTlhjd3VmMkx5c1Q3VEhm?=
 =?utf-8?B?TzkxaXJhL3FoNlR5eDFkTU81cGt5alRpcUVSQTViQWg2bVNZbDdiZSsrc1g4?=
 =?utf-8?B?RlFRZ3RVOEVFRlJnaDBPeE90TWJ3OW0vL0p6NDNsTExkSm96TnVmZ3dSNmxN?=
 =?utf-8?B?WXR0a3hrT3FRdzNHNFJVUGI1NllwOUV2YXRwdEVKMXZBK2NXUE5FQVUwbjdE?=
 =?utf-8?B?c2ZKWVdkMmlpRXBuYUFuTE93K1FWSm5Na21DUWNmRFRpR3BzMXdsMFNtc2Ex?=
 =?utf-8?B?alFNUGxvdHA0WTVNcVhxQmhpY2MxN25UMkVPajJRK3hzUlIvODlIRVpyaFJL?=
 =?utf-8?B?Sm1hd2RuN24rUm5TTzBrT1pNc09adnREOVhtMzhpdExVRi9uWjFrdHFZY3E2?=
 =?utf-8?B?TGtNQ2FudStYT0s5SlZPdkVXejd0YTc1ejFHdUoxV1NBZE5qMzg1TW41WDA1?=
 =?utf-8?B?eUo0d28rTURsbnhpbmJ6SG15WHZ0RWo3OWkyUHEvemVuZnl5b01kbGlFWXlR?=
 =?utf-8?B?aTF4M05oNEZnZE4yTkhySDZiOWZVTlJmVitqeWluaHBFQ2NPUmY2RzZkYXZ2?=
 =?utf-8?B?MjRrMUI5VCtwWmlFUlc2di94MWM3U3M1UUZGQzRvckpNdlYrQlFCNndYakw1?=
 =?utf-8?B?N1IyOWNnNkNURHhpNEVWTmpKNi84L3pJbVo2OE5JMlVrbkZ2aDVISkFjV1lU?=
 =?utf-8?B?MmRiZTFOUmNrWDIxT0RSNUJpMjA1VjBNL29NZlVMWWNHcG1EYy9sTUZXeE41?=
 =?utf-8?B?ZWJnbk1jdGI2WEtlQTdZaDVYK3JYOHl0aDN4ZTRvWVVsV2UrejBXZFRabzBS?=
 =?utf-8?B?UEt5UVhMT25aalZHMkRIOVpnNW9iY3BoR05jYzFpMHU0WkpTNEV0dzhlbUEy?=
 =?utf-8?Q?lZOAjMXn+ph0JZbmAgvObexl+zX4O0s7DUwHUE878x8E=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1U5emJyZWRjRlFzWEdJVU9vVWk2c3lac2pscElRVURaWEpXTWlOTmlBVklU?=
 =?utf-8?B?ajlQUG9kYjJDUk03WUR2bVRBT1NZazlzMXdiWU9WTk1DekxrdUdqQkhUUTds?=
 =?utf-8?B?Nm04Z1N6Q3FVeDZNeWxhVTJEMHdUbGFTT0MrYXpteUpDZ08zTGFDUk8wN3Rk?=
 =?utf-8?B?amxvbklhWllpNGF1TFVwSW16clBqSUxybkxicklsTWI3TDZqNVYzODFqd01u?=
 =?utf-8?B?UjdLZzZDanhmUThRSC8zWjgzU2NpN3N0WFpFMmQrYk00cTNKcUZKdDEzRTMw?=
 =?utf-8?B?Z1dybkI0YmJTalNQblJDTWZWY1FYY25nTU45TzBuclVMVlJyb2RBVnJXdGN3?=
 =?utf-8?B?cXBxTGZZazgzWGpkYzBjalRBRktzV3lzdjNJSEdTOVFETkhKOVpYYlNRTEJl?=
 =?utf-8?B?d2xzdGt0NnkxM25TM2d2Z2dWNnlhQ1BlbUNmajJPeUpXb2E4R0NBeHFWd1Mv?=
 =?utf-8?B?OHE5SWVqaTBrOGxFWjFRT2lGL3gyaXJvSm5YV29DdVFMVVBKMlk4dXlGOHlM?=
 =?utf-8?B?WDQ5MmM0WURyWHBQNUtlbW5adkNvV1NEazdhMitpL2VaajZzUGVHQ25seGtN?=
 =?utf-8?B?SWp1aWpzOEVXdFVRWEppNE1KK0RkMTZPb3ZxMDNpL0sxOTY3VmJzd1Z1TjBN?=
 =?utf-8?B?clNjSm80RDR4QmUwa21iamdqd1lFaDNtZ2Z6ZFdpVnJORWJHMmVNSmkxWGgx?=
 =?utf-8?B?anlNSWN3dXdnU0h5YlFhc2szRi92S2Y0Ylh2NEk5WC9IMVlXZUNIOWIvSGcw?=
 =?utf-8?B?MkNWcC9IOXdIcWpYSmZsTUVTeTYvNTY2Y2hRSmcxRVkwUEFxUS92Y2hQSVlU?=
 =?utf-8?B?R2xIZnMzVFBVby9QbC9zazZGc1BaKzNyUm1Md0FVdmxqYis0SUlVdWd2eG5B?=
 =?utf-8?B?aGVIdTVCWUFQZXNQYW5DMEtGZWR3RjlwcndMNmc3eEtEa2ZPeXJTR3pLMHNB?=
 =?utf-8?B?STN0UWpLcnRVWTJNQmJFVzRoaytsLytHL0liL0pWWVZiR05qRVhvUVZsQWlj?=
 =?utf-8?B?T2RxYlB6UFJNM3o1YXkzOWdKOVkySWh5TjhKUk9PZ2YxNkRnZ044VG9ldU5w?=
 =?utf-8?B?c3lVWTJnY0tCcTg4NHFESzlYNVJmWXJ6UGNQendRRXFsUWlwUHZ4TnZnckZZ?=
 =?utf-8?B?VHNyM0NtS2JuelVCb2crVTVUbnVveGZrNzUvdWl6QVlxTDc3cTlMazhRQ2Vp?=
 =?utf-8?B?UGdQeFlObS9paEpXTGpzekU0L0xOZHlMQWpkcUhBcjBNMHZ3NTRmL0Z5Tzdw?=
 =?utf-8?B?YkkraU5lQURmdkhNMFUxUTFteGt4ZGNFVTN6ZDBlWVhqdUxWL0dhbVQxTUQv?=
 =?utf-8?B?UkUzeGh0Q1RzaFQyNUZRMzd6Ri80RXFCUGhvRm5iTEY3Y0tkUTdBNmM2NUht?=
 =?utf-8?B?OSs1bGtkT2FHanpPeTJqZ0JrUVpCOUFDZXREczVVa1c3bG54NnMvdWtJejE4?=
 =?utf-8?B?Rm54bGthN0hSR2wvQ0RlWEhNZlFGb1FWM2czbVVCM1VxaXZ2MllYdGZaL0VT?=
 =?utf-8?B?OE40U1V4U09TWDNacDIvbjhHdUIyMnhFcmdObWRpQlUwYThrUkp0VWc3KzlM?=
 =?utf-8?B?WnREMXpBOGJWdWIrTTVnclFycEZ4NUhTQ0FYejI0OHAwdFE3TTBjWFpsWUpI?=
 =?utf-8?B?VW5IUmNRclQybG5oOWtJTFozaldzamJFaDJtZ3FBYUdkWDNQaExjT3kxSitq?=
 =?utf-8?B?TllDMWd4V1JQa1E4RkpTYnlOb0RiSy9jUUI4N1pjZUxMR1NVQ0lvSkVZWmFo?=
 =?utf-8?Q?OEG8hZ8HtynlkVhESM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c692c5-6175-46aa-916b-08dda18a271d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 04:01:29.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PPFDF4D545D7

DQoNCj4gT24gMiBKdW4gMjAyNSwgYXQgNTo1N+KAr0FNLCBKdW5pbyBDIEhhbWFubyA8Z2l0c3Rl
ckBwb2JveC5jb20+IHdyb3RlOg0KPiANCj4g77u/QWRpdHlhIEdhcmcgPGdhcmdhZGl0eWEwOEBs
aXZlLmNvbT4gd3JpdGVzOg0KPiANCj4+ICNlbHNlDQo+PiANCj4+ICtzdGF0aWMgY2hhciAqcGxh
aW5fYmFzZTY0KGNvbnN0IGNoYXIgKnVzZXIgVU5VU0VELA0KPj4gKyAgICAgICAgICBjb25zdCBj
aGFyICphY2Nlc3NfdG9rZW4gVU5VU0VEKQ0KPj4gK3sNCj4+ICsgICAgZGllKCJZb3UgYXJlIHRy
eWluZyB0byB1c2UgUExBSU4gYXV0aGVudGljYXRlIG1ldGhvZCAiDQo+PiArICAgICAgICAid2l0
aCBPcGVuU1NMIGxpYnJhcnksIGJ1dCBpdHMgc3VwcG9ydCBoYXMgbm90IGJlZW4gY29tcGlsZWQg
aW4uIik7DQo+PiArfQ0KPiANCj4gVGhpcyBjb21tZW50IG1heSBhcHBseSBhbHNvIHRvIHRoZSBl
YXJsaWVyIE9BdXRoIHJlbGF0ZWQgdHdvIHN0dWINCj4gZnVuY3Rpb25zLCBidXQgdGhpcyBpcyB0
aGUgIiNlbHNlIiBzaWRlIG9mICIjaWZuZGVmIE5PX09QRU5TU0wiOw0KPiBkb3VibGUgbmVnYXRp
b24gYWx3YXlzIG1ha2VzIGFsbCBvdXIgc3BpbiwgYnV0IGluIHNob3J0LCB0aGlzIGlzDQo+ICJZ
b3UgYXJlIG5vdCBidWlsZGluZyB3aXRoIE9wZW5TU0wiLiAgV2UgY2Fubm90IHF1aXRlIGxvb2sg
YXQgdGhlDQo+IHBvc3QgY29udGV4dCBvZiB0aGlzIGh1bmsgZm9yIHNhbml0eSBjaGVjaywgYnV0
IGluc2lkZSB0aGUgY3JhbSgpDQo+IHN0dWIgZnVuY3Rpb24gLi4uDQo+IA0KPj4gc3RhdGljIGNo
YXIgKmNyYW0oY29uc3QgY2hhciAqY2hhbGxlbmdlXzY0IFVOVVNFRCwNCj4+ICAgICAgICAgIGNv
bnN0IGNoYXIgKnVzZXIgVU5VU0VELA0KPj4gICAgICAgICAgY29uc3QgY2hhciAqcGFzcyBVTlVT
RUQpDQo+IA0KPiAgICBkaWUoIklmIHlvdSB3YW50IHRvIHVzZSBDUkFNLU1ENSBhdXRoZW50aWNh
dGUgbWV0aG9kLCAiDQo+ICAgICAgICAieW91IGhhdmUgdG8gYnVpbGQgZ2l0LWltYXAtc2VuZCB3
aXRoIE9wZW5TU0wgbGlicmFyeS4iKTsNCj4gDQo+IC4uLiBpcyB0aGUgbWVzc2FnZSBpdCBkaWVz
IHdpdGguICBTbywgc2hvdWxkbid0IHRoZSBlcnJvciBmcm9tIHRoZQ0KPiBuZXcgc3R1YiBmdW5j
dGlvbiBhbHNvIHNheSAiSWYgeW91IHdhbnQgdG8gdXNlIFBMQUlOLCB5b3UgaGF2ZSB0bw0KPiBi
dWlsZCB3aXRoIE9wZW5TU0wiPw0KDQpObywgdGhlcmUgaXMgYSBkaWZmZXJlbmNlIGhlcmUuIENS
QU0tTUQ1IHdvcmtzIE9OTFkgd2l0aCBPcGVuU1NMLg0KT0F1dGgyIGFuZCBQTEFJTiB3b3JrIHdp
dGggQk9USCBPcGVuU1NMIGFuZCBsaWJjdXJsLg0KDQpBbnl3YXlzLCB0YWtpbmcgY29tbWVudHMg
ZnJvbSB0aGUgT0F1dGgyLjAgcmVwbHksIGxldCBtZSBzZWUgaWYgSSBjYW4NCnJlbW92ZSB0aGVz
ZSBzdGF0ZW1lbnRzLg0KDQo+PiArc3RhdGljIGludCBhdXRoX3BsYWluKHN0cnVjdCBpbWFwX3N0
b3JlICpjdHgsIGNvbnN0IGNoYXIgKnByb21wdCBVTlVTRUQpDQo+PiArew0KPj4gKyAgICBpbnQg
cmV0Ow0KPj4gKyAgICBjaGFyICpiNjQ7DQo+PiArDQo+PiArICAgIGI2NCA9IHBsYWluX2Jhc2U2
NChjdHgtPmNmZy0+dXNlciwgY3R4LT5jZmctPnBhc3MpOw0KPj4gKyAgICBpZiAoIWI2NCkNCj4+
ICsgICAgICAgIHJldHVybiBlcnJvcigiUExBSU46IGJhc2U2NCBlbmNvZGluZyBmYWlsZWQiKTsN
Cj4+ICsNCj4+ICsgICAgLyogU2VuZCB0aGUgYmFzZTY0LWVuY29kZWQgcmVzcG9uc2UgKi8NCj4+
ICsgICAgcmV0ID0gc29ja2V0X3dyaXRlKCZjdHgtPmltYXAtPmJ1Zi5zb2NrLCBiNjQsIHN0cmxl
bihiNjQpKTsNCj4+ICsgICAgaWYgKHJldCAhPSAoaW50KXN0cmxlbihiNjQpKSB7DQo+PiArICAg
ICAgICBmcmVlKGI2NCk7DQo+PiArICAgICAgICByZXR1cm4gZXJyb3IoIklNQVAgZXJyb3I6IHNl
bmRpbmcgUExBSU4gcmVzcG9uc2UgZmFpbGVkIik7DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAg
ZnJlZShiNjQpOw0KPj4gKyAgICByZXR1cm4gMDsNCj4+ICt9DQo+IA0KPiBBbmQgdGhlIHNhbWUg
Y29tbWVudCBhYm91dCBub3QgZ3JhY2VmdWxseSBmYWlsaW5nIHdoZW4gb3VyIHNpZGUgbGFjaw0K
PiBzdXBwb3J0LCBldmVuIHRob3VnaCB3ZSBncmFjZWZ1bGx5IGZhaWwgd2hlbiB0aGUgb3RoZXIg
c2lkZSBsYWNrcw0KPiBzdXBwb3J0LCBnaXZlbiB0byBhbiBlYXJsaWVyIHN0ZXAgYWxzbyBhcHBs
aWVzIGhlcmUuDQo+IA0KPj4gQEAgLTEyMDksNyArMTI3MywyMiBAQCBzdGF0aWMgc3RydWN0IGlt
YXBfc3RvcmUgKmltYXBfb3Blbl9zdG9yZShzdHJ1Y3QgaW1hcF9zZXJ2ZXJfY29uZiAqc3J2Yywg
Y29uc3QgYw0KPj4gICAgICAgIGlmIChzcnZjLT5hdXRoX21ldGhvZCkgew0KPj4gICAgICAgICAg
ICBzdHJ1Y3QgaW1hcF9jbWRfY2IgY2I7DQo+PiANCj4+IC0gICAgICAgICAgICBpZiAoIXN0cmNt
cChzcnZjLT5hdXRoX21ldGhvZCwgIkNSQU0tTUQ1IikpIHsNCj4+ICsgICAgICAgICAgICBpZiAo
IXN0cmNtcChzcnZjLT5hdXRoX21ldGhvZCwgIlBMQUlOIikpIHsNCj4+ICsgICAgICAgICAgICAg
ICAgaWYgKCFDQVAoQVVUSF9QTEFJTikpIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgIGZwcmlu
dGYoc3RkZXJyLCAiWW91IHNwZWNpZmllZCAiDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAg
IlBMQUlOIGFzIGF1dGhlbnRpY2F0aW9uIG1ldGhvZCwgIg0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICJidXQgJXMgZG9lc24ndCBzdXBwb3J0IGl0LlxuIiwgc3J2Yy0+aG9zdCk7DQo+PiAr
ICAgICAgICAgICAgICAgICAgICBnb3RvIGJhaWw7DQo+PiArICAgICAgICAgICAgICAgIH0NCj4+
ICsgICAgICAgICAgICAgICAgLyogUExBSU4gKi8NCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAg
bWVtc2V0KCZjYiwgMCwgc2l6ZW9mKGNiKSk7DQo+PiArICAgICAgICAgICAgICAgIGNiLmNvbnQg
PSBhdXRoX3BsYWluOw0KPj4gKyAgICAgICAgICAgICAgICBpZiAoaW1hcF9leGVjKGN0eCwgJmNi
LCAiQVVUSEVOVElDQVRFIFBMQUlOIikgIT0gUkVTUF9PSykgew0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgZnByaW50ZihzdGRlcnIsICJJTUFQIGVycm9yOiBBVVRIRU5USUNBVEUgUExBSU4gZmFp
bGVkXG4iKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgIGdvdG8gYmFpbDsNCj4+ICsgICAgICAg
ICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgIH0gZWxzZSBpZiAoIXN0cmNtcChzcnZjLT5hdXRo
X21ldGhvZCwgIkNSQU0tTUQ1IikpIHsNCj4+ICAgICAgICAgICAgICAgIGlmICghQ0FQKEFVVEhf
Q1JBTV9NRDUpKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICJZb3Ug
c3BlY2lmaWVkICINCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIkNSQU0tTUQ1IGFzIGF1dGhl
bnRpY2F0aW9uIG1ldGhvZCwgIg0K
