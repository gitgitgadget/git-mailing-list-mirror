Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91BF23816E
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626385; cv=fail; b=kXTs0Fk8fKC196NHexjdECA9QDr0O6unZIG7aA1RbZXbJB09VPyPwcS8dbXcVMMIHGz8jG6VW+oPejFo8Rp70/mZcHib93Js3f4FKEN0s+enz/DmMmPVmhzMXmBLxGR/GuXJxJF7hiQB2ATKwYFozNQrKkBjsrgN/ss2vCsmP9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626385; c=relaxed/simple;
	bh=2ewjnurKrQuf0QVs0ewgj8+H2fsUuaNk7LruU+jixnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GT5G02AXYVsde6X4Ba94GCtElRaJoq/JMQEB8/lEM6e1ofFsRhPbg6lKUtC1Df1rwF3wVxogFXLEXbh5OamNNi9KBoerzpFKuE/uPXGsciou35VbINhPkTpSy3dxqho+YUliqfIA0Mdo2R3MH052QuqUzE5NtFGBb1SntENk1rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=mHRq6PN/; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="mHRq6PN/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esPMwD8IU3i7YqSM24hrk4crs0tsyBxRcw/Dnj0kNdYC7dOus4VSxS0P5Cy7arSoILQ+g2IFaiDNmfFNYusaZawxfQzzugcOBncEXwDWG8dr2/4RZyCLNMzuvLxWo5Lp94JSlv7AL5BAh8tfHCAgRqAuUV2aRSYrgxVRN8DllmJ0LF2+Ghe/WM8nN1r6rXLQS0GAjrmXVnQp/2Z5HcLFIVrwFV7MtTAW9kJEikPjvIE+Y461kA+Pd1VeWM1bEQmt9xILr2I9pTMLejqY0j7avQZZAzzLo5/KUASQYiTqh/95lSljugQoWYZcfcIyN/ZOJVJmQudSq2qntIG7DFjAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xw0CIRBibYQdXsJPUhQsUGEuNtxzPjZ2YXO7KIENp2U=;
 b=R/C0YN7egNNWBDal+z6oBzTehaG7P2OB8/qTkxRPek6O0kbHN1j1EwkKBGJJZkf3Me0A7k4bfXojs7FPuoR99Apign56pgSlOmjhI5XhRxQ080nxWwbPh7+FW0HG28cx+3F7dF44C6frFT7MrMglIn706px/tIoZYSDGPec2FahffxKN/3NhXGZRMMN7sCBJa0UFF5xDVu7FeOgtFyBkBxhRdi6muK0KhyjA7FzCssBdXGanW869V79jwfSN32H/cc8u4n26Kv12TUrg8LpkpRq3A0QehphKleONpcTChOqihbmfe5KeDgb3a/ahxrkYOoQWEZVmm0uPb9Is4s6iiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xw0CIRBibYQdXsJPUhQsUGEuNtxzPjZ2YXO7KIENp2U=;
 b=mHRq6PN/Am954TnOz06K9iv1qLy7G0qKNZmIHYyckZRCNN0Hca9BNzI8UL5v23umjqL39Ah91cWCevaWJjwpOVMWztNssNLLS86+iv8op6yylDn7rUJQZvNMMCzMeIBEOHkJ/ER76uAA9CxcfViVYjToxZUonXzvVnGX13R6K6vJ/ktkuEF91jt1TLPExRuSPVZaUEUkWRsT6uxRQprrIQ7WMMasuoQ90GTFZzd2PqwnxBGLC+xqmo+9T89VswPOiBU9J+E1yLI+q8X14jLHlLff/mdAvLtCM6NhKbZn4QtToOrCUT0PqodmIc7x8mE35+b6YDl/Shknzj7R9e6ZLQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:50 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:50 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 9/9] imap-send: add ability to list the available folders
