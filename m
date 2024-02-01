Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2027.outbound.protection.outlook.com [40.92.90.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCDE6FBB1
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 17:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809165; cv=fail; b=barIVW2+cbHG13gH6p1K9U2gFi6MAqQZVMxisBUSS2wz7TtikDBSxweW/XcrsD378F7/UNOJ3RFdpT9GqvcMvUVauVBfbNamsb3iRNpXJbgB0LaVvh5rMRdr1IszMMDQrayDf5e97bvFmSkjyPojiT8dBxrQ76JUl/yI5OWU01k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809165; c=relaxed/simple;
	bh=fJt2zPRStcu3rNZysBmlmRgbu7H5GqGkK3qN6Q5U6nU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hamJpNY8ZoLdp6mI9cQFX8eH3ayQGZcqy/icamzFKC4y1t3ZzdcszPdXrafVKlnSxj0EZYcHo35OPqW7FscwlftFTbPn8RFm84NMR/vcoG7hn6Y+RG4+YbOz02qNXGwLgooWl/36ykmCvdVHOfcgp/+UOZeTWKxPIXvZgkNiXLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=bPM68D42; arc=fail smtp.client-ip=40.92.90.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="bPM68D42"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xem2zwOI4l9pgVQGKpuOIErKJVaV4gtJAT+w1O6HRf2lShZEkz6CPbPowcyH19MnBMsxcQbTj/2AMM6GjGonybAAb/mIlJh63MOX97904vHXguANkTE9OfE4QEpf6lXmlMJ42JeGM/5QKHIM8duwgRqJGobWeKL9q53AmL+EcgcJAT9PU7d9HRUxkeW01FxHU4E+pelK4OCuzIU2/SWFEqBus61zO48Xl9fOquIdU5XLSr6KRVGMijJF316ExFkD8z4jHlktyFXjQ1t4L8Qhca4I7Q7cuMnnydd58fPHNeSiPkkutmsP7n+A8mBSAB2QoMA3sE38NSY851iIohBuHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJt2zPRStcu3rNZysBmlmRgbu7H5GqGkK3qN6Q5U6nU=;
 b=VxQjrhKB1dL5HwgRUDoG61a5zKHumWSA2Ikf6mwvHVX9begwfL4hAvIu9k9s2mH+x9yEqAHQnUwsOVFRHCEf7aNrK50T+WbKqGdwu0FPdsGG09MS5ju85+KP0uRgHnPx79fdlxFNrFD1YErq0kAyEZVuMLcinGyUiS6WJJNmMuJZQuaBMr2W7hejKkbYgKqg77ijVKNq6GifPsxr7Ob05bBTzE29QYVDNVHC0dghEc8S6AkRoYEHnMVgipGIMEOh02u5g7qUdni1sIjAiHjuYYwC2GIX1cqCeGFKXxTsjvLYDBMOQjsK8qgqb279mzfLiG6kZv0dcp0POOnRrdtWtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJt2zPRStcu3rNZysBmlmRgbu7H5GqGkK3qN6Q5U6nU=;
 b=bPM68D42eEmYD0UA47UzS7Q99QMPu/qaIT0L1wkSk0QNcr+qNqvsnHIpLVeFuXmkGF4X70MGuA8Jfi2o/+bBtOXkJkMWjfqh8lSrSzdU8voNnlTBAE1s2nYGCpjxpErNbdJsikB1d1YaTVMcxq7brfGxAp/5T7fY7vLf5Y4FQoe1X+IDjxfZYgtnJM7B4oyxuUzX5t9iYGfRe8aAaBRGoiT5F6Ws94bL7eR8iz64t+ae+zHVKnwxCWSbD60zVzMJmCUkc4OBIdkuKu1BykRC8y1pQoRbAHFv5u+iWq1GnB4IUPvD6ZRWX1jQn5thukdkqov0a2QlHZrZecCHRWUQPw==
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3d9::18)
 by AM0P195MB0612.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:16c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 17:39:21 +0000
Received: from DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10]) by DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
 ([fe80::61bd:4376:abf9:2b10%7]) with mapi id 15.20.7270.010; Thu, 1 Feb 2024
 17:39:21 +0000
