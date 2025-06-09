Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011033.outbound.protection.outlook.com [52.103.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A4221F25
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500625; cv=fail; b=srPdjFPxEgQmYoU4ETqg5wM32/VoPS+ltcj11DU+pI0y76H6w814qctHgVH9uPMoPniGv2YYs4fU78TbwiJSJ9ZuTRxvO1qtbTd+smBrw2dYiebZs1KgL7iwcNknkTHENdY/a0XMQV0iG3Or8C9ZFCQbAZPPcDtlIUVOlQUOl/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500625; c=relaxed/simple;
	bh=zkWQSpkybpIpv3zO5KOh8Q8OQH+UJWbP6/KP+AngP2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qr1N8B3yPWGld72eaCcmAKqgTGkLbCWxbbSKu5tAC8Ft6QzqL6d3OO2SSv7NRqkElbu9nnRygzaKfDzzlJHlRoNfVihZQXh1yUhKduBlyBn/MGK8NIyhKwrN7y/E904MJtIBmCA9CZ5mp/hYqCxMtGB5BNxuVREZwX0f5rQ/8OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=GMWEelfM; arc=fail smtp.client-ip=52.103.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="GMWEelfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLIro1cc6xIHzAM8S8mrlRfOVM2dhx0ZmAl9crHLSmOImvhTt6otjmOpxeGEF3GsPh8RgmNgMTs1IdXPCJ2/Xiob/9o9Yi+QGIvVgMESabJEY9SqyUurvF3HEwTI6rkE+yEtIjXpS4NpYXlNSjWyKfw65EWsZP7f3F+okGDXOPz9s5FDGRbtjutAUiI+S2qFzOpUnyuwu04EVQk1b2aZ1pFp5j5EKvc5f3aYuF7H747+MW+rgcTna68HTQYYscl6/HqmMkOFxCK1DuNhx1HbMJw1bwqZf0Fl1vYWDGK96j4wAaJ+0y4ykS+Qs2NLgMBrfOJsksIyUGjGS+p1TZNO2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ohLV4ba9DkJA9bOcm9V3EDI50tNGG2NTL84BqS0FjNc=;
 b=Tn6nq6LNmt4y6fGQG8aJPqCyp2KY5C/u6JKavhjNopXsbnKFkr6tKeMjcEoj8fWxZazafTWfEAAgJtvHO916PN9V8i2GTwGQpSl4yFULW9bkpkGzOzWEBteVFBYE4Yj2+aHktDmA+qON2yX+VT0vjIQDXI4hyUhc7NKram5CE/QfFZ9rSY+5sUxvkla0PdXUuXe0371dRXRnMhIQfNrHmbjyRVZZrpj3I99bd1VmGd0443kf3k/DX5eUh/F4DhQ1wMKFvMs8959s6QDTypjIO7Wc6lWeac2PiWd0dlMN9GfQP0FaM+bjrXdQbXAUmp7UvNMoz7Yw0j8ECPvbfVk7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ohLV4ba9DkJA9bOcm9V3EDI50tNGG2NTL84BqS0FjNc=;
 b=GMWEelfMuoUHpnh9I6FA+DGL041xvoZC0fGHMosKmtEkXo7osAr2I5gIXD/OBfC6dJJIBQHM29ou178LOIBEh0Wu7qh2Zq+/OA8HABXklSEIZrvpDDWsgl87LO23fD7R6JhlMC4WW8F8wWEjmVl7OTeU2njt9OpgJH5G8CZt1M6OcPerqnT/XEyBbyE2dyBJ9ZDjxhbRCPGNYU7yr+ZbvmC5R97O6G5gMWFJUriKwKaiGUNwYfL6f24MVtlgSgi1fmyHEu+AYrIxf4neViTnn377lfZfn4czY45YHCp3ZifVedD/Qa40C/WIEDj3zwam0eGjICePhE+AbD9O3FtamA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:28 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:28 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 07/10] imap-send: add ability to list the available folders
