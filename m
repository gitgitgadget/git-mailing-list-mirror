Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D0A221D8B
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500622; cv=fail; b=QqKejSKpUDjhRw6FaRAlwYF08g/MgK8eU6XCGydBiUb2/zrh/0SaRYj5gftkPseXzHyENuxaTIysszxlsdqJASO9yP4r7/SKAPhoJ1oX3jd8KtkLG620GLlvpV8XfTSwYcRGe1zGLBY62GnyRVowISiW3WD7s512aRVkJLUwllU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500622; c=relaxed/simple;
	bh=14KnSMPRCX6r2YvLSVmCDLmGF6sSIyb7yh2xRSCN2yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hRHlO/JkhXhzUgawPf5poNrwxeiVY70WVO3sIqK6Cilz3tx5iIjtehrCXtb1xHwK+u9F+W+8orKx07WnqQdmaR17in4ZSZANesW0j4mkARW6xA72Ix9c3UrUAQOL/Q9364576//J3RDvPTFvQeog184p9+w7sSzkUaI7b/ihc1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CGOknDBv; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CGOknDBv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHVcH1b3rl/Tt3SJeev6oLmX3yjBwb1pyB2B6RREI8WQ039y7KWwpmjMZVb538FRPRD9mp/uJtKHghaho2qG8EPE0GnbhjcwZX7pn3SYVj++YUopv7AAS22AP7jLrIrc6KCXEjb0/+/6FtggL+4pbwxdULyyxG+7EfuPHjP3SuxOMRY5rnJ1IQAbnbkUxUcoareitERQroBix9cfdxtJQyscr2sVjFrUT/sZJe2FzXzYBLWzXNa+2eRPLjAz6jNasuHx5gDbMbIoQGdpkUdsjeM7SFfAUPIYSUUzYPZE2jxZPLv/Hl7pDho2Xq7nqO3Ix0dq1Hj/eiNpdoywidzAXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nP7Kbsmr9f91UkYTaUlw6QDx3OWOce9hYQK5dHsteVc=;
 b=MOYKcmLas0HThTUKt0O0mNABL9uRVehod/7RW0/L+UQktGXq1HA91F6K01Y2tjIiCcfNBXpYFJYhvY4rnoRyZqGDqW00NrnbwH9DSQr/emvTmVISB/SYmM2twyBHp11T2SfKcDHzbxm27lwxgCIf0tR8dGp+Wx5pM7Xv3r48kc1YaSJboC7ISZS7wlpc3tym80316vVJOs8j8pYkMo689/PicsI1TsT+hQp/wjY2tFBmkVAPwSBNKCZtxMj2H8zknfaQRA96+kL+WDmSA+bXL9+NDVXBC0wGB0GGnzA77UQgZXHa1DPUj5sQMa2VecXTNAw+qYhnJGWrUIU3tTyt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nP7Kbsmr9f91UkYTaUlw6QDx3OWOce9hYQK5dHsteVc=;
 b=CGOknDBvTLNvK5ByBb4ZDTsVhgmxSvPxOEyhM0O5uom3X/Q1Oft0jIHEpf5bDx9Gp4dz0S5Xz4gOgBx1yIo/DxuyFqFYbkiLJSnZTbbymOKiKdzF7fLE5jlGpPReSLdqRcfc8onyTLuyod6+dSqzVry6MA2sQ6DTwhwpgA9df28QadvP2CdzIBa1+gRdLRAmN4hedKt3/m7AYIFq2f4YvRZRDXDOghLxTUVb37ar5CiMBw69PmSVTVM6VCqpXp5kkRMwCOL9NJhpUKZv2kQVnU3Phn7LV4hNRNO+t8KSvRyHY9XXiKztnADK6VbxlEdySTy5K9z28y5Zmhojtbqkzw==
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
Subject: [PATCH v18 06/10] imap-send: enable specifying the folder using the command line
Date: Mon,  9 Jun 2025 20:22:51 +0000
Message-ID:
 <PN3PR01MB9597FE80DA7E0B4AC8928A08B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a2cdd0-a746-460a-f24d-08dda7937e2d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XCZeEOd0HNaBQYzCWhqiW9wg22wZOVPBz22pPBwGsZpDeGCxVnDdAAXXfBe+?=
 =?us-ascii?Q?7xDedq6iavuAdnOS1hIO99SZeG53MilBMWRe5LxUWOB7PYTBfG4dJhWvagD6?=
 =?us-ascii?Q?Vvc0UkPA7hBVchUAP3odCbaVSECXnTU6sVlhzy+lTFlO9Sx6IeMuwFxbEYwY?=
 =?us-ascii?Q?pHcYSQNkchUw5Kg6b0N0F01iYrOLemrEUtRLlDOM2R1inYxLcWGXTkLLbQ/6?=
 =?us-ascii?Q?E+PK8eR77uGjzCnUVxV+QzWaaKlFhVABxtbTcJtqZNeNUMFs+vX4NKSX617V?=
 =?us-ascii?Q?7aFvMW9boQXbbzKOTXVyGw1K+V6fvEK3kTs6etwWXiykfquseGWzXHO/QHr8?=
 =?us-ascii?Q?sPhDiXZK7THwLc0vDAoAb7DiM4OxlGQKOCuWcJGVnDKvtAcMR/W+O8fZbDvm?=
 =?us-ascii?Q?8TzQifASwruG/bVp39JybaeDaXT6wZova+mKj56+jgG8mcyD4ritbTCD9l+d?=
 =?us-ascii?Q?gfM+yeePa1qcAbeczBNIUbW38GLLg2wjxtloU4r/gBGrbiZWBDVZYnlwdWbd?=
 =?us-ascii?Q?q6Zp8cbItoHQApveEvm5Wz7Q5n+24s9RAPjEr9UwDGhcoDWwV7VSmGOxUqgN?=
 =?us-ascii?Q?eQQ05W4w07qyTGmgFNMiO6Ro79NFsRXAQ22Xml+N6ILPHtc0Q8Ak/t6EpiwF?=
 =?us-ascii?Q?5cWMVqJiqznf9VKpFFJal3U45CyY4ZBs0QgCsrj8vKAzLGkXuX1rW3Sf1fxq?=
 =?us-ascii?Q?U39eP18TH01DQ/EsDYkwJs6hKzsKw6zGS/dRVchr1mNU2BAsKTnY/ot2ckCY?=
 =?us-ascii?Q?8oNRIjOajJJDEGT6FuZDB7CRdAW6bWGszWLdgvx1714VL8nopIOsSk2TkMeC?=
 =?us-ascii?Q?2g4R0zSVPnCQdEyVUigeJdI8KyMsti7CZ9BCgs0l7LQNATQTxV+YxYN1VCyY?=
 =?us-ascii?Q?ThLXteTLqAekHIbrp1scDRz1EtRUDvGPei+L+xyRCTP74wqc5n3dcJvcsAmY?=
 =?us-ascii?Q?kwmXVd2yFRD22J0WLJcVccPsgL7fU7ptscsweCjbOnkWq9QjK9xomnRmVcjx?=
 =?us-ascii?Q?M2qGhXzv2BCLItslsq+HPzHNvalOAiafc+fUTSVBnZ63WN+p1p/1uyJCxrT5?=
 =?us-ascii?Q?6dHJpFeL6QWLiOO8NbZpmt0x9G+GLNu3eYZ7zUOIJDbXSr2V7ta46S95kkKm?=
 =?us-ascii?Q?z5vJkqtpemDXskMLhem/iVonXHVJaLiHOSK2+sgFwdG2W777+rWPe3s=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hbfRAcSeMLt2b3MfpJT1u+XqkFsKZfgTSJt9iyLhXeyJZX0Ob3tYJKMhj6nP?=
 =?us-ascii?Q?aO16lpa+kv741yPqxFmvxLJBkEtwkdyXTO38EXhCUM5y2hd+dOuYYadilg6R?=
 =?us-ascii?Q?HbefWcNobWl7RAoUfeWjicNyNmppVxXIEqEUqpCoyFFLMwebHnati0eUAh4l?=
 =?us-ascii?Q?duVIitjZ/Xa/t6EzxiMA72P2gNCqd1p+xUj14sbVOP7PQzYqzQlmdUpxmT9N?=
 =?us-ascii?Q?yI7+M46vFc1CFy8yc/bS+j8EeS4MwRDcRJLmOOM2Utq8JqEjD/rKT3VyjR1l?=
 =?us-ascii?Q?cHy3QK7YFoN44Be+kdLziIE2uCZRjdB4ksOitV3t5wYq0EzA2lINxyGuDSju?=
 =?us-ascii?Q?YYP2wwe3kU5KAcEVX19Re8LdatQNf5wbHFPc3Sqs6q++Qt65ncQPjzCUw+ql?=
 =?us-ascii?Q?DKUZXQglZnlh+DI7iqF3URRQgMwn+YVuGVPPb4UmNDR6Zhp6rrIQZ/me1xGz?=
 =?us-ascii?Q?EOuqiJxUnG5Z4XoQFd57kHDn3ieeqqBbihdNdlCyF1kYvRK/A8CV5Qe0ji+M?=
 =?us-ascii?Q?OgVYdiLtGNM2llilELgNzzaapMQI+8AISXn3LHgkQ2cfBnt3VnviDdKnwmW4?=
 =?us-ascii?Q?tr0Pk9+V5DPI4orjSNRQ2vrZl05SfYEnwga6V4/pzzBjfTWoCjyf2erLOCL0?=
 =?us-ascii?Q?F/8hhcy/UfI0u8nyFxDskDSbLCcdNTeIgZLW5sGFeSmuNmPuBleBPYDJBqC0?=
 =?us-ascii?Q?FaeuBUL4rAp4vEjs4CPdCobp5qmoiw9+bs6VkmvAI1z+TTfhS3ByXai4Ym8H?=
 =?us-ascii?Q?3KM3T5s8jL22wjuKPT/EhSwzCYmAIrVQjwwiilZo4DgCyV51tGubXhJ00d7l?=
 =?us-ascii?Q?Il0Mtj6i/lWUnl3d9Ucwiba0PDl2N4YFCnBFi3LYUFMdxtpn9Zn4oTIUTpCI?=
 =?us-ascii?Q?sFS9Y52g33onykJePAGF2VsHYszjlBxFnVAQHKkl5KEr8P1SEoJGSrbwgKAp?=
 =?us-ascii?Q?Ulyy58uXKveryP3uPFbOliDUUim9/sgL1Hqca5PpV2CmHj45U5nFcsel/hfq?=
 =?us-ascii?Q?Klew7aWlpKjLRaTUJu4B4CXayXKD/R8FqLIiBLDoCfculZmdvlx5bIx3OnRl?=
 =?us-ascii?Q?9BE03s++Y/BvJoz9JSpMPIvFOwbyu3plEWGZKUxKvoZNvZkFX4fHkra+LMj+?=
 =?us-ascii?Q?Xnvr9yVRL3MWhifx57zbrFGQADBRvp9F129cCsG3xpsQFdGpQJYGUBQi6zZs?=
 =?us-ascii?Q?h6TItoyDGn7Rl78aLpSPCvoE1fT2sCuoOij6iIhLGq7uY4+nr5wZNtbbVIo?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2cdd0-a746-460a-f24d-08dda7937e2d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:27.7254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

While at it, fix minor mark-up inconsistencies in the existing
documentation text.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  6 ++++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
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
 
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 8adf0e5aac..4a0487b66e 100644
--- a/Documentation/git-imap-send.adoc
+++ b/Documentation/git-imap-send.adoc
@@ -9,21 +9,23 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl]
+'git imap-send' [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>]
 
 
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
 
 Typical usage is something like:
 
-git format-patch --signoff --stdout --attach origin | git imap-send
+------
+$ git format-patch --signoff --stdout --attach origin | git imap-send
+------
 
 
 OPTIONS
@@ -37,6 +39,11 @@ OPTIONS
 --quiet::
 	Be quiet.
 
+-f <folder>::
+--folder=<folder>::
+	Specify the folder in which the emails have to saved.
+	For example: `--folder=[Gmail]/Drafts` or `-f INBOX/Drafts`.
+
 --curl::
 	Use libcurl to communicate with the IMAP server, unless tunneling
 	into it.  Ignored if Git was built without the USE_CURL_FOR_IMAP_SEND
diff --git a/imap-send.c b/imap-send.c
index 64f66ec67d..be6412fe2d 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
 
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;
+static char *opt_folder;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
 	OPT_END()
 };
 
@@ -1729,6 +1731,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.49.0

