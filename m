Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011032.outbound.protection.outlook.com [52.103.67.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E711C5F27
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767150; cv=fail; b=NN1Z1xCDYCHnVx3egtANN/WXBruT0UQ7Y4YgUu+yqoM7/9bVcv3Fmmj5+KyRLFS3uMkjkeyKwb8kkQ6YcKahpyPW0xdClhjfEnKs5rkJfMJpBjoBtY8/uz9sozlI5ZiR+iOqR2e5T5NEeygtXK+HbUqRkMkzTV4rmYg9v2RopEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767150; c=relaxed/simple;
	bh=lCWxj5Z9XS5zF71KBxLZ/vUuygyUf1s2oOpE7SnN9e8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t1Hw+hVPYUvP4O4PTw1ag4qkb9bMKfES2jF7ouLZB+ux2/HtYLw0WoXKLlj5sGaWzEKNNk+6Hywo/GqY+MYTwRVQviroHCCA5hbGy8WBWQ7AW6DnWZI1jayFrQJUuqXWN3q8qpcyWLQdFYk4WBek5ovh+VIjW0bzQ4+HMPV+3ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hWd6Ae5H; arc=fail smtp.client-ip=52.103.67.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hWd6Ae5H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtpUY3ASbVTn5fIwfGHejonVy1VTXp1PKpGxcsr3ALjOimKxLYgAWVx6pMuwuKq92VmW7rvQdJoOmp0U42jynCR1iBlIhf7GoFUl7t556o/D1dKr+6ITfMqyCGhe4k6iLXoIvzfs8q3Qc71J9sqYCWCclHWq3EYHf7jE4D61ZLsZqfRPJ6oEKsf/vAJ5hBx/KLCmk9tYqtaqcVX7kWtBn3k8dHjU5k9e6f/41Pi4T3x8geAYJZOOLiN7dsqhvpuN7rOrwUb+pjdd16hXJiwy3siDLHkBbNx2YEPKU8Lbf1EPjmlNh9TK371BLgG6Bnv0AssC8uw7TW70aZVYsmoAbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgXxcck9uyq0mxhSI3p9OUfhn1nWvVeaNnzWvF6y18Q=;
 b=OB8OVnhPkCyhMQQsCpLV67FWEsqwFAcLjwLQxmLPFrwIRredhY3wvDk+UDrSdD7pu6xyMPxQBux/Hz/bQzdtKszY6gFMir5j5rCtAqtVCYFxrNksOifDLnsUNbGWqW/DKHakLF2tUrASwIe0lnlt8XrdqBS8FGrO+gI0FuQ1GdGqSv648jj4wUp1TdWAbyTreJcMWCjGV5UTRUsEJZcjKh6G4gVjQ5618aRsQbMZg3z+A3Bmi2S9B16Fda6169hBl1WFZFfMcBzgM2bI/NvN8EuRRX3Io+RbPa96pEueas+FO+btz4FUqr4bsd6PdgayRly162zgDmowFTEL87qyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgXxcck9uyq0mxhSI3p9OUfhn1nWvVeaNnzWvF6y18Q=;
 b=hWd6Ae5HRS0IK9eyH2udxiWK+oACpdyHwJGyD9vv5fqxGfM/1FiwM/bAauGTGGyKDzFl/zM4VmIdKH/yROLVki60I9ES0cxVBEM9lAsoDhQt4yJM0djruRog6I3rBlsENRICc1LY39n+psoFMb+ATroVp0szybp1jR2nuUgAQlfmgNoi1XQlDqm7wNWQhHNIglpghwpyDCqp83J/4kpQsLZn3nrxAMsEFv1u0YFxNpAa3DpmWVXlT6bXezlOL0GxJVJr7Cd8NtBRjvPKHn6ijiI++y7Oa1VO16/LerjgjoM16BERBvdpHXnEn1OmG3SLf91KuzRzkAHdB5iDdmwuvA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN0PR01MB9527.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.35; Sun, 1 Jun
 2025 08:38:58 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:58 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 9/9] imap-send: add ability to list the available folders
Thread-Topic: [PATCH v11 9/9] imap-send: add ability to list the available
 folders
