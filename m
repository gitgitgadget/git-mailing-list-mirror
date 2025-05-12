Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011030.outbound.protection.outlook.com [52.103.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D63433CB
	for <git@vger.kernel.org>; Mon, 12 May 2025 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747036182; cv=fail; b=VekFp1dlCPx0+1IOY/+kWMPh1verPLrSlwPgg9blHBI8mLmYydwH4ZCqu0KIE5wICQ/waKlvWHnj9tYPvzLxxSNUv5fHkDKFZrqMXJzKWk27uL/mR2AKKuX2uTXtgSkpK01O/DV1ElrKAydfxc+VmFL++q0u22ZgnBBAIy4tr30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747036182; c=relaxed/simple;
	bh=f8KJWPUEEHKEBkScYOy32OeMtZCMcDLOOKguu7jOnuw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g36moMf04mSqmf4U0WzPC/Zpxf1gF5uVfY7Gnm1L6FNXdRNRBGttHacXQtjEi1jc8C2aMPc7dofCCwxQJ1Lbxr65LJ3a1EPPzHWkpOtP7KJzKk/g3H9i3o2vdaiuuKQHGMJ7OwnNF2MfNOx9T2pVL4rql0xLnWuOwGaQFclcdyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jokVOdgv; arc=fail smtp.client-ip=52.103.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jokVOdgv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MC1wCG/84DmYkQ4OF8goARHbvhTizh02ryLIEAZ76pfULrA/kvS3FcK6MiS0HWxGhuzfdyr11m/kIprLWeRQN1Np6xWtcG/0wbgYh0jsAn2Yz2tc60ZUBjMLIDQLFn5km4/RTA9XjiCOZHfxi5w99nkz+rGQpochXokT+zFt1PDazYSVN60vKEecksHYrRKV2ixwG1VTs8x3R7u+d460dHv4ytvAcDBK7bCQ+ZCrJzf9vzwiNjWh6X1DPWUSaA4BlE2IYej4ezrmXe+JhmTewSzRwNqrxRtjfyP4W7lQlfOw8EtGqhsmrRCdU/ixgFVRtr6kKNinoKvlaJfYpO+fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8KJWPUEEHKEBkScYOy32OeMtZCMcDLOOKguu7jOnuw=;
 b=gT+zXrvH8ItuXIitpwo2tuoJfeXVnaiYb0VeHSjoC1yN/oMK9SgkT8/UDh1+b1byrlgOH29pWFC9xf/60DHsA567RH/0aNUvQQ4r3o8u1w+cUf7vBia9s0Lgn8Q2juDdwz8bHu+by95AZznfaq1CnuEaqp/m8+ACoWVxBMez+fUafO2VZ7LuZVlCm4/DGYMWGEnNN64Xfz+s28OZiS592rLJaYwV8IsfYJQgUQf+FUgdIMkvDf6iyVfjLsOUDPIpXNwPyBdXwY5ngnflH+LjJSiJqQ/7YbY/5dqIcnFYt3/6cXXvyEz8Oud4LVRznVOTYcDAxdvNxXJw/pbC+VJ3SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8KJWPUEEHKEBkScYOy32OeMtZCMcDLOOKguu7jOnuw=;
 b=jokVOdgvZwObpv0rwnCiZqVcDUjG63KGfC1YasmIqI9lSumMXyxaJuP1WKhG4cq3a4uaUuJQHcqY3OmcKtk7NGezmRzwaiOum+KoYfRaz/bXRqMI8P4Rlh48qLgj/1VsrK7QQiLJuyEljIAf8YH5vfpm3Duqo9pkCdaO1n4oEbqnUKXH8NipwN8nEy5xRK96PezXhIYHqMGV4z/Pk+zg75q4+pNZehvhCFdmGaXOI+conNBMjZe/uZlLSYteG3ZG9tMJl3XC2NBql1gwY7Kl+oDNnfEFiMqFL+n0hCPHXAF7mCCZrouAY1OdLACGJLB6HMUoeTl+O4eIAK/A24TF3g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA1PR01MB4355.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:11::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 07:49:36 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 07:49:35 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Junio C Hamano
	<gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>, Zi Yao
	<ziyao@disroot.org>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] send-email: try to get fqdn by running hostname --fqdn
 on Linux and macOS
