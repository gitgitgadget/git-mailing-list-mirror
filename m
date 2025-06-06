Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010015.outbound.protection.outlook.com [52.103.67.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2798821ADA4
	for <git@vger.kernel.org>; Fri,  6 Jun 2025 20:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749240545; cv=fail; b=WubhiAwKuKc+Yty/gGv1gHJPIvZhv811bWQSFjWeBNTslPczvNTdhGP925LV6FAIr971Jutmqlr/4MBUidUOEvr9huGn0jLDuXB2C/BHm2joskPjKDGWwrajSkeNyjh83YNXa4bq8tPgRzFOxREIxH0Ut0p1Z/1Ky6mgXH9ZuUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749240545; c=relaxed/simple;
	bh=lIM4IEJ0cy13Q092Wa0N3xaW00RvT+191CEfxFxM/Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JbXsAVbEjtGoAmdhDs8aC5o6jBuif8UT/gQqquJwTrxVdN2WNnGnukPUoRl1dlNzT6RQ1UhtyrJG/Mdc9mGP09BJblj0HGqJqrdkLcHD4PqWkddmEN4jyEjgiqjy8c2qV8T1GsTfpEDYMM3YLAGMWMkDKgLyoyzldqZ4qiRCmFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=pyKnXufv; arc=fail smtp.client-ip=52.103.67.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="pyKnXufv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jD8h7DEGFNiGg7jgnCP3XSgitkNj/OxqIsfE1EQiSFRtMZOl0dxaABa0+Jrx/j3gfRqAZOUjQRC4YQe43c+RHk37Kh1uYEo9iFx7hcbRGu8RvH06+4bQMqt67wbg5yOuQtwiuyza7boCj2CnDyrpM59EESBwdlVeGYuo3644ZEscyLlDrw3C4xfgEGUx/Umz3+GrJz+jWBM6ySpCIEEfWoie3ipiZuBr3lAtE/V637ScN5ALhTXAQNsiXzd3BflI7jqQ9UTecnG3dHUJbFo6kJG9jEj1ddoniv7q6q/Be0r+5EL+oZEHrbMZ/3ibwcVb0PNHpW7Xy28ABjN0iSzgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taO50WurVCsRMbRCi0WLMfGr6JNQ7fFjbxeWxENkNQA=;
 b=HgdWXFcNtnLHSzazXiM8XfeEdNYBsAU6TA+QW7AMhUCyZGAfwFG54VJyoThjL0bF8GFfFvUheQflDHf0LzxnTS0H4bQOa6wpRuHaaEs5dGxN6l2K/l2EMWdh3fKQRmNcwxP0f6tZW/L9Eh+4VcL7goD4q+TNZrfPDu9X2p4kY7b/Qkes7cZpe5j0cNp4PD0USt/y1YLQb0TOFPp95ofK++D/lMWPWpEWp+z3oGJN6xzbk/0VzUzCKiNUUCZSsMmJuBpL2uaugaZvMPTi/aKUS5uohTF3TtDh5hHqUoWNkb2quMEKBCWDekn5hA3jZk6wEk7MxgWmFpMQvYokm7YMBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taO50WurVCsRMbRCi0WLMfGr6JNQ7fFjbxeWxENkNQA=;
 b=pyKnXufvDyzj5y+pceckBck3q9FH1P0vG/xRF2GvS0E0+Ozm2rHE1Vo8KsCbXMLGfhqKyAfzrlfRAinAT/9KA70zxBH+tFYUN3RFJ/hni7kHrBzyomzreJf6zU+bKdMe50ZR4jcz9kBiZhFg3jVRLOq+ZOU43TpVmsd2rwgxCGHFTWbuFP3JnY+LClGobX5otZ0cBn1Magd2M8+iEEqwTP13tuaVwEaNsBGJLo7G29M4BrWS2khjjr/GL6oyecAbZgEeSU5cq/nLkoSvUZcmnKcL34KbgiPX/EPVxvTeaFcN5AEEh+9JT/iRZKI3lcjRHsJVsleQOltHYinZx1FEdQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB8841.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.21; Fri, 6 Jun
 2025 20:08:53 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.021; Fri, 6 Jun 2025
 20:08:53 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v14 06/10] imap-send: enable specifying the folder using the command line
Date: Fri,  6 Jun 2025 20:06:28 +0000
Message-ID:
 <PN3PR01MB9597F000B3515EC0A11357CFB86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.639.g0975df9fc0
