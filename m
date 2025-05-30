Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010010.outbound.protection.outlook.com [52.103.68.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E8D22A81D
	for <git@vger.kernel.org>; Fri, 30 May 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605044; cv=fail; b=QiqtNKyjxe4f68hdGb2C9jNKQ+ln4IDs8UDV2Q2KFroVz0MOlqOeLd61RjyTAdksbUyeSL5QKGdhhpXHWARnyEmV/U5pUHUWV98Ch4Q12xaBNS+SJkEu5Qc9Fgen2pKreFDKwQZfkgy+SaCRoXvjy1aS5238Gby7/yXj9tKJ6f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605044; c=relaxed/simple;
	bh=+EMZd5SbGsE42Osuc2WIN6OZIxVJPQ48qTgnkc7Viqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dd9uONRQAXdgTGHYLij8AhNd/jwGtEbfNiDo4olZYuHPer4qTH+FJah2S2Ne4w3fV9K6cfSFOlQleMApe51IsUaMNGwsfTmz1MN1Wx4mGFYKmhZDFwU+PzVtdE5f1E5fTaIMeLyhjQV44eiQyV78aAKUcz9os8+Q/jjRqxVQ8WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=NUbKASvc; arc=fail smtp.client-ip=52.103.68.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="NUbKASvc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NrLSSsr8V/XB1WN2LnfAvCYSvt8EVXZfhmnIL/kQJRGlNNebLwpR7bjciiGxdQa5gCFUYFyHZ0sIKyHsLVk898812Y1lImDmwU8wtGNx3fQPcymjcmtKvuScPEBzgTLCIIpfbWZDc0OribkHHU/Iq2/l3T5KdxATkGHazr3Cd8luTwyUOTk7D3oNDFSZfvf7nkiGAyybMPBRleJirbPGDKJKznsDPK3XsULfdIYpaF4KmUyMWJFTAUQ1EZzG6ME5jQBmrCemqK6M3PmX+fKUt8Bge0FwL3SSeckX2gOvvOgdTqAHyP2uDq8lMJXz8utrxUS5UEXbrYVcoNH0U717WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9Qzkr135tP1MW1zuBSKGfPzvtjvUEMeiqv1Yq21NA4=;
 b=k0HZ7sjFop3jacrrfrYquFBA/goc1Clh+ob4fpzsCE2T2aSHnbjcGHInrnjniLQGeUD0xy2s4JhXaRwfFA5lhcUniUsiI+nhMLVBQUe3k/Hz6O/lccO+816cbIIwbLAO8LLwdmnAm6G4K7XL6B7rHuGg3hcHB3MEVq0S63TdHgTzRTBRbEUM7D1DAyuyvwbhW/pmvN7nAhI8vo1pamLDXHTymVwb5KeOqyD9zePEGsagmVkdIddaFyABh/adgb49snZdZUgWPU5wnJUAFld+Oc99StCA0mUA7hu+qEVsrRXnQo45NJS7+IjDDpLRYK+ZlRB2NKaOarGeE56R3Bq+bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9Qzkr135tP1MW1zuBSKGfPzvtjvUEMeiqv1Yq21NA4=;
 b=NUbKASvchsKY9rCXncZTI6hHvmqV0XrIKVvVbA0UQvf8e0zzAvHKb6IT/5+PckIHx0zCRIGvfWESafAjr4Pqa75W/ZQBgALcadE/OCR6ug2G4FflzgV0fq+L+R5qyZzcdxi7/J01wh5SK2KWSEhQYrdslzYwOVipoTidZ0MOPaszgXDPPgCjyjRPdbRAlWWvTJxCbHZt4cAbpvVO7zQpPvcGti+NWHl0fKl9aacgddS0kTNPUJkPlj4fP5zJOBUL59AfRlxehF1oi092pOc8topjINMNU7W/cOgGobY82EyHMDC0aliC/miHQd0/RN+MCw+EvKw+eJQlGYJj14KFHQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 11:37:14 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 11:37:14 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v6 4/4] docs: make the purpose of using app password for Gmail
 more clear in send-email
Thread-Topic: [PATCH v6 4/4] docs: make the purpose of using app password for
 Gmail more clear in send-email