Thread-Topic: [PATCH v2] send-email: try to get fqdn by running hostname
 --fqdn on Linux and macOS
Thread-Index: AQHbwX6JzjtAxyUkKkmtcSJbF/t7h7POoNeAgAAA+r0=
Date: Mon, 12 May 2025 07:49:35 +0000
Message-ID:
 <PN3PR01MB959732CE8360446CD4E0A184B897A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB9597C419019DC28E489D2AF9B88AA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BC2E1B526A11D21BAB24B895A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>
In-Reply-To: <D9U0KAX6KVXK.WCY7YGX2Q0A5@swagemakers.org>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA1PR01MB4355:EE_
x-ms-office365-filtering-correlation-id: 014651f1-018f-41cc-3ce9-08dd91298a18
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|8062599006|15080799009|19110799006|6072599003|461199028|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?clk1eHhuR1JWWGJlbzRYdDllZlZhN00zSXh4cG11aTQxa0hCWmo2aG4ySjlR?=
 =?utf-8?B?T3JScXRWdndWcHlRM1d3Q0Z1Q05WTFNndXlCS0FCY1ViYm5lZngyb0NBdnRk?=
 =?utf-8?B?WDcxQjFQeFBwSkVQa1Y5UUtpNFRxdmJ1RCszZWJBTkpHLzFqbXNUVGNOZEg4?=
 =?utf-8?B?a3VIZWR2UFJGbCt5amVubEZ6bFROOVA3MFNNakRmaDArSllKWjFFdFhlTHZ5?=
 =?utf-8?B?YllpRUhiLy9OSGQ3YzY2ZW1BYUkzb1Z1S1l5MlRwaEFPNTdNblExRUJLZmRy?=
 =?utf-8?B?NXdPbm1JbEp1VE1ZYTNod0J0eFFhazBTb3ZQNWxoNWpjVmZ1T3FGTnBnMGxw?=
 =?utf-8?B?UFZIaHRrVkY3ek8ydE5TaUFONHZ6Z0hWbmFRVkRWeGwwQ1p1YjI3SmV1WjVp?=
 =?utf-8?B?VnVPOUFycm4wMlBoUFI3TGRkc3kvQ3JXZ3NldlNVMjlINzg3ZlJqUWRKYlJl?=
 =?utf-8?B?U1hlYVhQaFo4OVlTTHdLVmV0V3k3MzRIeHFhWkJCS1pCcFJsZnZFcHIrbjMw?=
 =?utf-8?B?UFV1dTJHOE1CSHNEYzRYRk00YUtwWU85QlFDYWxjenhmWmJobEQxSDd4SHA2?=
 =?utf-8?B?TFBzMVpBTFduUU5CVnB4cTVLd1g5UzZZNHh0V25CM1FaVnEzazZXUXk0aTRB?=
 =?utf-8?B?bUx0YkFKcnptdjd2N2tqVkd3NHZ1cVovS25rbTEvdWFIQXNjWThaUElJNDhE?=
 =?utf-8?B?Y3g4OGM2c2ozLy9JU1ptQ3ZNRk93YS9ucEFrTzQ3aDhGZVZlUC92R2NhZU1k?=
 =?utf-8?B?TTRVL21raFg4MHZyS1plcUVMOTZaU1Bhd1FtbHRlWSswRmFxc0piTTViS2Zr?=
 =?utf-8?B?NE9wTmhiMnh3NVdpYlZLZEYrWDJDV3piTUNZVlJGRFZYU2lUNjlaUTh3V1pI?=
 =?utf-8?B?bmMxMXpRcEsxUHNEOENhMUFvckZvbm5PZEFsTEdWNlUvSmcxd285bm9aN0k4?=
 =?utf-8?B?dTlqQVdZcGxpUjRaSjdVWHJRampWa3MwVmpBUkdhc0ZjajExNnVMbU1PS1dX?=
 =?utf-8?B?Y2pEQ2dVdjl1Uk5HUDFDNGxCdVpQTi9DSFIrN2Q4MitSdW5YKzhjZ3hYZmRl?=
 =?utf-8?B?QzgzVjVvNE4xVzF3VEd3R054NGtLbHdBaGJrcTlkdHN3RlJYcnNsVEgzZkVX?=
 =?utf-8?B?RXlDMVR5LzVobHJIZG5YbUpkY2Y4VXUvMFpJSmJwd1hrN0lrSXJKN3QvRC9y?=
 =?utf-8?B?S0w0T3Y4OUJkUDhHZWdmR3pKWTVmbEp6WWVzUC91WFRQYWJnKzZiZmZnWm5P?=
 =?utf-8?B?MVNyc2F6eXFsNXRFK1pNUlU4UDJOTXhmb2xpUlgxbFhqUkdkNUdKWkxVMk1s?=
 =?utf-8?B?QWlTQllidGtqaSthaWxVaHlPZFVsRTQwd1RXUmFSVW1yNWVvOW8wL1kyWnB6?=
 =?utf-8?B?MUsrOEg4YkUzSVhTRGRvL0JkZW9OVW94VytpZktSWVNEZHRRT2lxRER6ZUpY?=
 =?utf-8?B?eVgwSVZWeVZaY2ZUdUt2dlJ2a3pmV3o1alllY2tQUnRFWExaaWJhU1R0ZEQ2?=
 =?utf-8?B?dWNUOG12THdoVzZZQnA5T09kZDdLcXBDQVhwTFJpekxtVmd0L0dBckNHMEFv?=
 =?utf-8?B?UGc2UT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzgrZVZ5UVVmWE45blZ6UG5kK2pjTFB5K0grSm5SQzNNdjByU1ppUkhxbUlj?=
 =?utf-8?B?R2F2by9LVExBSDVPeVM4dkJHUi9SU29xa0ZtRmJCUmZLMnJ6enBlbC9tVXRu?=
 =?utf-8?B?RUdrQ3VlSENmTHlQV1dBU1BYdUd3dFNqZll6ZTg4U1VucTFJYXBKM2FiMTdI?=
 =?utf-8?B?eGNPZGFiVFM5QmNrTXROaElqenErdmN5UmU1aERCL3Rqcy9aczhRMS91R1JE?=
 =?utf-8?B?aUswM2JTRGNaZDFRNDZweHdrRkNWWWRpYkJKcnczV1pZVmY5dGRURmxPNnNp?=
 =?utf-8?B?NTVTckZwRWUyZEtwaldtTTVtUnltTHZidFM2OXM1Wm5CbTYwMDM3SWkxYjdH?=
 =?utf-8?B?T2I1VDVuM2dyRVFpUUZ0U0NaYVRnd0dRWTRWeVdBaWVZdVZCRG1nNndqL2Rj?=
 =?utf-8?B?UlljemlyaUVNb1JLQWJBaHo4ZzNIN09uUUtxZU9WWXBaL2tPYWJIdzJ6cklZ?=
 =?utf-8?B?NWdIYk9WUFlob294NTdRMWZnR1NKN20wZDBoa1hhdmIyVEFKTXB5Y1gzU0o0?=
 =?utf-8?B?SHhEc0pXWVVtSjFkTi9Ebm11Rno0bjhUUm43MlVJTFBEbEs1bnFzOTM5Qnp0?=
 =?utf-8?B?bTNmY092RzRpaVhEVUtvZjd3R0dkLytieEpWdDBDNGNOTWRMalkwenMydkhq?=
 =?utf-8?B?L0ZyU0s2MW9YcEZEcTJWN0FCR3c5WHU0QjdPOGkvQ3BDMGw1T0MzK0lncEJy?=
 =?utf-8?B?QmtYSU5KenRtd2FJQnFXWW8yeGdPT1hFZFhNVXp5d25VcFZ6NEVZT09PcGpr?=
 =?utf-8?B?bzhISEp2dVJWdmNYM3VBcmRPWVhHRHdDN1g5MWtJdTl5Y25HVEw1NXVSeEVL?=
 =?utf-8?B?RkFKYzBuSnlPOC9WbHBpQTF2Y0VrVWlRV3F4VUZRUFhzbW1PRTRBbHVldHN5?=
 =?utf-8?B?a2NSdldxTVBOK2xhZXZDNnhRTVpEU2xIMTR3dDNWT0g1SDF0ZVc5OXh0MjhI?=
 =?utf-8?B?elhrNTJUTFZsamxzV09Hclo5OWd5ZnZaNTdIYWhVdWN5a2lkZTVGczVLemFk?=
 =?utf-8?B?SDNsQW9ZZi9kVkt3c1R6SitQM2x4Q0dkNFZDcUdtK3AwNCtpbFp2bG4rcEEz?=
 =?utf-8?B?MnhFejErL09XQkdYT2hVV2hIU3JuVWlzSmdGeWNxR0I2bGl3RHdTRGVaRHFv?=
 =?utf-8?B?cFU5Y2hsNjlaRVA2aXo5NXdSOUdlbDlwM3VEUlJ0enFZVDJzbGdJV1FRM2dw?=
 =?utf-8?B?VXNMenF4TUJRZDNET0dXS3ZBMUYxeU82MEYwVWJsNzRoNlBRelNOY0k1VXlC?=
 =?utf-8?B?Qlp2OWxoVCtoUTg2NU9SRHhKWWZHZkxLbnZmUUFHczRYbkhMK3VjMlplRDJy?=
 =?utf-8?B?R1VPWUxNT2VuMlc4THRWOFE3SVBnOTRsNVZpR3VERFZSblRsbVczUUJFTERW?=
 =?utf-8?B?TkRla2pUakdGZDlnOGRXSHlNdFF4eFk0Zzh1N3Z2K2V5dnltcFhhaWlvWVdW?=
 =?utf-8?B?cm5wZUQ3c3BmK0FCK0Vnalh6MVVROGl5NXFyNGtxcUREZ0ttdnJuN2VIYVBY?=
 =?utf-8?B?M1BzYWhpbHQ0V2xIOEpXNlV6NitveldXYjRFWGwwaGdmbFZYOVJnOHVhbEJN?=
 =?utf-8?B?SW5uR0JyTTRmL2MvRm9PcHM4STVKVnRVZ0wxZGtrTlM2L0daQkUwV3JrTDFM?=
 =?utf-8?B?R1I3aStPazY1amNRZXh5NVNZV2ZPVVZjQTJIQVFXcEh5cWExRTdzOUtGeWti?=
 =?utf-8?B?SU9lL2xUME5lUFJMa2d2R3pRMEU0dCsxbTlMV0JjTUFISUw4UGRNWUJSV1Fs?=
 =?utf-8?Q?m/1xv63JQASvgGVZYM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 014651f1-018f-41cc-3ce9-08dd91298a18
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 07:49:35.2938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA1PR01MB4355