Date: Mon,  9 Jun 2025 20:22:52 +0000
Message-ID:
 <PN3PR01MB9597427F9AE36ECE4C7FEF98B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9bc66a-30e7-4883-cf89-08dda7937e51
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|12121999007|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|4302099013|440099028|3412199025|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mUkUmBcnkyuBtSHT5rszdKrPvIHodilO+yz8tS/2yncPzIRN/Bmx/j2f+3KC?=
 =?us-ascii?Q?eBn+8ImOEMyt6hREKIQJgjJcoHfGrFdrLhAZCCaXFOATOwKO/lDGI4+C+dS/?=
 =?us-ascii?Q?MrJAVn+NlfRuU82tiF/MBZ0D+UfXbxwVasrlefUv8LKkWHiq6DaN35XRFlVg?=
 =?us-ascii?Q?9mvjeUwHL6CWnS/h/qwZMkBu28lLF8h9niWO4b61BYA6yAisCiuIQhuLNh3v?=
 =?us-ascii?Q?0QI/itwqvYUc2tiVcphlGjaWx1rvwZ1q298e6cNfWgCsFJJCAcszIVowSzXE?=
 =?us-ascii?Q?PvdYeFwBQZ62yfG47FY9JEHIufOa+UTGzSvoIizSOhaDyQyBklLWQ0QMLcEv?=
 =?us-ascii?Q?bqtDnsYjoV9wBqvY8KdTBbcVsNXBSIn9i4fYIpHuN17xCiTCChf5hIUvP/7a?=
 =?us-ascii?Q?ahaOluC+A1CsGI5TJHMQt/XnCv+8u/DQb5n+/ZNd8m94pZzfRATRCIbUbw1G?=
 =?us-ascii?Q?FQMBIHqz3wF+SZYNE6fX1ZJorsE9px2fyDtbf5M3/hQUuwLcslgB1r2X4zZO?=
 =?us-ascii?Q?CsbkwjvMG99rJ/MU9R7ZkrRbFt/539JDs6sBWKrMP2bxTWrnhZ8VLkiWg2+L?=
 =?us-ascii?Q?2yb0Hma4U9JklBO3846929PddirDdBqDYsGtazc9Fi73Tb1ftxUEsMaeDkEI?=
 =?us-ascii?Q?5jFtq2cWKS3ZvF8w0fj1D6rDCi5qcEnwQDgDAkxvS+A9UC+ECU5cb7M+DT/t?=
 =?us-ascii?Q?0Lp/k0APoWENEkUl1NCHPPo38o9CnU1+06Bw8REyVRw5g4ziNaCz7Y9atbRL?=
 =?us-ascii?Q?VA6DYCXv13LH8yrLxN3zjm5Hz7BgpiogDZ2s8K3r2Uvs3KK3DPu/F2w39SOc?=
 =?us-ascii?Q?kVgJaRGACP1POGuPhfHvmmrgfO71oBcxV/xQaMW2b0ypPj5oFs9BO1QoXTxE?=
 =?us-ascii?Q?msh0t197o+NWO4l8Unjhzol6OsPlTl6B1p3cOYM+FXmOsM5O6BacOCIfYzWL?=
 =?us-ascii?Q?mugsCxLJ56BdWhZ+4rRiTzPfAYkRVRIg5CY6EtIpGacOoqHCvx4lWn/Lq9Na?=
 =?us-ascii?Q?EXw+zteTGRVOK0MXPJhZGxgi0mTSuu08Dqbm+C0giK0u7yu4gt6exptArgXM?=
 =?us-ascii?Q?ywFJifCYi7Df0r1p4P/QyPnD4hqET/qzfvogVhQvHPyfMlzYK81k8FIIDzVg?=
 =?us-ascii?Q?oZh8BS3VUTdcUYZcy1tPKVBxWByV7NkrTq2JvN4374tEHvPwMkncTRsa+1Gw?=
 =?us-ascii?Q?dpLXURlK8CqE68Y1mYMqek/VJaqL3/PrQABw2FvUdZTSFuZUu9+dh23mglTE?=
 =?us-ascii?Q?wfMzxYx4N/TCQE1nd+jYFMqDnaC/ya89tOOqnshXoa8+JxJy5PN3d2cGOMly?=
 =?us-ascii?Q?Z0V5JnixaNyn80tqGP+Ot1wGt59fw3J5GYsNNUBxlebxN92eInBU8j787to6?=
 =?us-ascii?Q?8GrRZjI=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oseszzE+dBTWgw6ppv4/Bbxbl4bAhL/m/+Gfh6Ds44woqedY4FKYFH2opGeU?=
 =?us-ascii?Q?7EolWhaX4VpO0cLVyeeM9/ddspT9rIizGy2BJMbPRJ0Vpo2UnHR8I9cV3+Mm?=
 =?us-ascii?Q?iQiaKWzEEF064SOngQplF6iONFcGyzqt9kBkJ0STwK7CFRxcIRAOTKD+CmN/?=
 =?us-ascii?Q?LPUZQIzifSfBkJ7w1LkUdlP6HHawK15Uen01Gn6xUErK/p6v2BD23ZIYNhsU?=
 =?us-ascii?Q?oIlxQeLg/b1qWQFp6fUVm63emmWLB7uu3BSGfwACnw80dM4UmSURL+8RyBS+?=
 =?us-ascii?Q?JWTfpVaG4zvhFYKaqPRJGtf8JxXlXuPOElpPlFw27F0cHr02R0dUhOQZkyb0?=
 =?us-ascii?Q?wKI8rzLlumezMGBfV2D33L4McZ4Y3NmduTMZnB18KynOymuzYtp5FuQ6YwSh?=
 =?us-ascii?Q?aDpiTXJdlqQtiWd5TcoYoKSHk9TXSpYuJqEJvP+yax93crL9ChihOQTTzDVV?=
 =?us-ascii?Q?ct2zPTmXEPqYbZ43qPbgtajvx64jRNfSvZrhs/hkW4SU8kMU0lDwveAku3cP?=
 =?us-ascii?Q?khNhTpkosjWuF0hhIG3qqMWAYSR5luvDCarmwdab/c3nWszdtbm5yena9qxd?=
 =?us-ascii?Q?SfZBU+jY4hL86BFB7F0flY61UWYNkYY1LED8N1s2WVlChuBOyvCAO10HcOid?=
 =?us-ascii?Q?TPra12x02msbEZ7fgkzE1Z7d7OQoJ/s1c7emvY+bCZL9qpQLSYppSHHrHeno?=
 =?us-ascii?Q?fs3EsINMSUNf9hOzadX83LAfRZ15uUM4TEvaIqScFzrvvskJPoAM9Qi32iaq?=
 =?us-ascii?Q?av3iWbDYUJvgBIzari9uUEWBmKNrJjnJqDP47z00qaVizq+OAePdWdojK10E?=
 =?us-ascii?Q?tCCNptEd/GcUeVTARwMzkKQgg/GxZtel2QuQAUTH+amkwVkgycf2McNk9rue?=
 =?us-ascii?Q?JHq5biwUU8K3ggpIJxxqS1lAsJCB/QCMXOZ9Vc+yy8MA2QA3yjTxMCr0GLzL?=
 =?us-ascii?Q?WCJrFbn5JMUanLqAfHwHfJk5r/quYbAsDngHF//4A7i84R3Jagf8tcgF0nq1?=
 =?us-ascii?Q?pE8zjJj82xniA4aOGJ+w6rlmuQUusGXIgN64P88B7B4fdJpQUEdRHDQxRe4F?=
 =?us-ascii?Q?Qxo0XHxLvll283lZgX6x8UznHCjpgYz1mCrpDRskk/0Yr5JFX8coEG2+T87T?=
 =?us-ascii?Q?uW5q8GkX7YNbGK5RoBi9jD/QQyHSRsBoSdFJbw8ozD7pAreb6hQhxbjQaZER?=
 =?us-ascii?Q?zbctQzf8bI2o8ABhOPEpuA1yieNbsvpwFKRZivcPiKzPVWc5V30Pbcqk9cM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9bc66a-30e7-4883-cf89-08dda7937e51
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:27.9798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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

diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 4a0487b66e..17147f93c3 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -10,6 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
+'git imap-send' --list
 
 
 DESCRIPTION
@@ -54,6 +55,8 @@ OPTIONS
 	using libcurl.  Ignored if Git was built with the NO_OPENSSL option
 	set.
 
+--list::
+	Run the IMAP LIST command to output a list of all the folders present.
 
 CONFIGURATION
 -------------
@@ -123,7 +126,8 @@ it. Alternatively, use OAuth2.0 authentication as described below.
 
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
-that the "Folder doesn't exist".
+that the "Folder doesn't exist". You can also run `git imap-send --list` to get a
+list of available folders.
 
 [NOTE]
 If your Gmail account is set to another language than English, the name of the "Drafts"
diff --git a/imap-send.c b/imap-send.c
index be6412fe2d..77cf2b3da2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
 
 static int verbosity;
+static int list_folders;
 static int use_curl = USE_CURL_DEFAULT;
 static char *opt_folder;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
+static char const * const imap_send_usage[] = {
+	N_("git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>"),
+	"git imap-send --list",
+	NULL
+};
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
 	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
+	OPT_BOOL(0, "list", &list_folders, "list all folders on the IMAP server"),
 	OPT_END()
 };
 
@@ -429,7 +435,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] == '\n') {
 				b->buf[b->offset] = 0;  /* terminate the string */
 				b->offset += 2; /* next line */
-				if (0 < verbosity)
+				if ((0 < verbosity) || (list_folders && strstr(*s, "* LIST")))
 					puts(*s);
 				return 0;
 			}