Thread-Index: AQHb0tCdrUXtfFzgKUq0lk80ZwaSVw==
Date: Sun, 1 Jun 2025 08:38:58 +0000
Message-ID: <20250601083821.2440110-10-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN0PR01MB9527:EE_
x-ms-office365-filtering-correlation-id: 275ef81d-f1d8-4f6e-6857-08dda0e7c0a7
x-ms-exchange-slblob-mailprops:
 +b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQk3Sr6AOpK3A6Q9M315hZvJv2in1n7hJvrirk13H0tuxaXd+R4RdukRoSZEqLYUKo12cxl820XADGEYs7HT6+Z2MxdgoydNPIL9BYhkUyn05CzTw4V8wPZdRTJ2sdHEZQ1NJg8qt1mVptCO8WKk9rDLjvWSXBaNAqw3Fjz/dL+HFE/D+bq4Y+V9DXfSplnDSKkpZJUHBczA4hZcxXKKqJJaH0ubggklLkk8OTv+3w3jf6VvS3AiTdAjLkJ4+QpyluEm0kx/vD7CBk0MUAd3nAPSybNcKG1tQaZ+V6rAZY4VY+89EYNIYADBZTROxuPdJ1XyJ0YLOejB08B2macr9d18aASLYty8+sEJHU7WT2riUFRgUVyE+jiv6XTT3oOwyNxLz7aXuQcEar2y5Af+eNCUV4ngrWa5AzlgNeEgoNtPMIHYVOPumsEaSTLtPfeXcBqDQO8ZlQuO7L5OwWHcDubV1EfEcUquRZEAj1vRQPg3ORXTjoULSANrYgvgphVRnFxjabkr3px9lSIssh4GOuteCQ0bunU462J2ARa+FAKOZ+tVDgzA7bRzrEcQ1mTWD5rskozYVSlNvWha2oBbp+cRBC67VaAUX2DplUnwyCcJS40bD/cplmhbvqDEHmwoasl0E4GxGImnX/e2aGKdLnSZz6AD7Ss7rlZgBRTJ/3odRYtfpneArj85RbQ93lhsABl44ufdXpxG+zw4t1FjF20ffkN81+6HFpHp599YCjQCTjUxGD/kVTQzGE9mH4LMaeJNMOObc1Bu8soSQF+opwQKHSYo21VEtlenqNKxFyztoZi3jbf2zTkLW/h3MAEn9O8pQoXDv5JXJZkuPH/eaaBjg==
