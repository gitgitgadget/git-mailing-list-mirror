Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41363242D7E
	for <git@vger.kernel.org>; Wed, 28 May 2025 07:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748415935; cv=fail; b=g4J3TI3+7AVVIEzVcbcHP0kVDcerY0i1TuJbZCIX+Qaxv3HInGOzaVBHbyeawyDB87SNdvGLzXf5T41zd1XOlzMrhODQOD8VUZEJRIGbY3O399h1uQK/Rec3r5HdZc6bgLLaP4pW+79y3I51F6VxO1RRdyDdJorXI8pF9JuPoUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748415935; c=relaxed/simple;
	bh=7GA6lmug0pPPdep18/O/gcFg1kpqt7PadSxvPJjWXVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKk51jXGrijZD2w140qEpffO5bPPvAhHWyBZNBKEXC6YIselwroINcagYNh4tnK0EfWdsVGN26KFOcghMzOYIFgn50iuYOgd/mZe5kr1EM2ZKuF+7vG650Q5pPHKENW5pE3IcEcB3vkOBcAH5n5gVLCF7ilmK89amtBSDqA2LbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=r/iwTV7y; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="r/iwTV7y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIxFk1MGKaGG2fX6tpnhZbT5jDW0BQ2y/4WKap53hX6IkmAQsra40yuRmf7vwEuM8IfvAZ7mo64rY8mekc1NGSGXwDniDPvPHsWAYrnaKWhoSYvE1pIyH6X6MvNoaJYBpAksrQ72gJ1gTnrGkcjC0S0UwKlYKmNTElYso/E7vMiZ2QQIzCEGv9QSNmxeoACVG3qwJRf2n2Jp6OOh2PZD9qsZh41C5I0KT0uzM4aGj3VOQ4dZ2qbolVDqv+Nip5NgHE4GC66CxV3fGlew+rSvFW8TRHUj6Wzggd7V50Ww6QLDOFYBV3ygey+yqCVH9qPS7VEaceYRFF8KxgGxkGYIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k/QG1gljLKx05nvPvilZbuQB6ZDtPbTJ1ZBaJWVbVws=;
 b=iLjTGBbLzXjExMmfnnhNps3KidYsS69hNYF/xpdarUTTcB2yJ621OhF26fGdHH9ufz/KwpLkBv7J51buFJOqeCxRRX2ISUi+LRb4skNLwz8FINkIi3mRzQXWMOLT/UTJAXGmY6AEgKXsWoxyBYasIjP+9Bz2wkgw7cm2o7Jlk1rSpxp56eX4QRQK5ITr1PYYCSuZOEU8WtwPlWkjiuekmsiz7o09gWEDuLRAiU5ccCU8mM0vv+kKmvEGMYGDjUGpYVLXBVp/5/fmNu18HBy453P0Y14o8bH5GHXxIdzElAGX6pxdZ3X1VwfzwNSHCtp7e1DupqOBEmuqK63LoE6L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k/QG1gljLKx05nvPvilZbuQB6ZDtPbTJ1ZBaJWVbVws=;
 b=r/iwTV7yxiTTbPK9Yv0mtd/wOfFRYpc8XPKkLbTqv4pv1LM56WgcAdQQ1wV9KfswcJua/dteAGHxAJrkBXvA6NWaBakK9lPzLEVJFEJOEWeVQUtNqYjRnImG7sFl5w2MmEDi5x/ux0g86vxDxqct2/lsEoRQF2NDfuyGvHXwzDMBhhrYpEtBNbvnJQkLTw41nk0MKPloeDsJCd1q/ZFgpQ4wVnwR3HeKUylkaTWZOamKY1qSzIInFKtBmXGh7ToDvRKne8CCsTp17sZviGeIgN46OTmZ/CJZ4RulvwzAqezDyY+cXkiD9QGXdAvxG6Wfe7W1uygnQri5TPkNVpKN8A==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PNXPR01MB7259.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 07:05:27 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:05:27 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Julian Swagemakers <julian@swagemakers.org>, Eric Sunshine
	<sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, "sandals@crustytoothpaste.net"
	<sandals@crustytoothpaste.net>, Johannes Schindelin
	<johannes.schindelin@gmx.de>
Subject: [PATCH v5 0/4] docs: update email credential helpers and improve
 formatting
