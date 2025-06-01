Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71BA9460
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748767147; cv=fail; b=oPdp8sgwAK/XL4bUhxPEMdWB9+ypOruBNJfK42bxUsA4U/ayB3Poj7gHNvuBokAZe4HCr5WPoNzu49y35SzJXsQl1Qk9O3G1OyhjqtC3VdJxd+KIovIbGiUdL48Orcj/KbNcOpCVW58EAQb42jYvLR8uHvapv1BVo/b/89QY20U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748767147; c=relaxed/simple;
	bh=9dRifzxGHP1ZM6D3bq9+f3tTVainTFe3QWt1c/ICpGU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oegZDQktNFjfZ6jp73TktAb8mwRbzIvh/JWxuoG2CgbVkvvrDBhgJZpGCT8tze7ElPU7+IaAKdRHb2y54J1vxPNlHMzzdNxMHjOD47ehNKKHz6cuXlDmPoOxLOTdACSmWJFGkAFIlJ0y4c70iRs5q4pwEW/uFy+PWeW15mBNzCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=KTKiQkD3; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="KTKiQkD3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kknwT88jY1fd75wm7Pj0rM1acLHdnWG5AW5Hs9AIjycGWTrcHEsyaP9V3ZazLOp9MRd6iCM9e4K3KlFj8jdq5P88b2urqK/yJhDzLFi4M/jJp9+mc7MWajfMBimTICXdB4FM4I8YPweT5mz5nTqXaoPOJS+t2N5rbueEGAA5H35cMwdGnjPhJRr/LlAM3bKXR6kgWOxtg6MqLyHmM8AjPWOCRgdkqiTLvx08HNpJYrKldDl2TbUMkUFpvhfqB71ku9bLhfJ+/BpGkW74sDAvYuxZt12gcxeTggx9SlJDvJL8Mgf7bQq+xqpUj2aPOC1wOkw/kHqQsnIuSe3E7dCyoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ld0WoZEn3kTLf2hlawjAugmFVy3w9RX1MphgK+exN3A=;
 b=aGcw1+0OXRIlB6Qd0ICMr16oqU92Cvfy2HP9AivlpSFfesc14UvNjon9Hev6YDLeInbEMDXPBNUwY8ebGuatilGV9IsJJQ5OQb3+tY6SIdm6SvbgP49A/NWPDTuP0S714hSENLof9dB0WPNM/NWg7Qj5OI7ULuyoilVvxwOx/Wjl+tuE/Ptbjy+GCU5+gBvgfFQEdqIlEylkBFRo76xvnvNLt0VRmxV0JsVc79KgWk5KNA40kGeApOpCGsW1R/oHOzs6aazyzcLT6Qr2XDyB1NoyBkF7uqe5AtldlzttlF3m3GAZ1rc0TvJDfj+ieOs8KGXpoBhoVALEsz7uLRHqVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ld0WoZEn3kTLf2hlawjAugmFVy3w9RX1MphgK+exN3A=;
 b=KTKiQkD3JU3Q6Qjs2Eu8e1nIDzBTNPW3sQFfgh/8w8GGjFV3RZSQmP9Ypr1OIR1+feslvk2RrvLkBXc1TMj61AysDgHZDy6KUz+YUs7AyC8qWQWEKyrRxqqMqwafrellp7zXqhVtyz7Gi3atQAEPel9HaVGnghuJirBAgJ2N1E2zW8vehGE4bF6qCNoHAtWfcejrtl07HRWvMlf0EbmRUbJfdnXUjs3HQdhuY2yh11grF51R6k9QinmCRkHtoJNybLP3peiNho3oWKj56tiwjB20yi6spAQx+Q/hHt0fbiz0iIleRTSnzuiiyIT+WYxHyukzP8pos7kUFxT3CdnoVg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6304.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:7e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Sun, 1 Jun
 2025 08:38:55 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 08:38:55 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v11 5/9] imap-send: enable specifying the folder using the
 command line
Thread-Topic: [PATCH v11 5/9] imap-send: enable specifying the folder using
 the command line
Thread-Index: AQHb0tCbH7SAtqyI6k2V3V1h0MtG5Q==
Date: Sun, 1 Jun 2025 08:38:54 +0000
Message-ID: <20250601083821.2440110-6-gargaditya08@live.com>
References:
 <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <20250601083821.2440110-1-gargaditya08@live.com>
