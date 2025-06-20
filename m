Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C372221DA2
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401669; cv=fail; b=OYdHeFHeBYwo3juv99JbIt1VtXFcVDst8FpIGB7yfwB5Q+jNrbBdXRzaBXvBY3ykpCUUkhs7x15wQtfMK53fHr5u8V5Xbb21l/75UouSpeeys1XqTi2sAhDgXYUCc/FsFc2ktrwdGEZ6WxYBKib+2q4bVPcMDMmFpIbXQEdRUqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401669; c=relaxed/simple;
	bh=AIYm6p4EJ9jarTQjLa0vwoyvXgqj0jl07Vuuv0kX0Og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K53ysXpcMIuJo8xsTMSKy5cOfosjL4znkuw8VaI8I+8QCRwtgs9TDIFMR3fFKK2OVJ7dT0tDVEhiTpOr9NiGXHZnlvc8YhDBjw7lFSCCcW+fsRyv1xOWmczbxOIdK5PWy6SrjRh6hevr9XQu36bwtmEs6hODQBQtpyuNs1yW0EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=CGDSyelK; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="CGDSyelK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ssqYQLHT/2rO9Csd5S1yLZDmmyE6pvnDJzPRHHdqwsxn3yT0W70Hlx2vGiu9GrdnwtGI79DV68/LO9WIpmD2ErUD4i6L/0Z8LcTfjAkBVX3p5LWycMo+1JIfu8GhEtE9If6GHwW5BR2++k6vWdy7NXnK+lVIauAwJWtDExcllYmTJ8Hsy7XQ0mmp4CWl9c1wvXLm9pLllV0MiBfu9IRIcKqheSdtixjNmzraCwo19ptFkJ9qjupXMjawHDMJ34+/D02A9mvnb2/jNff9t3ZEcwFWGFS86qtK0TKrlfF54Aum67/t2w5DH53BIz8QB1LMv4azMpm5HqNNrMR5HGuh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8p6fitltEneC0lmPEeIQEcGSJZx7d/sIknhv518Ebc=;
 b=N9bzo+HR2jkfr7oia29nzRDAdMAxggkBIImg5hcWSI+SJYZLxmUG+rAeSnP3mRze52kTlyi9SANzS8UU62YjcTOSQgmDKNxRzH8DXl7FaQpfv1H/+blCs6vEIMILhjGku2SqL0mz6JVUctR+qXXBRNHWEhrzLmNhoOPdB8iN/GyNQv8kxMaDqK6h/yG0wChPW/xjXEQtgnu2MZRbmKreU3gm5WrA/TESzbUHrp9qS8H8lyyznFfz7jua51bK1f+QBkuG8svQFfHSrG+RdKqK/pEtSZ3dlKLO754h4WDP1oPVRo2aWi51eirUsjLBTpwqRUocZy6ztL85RfuITv3R6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8p6fitltEneC0lmPEeIQEcGSJZx7d/sIknhv518Ebc=;
 b=CGDSyelKQaRbqTUEqCSeJm5c0GRvkP8vBXGwLibOnTUm+OInS9zO0qbw6sv9i7ADWSc4YNu3AkAMqvNPQTu3Q3XgiEKhhoxbFGKlnvmCixV29g+pPXJrE6KfVjVQ2U82EQs2nKuGsCg6hfzBnkeYIhQTGpj9VgXgp8yultuZ08NxbDEv5iMKoEFaoI5YxmBlV2XTZge9kNXZKPUtgtII37JwW4+gFELZg8D1YGB4EXYzUFGobEsf4R76ZIGd/zAuH07GX6v4KpGQkWMfvmaR6L8YRWCkHigH66jdSfSiqWlVYmChm2ir7ZC/XXeLzt6R6DqE+2BNLm/qGSA4c6kt4w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:53 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:53 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 06/10] imap-send: enable specifying the folder using the command line
