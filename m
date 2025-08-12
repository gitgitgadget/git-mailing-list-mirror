Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011027.outbound.protection.outlook.com [52.103.68.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF566311C18
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754981489; cv=fail; b=YK3Dy3Je6tmX96yzvP9KtohUDrjc5Jli0T7yBjm+y/UL727PQ3UrLfhapY3cUZO1lF4EX+d0Huse+LSWq8mIrWvxRNPZMyYXXhatZb3QwcqpT/ji4wudJEyYb80pwTI511LcN9gLpJTj2XV300VtNZ1BNN7P9N3bIFtwI48r6hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754981489; c=relaxed/simple;
	bh=DrZ+ipeWutZuTR5rBPoKLqf1pp89in2uV5+7U+vHBEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cjUz/R6Z//XEsAWPQLG2Q65qlRd1nKtrxlShdMVHplfrKo4USqOSGZnX6a1+egKekgidWECh3cGWQ9mPtQueepgpsMYxkOh1wFRYX/xGYBhzD4vhYuVuEuhV6o73sAZdWAqlvTf83afj/xihaSsRXxRAu5aXSi8jq5NejjmOuEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=ZpG3GYSD; arc=fail smtp.client-ip=52.103.68.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="ZpG3GYSD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAhgtPw+e69HcVvTrWwIIHxvAOtGPpRVtT5EboxI49rg/e6koWRm70B8nRU0px8PY1ylA3N4++QUXM6CmB8XlkYa5EiiU9wN9NL6xjHKju2CLYJp8AlMguVELEr0SQ4+9ZddS7OLOBFz7MfujXAGP1gU4zNTVuI0umXQQfp2VnFUGYfIXCVPFBju4ni9pw3tb3TqlOjqpBhaNtyHdH5fopFmr5WwtWOoXl4V0Oc1VmswQuEzxmA55q3h7gVaEK0KERmBUouvOJ7dUthRQzO3qqoE95MqpwOHVihb10XyXPeYzQ3xFWmXdvyAEuCiNhuzQF7znu2ntQh1y7+w3taEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrZ+ipeWutZuTR5rBPoKLqf1pp89in2uV5+7U+vHBEA=;
 b=sQ+//7JA7EznsFMzmJCijePqE27vPSfvm0yKXrET6N2XLPHK70ScD+rU9RJqQzu72YJ50OKyKFK1F5R8gHYM3M7SWeemc25Nqk7x+/HPQzWIADeDUS4SnTealdPl1E9WvwyWH79ecXxfsrKkGdN7o72BO0XMrREuWWHKqjl6C+9JXC/Df07SVtv0X0Yl1OKN+NX+GuiXWq0bwVdQBCyu+bLZqOtmP+09bQgTTqIkIcjLpuyn+PUE0yC8eQ9TZBR7EI5KdVYOBxVKIxqNjNZBQx48gOthmfU7FhRtcLy/+k6UJBSIEtQf81PW+huI8BlspJxdMGxMKehiFSeYse9xXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrZ+ipeWutZuTR5rBPoKLqf1pp89in2uV5+7U+vHBEA=;
 b=ZpG3GYSDDGdVe8xiTOtYWTDpof705zs42xY/9JXfJutKJNXMy7QDw0eye26MCkB5DutmZSoT5KpDf9tpvnR8399r/Vwc69CZ+SkA98nSpDxNLFVeuHVscOR+NQdZDO0VfeUBnySqLdmRTHue74NQARfIMHncrkrdjxqgVAYUxhoji4XP7xyp9zwbBiakHd5OjlEWnVo6nGZhI7dZXPYbogkDioSmZ+yza9G+VfkniXvqrWcqKNGAAkJowxebE/xqlXQYIOhITRojuYGmjCCQwaVH5NF3kAR75eOZ7vnU/usLQtSHmmln2DENE/tpQn2uTD233j640Cza9CWKpCR2Eg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7247.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:46::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 06:51:23 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.9009.021; Tue, 12 Aug 2025
 06:51:22 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>, "brian
 m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder
 without actually sending them
Thread-Topic: [PATCH v4 2/2] send-email: enable copying emails to IMAP folder
 without actually sending them
Thread-Index: AQHb+71dCRDKXsxRhEyzxpjO1f0evLReHPHQgACWmiE=
Date: Tue, 12 Aug 2025 06:51:22 +0000
Message-ID:
 <PN3PR01MB959751BD9AAB42393EF01D11B82BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <08528f201acc1038ebc5861321395d17516094fd.1753003385.git.gargaditya08@live.com>
	<PN3PR01MB9597EC4C5DF97943587AEEB4B85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95972CAE853F4079F0F62F0AB85FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <xmqqv7mtzfuc.fsf@gitster.g>
In-Reply-To: <xmqqv7mtzfuc.fsf@gitster.g>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MAZPR01MB7247:EE_
x-ms-office365-filtering-correlation-id: 9394a7f4-025a-4906-999b-08ddd96ca668
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|31061999003|8060799015|8062599012|6072599003|19110799012|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bDVFYzJ2ZU9Ic25VU0RYK0h6ZXhCejNNMFUxZmxLNng3WGhEN1JzWFJtZzZ2?=
 =?utf-8?B?SFcwNnUrcjRjQ3pOTldQQXdLWmlXdGtnYklzZW1GN0xRc2N4L1hqYzFoVE16?=
 =?utf-8?B?cjJWUGVsendEOHN3eE5laE5UQTExY2ZMbnY0U01NWmlVcGtnY2liVDdOWjhj?=
 =?utf-8?B?VTRRR3RDaGo1ZzhwZTMzcGtlajUybXRWTHIzNGRHYVJ6Z1VmS2R2dklnSU8z?=
 =?utf-8?B?d0VxeW11Z3lraldyM2VhWWtQOVFZcCs2SXgzWXFLRDA4QkNXemowRU1zT0lX?=
 =?utf-8?B?WE9NTlIwZHExMmptc2psbDJIalNOc01BWW9IYzNqK3c3Qm51Z0M0NHR6NTNM?=
 =?utf-8?B?YUZvakhTalhRT1RvZU5ncUdrSzRjeWVZL0RoUCtzSG5ISXFNclFWTzlucStZ?=
 =?utf-8?B?OGNQNEdHQ2Q4ZzZncjl1T1ZlRk5UTkNuSFUwd2lnd09TSnMwVStQVzErOGhq?=
 =?utf-8?B?MmloelBWYjdPdzZtSW1nRWN6R2ZmWnptUmhTdXh1L09MY1FzTjhSYkRna3Yv?=
 =?utf-8?B?NENmbkwwaWs2aE9PRnpObGQ1QVR5M1lhVFE4Vzc3NDViUzNkcmY2ZGFtV0VJ?=
 =?utf-8?B?clhsaEVpY1NOVm9temJEU1FWNFp3a1VxRysxV05mSVdXN0ZSaGFxVnlyTnMx?=
 =?utf-8?B?S0FGTytRamthaVoyYlI5ajVWak5sdzMvN0xOZGFTMWJSNmpldmhJcFNzVm1E?=
 =?utf-8?B?eEJGRmc1b1B1cUZjWXR5cFhoMk5UT21pUVdNOFdMQ0RxVVlmTlErOWcwbnR2?=
 =?utf-8?B?RFRsZE8wU3RNY0VvSno1QWNtS0xqSEpRZS94RjVVQ1NpUkFjdlFnVWNQdU5a?=
 =?utf-8?B?N3FsQkNhTGdCNXNoYWtnQ09wbzlHakNON0NzZFAzWTljc1l6NmxvOGx3aGth?=
 =?utf-8?B?VDIwc1E2V1I3OEFZNFFCSkZPQ05RbXFRV25hWkRDeVFOYkM5MXlDRFY5cTAw?=
 =?utf-8?B?ZWhQWk5aWmExUytqWEZXTEttS1RqOUZMejJBN1NtTVBmV08rR1BYczNCeXBt?=
 =?utf-8?B?SWtkUW91bzBQenZIMmU0SnNYMjYwb2NwSlJqVEJhbldRSFRKMDNTVHNqbWFB?=
 =?utf-8?B?L1dsWnl0cVprSkNXZjd6RkNaMmdwTWdXWGpNajk3VHlXQm13MWFKMHVmRXJx?=
 =?utf-8?B?N2NXTGRTZUJBWUtYaWpnd2pnbUc0czYxUk96Z2w4SE5mRVhoOERxM1J1VVJM?=
 =?utf-8?B?TklMV3ZTdldzWDdGUThWZ2NJcllKM0xaM0tLMytjK0NWNDBjRTdXUmNzMzFz?=
 =?utf-8?B?b3M3UUdEMUhFV2l4RzNaNnlVc0NKNGhXVUVsOHphRUlwYk1iV3ZoNnNmYUdn?=
 =?utf-8?B?OHhWUjBKZWE2VnNrUWpkTjhrNmNqdlI4a0NiM2ZxaksreHR0SXBMRi92aFRi?=
 =?utf-8?B?WTdURVAxZjBVVGdjcTViMzkrb2hQMmYxaTJPTEJTdmVDMHBkWXVoSmdSM1pN?=
 =?utf-8?B?dHQ5bGpPVHFnSitWSnUrRkdpeVVGcUZmRXFDek5aSUNaN0JjanBjT1NRazN3?=
 =?utf-8?B?RmNORE4wVVg3bktUUzZzT0gzTVpzSUg2d1Fnbk9PTk9xUlVVNXhLWm82YjRh?=
 =?utf-8?Q?Dr5EWaGeX9SUmjO/ilifoTGtI=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTk4NEtBbnBsNks2ZlNWQnE2MW1vVEREOEhiSUl0b1hXNjBwTC9EYmQ1VCsz?=
 =?utf-8?B?ekw0TnJGYWVpa2p5M0pkRGc2d0t5ZFV0czQyaHZMOXYrYXNDUkUxZDlYdW1L?=
 =?utf-8?B?QU8zaktMSkRHUGZBZWNuaVZWMjRzbkh6SE5LR1R0MHp6UmpVd2I2K1ZPYlZQ?=
 =?utf-8?B?WktHaExySUw4WVk2bE54aGdraUpMU1I5dGVic0dGeW9NZVNRQ0pYS2E5K2RO?=
 =?utf-8?B?cnlGekRtZHdBc3lrRDVuMEhUNGw1STg3VVVMMFd1OGlnaFB2clR3SEw5MnBz?=
 =?utf-8?B?ei9SaEYvZFp0eHA2ZEZlTGlvTW5PQ1VkRVYrZG4yNG5oRWhkcXB1Ylk0eFRG?=
 =?utf-8?B?V2NtMDNsb29DeUtGd2JzM0NOOHdRdzB4RElFT2xiZ0t0aEdPRysxSmN6UDdY?=
 =?utf-8?B?c1BSbU5ybUFEQlplM29LdFdWRndaZy9zVFpvZzZhZHczdWd5ZHNveUJ3TjRL?=
 =?utf-8?B?ZEhwdE9ndUp1dWZYT0pjTHEzSVRxSjRpMzQvM0tFUlpsdVdiNEY2cHgxd282?=
 =?utf-8?B?UDFTTzNQQjYwRnNDcHRWbjRiOWF2YTZhSG9SNzhGcmtYQnZRSnFxTFRxNEU3?=
 =?utf-8?B?K1JRRWhlZjFNamxrbEZ4VHhEMkpldms4cVEzSkRScVBxYXNyVnBTUDJTdjFC?=
 =?utf-8?B?bFlpdkdNTHVTcTdBSTJkZWltVjlGcTQzNDQyMEUyRjAzZGJxaGF4Q1F0NG1T?=
 =?utf-8?B?aUtSVjBCUFZFRnpTdHQ5UkhKUVNvMXdVK0ViV1pOOUw1ak9YTnY2TUVsdTNP?=
 =?utf-8?B?UzNIZnd5VEl3d1VoUTloN1lpRVJmYis5TEVhbzl6dTJ0TWdSN0hKZVNtQjVv?=
 =?utf-8?B?NHc2K1JZeU9IT3hsdXZ4NWxtT2ZrQVVha2UzaCsrTEhhaGdrajJUVzZSZmdz?=
 =?utf-8?B?N1drdmZhWUdaM3cwZWFEcEhDZzc1cE5rc2ZEZ1VuV3QzL0I4a1dRWThqU0hT?=
 =?utf-8?B?dUpOdWxzMytYNnMrempUTmZWa1dJU25EVWZiL2ZRaUQ1bUN3bDcvTUZ4NHZ3?=
 =?utf-8?B?ZklQMUFyT2IyRFZvOUlENnVMRzh4eUdIOXoxbEdycThLQk1yRUlSMHBibzRo?=
 =?utf-8?B?Sm82bDROU0dxQVVkY0gzc3h2UGNDeFVvMC9zZlFtT25ncTA4OTdhanZSOXNZ?=
 =?utf-8?B?aDhwUzdoVWpzd3gzU0NiTVZtVjJNcmtjeVVNNlpXckVud1g5OWxJYjRXcG93?=
 =?utf-8?B?cVNtWWhqelVwcUNueURhVmJTTDQ2cUFDa0g1djdpUmFOVlk3ZTUvMmFaRUR6?=
 =?utf-8?B?MTMvVjFOZ3RSWTNaczhIeG9RTThLNm5UQit6OWVIdThndGJHeDkwdUNvTlkv?=
 =?utf-8?B?Z0tvSUc2Zk5RcUp2VDhsZExhS2YrQ1Rwb3c5aEFNeWFNQ1Rmc3hEM01zVEg5?=
 =?utf-8?B?dVQxd0MwOFg2VlZ5T1lOMWMxaXkzN3NsSXFLRExhWFA4NURadDdnL1hqei9P?=
 =?utf-8?B?eHozR3Y4YXJBQStLbG5DbjJ4SWE4SmFESGI1Y01rbHEvQ2FkcWhPRnozNk9s?=
 =?utf-8?B?ZmVzR0Ria3RUWmFBTHhuSHJNenBLMWlkVjc4ME80aUhVUUFScThrMFIycWU1?=
 =?utf-8?B?Y1U5TzYwTTg4eDdCWHR6SHI1UG94OXVtZklqVml6eVFrZnJ2NHFCeExybXlt?=
 =?utf-8?Q?vOQHJ1fW9gSe8lG3ZgZZPFvmvVT5qSi3+UmCq5uW5W4c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9394a7f4-025a-4906-999b-08ddd96ca668
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2025 06:51:22.7479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7247

DQoNCj4gT24gMTIgQXVnIDIwMjUsIGF0IDM6MjLigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0
ZXJAcG9ib3guY29tPiB3cm90ZToNCj4gDQo+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhA
bGl2ZS5jb20+IHdyaXRlczoNCj4gDQo+PiArLS1bbm8tXXVzZS1pbWFwLW9ubHk6Og0KPiANCj4g
VGhpcyBpcyBiZXR0ZXIgd3JpdHRlbiBvbiB0d28gc2VwYXJhdGUgbGluZXMsIGkuZS4NCj4gDQo+
ICAgIC0tdXNlLWltYXAtb25seTo6DQo+ICAgIC0tbm8tdXNlLWltYXAtb25seTo6DQoNCkNvcnJl
Y3RlZCBpbiB2NQ==
