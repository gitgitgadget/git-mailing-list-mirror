Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C1F237163
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626378; cv=fail; b=HXFqgshJPXF2ZFigMQR5EDc21Jki1mo/0verAr6vQ5HlexyS2kobDUD9X0ZfQsRBiWFvAahbSKn6nnz2YCgKpWOi3CtC1TyJZzggKV4+BWp7U3/2/zL7vy9HUZQEYPDAot6JT7I1s/ECIYvBnve8ccT388p2bsI57IWQYLZw1Mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626378; c=relaxed/simple;
	bh=AOjr5uWUioQ44bEeuCUQwlu3cW4erGJGUk4lWBvuPb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjjpXq8BCVatHgTCDM1rUI9oNBBUdnds0Jp1ZoKy/UU7UN20a7mA2lscg9lOZfZz1upEnhV/V+WWcq0/6I78rKNgDJrQstl6EtJbzx9I/GiXHSHTArYq2kBDyqLby7bzQzLfJqEXXBQKT7zy4iN9XOdUQJYZbWTTmEqUx6Xm2h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=YRalriYP; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="YRalriYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+sP8OW8nFYwLhT/cX/7ZcG37z897MrnVgsPlQnL0eL+LRwbhGxP8HOUxqyXc5q9QgesOuquPxnFS4+/7sTcheOWrb4SY8tBT8ULEZGWahAMgT78RGDmwFFmHLIIu/W4BLdXAcfV5kNRkuKFKMUK4MewMTOK1dffbtq/v1jJx3HtNrDNARHJuOM/gQoy2qsYRyMjdiIdsD73RTonn8Qz/vzBlvyUasisiTdQjskov7dJIeD8ezGAjJH1wSnsWI5CPnzFZhk/a863JjyXgmdNbWhGMS0Mao4/tp6D56ARnUYLno4KjzfdyUspCfz/a2UKQWR4UB17xlZhEhg6iBBBcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/r+59ob7WVf8SlKpXT2suovMK2nKO8PgyExxQ8P6Ink=;
 b=i/ZsklqoW7OUgJJhc8qu7TlRSzrshOMK7lXRDmj5En7q/sq/OY3aZgCcRsvHFjlAjlixRNxuQRCaptvvTD60gGGakQHFBP0M2os/V2ZbbG1TeZxfwuFH8b2sX8gTN3fA2M289yNOTHaC8tWsgLuVUTj48o67jb6yHE8V20d+dl4u34L8HaiNoqEeJ9DiklSc0D05GwvhlC9PoVuNeTb5uvRzlT0mrd+kpOeeUguGD1qDk0rNCK8UAzJpCBrzPWKHhHsvlxB9TptTKFqy2GHjFmueG2gjcrANH43DMamRiYIrh1Zx9UtJCSl/1DX8+XDhIVBOnR6g8iZcYG5VpL1oPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/r+59ob7WVf8SlKpXT2suovMK2nKO8PgyExxQ8P6Ink=;
 b=YRalriYPY/33qUzpKoNYjbeR0Wb4eJtrEV2lt2pGPI11RWXo7XsiMdcKKa9updIEuwgTqylbIaSYLrqEsTYepAVngduWSwQ5c7yB8UU/T5hms34sQY45DHynSTgW6vIUqJjTqa7ctBNkXIOMexZVLtTuMTZ+cldPZusoaGnMLttVH2C76Twt0cxgt6K4Ec0wfmhGn3RrNtm82XZWPzokOw8kxj+IdeCNco/LbrzwtIkuM/nUN/Zg8jmpm03uTHwBfkmRFqv0vDpZaplAk0/JW0fdLDm9Po+84Qs0XiAYJ93x6Rm5rH5B3d0wA6t/FU/51qcUM6eyKjUbw5egSPZyJg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:47 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:47 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 5/9] imap-send: enable specifying the folder using the command line
