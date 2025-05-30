Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28418236442
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620219; cv=fail; b=iGXW/nJrlbQnBffy/YSDBeBbrEBEgYJdTlTF27KWbNsIz8W0bd63E4LWNtAov1sTeU6dqxQBz0/kTCCKIuVd8Zbi3Td3vdgUdOKtaTfF/jxw/scq4746Wg4oEHq4VElzWOcNls470tTYaoDQiZ3SJQq4FgcoBK/yCQ6r0x35Jcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620219; c=relaxed/simple;
	bh=ScfEskHHxcePZzRt+Kog9JEQa0eAyEK2ng1bq4dbLEA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lm4QwjOmUxUy0/6XjeyS+V7osSJ8K0pNKAb4ELqTeWhG9OonokAxIJ8nTWswV2tmoi1m6cApZEg7Ie+5sD0OsCYgiIOiUowbxbEXwFwNxlP+7PwPXXLZ4zbQ9l7Ojgd2WnrfPlOT8JtMzExfqy7eeArOlibU4u7KRfCsFD88P3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UTBngzG7; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UTBngzG7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MeuR0Ug9BRJ6/tWK5qMATvuNl+BjMDVYSvCPWPVkujeCORUShL0w685YxuNNnLUNcSGOTUsZLmBSjWRSFsRWNpras4Dw0VA6Kj7nfgPyMipqDl7u8WgNAIr5j5MQbr6pE99SoelWgkfDV54RZYvnVnIUGO/fYyw/pAWZNyTftGXLzYU4PlnHOSodVlkf9mcBB0hAyjjng2LOoO6QExf7cSb65T3HXoXAZUjcRlSVqL8KhDgVbYrqv3EuMUM2RXkg/+MA/Aidp6AxPIk+oG8yiw4LSWN/Yv9GzmPSFjP8Q+0drdx6j+JT/oWHqtW9uibeR8XQI4RBDzH5C4vXXbcVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NANh5JnHJu4aCdymOf+NI7Vd8f19K885HuBRpbfKzkY=;
 b=s2xzq8R8rIEWQ9wlfOu3k1qn6MO6bXDPbq6ogn0f6KhuTpxP8p7b2s5VOo6AfvgwRjr4z0Kkt3rW5HmI+jHpuVO/Ljf40MU4WF9FqClmHRwcSpTBd3F0ZNCDVUfvhF+/IVUg2ndEoAiByJQKOIAC3qziCJExfvmXqVOl9NSRlgxYm94phWPEphxBl3VQncAmUKccgkzhRchREm0rKESBCa38bQL0RwlnmMt1tQPxSTzl0sxQtsrzg5zDhPDZ4dtRvqFdgNh/ZH+tHT4RHGlnFI3TIr3z+zwYcvV6/0QfsuHe03EQQEIjKBwYsw06knkN07U6rKymeSxNk7OCpOOdNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NANh5JnHJu4aCdymOf+NI7Vd8f19K885HuBRpbfKzkY=;
 b=UTBngzG7umbH1bscbT3jqyewQ7OpDaagWzHOqO1b8ladCpe+wqoLBKqToO708HETsXtXu/+2PYTL/FEBIfmh2o3DFzDVoclYX4Y1A7HYabDck4bsULCTQUcFlCvd6fDZ7txOEHD0QvHnUs+fJLYCizBtPSEbQVxd4i3zF/eNe++WCkKga9doCXDZ4Cs/tvfo6wxZU8zujE7nP6la3IyRxGclqn4alcSNXs6XwWtSi5p67tGpsyZ42qzEEEeDDmBoX41Lw4FIFHjCgNOLe/bkhJNO753cXrxmwxW7DHVZHCjUjW9ln4VvQduNHiubBDgBSQ7GbSdJqNNlTJawyhVnyQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 15:50:07 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 15:50:07 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>, Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 4/4] docs: make the purpose of using app password for Gmail
 more clear in send-email
