Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011025.outbound.protection.outlook.com [52.103.68.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551CB220696
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 06:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750401657; cv=fail; b=JuSy88iqCuGeJCo1DlkkrBjEXbIxsnAdBeI1Prhn/u/rRE+lKjF0PSg2H+MsEXlK6VsGZKli9a8SY0QANFHOzREihPtdzD5vaAXohttPzNs9hPViuEZE1pW3zDHrdYn9Cl4ykagirl3Ls0i3e38u9qZUuEBcVAhb1M9RKM4mfmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750401657; c=relaxed/simple;
	bh=3Sc0Bteus47ylYAH1iY1ZaE4ipfNlh5LVMrSpAVcyxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HRIa+aICG1YdmWCgP4M1N4SJjZJILOdAtJ+2HFuseQjSKE2UfgK8EzfoXMsMp1TDetqExHYFio7uRmbOkuWduMpwnaWlpnGXDY17xFjDKKWpHjyGsVc2Qg5XohmxNPnuylzdq8rq9SLnGCH3TRvK5Q/ztMfInSr2nDPWBej9oFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=bqm57TH5; arc=fail smtp.client-ip=52.103.68.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="bqm57TH5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qP2aoWNhlx2DDm2X7gsNtbmhc+JinF6ueUSzGPEW02ygzLGqhOp+z7a7mN5ByGulImI31SHXrTy5/qG7C8Sc2Ux5TDc2WeuSRLqpnGsYJP96AO13BR3Go2sniwb8qrFlG8baqW7ejWp+L1fLBuwTmiSH+lZwQjrIMlUwhx7D/tm680sXpHj1678M33nkZ+XwgKKO2hvDatiQ6bxE0FaaHzBTDTR4vbARR+hiJIMvP2fB1LlnaxXpaRhwSltVX1a4HCSWO7FFXoBSsdqucMC26rcps1Zhc8augYqDS9Y4EgrbbmJBthvduEmuJhITK0FW9c+2CgWWp4Zg8KMZNqd70w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yEsCIY0mg7Lhcn9ciLWaqNaCHTtDhiml7cA6yMcrIA=;
 b=AHBgcpwjdnawgEs0rF4e/9C1h7cLqZqpYa7R8LC3//DNloN16O0SJ0IhxPwm44zHJV5didAlvmzdPqg2iGAhmB8dekV+8G9YKSdEgR5aWL+KHHIIyvtn3NPWc3uYugWizzVbO4Tw7QyN4gfM47t7fTPYEJ1yk9ml8sxqEXw0JdwyRq4hg9Im1wBDJeAAXILzlGqsJl3gOskAaamq6uVvJQyEpcofWzLRldrjXmXajtbgLjq0CFt8wMeXI8zw9RXu9keT2I7JKh1WNMPHVqC9R5yTfd1HqjYIk3ncnq+wUc1MCbNmKk8I85aOb5VW7rg8cnQ5eSwRaewYfgee7/Fl3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yEsCIY0mg7Lhcn9ciLWaqNaCHTtDhiml7cA6yMcrIA=;
 b=bqm57TH5T3U2crJnOR0WAZJLByZA7IYjS8G4+eHtllTwEnuEu9b3d0VvlMDmF2ZDNU9Mk0k6XIVkvehdcvXeRkS+yTpjJz3/TU+RDu9WSO1xeAyLim1ciodkJ+fC6Z/zwG2tnwhjv2n9yq6xvdvYYrHht7v0JIzFrcbjc6PYYo5hDmd4tOi+ddY8qcm9fKhPYoCu0HPamcISH/SiNcDBLSx7n3OWnUzdSe0ho3nfdaol4k+pnwZ2VotO5kMpLMp1D56S31WX3w+NV6vDPdSXZD2msmn/f5JT6zKIb08GawF28S7sghQuu8t0rTLmIEkjX5JTKkUob4Sk1cU2NaPCWw==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB6749.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 06:40:48 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8857.021; Fri, 20 Jun 2025
 06:40:48 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v19 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Fri, 20 Jun 2025 12:10:24 +0530
Message-ID:
 <PN3PR01MB9597B7FCD8155FB6F5B39CD6B87CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250620064033.15814-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB6749:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9af35d-d4ac-4e5d-9b44-08ddafc5643d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799006|7092599006|5072599009|15080799009|8060799009|461199028|41001999006|3412199025|440099028|40105399003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bfa1kHb7dIKyF0JZeguziUdpdgxerMC4mB6RNG/Rll5CnqYVFFX8Cr1zToY3?=
 =?us-ascii?Q?1D4cqC0/Ani5qRiDdtPqvLvtQva45ICbEAfWxvw304T9Ar2Kc6clFZ1E3jVk?=
 =?us-ascii?Q?w4wgBNgyVAJxTV3n+JrzCoT2IyFyGcG1peed1U+BszwJnPLwpXLt6wDGt/P6?=
 =?us-ascii?Q?ikwZSoQhLxLCNxbtZsolQGmdT6bOcvR6UXjqbYaXUX82yUBtjLeyxPXHvfWL?=
 =?us-ascii?Q?YJ8L9RtaarFCAIpBUOzG4RAGQeFJ2IJva479S5MiVW4J79KAeqPAbuVhaxAU?=
 =?us-ascii?Q?T7cl2oiNJWqMsVpnCpD3NdDutfKg5WjROI/zxcBhlumox26flxuFltZuof3h?=
 =?us-ascii?Q?/dXPwMxsiYDzvI3unpPa1mnRwwUiUNlqwvTyhV4o/1P/25ifOSE+3wnaGz7b?=
 =?us-ascii?Q?ioKBeekQUBzjO1QNbB6MdMQD4RBLJDdsxW42XC3r+0JoXM7Q4CE+Ja6pGI/l?=
 =?us-ascii?Q?EI6i+YGyhS0woNughpHXhS9Mf7EqS6iRNE2CVhvTEqzqSYqAFV4HV68va0P+?=
 =?us-ascii?Q?nuoAVlEeP1HEk4BehjrJipoJ6mILUh20GT7VN8HstBtw+iNDq3u+BqzIcCKF?=
 =?us-ascii?Q?Ze9vbLcmo5Jb6U/x7uQ2K/I96POjuPVbu3rv+bVqmfHlcP5loov+JHmxNOhB?=
 =?us-ascii?Q?2eQA4bkDvxULpkORRo5bL2FkCNHTtv6WEf3xTO585suPOyR/jh09AAsQZ+C5?=
 =?us-ascii?Q?3EOLfp4dgVXiKQAb6/H7MP8a3spzaFkTDSu7FbEg0Dxa9Lbcx2YoZJ3bRhjR?=
 =?us-ascii?Q?Lg8tOY5r3SdJO/JkRNV7KTwAn2YABuxZSz+3VloQjhkduLcAEHoOS+MX94s/?=
 =?us-ascii?Q?36XLT0O02HxP/YJg+84R4vRDdZb2fesfeJq9JrHeXbOrxWTzyUoiDC3DeOGC?=
 =?us-ascii?Q?q4cvriJenDXxHvzJq7AyseRj6FdHnFlEOyngz4iwbLVkm0ooBpbi8HFHlly8?=
 =?us-ascii?Q?nYXXJTF6hWLM021Waqul+RRMBbp/nE1hIgQXy92DNdRlFPtt3xVLaF/Dbs+O?=
 =?us-ascii?Q?XCq4pay1+TsxTtVz6aR33Ev7ZDTSuRbXvF9GroVoT1iC9FzIPoE4g2AWwFU0?=
 =?us-ascii?Q?h7YwIFjspqGhBgAFFoTMhnuXZb3sEcV988M+UYwTA0xtN6FJMISOj1Ew6aO5?=
 =?us-ascii?Q?zWmU9JSZUfmBmVGShmGafo6yjD4Zw8PRAdugufmNZE67o+8XN5ax1ZE9P3tP?=
 =?us-ascii?Q?qNC5OtihePs676BCws+tnmihiJmE7nm7YUVWNA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T7wDYx8AeBJ3bKMJT4DVkfLodFKD5aeslV8s3KdtNjSg1qKkPfJwVCGgmQCn?=
 =?us-ascii?Q?wNKk5Tu6nLkFpZs347zWVwzzf068pmrnVeL56Qr/raqMlZDOfgDSzn9ee9u0?=
 =?us-ascii?Q?brXtX68yACtzZ0Me0xTbFz5a0UjiZFnobBkLUSb+N/HrFhquJ3qT8URvsAiI?=
 =?us-ascii?Q?+iadQ3P2ZJubwg+QFhp2Z2N6gZRyrPErUupaMmASjPbuddZvUNTMFw+il17j?=
 =?us-ascii?Q?s43P4zlZF0ELBanwHGjrF21DNEC7ve5/z6MMv5+NjrW5gdLWrXpMMmHV6wE4?=
 =?us-ascii?Q?Q7d6P0myz1F2T/EWDkwtxXZhlKH7iYlVCEiT73GoWd6JLeK73PP/kS6GIwS4?=
 =?us-ascii?Q?G9D16pBm8pYwHm6wXL5Em1A4/GTMzeYscpPlK6DgrHVrFxa910Th8Ur6a8Vl?=
 =?us-ascii?Q?xkSXijEEcGKXVgiCbsfuGcSqDKhKYx45uOc3cPo33FbzfnaEiRfiAyNvS1UB?=
 =?us-ascii?Q?JC+YLuXJ+kt2baUozfvfgdNKWSl+b/aZ8K2o4NR3QLLCLR0HJDmdcuBWVmfw?=
 =?us-ascii?Q?cO1gzP4bGRUuRTItw8/uF7WMwwJbUbkPUEdrlpeaJRAbDJvJvvBo/COP7eVW?=
 =?us-ascii?Q?vxEChhdZK0OChIt6H3VxNUpWyFK/GPTKlC7UlsWpmKkDfUkw3YGg5fIU5sWh?=
 =?us-ascii?Q?ts2WjVY/g5+uxzCBX+2qJpPTLBGXz49uZ/pjQSd0sLVbUifgVyRM8zIuD8m1?=
 =?us-ascii?Q?AvR/3gj/Oq/NB9Bj7fjOTlrssgNzjIsNjxB/3nzjHLaoWkyQ/pP5v1cUqYno?=
 =?us-ascii?Q?Lv0iu1ZconhpN5btw25F94T4AG9QYCENgEXB+Kx/s2OCnbx1E5BN31cDmd/u?=
 =?us-ascii?Q?WIF81nWAZylvxK4y+bgSSUa6Vh1uiDfroXRipEy86rQveVdz3X+6IrTXIvjV?=
 =?us-ascii?Q?+QDbyOHowGaopHFoa0m3OMBwtkklhXhBcth0BKms/SGy04+k/fhslyOct2mm?=
 =?us-ascii?Q?4PZzv5jUPPUbJzGInbA9OwvQhkieJeaHj+0Umla48a6TPAOQceXifX8SjmUC?=
 =?us-ascii?Q?+u18Y4NdsfLwxNlV5O4FlPkaBleX4qzHt2cCiSfbPkbUqW4Y30imkIuww6xv?=
 =?us-ascii?Q?n1Ik/JA7bNlWZK9Dp/n1nPMzYkmcpXSAuZBLr1nCwNBnTRaPRYiMwk5KBHjk?=
 =?us-ascii?Q?AnfJMqyIpcG+5UiKsjg0MeUFzPKx7j/5in66vfg1hWKmrbamoFIrR9aC8Z0T?=
 =?us-ascii?Q?scmolUmf9ifarOkY0sP6kH4m4DYDeEPJkxr+ky9/vrPTCOTERD1V7civp1A1?=
 =?us-ascii?Q?imCfx6EBtRnsdy+eBhhhaFL4YondJCW2WozzARUjfBjLeE+glbfkBp7GyCBU?=
 =?us-ascii?Q?RBk=3D?=
X-OriginatorOrg: sct-15-20-8813-0-msonline-outlook-f2c18.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9af35d-d4ac-4e5d-9b44-08ddafc5643d
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 06:40:48.4224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB6749

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
index 2e812f5a6e..3eed2360fd 100644
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
2.49.0.824.gcc76007b2f