From: Hans Meiser <brille1@hotmail.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
CC: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Topic: Migrate away from vger to GitHub or (on-premise) GitLab?
Thread-Index: AQHaVQX2n79jCmLH3kymUsYhfKUndbD1ZQcXgAADOoCAAFilhg==
Date: Thu, 1 Feb 2024 17:39:20 +0000
Message-ID:
 <DB9P195MB21306E8C1DB2FCBDDF5A5614E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
References:
 <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <ada5564d-d810-4707-83b8-c00a7b5aa79f@app.fastmail.com>
In-Reply-To: <ada5564d-d810-4707-83b8-c00a7b5aa79f@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [v+RyalTpheOX1dlWcE2nv6YSdAkTVaAW]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB2130:EE_|AM0P195MB0612:EE_
x-ms-office365-filtering-correlation-id: d7feb15d-4ada-47fc-66db-08dc234cb91a
x-ms-exchange-slblob-mailprops:
 0HFyhoHfXaQOnnledxMKtuK09J4Ts+W1AhOtT2zm6DnH47V8qCX9zYjnDmWjQTW9wB2s/Ow2pPi55+gbxf+wuJHQYvGDIhQpnXlyYHzxa+1ui3SLeMV9RUOCN2/hAWESNK3cXkjY6alMyP3w0EoWn9k5h5fy2lW0P4Xtjy3Tpttqx7yUQxYD5oi+EglYOqTQwCdM2QP4wwy3JYOqmDqc4HVRhkXsddF+1nmG1X1a3uI2qmP7q7DTjvU8U3waP2imKYulH1KIaXb/XTQ6PabQTS3FSu1A3wtn5R/WHfMsqa5E5nwy2aBvCl2/g/9zKIH7LweIksubKdcK+VnYvDAILC/hBWYCEyehHoZKf8xVes00VI6mNGP5GRrd/nBPyI8VE8EpiLkYBMSZL5iZWwEWt3yzbmemZsVGai7frk7mjF2GIDo3Mz8k9erhVBUfNnckBxwpA4djgqMVAi6WqdPRi5KuNlj0clsuzYvibjIlvz0+8HDY6ibcl9uSezupLO5TOi5kfrW/97ewIPEnhT5528S66sHLqC8APG0fKglm3jtgLxDTZydYP506soj2JIBnANpSW+bHJHBJBusWT6GLLWPLwlXjAfkn7XeeAZsntgb2oKkNhcwxYwkwVMTIp5cVP0/i0Ef+ayH56ezT+jArGo8uNnea7vV1+QM05OeGE5QSoiOqoU2xAsrNWnSEj0uw2b6hf6R22vxzAoquisvZm46EDCTdZh1H/qxZAqBVb1K5HSC1fqChIUQKqp86COIGhzr4OkBI3WoL2o2xGN0bzZFizESl7TyaUU/llYBb5UktjFP5EHFibJX50qXDU28R7zSh8/Nip9WIO4qxNIC90NmFN6o08e4MSYPt4biiWHygtfEq8gGF+YZSYSX93PHDwQ4fnRAexT4=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 sTyGykd+n321Ec/OJNZ1Bf1u20aFBPioPsBNeLBwLbaebq1zXak/LJw/XAUexYqVNgA58AjvmnHuRbeCeYPiiVM4GOiOVMrzIY3i4SwQsWkM4oLZfFI7umKJWbawd21Z/Jf4rEj+2qmUG3adGZcIGQOoINH52saI66EwgGh/rjkCqiFB5wY0Jq7uGHJK8sW1xIMY/ArKUxrfkkJIAik5xe0pO+7rZ6TaEXn/sePcTWuBsdI7poggZs1b39R8mCEPCtHh4LEBkcH//VdVn4r5FLZ99tuXFLCW2oEArPeegFyTCnEsILiBTm7krf1riUVJj5H94tjSDm9yMBlXqOzb4q0weAA+TQwx5+fI3la5toF7Elzyb0WuribJTRrxswJjIazhKTqT2XOcsFmzVCr7KCcc13uDTAK01LSJysxi9a0rzwricZKbXuKb1qRVF3SDuDYYSuneSq2e7Uapyay+OyDxM/2tbZev+QQq1M/NuNeSqGQeXvXGUURG9NcmpGD9W26IOl2st4Bc1aUkiOW17k/YMWhml/Vk48EHQ0R48d6xK84lhIcxI7uSQKcYLgI+PhP/B8Rtqj/YOykqtmb+6ssVrvC1hw0N50FZ0lybAIQ=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MjQ1bEVkcSt4dGpYSlltOERKTVJIRjBVRUYyK0FaN3RpcUVkQlBnbzNVZEdH?=
 =?utf-8?B?K1hJQTUrdzdnV0h4dFBHVW5DREpZbWJNQjRsVndSSlUyclUyeWZkdEJYbGxn?=
 =?utf-8?B?aVI2VU9iYWwxMkgxdGQ3b3JPK1VKYjhEZUF4MnF6YmxlVU5uak5PSldTZEI2?=
 =?utf-8?B?dVZaQVhvTzUxZWIzbGFFTjJQVW5iWkdrazBVSktBeFh4OGtHVVpNak1nbkJJ?=
 =?utf-8?B?Y1dWODJEODBlVUF2NDhQWGpvaGcwcW00aGFvS3Z5Y3lOZ2hJa1c1Qk1ZdDE5?=
 =?utf-8?B?bFpZcE55cmprQ3B5eUl1QmFqS28rcHFPeTFXZFJ0aHhETXhhY3dIeTZoT2hz?=
 =?utf-8?B?UVA1ei84Zm9EcTJpZnMyUTN3U254ajlwellGZXdmY003azF5MnRiUVVud3NL?=
 =?utf-8?B?NUVrN2NQWUpJeDFXNWp1QVFlYzQwd01FOXRYRlBtK3FFUFBnZ3p2TGtQR0c1?=
 =?utf-8?B?czlZQlhMWEN6Y00vdFhab1ZaS0dpV2tzSFVtRmJJcHZLUGw0Qkh5Qk5FVnJU?=
 =?utf-8?B?MzF1d1paZUtENGF2QWc3MmtuUkNGUXNhZklBV05sRVRIeWwvT2ZpbGt4ZWl5?=
 =?utf-8?B?ZWp4eENtZDV3NFhLSHJBVWVIcm1QaExUNXhhem02RVh0UjJoS1JYZkZSSkNw?=
 =?utf-8?B?TnFjQjZOMFlFZWpERFNyR1daSE0wZnpwNmJ5b2VOOWJTclJpYmgrZ0poN0dE?=
 =?utf-8?B?SUd6NHdEMi9jaFNWcTloSW1FUWsyTkowSlpZcjd2OWRRZktpV21lMy9YLzZ4?=
 =?utf-8?B?TkZSVGZwOEVyZi96d3U4azhnRW5Ka1NRUGlNRnZINE9iSGRWd2s4MmRIaDlV?=
 =?utf-8?B?YTk1Rkg1NUZhNTBPSTJhWlVqUUhIbnQ0Tkdtb01jQmo4MUxSbzVlOGlJU2kr?=
 =?utf-8?B?NjE4b1FUWnFPRWxRMi9zTDI4d2xhOTdyMUlrSklLVFFwUzFHVGxRU3pscjZj?=
 =?utf-8?B?NFhueFZZYTFZdFhHMDdRUEZScXU2ZDFSTEFqWU95SzJaeDY2UWdVYUl4cE85?=
 =?utf-8?B?c21HM0lTS3FNUzB2aThGYVdveWtaanN1VmV2NDJjRnlWWlk1NmRLVVR4eldM?=
 =?utf-8?B?SmFEc25XcVg3SU1wTG5Sa0gxQzR6djBTL2Z1ZFVsNi9FME5iajBDdzVhMmxB?=
 =?utf-8?B?Z0RIQ09MQnlpbzZQczFPMmpQU0xoT0plRDJDNHlTeXhQT052eUVma1c3aFl5?=
 =?utf-8?B?eGUzYnl3cjRlTTRULzZ1YmwvSEV2bTlacHdBbmZLR2xBaFQvcWNpOWpKR0pU?=
 =?utf-8?B?eTB1WWZ2SUlGbzg1d0czMVIzTlU5Q2JwUFZmWFRZVW5QV2R2d0Y0elZyM0l5?=
 =?utf-8?B?a0RGN2FQR0xPTzRGa29aS3J0VDBXU2pMVjNXNXFBQ3BQMi8xWUgxY1NNaEha?=
 =?utf-8?B?dHJCenEwM0JWcGFKOHNMOG51KzZXY05hcXNsSUFCVm5iU3hRbDNsNGZyaTNj?=
 =?utf-8?B?OVZ0RzArWDF6OUYyS3NYUlkxQVNEZkdHSndmbTg4UmNDVE9KUXQ3Zlo0bkxP?=
 =?utf-8?B?RVFNa0dkUTJDT0NjditST2EvL2V0M2hKeUlMc1hEZk5NNjl1VkY1WTQzSWxq?=
 =?utf-8?Q?Q6w+DQsIaKYPYn1l+Na/91OFQH6xLnrrDEm4GvjaJtNwLy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-49ed2.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB2130.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d7feb15d-4ada-47fc-66db-08dc234cb91a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 17:39:20.9222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P195MB0612