Thread-Topic: [PATCH v5 0/4] docs: update email credential helpers and improve
 formatting
Thread-Index: AQHbz57kMiKAFdz4K0ycqfe5uXBUrA==
Date: Wed, 28 May 2025 07:05:27 +0000
Message-ID: <20250528070521.17379-1-gargaditya08@live.com>
References:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To:
 <PN3PR01MB95971131BD3CD89771F19E5DB896A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PNXPR01MB7259:EE_
x-ms-office365-filtering-correlation-id: df9af216-fef6-4f9a-4615-08dd9db606ad
x-ms-exchange-slblob-mailprops:
 ZILSnhm0P3mDoogZiIYtj6aHx7ik50F0NGet90XIPXY7t7iyjAdPttYsyYX6fS1XCZT8WSvtDp/X5/W2zCMh9TNBxcnWFrz0G0MHpuG5AiG67WzqpcIqj7SPjswBpTxHmTwjR6vWbxQB6a8y8bOaPbQvSCKPSu8JmrYAVGFUfCdZkv/zU8VU/O0lxyGtRa9wAm7jUd9Jfy37oiOosRSvNQ6YSg8fPf26G8xYXQDFB+4gEwoKOH85GCPLsRVvpv2k0fIYpIuIhAYYFY3sq8JQrDL/qLYhNEG/GUBnPE7BO1+Bq8t/L3lkFg2bBDVbbKaJuoe67T5n2TRe2DLPU83PQopKZDG0+3iVraZS96l1OQ9cgVJRnsunpr5Le3e/MRJ90FflwUY5+dm5O5jR6sYMsanViXyR6XPF9MQ1X7AqHusXCTcaY1uhMPc+1kcIcwt+6KW7wJYvFByHo47L7hkB1L3QEbvPvfaSyoLrtuUvGea4mb+IFItokSohwihhaOt/ucMOayDYmwVNfQBfEnx37n1iKKRYAJHEV7A2zP7Q2OeisSBk+BKrTjATs24ArEs0lhz3wiGks3Kk3eG8linFIB6VPee2/tErttZD/m1hhaaPlh1BJmK87LALYPoKC4gTk2GbkYz/l//MOCYZbmfUdnvZskNNvfHc/diQ9frdZF76iekJ1uCmLx26N+X5HPBLdkf6aGbp+UBm72E/wz0sboqJSyt93i7jbCBkwz3t8cZFywUNgKzzmzUsVDFZQlRYj8Nj2H4FvThvhk2krwFp9J1QB2JTQ+eS