Thread-Index: AQHb0VcwUfbJQI76pE+sTHZS6QGfsg==
Date: Fri, 30 May 2025 11:37:14 +0000
Message-ID: <20250530113627.8639-5-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250530113627.8639-1-gargaditya08@live.com>
In-Reply-To: <20250530113627.8639-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNZPR01MB4415:EE_
x-ms-office365-filtering-correlation-id: 46516da7-3608-42c9-fb06-08dd9f6e52d2
x-ms-exchange-slblob-mailprops:
 P1EfU6pZOd+Ewy2R3Pu64sHUJuYJdjG840eMljYuaWGkQSlzYmUO+fwhl0Y5VWNG8fh/npTyE8jvxkhk0gNG09K+QfIX35R0V+4aEnj5i1Du0bkhO6hUjWom1+qrPksp0wmTf1rT7uofe/IA2X4lVPiOyIbX/+r5VViGXUsW8wLHjYOH0W57sTbxzaJxdDY98+6e420dQvJrU346vqNims8qGwcr7bLf++5NPikZm19JBjrDBMRTgT3wGF9ryFKQmDw82HTAKuKP2xbWqh/ZMM+LX1x/pSftOraDPb8oaUeyDwRmY/M9J7pnRtXyvbRVLWoKx+GxR/ZKBgcsObxqUsm1HXp+BeXE8QbgoPaq0JGT7yM7fb0bcGPPOz9SyDXtg2iyJIXlgMF1xC84Opwgqz68X6KH3dTlnYQ6uG0KXkdelZmCfjeDQzdmA/XxdTa6Rhq7ipg0+gQWlPYRe3Y5yAyBgB3cpNnQFZdLIqfafYC6sYaZgD0mWg1jmgikF9UR93cU0JIpIBgMsDHn1ysKPRpzTQiPm4xs8DReEx8krbqPAhHjkFGVSY+k6a13RqxV3gkMzk1jsNP1RBTdBApFojaz2dIy8je6DoixY36NMOxaIflVz4IFVxK4RCprkrYb5RQrmBAXiMSQ84pNURssSqGR0mZ8LN+DjlgrAorv8alyu4UF1J8X1qTMZAaM1Sud6oOVhWJ9bff1Bv1X4gB1AFYzj1605ETfZVPtRyt4H0vczz2qOa2ASxAY0nYGzyCyt1iOtAHNEBA+6M3Vh5/sdCT6pgNhX1JQ1N8MkF1fAqCJXCtb0NL5XQ==