In-Reply-To: <20250601083821.2440110-1-gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|MA0PR01MB6304:EE_
x-ms-office365-filtering-correlation-id: 6f916b8c-801f-42c3-9435-08dda0e7be85
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|8062599006|8060799009|15080799009|19110799006|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SpQ7cgN0uCu7rTjA5H8wvBCttHjQjQHOU4lK1B9/1BnUqlJa73r+0RkBZQ?=
 =?iso-8859-1?Q?k2uc0NB3AmCKbfawKSH8wdWSXyV9tjcu7Cg1anN1X2HBg1w4BBZ4L2umAC?=
 =?iso-8859-1?Q?f0Wxv5OT6ZJkSajJb3erJp4IWoRqvPSpZOaMWNj/xWQz/SbDkxDB1QpA//?=
 =?iso-8859-1?Q?Ok1uJeUp1OQb07sqeJMM+1A1pCACaF51D7S7fy7ZPJKSZZtmdWXCt/7Fsv?=
 =?iso-8859-1?Q?Ypps+dkEErP3CqkpaNuWOQ7Fksm8V4ABBvqiL3qfRCUWqEBHTorQSh/PUa?=
 =?iso-8859-1?Q?YwxjR9BCH/fItKvfpscWeEUZ6c1T59UtyMMZLjLjMXfZhuF2zkRxK4yOr5?=
 =?iso-8859-1?Q?/n/d7yjR2MIl/ZjJUZGLZ8PF7PhE5oaSeJsOmhrg5nXAmGVmoyyiK79gpU?=
 =?iso-8859-1?Q?veX9qBIrS/9sdeCfkDv7FEdE8rDlRrJyMQPbnVQJKWc0Pa3OE6cVGv5eWl?=
 =?iso-8859-1?Q?LUfvyUVFLPU/KphMLYWBiddE4y1OYeJ5W6gSbtKszETdB7kKkvzPMaFiwt?=
 =?iso-8859-1?Q?trGeygcSRB3gmayCK60+ZffUYWBj3cCvSsBK3X7YYxIxW7iPkqnuSCrYdE?=
 =?iso-8859-1?Q?ud2+P8wnPNYRiQ7Yrc47Z72Ck3+UYIoSSId6vohtbRBmsVQVf/bj503tNT?=
 =?iso-8859-1?Q?2al4IybPdxGtSq8NbmJcIL2vxUckBDCpESYqvIzbh/Pxwsja0cmNeLfzw+?=
 =?iso-8859-1?Q?+rNaDp0gxN5dRMXgtpqU7MCK1Y60g9eBXM++ovufyK3M8AJFJ3NFQnTDeD?=
 =?iso-8859-1?Q?fkMjgohw2/TW43DOQJdl2jtmqneIQXFwTtFWzqwJ8ocGsy1nYrLdKA7c7V?=
 =?iso-8859-1?Q?WzcStWmP0nHG2hc80YXsC9VxSU8OlNfNuYUvkt0xdaV4vY37wkahyhFvwD?=
 =?iso-8859-1?Q?s+4onC50Z4xWMwNyPbjqZJoGONBP2/vf5oTmDgctq/VKk4rub0xLU4Qw8y?=
 =?iso-8859-1?Q?hU9Rv7FMfXHFlfYjRIw04PTWhOfD9QJSpkmtROwjpo9LH68ZsHZkGxXyie?=
 =?iso-8859-1?Q?IpZr/FV2TY+8lJkwvHo1qKsr0ipNz2gF3CTymRzAkqG9xHt54U8sYCaNYj?=
 =?iso-8859-1?Q?/JZEvUoKUlxoZ6nAVl5dyfVVs/FLiSOmUSfq4ZStgf0hpR+qxfjYfxWNVE?=
 =?iso-8859-1?Q?P/d4YVsjKLx3qa9UFqttKh3DtKn35r4UaH6taqCk4J9k0/AMWueVHc7jOo?=
 =?iso-8859-1?Q?Uspucb3LdQ9ul2cwemaOzVnNUmFpnnGu9Tg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7IDODmpg3i7upfdhyZIeKRhH0FohsrGyzoaXZ0XHVtBvrxc8zHn+MHZSso?=
 =?iso-8859-1?Q?nNnYiHsOV/adnUTZRNhQ3IB35i3qgYBtcRhu6rrYCIKY87K128fpklvzSs?=
 =?iso-8859-1?Q?t8/AXUvgX9iERjnsxWWWNoVRfap4nfYXFRjPzV8QeWeKYhCRBdLeh2lM4w?=
 =?iso-8859-1?Q?fTcnhqmW8bv5A7hIhrlukfL2SCuD32+5i2hEa6k45QXATEjmFzl+I8dCX9?=
 =?iso-8859-1?Q?mYwpXqTcm3ANiAMaPGrJAo+MGKOf0AeLluqlHss62vdDAFl65POYb2V2Xw?=
 =?iso-8859-1?Q?fi2LGlnvwFc1RUjFS2/mld2xMc+F21WRI53h1fUdN1X/M2fPXo0Of8c6G1?=
 =?iso-8859-1?Q?xwOgkj4u5a251mnBprsi5MWyEyfSjlxE4JBkYfTlxdT3KcBWgSWSIscdcl?=
 =?iso-8859-1?Q?fQWEdD4gaG1hAD7616xXpCbVpjZn+ul/Bgw4HG6u/vGVyPMHaY7hLgEHHy?=
 =?iso-8859-1?Q?rEmXBc7EuNLoIaGHTkMKSonHs4/bq1gLWMM+SCIzTuMNjYd6lxnUSS+i8S?=
 =?iso-8859-1?Q?6OrnnAAzX5zw/pwGAPjWi5oNGwTdlj/c5gH3qJlK3txxQV9x4kECgHLI8/?=
 =?iso-8859-1?Q?puVNI2FrPZ2zFkSzaQXnkJyW/15XzXGmOjdX/jkYkFn8DtQcBfq4lkTzYR?=
 =?iso-8859-1?Q?p+8JFVbysSokXN4f04E1Cf/HCsQFJon9FetcfzIx0USbof/9G1yzEylsA/?=
 =?iso-8859-1?Q?4ugp/lmUTYdhBoRIv8UniSlFQHe9xxW0q3pSOb9ZxAX5jidOjgupbcxsin?=
 =?iso-8859-1?Q?uGIxKSgarFmzY2RpCC97db7pWokKfkYjKPiiGlyFzbfwEIEc3xP9/AslYr?=
 =?iso-8859-1?Q?O1KPKemLsgwfehvWWXcUSlIkmKLGNTodVGGKof4P1f4Zx7DIOWoW9LbLc/?=
 =?iso-8859-1?Q?PbDx3oFMSIAjY6RP6hsWuVXzMEWyzrMhVFp+mTTSZzQ9IGwg5sXpr5jYU2?=
 =?iso-8859-1?Q?ALq4iiLzaN4JYcFd+mmktm/5T8KMcfvmCg1SOcEKQ1/3E+0qD616vNbfm4?=
 =?iso-8859-1?Q?noGCyGXRBPmrX+tYCm+UuX8kK2LyoSGXAjCLUWUzWpq4zBLhN0/z8Og4Wj?=
 =?iso-8859-1?Q?Q3kvqiYGMm+Ix9+UXP+VUzfgQieSgYHtwBqGW9JDvutsT/C7i7TmgSbq7g?=
 =?iso-8859-1?Q?K856f7ytqhCq59NN8Tx5OydirFk3Ttwkzw2rD4WTv+K+iDvfU5FbGCKiIS?=
 =?iso-8859-1?Q?9geAs2/I70hc9p2ix8obPgdrDTugFumT7l1ML3aIbYythP5rZPuTVE9nr/?=
 =?iso-8859-1?Q?w0cRp8DtGlqvxFVD6dPDYbpPnheC1qz0bGcLe+MqA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f916b8c-801f-42c3-9435-08dda0e7be85
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2025 08:38:54.4036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6304

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  5 +++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 24e88228d0..829d9e0bac 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,7 +1,8 @@
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
+	folder. For example: 'INBOX.Drafts', 'INBOX/Drafts' or
+	'[Gmail]/Drafts'. Required if `--folder` argument is not used. If
+	set and `--folder` is also used, `--folder` will be preferred.
=20
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 08ecb1e829..8f221240d0 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,21 +9,23 @@ git-imap-send - Send a collection of patches from stdin t=
o an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl]
+'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
=20
=20
 DESCRIPTION
 -----------
