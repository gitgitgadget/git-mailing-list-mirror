Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83ED1A38E3
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761947; cv=fail; b=oQqF+45NSsXIwJRFxQ95gB2zZQpmDt8zBlquIsjyrdyqkk9O5IH/ZatEqrmQKCPaW6UuJNAF54cJNjZZ4nP92CR2KlPWpwfYjk2Enlf0dkV3DQLMs8CmTUZ51t1EFP42tdT1wAFH8DDjrM6c4l21T9zDTMtOZyjeSka9Snsi98M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761947; c=relaxed/simple;
	bh=SumA40nC1GUzoc0DjLUf8m1mUMjeqmSfOxwcQEcSWx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vGTL5uHxeAn9nXSdBXoynHHyRKZb5GkhVoXdFNW6RyXN7oHnoVl6M7pDHnLnBKAmd3595+UkteHCzGv6q0KIFT/Tery7dpvIMtV7I4xlEojBTcLmwkaGRy2dw23YUPU22spx27mpuZmCxHoU0ugsDCM+0rEvd2AHLI7+2eMrXSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=DfHcqJyE; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="DfHcqJyE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peALiUg2m3DYlusYM2QuLKYShNYNQ9khxWAXNNUIfk3Tz1qQvh1aL6DrsdvIfRWrUOiMYdVNOLV2vXKfXVHkAw5l80Xox3xBA7e8bd83xUDpYlqYEVX9KuOr1ebGvASwMI/3t9ad50odTa5HLuPuXxT4gTa77e40Fpt061pNkZdrsPo6SMqliD4GfuwPn1GbDAtFbvj5BNsM7CKh0uhAhoR1BDPQXx/Kjg9RQXQmzbzpTspeYgYp8paALmVe8HyaBsZWOLCx5rD6+cm7yi1EY8+Z+6gga0tSTQE52apypu0JA7FX087SjTIZjUm8/y1jWUk2j5X67U5bLHuMGNt7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2d7ZCbr3hcLugVi1M3T+BzYbiP3Idq4a3IddRsLY/Y=;
 b=LPqSjlNyTEtDcF4Vve7Yc2lYWNlLUlVaMqbg2AR03BKW9BePraqRi5pRVqtTWIdvOIy3O2c+Jg/xet7PUq+oDnQd2rT6dLSEDVLVTwbqfvb3vQYsoCuZGm31U6O9yhqvKMv7CZRNCNazH/3WOG+7x1MLuYpMo2LQx3zTbDupnCtZnu1JnHAre+jwmAp4eh9zNXdpF6JecDFw+nRV4rmFWD2Atmo1JVOReHduxjVrXmkB2rseO5Zu7bYFNLNEg8ForkDj5ieE0UM/vtsxOTk08h7h0GyR992tvdavQGgiASJzPx6bylZPEZh86QxSNPp/+onz5nyTKiGbxpmHk6w3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2d7ZCbr3hcLugVi1M3T+BzYbiP3Idq4a3IddRsLY/Y=;
 b=DfHcqJyEOc9jDBMLDF0magbl8fjvX37U+ppeSg4ENQGQKLlEA8fROca7wDHKPlDPkEsxmnGxzjJcDO/IiPZly6gl+q5okp7DSxsfHut7GdXw9LOGByiAFx2vw8OZkKbcNqMG8Wav7ixDUSsoyawJ64tzCM6Y8qcOWkJbIo4rmaKh0Qbe1OFLjkUpkzavT5x73Cwq0YI3f45DRvx2Kp62wLSqy+kzYVx066jhCxwuuY79ENGBLgMSvSpfcQ5ZeY4CAq3i8ys8cRuIhYE16fVBIajb3nJiOHSf/rSDQ5Fppf/ky2RxFqNWbJxwr0pcG2/WJw/gncvETvmakaEyAh4WRQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:16 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:16 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 9/9] imap-send: add ability to list the available folders
