Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435420A5F1
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112955; cv=fail; b=RGg2ffWbEddGw5LdqT2gQtfxbxNX/QpZmZHUlvC0oyLl4PRlpOt6bZLk6MxWqB48IP2PRVAoaIWnrsHR0oO4H99qeDOYS/ZWi40x4+njcH5bceoBfS9R0Aq2/vcXoprmKGLZa4PCxcgc6QeVZyaFtyipABCKurfBX6Fe1pRwXcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112955; c=relaxed/simple;
	bh=sEm/aJHQ0/dZI7BWLvzKgvTKJ4BszVZAM+GhKn5fMX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E21wgP99C3rcGSSjhoXfr4fVYmue0TdtbgB2PXYI7gbEfQbbnblqWsjyho1I5plvrsgNDdNCmkU574ib8654rd5uCynMQ8krSBS8eVJq4zlTbcCvEQzqtmOS50iWRkZ/MZSh2U/WzAW+wCg9rwlIIlAM38L3HXTm/rmyatUJex0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=UbY++xHx; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="UbY++xHx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tz+LW+X4NPATRWo/SIozoC2htE8dTz4oAmyXzrn6xYxwHvCMCbPnslbNydz98jJX/pnaIozF62sV0WPMGZyPU2c6Ux+Q1JnxT94WdNmPOBuueDQiZE/4rRSkHaRFccJA+xUOlf3v+HmUwQIBTOkcwaUfUBwhgrKacHzmysEVo7mzA6hX5G+zdCXIOHDG3H6xUpgQLwsvUt6gewjLaNHbrZ6lbrVlxt2V5aseZiUwJ2ty+T93TAqMrPpNP4iHqFZq2G/O2SbSz+EDZlpd0kQ7vnF9xYFIDPysx7rePOXmwv00q2rsPHoTbTRIvDKRiwV0LaElsqqR1bvsZ1GqK7t7/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3cwybDf/wM72xuISBL5gqk//LgFqBAAJTyd/me9/T7A=;
 b=yH+CkqnOW0F5xPYvNKqRGx5zSSQyoVALHz2W0skG4hXmX+3DLkUMRfKsh0h7JmmXjxEDc/x6PLa2Csu/GBMoRlOyhfOHYuycmkcyagmUa9KTFk/2pwlNSbvYmuRGZFn/6H2yjPF3uO0wtpnyCjLp+dZi6zq+L6eG5NzWgZiCY6xk8c9JmAoHeqWZPti2UJZelDS+7yAeH2rBr3ip83Rjjkw0b2KiXTqJfJn9pZInuhNr1gLJYMXMkw6JBRsG6E2IZTihg0u+cKFXMoQSHuPZSVxH42jbvA0otrV6mALFsf9NaPFgh5SltphHkhgtKiqCBwZ4qqjwGoNC/MMBqJZ8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3cwybDf/wM72xuISBL5gqk//LgFqBAAJTyd/me9/T7A=;
 b=UbY++xHxBTNXhMbun3pV9oPg9dHyCAVb4+cw9A/fe84bCYyRrVYmtZuHwXF+miVyTxN0wxR44nEL/cn7aRernjn1So3FQyc0+PFE+QtDajJNhOqYAfUw179Qi5AZiP2Dm5JnLgxeBKVa2UHI4+JiSyRMcIGSaeyXC9lf2IkimEib58I9q/x/d5caVmyqnRiet2nuKfRTgyhpBRn4rMpIzA4BL0Ypn98Cuon0dSrSD7IuXS5eUeuNTknHL63dOvU/kWrFaNlxtx6aUae0Qu27pQTbYHyhnc6JQFNa3qVSiDEPhiY7ykw84YgoYjz28i3Uzeu3kIW2B70h/a5HiwMPaA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 06/10] imap-send: enable specifying the folder using the
 command line
Thread-Topic: [PATCH v13 06/10] imap-send: enable specifying the folder using
 the command line
Thread-Index: AQHb1fXENUO2a13k1UKRmQ2HHk7IGA==
Date: Thu, 5 Jun 2025 08:42:28 +0000
Message-ID:
 <f12713f24b00799c65546900ff501134ad24a807.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7773:EE_
