Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010014.outbound.protection.outlook.com [52.103.68.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165CB207DF7
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749483770; cv=fail; b=WCH7s1uusjEzgAyaqSpB3+GE5QJpWBLu5UkpSJkEAxcrRr1gp0Rd/ojuG+HK5pcjFtlVTeIv4lhqBk+NqsFnUvsA9q5Qn7c0x1Ja8zAxb5/XwgoAPKGYUKOqLTMD6pUt33iUH5ZcyU4fMacjfUpY3E9w7152RbHmM/G4Ewiky+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749483770; c=relaxed/simple;
	bh=DUIOMBYGVtgSz96OX42WYGcYqMBl/++QZu3fkKYESlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEiwXHqgxBHw9MjbgPbKBOLtUys65hCffLDF8X0qXdljbt4D/Of8qid+jq6rSVp6rxSb9TTH6fOjNO0H0IJmJZIEFJVJKCBqyg4mOx4yslPd+aILmjQS1h+opulHGfJdjC8u9GK6XenxEz8IQ55hqribyKHOBXOLUHjNHnrxvBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=Gx+PvxLK; arc=fail smtp.client-ip=52.103.68.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Gx+PvxLK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcM0XqZ0g5U5hzjBiF3CLA8V719Hrn+OnD8M1TBs1v2YWws/bONLWxu0WK1q6SZI+Ts3bcia53mlDof7kjP01PBl8dFgGbzuJpOxhO7t/BWj3Zvo8/zqdM+rnLuPJ2cbTrWh/j5xprTYhSAkiCNH956HquXlOaNe59Dz9sGo2j+NChlvIXmCIw0TO8CZ3/ApYqTHC+ptqFNDrylE9UQ0sPwftXVbzXi9hwhF4cACQULjMdReg4ZQa1KbfidTIVI6sTO5vfZl0M+QBQQ0fLFejP+5DPvmpp2qX9GLj/Pn5Zc7NUKqKCUJAVVbsFGv2Z3BGyUpSu0vcbMLouMaBM7hxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdOmmoOdwxQkoNxPy2bMs3GCFAorXM0APMnM9NVEVAE=;
 b=n/P0YWgAChFVEOORJm2zC+l80undK3XO3uxDo/7DWPBz+dLSEnuMFoNksRV1/mzZYBWLWU5wvZoydqOvpc2xNExq8F1Ur/+gQqEBwXPj2TQPCvVmy4RqxB1YxNYKrCgyOQ35Wx8dXBfgJtNFvrBYCpYmpi49GBkDLXVWoEPd3NkuQ4RWBddLLMxw29oPxKzx9hXefv70cjYKyil563sAawe4wxUnBSNfaSjSHWY9hEJWrrzgk+uk5OE0XBLcHP+r26IuMftFuRVvwKXNYRCgP9r3QWMlyh7srq+E7DKBeS3s3njDjCw8PxEKak9xhh+uDYYzpHIR3nRuFpVUPJ6gaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdOmmoOdwxQkoNxPy2bMs3GCFAorXM0APMnM9NVEVAE=;
 b=Gx+PvxLKcUJSyIASt1NOpwpfcUGJ/Cx2wll/KkILmQB9yQz4f+7sxlBzRT/9Ng5OLYwBEhpAFgq2l29CStUXbo3Fko86jm8Y8WKVdWZ3s9QUW8EvaUBjVbISZLKelPjMOvN7vIW2D0MCKoWACzYXTiW8pVR5Jkb/9Xku0XSSi/B568kTHKASTtrxCGqwGfuwxxtz5Xif+FtETIEpbpRbIpaflGWagmM+cg/Q7MICDPNAR8LHc847xT8IVgXgbHukkU72iGe84iDmKZA80wjxdfuQkxlmKkWFzkXHONNO6FH4qFdeEJOOGEkahBAhg/BUkS+yF4r1yPMmv6YvF0n3Bg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB5751.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Mon, 9 Jun
 2025 15:42:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 15:42:40 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v17 06/10] imap-send: enable specifying the folder using the command line