Date: Fri, 30 May 2025 23:02:18 +0530
Message-ID:
 <PN3PR01MB9597C14385FFA97ADF5ED3C9B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250530173222.20211-6-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 42e8a362-8541-45e8-03c7-08dd9f9ffe04
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ATDpDbA6MntAvnLGdUN1q6bXnrusB5F4yfBawv1dHKJQVDtimVS0LrSs0Ye3?=
 =?us-ascii?Q?H36C5yknK14ISuh2cCpK9POZemXjtax8LBLz80d0eqxStrLKjwGVMmhBANkb?=
 =?us-ascii?Q?sM1h33vqtrwueKQdrx58yq8AcIxymgtfhi5rei37kcVZyoG1w2TAx3o6+vmY?=
 =?us-ascii?Q?65AbmokZwHyJSi7gWlCuV0s5I9mIhKMOjyWhHKtWRD784VVwGTta2kjjnLt9?=
 =?us-ascii?Q?2tzkAMkWOJ+qlxlk3wDBT+oNoSnVez+s9G4l+uE8gG8GqImjGhz4G6F0R4VV?=
 =?us-ascii?Q?gC8k17LFgv5KTapK7xNSFmNIkKX2GmHFQU0OBSLkMBAJ2VI+EDHJSIISqL/G?=
 =?us-ascii?Q?NWa+GfvJcGRaQpCSBBpo0HS3FGj27pnMT3CMRVjBfW0jy/EHfzyXNaMTwUh4?=
 =?us-ascii?Q?vfdCTHkKqSnjKjRRFHKN9/dS5Qb5ytRUKJCE7uwNFreo5y/taxVLs00oRlpo?=
 =?us-ascii?Q?3kb3lhvPhsxxanEyy8ZLkPaR2XUFMoU63MPw0O1hRBgKiz3vCjKt67J/J8nw?=
 =?us-ascii?Q?R3GcMDWBDEctsARCS/KvmfSwTXnogxnTRYSNdZH3rODK5Anq4Ewyz61QaTm/?=
 =?us-ascii?Q?XzsxC7rMdjBBtarysUI/2OpujGplkbZssCOGNJ60rZiZxe3XUNQpBJF0Tnvs?=
 =?us-ascii?Q?6IEEZafFi6KwkIweeo6bH9XyXkRdnfREKg2a5iHu4pV9+HSbT8hSUM3w2//Z?=
 =?us-ascii?Q?QPKaBbtMtg+AJYPmixBlo5T6Uc7IE+ydOPoRcxT6xIclwjbeViBMrAWI/VPo?=
 =?us-ascii?Q?BapFlqHL4yaQ9oh+Q5Njgt5eu15fGoBvI0OPKx7fUcYpHzSL9EMx90JQAW3x?=
 =?us-ascii?Q?4U8uvRBBkt4nkxqMpsDqC+A/vLP6GybhXc2eXmkSxw8tTkCHE0nCMZEanhPO?=
 =?us-ascii?Q?Yex638+6pfOR4nIRHTJrfBXaGCNPJnkxKnhBn5NgodT8aHBJ7vLYkXJ9BG4C?=
 =?us-ascii?Q?NCnbIFGEIXXYLZ/M8aVmGw+6cNl6GYZwTIpG8wpGA9wUQSDbE8LR3d4Ni6LU?=
 =?us-ascii?Q?iUYwizwfq12PcH/GkjWvKsjimiO4/ArU6k4dV55MYrxe0/Y8QlTgVmv/w/yZ?=
 =?us-ascii?Q?+JmGCY5JYgfX2uhdO8iO0Ji43+vigL6V02U2rX5iphvgJ+PVJOwcO7bpTeLm?=
 =?us-ascii?Q?vKCDr4jrHIbF/k1UHTRYuIMgzSF6MLZxOg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZqlIAVFwp/VWXOpcgJMUrT33WzMpKI5cakLTH0Akl2n5oBGnmxmK/0rwYVN?=
 =?us-ascii?Q?D9j/MMsw/l7GQyGL7AKbdqn87b6kJAnU6Q2TKVS3waF9ojP1/SReqWQ9zWD/?=
 =?us-ascii?Q?dabX9FGapV0uDXP3mdyO0042iajeK7oWYDIAdOgtWxoeQdgDJv55A0SHPElm?=
 =?us-ascii?Q?FAsozzNlYO0NF5gDmRXwnDq3S5RRTrdPsRfjMr/SE5A5en5MeuGhvlAl/t2f?=
 =?us-ascii?Q?e5cxaERQM9IiLZiJCpYNJp6l/ysr38uKxtftUl1S1/N9RSiv++HWuQVPN1ow?=
 =?us-ascii?Q?WUGTG1+v+x5D2bJQ0uYDKoOtp6WKFjH0jDIsshG4PTdemdEiv0b5de9hDCJb?=
 =?us-ascii?Q?ppjgLJg0h/xRFedEa6ZeUhnbgqU0gQxYchpk9U/GzfTaxF+Mk4tlB6AIpIWs?=
 =?us-ascii?Q?UBfJ7uTT0FwbapGNYWP6eM7GWFIpVWRel2e5I5R95O328RN8uh9+IAwtJdUO?=
 =?us-ascii?Q?sRjmknHIz1HAEgv4ZowhnCDQmF9Wmm6Ev+O/9QnB86ZG37hzU1rBW7ADuSf3?=
 =?us-ascii?Q?uMTVnB2/tUFflBlXv7jgc3piWDyWMIL2vuOrMsSbu3cetgF8dpoVckXRwyWV?=
 =?us-ascii?Q?f0zwWxR3yK4O+AqB9DAMaUzM8PcoLKDCZ+IRVfEOdOtdgDjyp/QW9W0TUVHh?=
 =?us-ascii?Q?2aZL+HtaifU+j47AzYBfEU3rhXrHq4x28C98gi+IS6ZeXn3+3cCLdjsfGzxY?=
 =?us-ascii?Q?ZIIqcSYRVuqv9shJHMx7df2JEVGnnTqtmvQtUs5ATYAi5c0zgT7s3lnjum/0?=
 =?us-ascii?Q?OoETiAgK5mZkG9ayq8w742zlurOi/LBmdmjEk5JueMHFQqL1ffWYsoYynRAz?=
 =?us-ascii?Q?AgQWKy5Cw1OHbi46MTEq1j1ocjkBKZox291TI90XbEZ+GxpGe1RHCzaoGH5m?=
 =?us-ascii?Q?negNu0B7kY2UlqtmNUgtlAl/fHWYn59UyV00q05gdB54zGsFci2u27tQTofu?=
 =?us-ascii?Q?EL3JMjHWtYBArfAigJzPkNfw3nGId1QV80ByoDJ5zlPmOArR65mhJTT/3E0t?=
 =?us-ascii?Q?c55m4XOJFK8Vn9u4BaOQS1Gsjnj3139mgEEdh+PBlYnEHSswHzm1H3IPDVCd?=
 =?us-ascii?Q?Sg9Sm7FY2EElvhKEhduPQoPy9xASYddKnGxNVEYYsb+sdYkdOiel4h29RAsT?=
 =?us-ascii?Q?knDkIi39LUfQmtiHSvpXBdgIvOHG6JEa9pBD/h5x0LkkE4fSESTHFSOZI4Uo?=
 =?us-ascii?Q?YLD4p/rOPrp5TR8Q4onuXOsxjoPN9Zt+rCJ8RkNJ+dj11mQupsolc9jkSVu8?=
 =?us-ascii?Q?Frwp56CJc0irXwNUPQxlvOZnZJbAQhLJH5IC8g7C9ACMZC3thgiGrf2Jd0Ha?=
 =?us-ascii?Q?piqs8ZfuBLCbCdZhE4yj2BG5?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e8a362-8541-45e8-03c7-08dd9f9ffe04
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:47.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/config/imap.adoc   |  5 +++--
 Documentation/git-imap-send.adoc | 15 +++++++++++----
 imap-send.c                      |  9 ++++++++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/imap.adoc b/Documentation/config/imap.adoc
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
 
 imap.tunnel::
 	Command used to set up a tunnel to the IMAP server through which
diff --git a/Documentation/git-imap-send.adoc b/Documentation/git-imap-send.adoc
index 08ecb1e829..8f221240d0 100644
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
+in which emails have the fields 'From', 'Date', and 'Subject' in
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
index d0c7bac030..337f1049ca 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -46,12 +46,14 @@
 
 static int verbosity;
 static int use_curl = USE_CURL_DEFAULT;
+static char *opt_folder = NULL;
 
-static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] < <mbox>", NULL };
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] [--[no-]curl] [(--folder|-f) <folder>] < <mbox>", NULL };
 
 static struct option imap_send_options[] = {
 	OPT__VERBOSITY(&verbosity),
 	OPT_BOOL(0, "curl", &use_curl, "use libcurl to communicate with the IMAP server"),
+	OPT_STRING('f', "folder", &opt_folder, "folder", "specify the IMAP folder"),
 	OPT_END()
 };
 
@@ -1762,6 +1764,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.49.0.639.ge2dd5d9d81