x-microsoft-antispam:
 BCL:0;ARA:14566002|38102599003|461199028|8062599006|8060799009|7092599006|41001999006|12121999007|19110799006|15080799009|1602099012|3412199025|4302099013|440099028|12091999003|102099032|10035399007;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?AWCjEMXjB9SMFb2ce2in67doMFAdhb+oljuSQuGWMNlMRBO240Ck6D/P0k?=
 =?iso-8859-1?Q?oFFuc8KpZjt7GquVjt9Amp5DHMplSgNEUVMHQWArfxV5CWPHYYkJ6EOTPp?=
 =?iso-8859-1?Q?hGkvAD0KjXaMz6qtFdFsfQ8SE5jqgn6/dSCjieTPurs2vxdJ7EIrj2yZi1?=
 =?iso-8859-1?Q?wveK/IoeEphei+WmWjeJ2hkmF0XKdf+TssvLjA8IrDoMbP4AKt/HQpuRDL?=
 =?iso-8859-1?Q?jcAl7yrdYh3lfzydc9ZBySozh5GOMpNyHSSNgSQYYuaQ8inrEORDDmUrT1?=
 =?iso-8859-1?Q?+ghT06b6UtBJTiUD1aAvxHQqjZrsoWhf2qb/cQaPxeViB+1z6z45dgxbKC?=
 =?iso-8859-1?Q?IRna7km4Y/JnSBFjU5RYTSphcAIClLlhWdDR1fncHA8u1wZThJGLBQxu+k?=
 =?iso-8859-1?Q?VEB/CRXEe5GL0ctg1hw+R1YLISZB7I6vK7WWBbmgMfwvvP6HPfbvA95QB8?=
 =?iso-8859-1?Q?yYL0Zh65twWEYzeY5XZM5A2majER5JjUBJyJqDOK56RG+ESnwVi15DvDuK?=
 =?iso-8859-1?Q?Dx1wGny1VOM91gGWKDOCsZhAXgdKXwmEp78LYUW62yhdQXuFWgI+aombpz?=
 =?iso-8859-1?Q?oFrSCUXH3SlIuyHxntaApCFEaFGs/y6bT2UnFBP8rL6kJIAhpF5B6Wbt9q?=
 =?iso-8859-1?Q?INfrBxjBgEWP0LuZlfu7xuS2R84wo6KdE4ycsLMo25hhN9UEzF5W9KaZXk?=
 =?iso-8859-1?Q?FIQaXbnlpaYR3r2wzgu17fdRIwiFUqads1KbI79Lj+taF3vQFBdAO1tzPJ?=
 =?iso-8859-1?Q?P+iHcWMLReKGdf1S0dFvOfpifntwGKNNnBGZXYkATeHO0/kh8w6rrzJjHA?=
 =?iso-8859-1?Q?YKeR3Mcc+mmpUJFiaGuST7Z+mp8877OTGZwxf6JppkOC+fIlI18msf3G0e?=
 =?iso-8859-1?Q?oa/UIKDJn+KFS/glBGFqEdcyuM1823le3hSYs2vbgSdQtXpHKZtBNijyCo?=
 =?iso-8859-1?Q?7ntfQp9NyVCW5Ki7BlnlLLc6EBQMJa1VuUrneZV9LXFwHRAsnL7SgKlsu9?=
 =?iso-8859-1?Q?fq2Li+N49DRXBBp95j8nUhiy41YCo8ldTkT1ZWFuKHKdqnvdtiLh2w30ip?=
 =?iso-8859-1?Q?qI5vmCqHq6+PgaYO7qZvDWVNsk74FN+kbnfsxs7G71F2b1GClnKhjQ74k7?=
 =?iso-8859-1?Q?3+CJ7RFmo3gou4DU7W44jR27XXt1CWhU7S+Vu2I5cjsRiohZmByipNkyuG?=
 =?iso-8859-1?Q?OxX+p+hi3rNgySSxJhJwwt4ZTgmIepUFyP2WjTZREdGG10zhMAfjE5DneO?=
 =?iso-8859-1?Q?bXf7u5OFG6mpuYUVNTyPsKEbBp82EMYdQTNxGKpnofEDNDfaINvqv4EMRC?=
 =?iso-8859-1?Q?pGZuqCxfwzB01Lnzs0xwOfthGXsqMvQx0PfFW23F88m1Q7px2OacmsOyfR?=
 =?iso-8859-1?Q?/l//UG/fJPDJ3BM+BMWPL4XLJjKJhQ5esKa4DzkEZy3ACZh9mX33k=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?2w3sOWczZxnry/yMnhNmA2/63GIqMkb+pymLOJfw8RWuY70cQsBlvDh+ON?=
 =?iso-8859-1?Q?CAcgEe9CaAH1OfmXD9EHuHr+7R4acxLVoXAPhZ+Hx4e80r1QLQget/Iu4V?=
 =?iso-8859-1?Q?iobeNZRJ+BFZWHkrYSS21/SMiExZnvC8XxNayyZQN9tbM7FpsYkDxJWcWJ?=
 =?iso-8859-1?Q?fS0Di+U4J1zMxbvqlqrA/Tn7fScnaJrwTHa/drr96Wh1jlc5lIUMrLZvew?=
 =?iso-8859-1?Q?w5NjPqOHBJdmxJqoBGGDmgsdsg07JwY29ZevCQA8nSpwcuCFLiQWY9/H+3?=
 =?iso-8859-1?Q?GP3cnFClj4AIhy4FLW+ZPANJWSg9/8FTYjTMFsuy0smID/fBM5FM9Ddyw6?=
 =?iso-8859-1?Q?shIhn4Pt/yfU0Qvv73Oe/aHrKRWrWkLjL2JglTAgk8R3YcBi6AD0TTRXh1?=
 =?iso-8859-1?Q?2aPwOGWbvJpIiWvjgXUm8j4TGscTCsq/MuG/HygLiGa+zS/NUpq1SXfsC/?=
 =?iso-8859-1?Q?0vTF60DRi0KqrfKdeW44zzDKR3qD2L29Ms8tVfDEARQFkg46SJnxEYG+4n?=
 =?iso-8859-1?Q?Wb/byhjRT9WV5C8t4VUeIyUSdKClSIj8SADFsy9T9nss1GriXZb+HT1wT3?=
 =?iso-8859-1?Q?JRjqHBp/qbvESYJ1fMDyB6Ku2YABUqkUl5K9IlVODrbyXXKqGh7V3uEn8U?=
 =?iso-8859-1?Q?My6IEeC7jJaPJDRuw+De1EPNlWcOFq842sHcsA57OjKFwKQg9jFwEeHCOQ?=
 =?iso-8859-1?Q?wJsv7Qf0BgmKtIupSi4xmNHIF7ryr7lKz6qRlX9yXchH3XPIysj3VCjkMe?=
 =?iso-8859-1?Q?3uKPd+sBQNIHzbEDuIUJx9dID96f7dpkgGD829iTP6vrx71nH2x5CLC3Vl?=
 =?iso-8859-1?Q?maioeKMfldUIQuexP3ux01fQQcJQvUZRoX9cqfywIHqdlIZhR/WjeZ/vNa?=
 =?iso-8859-1?Q?xFhTaat1wYd/mgk6xokYLOA5v9pIXSihwQVcf7FVrjJ/1e6l2bS42DeSeo?=
 =?iso-8859-1?Q?39xihDtrOJuKG2dFiQFu1wQrQw1CWShVbgZjqjKKT1Do6AaKoULULgjoGB?=
 =?iso-8859-1?Q?ayYLWFmERe0O9S3tPYnSx8R9GYuoCjsfb05T+uNiG3TQ7pMxYf6QOWprRy?=
 =?iso-8859-1?Q?jFbEzfcETq4dtwVaVL9iswDusX788CQ1KqbHQ3kZ8GOEk2+fCoASusac6L?=
 =?iso-8859-1?Q?SHIHTrpsxJoleqQCf2u5AMLCwxhyN+i2UCYmU8U+bqNLLTerQ50h1G7ki0?=
 =?iso-8859-1?Q?jKgDx/CFgktqtXm4Effymm75KYMbJPK3ERl4Ct3sGtBiQKySOcZm5ZD51O?=
 =?iso-8859-1?Q?J+RdGbA0YuqVr8Xj4xgAzh6ZFCZ+la01RYwPUt1aY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 275ef81d-f1d8-4f6e-6857-08dda0e7c0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:58.2870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN0PR01MB9527