Date: Mon,  9 Jun 2025 15:41:25 +0000
Message-ID:
 <PN3PR01MB9597EF544FEE5D3C744948C9B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.824.geaff4db692
In-Reply-To: <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95979FBB320861CEE35C7F3DB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b5::7) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250609154129.13552-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c5af934-a809-402a-6780-08dda76c402b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|7092599006|8060799009|461199028|19110799006|15080799009|8022599003|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r3OsmBBmCtxAriVbEnaVbVl+kt1oLxDUYxDNErbv9yTfLNciJApN506+werM?=
 =?us-ascii?Q?rJuuOe0aAfMCMs+AztcTG7op4xsYgzde/t52HC1mY3t3HbhZsMuQXQ/5cYYn?=
 =?us-ascii?Q?gO8Z0DlSjMrTxbEST9trDwd1HNhN8p1buF56nSTGp2FRYUnYeeo1/Tb/8tym?=
 =?us-ascii?Q?rzzzkm5AisKYTUsTRrw4nimeSw4kZyVZkdWZx1a6ns+UM9YAsuCZfnEI9O6G?=
 =?us-ascii?Q?PfqsWIG5OyNxhEccSAKJy1n0MCWcG2ZH5YQCNKiinUX6Xb4du/e4azjZ46Q3?=
 =?us-ascii?Q?CL92yQEgUh/+VGunONdIfYR+ujzhOMIa0340Vyb7MNt3vxQgDlBO6fSx9Dzi?=
 =?us-ascii?Q?4PDaknZ+qX5ofH7ec1OpxgeyT4/ZlaQmY9P+xXCPHskBor+bCQoaNwI001iS?=
 =?us-ascii?Q?0ZgyXMhxCGq0uWqGb+v/Gypq/1Kkg84jdlCpe1McZa4aouwNTlS0mQbZm//L?=
 =?us-ascii?Q?VNTFTig06/IMwPU7arTzT/WEDXUJgi7XDwOihS+TQpQ776dW2AaKujHvXuPK?=
 =?us-ascii?Q?8N3qC3j7AqTCrv4U7IvfiYOf0FuD17zgCKgUosLm4zuP7RNkHWOoCuyiUQAG?=
 =?us-ascii?Q?CtNURK1bjOi86n3yKZcfn2u2xazCjlXLCovTJ8oBBjEq1APRChW2aTNcBPM6?=
 =?us-ascii?Q?mv6jpaW20S8H2C9dfXTg3MSffoMmd3lJ6RNs5wUAM2IHDqmI5b5gWKlBTNvX?=
 =?us-ascii?Q?hFI98eobA+ilM8HSu8yPq2OhoFgTIlNMk9Z1cHuaFKwNWyKqQ0qW/34k4KE6?=
 =?us-ascii?Q?uCnnjdji5zPD++f5w5ZUhoa/dnyM/u15Ka7KCt0/ViS6fqlPvR99eXcLjcuH?=
 =?us-ascii?Q?ov10Yx2QI9fJK5A4KQkMosh2xxjp8JPlvCjJ3Nsfh/tB27qillUEF1YMT0Il?=
 =?us-ascii?Q?nszBB6gX+fShIJjnmmvKX80X8WoQhvP/vpzNX/mkQKy+Fc7uT9XBD9Y7FB8k?=
 =?us-ascii?Q?l6LXdZppb6ZcJQ5iHyCVx03eoI+OIJc9i5aD/tjhEFoRJQTaPBYeYvURI+f1?=
 =?us-ascii?Q?Lxt2a1RPntgpFeHzD5pjifFSOR1gYyDDNPFZ216f4QwSaC3PbQPD0eo/7kUG?=
 =?us-ascii?Q?U02qcKMj+Eu71oA6CfCzdbaMjZCbhdDASf+m22UngXSP1u7V44KKjiOZxtmL?=
 =?us-ascii?Q?m9N0UjkuhIJqYmlpUAlKSIvBNmbqLPb6g0wmJlQZzJ3FPXNjQkU1Fb4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wuk1a1/MxLiXP9ZJ04R648y7AT4M/DV7ycSXU004KSa5az+X26vkwjOtLxa3?=
 =?us-ascii?Q?d1DQLOH2g44GU5tnTMb9vx5n2R0MFoMbtPTVT2IpsllI9H/Ukx9Lw/OJTDXE?=
 =?us-ascii?Q?8tD32qrFqbnGcKvd/bDQvfLijyeQauhQ1xm2xuazkDgF2bygcEaXXWXM+zGM?=
 =?us-ascii?Q?t4L5JC+tfG5KDEaTMjhPmPP+JNlvcs3SgMtYoEogQMER6sSWwooJl+cRKhVA?=
 =?us-ascii?Q?NltChXuKVBrQRjfI7i1hilTCh2z7TZiQleVzfhEH20O6MLxQt7jeyjhEUam/?=
 =?us-ascii?Q?asVARr2UD9HrJyI9L+sDMKgfvbzmdv8KeM3KEimQTOFtSoHI0BEAJC1wyTt0?=
 =?us-ascii?Q?f/fdBv4IQ2yVrjOtRDhQIeMbnhK8LCPV2yEkByUr1ihquKTIo9MTXPWL73ym?=
 =?us-ascii?Q?sacUam69PG+qF4Ow6M//RbCqZ8td5CQyefHRJMAVUAhln4rrusHGgqezuW6t?=
 =?us-ascii?Q?A0iMTabVnPqbbSyR7x2QMziIh3BvLo1wb7NU/m1Ad/4Yp/WZ50EHgiIMVvNn?=
 =?us-ascii?Q?k651sk1t5kmgCX44aDZB7eetBeEvgHS/1+nABbttIeLxbN/SszanfSTLFjHV?=
 =?us-ascii?Q?UQ1VxeRqG85BjARSehIkeWkEyuF2DRAQEx0IgtRg9DSV4jYr1bOvzfj80Oqd?=
 =?us-ascii?Q?tW90NHsQyA3oeJh6YN/oHqhDP378spe/sI8eoxzOZfk86WnBEfDRB1p31oIO?=
 =?us-ascii?Q?LL641q6vDkuJxcoo8zSu68e0PBL0Yq5pQkqosfBajeJhvaPK7H6I/MwkzFni?=
 =?us-ascii?Q?RB3NnUnOOZMsfKBY/Qd3gbroaKywY5KUBc0zDmD9O8aUuSRCnCJ1JW3Mr/jC?=
 =?us-ascii?Q?zCqWOA0smipccwXcZGENqIMFoES7VPVO2u/snEb+L38Jx0cKCZGtwFTjIlO6?=
 =?us-ascii?Q?KVFPfiMCTgkm6CDipYx0kVFHDL1HIQsGZV6YMw+HzlXvpzly8iV8ZyGKNljU?=
 =?us-ascii?Q?ae2FyitQF6q03+kGlb1/YoUf8gmJWqxS89LfZo4NpFdkro7U84B0pMVP7bUe?=
 =?us-ascii?Q?pjtjaZSDlmn27SV1eVaahNC7RXGzbOkAOdKFXmXgPdIqb0PlgVjqNDWc7mPG?=
 =?us-ascii?Q?s1tMogfFWnFT7wVBbyTshI5s6ve0SvnRY/0wXgp1Zch8Y2Qc80R+iKR4epKF?=
 =?us-ascii?Q?Hj4MqWyW23uspe+DOHAV5IgnIaot/axMYtFgRPoLrQTMUjnPqXqn7/vZIXsq?=
 =?us-ascii?Q?YHskcDuTFaw9kI/rbSKgYUjofXlfUy6lRDemfZ57AvfcXLQRs0sCkofnFqg?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c5af934-a809-402a-6780-08dda76c402b
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 15:42:33.4116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB5751

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
index 64f66ec67d..522d01c88e 100644
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
2.49.0.824.geaff4db692

