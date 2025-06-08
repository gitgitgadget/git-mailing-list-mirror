Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFA204680
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380203; cv=fail; b=oOll7BaG5jdJq4tpB9SSnl6vnE5Tdf318GXdinMn67i4TwDxbdL5i1HX16bT0jmhen/zmNyVpVz92GQQ/n16MWmtQTe0LGRDo9HUUXx8RrUzckxOu/wadeEQYwcoty5TU/jEQrR1gH+niqfqMdhZfrLZZikW6btuAQZIEkRTrqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380203; c=relaxed/simple;
	bh=rhxYi0aQLPGaxMeeqxRJRpBn+SdLWV4rYQ2bB3ul1Ic=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NZqN8We2eY/nq+5IH1cC2za/iuFJy/T7Tm0hh3C9dW1yaGkv0URU8YIpik9JyaH2/5/pKTep93iCCF9To0xHFRZ83IlpfdVDuEfM1t6vkNoqLRUVx3EfU1zfXIMAn3GrMeJ4cf9eTaWPSmGvkqcG/NRuIEzAkQvf44rGefc+fMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=jVou80jZ; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="jVou80jZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTp6qFdabXebQM3xQDKztC1nvksBVkxiMeS+Nr2sgwCqIqNXbzraJCbElbI2hN6gDEOxLf4AKnpSBVZ2q01XIkADlpKjandKh9fYShrFiSNlxyVORwn43LSlBP+9CF677+iCRNIYpGavFJ9vpZaOOWHdCXs2c0BLZyuBgC4Q+dt8fDMBICzrinTi8sUccrKjBKb5l4glY0RjdsorZ2Z+kjmAQNRgiI6V/QmSM2oSpjhEWk35VIbxqyj5rcay68Ad1jlLflyp0KoijBjcD31x2L07VsUJ+qCfT2YXKbGbHvtgg4eZHZWm9JukMJ1bsCMJsNOM1JoNDCZh3CYAPW9uCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhxYi0aQLPGaxMeeqxRJRpBn+SdLWV4rYQ2bB3ul1Ic=;
 b=meds7U3LYYhSdtf3CK27t8bTK8tjkIOwTNmIVA3nThnL7QoiJfDnhWAaVe3xyT5UJNzktTZPfPomHoQb+vB3H8XOc0tYUrLfEWvL5heNd5uUAvEvAcwWHK1dMEpYN7qlQnHPIBVKseL4wfp6pmm44dd96aH0qklzGGT2R5YVKLuPczwLmBOoi300Qa/Bete4WTmyALtju6n+jvqGBTM+WuAtpIaOxGbhR+bIhuQ/xteLCfkH3qrSox/47cIV9DfBCC1HJYUDnpGKILuKb590eHF5DY56+vKmZN8Ri/i+Mb52+4Pnl2qz7Yw2wLvWItz8jugCv1qvhhhRR20DDHi1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhxYi0aQLPGaxMeeqxRJRpBn+SdLWV4rYQ2bB3ul1Ic=;
 b=jVou80jZi0nuQtrMbT5YrPwm/XRjhzbCOp97pkpURChjCqFXmnBwK9b17cE1d8Q0S6Z5mD472NNRLqEs7bEZlAsU0JRNtn4Da0NtniU18R314vsBJA+piSMPlJFBqqPJ99/zuUlAqv6NwqNheBXNSRkspuvaYnr8YYBqXHbrs8ZLr2ORsbRs7TRvfmhNwq+PUzfoNY2rM4pt5CfWRFS2qwmgTmqNIIDkOm/+5BqhcCAFfh9mYQbc7ESSiakjPIcVcph48ET9zNJ1SLdilXI685v5OAR54BO6YDaIxQM01IUeZ7IzWerNoPtpWoWPEqAMeQudzZzt905qwyzBAA/25w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB8974.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:123::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Sun, 8 Jun
 2025 10:56:35 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:56:35 +0000
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
Thread-Index: AQHb1x7RwmU6j68CikiCTe6h/Egw8rP31HOYgAFFTlU=
Date: Sun, 8 Jun 2025 10:56:34 +0000
Message-ID:
 <PN3PR01MB9597F4AB1711886FC47131D6B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB8974:EE_
