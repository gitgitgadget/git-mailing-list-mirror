Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5141DB356
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453721; cv=fail; b=DnuSUGP2nxoGBC29ePzfpLGODsP3xi5C4NFAHptkiFf17Vn4fATV/HrIJBVxmGHiEgL1V5CCpYhKpNEae2S5AJvF4za2aDPyqo8uidmSzT8BlcOZFdaGLHGvbSghhlS4OX9dx545+TmzCmBB8h8cYFHKiJnNaezqCh0nGQLLwW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453721; c=relaxed/simple;
	bh=lIM4IEJ0cy13Q092Wa0N3xaW00RvT+191CEfxFxM/Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tZwyAX0Xv2e90y1Rn4MpAlABB+W+QKy96nwyAKiBNP7ilixGt86jcLrLlGqPRraDnS8DcX++1vk3X6Mw70ZA0ay4hxLSUA8H1ijx+cUSEuo2Eo0k2wkn2TorTxl0j5j6yGkbqDVdGsQybZy31wYEuNy25p6SjWsBK7WyGUfBJQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XzSQIJTp; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XzSQIJTp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZiOh0OzzaTYW9/uprDyF2V3SX+tOa6ZYKFdHV+4+o+HvWxJRdnNRyMpW4drRphiLdg6EMTKhltczh7vbffWotGafJo1hSNgUA00UsI2IXQxL2E1trdP+9gqljAIw2mvC37N760NKesbTYUA9Ztu/Xn1racRcOQmPdVah7tdcBFHjILEvI84S1b3AGVd6pOn7YULnoQgSpIC4MRCHrKUBfZSBnrD9RxBvfoko1VlYpElaghiOm9GH40NQbq2Qkd7NEP66CBxdu1SPzh2NY7PHf2Mb9XenkoYb47T3tXVYh/6QhI/9K4HoE3itoia1UvylLhIF7PLhJiUyjKe+7LJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taO50WurVCsRMbRCi0WLMfGr6JNQ7fFjbxeWxENkNQA=;
 b=UpTsIQK2Rt9/au+FBGT6bpCT7i74sJEX1eaVea1rRFZSMKb6dkGxt/qc/tMwhEqk2MKRHb/ON6t/6XyJon0lZOOnRhbVIlFs662TAOj7EE9h+7qGFf2PM3fzY5mQzzxwvM8QG4Fb6HFOk6/GgKNdZfPPmTZPyKwZQWFZKc7SKTKBsdNGQVGuQJITuSaHVbItUHM0wjf+IdnVd+NRKuh8WTKDux/qmAjtFSOCgQLjU1B5BTG2wugBg39VsSFCl5lrx9+Lr0P6tsqzr1qTLJcH/QIS79csyGrUbT2/6Fg/pUPl6+XxeZxbEUyOEbUsVLfKWLC+59x6tL1Yvlh7socdkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taO50WurVCsRMbRCi0WLMfGr6JNQ7fFjbxeWxENkNQA=;
 b=XzSQIJTpE9xfbp7+hpXMazWoQ2OhfgygFDFCeo2UfaQMgudhamNFJR3jk/Wg9GmFa7/lCVfDQZ4VcpeVz6RJtPG4jg155g3zqE16dZQFa/gki1GOB3wBNp/SlTfEXWPe0bG/jFjG55zLi3P8bMh+iBeFSmPtUSAzzTsAL4dragyDcCqYBUQM9ZIPQa/d2NXROqUiGfF4lrn+K2M8ACpEHsHSoD43eVgA1iGqa/QvmKbXgUjxAt8BtgOwHgfBXAn3xorj/1qWjdZHTSNqeQXRCmsQpkmf/jBY3i/Doi3o+JgEgmI2wguwqP9sMUxeaZL9QiI4kKCHz23nneJrMUG3iw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 06/10] imap-send: enable specifying the folder using the command line