Date: Fri, 30 May 2025 23:02:22 +0530
Message-ID:
 <PN3PR01MB95979DD3572EF490BE5D5223B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdef4ad-e12f-43bb-19a7-08dd9fa0002a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|12121999007|41001999006|1602099012|440099028|4302099013|3412199025|12091999003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uwKm3izS69b0Kq/wSfgr3SNDSvJeajEhTUdzUuh6w7nGYlbErNHK6D9bhEfE?=
 =?us-ascii?Q?Q8bww/r6RITXj77GCwGOVu5wU4TdgpC5CEnfF2jWcQPNS21Z3JVECbOvuCMJ?=
 =?us-ascii?Q?3cEMzFz5rp9sgZL2AkpVzA4LuOvFaHgEL4XlbY9IUFH/JsTTSMEZq/jb8hob?=
 =?us-ascii?Q?Ad0MNZXPP0G+mBSxowkZ/8wI3A8JE0afL5diyEUBeJujGqqlmdVlVDNzDAFG?=
 =?us-ascii?Q?cCVsJ3tvtk9FzzJcD9WTEq3cx94V2RLOoUX2692C9Oq2oasJYY3neLnu4/h/?=
 =?us-ascii?Q?biMqkRielf28kH5SRhE8///hLubV47JZtabkxJ0WQVYHyuQZaCGw3QD0eyLm?=
 =?us-ascii?Q?fW3Azylakwyp6jhy81LVBBgg579hy7IoMVmkkDuJdk20AKQY1koxg2/RLHGc?=
 =?us-ascii?Q?R2nGApvpuwu81bl8xDzoBE27ti6alos1mI77KmPvNonHMX0v3pxKvVcnNqgu?=
 =?us-ascii?Q?XHpRB1t5uknjJF5/DjTU2b4GppU2m9bBkOnES0M65T41rJ4OrI4r21nHR7oQ?=
 =?us-ascii?Q?obNiu9mOJs6EJ7PlYDP56qUTjzZp8fH4YF/fXUwH3AUgPggldnHatXjbrQ0v?=
 =?us-ascii?Q?eq6yj6/jLKWtbJh5IDlWFw9H4z3vcADxlI4MGXyTc2YVdXh2xrsR6vXUl9vc?=
 =?us-ascii?Q?L1ZbXlrHpy1UVYw0Ezbqv/zoPWtPV1xV/1lSFxMBbw273/meVmUnZ/21gQNl?=
 =?us-ascii?Q?9+dJ0dICLfKrv/2ih6DAharD6sJBRvYvW2dgHl4aqKv1t+lM9f7E6nynbUTR?=
 =?us-ascii?Q?Tok0Mp8gEWEINGOaork6HK9egZflpbmN5McEZOEGgJcxy5rqO7ffDFLmfHM9?=
 =?us-ascii?Q?NMQo7bXNvI2h7PdHmwcx2QP0E/No6qO46ldSAsm+fO//jiSALCxfRbLpALfH?=
 =?us-ascii?Q?E+rV+fdHk/X0zN4BR6rF5fMCmeAZqU5TNoIcg/wPTMpDAn/Dov9PUGY0bgE5?=
 =?us-ascii?Q?UGvvCFSIPlPsgC0C3Ap3woxqcOD4v331snVuZB1S7vlg7Nxmp+qm4TCmbrqs?=
 =?us-ascii?Q?07ZyF0ZUpPLUWmfICFbuSqJVYgUhKLzL6qscvmBadYnD8Gh6+uLbgc3OZ+LR?=
 =?us-ascii?Q?c2H/BR1Dw+gaY4Gmj53e6SPUICsYWAVhjnDegdnUIenSMU3iqlFd+4bGgKRn?=
 =?us-ascii?Q?Fhr9WDMcLZygDDBFlYSRCwblEzHREo7+LOYV2e4aO4bXUpQEGERNygKHJ7ta?=
 =?us-ascii?Q?QjWYjsa39yuvHVEXQUanMp2VXjCDil1+HAuBdE3BwPKtXWSR3GGSX59BnYEV?=
 =?us-ascii?Q?SGx9Y5QiM6DSrtBw+9hXhpMQ8m1gu8VjBP0q9s/Y7LEgCAe6dgpZCAokTL10?=
 =?us-ascii?Q?GV3N9syvBQDlRIdUL9vsC5Om?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0K2x1mSmkQlFVYuCUT6q02CIapPK7YeJ0vEyrIZWtCSL5KuMKB12ckwP7VnD?=
 =?us-ascii?Q?mzPgax9D2K6bMGu86RSbzEhqlDZOWg/uNiOtmi1FVmtMe3bD9nbk0JPNdm/j?=
 =?us-ascii?Q?Va9zwAdI+sUUAHHUjFx07hG9SWycNqiE89NkjssrUJwyugOX8zTNsUXzpTAV?=
 =?us-ascii?Q?+9V7R7U6vElqkW92tSNRJ0Kz9XkUn6d9CsElxWZ4Or+SB1kOQRQX+ExTaN19?=
 =?us-ascii?Q?P23jjfYmsUcHIFvD/feA8X4xbH5C6yzpAe3tGoLGIMJGaun8d7rw20hqH6EK?=
 =?us-ascii?Q?TT+9O3+JMkfh7EShX9gbzTk3SM3y8DHZif3zytr7ZGCjtKYNSdn5qKgU+A9R?=
 =?us-ascii?Q?iP0Iu/0p4X1pqmmAA/jBZkYu4RNdecfr6qYNugbhwoKUgHXgClSLA0mB+PYc?=
 =?us-ascii?Q?2+H3wU7V+pbN4JqOOUCFrEAa78O2ITDPRQtx1HRsFmpVSuVhJZa98qFw2++8?=
 =?us-ascii?Q?FG95aQAmyDNUoD14eSX48wpK7vwibizaUiZBPrqLHKrXuf88EoLu9GZM+wPj?=
 =?us-ascii?Q?iueylaeOZscpEfoJKdTHuFF+NKIG2RxRUCrDhgrnYRv9Mnw86U71IvupGqK0?=
 =?us-ascii?Q?fbYKZnKkqTxG0ZacwY+hEUVzRimaClyCAxryXlgPb4//dweDJSjtxf7jjvx2?=
 =?us-ascii?Q?ii9zw5Fi/RuzjGoWvBMyZ4FFYTa9BymlXmdvC7szFAqkKI8ijPkVukJhucnl?=
 =?us-ascii?Q?uYk8Okccs0J8/EKJoKT80gPDkGzFgsVRx7mQsFzHDVXEZzvfZTGzxnEnERdV?=
 =?us-ascii?Q?Q6FhTy7BOiafPqkghH7cTloOa1RN1q4COeRsyCCR7asEoWtQMiow4wajC+F7?=
 =?us-ascii?Q?Gqe5LhaXohtb84X+zDMf/SXX6Dx3umR8wOU8P2jDoNJgkEJezaFTmzKO538o?=
 =?us-ascii?Q?BA+1yOH9d6Cpv1BLSxTRB0MRo/DIfIPk6GDkXpQgwF43A2DmjYCDWbsNQ90I?=
 =?us-ascii?Q?yyxB+PzVFL9bMENBmqEIRJ73AnWaFER/ub92L2tBEqTp9mvCMp5FuRR1PIBJ?=
 =?us-ascii?Q?bQsHeuYKvrkgKQhKOdAOlClz3Sq9I4SuZbtIHMyI23Qt5l8fVTCz9Z4nMpLv?=
 =?us-ascii?Q?+Cuac8yEGZqtDGEi2u7sP9TkZJOvmTT01hgXFC5kUF9WtIFLv0eTI7fEWAW8?=
 =?us-ascii?Q?OxharlRkxlacIDLchr5qa3SgVwm5RzVOxvvRxv/EamEqL0WFmTqvwVWnRYmI?=
 =?us-ascii?Q?4Dz++p1mCdE6zkqm4tfYvbWrv1VrXXK8DzBioeWGuqqLC0JD03RDnwdkssZg?=
 =?us-ascii?Q?emTBZhTCkAIKBR9M0aTvosvaEwBDY/g/01kKFrQdMfwvIgViMzn/mr2v7c8Y?=
 =?us-ascii?Q?HT2fJpWBf6DtNe9Jtpd2HMrh?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdef4ad-e12f-43bb-19a7-08dd9fa0002a
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:50.6255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

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
index 8f221240d0..379a371c08 100644
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
@@ -123,7 +126,8 @@ Alternatively, use OAuth2.0 authentication as described below.
 
 [NOTE]
 You might need to instead use: `folder = "[Google Mail]/Drafts"` if you get an error