Thread-Topic: [PATCH v7 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
Thread-Index: AQHb0XqEshU6RDr/hkOuQo61el0WcQ==
Date: Fri, 30 May 2025 15:50:07 +0000
Message-ID: <20250530154934.10077-5-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530154934.10077-1-gargaditya08@live.com>
In-Reply-To: <20250530154934.10077-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6024:EE_
x-ms-office365-filtering-correlation-id: 619ce797-9f29-4b23-f3a5-08dd9f91a6d4
x-ms-exchange-slblob-mailprops:
 AlkLxVwsndlmbqnVVkeM2BobHaL9Maaa1bfFL2Q6k3wGJ1VB0dI22NLBeIKUebV5yD8JpT+JkLuB+DJPqU/kc8sY2I3QdcKhuXVkEW0zNZOxCQynVg2VMpJSVOsJVCvWR9o7j4j9QOA1slq1JDz8L6dh0sRZvV+Xybj1o+8//1QNMHCscyPilR/IUJxHWl2q8L+/aCQ7bLeE+S/8JKMfEODp3GJq4Lb+NU8Dzlh7qx560DA16ScbZh6+WSrApPArNvXS2OeKSC5WXq3XFGhMaLz8pIYTna0Ugmq9pB1sHLwoIENLBHiEQ0TkFQuGLfjfGo/SaBb6J+i/V5ihcO/zWgE7rbrmlUed/oFY9EsD2Q3qkeAXF4/rOoMqZ0oFIXLgbO4KAd34183uF6WyZ4dPQlPbWx2B9IjQIOudWztpoiGF8y8sqbaaaaZi/K7qf6v1IHfus2Bu6tP9F2zMcGWPMJziEjqkZpUw3U1r42ThA9md0mcaK7UzOpFL5hoJieeR3Be59mzubZ7zdEkzD3bT+OSHbVcj/F5dV1vdcNZSMka29D9P7u9hZwg1NbG0tosSDorIng7GEBggG9Cj+04Q03srIA2uGkLKjzIB68FEPpD/N+0p19nGfxMRjqI/YyKmpZE8O8kki1MgM8cd37zLDc0R1pqy44YAGCD2Hn3XmeXlbzdzVBTMoyX3I2VmxF/2+r63RWDmccl3lKiE489GbM/3JY7gacyBefk/9NvCivRXdmuFRtAl7rR4agO36y54qk0M21SUMEnMz7hyQI44LSBxKZJCGiBc
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|19110799006|8060799009|8062599006|21061999006|15080799009|12121999007|19061999003|3412199025|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OMLH1/oJ0Lj0ux4dvqjP9GPBURGz0WeiIjVpGzuNxG8dUCCWDg/9V+JgcM?=
 =?iso-8859-1?Q?vkmjxhlkBIfO9YG7kr3XkCT/tNh6TnJrjVRcE7ZRXhSj9Dh5KP7lr3xRpk?=
 =?iso-8859-1?Q?xdwQQX8y5Ph2sYmLpZnXhUs5FTY2oe5PfK9vrjIypcwb6gQc7rWJ8EzkTc?=
 =?iso-8859-1?Q?k7Gglj5NUdeWtd8VnQIKQhsHLWHUOO7Hqipt2ywy1eF31z/6awZgmSCMZd?=
 =?iso-8859-1?Q?EY/heHKQwHerm2Bl3Yo+nUUt8Yue1d3DBvKHws2F22A5a+n/eblWK5VbDE?=
 =?iso-8859-1?Q?7XKaZjDiHAAhSg0yHG1D/xg5RA93ru8yOHQXnWyyqndGpYFs1m6p3j8zjA?=
 =?iso-8859-1?Q?D8m4KTuUpK5D2qTf5ipvRlzx4wE4rOMFp6yIiLaJB6alv3i9AKSbG/w7L9?=
 =?iso-8859-1?Q?dp2OLUVaB0LPtaSPpUFK05WwojPJRH1iWcYgzrHPbrmjhXhReap/JYtSCq?=
 =?iso-8859-1?Q?YJYfxNAodsqXNeMGYT0lPS/EBvVz8LopyJ77oe2bE5wB/PAQSB30X/79Ze?=
 =?iso-8859-1?Q?psrD6jHwGeI1o+LbR3KAlX3LYFDiL0eErJ4QeDYypVs7FRC/kUJRFjI3z0?=
 =?iso-8859-1?Q?y330jIPMZ5+iH+RPSd7CGqLX7MT3hEfjXeiSMXEglc0aV7IGWzgQe4xmHN?=
 =?iso-8859-1?Q?YkTr8jkDlQu9jOMu9UWneIVfMZ3SXSCZu9bQ61XNspv5LLpv7PUP4lVTUW?=
 =?iso-8859-1?Q?AcD+nrt7cUutvg9L9I1vMIEIgrYr9u/2jAjJ5NT4+VmF/E/Z68r6hIhuyo?=
 =?iso-8859-1?Q?RwmEJiTGXv0lJlARmhFz3V1lMuYOwI9pH0nuZBL9HOJf+bsa00hctd1Y2G?=
 =?iso-8859-1?Q?IlTxlFkb0rVV7ytdyELCn6NnvW871HKenn/HXhHoEXTE0Xe5AtEdSIiyAC?=
 =?iso-8859-1?Q?UWuz7uGGUlnvcSdlfhoPVC0GBfODLzqxv5Yi9+ELUJww/jAXjZDOxl+vH3?=
 =?iso-8859-1?Q?8CjqU8PiSumW1ZNv0OICDlvaw5kbMWQxztG2r966Vj+zQCJC6JXGb6/U/8?=
 =?iso-8859-1?Q?RtIqol+fnxfQFWY1vcZBTEnJIjjdgrHIX5IDoZzHzRnuMcSk0Fw/VdL8C3?=
 =?iso-8859-1?Q?Km7RZ5o+rAKk40QwP9uP+CUcDYmjrHtOSUWB38IKRiu9oYRDFQPiqPiYcC?=
 =?iso-8859-1?Q?4GGHclFdFLnz/A3u0It4CeJk20XITE9hx7K1KTZHpWnUsuWfrB7GFLSiO9?=
 =?iso-8859-1?Q?63p5Np/FFc4f6AnaxzqvaEmF5EY5tBCdvtu/tW1sWWK1uLH9Cg8lthUHBq?=
 =?iso-8859-1?Q?p4fvT9nOr1Ae4bPc31qciNEFyObh8fLQ56kDaF+qnZYdfhEftAl+6MpT04?=
 =?iso-8859-1?Q?f7VW3GsjWeir8IBXYwi8/Uy5OVkoooUXE6jr4+Hc7T7SC4s=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Kn72jrYlSm25UQgI/u7RcnHzGUoGG+Nwfcxes4hO4yKTwiOkNwoqWMG04U?=
 =?iso-8859-1?Q?HtqUfRe9YHbdhIim9zhNnly8Cu4V+k9iqxWJCH9OPC/NBGgmFF5+zGFSVl?=
 =?iso-8859-1?Q?VOnAqKCuwHOLtyYXmMrCqFL6vaStzAld1tc45pUfcoRsQMXmsmBiL9ji6C?=
 =?iso-8859-1?Q?7m9PWXTJndpJ4T/GnL+Kdne48oqc5qCn0qfC0oiGRP9tJjrxZwi27dkcUy?=
 =?iso-8859-1?Q?PYypndq8AovlWmIgInWGCBPt1IEwMBtf5IdBNwdsF4ccrWktW81xxBXs4x?=
 =?iso-8859-1?Q?vadegsGOJ2Cmx0Uf1+Wd1mBDAVb9Diz8g248hnR1tgXF5ciYN1HH6uRx8K?=
 =?iso-8859-1?Q?wDy9GeX83dGB+OwiDqOr7QwsSVsrpKOc5EcNJJGzImNnisWuLL1KFMpG5f?=
 =?iso-8859-1?Q?j89UeLiy+bAF7MFJ6KRQ7B/xIkBq6DdwRT2enCPQIsCMuTczJXAnqzRr8b?=
 =?iso-8859-1?Q?ooMAZKMnQFWsByWHSBkwKHbxOlwk5ZlsuAQmIALb0bSLclj86Aupw01sxh?=
 =?iso-8859-1?Q?TecX9HTkw+QBQZ5dXch+8dftixyd1I2M3fi2HEmMQhM9d9ks/XC8TI66Sp?=
 =?iso-8859-1?Q?4anojI8AZy8oy0MvJw4I/xl1isHjvZWLdiVyDm7pct2ykReR+KO+svWJ3c?=
 =?iso-8859-1?Q?pFJLlvRfMissfVKJPpxdO6+F41ixmtD1a30M9f0vPUgMS3M2kpQNuiB9bZ?=
 =?iso-8859-1?Q?jp3U1/eaYNuHqcg22kHN8kHfgyd8OIMl7kchGLk0rTpi+0y3me9ACbZxI7?=
 =?iso-8859-1?Q?ljENnUBEQqojiAUaBW0STChh1m1fxgW0flJg+ZF7nXYRyJvovQ5TKOt2f8?=
 =?iso-8859-1?Q?4rfz470GR+oZlEIWHMwqvufY73vU1F3wTa9Ku2yAVemtkC0ORSWKyGbPpE?=
 =?iso-8859-1?Q?Br+J5aj2jckK1iWEt11YGimQTZ1qBWKrRbrvt+jY6Y43pxIPbV5xA+Pm8+?=
 =?iso-8859-1?Q?pFSwr4ZugfYZDUIJtXmCWbtQOoT893AzNQPuCpCeFzIF6KLorrgev/D2SJ?=
 =?iso-8859-1?Q?SKCyTl7RqNfkn9qShDvcTkbC/GaFrxPgYhBLTcCJy6801Qs2c6myzr1ENi?=
 =?iso-8859-1?Q?y7/YgUd7/E2sncA8UcVW438A+j8Ipe3oMDRZARAQC/DoNlfNZNgAy/4QoI?=
 =?iso-8859-1?Q?nyBAjT/14oRbv2QYEIcI+ch/CY+8c/2Wo9JDRjn/xaebG9Zakge+dVw4MD?=
 =?iso-8859-1?Q?mKFWVSr7Di4S2dIeP7OrIuaO8B8TJ6a4zyahCHEvIzs+B4il+I/UTDtC0R?=
 =?iso-8859-1?Q?ReMRs1YvbWmea+HHSw+9srWmoKaYmGVjJo29ViKpI=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 619ce797-9f29-4b23-f3a5-08dd9f91a6d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 15:50:07.4007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6024

The current example for Gmail suggests using app passwords for
send-email if user has multi-factor authentication set up for their
account. However, it does not clarify that the user cannot use their
normal password in case they do not have multi-factor authentication
enabled. Most likely the example was written in the days when Google
allowed using normal passwords without multi-factor authentication.

Clarify that regular passwords do not work for Gmail and app-passwords
are the only way for basic authentication. Also encourage users to use
OAuth2.0 as a more secure alternative.

While at it, also prefer using the word "mechanism" over "method" for
`OAUTHBEARER` and `XOAUTH2` since that is what official docs use.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 5d13a856a7..7bd09c254b 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -525,15 +525,18 @@ edit `~/.gitconfig` to specify your account settings:
 	smtpServerPort =3D 587
 ----
=20
+Gmail does not allow using your regular password for `git send-email`.
 If you have multi-factor authentication set up on your Gmail account, you =
can
 generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
=20
-You can also use OAuth2.0 authentication with Gmail. `OAUTHBEARER` and
-`XOAUTH2` are common methods used for this type of authentication. Gmail
-supports both of them. As an example, if you want to use `OAUTHBEARER`, ed=
it
-your `~/.gitconfig` file and add `smtpAuth =3D OAUTHBEARER` to your accoun=
t
-settings:
+Alternatively, instead of using an app-specific password, you can use
+OAuth2.0 authentication with Gmail. OAuth2.0 is more secure than
+app-specific passwords, and works regardless of whether you have multi-fac=
tor
+authentication set up. `OAUTHBEARER` and `XOAUTH2` are common mechanisms u=
sed
+for this type of authentication. Gmail supports both of them. As an exampl=
e,
+if you want to use `OAUTHBEARER`, edit your `~/.gitconfig` file and add
+`smtpAuth =3D OAUTHBEARER` to your account settings:
=20
 ----
 [sendemail]
@@ -544,7 +547,7 @@ settings:
 	smtpAuth =3D OAUTHBEARER
 ----
=20
-Alternatively, you can use a tool developed by Google known as
+Another alternative is using a tool developed by Google known as
 https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail[send=
gmail]
 to send emails using `git send-email`.
=20
@@ -552,7 +555,7 @@ Use Microsoft Outlook as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
 Therefore, OAuth2.0 authentication must be used for Outlook. Also, it only
-supports `XOAUTH2` authentication method.
+supports `XOAUTH2` authentication mechanism.
=20
 Edit `~/.gitconfig` to specify your account settings for Outlook and use i=
ts
 SMTP server with `git send-email`:
--=20
2.49.0.639.ge2dd5d9d81

