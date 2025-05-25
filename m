Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011032.outbound.protection.outlook.com [52.103.68.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5331A1A26B
	for <git@vger.kernel.org>; Sun, 25 May 2025 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748199301; cv=fail; b=sIIvX+5loHybfLWRJyMAxCzjszcXvth/mR+9kn/Fu6kr49lMCBEY0kgs0NQBaXneuJWP7zXleXYKnzMQ2YB57p3nyZuY6kYmz63d9Lsl/r0A9Vk9+M1YJKyP7BqLGTi0dvsf/leYhoMKYJ60FYtWUMLA2l7tzhRABPwqp0nMYps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748199301; c=relaxed/simple;
	bh=n6uzIocZ9Dh6uUHJEIt3dXiH1pT3J/0M91sd4uNUwG8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W89nyHHlSbTBnFfg69kdoRFbtGqv3ouwbvXjLS5rlLQtYWvr0u0PQ3imX+UQKQFI1pXJFNdLUEtGJuySLqKRfep2ogn83ualucryIgzdip2sm3CNvk3BYLk2YIDygm0YwvphGno3xFTYWdCg/YF6xgBYTd1XvcyL0ilaKf357hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=c/5Imcin; arc=fail smtp.client-ip=52.103.68.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="c/5Imcin"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y+vCoJvD6EZJrG0EZyTATLraN5xpYsKoijo2UTuqK/iYzNqDfbGh38Oxj5tDRpFm6ilFJvOiAuHX8qYXDiPWFH879q9dlqS0FeCncOu0jiuOnglDMkrO5/WKDJuFEaZ+cyD84/gsvloH5MzqLnAi0lxXWg4RoJzCNh55nfOzaaDZ8NGRo/Jv7Y9/xTzk58ACrXEsx8d2oTL+PowmZrEHesB5RM6jZMJevlo5PpSo+347ZqXylUCGkGUaJyt9iubSblIbTqrHSFcTLG6PVZZwtoYUqLk58owXIkbJO0YpjXNQbhc9ZzqBRx/ONdziiP0mgUpbBfFP/PsQFJWFA2N1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13UjRHYXRl81s7D4l1d0+9bqo7/aXWYo+YXWFSRj7x0=;
 b=kQBStHfTavlZf4wTkyQgqOgUDgkCZjeUpbvF8io1sd+SGxIHtXOpUslPKNB/LRUTQLBux9BAx5fUmPbMxrYEO43jWTaJBRvvURQVReKdBkLJfojdxrIKOBk6OIzhOVzRPPC57nSkgnwVdUNxZYwtOMoioLWLzFnVpklRn2EQM63e/87KItqsKKWibAvxadlat6o3vJ3pYFLamX7p471lWp93PpIPKGn7cSRHwBISDbNrqn3m1ibM54UkSdTSmkHzCTh8beIeqS8cX+nmoVs2vObzYo8wB2QhQWwcCkvDAU6XuU+SkDlaTalfLdRL4MYn6neP+q5lNSPHnIu/mIb9AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13UjRHYXRl81s7D4l1d0+9bqo7/aXWYo+YXWFSRj7x0=;
 b=c/5ImcingBHUQBlpm91YD2jPDUwv5Q7cdIkEKqf3iTiQ3u6Jk6rY57ttoqui7yxFVhJncl4gV8abqvNCjKtH0ND9r2TQioWNoSW7LaSG/sfJLsHghLgE3hu6QADSQmafiLt/rB9k3ZJIguUF/8ywL7wz/q2nvh4tNSJdmps/q9wdOIb5ybMwyPRhlsmwqG/lfD1zBA4CJ8/h8godPEDbiT4u0QqfKT2smTnAiNxH5KOOaTAdxn7eqAgg3ZQlTr3DsosseFQqstHUOnczwn0QDhBeN8yCyFrZrYPh7QHBUz0lP6J95O3R6YE5gIAD7OurMkiRqJXf+tAmaJS2q5/+gg==
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:10c::9)
 by PN3PR01MB10362.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Sun, 25 May
 2025 18:54:54 +0000
Received: from PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa]) by PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::5b05:29d:5646:39aa%7]) with mapi id 15.20.8769.025; Sun, 25 May 2025
 18:54:54 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>, Jeff King <peff@peff.net>, Ben Knoble
	<ben.knoble@gmail.com>
Subject: [PATCH v5 0/6] imap-send: make it usable again and add OAuth2.0
 support
Thread-Topic: [PATCH v5 0/6] imap-send: make it usable again and add OAuth2.0
 support