-This command uploads a mailbox generated with 'git format-patch'
+This command uploads a mailbox generated with `git format-patch`
 into an IMAP drafts folder.  This allows patches to be sent as
 other email is when using mail clients that cannot read mailbox
 files directly. The command also works with any general mailbox
-in which emails have the fields "From", "Date", and "Subject" in
+in which emails have the fields 'From', 'Date', and 'Subject' in
 that order.
=20
 Typical usage is something like:
=20
-git format-patch --signoff --stdout --attach origin | git imap-send
+------
+$ git format-patch --signoff --stdout --attach origin | git imap-send
+------
=20
=20
 OPTIONS
@@ -37,6 +39,11 @@ OPTIONS
 --quiet::
 	Be quiet.
=20
+-f <folder>::
+--folder=3D<folder>::
+	Specify the folder in which the emails have to saved.
+	For example: `--folder=3D[Gmail]/Drafts` or `-f INBOX/Drafts`.
+
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
diff --git a/imap-send.c b/imap-send.c
index e169c5e919..cfa335b647 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
=20
 static int verbosity;
 static int use_curl =3D USE_CURL_DEFAULT;
+static char *opt_folder =3D NULL;
=20
-static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] < <mbox>", NULL };
+static const char * const imap_send_usage[] =3D { "git imap-send [-v] [-q]=
 [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
=20
 static struct option imap_send_options[] =3D {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP =
server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder=
"),
 	OPT_END()
 };
=20
@@ -1766,6 +1768,11 @@ int cmd_main(int argc, const char **argv)
=20
 	argc =3D parse_options(argc, (const char **)argv, "", imap_send_options, =
imap_send_usage, 0);
=20
+	if (opt_folder) {
+		free(server.folder);
+		server.folder =3D xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
=20
--=20
2.49.0.638.g5e24c6cde8

