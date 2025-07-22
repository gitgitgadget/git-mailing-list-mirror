Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13881185E4A
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201927; cv=fail; b=qLchp5GVKOsB/k3c6v5ORah/etfg/pttLM5YPtYU+TuacbVMn3N1XISIqsO1aKUn/yByRLHeTHcTenA69QJnAULJjJwquiSeUnUOKUlUAlhBM13dKLyoq5A8v75TpQcoMp0e21423/brK/z7pT9v+sb5mU68dYnYRlQZjaFBsDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201927; c=relaxed/simple;
	bh=Zxb1cXZOwyDmI45+m9ggz2dIBPp/mmsJudpWikazktg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hs9m+i5CV8K7lGq40iAXNkXSyD1F0sUXk0xrE2RVaxVTRUOz/LOuylBBGHBPNFwk4Awai4RrVyfJSM7ZdVgu842mhA6PZAhMTbbAHpaHsHIO/neZCOq/4v9uZ7u8pHuqiPHL3y5Wzm3/Ym3dbz243C5UcDYcE9N2hwa2bt+6i5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=abX8CY2h; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="abX8CY2h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TaJApyBhweydAv4GxD2j6wpb+hKKSC+OjqaSmoQLCdwLx/Tbn58nJRWzqTowRj7Bn6zJJ096/6fFHnmDzRLJUl+ET0TQ3sJwB+NFZ91DhaylrbLjE/7VY+MtjCamn/yFsDS84MjT/IGD7tXi0a9YGZwpDrOyTSO3ySZy1uCSj28X3q8FgiX/n/o0hKs71JmSI7jlF9r+NjOpQ8NS8//nT1cTC9aBsKE8050gPd3t1jm55ZYgxwG6EejWarXjkBSFlQh/1zN6XNDzN9cU0Iozlt8iyph0EYlAGU2W9j9E3rEqiamwyWq0WfSLBRvLkvDQG7pWiiyDkKfZUfM6gn5T8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zxb1cXZOwyDmI45+m9ggz2dIBPp/mmsJudpWikazktg=;
 b=fYNlTXLnBSLt5iNUJsVGAwtpEze4k7vcCIcRXqt6dxsgbDxkFgxvW+Uh/ivZCIPb88fiHarx5t47wmvkVwAQechuLbLrBaTmQHpPZOcz8FrGxAsXsLAVu5C3bVl4b+mkmliciBtZkaHbFp+Fmc9kxuCvXlRiwJtnNUqt8+ptBDpVzB1rFIoLjbBH1uyp2KjSTDzvP11PTSnGgsMEgZVLKw/vP/8X/BsVKjfGPfDLJBygLY+jOoyx4TC0XJatojesIu8oSJK3yxs+2CnphhGYJd1uWxpn5dYWcfCR6Fk4Qn2iFRZTezwQMLHvwchSSiEjmXGEQBhTn/SjwfD8KuPokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zxb1cXZOwyDmI45+m9ggz2dIBPp/mmsJudpWikazktg=;
 b=abX8CY2hlTUsj/29ky1eBcsgG//oW4MOfDOL2JIV9hHRwg4licoUrwvvJzcgJkRipLI1HjrbOpJ6fc/J8UqG2T+ChxUIebyVhXKMgtHw+/pJ2CAg8v0KokDpx4RPGQT8p4s/lN/ThnQgVKMF83LxAIjIjg3erjQAvQa3pfPvZSvJl1rY6wBzjQ3HKAOEEgDoxoR+sZyw6RbXpV1fioc2swTcu+zSVYVU6dr4lpeduMpLyOplzh4v6PCeab76G52ZueqNQHYwrGCeRJQFOmPjMkD3dxrgk1s8EI1PJNIdxM+EDniYhpa34vQbqBDVrXsfN5Vr0B4u250ljzfksQ/EKA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB10395.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 16:31:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%7]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 16:31:59 +0000
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
 AQHb+icCP6QpV1qJFUuwKA//pz1KNbQ88vHdgACMowCAABmiW4AAEj4AgABWuICAAEZaQIAAD2iA
