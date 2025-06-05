Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010004.outbound.protection.outlook.com [52.103.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F321507F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 08:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749112964; cv=fail; b=bwI2zAnEsuFdej+IxNy6EbgCZi+gDDFFsPAfbfncGWIJ1X1h1x9DmxL5YeT0TCssfGzvLk7x2BowGr0xpSSTgyAcqSoVt9I2MhPdghvl3oSXjHlKX0sG+5wqbHcRFRwjt0WGPn3hBDTkkyiftMExWmsdcD3WozzTR59c9b33R4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749112964; c=relaxed/simple;
	bh=3Eile5SUNlM5ctgbM644SGlJtX9sGbrBOTawHpKquI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KmbET8i96l4jSHyz6oRuc8+DU7YRLAdpNkwxASSFCnCNqirleUA8hra1gdzkjMG/uoI6NvJcPvvYxiqcDfPJ2oQZwXvIAG4+4Fm9m9GoHk/PPA+NeN4FtcqRXko8EmgZEmEB1oHjYwam5coehV3zVnqA4uBMjnCECZbYxa/A2zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hJ3PF88/; arc=fail smtp.client-ip=52.103.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hJ3PF88/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=po3YJMO7y7Rwqlv7Wq7vAga/H0+FfFLj5EzEGJP0/kcfXCaqLIojUFKHk5nDqWMzH8mMEc6HnKTVRQPet2VS+agxaAjxypPV3JqYzXtyfY1y17mOopL/7UrNr6K9VqnkxFb6sZMAwRyTkMATVPrrcO0T8D0i5ATRTR4v2QNfpa7GKkJpR5ysIk6AwqmaN6vCSM/2ZW2O+DzSZPi/V6XHKvbuVP874GAzyPchsxRvZl0qb96zgWQDbFRBfCBAFOeYYzgRegOId8zyj983Q2g5HphHg2rFtuMn2UixY5Kcf80cXPHhbneYB8lwoQzO8xuXd8nbiBXHeRLhqzVw1RBmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i54K02m2flCcBeG7Y5WsQD8JH2wFxTENmXvBj070C3Q=;
 b=IcoHDEL6cdAdFeAS374lzaDrTG7N1BpdC0Zpbb4epooAXAsZOWKqs0LYL0fzE4XQ/VB+DZ0Ey3YbKxerR0eZl/f40a6INbs3oEGFqi8lSNLgtdjQVpsm4y1PWxDP4NfRGg5/t76ldOFut/mrWQAbiaOvDQ4TrjR4iCGsIOS/YB17gCqVDVpLyhEgyH7QzFqQLlkCJXJwpI/yNuNFPhWo4q67dWqA8QnZeVwA2TxjlBRBz/yNY/TqtwtLpqNDhBlnP3n3xDxLMRQNP1bTJHb66sebKgxy2GCSUQ/1kj/3Z9+vnEAKZJ7cO5ppDqVyKsRheiObGSjmlVOVp/BfiSorIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i54K02m2flCcBeG7Y5WsQD8JH2wFxTENmXvBj070C3Q=;
 b=hJ3PF88/QIqqf2lMpETthxopes9SoowZmi5Q7ooPISQwFtUO9mFfSSFOIFKOQmyBkalLRQ4pCXK7twBMcoDUw0KyCP440nAZljz6/9ILuPMT7c/zuR24YDexqA+fIMm6SyQfWyh16XgVdlV3EmrZ3Fuu0tW2W6WagiCcAVTM+6ThGdp6aHCXvSe3dnA/n6JqFke1O7/NU+farUOLn/unBfvVWgL65UL9ul5SaA0Yt1oxl7+CQMR2/t/66ttYMTr34hOqI/H8PBQ5yPCHbvuMaSxTsePpoDgYvmRelOXXwBzdOYXWCjTFuEFA4c/YHnZ0sBwDCiCVWTD+62WbCwVvJw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PR01MB7773.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Thu, 5 Jun
 2025 08:42:32 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.020; Thu, 5 Jun 2025
 08:42:32 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>, "git@vger.kernel.org"
	<git@vger.kernel.org>
CC: Eric Sunshine <sunshine@sunshineco.com>, Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>, Jeff King
	<peff@peff.net>, Ben Knoble <ben.knoble@gmail.com>, Phillip Wood
	<phillip.wood123@gmail.com>
Subject: [PATCH v13 10/10] imap-send: add ability to list the available
 folders
Thread-Topic: [PATCH v13 10/10] imap-send: add ability to list the available
 folders
Thread-Index: AQHb1fXG/pH5Cr6B40yKFBTRh7/d8A==
Date: Thu, 5 Jun 2025 08:42:31 +0000
Message-ID:
 <f77f2423e1153fe92e927df53bd12d983ec7fe3c.1749112640.git.gargaditya08@live.com>
References: <cover.1749112640.git.gargaditya08@live.com>
In-Reply-To: <cover.1749112640.git.gargaditya08@live.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3PR01MB9597:EE_|PN3PR01MB7773:EE_
x-ms-office365-filtering-correlation-id: 3499e0d3-3f4a-45a9-ecee-08dda40ce97d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|38102599003|41001999006|7092599006|12121999007|15080799009|8062599006|19110799006|8060799009|1602099012|3412199025|4302099013|440099028|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OBGMQe8fLjWz36IyPLZxf8eJVGparVGLi8/v0+elIT2Kl6FDyJxEwkGtIz?=
 =?iso-8859-1?Q?dnfQv0EgwtWrwwQDgUnIEuWzMU/5nd3AYDhgUQxVmGLFIoYUGcaUPY5Pgy?=
 =?iso-8859-1?Q?0qX/znqC8Z5H86RP5fK3uigWGY35I8Tx4DWTetqxQ3ByxEc0EOv5SA5A47?=
 =?iso-8859-1?Q?pjCXGcop8n71ZWLqvKkObEYMVdbuKz0rkxJdLlgxmjZe/WpqIvCvUhV5kz?=
 =?iso-8859-1?Q?Z+d6kfrkTnXK0T/hAtKffvVUZJgoAm+HVxjBLlak0uaHqc6HMtAlpyjckS?=
 =?iso-8859-1?Q?ctvOFT9LZl64YVmS0Tpzt1DTVAjwFum4fh9A8U43ei1Lkf8OEUk3ywVRGr?=
 =?iso-8859-1?Q?GCHanUYFXudSHTweZkZlcNWjVl3V8lEHBFN6+ndG6/5WrB0MsswF57l0ME?=
 =?iso-8859-1?Q?X5lL9ioT3S4ufXYopwmbogfYo4UeXP057FXoD8aGWip8zzIIqPknPzua/z?=
 =?iso-8859-1?Q?YQW4+EVulfPvuopIz0uMF49owiqh7PGwmzXdqQ6ywcvm8H/PQkM29iNXyI?=
 =?iso-8859-1?Q?DiXS887DYym/chr4KDUqaooys1gx+LKxev+7tVanZWEVVqdLyQvlxR7yri?=
 =?iso-8859-1?Q?9GMPOm5+/i4GOCZcAyqKPMomdYWCBinko9OzvnKROnKZeUW5K8GWbvdqc1?=
 =?iso-8859-1?Q?h/tbaqT/L4caziVsVAGTAWOuVKndkTNJ2bV6xymY2wM+q5gBxjg+QrInkb?=
 =?iso-8859-1?Q?Tp9hXb9BnXxPchc3djd4Z9av/E6b/aRRQqmijJz0ve5ANQfs+0jDHl5HtP?=
 =?iso-8859-1?Q?kzWoVHCzoTXEtwziGb4iiFqVANw2gBd4ver636h5tebz0db+/BnUzJkKXe?=
 =?iso-8859-1?Q?gjwNr3RbolgCOv+0dVW0u7B1BHgCN9IJ+PYjmdktrs4Q/W9t/YVty+nhlE?=
 =?iso-8859-1?Q?m7ZGzJOjiJNe2i2H2r0iHmWIL6Oy826GwVI39Vc651LkFUW7f8GaZMIvnJ?=
 =?iso-8859-1?Q?C/R9fxfmvRUcLXXPSjlg7rhgjz4fLtyP+DCJ5wS7iFarhqXTmARCJGztri?=
 =?iso-8859-1?Q?AKO7UyQqAGlKGeMbVW7QYzEIN8MV7BdJO2NJBYZ+cX3UfT39/GRF612mDW?=
 =?iso-8859-1?Q?rzJeYpofasZuIJXnThIEIevdNlSXY72f0IKvegiZs+v6AKCVDx98iRjCOs?=
 =?iso-8859-1?Q?ihF1My0Uo7Iy2dUc5Iihd11R78IRS8guQbuzBzUpCf64AdlymIge6V8E8F?=
 =?iso-8859-1?Q?fVk/MN1lHb64YiiGIVDtn5jAWTqhxIsf9TiWPJ3L8V6FJzlPv1ETBSZP9E?=
 =?iso-8859-1?Q?gzeKkb29LqnPBsZuOy1K7rRrr0OjMjn9gubWbg2hxM+UUnbaI/MN+kRY3M?=
 =?iso-8859-1?Q?eiEBB9pLVQDqJ+k9olUrmO6mjK2igzZXlpFFH+DluNx/vJSNzQ91C8ZZUg?=
 =?iso-8859-1?Q?9p+TDjkFu84u1XMAWraUKy2O7Tu5VtZo9L+8wjI2ntVSNRNl79aQ0=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?p+4pNgkoLCa7Khog+rTjw5i+6edt3dwOnKFeP47H8GZZbyPzdzAQLkx4eQ?=
 =?iso-8859-1?Q?rE1O56NW9Od0XgARhSAnuK53PtxYFNITIAE6++yUdJVQM1BawOkfT+MFSg?=
 =?iso-8859-1?Q?65h3O7Y9rhvMsQrHPFcf0383WjBJJmpO/WvpQSyFRQVp6y7e0zlivCIql7?=
 =?iso-8859-1?Q?8q5dFnyoS3FQr+hchKzvbGMlZGnl2qn4idhlcIFDsblUwrt6iWaqdzLBqR?=
 =?iso-8859-1?Q?PbWWp4YOJNEoA7cmlvZusRYzScQO+ADVZ5D9SFWZ8F/yNq33AGpPdaJ1QB?=
 =?iso-8859-1?Q?McDMO0fIRhM2u7GLp5S3z7MJo8pCBZl9dxB8pRp/QcbyU+UNkeLTP2Ddo1?=
 =?iso-8859-1?Q?fKS7oavpgf5vbOIYXcN1x64smEd6ZcwiipsVpldm1WmEtB91O+JjPhRdtN?=
 =?iso-8859-1?Q?ZXuQPbXV9qTJwVMHoS/v/0WXHLEYcY68BZ/iK0ApbdhJe8mqvMvThxnOi2?=
 =?iso-8859-1?Q?M4rGBjo5h5p783JKJfgxU0Jg3Bl2afKclBljse+pIAJGCbNtMofZq5ujjW?=
 =?iso-8859-1?Q?wEjxttEdFeIxY7fT5ZfuUoFC92bOINF/+ZHT78GupFbiMy3CwpmbyWEuFS?=
 =?iso-8859-1?Q?ahnrrDM+tTA0E1bkNBzyL2SPelb1IQTF5bI4Ux6HVY5Si0gxq0vcbtF5Yt?=
 =?iso-8859-1?Q?8Z/Qr870814GtbNW7tn794lTtJRn0JqZO3Ibj8+WmbTxKyo4yTZro18Qk7?=
 =?iso-8859-1?Q?fu5roqZf6iaj+B/dkduvRxC16uHM0OxHg5EBcMR+Ft5myjGjQlwuvvd76Y?=
 =?iso-8859-1?Q?JxQ0EHdp7nP+l3yd4fTi/diXZYR5/yd9YTEASL6KdfQfuI1egJqq/BlhCj?=
 =?iso-8859-1?Q?6zT50be/ymVE+XWzYhKAH3iTfJWNQo/Sd3PEnsgQdkS+PBmk/x1YyDcjMb?=
 =?iso-8859-1?Q?OkSB8tutkoLpSgKFmRGrL8SukdMwLSbqu7zHzP3wk98nYyB37W4lAjgtr2?=
 =?iso-8859-1?Q?C2Ae9gZ01yVK7pp1JrFce6NDRXXsdWWPCDhbiEOGIwd4eD+IyWQmmaLqHC?=
 =?iso-8859-1?Q?oPYg9UzljKxE4aeSiJxQYbLCXvvX9phCASWRoxuu+Emhf7Ac4vL1fLcdGD?=
 =?iso-8859-1?Q?baWFteP2ex/f/1ICmfk/SPEpB+u//jrHCYbwZKSSLdq5JIcuKjrx0BBgSG?=
 =?iso-8859-1?Q?iKsIMEQUs/a6JLOQ52YG8xMtpJfM4Tvogmx8ALlCSPu2jTr4GDxlDnrmCr?=
 =?iso-8859-1?Q?G0AWtds/phYKn869MeEQbOyleLpeAmRDkyQj1R5ChtJE/Fc3Mz4/MNGq/V?=
 =?iso-8859-1?Q?VAOxnukbwEDEzivnKhga9ELpqhMdlx3fh1UNstoIk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3499e0d3-3f4a-45a9-ecee-08dda40ce97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 08:42:31.9777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB7773

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
index 4a0487b66e..17147f93c3 100644
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
@@ -123,7 +126,8 @@ it. Alternatively, use OAuth2.0 authentication as descr=
ibed below.
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
index 3ad916c6da..910e0ea133 100644
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
@@ -1626,6 +1632,26 @@ static int append_msgs_to_imap(struct imap_server_co=
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
@@ -1654,11 +1680,13 @@ static CURL *setup_curl(struct imap_server_conf *sr=
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
@@ -1689,10 +1717,6 @@ static CURL *setup_curl(struct imap_server_conf *srv=
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
@@ -1711,6 +1735,10 @@ static int curl_append_msgs_to_imap(struct imap_serv=
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
@@ -1757,6 +1785,31 @@ static int curl_append_msgs_to_imap(struct imap_serv=
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
@@ -1797,11 +1850,6 @@ int cmd_main(int argc, const char **argv)
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
@@ -1811,6 +1859,24 @@ int cmd_main(int argc, const char **argv)
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
2.49.0.639.gf77f2423e1

