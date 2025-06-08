Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010011.outbound.protection.outlook.com [52.103.67.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533C215766
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 10:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749380243; cv=fail; b=AO89s4D2HVd6yOMxIMTqkyIzBwcq7y7b3ok4HaEeyTlk7cyD+9PlCg8C/cIvrr0zrFc6Loy59HidwU9Lhh1TcDyUn+KE3pafVI2XrB+yaqEBaLWqIiR/UYk3ousNK3lejYtOvS2zsIW6Ndw65PhWiWAf4eAVFReSGeTtXqyaaBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749380243; c=relaxed/simple;
	bh=lIM4IEJ0cy13Q092Wa0N3xaW00RvT+191CEfxFxM/Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aIx0xyzX4B3Kxae2P5O2NwcYqhEIDvyPhMMR2wYnhsxBsXPqj2vLl4EsJuZpeGq9Q2Y3wtSczWeodrmrX/uk47ygZEeRBIs1ziJAjgUCcOl+aQ/26ZfthMNaVR4mqboCmVRIscSgB3yZeWbYcW1JK8j+LyKBjRnkJaRYzTzm+5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=f3yVrIZb; arc=fail smtp.client-ip=52.103.67.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="f3yVrIZb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G2lS5TTm5jIEGjeejgvZw0XkzTGmXXCYoT8m3CPi0Vn44tl9T2uqMPOne/KOOs5JvC/VAykmhpit4zinJl8blRMIq4xomM0dx2pKUYQyvwmbZh/IvhqQIu9blpq2TtqtsFhS1HXrKdjRzDa5fnLqKJm6O818dJGHVZZlwfdOBkYaX+Yrig00bYhSTYkZ+arY3hZXse1D/10LBCQLkyyuwvlktg26MAy53E98yy60V2T/5GOvXplcVdfH7Hm1G5xts4omttB21C9EVg0g6Dz65rG1/LSdL49N4q9b2iXo/p7Wbuk+QCEnOrAw+hnpHYVQCZxXqwuS7cG1MZW+0eY0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taO50WurVCsRMbRCi0WLMfGr6JNQ7fFjbxeWxENkNQA=;
 b=yric28jC911SxT4A5M+IQjkSrVH8YUe+3kIxzu/772HEjuK4xonLwCFvy5eW9uileIKHdMe9VWkhEZQN8aMEby1OrSMvT9mcFP3+Nsvi6bEiVQl3tyvo+51TyntHhnpBAndqvZaAcMP7RkyCEEy6le73vkWAuSsXuDaV9eqfnDIM/jO0RvlgYZ/A+xdm/2Isn/q773dn5SffTYiYCbV9iZkBhP20TMgftW7rZm3/8MVCrEuLSun/VkM4OtpHFQLa/AfTKjFLvFhWPyaiD69EerLUa70w1qTubmKecTTVyQIoAQznvx6uVC3RiVXaHo8hipUJwaz2Zp6JaAJyP5coIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taO50WurVCsRMbRCi0WLMfGr6JNQ7fFjbxeWxENkNQA=;
 b=f3yVrIZbWq9yOGmJHUyXO3Bv21EDue/ukrhzFm18coIxrm0Zp+0IQeOURuh8p+RENrO1JE1CrMU/u3KQwFn87/32HRoKI8ljzy0o/CXlVPKbe8LiKFUjBl8vKBBfLVIo0qiYIbJ0FiOGdie1mtsyXJkNiqkFlDu/P9TyiA+bgpuQpOugj+1zq1fgGeUETGpsjA6F8XOcAa+kFYcC8G/Wj4TFIqT/JvaxPiHkegLWJf+1zo643LbqrZ8yIvZ75AFVrjoz2gISRaXZZ/cwJvKUFG/cSHWcw1vZnwxKVv7NoACIRH1zI7wegYVZMVyMcJACoRIQ3fp4qq4B00lPpbLWLw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PPF9841FCE60.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::1bf) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Sun, 8 Jun
 2025 10:57:12 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Sun, 8 Jun 2025
 10:57:12 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v15 06/10] imap-send: enable specifying the folder using the command line