DQoNCj4gT24gMTIgTWF5IDIwMjUsIGF0IDE6MTbigK9QTSwgSnVsaWFuIFN3YWdlbWFrZXJzIDxq
dWxpYW5Ac3dhZ2VtYWtlcnMub3JnPiB3cm90ZToNCj4gDQo+IO+7v09uIFNhdCBNYXkgMTAsIDIw
MjUgYXQgOTozNyBBTSBDRVNULCBBZGl0eWEgR2FyZyB3cm90ZToNCj4+IGBob3N0bmFtZWAgaXMg
YSBwb3B1bGFyIGNvbW1hbmQgYXZhaWxhYmxlIG9uIGJvdGggTGludXggYW5kIG1hY09TLiBBcw0K
Pj4gcGVyIHRoZSBtYW4tcGFnZVsxXSwgYGhvc3RuYW1lIC0tZnFkbmAgY29tbWFuZCByZXR1cm5z
IHRoZSBmdWxseQ0KPj4gcXVhbGlmaWVkIGRvbWFpbiBuYW1lIChGUUROKSBvZiB0aGUgc3lzdGVt
Lg0KPiANCj4gVGhlcmUgYXJlIG11bHRpcGxlIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgaG9zdG5h
bWUgY29tbWFuZCwgYW5kIHRoZXkNCj4gZG9uJ3QgYWxsIHN1cHBvcnQgYC0tZnFkbmAuIEZvciBl
eGFtcGxlIHRoaXMgd2lsbCBub3Qgd29yayBvbiBBbHBpbmUNCj4gTGludXggYXMgd2VsbCBhcyBt
YWNPUy4NCj4gDQo+IG1hY09TOg0KPiANCj4gICAgJCBob3N0bmFtZSAtLWZxZG4NCj4gICAgaG9z
dG5hbWU6IGlsbGVnYWwgb3B0aW9uIC0tIC0NCj4gICAgdXNhZ2U6IGhvc3RuYW1lIFstZl0gWy1z
IHwgLWRdIFtuYW1lLW9mLWhvc3RdDQo+IA0KPiBBbHBpbmU6DQo+IA0KPiAgICAkIGhvc3RuYW1l
IC0tZnFkbg0KPiAgICBob3N0bmFtZTogdW5yZWNvZ25pemVkIG9wdGlvbjogZnFkbg0KPiAgICBC
dXN5Qm94IHYxLjM3LjAgKDIwMjUtMDEtMTcgMTg6MTI6MDEgVVRDKSBtdWx0aS1jYWxsIGJpbmFy
eS4NCj4gDQo+ICAgIFVzYWdlOiBob3N0bmFtZSBbLXNpZGZdIFtIT1NUTkFNRSB8IC1GIEZJTEVd
DQo+IA0KPiAgICBTaG93IG9yIHNldCBob3N0bmFtZSBvciBETlMgZG9tYWluIG5hbWUNCj4gDQo+
ICAgICAgICAtcyAgICBTaG9ydA0KPiAgICAgICAgLWkgICAgQWRkcmVzc2VzIGZvciB0aGUgaG9z
dG5hbWUNCj4gICAgICAgIC1kICAgIEROUyBkb21haW4gbmFtZQ0KPiAgICAgICAgLWYgICAgRnVs
bHkgcXVhbGlmaWVkIGRvbWFpbiBuYW1lDQo+ICAgICAgICAtRiBGSUxFICAgIFVzZSBGSUxFJ3Mg
Y29udGVudCBhcyBob3N0bmFtZQ0KPiANCj4gQWxsIHNlZW0gdG8gc3VwcG9ydCBgLWZgIHRob3Vn
aCwgbWF5YmUgdGhhdCB3b3VsZCBiZSB0aGUgYmV0dGVyIG9wdGlvbi4NCg0KU3VyZS4gSSB3YXMg
dXNpbmcgLWYgYmVmb3JlLCBidXQgdGhvdWdodCAtLWZxZG4gd291bGQgYmUgbW9yZSBpbnR1aXRp
dmUgZm9yDQphbnlvbmUgcmVhZGluZyB0aGUgY29kZS4gRGlkbid0IGtub3cgaXRzIG5vdCBzdXBw
b3J0ZWQgZXZlcnkgd2hlcmUu