SGkgS3Jpc3RvZmZlciwKCnRoYW5rcyBmb3Igc2hhcmluZyB0aGVzZSB2ZXJ5IGhlbHBmdWwgbGlu
a3MgdG8gR2l0R2l0R2FkZ2V0ISBMb3ZlIGl0IQoKQmVzdCByZWdhcmRzLApBeGVsRAoKLS0KRnJv
bTrCoEtyaXN0b2ZmZXIgSGF1Z3NiYWtrIDxjb2RlQGtoYXVnc2Jha2submFtZT4KU2VudDrCoFRo
dXJzZGF5LCBGZWJydWFyeSAxLCAyMDI0IDEzOjIxClRvOsKgSGFucyBNZWlzZXIgPGJyaWxsZTFA
aG90bWFpbC5jb20+CkNjOsKgZ2l0QHZnZXIua2VybmVsLm9yZyA8Z2l0QHZnZXIua2VybmVsLm9y
Zz4KU3ViamVjdDrCoFJlOiBNaWdyYXRlIGF3YXkgZnJvbSB2Z2VyIHRvIEdpdEh1YiBvciAob24t
cHJlbWlzZSkgR2l0TGFiPwrCoApIaQoKT24gVGh1LCBGZWIgMSwgMjAyNCwgYXQgMTM6MTAsIEhh
bnMgTWVpc2VyIHdyb3RlOgo+IEhpLAo+Cj4gUmVnYXJkcywKPiBBeGVsIERhaG1lbgoKQSByZWxl
dmFudCBkaXNjdXNzaW9uIHNlZW1zIHRvIGJlIOKAnEltcHJvdmluZyBuZXcgY29udHJpYiBvbmJv
YXJkaW5n4oCdWzFdCgpUaGVyZeKAmXMgR2l0R2l0R2FkZ2V0IGZvciBwZW9wbGUgd2hvIHdhbnQg
dG8gdXNlIEdpdEh1YiBhcyBhIGJyaWRnZVsyXQoKVGhlcmXigJlzIGFuIHVub2ZmaWNpYWwgaXNz
dWUgdHJhY2tlciBmb3IgcHJvamVjdCBpZGVhcyAobm90IGZvciBidWdzKVszXQoKVGhhdOKAmXMg
d2hhdCBJIGtub3cuCgrwn5SXIDE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2dpdC9aUnJnTURh
Y1lwajQxRGNPQG5hbmQubG9jYWwvCvCflJcgMjogaHR0cHM6Ly9naXRnaXRnYWRnZXQuZ2l0aHVi
LmlvLwrwn5SXIDM6IGh0dHBzOi8vZ2l0aHViLmNvbS9naXRnaXRnYWRnZXQvZ2l0L2lzc3VlcwoK
LS0KS3Jpc3RvZmZlciBIYXVnc2Jha2s=