Date: Tue, 22 Jul 2025 16:31:59 +0000
Message-ID: <8596251B-7A3F-4220-8759-B75FF63964C0@live.com>
References:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
 <87a890182591c9c21061e85834fc99a766252611.1753092192.git.gargaditya08@live.com>
 <xmqqpldtxsp7.fsf@gitster.g>
 <PN3PR01MB95976A7BE0F9A54E836FA2F5B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqq4iv4x15e.fsf@gitster.g>
 <PN3PR01MB9597B8D3D84D9F7660F15E94B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95973B291F0A52A19DA8BD49B85CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqo6tctez2.fsf@gitster.g>
In-Reply-To: <xmqqo6tctez2.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB10395:EE_
x-ms-office365-filtering-correlation-id: 7f495d55-1f9d-4465-62f3-08ddc93d47ee
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZDFnNlJ1bUJjYnhOK2VRV2R5a21QdzdJYWlwSUhxRHprUXEreGtBV2JURmgw?=
 =?utf-8?B?NG5saC9ZM3lDZWVVVVJSeFJvdUlOcTlJZVM5bzNtZ3ZNOXFlTGRDRlp6TG11?=
 =?utf-8?B?NWJRM3pDT09Ia1REeU1UQ002K1VsUE1yUVN4S2hLb0xJVHVYWXN6SVhDa0hz?=
 =?utf-8?B?MDJkdnZ4WG8xaXYva2tVblJiUkRDQ1VvcmZwNVpMaUF0WFdnZjFSbnZ2QnlK?=
 =?utf-8?B?WVNqQjNDZE9CektyZncvOGZIa1ZHeXF4TjRTdEsrblJSZ3J0dE12UDN0TVZ3?=
 =?utf-8?B?eDIyMi81OGU0UlNnWlppMGpJSENsOFB1YWNUemE4SnlTcTBDelo0Tkh5VXRh?=
 =?utf-8?B?SlJlMW1LZTRRSHBVdFhuUCt3cHpmcGg5WFgrRjdzeXlha3p6VmZQcjJnRitn?=
 =?utf-8?B?eEZDU3JaSVpGZEhTb0ZEQVA2RlNNbzFOQTJMalRXanB4bmU3cHlWZXE1djBi?=
 =?utf-8?B?bDVmR0FJdG9tZk1qSXZ5cWxNczMwTEFjdko5Z0ltY281QWZFRlBxMVgrY0l6?=
 =?utf-8?B?Y09XVlZwODFMZDIzRHgwTmhUbVMyOFI3ZjM1emIrZHkzQ0xvMXNYWHc0MzRX?=
 =?utf-8?B?aTc3RHBUd2NGQ3BvUUt3WG94bkxUYXVETUY0QytQUGVZZmJSK0JEWVFTU0xL?=
 =?utf-8?B?c29yTHFpZ1c2Tm01R3FtYy9iRFdXZFZCcndWMWwrTzFUd3BxUHBLcml0OElB?=
 =?utf-8?B?Q09zUVA4UlFnR2l2bU95NlFQWWRiK1FZNW8yOWpPUzVVYlBidXMyeko3dUls?=
 =?utf-8?B?WkFzZHdUdjNTeGUvWlRPL3hEOXZSeWRCbmxDTWNpc2tueHhiZm9sazBnV1Ra?=
 =?utf-8?B?SGIzTW1OY09mbFdhSUFHSDhRVytBYnREcFh0aGtTYXNqY1hXeVBHK2R1OUNv?=
 =?utf-8?B?c2kzRjJxQWZmNlN3ZUxJNzhUNU9WK2pIaGR0bmVGVmx2SmdRNVd2VDBKa1dB?=
 =?utf-8?B?R2hFN0VzRUNYalNOL0pQY0dURUcxVmQxdFhraXVKTVhyTzJhbjVvSDAya3p4?=
 =?utf-8?B?Kzh6Q0ZCbE9vLzBSL2t6RnljaUZNRnNLd3NhUE5MRTRWZVFYZzhybFZ0NHZU?=
 =?utf-8?B?VG0rVko3WkFTL2ZuU3k0UUJpb0dVZnFpQkpwSTBWTGc3Nzl4NVFmMzhjb1Uy?=
 =?utf-8?B?VUhBb3UzSVF3cmpPN05XQ3E5Rk5wNDBKQzZKQ2o0ZHZNbnZPaURWVXZLZlda?=
 =?utf-8?B?L3NqVGQ4MVBhV1Y5MHNpK0dOTHhXQXJKaUFGSUNNcXdZUllmc2trZ1RjaThj?=
 =?utf-8?B?UFdVb25hVHRaTUIzb09zZ2JRZHdETkFkSnpiVGg2VFAyZnc1bmNJSnh3YjVJ?=
 =?utf-8?B?WnZrL240ZGNEU0k1Q2hMRjkxb25hMmRZdTB4Q2o2STczU1BiNW1zM2xXVVdN?=
 =?utf-8?B?bWxNblVjNWdSN0E9PQ==?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzhaL1R2WW1GeWFtY0g5R0c0MjAwTldZcm4rc2F4bkJDZnNiMnBzWDZoMXRw?=
 =?utf-8?B?VjlXOCswQWdDWVJ6T3VuZStmU3E3L0lxUlhoeDk5UTV0dlVIM1prUmIySXlS?=
 =?utf-8?B?dXhYZ0N3Rmp5WkZoRHFrL1NDSlhrVTZKOW1hT052bEREVGVyeCtXZUNvRTJ0?=
 =?utf-8?B?eVdWSjlDdHpqYUNwVk1reUlNcnU0QjBFekN3V04vYlJZSUxlSmRyKzdYR05P?=
 =?utf-8?B?QW5JbjRGNXVnalBUalkwNnlRNEwzVTA1UGZ6dHM4dE9ZTmVCdVBPTTFaTzFt?=
 =?utf-8?B?SC9reCthWnRvTUFXZXhCR0FNazFhNE1wWDZ3ZWJCeCtVTU5yZk1HMEhyUUd2?=
 =?utf-8?B?NUJqQlZZWmpwR0UweXk1ZzN1MGVaajJDNlVBRUNFUHhKaVNDM1NUMzNSbk5D?=
 =?utf-8?B?SXd0d1daMHVzUFRHck5CR2JqTktrQmdKWHk3cWtCa01FaVJtZGUrL3NkL1Mz?=
 =?utf-8?B?ekVHU3p4Qncycjk3N2RPTisvV3lINlJKeFYzTzhGUloydENMM3IyVHFyV2xi?=
 =?utf-8?B?a0wyK0NQUlJybDZRbndrZGZSYnF6cVlWbERHUXBHUWEvVWRwNEJDZ042TVls?=
 =?utf-8?B?YnFBSituUlJpcyt5RHVad1Q0NThkWjNpcjNEejZjRUNtL2FwbmlkRTBqdDJr?=
 =?utf-8?B?NUptWTVzSnlKRk90VzRiWWhHWlZWL0xyZzZKaG44TnFoeGRHUlppWmJWekNP?=
 =?utf-8?B?N0U5QzBmZEdRQmk5Q3pqQjZONjNYbGVIYlB4T2I4VDFOVnVQOTQ5Q1p5akNo?=
 =?utf-8?B?ZVFPaHV6Ulh1b091bG5vbkZLdXU3N1pjRFl1L0xNUTVHcE9xOTQ0REphcVVS?=
 =?utf-8?B?dHlQOFBDcDFmdTc3K055a1NMREQzeXVJZ2Q1dlNBZ2ZtWXhCQzE4aFRNTUVX?=
 =?utf-8?B?NTVncVc4VHVUU3h3TzVYazl3am9NVnVzZUdMTklEKzh5bis2UG9Dd3V5N3Qv?=
 =?utf-8?B?WXlvbnBuQTZzdm1LYnZIRWtVM3FOR1JZR0ZDVjkxdzRySzMvZXQzRDkrUUt3?=
 =?utf-8?B?dGpBWCtDWFdleXp0SFJDZ1hLZlZsRExPNGxaU3JIMUEyeXJzQThpaHNJcHhL?=
 =?utf-8?B?dzhxdHhmcmhtMEw4MTQwSTNQK3MwMkRGbXhQUVZ6b000NENkL2dmcjk4Uktx?=
 =?utf-8?B?LzVUMmdSeEJFdjA2QjJ1YktSYWJjVVI5dlJtbUhNSHZyUUZ4SnNmVllPRWdU?=
 =?utf-8?B?VWE1eEpUdWtEVFJKYVNZU3RmdC9TYlByTk5WRkhaTlFjTUo5K2JGMFZwckJY?=
 =?utf-8?B?T3hqV05mTVA4UTNyTllSS21COTRWaDZUQzg2Z29ZS0ZqMkFtaHlIODFmTDR0?=
 =?utf-8?B?ejNBeEtYRkVMS3ovblpLTUlvTC9jM25HNUt2Uk9tRWgyUEVIQXIrcjRYMTNp?=
 =?utf-8?B?TkFMSWtZRnltRCtLQW9CT2hGZkx3Mm9USkFMR1ljejB5NVVYWFpTVFUxS0M1?=
 =?utf-8?B?VjQxNHNqTWdCNGtRNHJ1SDgrQ21lQ1h1aXFUS1pPL1F0WVpHazNINHpQVXFD?=
 =?utf-8?B?YXdjVWZrSE1rcGZYSk1OS2g5a0RPQkJCV3QvZ3ZkZlM4M2RHbGxPbitleVhq?=
 =?utf-8?B?RWRKWEcrTnQxcjI5ZHlnM043TUd4QmVYUXEwWXd1bkExRFMraGxhUk9GdzMv?=
 =?utf-8?B?ckF4U0VNbkZDM3hOUVlYeDkxNjJLMjV3M09nQ0ZvaWhWRUtqTE9Henc2enNR?=
 =?utf-8?B?bndXNU9XaWxIdktGZlFrVHpNZm9GNTQxcjJ0YUgwb0VvSlRGTUU5bkdlUEtX?=
 =?utf-8?Q?FE3ZG+WLoCSROSqHE+qvfmOpKOf96wvahLqG17F?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84B83AC037D2C247B319879C197DC7D0@INDPRD01.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f495d55-1f9d-4465-62f3-08ddc93d47ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 16:31:59.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB10395