Date: Mon,  9 Jun 2025 07:20:37 +0000
Message-ID:
 <PN3PR01MB9597AA90D615E2DEBF62220DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609072041.12114-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e36c1c-208d-459c-3b91-08dda7264842
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|7092599006|8060799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b85QmV+BjbN0zl+quVOM9P9GXJnxzgZ1f3WIN58mUEv/0/5bnxIz6W2ge0eU?=
 =?us-ascii?Q?0c9OUhvbX/3Z8eI/chOP/DMx9/cwZIH0/Mg/51HNrZ/0Gu0Rgz5pxdPX1Sec?=
 =?us-ascii?Q?pF9njZRJPEsryGLyZ4RNgwxG1MuAyYPXwbDxkKBp1ICQzTlpM93O1FL/2ScR?=
 =?us-ascii?Q?+aQ24BIDuRZdKtQlQoWItuEqTZb6QTVdcWnfSTJdpRGgHSAT78vlVMZP4HRZ?=
 =?us-ascii?Q?DhzuHWmki8zBPuuy5kgAgiEOQZkWYvdq/4J70h2k08fVHcfpOTqvcRU2d3Sf?=
 =?us-ascii?Q?j6ruhsGRTQgH71LS2K652Ivf6YbOw8g8+DPz5qQyub0igsujy0kTIfmZ6kQx?=
 =?us-ascii?Q?2uU3GMYr5GzRrlV8ga7laM6+sYN4oAsLQYm1Ept0FoOJxResS5YvD2/IFSRb?=
 =?us-ascii?Q?SRzgx9Mly9pNaP+imY7zZfOaVKpghn64qw5i1rtGn5d2h0f/3sgqdVjuu2j5?=
 =?us-ascii?Q?DV8eoUjO0Z7beJP+Bzf9xW8g0ralWZIrU3+Badj7GJLeHQoxlUvDBxAAzb2P?=
 =?us-ascii?Q?vyI/qQCwwvVvdQu1Lxc1crciJeiYDW5bky+nuRz66B+4MCwLsE8/fW3mpVDA?=
 =?us-ascii?Q?DXD4tDe21nR0TbQlcTQsFcQtt711zKLbvHSurxFuTr5Th6XWPqbFvfr/Orzg?=
 =?us-ascii?Q?M+1qWNOKjIa0grwhFhn0Bu3yORh8mHXE5Z5MhLGrQO9xnp3Qi5Vzl0erwRpv?=
 =?us-ascii?Q?0OlQT82lOyKIe9V3UnFKS0/OOywuFQMP6YK9Ta55h4w7aKq6vm4NsSyOZAIJ?=
 =?us-ascii?Q?+obcpnXJpmUd7U9muwa/xWfoNlvXm6/NvspsopnzGzQYq8CikR8W9+/Qeiph?=
 =?us-ascii?Q?A/tVi8qeQ455x8VwcBbxhRN9G2ed+3CHdUr0MC0Zhi+ZKRO3MLMKX4wkC1Mp?=
 =?us-ascii?Q?xDr1351daDsdUuECheX5Gancv89sIfWUaU2vYQcTU1zNkUl+jCbVcywSEQ6g?=
 =?us-ascii?Q?jJzlW1Crx5A8QI626B7J4wLHTdBmWlysc2djDmhqEXfAlJGfXWg2ASVj17Uq?=
 =?us-ascii?Q?TCuijVbAmLz9Tkj6sEyzwugOnf1xER1L0nZjgkvv88D+Jj6E/13BfHhpVpvP?=
 =?us-ascii?Q?n+alPZNRjSmxKzm41n9AFDHVoT5m7bNa0oW6Rvf6xv8Q9L+UlV3iHmovzcjx?=
 =?us-ascii?Q?ZigGVD3moEQB5rGQ0+DoAiCwHAmEWQuMbQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkYH1jQ0sbkUhU3dQHA9ZAkC+CeneZJN03XDcYZ6vzMVXBYykOX42DUFu2bm?=
 =?us-ascii?Q?xHDfG1Mh3XDe+8MwUrMablaamYMaVwENGFiBJX/V0NKPFRbLPvleaat33Lwc?=
 =?us-ascii?Q?EI1Omaw7Kuya1VnJu4+5Dwoe/RKPnrHcLuHMGXMWZQpA9yQQcV0rhM5RKHye?=
 =?us-ascii?Q?E/C5DuLUzVjHFpnyPFXrQeZdHLXhQUcAWsO5fqN6y+udTP3nEDZ5ivsnMQch?=
 =?us-ascii?Q?YxRAyVx2JhCTo1IJbo4kLSaJWm3Cv/eoinY+tu8m8P29hMWCOZET+AGDBvsc?=
 =?us-ascii?Q?zA1lnbX9DfEfYE0aZZ1lzBlL44Ai9+nJxpc7vSxtA7A3mM+cIBf6Xdy6ZsnI?=
 =?us-ascii?Q?jPYTdPAtRMv6hdFVYxsKVHCI8K3Q0FSxoVOw7oxyx/4/QtoVpUa/LqLxyFdk?=
 =?us-ascii?Q?ocBvKi+WkXEUuy3ghBfSPLrswHjARLIPobKYrZpBgd7Ln/Qu7PROQ7rBE6TB?=
 =?us-ascii?Q?Btz/GtjVfR33ZJFl0km73Bv99ffFk/rWOm8b4ASMCy4EpMZl28J3FXtoaS6h?=
 =?us-ascii?Q?1IHNTOW/HjAZ5KEaN9gzGNF8vyBVo/8IxHs/loO47IabRy4o6wr6cwY2FHDw?=
 =?us-ascii?Q?iYTlv8k0rFw60c6C8yINj3jqKOEbarpzgdY328sUs7KaY2rD+Mi8sYyFn7sK?=
 =?us-ascii?Q?sDsLKKsiDpbiNUlDtjwcoG2pgfmFHDwxINxgQiWm/ZitFlxbaEiDf1CUpx14?=
 =?us-ascii?Q?h7YZCUd3bvS09xCAXHtMRj0P7ledmduIA1y8wppBWbE1GCMCtV97QLnXgWFL?=
 =?us-ascii?Q?W2+lCc9UDN4XO/uLecL0XMCddzOqwld5xK4Vc1hVC4dSai2sJH7nj1o5112x?=
 =?us-ascii?Q?Z7xYFk581h4Vk1GZsg9nfzZ0PIJlD5+u43ROQwYZPAFQ7ijPF0cjLBzjb7TN?=
 =?us-ascii?Q?V10vyfzP0OQNtirfX3t/Gf48gNcw34nVfHB65foryC8qPbwfAdSUfEsPNXg1?=
 =?us-ascii?Q?Y94vWfQRxcf933sqXWJCTn5xvNZfdsokoZdtPqcUOoDkst2TRIKFZyIjKdUu?=
 =?us-ascii?Q?HbE0yzz3U+oJ3nYPcrdH995JiHquKQUGr1syzYKkCkICDX64v8CGlX9wwPRK?=
 =?us-ascii?Q?8N7HKJGDEluvRLq9a+CxLsDpq0J7NCL5hgGoX+Z8ub9rIQNlCuPb00IzzeXq?=
 =?us-ascii?Q?E+BjRnoIjlPPfGs9Uc3eMCGKFivWCIo9AUND+22gzyrNo3ROK6ws6m0AJQFT?=
 =?us-ascii?Q?qQnDr5NiYT85NJ5ULCSrZUP1XlFaGn6wmko4961wxRllsk5DoyGZOy0Vt78?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e36c1c-208d-459c-3b91-08dda7264842
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:42.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

Some users may very often want to imap-send messages to a folder
other than the default set in the config. Add a command line
argument for the same.

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
index c6e47ddc42..a4cccb9110 100644
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

