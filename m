Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010002.outbound.protection.outlook.com [52.103.68.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667AF19CC36
	for <git@vger.kernel.org>; Sun,  1 Jun 2025 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748761941; cv=fail; b=s0okNPd95jAU2i6yo4dh5/lKFASnKSKZgbqup4syx01q6h0ohjMAmQmFh/kjkxWykmnJGQ70PgB9T5iJbobkKic7V0wbj1VQXI7lLdl0Kfxa5BZ+WHPeKMJVezMy23bR5xyukBgVWyRnxMkDWwf5ccquoKg4hrwt98PFpqf83vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748761941; c=relaxed/simple;
	bh=PBoxPkhbDlIsunUL1eZ/Yk9LDSvXdenmRQvcIkVJhLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GvHtzoYm/xjffUc2QVJHVZoPDABqfPevYH2abBdz0yMDGiE2Lb5ZpB6MIkXFQ4mBFdbrYyvmLMuSvOxYAN9bIE10m1ao407aE4WohPGEkckmFM6LdqPsSa4EVnMYKKoBcTTwdL/N+uyRnXkBiyXbEPP55fCMWMtqcjTboCpPdCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=h6xQhL1u; arc=fail smtp.client-ip=52.103.68.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="h6xQhL1u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WWZDR2adnzHgFLO6UNpcnEMReZeGhL6c83A9cVtpdRiI8my0y2Oa9eviOFAsR+419IjMOCLEtRTgAeKSZnIIrP1zUc0ZMLd0RetatyPLClFWVB5JZV1nUDWUK80obMo5vskCW6bzEH9nPl7nNNyeBVEtsaU4tx/iAbqmPhEiQme0oJEUpd2IY7ZKDatLgDq6M56IrrjyAsYJmDBmeDhcd4N0pta0ANWapc0ayQV3vy+EsGGgCEnQWCxmFSyZPrU9t9y/mbiaxGURgYstbCe7JilGHwHBDzu5bPB6yi+cbtWiUmkk029ykh24/vUFiHXmKKxpDY2tdNGJFa8usA97ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sLjBRzXFYF4SUB6QjtQaApNLmYLbTuMrtuGiSglHGsU=;
 b=ba1ftRdt0FXl6bhtHhjdrA8WoTlgLzQZQucAySLs/ixzErCDVlVUWHzowFKeJCfntofxAYI/H+OfbNfg4U35cs3R2f0gVAUbgiPbkdLdqoV/4Cij66PxEJhVGxYugwXqbyTY1iDHiOyp7OVlW59Jb5iEt5W1ZAzq6jNDYEI2CRBJdktGplDcc2tzFJH3q/tYnu5heuF1bVXRrp2c8JMFtjkFerWBmLVeltmDc8Xylr4oJfrFIEG9TptnjPIxIQFpllRVzfpCKnXO/nEQP8U8BmrmEeMupCexGSwcV8Z9deZOvmmcAkAEpGDv2gaY6jNMabUt33cEuhCPYqdDr0h/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sLjBRzXFYF4SUB6QjtQaApNLmYLbTuMrtuGiSglHGsU=;
 b=h6xQhL1uRMHxVNqkDO0FZVIg4uZ/u8MU+QVWdSZyR4zQwgCkH0d44+2rOb1C3f1NFPEzwQYNGJPq/gVVv028zJjXbHcjtKpCd7kOSitRDo/32Yfdn6RJUrFNYUcIT7wTXRop8ObeaWvbOKhTmAWj39p1vcMzgvMjwgHe+BnIVomUCuWvBNRRWsyoJvzrpm0HPpQWGeHGxJ4fH2oWMqkqzBqPgOHbJiwjiyigenYZZ4Uw/dp3dYFnKZyjzWo9GGw/02T4edGytfYs17jp0hC7DX6pZ360M3XPGxoGQBJUvOIKrAmyew78MLa/bNFIgtyEkacrBiXIXbvD5uZduAOuOA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9108.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:15f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Sun, 1 Jun
 2025 07:12:08 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.037; Sun, 1 Jun 2025
 07:12:08 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v10 1/9] imap-send: fix bug causing cfg->folder being set to NULL
Date: Sun,  1 Jun 2025 12:40:27 +0530
Message-ID:
 <PN3PR01MB95976B6E2D472ED8FAA6D699B863A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250601071035.2412968-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9108:EE_
