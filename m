Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011036.outbound.protection.outlook.com [52.103.67.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C39281341
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453722; cv=fail; b=VWSjIhm7N3b0Z/VlRXrG1d/2sscVFkL0J/euSUCKiffpzKHE6nptCpsPcMpktmJq+iuAVN6cFCYgoDUKBwZnTWg2d7zuduFu6ad+4LH46vIFfSu6IYHdwtAjI/UdbX3zg7SeXqSNY0TifNvpA0jffiGFqYNYzP22AG3bWNkEK1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453722; c=relaxed/simple;
	bh=AnSST4nB55yNFAxdu4ljBS66Gg0vkvQv360hn4tEjdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=beNFkcn6Lbf7BoI6/LullYYO8TgNJNWROZmAAM4w0ynd7HJMECRy85N65uhVelLk5L04/00Ips8BXoRnihMuXPgyWK+zkAgHF1ZIh9Q/CzQ6Vip5ZfO3D5swGy0PJFHZjF9zuR3JlrlO7HhS/l6xNfSWZOOUQiEi/1vKYx72YeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=JWm6jqEt; arc=fail smtp.client-ip=52.103.67.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="JWm6jqEt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmmg/xa5VLsoHlHLaf6//oI1CH5E+zO17kgfGzyBXi5vEdqqCwZUiH2cSuSRFgfmesvlUpfUd6Nfz9Bsi7IUSrF1g3JHobHMRh+axHcIfCLSz/VAmxFuXWPr4PB5H0s4dpGqWLZbgzuXqILNKEE/d3Bkkki+vtD9r6G7gVbr1mbIhneJQ2OBvNKyJrAqm6/atCgQ8H0I+PnlffOFWiGgwGhzghgEkkY7PR40/ghSDT2+5u7oPTKyox2RoGNIlTzDd5mTORAYCP9RI1oY4Lu60peO2fuiRsLlO6rMmSAdfcT58DrLmDHbacru/ayC8Z+tlfi0scnpJOQ3zbSctXnS+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kTi2Nuzmb7RblYD9C5a6HLxdVSc2mPHchedfVaQk2aE=;
 b=ukY90KA0E7FYMJG3Ebyd7OTubTpuo+ct0/6VOzA89OmWhF9/RdjCxqJSP1wBBfVs+XwPgPjb9eyvzEnvplFiCFa443mwWdFfGQmo55cia0QADRZDV/UF6Gq/bmlx+CIH4410Fw7qbZK+iH8MPrk449RJf1l5lAIvVQADB66UzsMUNGPvc5mEb1v67ny76MqBwSsAfDStZly6wma6ULzAmKh7AEdlMFUcrxT0yHTb8ZzYQkL5ZZbkmNDrC3e9YxH7NLStup5HzTQEZYruD8gqfxci6Al9B7hN37MEznRwWQ1KHOl/7aZ44icqT8gOQ0/c1+OwZh+oMenPARLZumxv7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kTi2Nuzmb7RblYD9C5a6HLxdVSc2mPHchedfVaQk2aE=;
 b=JWm6jqEtewERZDbiiOretCYgZpziz9myEwyKhty+2qohOOqM/k7ZMxk2Y1n1NnH6ySCKMdcsfHy96yWwMsx58yT3NbUl17kXT7htErujsrkddAJoG4C/fTqEuBqXqpzB9ATkK3iosGpFQ2mCqRtDBvLjDUnV7eps/Nf9XbgWYieVlMB7lZa84iKbhygbuwoPRfLKcwbOYD5zBz5p50lkc+LLCBn0YMLFgz7kAb778P5FuDY4UjPeD1Jm5coAF7N3jHu27SBWSGjCmnia25iQTUlS7sGGFKJQGrQfPjD6sTwtg63B1UYy7Vn+mlxiOQjxJ/qexEf0RZnaidrDxIGvpg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:49 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:49 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 07/10] imap-send: add ability to list the available folders
Date: Mon,  9 Jun 2025 07:20:38 +0000
Message-ID:
 <PN3PR01MB9597440624DB4F9871F069FAB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g6561d45bee
