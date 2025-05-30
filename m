Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011029.outbound.protection.outlook.com [52.103.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9381198845
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620211; cv=fail; b=egevipqez6Uq98W+vmiv4gj/ka55er3sbbdot4YpK/nUUw3id85NdGrxv35ZGy70xfAUITlyXjUlpq5pnnFET7foXoJi4I77igWkgAptLP7viRnjB5nfLyfzuIlE0lk4HlGUNzVX9xPXrCTKGaYMyMPoUcmlrGmtIJe8kYfkOSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620211; c=relaxed/simple;
	bh=BBxsMQNMLHaA6kCGOaPmfXEBe7b33yWcyKhbE9IT2pE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h2RjY6a+exZpEiLmAQrORqzBAYvP5T2LbruS9PKIp9ueaX8U5Eg5Z6q5mv553GfsXRVlNhkISMoCh4yFh2L6EsjMk2puMW9tr24RJC16ubhhcitL93GsxxlX4HITpDvtR5ZTn2OMaAR/dPMsRU/2ZNm1juY09OjV8B0nZ4+nMjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bOiqi5wh; arc=fail smtp.client-ip=52.103.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bOiqi5wh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VBqp5KGqKpXV+OABBE4dIl7mvlwPkeNEJGz7JGAc4tWejFT/qKgbyIOix8MfpDDpr4SzPpPg1GGhHI+CdoJMsUl+RNx1fflA25UAcgLDczq9Rmclk2emQWVWSAkFUQVRmz5GKY8FwaKiS4Jy07Umt2pzW3kej8PZmehP/IU5sxbU47Az1XH29JfX8x9IPQ6M5CNHepJLL2CBy5VjwQwlJnA+SNOqgtzkDWtI5+N9drme35wN/axPFnrY6S7R2H33VxLqSA73xee3NGIE7pKJ0VCpoHJgo7kQOEfrUki8E5tXEQo1kImSoE5GereikIdO2S3R+ssQ7m/pv5ox6Miktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhxeKvWr2PJvhHoNahPGp5SNUswFvA9yoQqzwb0dV0w=;
 b=mDRzXeiAgp5MWQJedbIONmk14oCqtfLKJoIpfj/ESYt9/DYjxX7LUp1i2s2E/48Rd7ezxvhbyl0Yyb0Fm+cZSXDb2gPQ6jNoeckcwAsfK6qBu66nAjlB/gtV97jlMKOEJ2RccOU7SNJ6K47771QVES62l9DSh4vePCGfp3512fZcRRPdpOHkLdSDtYU9r9Zqp9jil5O8Cv4HUyFThajp1cRi/wGXkGyIjKYNI3VXt1kImTTTMLVtNma2ftpTpGf0gIiRBDu2Clfb4TA1o7LaiBRBBVpFddQOzr/WQ7crJsdsLrmZa8uSCShIGvhUA/i+199bIMSQpL/NV1muHx9HEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhxeKvWr2PJvhHoNahPGp5SNUswFvA9yoQqzwb0dV0w=;
 b=bOiqi5whh5eC+wYPFEC6OTTLPCe7+BTrk7rMEy9tvRI8eEjlVcVc7oE1+PAjUOztP8DpScW3s3q3++WDsh7iw7Ud8GqayF9gd/GfiHHkVmp+ultMD0NnvMXIKaz/ZkZJPrv7jaF+Q+dqmBADac1C0UWQUsgATNUC1/duGw5XqKw3tgwyjBHUjtDY4mMp9YzOwormDczyjyimdxZHuX4V89xdI0HL9hgbWLIF2zddtCqpEtoZAG46T2H0ihOatxtUzO7ZlPVVmri8y+kVODW+oS6wkwYO1UWEM7OOmiEggTeAKe1xJhFTnzdJZWymw4z4sKy/NkEAMEkUEa9mHnmfBQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:7b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.32; Fri, 30 May
 2025 15:50:02 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 15:50:02 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>, Ben Knoble <ben.knoble@gmail.com>
Subject: [PATCH v7 1/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Topic: [PATCH v7 1/4] docs: add credential helper for yahoo and link
 Google's sendgmail tool
Thread-Index: AQHb0XqBCFNOgDoFN0aLwX3jqGxTYg==
Date: Fri, 30 May 2025 15:50:02 +0000
Message-ID: <20250530154934.10077-2-gargaditya08@live.com>
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
x-ms-office365-filtering-correlation-id: 07b850f8-101e-4abf-3a16-08dd9f91a400
x-ms-exchange-slblob-mailprops:
 02NmSoc12DcHu/Dr1OK6cqcYKvfIm6M5ssuS2g8SdpNwjNiB7hNnliMapY2lobLXwBBUFJRX+I0+C6qZMhNemA4o7qIWzeN208TBPX5xtXLK4pfCYpztHoHFscuQst3xJA8iQ37I8kxvpgH5F2IfLuKSxv34XL2C0teH6WSzfDE+tnXtasFPaUiy9puswBA/aWHlhLclqtKJqvW5epZHfSLU5R8fzBDcf72gaKMAGttKv8K1lFHzFNxw2fxP1nPDMY7b8HYphxDpv/toDYzRaBbUxD8wZRcnmEAHTOY9Vm8s5m0FFA5Bc3LVKiBEI5rbzWj45hoOlJEv3kpu20osElxLeuQTYzN1WcEIPsceg2ooY9amNxlBZ2vtLzt2JzNEw3FrcwwgdsoJbo+bC8wv4B9xmehT2QtgX9hmS+3GrKf2syHtSUgZjLkugxgpbVI4s7JDnhk5xqOsLzv5fyk1kanr12WfzqHP91oyGWTNoMqdQ1BNYMgPIsaRq9ePYE3Q/iiFw5sEugaTvRnNM/8Me6oHZlp52p+cGcaL9Ccn1wQIwghMfmxbpEXTr1QGW5wRZKrTDKFX6R2gOcRwwwvbwvyhoP3cccjgXA/CFzxRGchOR95pDAKp/Q7/J7lkOqzsmvoTbulL2PknaeRbzYLnnUWwn93POjDLuHORLFFQUvsAiwaTJWoWyL0Ba/vvCCkSSgIyCiEudLkuAQhYoHuVCSHQKuOvsGIh9iJ435bzWMx8IVQthiEYIBI6dATeQf7o
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|19110799006|8060799009|8062599006|15080799009|3412199025|440099028|102099032|10035399007|19111999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?D8ro17eLsjeYJhp3xtRwpcrK+TCmKHmXzE10pxBogbkJL/OIdT3J436wsH?=
 =?iso-8859-1?Q?m7XBOvhwklZw3IUImeZs4tPfC4CD70lVwU2h0YXiLX5eMiDEpBCrKHIi7b?=
 =?iso-8859-1?Q?o7qcRgT0PYmtlOQJGwplbBnZ8jLxc4j3vXrgwAMu+MmYi1lZV5NPD0VeXc?=
 =?iso-8859-1?Q?7yKYQDw7W8+Oean2sEUwDWhmDHzdNsQCkuJX1jrkz+GaOfL3agI8e+hi2W?=
 =?iso-8859-1?Q?9l6h6snsuczesPX6Je+V88X+OCnJMjDlfYDk+mOvohuCazgOXiAl7lwApL?=
 =?iso-8859-1?Q?zt6CuzgCWd9VqSAg1yuaeexkdTWG887qWyo48Zf/Cmzo2c5bw/J05zS6za?=
 =?iso-8859-1?Q?7wLIP2zM7vcnFJ7ycw5TeHs1jC41bpfEiH3UzkS30WmYDk2I5tmrhNDqY6?=
 =?iso-8859-1?Q?Rvw04Hk/X/ibevW5EWw0lU4XNmDDSn+Ab6W+h47y9fnFiX/UsDfQijKLHP?=
 =?iso-8859-1?Q?qjQRdoDDmSqtlTT785OokLxTjjlNHM780y1ApsPQ+/59WiKDSv78Z8MfHQ?=
 =?iso-8859-1?Q?EktSjoYXuyut05d/RQdO1xP7N/Q4oVCi76kZRM4ceXef3qMf+0Q1Ct/Itw?=
 =?iso-8859-1?Q?a0e5wx+IUbKLyC5ZNDARhyeezJBBwJsX0rd3hM9nxG3pb9zvZZBNaK0bdt?=
 =?iso-8859-1?Q?U3v8Tf/hYqcWX4VPsQInkDQGa1+zj6xPiIkFRLXVGgGKdt5t6ZDJpGon6z?=
 =?iso-8859-1?Q?AwFYGBVeoGvKLKPzK/epk2tbCBOQDhSwMbj+Bm1ylkZ2vVz2+NxngFESRU?=
 =?iso-8859-1?Q?w4Gmjs91itPudwY2RcUaQXLZ9QRjx9g4GHkKkfyOYdQkLluBW4e0d6/eNv?=
 =?iso-8859-1?Q?gfseqe10muI1YClH7lGBYDQhtr7oRVZRLteWZtwxzBNTw3YprqLcJtt9zE?=
 =?iso-8859-1?Q?fT75v3tAZzevPHp0F8RAOEZXB+nZGP1HohkhdfOz76LM8t/VUHeJOF5hSo?=
 =?iso-8859-1?Q?PH7lfnhdHNVH7k3fFbvzBUXK+F7VWyS8PxL6HUrl0g2WNGwWDwuJj8ER2m?=
 =?iso-8859-1?Q?ibqyvvcRbN4Qoa92tbI1eqEnJQljuoYqR/Um5SozSxOpHziOJwKClGwsHJ?=
 =?iso-8859-1?Q?cM6C8jhDFeWEPIViERMlk3ATipe6E//uWzwjrt7fd2sFOipJeGCbir6fUO?=
 =?iso-8859-1?Q?a4rRGN/1wgttaIlz7kynvEmoHVpb7qVoD+eJA8EsYuVoi3e7/wWdMTfm6s?=
 =?iso-8859-1?Q?H0pNP7nDxk51tnY7eU+5Q/EJgrkVfLVk2dUcHQ48vxtNP0Jg1Ayt4sTywB?=
 =?iso-8859-1?Q?TL6WvXQsimH/+t98VeyPw8mpZuSpo/BCjhcVFdp/o=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bMC27nP1Xm6VOiXyo1Pw3gKu5nfQqn37vuF14DrW0CGmKBGrOtVuFkh55X?=
 =?iso-8859-1?Q?FlxXsjD6vyvJlNpBmZlWJa8BfcgUCrRvwSCK3TTV4BXsHBCcBY9PNwjUYU?=
 =?iso-8859-1?Q?4a8Th5KNT4wZ6t1PK5+QRcwf8WO+x42USfYZfxR6ichEXUR0m/ylhGfd67?=
 =?iso-8859-1?Q?4Ygb9khOZzeqUPE7B0tnkYqLJi3Yzgn5ByReSrcYxVEGS6AjGu6J/v3tFg?=
 =?iso-8859-1?Q?s8hg+TcVrNprVOquRUWzdGoDyb2daplQ9CY1ydHL1Rthv2l3MBCstunp7F?=
 =?iso-8859-1?Q?5GiBUkhKEjZUKHoW49u8Udwtemif3Xco9b0j8k7G+k1OXeqKeI19wvWT9b?=
 =?iso-8859-1?Q?FFNk3u2oh65E7t8kdJzmji+2Af3P2mmyM3vQTCOnsDOLvjvvfdyboojUuD?=
 =?iso-8859-1?Q?O/qSbJgXhrbS+2lXvwFXdM+JtcLce2T/P2c3D3OIZKQ/k2TUtdlKZiX0md?=
 =?iso-8859-1?Q?AoBK2XqXzjEI2vvwO7QLw6DRsV2fgOvnVC0rpTPHjzXeBHHAJ59/huHmsO?=
 =?iso-8859-1?Q?GbyKQ3qQbs+8DRje3RwpVLuXWAJM+IlvYzN70mjlZdHJJEfMUTWsEZVg+9?=
 =?iso-8859-1?Q?Kzwqweep8+79rndzOft7vmzK2NfU3fc1ibS0Qz/Wfy0n6t4h2IwnjXL/37?=
 =?iso-8859-1?Q?EvVruCcCgRmInah2/BFj5MSvbvRGgkDjE6FO0KqOY7afYRzrWEpLnotRoa?=
 =?iso-8859-1?Q?Do4k/8m1NNwtXxyPt6JNpLw743gZErIQvaZ2tnmsF7G1KLWOyXhj4yt3iA?=
 =?iso-8859-1?Q?npm39xIZLWXsQA1wQugBJXQymjJZVRDCGNFQYEtdtiZxojxPKyDHI9H2bE?=
 =?iso-8859-1?Q?qpPRRCPdTrkJvHoaDbeK/y06DSxvOxwH2Zewqw/Pzh6u1GSHLVNfieeWC+?=
 =?iso-8859-1?Q?AZktTEtByKVIrMrO9HqxtIkRsOjiKbxHDjLMive2dGiV9MSkQynVoUbAJz?=
 =?iso-8859-1?Q?Jx4WQDZzIv36/r1FNM4ZH0WBBRzhtaZwz+u1WW17TjYxquum5LrDUMFzPe?=
 =?iso-8859-1?Q?QYctjtQnve+GBO/DDbs+UpTfPJBtKf9wK0kfQWn6KUwrXxr3jJM+GhT+8V?=
 =?iso-8859-1?Q?OEwH04ou+LV9XE9HoQEpQelbnVJuad0+av7A4Sc2gtv2VIpnm/RZaw7zFb?=
 =?iso-8859-1?Q?tC/pCc9LuVqq2aVi5+SHczKMApF0z7ZS6tTzTifM69IuM2ta9d5GsFRCTE?=
 =?iso-8859-1?Q?g+4oeo4eU/8lJl1g0trp2HwqPaD//O/cOSpZAiSXywXDQ99ZjYQlpH34MX?=
 =?iso-8859-1?Q?a94qa1mFxdcTM7NioZ3fRtQGF5r1/MsBwN5X/nIdA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b850f8-101e-4abf-3a16-08dd9f91a400
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2025 15:50:02.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6024

This commit links `git-credential-yahoo` as a credential helper for
Yahoo accounts. Also, Google's `sendgmail` tool has been linked as an
alternative method for sending emails through Gmail.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-ema=
il.adoc
index 26fda63c2f..81f8cbc6f3 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -543,6 +543,10 @@ settings:
 	smtpAuth =3D OAUTHBEARER
 ----
=20
+Alternatively, you can use a tool developed by Google known as
+https://github.com/google/gmail-oauth2-tools/tree/master/go/sendgmail[send=
gmail]
+to send emails using `git send-email`.
+
 Use Microsoft Outlook as the SMTP Server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Unlike Gmail, Microsoft Outlook no longer supports app-specific passwords.
@@ -579,8 +583,7 @@ next time.
=20
 If you are using OAuth2.0 authentication, you need to use an access token =
in
 place of a password when prompted. Various OAuth2.0 token generators are
-available online. Community maintained credential helpers for Gmail and Ou=
tlook
-are also available:
+available online. Community maintained credential helpers are also availab=
le:
=20
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-gmai=
l]
 	  (cross platform, dedicated helper for authenticating Gmail accounts)
@@ -588,6 +591,9 @@ are also available:
 	- https://github.com/AdityaGarg8/git-credential-email[git-credential-outl=
ook]
 	  (cross platform, dedicated helper for authenticating Microsoft Outlook =
accounts)
=20
+	- https://github.com/AdityaGarg8/git-credential-email[git-credential-yaho=
o]
+	  (cross platform, dedicated helper for authenticating Yahoo accounts)
+
 You can also see linkgit:gitcredentials[7] for more OAuth based authentica=
tion
 helpers.
=20
--=20
2.49.0.639.ge2dd5d9d81