Thread-Index: AQHbzaZ/y83S182Z/0G7/Vz3wrSleA==
Date: Sun, 25 May 2025 18:54:52 +0000
Message-ID: <20250525185447.29982-1-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN0PR01MB9588:EE_|PN3PR01MB10362:EE_
x-ms-office365-filtering-correlation-id: 74afbd72-1a06-415c-4b65-08dd9bbda22c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|8062599006|8060799009|461199028|7092599006|38102599003|15080799009|19110799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?h2OSKCrnebP1kz0IA+mTdH9EAqwWYHoJEDdsALhqWCEmMls84+lfdy7tmE?=
 =?iso-8859-1?Q?VadZJBo8Vmt+ZpEnOHU1DX0NfWgWHWXz9zu8561AEaE9QGHyY1vltDso4D?=
 =?iso-8859-1?Q?+vGpsVsKjWbJvT6Fe5+3HCS37CzovSFpkDFECvcQhmN8/LEYiX1+pYI3MK?=
 =?iso-8859-1?Q?L/eBTN7SbiD9hfhg+F9iv90IfrexuVoGzf7OsyxBMu2fOkvE6N63ntu1zy?=
 =?iso-8859-1?Q?Ds5IAnu+MOPqltiF0lqmSjylEK7Dj+EjDPhmNQagOKaTmBqyTfsaMdynTf?=
 =?iso-8859-1?Q?TGeh61ud8TvOquO149RmqWOUZUPTGjyxzpVFyMnkxGBZLpFq9E4kWKdThB?=
 =?iso-8859-1?Q?odX28gBAwwE0LU/IUAPsOJAgJCgf2gfowLev9vY4HKpcpoc5tLumaqd3Yi?=
 =?iso-8859-1?Q?rmNWe953ZUVQcc+BFAUUcM9UZaBx+YOw1pVATj2oZjVyh77vAbIO4hoVIQ?=
 =?iso-8859-1?Q?Gas9myH1PP4fG4JGkZAPWyPfbcBgkInuNb1GMxaHysLlTYw4JC8MUCYist?=
 =?iso-8859-1?Q?yVAlqcvDKp9v17kXoRW2JUEuQCJqyCLQP/XLSLl/zxeS7vJWnP7v/biUTN?=
 =?iso-8859-1?Q?z4/2hHpxInwVh1v78Zw+tvNQPmVLojChExjehlcytg6MTMea8p966XjhqE?=
 =?iso-8859-1?Q?aS5Pr46JGJjPTEPQQ6jxlyKds1NCCnE9Rx8y+c6xVBSNS1VvyvlpPnV62S?=
 =?iso-8859-1?Q?b+5DYcrTk7jH59Ykei/033qK7+B4OXwkOxo+OhTo5SX428QJLgjZ9NFv9l?=
 =?iso-8859-1?Q?oWKhTDahv5kY1C7Xy1k2DL0OgkdlCiZ/1jYAbFnU1CCOpl9JOiganPNyuJ?=
 =?iso-8859-1?Q?wd+zK7j+NbLYObv4fNIw8RW1J2YBOqSU118jqP0TZQ//YZRG3XwhtXV6Hi?=
 =?iso-8859-1?Q?pVvJSQ+R9/GactuyTtYSDOyfNHEDcSPbtunjKCaxI9gWY6tVqXO81xN8Hb?=
 =?iso-8859-1?Q?fqFgzsdPOTV+Gu8S5I1wECkEXRJKa+t+Vi01qbBI18yJNv1X7as3edRRAm?=
 =?iso-8859-1?Q?5ziSmZTrw5LPw2/s+bWOaXFP0eYV6PCP86/8PyvLEnQcYjcGMTG1J7B1Z4?=
 =?iso-8859-1?Q?xS4iSQn0mz7WrqpszoW0HujooCfjLfVg3t7f+h70pOrctmhH+mVbkHutso?=
 =?iso-8859-1?Q?09EodoWw9At+HobX7gZQVjyFZFn9WkLGtHU/eM4kYZMlwfpY/ycFjadEfd?=
 =?iso-8859-1?Q?rb9uOlCKslkSQ2W1nwL/6VchDusDpYVEcuQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3AdybMl4dcKz1k4D8E1oNcPnYCySYoiilmtrhu+f/iv0EY7+3k1PudcbPb?=
 =?iso-8859-1?Q?/FbgKymC26aIjQTUsHGtwWsmmN4tSxTJLGq6TiYussJpCJCb9QlkpIphfj?=
 =?iso-8859-1?Q?YVKspsF52WRpO97dcMps+yd9828kyj/hlHZQThDTSO0F/rVMM4tiPgUaQh?=
 =?iso-8859-1?Q?WQLv4UdJ9emLuA1qOPCtdQu6Zn6+QAFUeKoJZdJiRRaZYi652yo81dOPMd?=
 =?iso-8859-1?Q?xy9dflp/yXB3wFlgaYr8c0HMzdRJ3hesmpbYyLaslTSdyd9umjj//KuSgX?=
 =?iso-8859-1?Q?BNX47uT9NzMu0O9HDJn68kSln40RUsjAha11fEa+4ivtmFA3+c7D+3XU+W?=
 =?iso-8859-1?Q?AxA90OyrdJ5ttqkI02DYxRdr2yP6X9y+vwR2o9z0SlrIh+75Uo+M8PM1IT?=
 =?iso-8859-1?Q?/QbqjW9Pq9DtFgmsr4mIGQ7VatVgsarCPVVWhah/Ljh0LK0vNSD2Z+0vh8?=
 =?iso-8859-1?Q?rQwmahctcRST4uQRv2xGgHrdIdMc6Hb0cghIotBWjCXrPRtoMjxvWZMaKb?=
 =?iso-8859-1?Q?GYR7SOshWdiH48FPt8AmK5P1+LgPo76huiJb/f//2xxMoVCt2cZmsUltiO?=
 =?iso-8859-1?Q?0mW6dpb0QX9hLo1VwINZDrEB2iJC6nU1EqvrK7yR37SqLrxkraYUYS0k0E?=
 =?iso-8859-1?Q?jpvg9AHx3gZYwXrXYS5Z1me4Lpm8mSXuM4Ed0QQXDug+CtHLXn1TpwP5yE?=
 =?iso-8859-1?Q?8GxwFKOyqXws1fSKQshttXWu2suWFtsi0Kl5MuGfwelWurAbC7wkBKUSaC?=
 =?iso-8859-1?Q?t5ACxtq3tFpEVdCUklp8aj1Lg1nbTQkdt1Vd8VOWS4RIz3jxDst0bXIV5/?=
 =?iso-8859-1?Q?kXqQu/pHtVhkn/st2WMy3pbFmnawfsy2GEBnsjB8j2hikFG6n/sPbZH5+H?=
 =?iso-8859-1?Q?vvn1/NML/wjNTtgqOW9X8mP3giwcx2ZcG4iCaqG1IfzZeSkCGEB784d47r?=
 =?iso-8859-1?Q?lmofv/pP6nE34C3MDkolm+N60vENlYvu5o3Zv7g0iC4WqhuEXhmHwtUetu?=
 =?iso-8859-1?Q?2O6MQ4IuyYhvidLV/LjejwUYShSeRrb20QxMBKiyuwT8sSaECLBBFijPEc?=
 =?iso-8859-1?Q?PA86EdlEcMBavPISpvwAJrzMF5J5DmSVvGVxDsIylBX/qevTsxZ/6Peeqk?=
 =?iso-8859-1?Q?K8rM5r883aEyYmZACBUPDrjbeuMklwYGXkX+dpYOdfgYhfZQKaJv045g80?=
 =?iso-8859-1?Q?Klgs9JqCDAtSZ6P8pckpcgDQl/Zrgp242P8RJlNVo6KtCMp1okWyD5OwTK?=
 =?iso-8859-1?Q?RLMMW6MqL9ff/9Ad5oJcgrlcekqoDj6iDvrsc0VBI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN0PR01MB9588.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 74afbd72-1a06-415c-4b65-08dd9bbda22c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2025 18:54:52.8229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB10362

