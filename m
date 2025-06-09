Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011029.outbound.protection.outlook.com [52.103.68.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C521CF7AF
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 07:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749453711; cv=fail; b=OIFL4VNgAc6j4Q8lL6nCG1wdh3fHtOFvVhphDhqmJeWEqXcUiSEwPvYns/m4yKmLjKtJ3qPamXgcU2Ya8jNfAri26FsKkLJaqNF+IxjTzqEPuoLCCYenlvr3F+QGGqnvRjpok6j8RybmKGDbBjwHqzapwl+p3KyM8FgoFXHD4yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749453711; c=relaxed/simple;
	bh=C2Ea0fZ/1fbZp7wXFXYheErtV4NTDUaAB+ZPCRCqPGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hJIoUj/n4lVKlutiYQQjyyUUm9kIenXCL2sS13v2jp+/zP9txL5TzdVS6q0WO+sB3ncbkrwkTINsWynMk8roYeDGbMoE+ft842Dl9OiYzrrRefWSvtpHD637IHvxkvMhjGCfAxdWADN+aQ+Nxujsfua5zoefndBgL6zTaEocB00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=C6LnjfP1; arc=fail smtp.client-ip=52.103.68.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="C6LnjfP1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BXzMTEfHdiKghkxtqaXNSw7oE9rZHuU9zImI4woxUGeQp3kzggD0s3FQxV5sB4xsOzjIBmpmySBkWjdBa0VNKvdIhJqPjUb0TXvSXTzgqwjOfofzVbwwSWgq8ARqOWC8Lw10iCr0YnMLTjrSUJ/BJrYlXFMFLKNaPRm/dMnMmXkGW/oqLOGc3g4MpqlVzHr6CiNBJry78B3D70UpgxZ5UMbBDPrqurlOl47Rrq0VHHB3jXNvKZJS8aBciTuyjl6vhOxi1L4YjPnoHYQbYjM5f+/mAw0sVRwbFtsKpSFhwKSndZTuGDuTvZcI+rc0NKjwGlsUbLSDPrz8aLZonfENpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bn9dcpWLeDQognIjZ8sklbeWx+YlUw4c3jgja55dACI=;
 b=d131uYA6/cJplRxcDh/Aim6Hu/Irv7Gazkw2vbS0z+mq9I6oRyDtEpjaB6CoGzESq93ltYDDJ5LjAE67g3e5KVI+eV/ks8apIITCt2mqgod7LCtsDelTd09b050kOZY3Tm+pdDH1LO7xy7ZCVG/q5njpOB1a9vULrwtU1uIW50TLWVK5TCsby/LCm1vQYXkMNiDkKcAXz1m7V4hiqnUnLDJXAfG81iTHHsHm2lsCCpdA0Dx96pGds541vHanjl6iN1eivxuve8V8fx8B8PiZJLxmrtIPHqyHCnw0koxG6I6DUswl/opvrofMCw13UZL8P7MUGnntHMYeTz/5F+mmrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bn9dcpWLeDQognIjZ8sklbeWx+YlUw4c3jgja55dACI=;
 b=C6LnjfP1mt7oD/X33rlxtSZeb9/h+3Qdg2k+QivIpdTIqZVLcxLRliMtuhlZi8XzMwhMNfav2Z4c1rP+GZXYHjxvy6WuuXQ2yL481zZx6UV9LnQLIFnviHzmuAXFI6sFsWZ/jmFZfLZftzAAd4mpo9QdoORyySvep96aCwZAaOygtfMA544NntZxZM0EcbtPopPDcynA08PL66GA3MstsKgaeySOXDnrVXUFa6DUx1Vr0KAScundAKH8nKc6IabSbv2r0N2dGy8X9oImzvKYHNEZH0z9Qs21pN42KobDa43frBMjn8A5JngFEEL78TycVFQwkkT/6KghNIulo3smGA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MAZPR01MB7959.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Mon, 9 Jun
 2025 07:21:40 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 07:21:40 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v16 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Mon,  9 Jun 2025 07:20:32 +0000
Message-ID:
 <PN3PR01MB9597ACDBA3FF42D348336C42B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250609072041.12114-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MAZPR01MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 479e7dd9-7a44-4744-1d4f-08dda72646ee
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|19110799006|15080799009|41001999006|7092599006|8060799009|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IeQsTceLhLxEOpKQ/5ZxREuSwJKr+UHDO9fzuTK7RIzRjLffLTyK9SoWBu4Z?=
 =?us-ascii?Q?7TrAAqpyJJeyvcZVIw/NrbnDIEMtJ+kstc8uOlrl8YXZJa3YqtwBeBZk3HtJ?=
 =?us-ascii?Q?HdWvCIJfCY/NrcBHs+E6nvbHp3JGYjiWqEZBweQo63o5kPHaTbabSnIMzHPI?=
 =?us-ascii?Q?KWUoqF3aR3QUQl9MAbYCL7IxPAkzr2l+Ox4aWTAWQ2rXukvHIHKjJJjH9z2G?=
 =?us-ascii?Q?s2O1WBxNr9T49R+mkHOGbzQ08/mEK7NdGeVylLeSU6d2/DhbkjjqsalOb/2H?=
 =?us-ascii?Q?WPkr5tdufM5ZZAeKwRyeDN8a1QrfFneBg6CZ75Ssy7ZCGeu5GuZhZh7o6Ifv?=
 =?us-ascii?Q?SgkfsT99y74vtDvoKyJT1f6nZrzqrt5gTlhKyo29bjgM/EPPp5C5U833BNbe?=
 =?us-ascii?Q?NuHopxDY197ABQtbz08KN8YYUN4MhgWrVnG6HjtHZWLkWeOX2DPyg8/fbarl?=
 =?us-ascii?Q?/lzKxhpEbEhvxHdTu5mu9+xcoHqUfkXLXAymLfXf+OKpLyXc0fd/K8hGv9Su?=
 =?us-ascii?Q?GruoCmEQFkXSbmbA9cdhJkINFNaYPWV4absTi6J+XSOBzyiGRrJ3DYtVcuv0?=
 =?us-ascii?Q?Pp0vMsTA0DiTO6cSrqN3DiKZnT5Fg0tj1GXJtHORt3Zz/LK3ZVF1b9GsqLMR?=
 =?us-ascii?Q?T1z5LQWFvlyTBEjzX5UBSHKieZYimk4wLZ2pd1SabXPldFURsOGhxNv9YCkD?=
 =?us-ascii?Q?tSc1KEbYcCMWYXM54SiBVZ71BgnNGUeaTzvSXc25o0g4mTb63PbtD8GdCwNS?=
 =?us-ascii?Q?v7AlQePYFkf3rfTUKxkK2+QtiOKfxDaixkLH4gPenVfSR8dS4G69pHNJgNV+?=
 =?us-ascii?Q?9frSe/X8DqCJ5k6Vm3Jdn08nWN897yBe7Rcwf7QAokK1qMw+ernofChwlsnR?=
 =?us-ascii?Q?0Nw16EazphEvm8p57o6CvCXhDsDgFiN6OtOVO4L9f+tyMrrN9LBEE4/dJ/eM?=
 =?us-ascii?Q?pafHB3Q3U71fgMEEx2U6bO6BKNFaeNH+uIcyFaH4iZWmsKMdLSJfk77TiBT2?=
 =?us-ascii?Q?2MDLDLyNQLty2fyhx488GLO7j7T/aoI96Qr1dUShOl3dC8jKCNnkVvBsHR8f?=
 =?us-ascii?Q?luU4NIqtKFRotmvX6UnYa040n0NjFafTR/5gaB4pOlPUeY9u+0sEovuBuJJZ?=
 =?us-ascii?Q?6esaCv3BevieASap+mBF760pkkv4WmMx30Hf4tacrXdCX55phsCoYEs=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J1Nn43hBNUuzgsLB95UBiwige+LKGH5tBEUY2i/p56c/Y9juXGXCguUGj8Un?=
 =?us-ascii?Q?fimTgjXKurY8ZhKQ+LOmA7BL1hSKw7bfvN3OygZ5h4mqW7O0lMvbhqZYyb6R?=
 =?us-ascii?Q?X4/xz4QxAO0UtYGqpa+rpd0XNgwwpgLkp87NKSXiTxug71m/vn6DRyH/feqR?=
 =?us-ascii?Q?hykxr9brsDMyPy6aCXQDGg0HG0/pYj2i7Iw999SlY5D0kFNF7cK65aI8Ql9c?=
 =?us-ascii?Q?rQr3qfM8tAHrUUdr5oBtquwzAdd3bdfoGooC5VijEPvEDqK/k6bXMGN8fmrN?=
 =?us-ascii?Q?hnT0+UtvQhSsVTtHBv/OWMUtAn2/p3A98b995lLvY3OAlGzDNvvrtc/p8Gib?=
 =?us-ascii?Q?mBv+kuIIxFCeeHmiFyosH6Jj9LnJhAUmrevkZk2l12MBeap8ZgmkubKz9LYm?=
 =?us-ascii?Q?Y4oSghuF79f+DQ6+NJmT8Vmj1TzphaUWx1w6e4L9y4/FEDeJSGSh0KkfmyNy?=
 =?us-ascii?Q?lKetIMwHG9RHvXCJmQahM0y1+C9wDHxg48X4IEaAsRmbohZD7lkgWsJU5Xx2?=
 =?us-ascii?Q?8nPV6CTdPpXQGGf7yGPdfFQCMZfV7jrfK6UjwS0NIvhVUtB56AqTbF4GLXqP?=
 =?us-ascii?Q?/hCvI1Rgw0r1rHhmJZknfExO5lvAZjx8ZJO2F7NH4WPEG3XxX3gBn8ZhHCj3?=
 =?us-ascii?Q?/wLhUr290EjyRXJlEAxTfSp3Bsh4NxXHA8fesEZ3pkyJVoQerLbDIy6AjWyu?=
 =?us-ascii?Q?RJfF9W9dpeBsXPdwjyTBiRof3WV2TNXk9DzQEjnCYJ92On9xI8f1hGtTPIPT?=
 =?us-ascii?Q?OgrdhqnFECGXI3cwi3mLW4q85Lz3ZgDAhSGj1nVa/Ku9x1xYDkDytjvbbM79?=
 =?us-ascii?Q?sp283Q4dysMu+mkwgXE+3tgdimsobb5BiFSrhWD5c7bwZRiRo4w1+I3ePsNM?=
 =?us-ascii?Q?9IppQCvEcqw9GOljuTQWndx4zTRRs4nBVL8f9SVtXImQCPPSvTcrXUMe0RoR?=
 =?us-ascii?Q?ycFZ9Vy4dLfnHwtUTq7579onafOD4QI5tJ9qgSo9yI9T+sfkHqgLfBHcGMmQ?=
 =?us-ascii?Q?8IvE/QIKVbT2wG1KhhbG/7r7aUM1RK99D1oubC43XL97Vts4LpIKVigSbpGC?=
 =?us-ascii?Q?WcHLFWybwL1WUXpwZYhSdnuQ1otZdzOr1iTxQSA0euNdqDXKNgjtcyCtRA2u?=
 =?us-ascii?Q?TQJkWQ+3/RATqC2zGkQSmrtc6MO9DHGRWOhBWxk8xr7zLh8dDpL0SVp7mglP?=
 =?us-ascii?Q?Ztt1zwVcktnSCraA4oQ3u+8C9uoM9PD4JWEeIL6PY2+sxIinmaVyu52YBPE?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 479e7dd9-7a44-4744-1d4f-08dda72646ee
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 07:21:40.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAZPR01MB7959

6d1f198f34 (imap-send: fix leaking memory in `imap_server_conf`, 2024-06-07)
resulted a change in static int git_imap_config which resulted in cfg->folder
being incorrectly set to NULL in case imap.user, imap.pass, imap.tunnel and
imap.authmethod were defined. Because of this, since Git 2.46.0,
git-imap-send is not usable at all. The bug seems to have been unnoticed for
a long time, likely due to better options like git-send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..37f94a37e8 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1316,16 +1316,16 @@ static int git_imap_config(const char *var, const char *val,
 		FREE_AND_NULL(cfg->folder);
 		return git_config_string(&cfg->folder, var, val);
 	} else if (!strcmp("imap.user", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->user);
 		return git_config_string(&cfg->user, var, val);
 	} else if (!strcmp("imap.pass", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->pass);
 		return git_config_string(&cfg->pass, var, val);
 	} else if (!strcmp("imap.tunnel", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->tunnel);
 		return git_config_string(&cfg->tunnel, var, val);
 	} else if (!strcmp("imap.authmethod", var)) {
-		FREE_AND_NULL(cfg->folder);
+		FREE_AND_NULL(cfg->auth_method);
 		return git_config_string(&cfg->auth_method, var, val);
 	} else if (!strcmp("imap.port", var)) {
 		cfg->port = git_config_int(var, val, ctx->kvi);
-- 
2.49.0