Date: Sun,  8 Jun 2025 10:55:15 +0000
Message-ID:
 <PN3PR01MB9597B4D69ACF1E64AEF70634B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g4d9a3b5661
In-Reply-To: <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975598E2CF61CA5DE050BAB868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23f::21) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250608105520.18264-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PPF9841FCE60:EE_
X-MS-Office365-Filtering-Correlation-Id: 37393905-2236-4ddb-d0e4-08dda67b374d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799009|7092599006|461199028|19110799006|15080799009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p9IJLwh8qZgfL6TG2WXeT7ejH5SDGN0MOi0ZGNqjBlRdfPz0EvuWMrEr3Taf?=
 =?us-ascii?Q?ug6mui39/Id6UGuXz3d7XA+sgukQNQi9yJuNeR+gzz5m+aYZvX/w2IjMPCDU?=
 =?us-ascii?Q?Rl+8HIHU1sS56kkEvNe17ENHehr24PDnkutiuaFDm7Q6Dmma0zamF/k6DC6z?=
 =?us-ascii?Q?C7ZEDDNU3ye0Voby3RRpSyL/iUyG9VEuJfUcoU3yb/n+sclO/ogweGGguyKs?=
 =?us-ascii?Q?nlHzrJkxg8PwKdCTXYHCvAx/VcjRXD3tsQqSh4ruOOuXwdesAuSi8nXwwPGu?=
 =?us-ascii?Q?eu6N9N98OV9+sq5tqAETlJLf0m494V+PeH8LGlRFkhz204OxLLd+T4v527Y3?=
 =?us-ascii?Q?yzrdH9hp7EH19yOFR2Grke8NoRCxrMfI+GfZQqDGXQiWPVIDGotlaxQjR62B?=
 =?us-ascii?Q?o8k39yj5abCsguK7vfPrzMwHln97LqSc7+xuJzTrLplgeY2ul/u7GzeQe9af?=
 =?us-ascii?Q?DooGE5ROsytIazP6lT2rCTEcL8K4BFQrK4mebSC61C/d6KyaHR8V5rkDtPPb?=
 =?us-ascii?Q?sbbft9s4VD9BLoOhN0eCFHdbXtELVqvPgDDfsSpa5jW2dBE36MDGgs1F1Kxb?=
 =?us-ascii?Q?F192qRmahMercu+6tmk2NzZkBzIVDS/NypsIlT8FUliWPh6haHYlkp1q+Cof?=
 =?us-ascii?Q?tP/uITA5JdOp7XWsHlX90hzFi8SaZATS+pHoQA0GEHkgh0uv09CpZei7VhkY?=
 =?us-ascii?Q?ob2a7Cisb7ltmOYeAemW1+9pz5xbW91FljqqrRgMUWKMkHVsfPBtnTLgfgIv?=
 =?us-ascii?Q?6+mAhHv9NnusQb8VFZErDcWuwklBnyrLENXS/8cnwPgulT3RlT+iO5nJr17J?=
 =?us-ascii?Q?OzHVb/U9iNvYoHFHcXx5zhiiDXCfolEkcYJdqp2X6wMiHPc2BSqh0HWI+wEa?=
 =?us-ascii?Q?KEDtofUHvqOGKvGbJK362FlI3qXhRbTwkY+NoPpdAHaT5rp08ymbXDTtOEi4?=
 =?us-ascii?Q?TclLdEe1pvm/HiCaSD92UzecES/bgiZptcMc8lnVrgtFH6bLlJ6o8glyA7co?=
 =?us-ascii?Q?AmA5y0WdreDl6CEhZQ1HI5H+CEhN6wj8SEegT1iUWD7ngYaNbnP9E229kP9n?=
 =?us-ascii?Q?8T0yio/9PIucPo9kaLQety2xFVs4JolzBSsLPVshniB5g0laxkteUt3zwn9L?=
 =?us-ascii?Q?tkDU923Udk0lro65zCkAJtae9iaMyPxFaA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uhQnf0lM6RXwSNhlU9PnVZv+aa9Z6Z6kQTFmDqKhh0GBKjGtB7Ba3Q3QkDGY?=
 =?us-ascii?Q?Pt5aEUP0KSU/hhjjdXHFkudRPIxnVVU9g3hGukMGV9tSUd+pvCdH3YRemA1q?=
 =?us-ascii?Q?8WBPy6COMdDQJzxzbmlHLZOovCjgf2oYnSb/rGw2Sq8iG2ZgyHbF+13p0WHp?=
 =?us-ascii?Q?D8xMXb7Zbw7L12h2QCozb83e6+plAIdpr57VjIapz3nCacnkxwgz7ffMxTZM?=
 =?us-ascii?Q?i4HcGqhYmhpDl+e1DJYT+UtmcA7QC7BCFhE5fZ+nMgYBcg6glVV07mQJFyMi?=
 =?us-ascii?Q?hgehZkIEH1ZySf+nYtj1ZvKO2Benk4PAxzRbv6lc0GZwABXlDAJ4OKXhUfHO?=
 =?us-ascii?Q?ncqDmWNj/+yatGD6EK+4mBWxEf0jasIxTniFLCcuJtya93JlUUKS87yGZ6zr?=
 =?us-ascii?Q?uPEsfXXCLTn8iSxbNXIuvzjwndyu6Oy1N7WiFBy40G5OfYQf5e3vMj9PE6QA?=
 =?us-ascii?Q?U/uJhrPW7J4ST/VibiGJ0sibToC4mYH/HO50xx9aPRONL3WmiPZ4CSExGUpA?=
 =?us-ascii?Q?t3/sajC6xhecBCJ5Rlzg0oM3wONnkrGwaHbgZPR16KmMAc/zGO02zN0gPawq?=
 =?us-ascii?Q?Bq7OvlvMPuNFV7HXnQRnwRjz1g4E/WmV1c7DuQwTG+k/NhIS3xje69Gw6u1Q?=
 =?us-ascii?Q?pVnjktRnK7CfN4fCjrAMZSIrpn5Y/FCd0CQVwpXiii9twRV6Tgfzw9/+dIPv?=
 =?us-ascii?Q?4BYXDjEZ9Q24375b3D6IrtI4wer5w0MQ+dqkC5SRA6M0udpz1pEt5pdXfJZ9?=
 =?us-ascii?Q?rs3YW5wX5GVSwjcJusI5/IrJI7FxMr15G76rJ8uUhHb7m6dxkIgjhF1YjUO+?=
 =?us-ascii?Q?UdTeMjbaMxFoEOVKomUjScOmuj0EaiRz1DEcY/yZHDDJJYYdsL8HTJ1WKSPL?=
 =?us-ascii?Q?ObfwOLqwKBiyl6y7WtVuRJSwvzNRg5bUzFDBUVGSKKhDuQO1cQhXi5qasyw3?=
 =?us-ascii?Q?/tJa/BlGJrsvxNx1uwXF/9E05Kk6LAXUrc5cPzPTQCNZXBX08QevciUOPyaA?=
 =?us-ascii?Q?VTUP9z4xPw+yro+FvGYTtP4OuUbQ8mt5ALf/I+aSPyiswaiLynDr/pAMnZMy?=
 =?us-ascii?Q?NqaZcqn3T+Evs3ENXAec161edr9q8nfxpta6rsBngfpteAmDWUiky6Xf7r6B?=
 =?us-ascii?Q?931hEEPq12M/1DIiN9IV7J/c6hlHM90xOJhLi0C072UWt5rtALTQ3J65Fcfy?=
 =?us-ascii?Q?HwVNidLDjBOGofDA1irfK8gx3hlnn/nxCfJ9tfv7gDnXC7KfkFzaHFjGFDA?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 37393905-2236-4ddb-d0e4-08dda67b374d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2025 10:57:09.7455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PPF9841FCE60

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

