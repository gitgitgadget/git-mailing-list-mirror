Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011026.outbound.protection.outlook.com [52.103.67.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05D283FE0
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 07:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749194223; cv=fail; b=mAbZ7659mskgYrO4GznwyJMgkNRqEGGquk0KbRfuEXs4m8WWX5EY7JhMVUcwUqLZjl2p+JJkt1eaFkyYCXIvRejcVkCBpAmpcnMecgfip0CSZFieDlF3aTLY0tFPRI8Z730RyqQb1j8KUcf8hij1JeCGRjGezF74xZyVuiSpJ/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749194223; c=relaxed/simple;
	bh=AarGiViB9dCzEzgK65Z+jCziDKw0W+FGMi4q3c7dDeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aL0hb8CRIA5fQO1tRe2bXy+/gb57jPgveI2fk+nW6A7FpF30+7QVuEImMJNmDMgTTKjCfOF6HClwZDV/Ko3wxf2eh5oJuhLZHHP5g386WxIVIz71dPippzmVmDHaKj7+oSDcoVG9dqufqop9kP2X6bxma0mApxNdgU5XBdP2dHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=rBbw3hwP; arc=fail smtp.client-ip=52.103.67.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="rBbw3hwP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUrm25J2bS6KfXoXnycwdzIm/6OL6WtZ+CyAugfaimRRGAhaky044mNHStonDFBRlf3HoQ8dgDm5sxNev192UzmllXTA9f2tU8z/Rw2d7Fw0iU/z4jDiqYSIJqwI2DsfTb99B1PBKzaF5M1/qU1tNE+SwR/J+8O3DEagqL3M/FiI7NJqYzcAp+GoQeRbUwqrRJ0Gyy1l01o+kzU5g6dzJOG62bMfoPKUfwOjTQhXKw7j1t3coYLW/73DZ8DalGGopkvK0pONf9QtE1YJg+mFGt3Rp0yZyQrUAWHCNjQviFLtDMTrVq74D9EpcEUMI5cxQWbc/zHygddZ145vyJxNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AarGiViB9dCzEzgK65Z+jCziDKw0W+FGMi4q3c7dDeY=;
 b=l7G7QNPn+SC3umpETqrfMZScb21PtnmTCD2sfZTYqt2yu4jRZvpknIxR2PCiLBHWKf/C3sH34FUAv3jWVKIAxFYcLsdFhprYNUtyvQGzdsUlDP/Hc57WWiGycoUtG3xfbD3+9EMy3z0dSwaNBX4Os6qXV6NlYa50zzve/zZX2t+7s5pnTp2GFsRmSUU8Bv1RNycuJ/H5EFlj3y+m04iryx5jkZrPFDhWrLPCdYgLJxw6IdTmLWy3AKmkVT5SOuK7ciDSmjpXzCboyrlGsYXFWpwpbUoXaRpmRQC2dtrelLZ89CD8kRhTng0Yf4MjmA5MEkgVXZrzQp1T+Acrl8xUtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AarGiViB9dCzEzgK65Z+jCziDKw0W+FGMi4q3c7dDeY=;
 b=rBbw3hwPywhypIiC/IbUvmRMGMOh7rUFba7V5wbRLBNjcsOvc1oQ4QrhrTt36QV/bwSv2WPnl0z+TZ13LVOwyJEmFPPZw3hXsX6EI70pLqFZkwi6PI2rnn2hYrrqU0Qa8Y5tciaGrxLUKtE+C0qoOnpIr0qnJPgn63y++UHd/dJXlal9WAmGd2abJKMNjTPGJJ1iYjNSk1LZ1DrfjsXD5FmCzvFi6C1JyGUAjU2ngu3UKJWLwPG/8jBHrrfLgSyumkqOMcNEEL9j9P975fkkipCbNxDeZyR6heU1Fz1qpyqAvYg1ZGYhixcPVufLz64T8qocL6/nZ7N6oBycjZzoAg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB9992.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Fri, 6 Jun
 2025 07:16:54 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 07:16:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
CC: "git@vger.kernel.org" <git@vger.kernel.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, brian m carlson
	<sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Topic: [PATCH v13 02/10] imap-send: add support for OAuth2.0
 authentication
Thread-Index: AQHb1rCCpRSbkEC9pkCE5UNU00JzjLP1uJOA
Date: Fri, 6 Jun 2025 07:16:53 +0000
Message-ID:
 <PN3PR01MB9597B34634910FE5E65ECBC6B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References:
 <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95974F9ED808F60A915D054CB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-IN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB9992:EE_
x-ms-office365-filtering-correlation-id: 662c6e0d-f208-43cf-024d-08dda4ca1d6c
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrOwsKBlx1JOgpuS/9RkESVoeH25oKcWcAmtPPBqpeow3M9ZxRUg+5MJxUfEw7HaC85hSDS9DCIsDBB7mI4qvlzReEZRU2FthHl5VHs2AGMU6aKwCQJzVZ86qa8Adq91UFq6NikK/dz9bfQnFdm5tH8vk8C33kBNeipO3QK0oAY3ppkvg24ccmJ/+hyoMlpgfOEiBvuruDnWUNjKLCL3jHSxO6xUkI7zFbp89G5Tg4FU+dONASfyBQmiKnE7itmbKKexEYQV64wvV2cO2pQ2CArRYyDKFGggrxzEhQ46DtnFUCve1rUoAo1c2PHjlIXbT834iqXrBHwbxAsSv5WdRW5xJrc5qJ7FzDytK2fO8xkz63+a1wHG37DeMA6WQ9qSu9VGeDwUbSMePaZM44taHV4h2lFCsaDDtN/DS3p1zfnRU/R+BIv4zOG4a6hYaZN7eRZf1JKUJAiwZuWUBBH3orkj9nE5lUtbwpe/VcmV70k66kNctKyfffifmG/uztRjDsCWWxZwoTqbQ1vTQyKN+4z0Ntj6hsDpnd8h4fQZdhdLN+scIWrINBhNYUYDvgmf8/uaOdVsC7hLmeFIlexCqZ0m+Q0FUUqfDRAo4bWtlPfJe6tjkq0MPcvyWszsK3GbcVZuAYYFeZr9s/IJFaULXRzyq0xQDkkYjZPxOZJAhEjxuEaOBb+JTY9Z5P9NZ4jFWyKzcjmySmiPYLxJC/sZAv9FbZsaFU0gpPVekl4iT6YpVp5k2lywNsVT9oiQImYdpNw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8062599006|8060799009|15080799009|6072599003|461199028|19110799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2cyTHFOOWx2SHVkMVR5L1pYcVd1em9VK3ZlVVRoM2pVWm82em5Vcm1NVlpr?=
 =?utf-8?B?QXRjdXA1MUhXa0tJblJOZTFFbVQ3S3NxZ2tXaG55cW9rUFgxREcxVHFwYnRq?=
 =?utf-8?B?UXIyZE1NM0ZtZUNoY2liNU4yK2t1d0hCOTRuUWZDV0FKR0VhbHNOamdUalZ3?=
 =?utf-8?B?UWZEbzJwcTBNZ0ZBN3ZqdFJ2bzlkOHF5bTF6cEYrVllOdklVQ0Y0dEIzbjds?=
 =?utf-8?B?ZFN0SDVqYThJaTlQTy96TGJIVHROM05PWGtCS2RkeGhETncwampwVWRJYUVB?=
 =?utf-8?B?Z0ZhQWs4NUlVTVRFOHRTSFQvTDRiVnAxQlNGaTlJOENMMVdQUU5EZnZmcW16?=
 =?utf-8?B?OEtMY29lYlNNUWZVUXhyOXQ0NnBSbW91V1F4QkVnZm5URFMrSHRJOFI1K0k4?=
 =?utf-8?B?andjeWcyU3VyUVRucjFnTitiZjVpMytkWG8wK0tKc3FWYTJHMy9UQXRTcm4v?=
 =?utf-8?B?eUUwRDRkT1F6UkVxNTdvYUxHT1BSVDJPaDhYZzNKNEtEcDlxYm5aL1FkQitB?=
 =?utf-8?B?VGt2ZmZzTFp3ckdOR3lTY2M0NHo2U210K0FrQU16amZzN0l5Zzl5c3pUM3VR?=
 =?utf-8?B?SFpGV04rbjVGYTh4ckxWWEM4RDBIaDdPOTRZMkJ0Y3FCZnNtbDZhbmwrZHBF?=
 =?utf-8?B?RC9WcFhNenNodzBGYXZ1SzB3dVBhSlgzUDk1djRKN3IvNXd2V3lvSWhhRnp1?=
 =?utf-8?B?WWVXRU84WUp5bWVua0YvOXBJcldUdmtROGVVNUxNQmJvWi9WOTVIY0tHYThP?=
 =?utf-8?B?Q0dCT3RQZ0Yxb2dTMkJqcUNBQ3ZKZWhJd1dKR0pjSUZDMURRY0prb0tPYWpV?=
 =?utf-8?B?TzhpWC9hOU9UK3BlYUJsSmxSbHJOcVR1ZnBtRE1FSXBUWmZLQ25RcnE5UTVi?=
 =?utf-8?B?WituR1B0ZndoUzhoeERwVXRYWm55RnhRdTRraWpSZ2c4Tnd2c0hjZ2hteGlt?=
 =?utf-8?B?QVBJMXB5Smk3ZTB6TGNQS3paZVBPeG54WXZXclluRVhVT2hRdFBVSDBEYnRO?=
 =?utf-8?B?ZDZBZVpqc3FDTW9GUGdDT0g1MTVITTlzOGIvblRYS3N1UVNTRUQydU41RWRj?=
 =?utf-8?B?dW8zR3lvcEI2OHU5ZGl6S0MxMjY3d1o4V2RyMEp3RHRkd0JMNjhMNXRHQk5S?=
 =?utf-8?B?SmgrTGE4ZVF3ZlVGOWlXbHQ2SUhkUkVIQkh1ZXp5WnN3eHZlSVBNejFPOTd2?=
 =?utf-8?B?djVHZFRMbm5aTE90ekdTcGg0V014U0xZVGp3UkFzVEF0RFBCVUYzM2pUUHlM?=
 =?utf-8?B?b0hzejkva1BPM2RUamUzVCtIaGZ4WUR5QmN2T0ZSZVlRM1ptNzNWQm5lWlpv?=
 =?utf-8?B?dTQvOGpKUmh0VENJaDFMWkt4aWc4N2lvYWdZMSsxVXNuQm1BbmNqYWZUN2Fo?=
 =?utf-8?B?TEtNK2UrbGlMc1RkcGhqUCtUT3k2UEJSNkZZNGN2YmdrNUJwa2J1cDVybEhP?=
 =?utf-8?B?TjZRaHBSRHA5ZEJEOXljejNlMlVCblRRTDFJU1ptSkJpU0wwa1UzOE0vaDQr?=
 =?utf-8?B?V0hzUTZndER6all4VDJybnJLbmNRR2xORys2OS9DV1pabENuY2NqSzJoY1dK?=
 =?utf-8?B?QzhzQT09?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a2I0RDBPRzhkaHFlR3o3Qi9RdDVUYmR1SVF3RUdjM1dDbXJJVEJJQy9jbjhh?=
 =?utf-8?B?QUZ2OUQ3Y3h4QlkraFNZbmtoQ1dTZ3BSQTBYV2Q0OVUwQ3RnNlE4Q3kxSXR6?=
 =?utf-8?B?bHBxQ0NiNUx6TVhRRGY4SVNQeFJncHk3U1Y1ZnBsSTNyVm80eEVDenc1UVB4?=
 =?utf-8?B?dHQ2WHVKNTRjVmNlQkdtMThxOTZnUDJDYUhhd3lYaWtaWmg5Yk5mQURIL0s2?=
 =?utf-8?B?VVBPWXJPNWJkNk96VE5wTVFFTkZaVVlObjBYMGUvbVFUcHFtelpabzZyQkE1?=
 =?utf-8?B?MUI3Szh4S2d2VjVQNEhGSFRtbUltZjIrTlF1RFRET3pZYUZOMk84cmF4Z25S?=
 =?utf-8?B?SG1VNTR1K0V2cGxJOFloRzFJTFlJbzB0MVd6T1ZtWURxbUh1eWErQis2eVlK?=
 =?utf-8?B?clY1cVBLK3BpNVgzWWJLTU4xbDYveHJHNXdJL2xQaGUrbUZ5WEhXMCs1L1BQ?=
 =?utf-8?B?amhqM3BtTWxRMkxIUmZ1SmMxSHA4ckVESENVR2ZMY3dRcjVoL08xM091V1Uw?=
 =?utf-8?B?RkFWei96N2VHZUtUYUZscTk3RkJLazZ3UzhzdHJ3SFpySmtkT2ZhNmpGUy8x?=
 =?utf-8?B?RzlnVjlBVWxrTFN3NjVFbDVNc21vdTZIbDhwbzVBeVRRdkxqUGRlNmRVQnVp?=
 =?utf-8?B?aDBHUVUzU0RtRnZxZHBxcjZOM0pPOHBRZThua2VNNjJOUXFUUklHbC9hTlNu?=
 =?utf-8?B?VEhSQWZtM21ZajZmWE1nUER0dVpDQThWSEZJWHVTU3had3BpaVdvNzNYVy9J?=
 =?utf-8?B?OVdaMC9UUEJVcExxaWtlYWViblBOT1U2Qk4zR29oRjc1U3AycnovT043QTFO?=
 =?utf-8?B?VURPMlVkUW5ITWRBOU9RUElDQjVONDVaRDg5YUg4ekVsZDNKb1JIUmNXN0ZL?=
 =?utf-8?B?eUoxWFNrUUJleDRHSys1VnVTQWNVa2JPU3RiU2ZPZDFIN3FIZjE1QTRLbmU0?=
 =?utf-8?B?SmMwRFJDbEZMcEc5bUg4MVJSWEE2WC9CMkpKQXFXR045eUJLdUorbE1iMHgz?=
 =?utf-8?B?YUdLVDQyTFlPTHIwM0NrVk4yc0hwem13MzJwMG1UcE9BR2JzN00vN1MzaHRo?=
 =?utf-8?B?b1BrQ25qMkhxRGZzeElJcExKTzdQNmE3TUpXTHJ2SE9tMnV5bEZNdE9xTmVa?=
 =?utf-8?B?bVJMNUJYb1EzRGxKQk1aeHZWa0pTeVZYdW9CbVljclFvMlp5ckxVcm1kVGgv?=
 =?utf-8?B?WGM5UGtHdVE4ODlNT0ZUYXFRSU11TFdoZERYditKTGEyZkZ2ODFpK0tKLzN0?=
 =?utf-8?B?Tk4yWERIQkhJR0VaM0hJdU4vYjk0Nll2amNwY0dQWnhIbFpPQzJsLzdjVkdS?=
 =?utf-8?B?R3pmSG5mWkNXdDU1SVFmVFZrYnNmSUdNdnlaS2szdUVZY0V3VlJaNVJ1TmNr?=
 =?utf-8?B?VzNlWnlpUXpYL2RlT3pjQXlXVnB4V3JnRVlwdnVRWUlPaGd3YzJjR3dQNnJT?=
 =?utf-8?B?aWZHU0QvVC8yeUdXaVlRSUhYM3FiVTA3VWlhV0c1K1crOWZ2WDQ3UG9weTdp?=
 =?utf-8?B?ekhGd3B6YlV3Q2xyUmlWSUVPWFkwYjhic0tOTHJtWTlBbE9uOWhDbWhEcGpU?=
 =?utf-8?B?SmpOak5SRUw5ZjJuY0ptdkhMeTY0TWhaYW1KQmRlL0lyVkFnKzQ4NmNOYllL?=
 =?utf-8?Q?HEAdZPuutqbA+V3sXpq4WQUa69x1GtbQG4AWdxu300JM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 662c6e0d-f208-43cf-024d-08dda4ca1d6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2025 07:16:54.0058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB9992

DQoNCj4gT24gNiBKdW4gMjAyNSwgYXQgMTI6MjnigK9QTSwgQWRpdHlhIEdhcmcgPGdhcmdhZGl0
eWEwOEBsaXZlLmNvbT4gd3JvdGU6DQo+IA0KPiDvu78NCj4gDQo+IA0KPj4gT24gNiBKdW4gMjAy
NSwgYXQgMTI6MTjigK9BTSwgSnVuaW8gQyBIYW1hbm8gPGdpdHN0ZXJAcG9ib3guY29tPiB3cm90
ZToNCj4+IO+7v0FkaXR5YSBHYXJnIDxnYXJnYWRpdHlhMDhAbGl2ZS5jb20+IHdyaXRlczoNCj4+
IA0KPj4+IE1pZ2h0IGxvb2sgbGVzcyB1Z2x5LCBidXQgd2lsbCByZXN1bHQgaW4gYSBjb21waWxl
ciB3YXJuaW5nIHRoYXQgdGhpcyB3aWxsIGFsd2F5cw0KPj4+IGJlIHRydWUgaWYgY29tcGlsZWQg
d2l0aCBOT19PUEVOU1NMLiBJZiB5b3UgYXJlIGZpbmUgd2l0aCB0aGF0LCBnb29kLiBFbHNlIHRi
aA0KPj4+IEkgYW0gb3V0IG9mIGlkZWFzIDooLg0KPj4gDQo+PiBTb3VuZHMgbGlrZSBhIGdvb2Qg
cGxhY2UgdG8gdXNlIE5PVF9DT05TVEFOVCgpLCBpdCBzZWVtcz8NCj4gDQo+IE9rIHNvIEkgd2Fz
IHdyb25nIGhlcmUuIFRoZSB3YXJuaW5nIGFjdHVhbGx5IGNvbWVzIHdoZW4gd2UgY29tcGlsZQ0K
PiBXSVRIT1VUIE5PX09QRU5TU0wsIHNpbmNlIGF1dGhfb2F1dGhiZWFyZXIgaXMgYSBmdW5jdGlv
biB0aGVyZSwgYW5kDQo+IHdpbGwgYXR0cmFjdCB3YWRkcmVzcyB3YXJuaW5ncywNCj4gDQo+IEFu
ZCBOT1RfQ09OU1RBTlQgZG9lc24ndCBoZWxwIGhlcmUuDQoNClNvIHRoaXMgYnJpbmdzIHVzIGJh
Y2sgdG8gdGhlIHNhbWUgcHJvYmxlbS4gQ29tcGlsZWQgd2FybmluZ3MgKFdhZGRyZXNzKS4NClNo
b3duIHdpdGhvdXQgTk9fT1BFTlNTTCBhbmQgbm90IHdpdGggT1BFTlNTTCwgd2l0aCBubyBvdGhl
ciB3YXkgaW4gbXkNCm1pbmQgdGhhbiB1c2luZyBtYWNyb3MgZm9yIHRoZSBjb21waWxlci4NCg0K
T3IgbWF5YmUgd2UgY2FuIGp1c3QgdXNlIHRoZSBvcmlnaW5hbCB3YXksIGluIHdoaWNoIGl0IGRp
ZWQgdXNpbmcgYSBmdW5jdGlvbj8NCj4+IA0KPj4gICBpZiAoTk9UX0NPTlNUQU5UKCFhdXRoX29h
dXRoYmVhcmVyKSkgew0KPj4gICAgICAgLi4uIHNraXAgdGhlIHRoaW5nIC4uLg0KPj4gICB9DQo+
PiANCj4+IA0KPj4+Pj4gICBzZXJ2ZXJfZmlsbF9jcmVkZW50aWFsKHNydmMsIGNyZWQpOw0KPj4+
Pj4gICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfVVNFUk5BTUUsIHNydmMtPnVzZXIp
Ow0KPj4+Pj4gLSAgICBjdXJsX2Vhc3lfc2V0b3B0KGN1cmwsIENVUkxPUFRfUEFTU1dPUkQsIHNy
dmMtPnBhc3MpOw0KPj4+Pj4gKw0KPj4+Pj4gKyAgICBpZiAoIXNydmMtPmF1dGhfbWV0aG9kIHx8
DQo+Pj4+PiArICAgICAgICAoc3RyY21wKHNydmMtPmF1dGhfbWV0aG9kLCAiWE9BVVRIMiIpICYm
DQo+Pj4+PiArICAgICAgICBzdHJjbXAoc3J2Yy0+YXV0aF9tZXRob2QsICJPQVVUSEJFQVJFUiIp
KSkNCj4+Pj4+ICsgICAgICAgIGN1cmxfZWFzeV9zZXRvcHQoY3VybCwgQ1VSTE9QVF9QQVNTV09S
RCwgc3J2Yy0+cGFzcyk7DQo+Pj4+IENhbiB3ZSBjbGFyaWZ5IHRoaXMgcGFydCwgcG9zc2libHkg
d2l0aCBhbiBpbi1jb2RlIGNvbW1lbnQ/DQo+Pj4+ICJVbmxlc3MgWE9BVVRIMiBvciBPQVVUSEJF
QVJFUiwgdXNlIHRoZSBwYXNzd29yZCIgc291bmRzIGEgYml0DQo+Pj4+IHN0cmFuZ2UuICBXaGF0
IGFib3V0IG1ldGhvZHMgb3RoZXIgdGhhbiB0aGVzZSB0d28gdGhhdCBhcmUgbm90IGENCj4+Pj4g
cGxhaW4gc2ltcGxlIHBhc3N3b3JkIGF1dGhlbnRpY2F0aW9uPyAgV2lsbCB3ZSByZW1lbWJlciBl
eHRlbmRpbmcNCj4+Pj4gdGhpcyBjb2RlIHdoZW4gd2UgYWRkIHlldCBhbm90aGVyIG9uZSB0byBl
eGNsdWRlIGl0IGxpa2UgWE9BVVRIMiBhbmQNCj4+Pj4gT0FVVEhCRUFSRVIgYXJlIGV4Y2x1ZGVk
IHdpdGggdGhpcyBwYXRjaD8NCj4+IA0KPj4+IExldCBtZSBhbnN3ZXIgdGhpcyBmaXJzdC4gQ1VS
TE9QVF9QQVNTV09SRCBpcyBmb3IgcGxhaW4gb3IgbG9naW4gdHlwZQ0KPj4+IGF1dGhlbnRpY2F0
aW9uLCBhbmQgaWYgc3J2Yy0+YXV0aF9tZXRob2QgaXMgbm90IGRlZmluZWQsIGN1cmwncyBiZWhh
dmlvdXINCj4+PiBkZWZhdWx0cyB0byB0aGVtLg0KPj4gDQo+PiBXaGljaCBtYWtlcyBpdCBzb3Vu
ZCBsaWtlIGlmICghc3J2Yy0+YXV0aF9tZXRob2QpIGlzIGVub3VnaD8NCj4+IA0KPj4+IE9BVVRI
QkVBUkVSIGFuZCBYT0FVVEgyIHVzZSBDVVJMT1BUX1hPQVVUSDJfQkVBUkVSDQo+Pj4gaW4gY3Vy
bCwgd2hpY2ggY2FuIHVzZSBlaXRoZXIgb2YgdGhlbSBiYXNlZCBvbiB3aGF0IHNlcnZlciBzYXlz
Lg0KPj4gDQo+PiBUaGF0IGlzIHdoYXQgd2UgY2FuIHJlYWQgZnJvbSB0aGUgdXBkYXRlZCBjb2Rl
Lg0KPj4gDQo+PiBUaGUgcXVlc3Rpb24gaXMgd2hhdCBoYXBwZW5zIHdoZW4gdGhlIHVzZXIgc2V0
cyBzcnZjLT5hdXRoX21ldGhvZCB0bw0KPj4gc29tZXRoaW5nIG90aGVyIHRoYW4gTlVMTCAodW51
c2VkLS0tdXNlIHBsYWluIHBhc3N3b3JkKSwgIlhPQVVUSDIiDQo+PiBvciAiT0FVVEhCRUFSRVIi
Lg0KPj4gDQo+PiBJZiB0aGUgYW5zd2VyIHRvIHRoYXQgcXVlc3Rpb24gaXMgLi4uDQo+PiANCj4+
PiBPdGhlciBhdXRoIG1ldGhvZHMNCj4+PiBhcmUgbm90IHN1cHBvcnRlZCB5ZXQgaW4gdGhpcyBj
b2RlLCBhbmQgdGhpcyBpcyB0aGUgcmVhc29uIENSQU1fTUQ1IGlzIHN1cHBvcnRlZA0KPj4+IGJ5
IG9ubHkgT3BlblNTTC4NCj4+IA0KPj4gLi4uICJ3aXRoIHNydmMtPmF1dGhfbWV0aG9kIHNldCB0
byBvdGhlciBtZXRob2RzIGxpa2UgQ1JBTV9NRDUsIHRoZQ0KPj4gY29udHJvbCB3b3VsZCBuZXZl
ciBlbnRlciB0aGlzIGNvZGVwYXRoLCBhcyB0aGV5IGFyZSBpbXBsZW1lbnRlZA0KPj4gZWxzZXdo
ZXJlIiwgdGhlbiBJIHRoaW5rIGl0IHdvdWxkIG1ha2UgbW9yZSBzZW5zZSB0byB3cml0ZSB0aGUg
YWJvdmUNCj4+IGxpa2UgdGhpczoNCj4+IA0KPj4gICBpZiAoIXNydmMtPmF1dGhfbWV0aG9kKQ0K
Pj4gICAgICAgY3VybF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1BBU1NXT1JELCBzcnZjLT5w
YXNzKTsNCj4+ICAgZWxzZSBpZiAoc3RyY21wKHNydmMtPmF1dGhfbWV0aG9kLCAiWE9BVVRIMiIp
ICYmDQo+PiAgICAgICAgc3RyY21wKHNydmMtPmF1dGhfbWV0aG9kLCAiT0FVVEhCRUFSRVIiKSkN
Cj4+ICAgICAgIEJVRygid2Ugb25seSBzdXBwb3J0IFhPQVVUSDIgYW5kIE9BVVRIQkVBUkVSIGlu
IHRoaXMgY29kZXBhdGgiKTsNCj4+IA0KPj4gT3IgdGhlIGNvZGUgaXMgbm90IHByb3RlY3Rpbmcg
dGhpcyBjb2RlIHBhdGggc28gY29udHJvbCBjYW4gcmVhY2gNCj4+IHdpdGggYXV0aF9tZXRob2Qg
c2V0IHRvIENSQU1fTUQ1IGhlcmUgKGUuZy4gd2hlbiBidWlsdCB3aXRob3V0DQo+PiBPcGVuU1NM
KT8gIElmIHNvLCByZXBsYWNlIEJVRygibWVzc2FnZSIpIHdpdGggZGllKF8oIm1lc3NhZ2UiKSkN
Cj4+IGFib3ZlLg0KPj4gDQo+PiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgeW91IGFyZSB0cnlpbmcg
dG8gZmFsbCBiYWNrIHRvIHBsYWluIHBhc3N3b3JkDQo+PiB3aGVuIG90aGVyIHVuaGFuZGxlZCBt
ZXRob2RzIGFyZSBzcGVjaWZpZWQsIEkgd291bGQgZXhwZWN0IHRoYXQgdGhlDQo+PiBjb2RlIHRv
IHJlYWQgbW9yZSBsaWtlOg0KPj4gDQo+PiAgIGlmIChzcnZjLT5hdXRoX21ldGhvZCAmJg0KPj4g
ICAgICAgICAgICghc3RyY21wKHNydmMtPmF1dGhfbWV0aG9kLCAiWE9BVVRIMiIpIHx8DQo+PiAg
ICAgICAgICAgICFzdHJjbXAoc3J2Yy0+YXV0aF9tZXRob2QsICJPQVVUSEJFQVJFUiIpKSkNCj4+
ICAgICAgIDsNCj4+ICAgZWxzZSB7DQo+PiAgICAgICBpZiAoc3J2Yy0+YXV0aF9tZXRob2QpDQo+
PiAgICAgICAgICAgd2FybmluZygiYXV0aCBtZXRob2QgJXMgbm90IHN1cHBvcnRlZCwNCj4+ICAg
ICAgICAgICAgICAgICAgICBmYWxsaW5nIGJhY2sgdG8gcGxhaW4gcGFzc3dvcmQiLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgc3J2Yy0+YXV0aF9tZXRob2QpOw0KPj4gICAgICAg
Y3VybF9lYXN5X3NldG9wdChjdXJsLCBDVVJMT1BUX1BBU1NXT1JELCBzcnZjLT5wYXNzKTsNCj4+
ICAgfQ0KPj4gDQo+PiBJIGNhbm5vdCBxdWl0ZSB0ZWxsIHdoaWNoIG9uZSB5b3UgbWVhbnQsIGJ1
dCBJIGFtIGd1ZXNzaW5nIHRoYXQgdGhlDQo+PiBmb3JtZXIgaXMgdGhlIGNhc2UgZnJvbSB5b3Vy
IGV4cGxhbmF0aW9uLg0KPj4gDQo+PiBUaGFua3MuDQo=