Various IMAP servers have different ways to name common folders.
For example, the folder where all deleted messages are stored is often
named "[Gmail]/Trash" on Gmail servers, and "Deleted" on Outlook.
Similarly, the Drafts folder is simply named "Drafts" on Outlook, but
on Gmail it is named "[Gmail]/Drafts".

This commit adds a `--list` command to the `imap-send` tool that lists
the available folders on the IMAP server, allowing users to see
which folders are available and how they are named. A sample output
looks like this when run against a Gmail server:

    Fetching the list of available folders...
    * LIST (\HasNoChildren) "/" "INBOX"
    * LIST (\HasChildren \Noselect) "/" "[Gmail]"
    * LIST (\All \HasNoChildren) "/" "[Gmail]/All Mail"
    * LIST (\Drafts \HasNoChildren) "/" "[Gmail]/Drafts"
    * LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
    * LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
    * LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
    * LIST (\Flagged \HasNoChildren) "/" "[Gmail]/Starred"
    * LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"

For OpenSSL, this is achived by running the 'IMAP LIST' command and
parsing the response. This command is specified in RFC6154:
https://datatracker.ietf.org/doc/html/rfc6154#section-5.1

For libcurl, the example code published in the libcurl documentation
is used to implement this functionality:
https://curl.se/libcurl/c/imap-list.html

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-imap-send.adoc |  6 +-
 imap-send.c                      | 98 ++++++++++++++++++++++++++------
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 8f221240d0..379a371c08 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+'git imap-send' --list
=20
=20
 DESCRIPTION
@@ -54,6 +55,8 @@ OPTIONS
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
=20
+--list::
+	Run the IMAP LIST command to output a list of all the folders present.
=20
 CONFIGURATION
 -------------
@@ -123,7 +126,8 @@ Alternatively, use OAuth2.0 authentication as described=
 below.
=20
 [NOTE]
 You might need to instead use: `folder =3D "[Google Mail]/Drafts"` if you =
get an error
-that the "Folder doesn't exist".
+that the "Folder doesn't exist". You can also run `git imap-send --list` t=
o get a
+list of available folders.
=20
 [NOTE]
 If your Gmail account is set to another language than English, the name of=
 the "Drafts"
diff --git a/imap-send.c b/imap-send.c
index 3565a91ca3..ca95eef652 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
=20
 static int verbosity;
+static int list_folders =3D 0;
 static int use_curl =3D USE_CURL_DEFAULT;
 static char *opt_folder =3D NULL;