x-microsoft-antispam:
 BCL:0;ARA:14566002|7092599006|8060799009|461199028|38102599003|19110799006|8062599006|21061999006|15080799009|12121999007|19061999003|3412199025|440099028|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?GfB+NU7CSFNVTUVYn2NVBCfMM52c9TNPNg2i6zqA0uokYuDTOGY8fMh/eP?=
 =?iso-8859-1?Q?XOivCTv5sdrAK/PU7Dr9CqArnTY+8QXcJ3gO5jwnzuIYFwiaiUk8MdBuT/?=
 =?iso-8859-1?Q?KuhAUI/tH69fOIX/mYzngy9X7Nk4JIfKP2dil/YHcObZM78m/RJbmrSTWd?=
 =?iso-8859-1?Q?5/EH2UY8P2dpVllmkUARc8onWSCw0RMiBUXRNTkNWcz4xOKOLhxO0Z1naR?=
 =?iso-8859-1?Q?Z2uEBgtwv5I9grFRWZOS5rGClCVevhj9hbHsJxebr9lmzA+8J8jRjmoj/7?=
 =?iso-8859-1?Q?tmg3BsUiDmIeA6lTejg0jTwrmYCiH1w6fkBufcOett5sTXe3lMKjLMtrbv?=
 =?iso-8859-1?Q?YAa8cTU9PLbCtVNWblKQqnIF9wjvytl5fiz5/MAK1tZPglNcDGhvNCKpg+?=
 =?iso-8859-1?Q?/hojnMS9q+dI4/WL6pTdikOIR+ogB3jR8pW1OVl7+hgd5jqCoZ+P25OcXq?=
 =?iso-8859-1?Q?JGTn/LKnBTaBjbfVr/Ub5xsVqCpPTMiW/BjqKdrvLIxHKb9nwmTVDqur+1?=
 =?iso-8859-1?Q?ME3tnzNNM+vH6Nx7TKTzFV7FkDGziicbgdneW5duqQX9Y2zqhu1edpCjv+?=
 =?iso-8859-1?Q?UM8Z26g78Cvtt3XnVg11mNxsESBypSheDxfSNhjWi8f5VZolYiU8h/2dhK?=
 =?iso-8859-1?Q?Dbr7lRCYyIC72Q/MOPHNsUN8OYyO7JxehVgQwi/IzLkGc+163M6XizqpkT?=
 =?iso-8859-1?Q?U1yvk1otneuuj1WKf/Yx5DwKPozjVlBmPsj/qTEHXpo5XaMGnLwDQXrtd+?=
 =?iso-8859-1?Q?BwYqHSqErf6jJ0v+Gwqx+B8Gt8l7naEwXvB9EBHkL99RKfUHCmcpZNRR27?=
 =?iso-8859-1?Q?jq61H3qWe5lcKBG0SpdpjxtVjDaroDkgy6NCeFSeygWjmeZo+74Ip6fEgk?=
 =?iso-8859-1?Q?DbE0y6uacEgtzF/2H+RphuZfFXqWNw69HjgR95qPvUeJCwqBuuSq87HLDV?=
 =?iso-8859-1?Q?6Hcd/b/ruX0SCJbGUhFaCt0j7SDoQb254bIzsJAvO2Tlys+z5hXXaepYeJ?=
 =?iso-8859-1?Q?IBuWhf7NRNBgicNYLIBv5KCnpUvD9RbkTsMbCauIk5uXK2n8qNOgKJlT/N?=
 =?iso-8859-1?Q?iRoli6Hau+rafIl5Ezr8Un9GaiYd/hUhbJ8NJDYY4GJUBv2nDm7XJoLJt+?=
 =?iso-8859-1?Q?Ok8nLRNwbl/ifISU4dIYTKagYRe2ncspVzB8geNMlWDBxwgh3+mT12QFMq?=
 =?iso-8859-1?Q?q4sWs3AOLF9OHMUP5c6MSd+Ff34kzh+GrT4AP8qar4nmMoUiVETU66BYPz?=
 =?iso-8859-1?Q?9YrBRH+wEQveGiyH72+ekKb/3v6L3RLzgstrXAnM3J8R+wevJNngnTydje?=
 =?iso-8859-1?Q?WiUKWhHe57Y6E1zeYr/uZG0jKcEhNZnXtPVdPRj18msAGKA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?lxXdHHVOf7F7Vl3nAsnY4TN9I/l6p6RnG4hfMaU8N3KLfYk+GfBGUPjh+x?=
 =?iso-8859-1?Q?+N6fJ759z9yO9Dt3bn4IM2O26J86Ej10cryY3W9RWo+tuqSDJTWIBxp/oU?=
 =?iso-8859-1?Q?P0Oeghhdz9xXgdlAzKE99l9lTcTz8AjHQfGZYj47eIu0/bVy4UAW7cVpTt?=
 =?iso-8859-1?Q?7UyClYLwXJpphFkjmS941mDYTEVG8k69HyUe7eAnlyj7/1LfBzk0t0U7vx?=
 =?iso-8859-1?Q?vm34B0efHjEGusSWQ4mkY9Rcb+qdppcbjzMXoaXSct0oWteszHkAalgZeT?=
 =?iso-8859-1?Q?XnduVzD7wyaTQPn+xmLTZsY9pF2hZTY8BuLiAJRtQktp2ycfZRgLN138FR?=
 =?iso-8859-1?Q?ZCX5bh4RafBjEFsrobKA3mMDIgIPhjCG4GDOTuN0Cf6iDHVbO6sNBeVsI9?=
 =?iso-8859-1?Q?/Kl/0eE6nK8cnOdqY0bx6KlKuqz4YOtc/hOPJy566+f2YH4U1TvbAVcwJH?=
 =?iso-8859-1?Q?jNLrxNCA1LG+q26f7UhqX1vYvmMYpgc2Xqar4W63wZTOIEiB724bt4K2LY?=
 =?iso-8859-1?Q?Zg8pDedkKWKPu+pASt4ESa8p5+P0aRS6HWzneKrzgMGK9z2UtWgJpAehqX?=
 =?iso-8859-1?Q?qIvQ/HvdvTXmHa9S7RKbjpBQU7BECJvA7cKLR3hVPShtispIWKL0GBx77z?=
 =?iso-8859-1?Q?lrAEUgFgn5xVlWYxqjZv5fIhQ7N7omylQKxu3AZzR0CkGz31+482JJ81UB?=
 =?iso-8859-1?Q?bdaLVgUOsDl6+to8yF7i97oDO+GZQdI8wYpALmUe8plunveFVHIT1LuxKD?=
 =?iso-8859-1?Q?hRX695u1o8JZsCtNZLrTizc6dhFPjYfnlc0A7fRx5QtiTU3uJ0bGc7/Nu/?=
 =?iso-8859-1?Q?s9hfeUn3mGChSb8BVH7Opb+WaCPev0oTp7TcT76tn/rHxEvG3ladsoePMQ?=
 =?iso-8859-1?Q?CzzRdvGzvj5smJOEU30DAvAM6BipThsyk15WlKiyRkSTEdfqBSDwSUQfKL?=
 =?iso-8859-1?Q?q3/UpuE6Fh/BCB9+OfTSwmWNwldgcU5OOh/nrJFwlwmoujc0peW/VEjQOn?=
 =?iso-8859-1?Q?w4gw9FYlzlpfgQPAmbiuvSzKGV/dT6f3Ow0Cd+rj2dMbfaCU6c3AzMpFh7?=
 =?iso-8859-1?Q?h2bhFr4YFpy9ORknbquEYbOYHbW2qIUMBvf8tXK/zjoPpsqbu7/HNhds8B?=
 =?iso-8859-1?Q?o7xFTGWULtDGcT4IV7Iap4A6oJFTg4PxyBXvnehy0EiDYILJah4+G+SST1?=
 =?iso-8859-1?Q?Erx7slbUwNRX8zlLUyGizbcZmH3EhWE4AlgWSs8sS8VSMuWnffo+bcgZWE?=
 =?iso-8859-1?Q?lZ5PjTkV2JmZ3vz1sZhjEgXe2WghCZZtaAydIQ39A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 46516da7-3608-42c9-fb06-08dd9f6e52d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 11:37:14.0696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4415

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
index 04e1c459b4..9c008dabe3 100644
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
2.49.0.638.g03d7d6a772