DQoNCj4gT24gMjIgSnVsIDIwMjUsIGF0IDk6MDbigK9QTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IEFkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2
ZS5jb20+IHdyaXRlczoNCj4gDQo+PiBBbHNvLCBhcyBmYXIgYXMgQjIgaXMgY29uY2VybmVkLCB1
c2VycyBjYW4gYWxyZWFkeSBkbyBzb21ldGhpbmcgbGlrZToNCj4+IA0KPj4gZ2l0IGZvcm1hdC1w
YXRjaCAtMiBIRUFEIC0tdG89c29tZW9uZUBleGFtcGxlLmNvbSAtLXN0ZG91dCB8IGdpdCBpbWFw
LXNlbmQNCj4gDQo+IElmIHRoZSBhYm92ZSBjb21tYW5kIGxpbmUgaXMgc3VmZmljaWVudCBmb3Ig
dXNlcnMsICJnaXQgc2VuZC1lbWFpbCINCj4gZG9lcyBub3QgbmVlZCBpdHMgZmVhdHVyZSB0byBk
cml2ZSBmb3JtYXQtcGF0Y2ggYW5kIGRvDQo+IA0KPiAgICBnaXQgZm9ybWF0LXBhdGNoIC1vIG91
dGdvLy4gLTIgSEVBRCAmJg0KPiAgICBnaXQgc2VuZC1lbWFpbCAtLXRvPXNvbWVvbmVAZXhhbXBs
ZS5jb20gLi9vdXRnby8qLnBhdGNoDQo+IA0KPiBJIHVzZWQgdG8gdGhpbmsgdGhhdCB3YXkgYW5k
IEkgd2FzIG5haXZlIDstKSBCdXQgc3VjaCBhbiBhcmd1bWVudA0KPiBjb21wbGV0ZWx5IG1pc3Nl
cyB0aGUgcG9pbnQgb2YgdmFyaW91cyBzZW5kLWVtYWlsIG9wdGlvbnMgdGhhdCBhbGxvdw0KPiB0
aGUgdXNlciB0byB0d2VhayBDQzogbGlzdCBwcm9ncmFtYXRpY2FsbHksIGNvbXBvc2UgdGhlIGNv
dmVyDQo+IGxldHRlciwgZXRjLiwgZG9lc24ndCBpdD8NCg0KSG1tLCB5ZXMgaXQgZG9lcywgYnV0
IGlzIHRoaXMgZnVuY3Rpb25hbGl0eSBpbiB0aGUgc2NvcGUgb2YgdGhpcyBwYXRjaD8NCg0KSG9u
ZXN0bHkgaWYgeW91IGNhbiB1c2UgSU1BUCwgeW91IGNhbiBhbHNvIHVzZSBTTVRQLCB3aGljaCBt
YWtlcyBtZSBxdWVzdGlvbiBpZiB3ZSByZWFsbHkgbmVlZCB0aGlzIGZlYXR1cmUgb3Igbm90Lg0K
DQo=