Date: Sun,  1 Jun 2025 12:40:35 +0530
Message-ID:
 <PN3PR01MB95970D54BD76076100CEDC5AB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.638.g67a2d115ec
In-Reply-To: <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597C4D1176FC7E9A459C42DB863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BM1P287CA0024.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250601071035.2412968-10-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: a7e2ff40-c277-4c38-8cd0-08dda0dba38c
X-MS-Exchange-SLBlob-MailProps:
	+b2+gf+2pHTK0hJWfIOsgR8XTzjzRgQk3Sr6AOpK3A6nXRoccZx5olPJuEkdghTyiq+Bm/JLpfZ66MdGtkHSOzOM9qOae/l4Hf2Fg9xOA6gKvEKbjLYOn2uBG1rcboBDcmazGtM3vupoeRPE/ooK1z2Cvn4BPvX74kagpVwdEAdvvnYCIPL3lE3MQVSyCngchqfMAH4h+cyBxKySN6wUSIx+mn2uEJuZotgJYtF0MySqKJtrBP5Ci0iJeerXiPWRNJJNYwXN5+2Bq3tvLfrTtXt9bxx5TOWWCjKmlaMW+csTHLakTMIC2vTQrlHX+tvMdhSxfVy+8TmSHOIMQI/zHkGfTBiU8SGMjLb6YN4KEAv3t5/NL7+fW2i9jm9kqCECnZBlC630CK08iyua+ifAOp1H1I22tIBHK71QF8UqnAtCDCggMc/FbzLhbr6tGKlp8j9Gq/B3xwQa6dyS5xdtaLQ5/We1Jij8K29bSoNXeKQVkHcTejOpsjNEwBZ1meuJt++ZhiOSnkkwxvk46j0Kj4rbJTV6TGJ3o36DEOECZNKhQSS5ViZScFxi2DWlI6RjCZ1rXw3TtUQXrpmexA8C78gtm0soAqLL+DlHXIBwsFXP++sQlA57BvewDQVkYpeJ2HnhLNzSyds3fBYGh94mYVYO3g0KPfZ3PE8czHoW5GLzoeTHNRv/Lx5q7AWyBth/MtB5RTJkEXJ2fz7ox5asFxr9kMGE1+UX8WLyKGbOYqQteM8uIc+vOXp4rStgK2lMFi4EPkzkX7CBoXsfsXDIjIJF/m8joLYasIsEuVGdJ2b3ac9/JM4U310PMEdybhnR1Ihk+jls9zhMZP+X2VtGAKEXiW34gX5lXvjijM9EiuKx5WxXTUQFTQ==
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|12121999007|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|4302099013|3412199025|440099028|12091999003|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hn61omA9wcBqRdTpReLSNBvGgTh6bY68WNuruSNA5lodLnEq/wykntiW3D6V?=
 =?us-ascii?Q?zpzzq7Pi/0LTPqVKyjcuPIxx+gVLRfpNSxutYV8Jv02Gr7sYmWqNAZ71WCdj?=
 =?us-ascii?Q?aJh5/uNWTj4M+vpvSdMjSfyxZYxF5hotPNhihV+zKC14PGy646rff4D283h2?=
 =?us-ascii?Q?x7cDesxX4s8JFiYytb6e2kp0TNpRHo/LW0g87I3y0SGHiJ8pCCuzVAvwTLNC?=
 =?us-ascii?Q?ueVeHy0ZdW33jL4D3c7VuHMDZFb9/x+oI5Sl6l5Hb/Rrt5K+g4hgMbL/b+Bv?=
 =?us-ascii?Q?s+U8By1M0oG9DU/VS1oDTxYRszomHk3NFAEq+fq9syC6iJSrijSMlpmrTO59?=
 =?us-ascii?Q?IL1/F6lJTHBE8adv5bFViRtxwI/eWp5aF7pe3PdKcJKrPIGVhPIqVcvhMxlW?=
 =?us-ascii?Q?TnrZV6QxT6ccbbBVDC/Bp0WOSvSQkaS2eXSLTeYNLr+AN8oLQr9bPD0oYuYc?=
 =?us-ascii?Q?sAFL/5toVJ9zl7WtmnZqBKRFS5mnK/vk6WNpGicgrm/y4Hr566LQ/M0C5Uws?=
 =?us-ascii?Q?usYp9Qs1lp66r5g64r6V1vxl7l1sUu6sYjRFS6H+5ZW1KFqwA8AgkxVL9h5E?=
 =?us-ascii?Q?sRL8C+amJV7uhpvTjRCov9lLuHSeuZGMFXztmmsn/bwRkpTmJkewxoTCO40L?=
 =?us-ascii?Q?yZqs0DfGIfBdC6kJib5kL0aGLLEJMvi89HwRd9OgZqaDhcxCiOJOBAGKeLwd?=
 =?us-ascii?Q?TVKKRHNf/ynqA8WUc8fJlvPpnrWj42FLR2qjaHDr1r+0VhYb0l0l7BhiG3+G?=
 =?us-ascii?Q?Zl9vqMpSoTYbpyeiLoXMao0N7C3CEOxq5sucoQlm9B4lOrn7P1GbGuTFaJ94?=
 =?us-ascii?Q?72LmLarjyFEWRyIhI7SkzXSKrWLA1dnlSUuaaUCRoH7Hw1T5kRbo82fyh9Lu?=
 =?us-ascii?Q?zhg9bpu6Ev/nbhbq6pBGuvx29cvPX3S7M9LMCaMhO0S0bg0J1x1b5qaBSMx9?=
 =?us-ascii?Q?ZXwKFR3okpJZnFpVfCMZLT7OwjkM2fxj6jvRTZdg7mLQ9h7IW4PxhvtU3oHV?=
 =?us-ascii?Q?b9+hld06sl/qNbPGheoXRheNbvXOSxgUhQHePsJRj1VCSQ0FE2BCI0kbf7Tg?=
 =?us-ascii?Q?UrxnrHuXrN29SSmwELeFBDXPmE6w1xe9RQyy+lPTMKX8AvgmNWojN++pkFw3?=
 =?us-ascii?Q?QjUUtP71ZgApKzMxYm+eziLidwtSbz+TKvqHtqj2XFXvcDy/TeO20+ybtTBv?=
 =?us-ascii?Q?vfXIo3Zicuw1FBFamC9St6esVu7V4pIyyhrxgNtnGQZMnGRVH1eggsB6XniB?=
 =?us-ascii?Q?NaSHEc+Y7KII2LLdyMrPfIdRieTmtGyki4txEV1UjiH0GJWmANNuzxFgkWFf?=
 =?us-ascii?Q?rfX/QGL9VenRSrkvQwSN27RBBA7H6afF+j4sN9wVa+J+uw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cy7VhjKoRnDCUWAjwFcPBcdoGW6YL3Z4Fdtlyk3TfxUUk6m+pKvn6nSTmPrv?=
 =?us-ascii?Q?QtPkMo2OKMCCXYgz2ySFpaiaS54I8GD8Y9xvQ5YQ2FD3f9W3eDOENUrC09oy?=
 =?us-ascii?Q?HysNYaVpy3bH5nUlhlQXgnje3qSBnjQ4t8SR2JpcYLMQghM8bLITeXzSaOo2?=
 =?us-ascii?Q?XsekcxmSZdZ6nwpIjYQ/GhINxjhSpx7cFCwSFS+YoHGNrBm+iA+cD+LHPr7u?=
 =?us-ascii?Q?U/JffI8YcbUAis1glAp/TcFzuObt6MUhgmGfLou7TLH1B3WwNeWqM3Jlw2ok?=
 =?us-ascii?Q?xaoyedP3Z3WjW6oTmeJRa6UeIy0IwBDLelM64DhD8z9v6x7DTTYixaurIDa+?=
 =?us-ascii?Q?gcpOiVw9jA+LhwifZ969LOfmaN3UHjUPqMPUiDdbivzEzURl3l4N6LeWsFWY?=
 =?us-ascii?Q?nLl/k3v/PnUNzO/6VSpOLhBWfncu7jcJkOa5550lrohdI7BguBTeCqMT+tw9?=
 =?us-ascii?Q?cab/nqR//q7TPoPBCBgRNOQC0W75DI6338tSxlM3bkPgc//cq1A3JH9KY+dB?=
 =?us-ascii?Q?zPFeSZ8VV6GUr/8w2rtSI7qLWEO/mnLOsFUEgzn0J7tO7LJa5erFelQ0nqHJ?=
 =?us-ascii?Q?GX1LmpAvrQVCPSJqcqVhV5Hx7SbMA/VazC5G5WUqVe01zYYC8SxALBMJ2+CF?=
 =?us-ascii?Q?QK4ot6AKTH7N8u+fLZCzCLV/OG4rMrekUN0queO/4wT8Y6aizKN8/q9EPHfN?=
 =?us-ascii?Q?q911tjNctj+bB92p+y7K/gz2DV69MGAV15ca9Ppmev+Fot3UHCcY6Kp7hWCC?=
 =?us-ascii?Q?ZTSqObh3bcLDLy7bn8erntN/RA0DGeQS8Ep+J289wqrrM4V3XuIiPEaFF+hZ?=
 =?us-ascii?Q?1KtmxwuQtkUoctCfOl03RBUkXoaqqVeDwN7XqFP6YH724+f324B55YcKpysn?=
 =?us-ascii?Q?wOjl2zqS2yPy1/IpVmaMVBgYlEN5Py5cCnDMUbl3UfuPFLJmKkaXxVHq2SmN?=
 =?us-ascii?Q?tqxPfHDzmwv9Ffn5l8hFZyXcD9nIJDSt0Ga0uCJreg1xXr9bHD2yBiIqTxCW?=
 =?us-ascii?Q?9+BwVzALpT9Q0Eq4l37+ROAztSy9h+mfddn7v0TH/0Tx7CsjxYvdsSeH7r+r?=
 =?us-ascii?Q?t3EI2CeQWEvWWR+e/EllV+s8zw3FVzC503GctqDSQ7ljlPW7V5+06YByfBDl?=
 =?us-ascii?Q?XTA2VTPnAcs4hRDGNa42HNMB3qqkRrvXmZHav8ZkmNAZQjqOgx6kIRli6YBa?=
 =?us-ascii?Q?xvRGShWmz5Ie9mtKI55TuHW8pEHW+NczBJLgET4A9FuLZC2+pWTdvAm6eJ8?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a7e2ff40-c277-4c38-8cd0-08dda0dba38c
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:16.1089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

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
index 86d46395de..4a7130c20b 100644
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
@@ -1622,6 +1628,26 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
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
@@ -1650,11 +1676,13 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
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
@@ -1685,10 +1713,6 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
 	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
 
-	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
-
-	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
-
 	if (0 < verbosity || getenv("GIT_CURL_VERBOSE"))
 		http_trace_curl_no_data();
 	setup_curl_trace(curl);
@@ -1707,6 +1731,10 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	struct credential cred = CREDENTIAL_INIT;
 
 	curl = setup_curl(server, &cred);
+
+	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
+	curl_easy_setopt(curl, CURLOPT_UPLOAD, 1L);
+
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
 	fprintf(stderr, "Sending %d message%s to %s folder...\n",
@@ -1753,6 +1781,31 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 
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
@@ -1793,11 +1846,6 @@ int cmd_main(int argc, const char **argv)
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
@@ -1807,6 +1855,24 @@ int cmd_main(int argc, const char **argv)
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
2.49.0.638.g67a2d115ec