x-ms-office365-filtering-correlation-id: 92bda0fd-bd0d-4c57-31c1-08dda67b22af
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799006|7092599006|8062599006|8060799009|6072599003|461199028|15080799009|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?dFpBRy9mZFFHdHlaRFN6aEErSWZjUWI2YW8zQ3hndVBvQTlCQ0hwc055emxX?=
 =?utf-8?B?di9PYktteWd0S2l5ZTFuZUVUempGb3J1MmJBNjFiRzFkMkRqYU5XQzlreGlL?=
 =?utf-8?B?ZTEweGViOGZrZGlFRy9NZjc3cFJPNVEvMERXQVJ5ekpYQ0lzMnYrZ1V3QTJi?=
 =?utf-8?B?d3Nrc3dIbE5nb0paakxOcVNCS1BHNnhGMlRRSlRCM25WSDNqNWViMWJjczU5?=
 =?utf-8?B?SE9Dck43VHV4Zld5Vm5QNkxwQjFkZ1dBVExnWmFtTlFvZW9mTk9qUDJzcDRy?=
 =?utf-8?B?c1hoT2RYV3ZSZnY2WkhhRVcxMmcwcDBTMFlUZnRuNjlZczZZVmJkelFWTnBa?=
 =?utf-8?B?NnVaaThreW9NN2N0aG81N3p6STkwd0NSMXNqcFdsUlBRMkRqVGpmMmhYNUZE?=
 =?utf-8?B?VXFzSm5jdFhmY2o3YnVjZjVIS2l0RDhhczRWS1NnQVJja1pTcWc1Q2VpNGZm?=
 =?utf-8?B?Z0tQci9yMm1lbnd6L2ZEaER5WWZHWUM0TmwwS1JMcWk2c0FVVFlxRU0weWt5?=
 =?utf-8?B?YksrbmE0Y1ZxTkZjVG9vVGN0ZklKaU04aSt3REVjSlJQYnBWeWNhU2hjMlVX?=
 =?utf-8?B?S3g1TTdyQmZOZlJ3R3hQWDVtbm5GYUtKRlF4WFRlSFpvYWxtT09pY29nd0I0?=
 =?utf-8?B?Zk5UWDh5cGpiNDlhVURxN20vSXpyVkI2NDdiaDgyNk1FYU5yRUx0TVdJWUxL?=
 =?utf-8?B?alNKellXMGNwaWpkQkR1WjlqVHM3ZEhXN3ROTXc2MmQ5WTFoUnQva20wSS9X?=
 =?utf-8?B?Q0QrTUx2b1E1Sy9yaDdwRC8yYVdLQTJjSFlURWkxTnBpK1V2NXV2QkZ1Z2E3?=
 =?utf-8?B?ODVUQk5WdXBON3RUaHYvTy9CUGFVSXprREhKWXNEZVovUTV3OS9ESENlZFhr?=
 =?utf-8?B?TWFCU0pUTURyWlVNK3U1ZzZ6RTdpWXNWM0ZuOXQybXhIRGVLaDArL1BLWldK?=
 =?utf-8?B?YzFyRUNJVkw3VEszc2hTcjVJWVdSWmFJbzBObGJ6Tnc3YnBSVU05dG5Vb05M?=
 =?utf-8?B?RTNNY1c3aWRrQm5lakhlT0dRQzFMdlIrd1E2Lzc4bE0yT05tdEVMU2RmcHZG?=
 =?utf-8?B?cWVBcTdUeUR4RVRXZlZwVVFzUDRVOUMrWmFJRWhSTU83RkQ5ZnorVm5pQ1hx?=
 =?utf-8?B?b09oUkFaZVM4VjR0Q01SVGRabHJENktDcWliUmlPNFJCNFBUdzVzMnlMQmIx?=
 =?utf-8?B?ZFpQRFNSZW4rVlYvZ1REbktRL2dXVit4TFJRMWxNMm0vR3Q5WlJMSVIwdXoz?=
 =?utf-8?B?TjJSc2oxRW9QeTFWZXNPT0R1UmhIY3VHRUkvbnFab3B6R2VSZktWVzQvWXV5?=
 =?utf-8?B?SHIzSjdqckZMY2pGOUgxdURSd25aYThrSkZNck1MamNVRGJyVVlNWXUwTy9T?=
 =?utf-8?B?akFnNTNCVTJOS0h4QktzR0pIZTdwY3dMQWhnU0tLM3JUNVN0ZmJqOUd1UnRp?=
 =?utf-8?B?ZWt6anhid0RDRWVLM0JncGZhbU5nWGxyMEdjNnRlcnR0RlFtNGlPVERvbVlj?=
 =?utf-8?B?QldyWU1sd25IN0NlMmxzeFFKTXBkMVdKY3NKRjR3aFdCMGwyVEtIVlkreFVj?=
 =?utf-8?B?K2padz09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Y094L0FjYmVLMHZCR0NGSlZtZWsxZVdnMUNodmw0Z0JXa245NnlpdW5rK29U?=
 =?utf-8?B?akdtZ2RMcWlVWjMwMWs0RktxWHhVbXQwa3pEUjMvUXdNZlVMcVdvWTJiSnpL?=
 =?utf-8?B?TE41UzlTWFJnRWl6ZS9rZ29JRHdUR00zRDh2SjA4czJxQjYvNTVTWFdBTEFN?=
 =?utf-8?B?VHNGVXhWcEhjNFhiZ0pXRTJVN0dpTzd6MzBQSVFvd3ErdUZQVjF2YkJPOFBy?=
 =?utf-8?B?UDMvS2I5OWtDVHBWZTBNamJXckNINkF2ei81Y21QWmR4ZlBZMjBhaTQ2cEU5?=
 =?utf-8?B?dXZHOHNGbEgwNS9PMGExN2ppWDE4TS90czVkYjFlTUtTMjRmb1RTbGR3ZE9s?=
 =?utf-8?B?OFZFaTRsOG5scWJWNFk2aFREN0w1SEdSb1hhOE5raEFqaTZ1bWxnZWlOSk9I?=
 =?utf-8?B?dGNITGpRZDdWVERSdDFOMksvWEVLUlhJbWZIOVVqOW5ZWHVQYk1sU3hqSHhs?=
 =?utf-8?B?akMwM0dFS3dvYU5Lc2w1eVAwbUNZODlFb3VQbUZkbG5RTDJVTmg3RlZhaGNz?=
 =?utf-8?B?b3hsc1FNMHBOdTdQaFQ2KzFzUXh1UTNJck01UXNkS0EvRW1RR2dITXB4aGp1?=
 =?utf-8?B?Q0RobXV3YTFaYklRQmR3NGQxZEhMY3cyN0Q0TjNxbFdzYXZMRDMxYWsyU0ti?=
 =?utf-8?B?eG9UajZwaG0wQkhKRklYajFsbzVJTTBmeVpTUzNoNFNTeDVBZWErTmZTVFRw?=
 =?utf-8?B?Vkx3OVl2WDMvT1lmUlhVUUxoMjg0S3lwU2ZXenh4ZmFLTnNzRVJhS0hJVDQ1?=
 =?utf-8?B?SXk1TnkrMTRxNmlOb3Zua3pxUERWRWdlYkh1bTE4cWNIUkFKNmYzL3NhWUFD?=
 =?utf-8?B?SEVWdFcvTWhiam5jQlR0UlUzbnVWbFY1QlRKZmFCcGJJdGp2SzAvQ3hDQTY0?=
 =?utf-8?B?OFIvRUZXdEMybnRjOVd6dVNQZ0Zoa2Y1dUtrdmRqczlhWkh1UDNUMEplZ3Qv?=
 =?utf-8?B?MWlqa0N1ai92TFhtSlMvOXRJdmFqQXpJcHBqUUladjJIcThzazBOQ1YxUFA2?=
 =?utf-8?B?WHllalVwd05ESWZXZmNPUWNMVWhHaTZxRUU3dU85L2lxbHh4aVJmU25NTWI3?=
 =?utf-8?B?SWlaZ3VkMXVqNzNHelpHTU5FdDVqQzVIMkZxdEIvb3lwcXVZdG9YaFpteE03?=
 =?utf-8?B?OU1Rc1RlQll2RDVjTUxaVXk2bUNxNFN4dzNTTzltdlRNZHMrUWFNMDhrbExn?=
 =?utf-8?B?TzVCM3FKM3ZHdGJqS2tDb0V1Tlh3SXFlSGRPMzRrL0RyZGRrMFlLbW5FSGM2?=
 =?utf-8?B?RHB0dG1kVE03OFpUMWlDcDdrdzVEY3VBL01mSERobTRaR3JWUUJ6TkRHdkRN?=
 =?utf-8?B?L09CcmJ5bytVSVB3a04xUFl4YjdqWUg2ekxnZHpKRytyOWRMUFNFWXBsbGk5?=
 =?utf-8?B?aitZbEpoVDU3WVFrdllQblYyK0lYRDdMcDBYUnVsQUxRdW1hRjBoZHdxeGJR?=
 =?utf-8?B?YkVDUGNQUkthUENiV3JlSk9OVTV5NnJqVVEvWEhpWlJrNFFtT3puRnNXVStH?=
 =?utf-8?B?b01rZzJKMnZuTEhQM3prWTRvUUk1WkNhVlRnZXVyQkFFaW1saW15Z2Y1NGEz?=
 =?utf-8?B?SURobHlGQlpqNFk0allFZ1Y4N285NFRCdktBMlQ2M2phTndJRCsyM3FTUWFs?=
 =?utf-8?Q?s5FtgN38cRrf6Dxj4tPmSuWZAsRzIBPPo+sfr9DiELdk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92bda0fd-bd0d-4c57-31c1-08dda67b22af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2025 10:56:34.9252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB8974

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
c2VyaWVzIGNhbiBhZGQgT0F1dGgyLjAgYW5kIFBMQUlODQo+IHN1cHBvcnQgb24gdG9wLg0KDQpT
ZW50IGEgdjE1IHdpdGggdGhlIHBhdGNoZXMgcmVhcnJhbmdlZC4=