x-microsoft-antispam:
 BCL:0;ARA:14566002|41001999006|7092599006|19110799006|21061999006|15080799009|38102599003|8062599006|461199028|8060799009|3412199025|440099028|10035399007|102099032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AAznxkPIiJvAt269tKP2h5babR+WNcHz+v35qFQDoaAtXbBhb3TRaXYL6/?=
 =?iso-8859-1?Q?PnH6XcWl3qSDPy8YH8qc7V/yA6x6Y1Zcjr3dfAT0nlZ0/I4FYvYv7px6Xb?=
 =?iso-8859-1?Q?SZL06adr6Q6VoGGy7tAgMThFvvcZTPgKAkPO/r0Fe3LXGAcjyNruwBbGCK?=
 =?iso-8859-1?Q?xajwXPq9NDZFCu3l6vxoS6xktYQ1mWKslnmfZk0NNLWaqkOGVMGn1GrOOx?=
 =?iso-8859-1?Q?C0y4lSvR1qfGlE45uqUea5K7xA9GgFopre+gg3POyTjH6a9EnawD3hpmod?=
 =?iso-8859-1?Q?sZjnq9ScVe9EeX+k8qSxN1jHeIIbXqSfVTSzcXAiG1A4krtMwpGPL9bPft?=
 =?iso-8859-1?Q?9JbxEiMZg5gJ9aLK0swDjf+DcFmy2/FbKl0zQ8LDWy99+nOHQ8hs5M99kw?=
 =?iso-8859-1?Q?MO5b+dSzMnSwwxhgfMIBSMeLXe/gCumF2iwJcxgkpRx31we0i8qoRR7h3J?=
 =?iso-8859-1?Q?OGjJ2ZfIDKkZLnFj3asozgtn30vWedREhY//iTuhLEWEtA3IgjG8kffnqZ?=
 =?iso-8859-1?Q?hh9XuBfpQPW7NWplye/jEw5EMNQ7C5zS5BZfUBwgoGk8isn46Uyji2v3xd?=
 =?iso-8859-1?Q?AzQXCF0Jiw2+FSrUWihj0mK8GofXT7glVCeB0cgBkmLUUXmaCDUBJ4ny7R?=
 =?iso-8859-1?Q?E3W5Z92TqQ1WH0XBUz/c9ijULjxNQjSq6rIVt951X44E1idFv8D6Mll63K?=
 =?iso-8859-1?Q?Kf/TEcgNKUCgCX41KqqkpD3KG9IgvNmpRXQ3+HaqNa9FBr7HVixEycWuso?=
 =?iso-8859-1?Q?ZPIfFz6OI3/7a63GPveynNWZ8acjvGgOsLrKL8BuU8JZ78L1Tujl44hnvm?=
 =?iso-8859-1?Q?MrE70vsrrqd/bbQM2bFnayeDbdSLyEMy83jErIGRlbkFI2NcwrQNTakcEp?=
 =?iso-8859-1?Q?a9cyop0tKFLbzm/SGA1rOkP1Lj8Qwyd1wEDQ/n5aq9Z7AeiE+/2tukKNw+?=
 =?iso-8859-1?Q?vzDVQU43X8c4NwB8Yi1nN9TRc0kCW6helEDIvn999krp+wk6mRiCye+Ed4?=
 =?iso-8859-1?Q?SeklA1zTFv6YYRfHP1EPT3RjMyqyVs51k2iW3i4GRP/Q4A4ccyRJtkmVCi?=
 =?iso-8859-1?Q?YyfWIf/J0ga+HPpwWE62ByAbJJ+ODU+jsuIyKSooCPgNZFzDE4K4u5LV06?=
 =?iso-8859-1?Q?KxAUYc8qedYDlDrk3D+u1M5f3G357l/9TrC/8vYu5yyJOCluGLR4seojDd?=
 =?iso-8859-1?Q?B2lncfBhyVyUAPcjloQpv3dhv/7UoKoGoSb87PpNJckyEgN3jB4yPnYZJK?=
 =?iso-8859-1?Q?nEGwtuzUMaLkTKiJvI/+ZrRIHPZ8pHx2R4UiXMD+6BsPhM9tY6ANg9HPT3?=
 =?iso-8859-1?Q?Rnhn?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iONxf+eqHeyF0xq8gReOickQ9nu4ORO7iTx/3LHu3lizdklJeIqwO03kjB?=
 =?iso-8859-1?Q?m18rNUt1wKNBpw6F5+JkCUBrx4BKej3cMGCJndslxuxI7tpHDIKcoG11ef?=
 =?iso-8859-1?Q?rmTOkQsW06JT+SN9RVaeOyjcUIkQIO6i2c794oKg2u2azUEz6uItf2IaRZ?=
 =?iso-8859-1?Q?DlL6/t8ICrP0Wq8uXnVZ5blQizNp4b6n8zP74zjkRVnSb6Ptk4wuROTtFV?=
 =?iso-8859-1?Q?LWtEOswKHBDWDEgOTRHdPRJu6uhn8WiHpDGlWynqx98jraNwYoan96fIN6?=
 =?iso-8859-1?Q?g1pmE7sMaK6hh4aXQ8w94ETrTwqpXCgUYRQXUM4y+FlOUf+kmSXcgZcxqf?=
 =?iso-8859-1?Q?kR/gslebysznDvW4M+n5iPre75IsSbOXzak10GYTSEI7dJOKYOyIhGAl4w?=
 =?iso-8859-1?Q?aH4iRdsS7t4lPH5skSdki4TA8OEqM5OmZuj3obXiTPevPWgGRLiut4RqRe?=
 =?iso-8859-1?Q?W5WaR21xoyXSmxxuDv0BUhdBP7t9id5CYqrvbz/nwDsdXkBEuIE3fs1/mw?=
 =?iso-8859-1?Q?UBN7TM5de4UrfYPULoAvGNmEJO5di/YfiQYtuYFgBo91nxbkVNOUWzrSag?=
 =?iso-8859-1?Q?Jul1bPyOvSCA1s6t+u7yd96rFxWnw660ry2x5pnfBKQxBp3sJhzaMTfDbc?=
 =?iso-8859-1?Q?x/w5TagvWFaNKf1yaIBMWzX57h7dt4MpvjqwD8h9clnYuCOlZU8y9ajU2X?=
 =?iso-8859-1?Q?SJs+c7d3t4ByQ4t8u50Pkn2+gvEx91lWhafE8oTpzwpjUGfhWvCslMCcE/?=
 =?iso-8859-1?Q?EvuYlS0SVM11pyUU2ZkOmW4Rb6oJuy3HuH5Ahs3Dj8OIsVZJdtmglkhoc6?=
 =?iso-8859-1?Q?b792dvLFh1yV7HTa4AcssxarnCG8MmTuY9ZbtFYrYiWlH0P3M5z++jl8Ym?=
 =?iso-8859-1?Q?fDoUaynTq216w1ezWm3MIfPd7bGqJvyASIbj1WHgIrDRDrPwOr18OJWHNc?=
 =?iso-8859-1?Q?5sNA9memkP4q+1YYh/ySGToEkBVFX6+pUVsLQBxP6OLsOVvMeRbA+iu/bL?=
 =?iso-8859-1?Q?8RNPQP1OJhdOdrtaOwnw6wfCtJVjHv5uB9JyiFo+FLoDuaOfHaWhkCXURa?=
 =?iso-8859-1?Q?20Ksks9CvMznAIVSzbVahg/7pfS+M8keMztj8h1Fb9QZgr2IJdSQupq10O?=
 =?iso-8859-1?Q?chamytXnmXYGdeCoMGfQ2s0/9Axv+ZYKnBWjjm7bb40OM+D4FtZ9sExNZY?=
 =?iso-8859-1?Q?V59luNg88iwHQqhhbvocAmuALRbwuwUnxbQGsA8LfEOv7G8cDYb2sHSQ2H?=
 =?iso-8859-1?Q?kfiUfSK5brA/TtRo0QviaHdNdWEpwpkFHvAafIzt8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df9af216-fef6-4f9a-4615-08dd9db606ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:05:27.7507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNXPR01MB7259