In-Reply-To: <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95976572C3B14C983802ECC1B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001B5.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609072041.12114-8-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: f91ec942-3991-4714-8023-08dda7264871
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|12121999007|15080799009|41001999006|7092599006|8060799009|1602099012|440099028|3412199025|4302099013|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4m7D5u0B1vFx+GAQr+SsPKkEHnT/byS4XWzeGMHQ9s/4CETokRnH25K+e3c/?=
 =?us-ascii?Q?pdKSpwIlzN+cHhOShZklKlfMt9ytu1Xl7U3ypg+lQ+GjDOkYl+AIR+a9V+0Q?=
 =?us-ascii?Q?VDzCCY1oArxxN5Nc0xaRLjirxx0FuJEFqd0ZJ5pJx2BzGJiw5VAXX5fWN8Js?=
 =?us-ascii?Q?mS3NBoQShRxcSWumFO/vwyihV/mvQNXB9oQF97kZ8/d9pJgLWO+2KNH4qIim?=
 =?us-ascii?Q?588Db7Moy6C/SH/N926eaW1xGiSbCaVK36Pe3fdrIXYCywNcwtJRrDesXj90?=
 =?us-ascii?Q?WgDkGDLSAj3ROn84xFpz/NQeHhcYa7ZIn94Rzo4R+4x3nlU9Q1ccjaNs6YwB?=
 =?us-ascii?Q?M6eATuG3FoDBqC/IuQRKcY5RPVoXvgtw0rG+K56ekQgqIMhLK2JgtWj9WKRc?=
 =?us-ascii?Q?z0iXiCKnx+sGWl6xQuIDudapjMpoAyggdmQiApQCI85cYls7NXEndcsrMVrc?=
 =?us-ascii?Q?ywsPECxFZTdzR4qMGEfHwjg2PXJaxj1+e08ecXKggtO7wZ8GziCIYWNquhAB?=
 =?us-ascii?Q?6FDYr/iXuXpFEFeOF2yRTg5HGQJC7i1f2n2dDGiKXlYg6MG3wc3d0+O2kKko?=
 =?us-ascii?Q?xxmVvkqIdHqFAhaRjU4KKD72XNm6tdLlLf4MpueMI1Lwrol/HYvDiJVHvS2c?=
 =?us-ascii?Q?iPnZcGYiYGTgS4mT0BuyYwyA9pX/m82PK96HVnCarOZIViw+StPLKFrYfi9N?=
 =?us-ascii?Q?fDtXXiVQjcoa/+Ri6KjprUYfaQfnPaNTx2SGGYvUy8rEQTjBShGZozrBDCV4?=
 =?us-ascii?Q?rR+ivZWFeuKvnrWyLcJn4gya5YE8HmbOg2JiYtXkjIr+kuM5BaxJ6eWabttw?=
 =?us-ascii?Q?o6gAwM8abjzm/AJh4XPcL8XcaqkGqlnnm8dqbNU7lRxPyYLx+3qXjSFgk5Np?=
 =?us-ascii?Q?eU2jv5HnNDAXgMnFqiW64Ef1wmLN8Mv/xK6eb2YRMReALvdpwOQJo9dQ2kuO?=
 =?us-ascii?Q?LiWSHmJkyiwE1yFLT4afWvAdD4xT/JZ4tLj0Dx3UNzytAe+r6/WK2pxE9T+8?=
 =?us-ascii?Q?clATEEmWcETYkhWJiuZR8Kg51zvRVdypslcb2+m8xOnaUYtRUs4CFFZ55cU0?=
 =?us-ascii?Q?z6gUNFI4xXiyF1sF5H44SU+2yIlI36HdVmeiQCsiNJQPOCP4R9lAFGDdXFyW?=
 =?us-ascii?Q?Tj3V6JWqORXFQbONGxEfIXNN18re9XmuRNdK8pSyKqItc+OnysevyacFqmf/?=
 =?us-ascii?Q?j5t35AshJahxWP8CzVt3RhL8DyI+oleLsPwZWyz5ij6qHd+ciJ50JEPvyf+B?=
 =?us-ascii?Q?DK1rkaGUXtWmz4RPEOgbR/tWtCPlcY8OCQAM8uPiTFh8ZY2su8AL0gH9mCrh?=
 =?us-ascii?Q?EPpixHKCaotkHQ4H0ECzR02Kg7qF7W52FLPrJhbK/WBa+w=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FpVoudX50NpZG5fUln7a3hOvHoW4eqRd+ziotzwFmMNc9HUTLnyt6trFyWj/?=
 =?us-ascii?Q?VeRmodXwY//8uPl/Qa+ToFqGDCiGAWJNE8vftyO84rKSg8MbXUvIsdcG7fV4?=
 =?us-ascii?Q?/nrmBhpAM03pp4fZGmP5j5xBFzoZ5YhBwn7phdcT0idt1VxklXLDE/nEhHHn?=
 =?us-ascii?Q?IQA89rJx8cUpX7Kqm4Y1ffTFtqYevJqCiioz8RmB/X8+xBP/iUTyp6wBPWN4?=
 =?us-ascii?Q?m22vAs0CU++nS26pwryJe5774zt+FmFlziU5cvbmlk3p6+7Xc2tDTUhIX6Lo?=
 =?us-ascii?Q?qUSKtPiCPqaAMgfC39l7SS8zRSgHgZ+f7eDhqYAQEy9ew3Z9KmjUe8PNGYN1?=
 =?us-ascii?Q?S/IbdKl0RDAomIvIC6DvfLB6+L28syfLm40z08jGxV/t75oKsTR95PQ515En?=
 =?us-ascii?Q?hkW7DFFintgqp1phqAB1TOtVXmcSSSiFo6ABdfcJt8JT0S2wKy84Tfp0Sv58?=
 =?us-ascii?Q?VYuIGcPIOVlMDq/aM42j5kxqfNZ4LiBE4In3R+LJomdsNuvXoLtq6+wdrjKc?=
 =?us-ascii?Q?QTGrsRydk7AVLKkPJCQZyVl6dtVnCD6jo9B7xoQzsneEIbtHcX0jDAbMcX56?=
 =?us-ascii?Q?6GF7PLBZPvJyuxQg4zWW9Jyjp8MgidvSAI8IIPjeRUrmgGfmhQsd/Y33w+4K?=
 =?us-ascii?Q?d0bEmvS1MWdQ1aeDdkycnBiJ65Sn+Bhc0E8thCRMgZubbLdWTOzZkGyAAlUY?=
 =?us-ascii?Q?Z1ucysydZuGUxU8WMMLOl5dyV3USboegDoPbctTkTt6P/CEzx4lclHergGKy?=
 =?us-ascii?Q?xx4cjBHk2t+i5Vs1OqIeIDKwiJ9CYc6mT7KM/mauOOidpan8b/Tz4QLs5a2Q?=
 =?us-ascii?Q?oZFmTCYMW9JrAoiep+dabJaF9V6sSfeZnxY4GeL81fQbAscu9tFP7ay1w9nh?=
 =?us-ascii?Q?YGVT6M78Yg6TdHye0Zbq5bZWJTWstL8fYdGxMt4kkpWO6lfa+YxFdZhrdK9L?=
 =?us-ascii?Q?HRYpDWkYqQwHHCGuMWYsww9Hv0EwIxRsJZ8aDTTioKjphprF5R/n+Cyv/dEu?=
 =?us-ascii?Q?k2jjzoGoYfyIXEJnhKJt4fIJRK+MhUXtaRUL9mny5uxof9tBMXwNBUjlY9LO?=
 =?us-ascii?Q?0lkXIDyQGoaqowNGe5P8Z/2qgfgrHnISHt0EqYXQUAFDlfDmG25sF3ZCx7it?=
 =?us-ascii?Q?N5K4agef28a9kt8jT22QnueyNX0sDIvL6fpiiSGzsSv6ZP9m7qWwaGPMefGc?=
 =?us-ascii?Q?p2Ywiko/otGX5BmF1ga2kShj/ouzZ5nw1kGtxrgLJJFTTCS9qKn1LUwZgnw?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f91ec942-3991-4714-8023-08dda7264871
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:42.5009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

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
index a4cccb9110..f03a92a2fb 100644
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
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
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