-that the "Folder doesn't exist".
+that the "Folder doesn't exist". You can also run `git imap-send --list` to get a
+list of available folders.
 
 [NOTE]
 If your Gmail account is set to another language than English, the name of the "Drafts"
diff --git a/imap-send.c b/imap-send.c
index 95b78fda42..60562dc9b8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -45,15 +45,21 @@
 #endif
 
 static int verbosity;
+static int list_folders = 0;
 static int use_curl = USE_CURL_DEFAULT;
 static char *opt_folder = NULL;
 
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
@@ -1619,6 +1625,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	return 0;
 }
 
+static int list_imap_folders(struct imap_server_conf *server)
+{
+	struct imap_store *ctx = imap_open_store(server, "INBOX");
+	if (!ctx) {
+		fprintf(stderr, "Failed to connect to IMAP server.\n");
+		return 1;
+	}
+
+	fprintf(stderr, "Fetching the list of available folders...\n");
+	/* Issue the LIST command and print the results */
+	if (imap_exec(ctx, NULL, "LIST \"\" \"*\"") != RESP_OK) {
+		fprintf(stderr, "Failed to list folders.\n");
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
@@ -1647,11 +1673,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!path.len || path.buf[path.len - 1] != '/')
 		strbuf_addch(&path, '/');
 
-	uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
-	if (!uri_encoded_folder)
-		die("Failed to encode server folder.");
-	strbuf_addstr(&path, uri_encoded_folder);
-	curl_free(uri_encoded_folder);
+	if (!list_folders) {
+		uri_encoded_folder = curl_easy_escape(curl, srvc->folder, 0);
+		if (!uri_encoded_folder)
+			die("Failed to encode server folder.");
+		strbuf_addstr(&path, uri_encoded_folder);
+		curl_free(uri_encoded_folder);
+	}
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
@@ -1681,10 +1709,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1703,6 +1727,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1749,6 +1777,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
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
@@ -1789,11 +1842,6 @@ int cmd_main(int argc, const char **argv)
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-	if (!server.folder) {
-		fprintf(stderr, "No IMAP store specified.\n");
-		ret = 1;
-		goto out;
-	}
 	if (!server.host) {
 		if (!server.tunnel) {
 			fprintf(stderr, "No IMAP host specified.\n");
@@ -1803,6 +1851,24 @@ int cmd_main(int argc, const char **argv)
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
+		fprintf(stderr, "No IMAP store specified.\n");
+		ret = 1;
+		goto out;
+	}
+
 	/* read the messages */
 	if (strbuf_read(&all_msgs, 0, 0) < 0) {
 		error_errno(_("Could not read from stdin."));
-- 
2.49.0.639.ge2dd5d9d81