Date: Fri, 20 Jun 2025 12:10:29 +0530
Message-ID:
 <PN3PR01MB95973C003222DB86833C599CB87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597F9CAD0DA83152E651194B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250620064033.15814-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 1927519c-9721-46e9-b698-08ddafc566ce
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|15080799009|8060799009|461199028|3412199025|440099028|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y5rnu7qLThpi/iO1zb+Cul04SYtPBWkJq0oEXKJ60nmQ0bbaZemarZtRZnNI?=
 =?us-ascii?Q?BsB0EsQFZepagjaHSFKNR8zFHfjSrRZ1kMRWh/9kNcmikXMeqUH3Z8jldjoH?=
 =?us-ascii?Q?rXKyAXZbAAbBpZiwnp/4WC/c2iah+5CFm8f0LbsdYl/BaMz8c2VelNzcps+g?=
 =?us-ascii?Q?ogTl7sUB2IDYOICWZ8bx9KxmcsGYf6dY7Z7EvY9nky53Ww73qPf0fcPGmQG/?=
 =?us-ascii?Q?BOu4vEWucD6q1ho86UcQrqCfIpDrIwTCkvXC1MSNDoZJom2U8k5iPeRdULf8?=
 =?us-ascii?Q?CBXNZQvtW/jZ4OHIM7HQFhwD9xUUPRl5CQucfm9leH9bFCrq5RbvGddarg0s?=
 =?us-ascii?Q?D2e/M26fnFUIHyJUNBLf14tkNZc54f5//QtqXe+wVmvgcYbc5cye3jE/afv4?=
 =?us-ascii?Q?6QpckXkTh8Q9rxwOP8uNH+KckC06lFQ1Gvg5ereZ9lYIHpD1m0I3itg8QeCV?=
 =?us-ascii?Q?rviYSgyLD4rls+QAbs8Ipdhq3lEkr6fyeBlu0Hx3ijM7LRwtK5UtW+kNLRQz?=
 =?us-ascii?Q?fPxC0QssE/jaapirRm8KkvwrO2cNhjHZyn4RRpKjFGUONY+UFRE2YZEzN5fF?=
 =?us-ascii?Q?u8ON2npKdcWor5QbXCCRiAtuWZaimT9/sP44goqPyyvF8Crsq8n2EcoPPq5D?=
 =?us-ascii?Q?k3Qr5QYfxe3C74L7byIviLhR7dnsYGJNZxeCNrcoxdZjxx/7BWNSQ7AQqHot?=
 =?us-ascii?Q?rczU9C+jXUbHOqZkZLKhzxRSDLaVg5B95g9Y6vXp/OFVGecdHQOps3h5hmXF?=
 =?us-ascii?Q?fLeMl0/FnLyYZ+3+c/Q5hQSfqEK1Wd8M392julTJeWFF4LGOoS28Y9eAyrEq?=
 =?us-ascii?Q?1d1MaPgVyrXjgWi6N222foAh+ieU0RYp7SWV2JrXi5JRIKLVMYXyFzdeuvoT?=
 =?us-ascii?Q?yWP+KlwLPKx2OusnWihAH1dCjLvJirmWFjzrVFkKpU2Tqp2Skpkuuk4csbra?=
 =?us-ascii?Q?fzIXiwPWVLhgWokDpAFoQJtQHdKHizYEf+89L/DTkv0TZh2wlN5cFGJfqkXK?=
 =?us-ascii?Q?1CPvlgnx3qvES12p3gVPktlAZMgP3SXOVVpPnxBlyAU/4biSmwWYYmppahPk?=
 =?us-ascii?Q?aBIuYcMIJC5+bRUMzB9INf1Df3mrwza2KanxsbA++upNHjbtkTEbxMpSdN1p?=
 =?us-ascii?Q?JB0QY9S/1Nkzj2uZSdMPfw4UAz9upSV2NywDamLvE+VVVqMauC6/uo4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q7mA3qhub0QhnGy6BfLACd+fQnXVw5GJTIJjS2Y88sAp24oHV3S+E9jIhpiM?=
 =?us-ascii?Q?/KvKebyUJC+qZJ94sRzbHdNiktBV2VL+u3+usRfBCnjcceIm3ZUl9Kp83XXZ?=
 =?us-ascii?Q?mvfvVeBSEmOCNgqZkj4Mz+oWxS4OyEQ7fly1hrYqPlVBvsd9BN6CX2alYHu/?=
 =?us-ascii?Q?vCmXDpQI98KUaCWEC3c2fchHbaPH4DwQUzqjOsOPYZuOWhAvab7dFev4Eea8?=
 =?us-ascii?Q?rc5SBhk8UcETaicwWciaO4+3xTeqj9F5VGnzSjfrwJhdHhk3nOaCT6l1bAds?=
 =?us-ascii?Q?Cg/ySNfmsjCf42boVbj4QS/o+cda+q0Ws81N7Ub9qD39U4Or+M9WA7EJ9Nh8?=
 =?us-ascii?Q?HuzT7M9ee2vOHaUCB3sDPOU4yHzAD3le8BKXfZjD4tQapqfur0N5wBg7vLhA?=
 =?us-ascii?Q?YcI0yI4kRXnhTv/RNqidjxm1UDoRxwos/UOYl8orCIk3v9PCyX65cTbEeHw9?=
 =?us-ascii?Q?+xdJLm8grYPn6eMmQsjRG+2kNbULNv9f5gP8y/mvQc6bmTPvRh9fzAia9anQ?=
 =?us-ascii?Q?M+X4y4tv9Sdb6rHDn/3PTg8AQstTlYsiUh/6NqRyGD+gxVDvg0ZgD3XvQyYM?=
 =?us-ascii?Q?BXJThlRg6TESRuHUmMqOPP7yvagIANBRIl1fCNDS2ttOxxOoH+y1YWLJ7l33?=
 =?us-ascii?Q?mRVLeDrFuSinbVBHI7ya44/vkA+9nbPKjt7bVzB0juNHsToVXIFTb1HnCOS2?=
 =?us-ascii?Q?HG8yeFuTGe+YFIstCl9ulgQyhZIkUgpk4LZDt6/oXNn25QtyjuLbYs7liqhz?=
 =?us-ascii?Q?neBHgN04LIqVsYQK91MQfYqHt9TbVcmmx9GzCRux6RSF2Mp3xNO5cy56D9N7?=
 =?us-ascii?Q?JY7QpfZUnuVG6NaTLtfGOv/oTqI5IhR+/jX+tE3DLcqYzlU8ZHY1j+6wYK/Z?=
 =?us-ascii?Q?AQx0mtBB5tAp/CoMOVT39wYVlNBp2j4n+6X5A9agNSHIM4HXI7kzgmAAPG7L?=
 =?us-ascii?Q?s1gu2Fdb3bERCZonp1y/36N2tyX5Kb9QUg+XuoOk+SJtVznFXf77DdaAup1a?=
 =?us-ascii?Q?K1tUB/CZxNtvQKtJYfVMsDP1/zkZgkKj8aEwRdnu80plUhFP4fL3Zs2J5zht?=
 =?us-ascii?Q?8TQlFr6Mk5KKGePaT1/CA8o54Cj9/sJzevAX3uPuQ5iKKTqH5DXMZE9VfBEy?=
 =?us-ascii?Q?AV2KUz+v865MN+u4v/8wti5/lVVyO43i8UG7xQMHY97UV7XIn28kMgOrpjb8?=
 =?us-ascii?Q?h/ERepbcoGOZ7v/sgF7tSvLtldLSW+diqKlzoZmDO+HZ+wrr5/srbMUShj/q?=
 =?us-ascii?Q?JIJXuHPP5k+3ZtEeQ7LpY0RwOMaiQHzLPnKF9MqSzqAfPl+soEJ0slgSo3PT?=
 =?us-ascii?Q?s3E=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1927519c-9721-46e9-b698-08ddafc566ce
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:52.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6749

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
index f3ba5eeb5b..7e021c8392 100644
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
 
@@ -1722,6 +1724,11 @@ int cmd_main(int argc, const char **argv)
 
 	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
 
+	if (opt_folder) {
+		free(server.folder);
+		server.folder = xstrdup(opt_folder);
+	}
+
 	if (argc)
 		usage_with_options(imap_send_usage, imap_send_options);
 
-- 
2.49.0.824.gcc76007b2f

