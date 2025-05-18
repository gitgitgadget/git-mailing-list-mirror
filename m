Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011028.outbound.protection.outlook.com [52.103.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC13D2FB
	for <git@vger.kernel.org>; Sun, 18 May 2025 07:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747553806; cv=fail; b=vDSxtYYGKqNtCRnqk26aB/M2aR1ZRPKF/G7CP9uklNRqQosTabttHtTdOk7bxaYYBrqzv+Wti3hD+kXzHnc/Rp8auhhjz9lEYc8mxeSamjVBxxXprk2HYj62aaM5+rj3RTRQipaT5zbBaQkpTOoaIGJHqqA4OpZLjVT2rjlsKHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747553806; c=relaxed/simple;
	bh=4osxrKODCtsmDWxSOZaMIpE4tMdpI8VYybZjcB1Ws9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GlTq9hX07WORc9rNUTtQhloqsR8sZlCGCiAt3eOvrUbXe1p4YU0uFoSrRbnJfeBeoRIIjloRuzUFLnbZhDexXiwnoX/0nwkm6QmYiq2hulSgluwpO0AU6GSj0VVeYwtBhQ4e1TKzuFrbyWYXTGyuWapGzBzLWJDmXYY+pFEJWtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XaUPBjv8; arc=fail smtp.client-ip=52.103.67.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XaUPBjv8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbTJjNRoKZVLiJoymxr8F6V1bL979huqcNZ/YbOv0YaI2oO/EdI1LNT0q3zk4zXEz3V/F1ShL6fMCJOc2BCN0fTPsBdtW+D075VQjxEswdY5vHwOyv2l0az9xR1QpS1AdfeXCijXI8m0fGSewPO339Tc/DQ+9DB57auSVqF+IwCtoJof2l6v2f9v//jFrj0mr5MG+dA9o7S800qYQBdKirvQBQKvH4UQohm4rUTvQm5f+jPiLffEPnxMBdqbZns5bLE6LfBiBQp4CptFqwSoXJJNccmc8lkwx2hjnTTBcmVu5d6FPj3cw5xWr3SVIkj9dCQt7dsSJr5PbSeflIv3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rj+dJCEFxVYKcVW82werJX1Hi5pqYezUQl5f6bOpZuc=;
 b=avrujx8hh0ELXaXX4dafv2e9BIiB6jIp4vJ476TkhjJxpyfwYH4a7hW4JazIQ8SzwM7zYl3UB9n5E2D6qKtpc39txCsF9FAJRDlWezRZfbDQOLqftANnqdUvZaBhku6VSavdx46E7fUQFvZUVi6dBuwRZ1IMYTjf2y1UN9+uNGYed84bYXXEQckt5+J9GPLkZWdcf6+jMirsiDCSPKbpVq4l25OzXQqE382G0Kk9EZ5NuxWn+vbr26EnCWCtBOIRwWiwpDhnsZSmGeRHagL18Cfoz1nUxsUqbRNFwMLfZILCyDtLSQ4NPRD+B6dx3+wnExMF8Pt/QvjXFTrjs9Ixeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rj+dJCEFxVYKcVW82werJX1Hi5pqYezUQl5f6bOpZuc=;
 b=XaUPBjv8zGoRVraagJ6MTcoPgW6K+T14aJLG0zqympU/fRK5+yy5lDb5TCgGK6K0/RViN5xL2xcbZM2dfsgxkmU5AvqnO7TImRKWxQu9RuvhPiP6PzdobrxM5MpJPlLVF+aZnYZmwrJGL/CcjGDcwvh4VOfpTvCvGs3W+24whQmVz5zAnrJy6WhiBlZHTVl3nbPCKp05rB/pi9FdYPqUBkVq/aJ4sDtGrIpjhM9gTppo8kvdKdV7UDrEwQwOwA9pk8+WtyHfTcUegGQgjNELogmAGrZld8+Wai/xMiziRP/PtULvohaTHuD3v9kc0+o98uzh33vuJWs2reaJUwsRCA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB6904.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Sun, 18 May
 2025 07:36:37 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8746.030; Sun, 18 May 2025
 07:36:37 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: [PATCH v3 3/3] docs: remove credential helper links for emails from
 gitcredentials
Thread-Topic: [PATCH v3 3/3] docs: remove credential helper links for emails
 from gitcredentials
Thread-Index: AQHbx8eWIeWyRjN8hUu4/kBMhHCl4Q==
Date: Sun, 18 May 2025 07:36:36 +0000
Message-ID: <2D9CF051-5135-40FB-9C15-6E9E1173C9EC@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597D6BAA98013269897A963B890A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
In-Reply-To: <6D57A8EA-FDE8-42C9-9541-7B97C2DDBCA1@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB6904:EE_
x-ms-office365-filtering-correlation-id: 81c2495f-76a4-4388-0258-08dd95deb8b6
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799009|8062599006|19110799006|15080799009|7092599006|461199028|3412199025|440099028|4302099013|34005399003|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?x/N8mUFqi7HNVqLaRgCLhzZUlkLsJVWbyCjVSlnNBEVpHzkDLvYdHqZJ7ew8?=
 =?us-ascii?Q?Bvq14YNhQcsbrXk728TD2hYVj93h0loVavOqrIZFM2UiqQGd2eBUBgZ8qtfx?=
 =?us-ascii?Q?8UnOCFbqN3pcR+KCXSJv0cGLW8oGrSo8gKUe4U9B8mZj1JlBX+qDUMzLcrWQ?=
 =?us-ascii?Q?qxuWLXypICjF9DJO4scQ2hSjB8GMkWM9Bs09MuGe7Ma5/Fo2TBv/RCfvk9oP?=
 =?us-ascii?Q?DH4PkGkC65JZivcer8UK0FAI0K+wZFSSRWx5qpL84WSMe6TREyfkQH6Mj7B8?=
 =?us-ascii?Q?2Gb3asVAUEO0UyzEuI1N7WVNiFPFIa0ZS+G5BxkSUEfL3c4eUpQvTCSdfT4v?=
 =?us-ascii?Q?DSkxQGf1EQmFjY7kn7DWMiWOZzKuoi2oXSf2czdIzos9Z2IpGict+VJiPiG1?=
 =?us-ascii?Q?hpwNi9CPboLzI30ySPXObDqUmvgar072KSd+AH80tFG//iA0v1U7IIw546db?=
 =?us-ascii?Q?8dH+a4CB7QTRd5wJ6OS7LHTdYoeGxvrGjP7o1ets2WdeuyrChTcY7o/t0ps7?=
 =?us-ascii?Q?TvshR0hOpq6uf28IFMYbBpQSeS4vZWytWNOxzV3qpnwEY5PMC5dr0LER3MB7?=
 =?us-ascii?Q?RyedQ5iM9cDdOliM22qtFGGkYEeNw7KMyjTf4WGNa0EnPZaLV23n8hoctYzM?=
 =?us-ascii?Q?WAj3bQ4LhiImw+kB3Y6bIKr/Ii4W3Y76MVbPKFqC4bD4pwwbYJ1MgXFJAkMK?=
 =?us-ascii?Q?DJXQg6p/9bF19ep5POHgcL1NINZkdo4C4s9QiWeZa3eoNdlJZ+teU7T/IX+5?=
 =?us-ascii?Q?eHrPGn9A4Prr2fSIlIlPfshZcRb9cNy4Z3e40daKQjSx53fbdz69+z21BTPd?=
 =?us-ascii?Q?3mYySgrvpO+8J5OkaE3Bp5/enFWubi4CjYTjm+JMst7lfhThmPnpVUfFsMfY?=
 =?us-ascii?Q?0FjW1janM1yYwcZ8H/+dA0v5j/h/4wexjzc22LD1P+awXDLKXvJtd8cRzqO/?=
 =?us-ascii?Q?iUSdkWK13ZFwFJCj9hBPSyFOM3doWQ+L4xmHdYXlEw/lqjxdAGwoQg/w8xY9?=
 =?us-ascii?Q?9aQkS/pLyTf0bSmDoXBPLaeGbt/WmPypjjOU/ngIrNCe5brcykcfNkHK9C2j?=
 =?us-ascii?Q?q//RNReCphDMm6lT9pi8W9Q5ppNPJH/vufIhAhb+CeGqcVLU2ZXg2Hrw5Ags?=
 =?us-ascii?Q?Zx2CW8QF8SB4sQMZp36CTXkB0R9ovFJr7enLtq9QctJbAAPg/xq5/ZT1WZTp?=
 =?us-ascii?Q?9X/YLoQ1rkbpCFb4esI9pSUtAiBNhVPo2LG9SZvpaWUdDU8yKzoYMzbUTC66?=
 =?us-ascii?Q?yb7vuvUE59MM2goAGiB4lomFf6pCkaAqjEKgGfgNag=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mHyM3rC1Kb4U4p1XsFXXAWn6kPir0sIRpstGnKOv8Q6HK36NAnB9Ob8Hmh4+?=
 =?us-ascii?Q?Wc5cnLxVkk16IPU7AovATKJ1YetmtSfqqU0aOu7YVX5Kq9Qjhj5LaBlCB6/1?=
 =?us-ascii?Q?aqxe3xnnNUr+1UvUUnux/2G3cImNHEAxDwAkiClX6YpWyHQWyakWRSgx439j?=
 =?us-ascii?Q?07Adri3DKpFLi01Dd8TAD4BPocw4uL2R20SXm5I5TSwYP2OXbaRFl6hPV3sQ?=
 =?us-ascii?Q?Oi0wP+3gk79HZSMdf66tuZ7siZHsoU1cA1A9f7G9qvOSmxs8PriTZKkUo1NZ?=
 =?us-ascii?Q?vchgo1iVAJKPWV1H7I3VdnPMLzP71LVzCY9YAHscZje5HUNKGpq6FswdGAMT?=
 =?us-ascii?Q?LYz90plKne6CjedL2ZsWKke08o7uSz4FsyDlkTO1u79pW28ZcDjGGNDtG10N?=
 =?us-ascii?Q?GCZvITeHxmgDmKT/YJ4M1LoHyt0xNuVWeJpEEMrQib8fd+Vsz/bEAKSKOlPe?=
 =?us-ascii?Q?Ibs4crJQS4WAxDiaFs9zVKWuvOnalyKnm7YOlhqUrfzB2JyWrjDFLlvF/JMB?=
 =?us-ascii?Q?v/UqTJ+Fo21u+0Iv54bboiG4+Fc/v8Ce7eLxU/cBZSMs7vCKrqrvJzva36LJ?=
 =?us-ascii?Q?VEaQNeOfJdWciGGlIMZNYDVsYOHvfcr/gYPhw2kPAL8zrlpSPZNQXcSv/lTl?=
 =?us-ascii?Q?h5Ys0VeE0SaiTyi4EmQshr1Tu7QQ5VlxaCwWAdKz9MqV1uOroQ74L6+1Ijd3?=
 =?us-ascii?Q?8t1FHlwr0qlUVTLgK57fAdEeDPRZczCHM9XeRx0T7Qwuks8svuIjhiLyrIKT?=
 =?us-ascii?Q?ism5yWUXB67jMkif27wG3jYt882kGGGRZUR8NriRFqXdY2nMP46oe8gw4rNg?=
 =?us-ascii?Q?wnCN9t3B3Zf87vPqLuuNoTGuJDRm2i9sCJhpIUsGpJUUZFPItUu6w5cmMr33?=
 =?us-ascii?Q?ZDLKSjwbgkogagd2nfXW3hQUfD0XyCnelgN5jZSvOabVGh6GgtiIDnFX4hFm?=
 =?us-ascii?Q?Wu+FRs3m+pcl89QkW1mkfKn6VeU7dMLJuCYHF7QZcF0DF3H6t6qrUzkJBVRZ?=
 =?us-ascii?Q?7DzG2btQ8kdo1z9VD0gxS3HllaW4X6aREEBCLxzjd+I4na8WeQqj3wZp7Jm/?=
 =?us-ascii?Q?2YrzXjOL13kC+rSfwcQnyTAPyBTxpS1Y6yg6tJ0P+X2Vzm6L9LVezQcjeKdL?=
 =?us-ascii?Q?mYvsyzzKO5DLbkmEtywfbs4jiAQOGPFntRFSYC4aS+o44bPq6QQtMGW8qmuS?=
 =?us-ascii?Q?IztUl9WPOF/HfLo/bEDthrtAfJGevjTeog5LFDzAz4dBi1bB7wE1X/4SS+EG?=
 =?us-ascii?Q?EuvPNY7IH4n1HYxuUqhw7tZ8vQlAeSwy+q/SL/LjsRIE1GoXrdFkz0QLZ7LZ?=
 =?us-ascii?Q?nAMCoo97QCoxHHm0rCL8SWPx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3F8FA11820F7C045B2E47289DE63C7EF@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81c2495f-76a4-4388-0258-08dd95deb8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2025 07:36:37.0081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6904

In a recent attempt to add links of email helpers to git-scm.com [1], I
came to a conclusion that the links in the gitcredentials page are meant
for people needing credential helpers for cloning, fetching and pushing
repositories to remote hosts, and not sending emails. gitcredentials
docs don't even talk about send emails, thus confirming this view.

So, lets remove these links from the gitcredentials page. The links are
still available in the git-send-email documentation, which is the right
place for them.

[1]: https://github.com/git/git-scm.com/pull/2005

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentia=
ls.adoc
index b49923db02..3337bb475d 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,10 +133,6 @@ Popular helpers with OAuth support include:
=20
     - https://github.com/hickford/git-credential-oauth[git-credential-oaut=
h] (cross platform, included in many Linux distributions)
=20
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-g=
mail] (cross platform, dedicated helper to authenticate Gmail accounts for =
linkgit:git-send-email[1])
-
-    - https://github.com/AdityaGarg8/git-credential-email[git-credential-o=
utlook] (cross platform, dedicated helper to authenticate Microsoft Outlook=
 accounts for linkgit:git-send-email[1])
-
 CREDENTIAL CONTEXTS
 -------------------
=20
--=20
2.49.0