X-MS-Office365-Filtering-Correlation-Id: 260ff5e8-aa02-48da-bb1d-08dda0db9f38
X-MS-Exchange-SLBlob-MailProps:
	WaIXnCbdHrMi34iUpeHrvUBJkG+6rPgnpXacx4mG+8CjKYrijm3xLUEPnW5cCE+gIRax3Ls8dy/yOrFKzlinaMpZX4ID6jHMnovw616RUR5f9zD5pCVbRGdwSWB7mbIjPhbNLOm0vq23Jx83y971UECXlTdUuT+Ul2kvtV8lSuUwbVBJ2+5VQW+lmMKDiVnAokcS6q5/5RnVDa28SK/zwRp8nU/QTg26ft7bMuq5PXx8VCzFa8m4AV4W+68MSSNBvpDj/LcaD5qAbxN+QIqgipUwCXCD0ui4AxLof0cyMiL+Ms0HsM424qARqHsKucsfUb5tlmchxAjT7iwB+jb9QAkVMnbwUIgyugrUZ1knhrBpNF7hM9B2nB/1iFfTdZpGhvsEZpLLxFtV2j49Fwdf2MtxIAzI4bqzHwcFGOsa092oPRgdvFfJIu5oL6uVIY0uWnRypYfxtxCdpLEfjTpCr2fJnY71bHn3bvva7BSufcUzt3IRlMA6btshpDsGF8zR8jIlJ8h6ulIn3ZrPOmtgV6GDsBb2gczT+OYVnsGV6TOyHqAG5IhtZSobC2X74m79ex+w988KVldmdBmEyf0ASreB7T6SEiIW3QNbQkerc+P+gt+nfLrRrzr4aY53u1QPQIgoYf6Mo3ZXG5/BL5FN6Hl4PjLA18X0XE8QuWDF7JJCdFxuV9zg6/FFKPmgUXpTX6RMaRK8d1ESJlIz7BOeLKw2GE7u8Fi/EQTf8YuOO8evi98FFQqkduOY4agxmBdAgQS8Y6JmzbI=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|7092599006|8060799009|15080799009|41001999006|19110799006|5072599009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0sGGzD7jaelqRe315DSTM6/nmrTx2yC+sH6gY9Y47Amt10lq0gQZA5v18Wqb?=
 =?us-ascii?Q?aDGbm4rn8+JM6T8twhXIiu15qeQKmrh3ruIUl+Ebmwkim1L6ajCNOnmDeDpn?=
 =?us-ascii?Q?zUma9bGx1Mz/wvzLm+37Hoj3xAQBhTYEy0BlsYIRz/8IU1kaVEyXXtNRUyB1?=
 =?us-ascii?Q?/KB5zOFUCyFBghtern/P6pKXOnFe+GCKmi2wuQzVR3+37wQyYabuaOdTHmRl?=
 =?us-ascii?Q?03poFPodXD2iCDHu+9Nwa4zHFwBaXK+zWjNvBgZl4zHz2jQ7w+xQjF/3yn3H?=
 =?us-ascii?Q?M9y6rmijHWPBXnvtcByc9f1R3I2fzhXyOu/QM5aC4ef1HhyKsRYYOrpg58nx?=
 =?us-ascii?Q?EX7q4WyXuSKBkKQ0Zn3kHNItb2Bo0I7fACsq9PysZTwvGzjyEqJhmIbVA/16?=
 =?us-ascii?Q?EGq+DWurVfb9ZNgosO8cfeAWz5OdiSNC8QXjaq/G6yuXi/IV/ecsT92L4yGq?=
 =?us-ascii?Q?i6hBGJqw2kMU0J4piqLR9njcsl1K7HrKQlhH4DC2PZqwOZYNZesFInrKNONY?=
 =?us-ascii?Q?6F9f7w74mPb+CfyGRyduYiaqR5Z1NDOa5/0usqOtOxNX87Qgx8XpMhf1c/Kp?=
 =?us-ascii?Q?cOvxCE3f4gPlxDijUNenaQEBdTRK5S1+lsbtTLPtscmbA3g/B7R7WuqXDRux?=
 =?us-ascii?Q?16jEu8GacVcXRns3iIfqkxMTGV4A3IaYILSux0vVU5hkoXPabiQwRixaauZr?=
 =?us-ascii?Q?Ezl7FJJ9R891L1BxnOZNpIWa2BbM6lTpKko3E2x3iYKaHm//3dXhuW4aZzP9?=
 =?us-ascii?Q?EaaHZyyDDXG4k86yZUbY0YAIxnWDFuM0CNb8iPDb9BvfbKgtnfi9fgRaprAm?=
 =?us-ascii?Q?B8ru253jHXnPZZb2DfJo0uQLB0vhU9Qo/Nacr3uWBwKVh8wvFBjhnu5+eMWf?=
 =?us-ascii?Q?iG2lE0rNsB+woiecpsYjC7JIHfOaFpCjFLd1L+KB8ADZTPTEzOU+Z304a21Z?=
 =?us-ascii?Q?oiRkoz0Jm1k7PW1+CzHr8dNVRM+6GonNBoEvNu1vECr9gm0aa8KsI3AF+y/X?=
 =?us-ascii?Q?H4/6FNNkkejplIoAsvluXe9Dbb+LjVzc+1hQZvZqpEjw0DCBBVoW6PkQfvz1?=
 =?us-ascii?Q?ah+bS4vGDZ/NlCJjapA2YfehdyUrmwJ1w3XRfNzvd5To3kSQFvgAvNVFa9GB?=
 =?us-ascii?Q?cHe3gIaobi8qGfIrKhC7COSt1XK3ahTQIjpwg58suSjcX+PBCSzNX9s=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vGlyysjugeuDupwvsLkQaXYwdjlqOxB3pRBgQHPJgOktRdW1o8BO+BkdYQ0L?=
 =?us-ascii?Q?oN/XSNiqDv1gf/p7760/RkImTS9iaeb3tIFHmAn9sg6Iqeit+hW3SYSRk7e1?=
 =?us-ascii?Q?4mmgvfjQGveZq1hK99DhOiODvpPkFdXvdw6kDhPGbbWvQ7rwvwCBRnQg7jsN?=
 =?us-ascii?Q?ZQysLWhXk+gpjIRfPf3WYNyJ42hE7qAUCnf/T1xe5XXwEhiLnDNdher622bz?=
 =?us-ascii?Q?NdNEJrX95aHgp63Tigk0IfCdzOM5LGkWjnKwa0CIVHKPna4uUBk2/q6p9WIb?=
 =?us-ascii?Q?V9Kr4QkdVcP5G+W5cHfZXjZTI5labMM25Y82/jy3Wd4EzR7TsmJElhLfm9wq?=
 =?us-ascii?Q?FihWYBrjdJZVEjV+QJvQ0zHDn5kfCAoi4ioDm46OTfATycxyqsrwbgT+Z3Rl?=
 =?us-ascii?Q?ktI94OdqApyHk0GtHbCjHypG42J/3jxzxILhRK5gL+oOuipLZFSykjtm8vk/?=
 =?us-ascii?Q?lLr7mQQ9H1ofjRR6HgQVSikjfuR5Sae9YbWi9HrxPhgM3e8EKAsPhux26VI9?=
 =?us-ascii?Q?/1C70nnu+teeYV1GFq/h2PEmBlYQ/ar7hieowU65hLyPd60Ka3o7KXH5BekA?=
 =?us-ascii?Q?CLazjtKnmDbKWArpAn1fSoyykkgtgEfr41uxySnfNSgTTFdM0+X37lCmIJ5q?=
 =?us-ascii?Q?hVdYrlQjImSrE44bSZRL+nGkNO0BJiVs4/IqapUSwpx5yDe3B3d4ZGWy26YZ?=
 =?us-ascii?Q?Wph4z527NAxWra1/brGphWOUXc+hbsTYULG7yyPkK0gc7441EA91iGHDN2Fe?=
 =?us-ascii?Q?jF/j2orVTMn6TgTdSd9tyvbdjpWu6IfK9shokrpL0/87W8r5wsNfbM5MOUHn?=
 =?us-ascii?Q?6X73y7ZyNcrZKzWYrABXHJixvlKbYDR0mX2lQqHednixGdjHl4oKrEQW3BSV?=
 =?us-ascii?Q?xqSDilJJ7xsxUsYFhqvl0fn07LLYn0P5HbHSQO+aV2nAGGnVXNDPJUvAMRXs?=
 =?us-ascii?Q?63f2hoG8Y/wc2tfTtACTh2ae+Z/o2ECleEFQ2lsHKIeKsZ3oOlTFUGz+y5mM?=
 =?us-ascii?Q?3G8VhdJGzw6Fx7AwtLvTAlT1dd4HOlFeO6efBJzqA7dSXki88YrUzec2raV/?=
 =?us-ascii?Q?mGc5qSgB9ghyI048iEzOWGxorvUCO5zJqcmifY69SToFtdpZe7w2E+eEi/zH?=
 =?us-ascii?Q?kDxs8mRuqh7fcsRrfPrU9AhmgC+4HjYJB650M3zinlZIR9NtLpuquMpP6WsG?=
 =?us-ascii?Q?4T3P4qmrowYZIdDGGgfszkCCRAv+IsLmZZk2XKtdPEVYSaTPqLQvv4HiSGk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 260ff5e8-aa02-48da-bb1d-08dda0db9f38
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2025 07:12:08.8844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9108

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
2.49.0.638.g67a2d115ec