Hi all,

This patch series included three patches:

1. The first patch adds a link to the `git-credential-yahoo` helper for
   Yahoo accounts and links Google's `sendgmail` tool as an alternative
   method for sending emails through Gmail.

2. The second patch improves the formatting of the `git-send-email`
   documentation, making it more readable and consistent.

3. The third patch removed the email credential helper links from the
   `gitcredentials` page. The links are still available in the
   `git-send-email` documentation, which is the right place for them.

Detailed explanation of the changes has been done in individual patch.

v2: Removed instructions for Yahoo SMTP server since I've realised that
    Yahoo *was* a popular email service. Also, the instructions were
    just making the docs more crowded. I've also added a link to
    Google's `sendgmail` tool in the first patch. The second patch has been
    added to address the issues that came up here:
    https://github.com/git/git-scm.com/pull/2005

v3: Added a patch to improve the formatting of the `git-send-email`
    documentation.

v4: Added cpan links of the perl modules requires for `git-send-email`
    to work.

v5: Added a patch to make the purpose of using app password for Gmail
    more clear in `send-email` documentation.

Aditya Garg (4):
  docs: add credential helper for yahoo and link Google's sendgmail tool
  docs: improve formatting in git-send-email documentation
  docs: remove credential helper links for emails from gitcredentials
  docs: make the purpose of using app password for Gmail more clear in
    send-email

 Documentation/config/sendemail.adoc |   8 +-
 Documentation/git-send-email.adoc   | 194 +++++++++++++++-------------
 Documentation/gitcredentials.adoc   |   4 -
 3 files changed, 109 insertions(+), 97 deletions(-)

Range-diff:
-:  ---------- > 1:  2c47cc5396 docs: add credential helper for yahoo and l=
ink Google's sendgmail tool
-:  ---------- > 2:  bc1d0471ca docs: improve formatting in git-send-email =
documentation
-:  ---------- > 3:  b9e41e2492 docs: remove credential helper links for em=
ails from gitcredentials
-:  ---------- > 4:  a6ad7ac810 docs: make the purpose of using app passwor=
d for Gmail more clear in send-email
--=20
2.43.0