x-ms-office365-filtering-correlation-id: a4ddad49-6f5f-4cad-5e62-08dda40ce78d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|7092599006|15080799009|8062599006|19110799006|8022599003|8060799009|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?FUJGX7rwzqrxE93P0Co0taaEf08yVRjc56zhx9T/DfbAzNBJjnP40qwawo?=
 =?iso-8859-1?Q?1irf/7pMWJoY/w4Q5XVjiQAb88qtAoa2mwr2RLNs+I6AoR2xTZoc0POaDc?=
 =?iso-8859-1?Q?toUUz/fuqUer+qlHtfGZbwf6ERaDInmhZqCvTIsgam6x/lT4IBIm5LxNie?=
 =?iso-8859-1?Q?YSCL089ZYmhnQU4rZPS4DlmxahRepSk1TLZSNbrPcobcAskxlweEr8ZKpg?=
 =?iso-8859-1?Q?dCUpcIUZe0tjDulpwrMACJ+9a/9g5a6f7BOx7supzf7LrInT8IhJ0bNk60?=
 =?iso-8859-1?Q?wtCUMiCaxNOWE6ym7jh66kGL4djS4qhHkQ12gaySGtJJOlMCMCwCuv6Kv6?=
 =?iso-8859-1?Q?chWncQirYX0LEJpTmkLejkcjf+ZJprpRZDJgq8J/oq+ixPMAaMzbXKvccT?=
 =?iso-8859-1?Q?D8kqYVk8t7JVBxho6Ko8CGLxe45v6x8E4TU+Ajpx8i4Z4C2BaV78Eq1KzU?=
 =?iso-8859-1?Q?PbCHQeW93W1xafoMRwMFp+J5i71PoYzqx71XLWEXWXnIHvooJvTNCDC9wK?=
 =?iso-8859-1?Q?uXmYvjs7Esylkavl1gX25wWi3hK7kdEqI5fomHDSJnDQ6/6hTTVXZMSGJc?=
 =?iso-8859-1?Q?HkTdOcEyY5eZ33BzM7wxxwqVhlq0HV+SXfCdGSQUenBvBQc0viJ5iCMMsY?=
 =?iso-8859-1?Q?qiDUpSPMnqmPNTupQQVexURrHph9BPJ9Wm5tmoOH1nLIgwwWHyYl9rIb5B?=
 =?iso-8859-1?Q?pKxeO5xRQp89OHLVeirRUvnayNZJnddqL1FQshbROVkGzOS/7F2cjUAgzz?=
 =?iso-8859-1?Q?37c0cy5q9i1wp1KO8R73yt81dyIKVZKOLTYHxsdEuz/iwP7lb6tk8OQmQZ?=
 =?iso-8859-1?Q?PfbS3BeV2EFXCYbONinwxi12QmbNALr+pUlRWM2O9+ZdhqgfJgO17px/cE?=
 =?iso-8859-1?Q?+96c0a0vbHswWxo97wFInayfOoQNYnfkWmqZJfUcE428ns0wtgPrSBjE3L?=
 =?iso-8859-1?Q?isze3foN45jdPUnM7vA7Js9YdSRJfd0MVL2YiLGkk8qPihUcs78PHVCkaO?=
 =?iso-8859-1?Q?b97rByLsfz6ve7CN+BKKjKCA69r8diNtoBQAChHtH/gze4n19afZ+jC70V?=
 =?iso-8859-1?Q?mqluFARFiVThaUxASe5SxdW+NzCqTjlhPa07v6+/M7PPDXMDFk/+RiAj9x?=
 =?iso-8859-1?Q?L0JpeBt13CeD/qkdBa8JjJMXDNNxxdhm/+ofOohYnMbxLC7vbs49iKkXr9?=
 =?iso-8859-1?Q?g3NSRD0wSlBYnQBQHHHYrBP+guxSPcufifE259fq8tTQJ/yqMaqJAIj60Q?=
 =?iso-8859-1?Q?PF5hvxJ/UDkxWfKdU3fg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5yKGc92LmLZ6QuJ8VLmnF2vawNSmvtLC3TmzUTA7Khz42dzkQBIYWcRKy8?=
 =?iso-8859-1?Q?sQSGb5mLzptz/s7x4xQbjXsTvQ+dGzwGSlKBBZ/u4O4HixB0e3/J3Voaxf?=
 =?iso-8859-1?Q?7Knv2uocbGcWAJYrzIefhRvU7LeVNTrteR2jFOochFX/AiBGgG3n6Zefef?=
 =?iso-8859-1?Q?kpikhEeoePbIF3Ueqtgxewd4pDbxwleVfegigAobheK391XeoAU5ieKeCH?=
 =?iso-8859-1?Q?wBtDazsPJ3+uP5pPmZ/T3ZxrO9xTD7QPqtVQZEiyLQT+5YmlBSJ/ipOYF4?=
 =?iso-8859-1?Q?ocAMsfIMI64qvawefY/HFNYUcPzIGH2k8x6g4kQxaBmd1r3PgGZMZD5g2D?=
 =?iso-8859-1?Q?oK62xsn6A2YX9/7zeN/CQyKPE2caofhYkeA7tm08I0Ff7/RAAhVICx6FPo?=
 =?iso-8859-1?Q?KuVtlxI2+RfV5mcL1Gwjz3+bOTzNCU8szk0vSUoOLw1rjT7iz3KoB4EjC0?=
 =?iso-8859-1?Q?alsPkrXd8KUFe+MyjuqiTOJOr1/ypkvTLe35ehmhITjYKx5nfVux8OxfY9?=
 =?iso-8859-1?Q?NkTFyF0ay/N0dyG7Sa812OtaiTy168tVterYvUwrG2LwOf+M1y9I3O2JGI?=
 =?iso-8859-1?Q?Orm0OD7F+9I+ko2L9ykTPKbtmNXz1ZQDtdRnkwC1LgKXM8SknDfHZK/kO6?=
 =?iso-8859-1?Q?MaNKSldwff5g6roaR9JjEgYMzoWKbEUwHKMLKPFm+z2Z1GGkAGKLYU4ltF?=
 =?iso-8859-1?Q?rNAM3in0fNvAl0TXn6GdwY69Iw4l2Erf0AlWwUqogYi3eSRWMUGpJ7p/ev?=
 =?iso-8859-1?Q?0BbMJD/mk7niDFPWyRqwB/ZM1W9kcRwoia6d7ErWzdcKPWCM17RTMJglp2?=
 =?iso-8859-1?Q?AotS0EpKAXjdOZ93WMVdf2+hYm7AiIRdM40U4nc3NwDRJDHYZU7xzPcrTG?=
 =?iso-8859-1?Q?2LKpOWFHp348OTAYhjhytL5h6AYhyzuqqWg644yOv+1xn3Y1IoBG41VLjz?=
 =?iso-8859-1?Q?9P/nObizqdtTb6pGQ4HxtCAlx/sdAxQTmjSBerIJiO6WuaPuKZA3aX/6Pp?=
 =?iso-8859-1?Q?2/J/wAkxsDbveqJm+25xM3M8/jPeOiUVsB0LHJRRUMknYJLKgCE+Ji5tmA?=
 =?iso-8859-1?Q?QzAIDvecbIzJoXBaxVrw7na55XVgzPkXa56NWZZyxqF+7f046ZxA+BVUaS?=
 =?iso-8859-1?Q?Jx0iCXpXbck7Oj9M2OrPGxkixQDIyWWteFpyu5QPBrjeh/41SHfCSbNJM7?=
 =?iso-8859-1?Q?WS+f2PzfpghI6g5kNLX1Q30CRyNCx77wAZo8diRiw/zLb3iGZP8/xqw2DP?=
 =?iso-8859-1?Q?CKRwYYQ7TIyvrCtqfKlF+qD2m6Xs55d1npny2ET/s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ddad49-6f5f-4cad-5e62-08dda40ce78d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:28.5722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7773

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  6 ++++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.ado=
c
index 7c8b2dcce4..4682a6bd03 100644
--- a/Documentation/config/imap.adoc
+++ b/Documentation/config/imap.adoc
@@ -1,7 +1,9 @@
 imap.folder::
 	The folder to drop the mails into, which is typically the Drafts
-	folder. For example: "INBOX.Drafts", "INBOX/Drafts" or
-	"[Gmail]/Drafts". Required.
+	folder. For example: `INBOX.Drafts`, `INBOX/Drafts` or
+	`[Gmail]/Drafts`. The IMAP folder to interact with MUST be specified;
+	the value of this configuration variable is used as the fallback
+	default value when the `--folder` option is not given.
=20
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send=
.adoc
index 8adf0e5aac..4a0487b66e 100644
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
+in which emails have the fields `From`, `Date`, and `Subject` in
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
index 6c7175ced0..0e51bf2b85 100644
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
@@ -1770,6 +1772,11 @@ int cmd_main(int argc, const char **argv)
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
2.49.0.639.gf77f2423e1