@@ -1579,6 +1585,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	return 0;
 }
 
+static int list_imap_folders(struct imap_server_conf *server)
+{
+	struct imap_store *ctx = imap_open_store(server, "INBOX");
+	if (!ctx) {
+		fprintf(stderr, "failed to connect to IMAP server\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	/* Issue the LIST command and print the results */
+	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") != RESP_OK) {
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
 static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 {
@@ -1612,11 +1638,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
 
-	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
-	if (!uri_encoded_folder)
-		die("failed to encode server folder");
-	strbuf_addstr(&path, uri_encoded_folder);
-	curl_free(uri_encoded_folder);
+	if (!list_folders) {
+		uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
+		if (!uri_encoded_folder)
+			die("failed to encode server folder");
+		strbuf_addstr(&path, uri_encoded_folder);
+		curl_free(uri_encoded_folder);
+	}
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
@@ -1647,10 +1675,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1669,6 +1693,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "sending %d message%s\n", total, (total != 1) ? "s" : "");
@@ -1714,6 +1742,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
 	return res != CURLE_OK;
 }
+
+static int curl_list_imap_folders(struct imap_server_conf *server)
+{
+	CURL *curl;
+	CURLcode res = CURLE_OK;
+	struct credential cred = CREDENTIAL_INIT;
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	curl = setup_curl(server, &cred);
+	res = curl_easy_perform(curl);
+
+	curl_easy_cleanup(curl);
+	curl_global_cleanup();
+
+	if (cred.username) {
+		if (res == CURLE_OK)
+			credential_approve(the_repository, &cred);
+		else if (res == CURLE_LOGIN_DENIED)
+			credential_reject(the_repository, &cred);
+	}
+
+	credential_clear(&cred);
+
+	return res != CURLE_OK;
+}
 #endif
 
 int cmd_main(int argc, const char **argv)
@@ -1754,11 +1807,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-	if (!server.folder) {
-		fprintf(stderr, "no imap store specified\n");
-		ret = 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "no imap host specified\n");
@@ -1768,6 +1816,24 @@ int cmd_main(int argc, const char **argv)
 		server.host = xstrdup("tunnel");
 	}
 
+	if (list_folders) {
+		if (server.tunnel)
+			ret = list_imap_folders(&server);
+#ifdef USE_CURL_FOR_IMAP_SEND
+		else if (use_curl)
+			ret = curl_list_imap_folders(&server);
+#endif
+		else
+			ret = list_imap_folders(&server);
+		goto out;
+	}
+
+	if (!server.folder) {
+		fprintf(stderr, "no imap store specified\n");
+		ret = 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("could not read from stdin"));
-- 
2.49.0