This patch series does the following things:
Firstly it basically makes the imap-send command usable again since it
was broken because of not being able to correctly parse the config file.

Further it adds support for OAuth2.0 and PLAIN authentication to git
imap-send.

Last, it does some minor improvements including adding the ability to
specify the folder using the command line and set a default between
curl and openssl using the config.

P.S.: I am surprised this thing even exists xD.

v2: - Added support for OAuth2.0 with curl.
    - Fixed the memory leak in case auth_cram_md5 fails.
v3: - Improve wording in first patch
    - Change misleading message if OAuth2.0 is used without OpenSSL
v4: - Add PLAIN authentication mechanism for OpenSSL
    - Improved wording in the first patch a bit more
v5: - Add ability to specify destination folder using the command line
    - Add ability to set a default between curl and openssl using the confi=
g

Aditya Garg (6):
  imap-send: fix bug causing cfg->folder being set to NULL
  imap-send: add support for OAuth2.0 authentication
  imap-send: add PLAIN authentication method to OpenSSL
  imap-send: fix memory leak in case auth_cram_md5 fails
  imap-send: enable specifying the folder using the command line
  imap-send: enable user to choose between libcurl and openssl using the
    config

 Documentation/config/imap.adoc   |  17 +-
 Documentation/git-imap-send.adoc |  55 +++++-
 imap-send.c                      | 277 +++++++++++++++++++++++++++++--
 3 files changed, 326 insertions(+), 23 deletions(-)

--=20
2.43.0