In-Reply-To: <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597BB453E9980CC50AA6703B86EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN5PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25e::12) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250606200632.43298-7-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB8841:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f306de5-b255-4f02-a7fe-08dda535f3db
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrOwsKBlx1JOgp74JtkuEUkO3q17r/elbZYBEGnxVZxwDlmV6d52sZVSKU4kt47vN+eMrZvO+H8diVajl86wWQnuOTieB9MaMGHBuQvT3vMdMpkeYefVHuf/IjfYid+4FhOb+0WSfVWOYIJWO7veSkINLM2bhN69OpZhgWIQRpBWaRngv5tGm9KQnxKp4DdZDIuCYZ/FNNxIK49FsJ9QCKRPK9bUdSzHnCORAmMAy8/Q/il0VrOM1Xdz8ikNvxA7UPD4K6zXpuwiKt7B9SKH9aLCFmmbz9NplwiFR4HgefYnxVnKaXIcgmnqJe4mD/1BZwpihHWbxLPHC2ujJyDS80AsH2GxSdvtdWSBLeRCxX3YFXwSc9kcg/wyv/i9mimRyD3W+2K9l8VNHbcOMsRSwQ2gEBEGY0BpqStOkDYD1ESPcWTniXrz6zjmDj3tR/ZSjv+6dbPMzjkSZPy8iHtP63PQkGGZBIEu1tlVP1+OUfJL3SQtzQDBhy14Rki2ofUnvywrxN59F7GY2Y6dJNhrB5gbML5yqPS9r3R6n8SyWUJxD95qtYYwidGohHQmnlDdMALdfa9vtUljvgQ4Q1l99EqTnYlilh/cOPprXK15Ykv43q+3PdaABaYWShXbOx47VfiraP5oRUspBYIZwMHuAUFI6etRGtp/Xgf6nAhrGn3Lq4uEvNYaBORAw83MkrqoPltHZUKngvzKchnD/ue1II6xliAko1SDMVAYRMX8N6Fd+xd+EAoXbGZ5g2icgy1FAbE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799009|19110799006|8060799009|7092599006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1LGhL7ODYRigO9/DsVsQde/BtCmSuTGdE/YVZV9Z6Hn+rk/+RBIdnYIhIAyN?=
 =?us-ascii?Q?GNcGJQJwM6Q2m9YZQOOhG02KsUTCEWMvyfRqnFLTPhCUjzRxVzC0BBBZ28fm?=
 =?us-ascii?Q?wgUOzuLVYku759s7C2/4Da+H5NcsXCQ/3Ef0Xgt/mTpAOL92ol+xh3BeWmY1?=
 =?us-ascii?Q?R3B2G+IrK7yLFZeCMWvMq0epD4zpw/yKq3b00DvvBeolKgwol41m9sbU+4tr?=
 =?us-ascii?Q?K3J/Fb4e3O8AIwKqSfyuEzTf7Ej8U+NDCyJ8O1AsOYGPfKF+IliZokvAycpV?=
 =?us-ascii?Q?4XMLFRo/DsNSc0TwW+KqHzk0sfdxOFz3Y6cASl2NubgOAkccXDF6wiXYuI6R?=
 =?us-ascii?Q?94JrKjkHTSAwQoS6Wcd5m9KL89Gh2oTGvYFi3oVjuPgL60tp1et2y8KQgHky?=
 =?us-ascii?Q?0vgXX6wtMnn+cD0h9iYlc5WqwiqzdovDS9W682VM+HbnQXoiQ+LontN25zNE?=
 =?us-ascii?Q?8dwZuGhyPuzO2pIRCPn4xPZMRBB1+q5NU9gYX0BjPGVSw7dEHlPqqukXB+4s?=
 =?us-ascii?Q?E1q/jMqTyGsEC66AwdW/NCJC2cYIFXnKkMlHEz2QBkKwuJ7n86nWOgr7x0sh?=
 =?us-ascii?Q?VmYFQKr7VXA3bMuJzQ15kCKN1P4rhncNkPd4vj2HOffFoiKZP4OXqgYcnXf0?=
 =?us-ascii?Q?Qal9yGUBzFQ2ZDP0sm/iACIRk/Weaqhx+rq/v/uhGUgxi0EGNEjX6ObLyFUw?=
 =?us-ascii?Q?SlYzptxhV73ad46XNKHu9Jx6nRxyfM0a+L3s/Uurz9DcwVGM7hEXgsZWkDgX?=
 =?us-ascii?Q?+Klbboi+ckU4wUz3sD8mxuj791QJAB++pR/SVru34kggEF/mbE9zwEJXmzeX?=
 =?us-ascii?Q?U05o1pj3cmeNegh684G7goGG9zPiBqCfXdRwRKjB/nME8fWz1nlHPrmG+Pwz?=
 =?us-ascii?Q?dJqkMuG/nGgEa2qsU+MNCeFVdCmPUKQxO0e5u0SA6AQuXnzpLzBBh76zS+Tu?=
 =?us-ascii?Q?r65I6TCiobBN0iu0ad16nKZ6vZMnPkOFkOylumtJAWr8FoTvVwLKPuluv61x?=
 =?us-ascii?Q?mgUiMjqKBR7lliGHb3iqGJRmuG9R32BJvsMempBHg9QLAeDjRHeSr6sapRAE?=
 =?us-ascii?Q?Bc2aRkhHp6eTwaEE81SQWshlHqOJ9+44qNNzSbvPTyaxRlkpPt/Hzwr5oGW8?=
 =?us-ascii?Q?CRCUo/L1DAM1qS11xFuXuoLEtyq23RoAYQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BiD5C6rFbkqpyVHEpW18Bxi9alooBgrAIAGG75dOa6mb3Jj2U18iEAld8VGe?=
 =?us-ascii?Q?0YnUTnKdcRR4BFLb7mMuWTyUEpphdKYWtFoL+FUy9w9DNkks58ciTDSFTEcC?=
 =?us-ascii?Q?jiTUn9XIdnHNgt70ZehX0h8GKhwLRTCoEC4fg9UbCO9hteRutYOCBJBfsbFT?=
 =?us-ascii?Q?oK9dnRYGOgEGkRPQHIzw65Sauph7SjxQWClg7+0pCgKxHm705na4rJlLuurJ?=
 =?us-ascii?Q?eztjHAUqlfN5v6XZDiPrkl9SzL0ujLPQX/+AV7r6J1wF0G2i7tnwHxGOPC90?=
 =?us-ascii?Q?zQOkQ/jlg9560TIx9PdJe7EbCCKOggktQeJh/bqsGcZHhsOVISAl7Uz5PfiN?=
 =?us-ascii?Q?iYhtxsaiV7ZSi2NQrkiJxo2xl3Y/6GWoQBCFx6xqEYC5vANsL4CGjmPFDNRF?=
 =?us-ascii?Q?l6kfiGplyKOYyrB+QQvy/vT9JtBabgV1wRtXh0vOWvUFMJ71tsXvCzkrPClg?=
 =?us-ascii?Q?OuOYER1KLOSy1Bc6AZ7epv5zxcGOkaX5I2xLsh8Ao5G9q1bsDPYZHHmBrUiT?=
 =?us-ascii?Q?yRKcXiBf3pcsnkXSbgJW/9jIdku4OUxhHO27gpqoN0lpbVy812e7+kvSRiev?=
 =?us-ascii?Q?84t/I5qqM0X5ELhwSpP+IwC4l8F4gFAUdp4FUQVFGBowxzEvAzZLu9P8vkfG?=
 =?us-ascii?Q?yufJKAxBl9wkeeTGKwfxtmfo8IJiFvKCSUCMHeLBsIgbyi2ysbse3F7EWKXL?=
 =?us-ascii?Q?PAYEnIWD+0boW5lM+sW8Qs7sFr1PBVN24W3KGagar5h+JFueXFVgim+JfGR1?=
 =?us-ascii?Q?jgXJlrYX5WAPn1XWCnS32afoF4oL6YYGaFyJF6WpJJ0azHCWYBRItxs9lgjv?=
 =?us-ascii?Q?XrQ+Dt0ihMcBDlsqWbUXZQgXTaUJ2NwoFMvzt6eDp/DmUkfCiwrqaTzDjoU7?=
 =?us-ascii?Q?fORwrsd6F+a2ndaQqMPa4MuFxI1wbHccr0Gr5PBKZrKwKsej0UlhQJcjPULC?=
 =?us-ascii?Q?K2r5Cwuim6A/VxkCJFgqk5rVHxdBiqcYpHkZjvFQt2g/tuhNPKRKYcItF3/T?=
 =?us-ascii?Q?7Yc0H/rOO8yLjr6XHdcaCfs5FNUz04/wofFE80NuV77ztGxT7gIWajZEZ1JP?=
 =?us-ascii?Q?JHccBA9NhReA0erO9aclxgvCi6TbBGWbLdLKs4dMg+J9JC8epNFEtYr+gBaZ?=
 =?us-ascii?Q?rT7qIgflY8RYLwkl9au32SKQQXA6adlHA8aWwOWkBVXF5sHjiAtllK359i93?=
 =?us-ascii?Q?EAiEV1Tdd45PPJx7QJuLrHaD/RJT4WvQAofRb22mSpTNAxrdS1MRskHgjmM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f306de5-b255-4f02-a7fe-08dda535f3db
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 20:08:50.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB8841

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