=20
-static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
+static char const * const imap_send_usage[] =3D {
+	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbo=
x>"),
+	"git imap-send --list",
+	NULL
+};
=20
 static struct option imap_send_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP =
server"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder=
"),
+	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server")=
,
 	OPT_END()
 };
=20
@@ -429,7 +435,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] =3D=3D '\n') {
 				b->buf[b->offset] =3D 0;  /* terminate the string */
 				b->offset +=3D 2; /* next line */
-				if (0 < verbosity)
+				if ((0 < verbosity) || (list_folders && strstr(*s, "* LIST")))
 					puts(*s);
 				return 0;
 			}
@@ -1622,6 +1628,26 @@ static int append_msgs_to_imap(struct imap_server_co=
nf *server,
 	return 0;
 }
=20
+static int list_imap_folders(struct imap_server_conf *server)
+{
+	struct imap_store *ctx =3D imap_open_store(server, "INBOX");
+	if (!ctx) {
+		fprintf(stderr, "failed to connect to IMAP server\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	/* Issue the LIST command and print the results */
+	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") !=3D RESP_OK) {
+		fprintf(stderr, "failed to list folders\n");
+		imap_close_store(ctx);
+		return 1;
+	}
+
+	imap_close_store(ctx);
+	return 0;
+}
+
 #ifdef USE_CURL_FOR_IMAP_SEND
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *=
cred)
 {
@@ -1650,11 +1676,13 @@ static CURL *setup_curl(struct imap_server_conf *sr=
vc, struct credential *cred)
 	if (!path.len || path.buf[path.len - 1] !=3D '/')
 		strbuf_addch(&path, '/');
=20
-	uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
-	if (!uri_encoded_folder)
-		die("failed to encode server folder");
-	strbuf_addstr(&path, uri_encoded_folder);
-	curl_free(uri_encoded_folder);
+	if (!list_folders) {
+		uri_encoded_folder =3D curl_easy_escape(curl, srvc->folder, 0);
+		if (!uri_encoded_folder)
+			die("failed to encode server folder");
+		strbuf_addstr(&path, uri_encoded_folder);
+		curl_free(uri_encoded_folder);
+	}
=20
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
@@ -1685,10 +1713,6 @@ static CURL *setup_curl(struct imap_server_conf *srv=
c, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
=20
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1707,6 +1731,10 @@ static int curl_append_msgs_to_imap(struct imap_serv=
er_conf *server,
 	struct credential cred =3D CREDENTIAL_INIT;
=20
 	curl =3D setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
=20
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1753,6 +1781,31 @@ static int curl_append_msgs_to_imap(struct imap_serv=
er_conf *server,
=20
 	return res !=3D CURLE_OK;
 }
+
+static int curl_list_imap_folders(struct imap_server_conf *server)
+{
+	CURL *curl;
+	CURLcode res =3D CURLE_OK;
+	struct credential cred =3D CREDENTIAL_INIT;
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	curl =3D setup_curl(server, &cred);
+	res =3D curl_easy_perform(curl);
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	if (cred.username) {
+		if (res =3D=3D CURLE_OK)
+			credential_approve(the_repository, &cred);
+		else if (res =3D=3D CURLE_LOGIN_DENIED)
+			credential_reject(the_repository, &cred);
+	}
+
+	credential_clear(&cred);
+
+	return res !=3D CURLE_OK;
+}
 #endif
=20
 int cmd_main(int argc, const char **argv)
@@ -1793,11 +1846,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port =3D server.use_ssl ? 993 : 143;
=20
-	if (!server.folder) {
-		fprintf(stderr, "no IMAP store specified\n");
-		ret =3D 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "no IMAP host specified\n");
@@ -1807,6 +1855,24 @@ int cmd_main(int argc, const char **argv)
 		server.host =3D xstrdup("tunnel");
 	}
=20
+	if (list_folders) {
+		if (server.tunnel)
+			ret =3D list_imap_folders(&server);
+#ifdef USE_CURL_FOR_IMAP_SEND
+		else if (use_curl)
+			ret =3D curl_list_imap_folders(&server);
+#endif
+		else
+			ret =3D list_imap_folders(&server);
+		goto out;
+	}
+
+	if (!server.folder) {
+		fprintf(stderr, "no IMAP store specified\n");
+		ret =3D 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("could not read from stdin"));
--=20
2.49.0.638.g5e24c6cde8

