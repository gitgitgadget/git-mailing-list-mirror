Received: from MA0PR01CU009.outbound.protection.outlook.com (mail-southindiaazolkn19010005.outbound.protection.outlook.com [52.103.67.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4D7239E96
	for <git@vger.kernel.org>; Fri, 23 May 2025 12:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748003013; cv=fail; b=NmmTsE+bjJFlCdK8bUKGXyVM2oXjmR+nhU5VQFd3MFMAyJtn8M27GBhtqsaK4fwUnRV3K3rfzyqLS/w1Jmx8oTWZd/vxUAftxKp9pN5ys4SWIfBlh2u3qtMt/LMqZ+9ni9pLcZA6t92WwSvHXriApHfeevy5W4APKMDL03fcVPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748003013; c=relaxed/simple;
	bh=HUG+UCkxLMDfvKJjWtf5JHQ0vHOkIDL2nv1FFG8PfHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mj2RfxqA7VgaHuGc0DS+efZPsAhRCC9y08R1lMkRxWVeD+ZQKMbTkDh3QmZOp/oCM2UozUul31LntimHFvELogUtUP9efHvsvn+A/ncCYsg+41ijqFoRBuECzkK70BqiitilZ/S/OfKhYP1LD+8d+ezYe9HfYySyQDcVd5oRneI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=oRNAaeZX; arc=fail smtp.client-ip=52.103.67.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="oRNAaeZX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vetPLX+BEqKJ8XYePILjMA0x1tDDzmVVaQrdKm1l8WOebZqpN6sht4dfGsQjEStdsV19EgGgw2kcQ4Mokk1x6lmUB6R2FiiHElXOlGPBnED7vOIQsk7w+zwL+Kl/3t3qfHpor1UadXIYl1D/ZbTXonK6ABEzSiILsfC2sKcWyt9mcULZbPPof6Ni+Y1K42W46VoI4YQJWjun4HlU85LCyhsDGRvBTG8yfVWy01QgCjb5BDm0w9x7acrt4PoOoRC87s6us4Ylr7kUQwiOkIp/iRnQxidah37EKVNe+dhb/5cwbNPmuEgUug1fAvMRTw4E85WYQfg8Rnrncy8dsqU3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y9xvrnsGGipSlukcrY6oHMiIpb3y6sci+Bv4oJ0zI+o=;
 b=Uz/21GIhS6sjleqAaRyteJkFs1RSde8PoRzsH9cS293Jr9bFUmNdLdSIdbzbXsNzEfIhlOyT34zpY1eb8Do+bxaB3lVc+G/uPUYQof3txtDIcdi+cROiStOqkPulUUsU1hOi7OoIoYZE6mVQXXloseGQ2HoIHnS1Np0droyxl7RUi9TolWqHt0a/o2+s5uyFyauVqCDRFDQh8OxE6EeUXEAZhuVRxTNYVkRvUczNiPjNaoTnfeJf+FUr++O70LAtfXpH9Viq09i4a7YbiaBPF9t5XdE4KqhgqdNZe1OTPM9ZtS+G3ODCbfEwz4FPMyjGikOBHiPlv8lo9/Ya4o+itQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y9xvrnsGGipSlukcrY6oHMiIpb3y6sci+Bv4oJ0zI+o=;
 b=oRNAaeZXy2ZQ50ODspWztiXaKv4k9ufMkndJTVN+e+VWaTtAaiVfJGyMke1fYk4+OFc8RSX/kIR1bmCdl/hLsUO4H+aDoGqOz1Uqs62HFS2KJWJPb0CBCuHkxyJoCNe1WaJ9jXE9TxrrtTJtibMsxl2p6Ie5uHQ81RIp6gGtTL3HNQxhBVEOkckVvwEk687CJEvBQYbLHERPGEZoECByXheKzcorP7NK9T1nEz2pIRI3KE1g487oIj6xttoShjTb6XVFgu7ufQmV2yJpgt9Lk0gJ5CupMhTSMkwELR00hVEm4zoDYSuulmiGlBynTKNGc2ZukJTn8hvEBiUIn+Y3PQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN3PPFDDCD3ABAC.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c04:1::57) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 12:23:24 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 12:23:24 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Zi Yao <ziyao@disroot.org>,
	Jeff King <peff@peff.net>
Subject: [PATCH v4 1/4] imap-send: fix bug causing cfg->folder being set to NULL
Date: Fri, 23 May 2025 17:44:27 +0530
Message-ID:
 <PN3PR01MB9597D0F7CD8B8738875D5F48B898A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4P287CA0030.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:26f::8) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250523122236.22593-3-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN3PPFDDCD3ABAC:EE_
X-MS-Office365-Filtering-Correlation-Id: 23dcce3c-e717-48c7-dae1-08dd99f49cba
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|7092599006|41001999006|19110799006|15080799009|8060799009|3412199025|440099028|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WqOrv29vLQZVrYj3Mlk17YqlmIuqxoDbsdJsGoE2ByqUC0ZMmEqwQpbB2anO?=
 =?us-ascii?Q?tsmaQKHOhjnijXGnX9shqwNJ6131+Qndx2IP3PFjVjrNYQSGliXEJCswICOO?=
 =?us-ascii?Q?DT+xPKKoCKjbUeS73/aFNEFrKQ1EhyMurhkBpibbVOPab5g5ww9p8Efmg2Oz?=
 =?us-ascii?Q?RNYboSnleJ+R6nqxqMidaN9HdzbVItTyEJMqp/CO6UxiTOpZ+3nOZKtzc31i?=
 =?us-ascii?Q?kLPaH8zGpKjkjJsoQZphG8ezC/FV01Xq6JXIvG4RRjbF6igMxwFMcPTKjqDm?=
 =?us-ascii?Q?sPJNu3ZPbYaWKlFYsPhZibkCObk8a7qExPSOt9D+1cIYqB8tKYW5ldRulYSG?=
 =?us-ascii?Q?4tBQUEm3yfWpGQ142AeI0pMymrfcb30vk21HSh7VPU+h9RJyGUR59R35LGP7?=
 =?us-ascii?Q?z4KiqrzO5bJZcA+oaUryxlWYjQWTJ1qNn5vZIUCvc4FFnA49WGtMajTKUtcY?=
 =?us-ascii?Q?evW839Sxekg0+wyV5tWJTKcC3kAD97ObHQ8ZZBWDCybhXgoV1s1+ailFVRG2?=
 =?us-ascii?Q?kgHqQ/6sSaZuP0K7099wqNe80ZTHg8u0zwIVFPRmy41ePrpIS6VtyllED9eB?=
 =?us-ascii?Q?Sb2HNts18jTOEJyKcAPISCDFlmyE0I0XhTX9wNGPeUHjl9Gvuo2tqvnKz9t2?=
 =?us-ascii?Q?YisBa4cR68U6EGFHUjLlqL3xL1TbwuNleGYcs1M/FFIM7Z5tNC7A/JaKRvoj?=
 =?us-ascii?Q?9eaItRLXq3MHBYk38d4bq6DXx1T1UIjXdRfX5DMr35TN0jBGk32zi0+XkEWW?=
 =?us-ascii?Q?pwRKTP4zyG+X+zcjzWdm8/5YU9oUnliIWxR4oQ44Lnv1UJq1hEvm0XZtxLKp?=
 =?us-ascii?Q?Ia0iRgM+rn8E3ICX7J4BZIPGhG2t1ET5WxaTrGErXaERN/RPKcwT2ofh3mYS?=
 =?us-ascii?Q?Bpj+qunLjB1YmROYIA26nqKPkGbJpdvg660Y2YF3eOVYXc2+f1QCYY4w+sQ5?=
 =?us-ascii?Q?qnCKmhMHWuGfdY9JpEoC6L9fb8MbCRMh4VpTGCJPc4yVgHIEdVgGv3jUm9CL?=
 =?us-ascii?Q?0foYwnseQrySy+K+B7XKpMTCSWhVhm629pmpQXfW9gLQKoeZMZLIh5Zio1qq?=
 =?us-ascii?Q?THrRvLwBqkhOa1AZANslCBH+xgeGAnHVYoKuiV21VTi9cyKAlYFXjKW12Fj6?=
 =?us-ascii?Q?p+iG1HVVKCMgPef4yas5BpOAEfMJzt3d/O2QfWiv9235Gg5txrwozsA=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?max6Wug6hRfGtUCP39BOVbFVaO74GcUHWdCeS1Je6sL9dnVDyqggfxW/Kf1f?=
 =?us-ascii?Q?IUqJa0UVoe4CmL9KmwBGli/lolIz2/blgbqIn5gbgmRAnb6AnNv8Fs6cqtZj?=
 =?us-ascii?Q?GokI3OzG5QeMQgI13Q+O6XbZ6ACl6xFWCKpv/tLPiRH3LbxCJqVrpPBzuWJq?=
 =?us-ascii?Q?wgJS/9bHXRftHPCEYtk3X+CwTR021gtDHDdJ4GdswOKEziZhLOqMy0wH0m2e?=
 =?us-ascii?Q?i7BCiR03y7twyuJO2wPJqRPNnOglrVDFKc7f+F6itqEMgwoxOGm4ak1dCO6X?=
 =?us-ascii?Q?bxSsg4lSBmcYs3FM8hrOLjBjozLFvxESBhX/B1q8FqnWqGs8dYXiAmKZwgqE?=
 =?us-ascii?Q?7GV9VrMeJof38Db4NTwOyhDhP0xrZyHYxQjyFr8KpL8gnlGbOVgjv6DOOgiu?=
 =?us-ascii?Q?pUQVtbGqmcM0655Wcz/uXYsapTswQJL8BFdoODdtMdKadK5J09m8Hj1P0btd?=
 =?us-ascii?Q?ax6GBqC4ScipLSe8L16jeqZuzVfGEdvQnfhKmtEiQA00DJ31ZKzMVmk0tKjf?=
 =?us-ascii?Q?11ZFtt1GGYR2Q7z7rGPn5r7b7oJDVYKX573CgsoLCvamhf7ZjsmAztR/qkuE?=
 =?us-ascii?Q?I39jItxB0UXbOOo5O+c3m0KW/Omt3Gzs8dondtjBLm6tuDw2xaE0EVGkl4BV?=
 =?us-ascii?Q?i4Nc6iQ8W0+HgDX4yVuxlnEA0OiS+vfSq5ws9tCqa2tlbv4SO+8Wv4u5CJC4?=
 =?us-ascii?Q?8KZ344jPWUzpWxwXtm3c4/e2TpB31RVgo2EarJ1b8CH1xyPMdXBZ7jfE9Moe?=
 =?us-ascii?Q?ESpFATDkOdIPDQjsSudVW4U1pN8AMK/XKueuBsS90Gpgbfekh7sYei7eLmDg?=
 =?us-ascii?Q?qE+T01G5peUco8G8T0ckSdBgfVpP4jCCHl6kKKHrQL8hi8Y4fZEAWcb3DVXu?=
 =?us-ascii?Q?ADKvmUtukN0aw7Ql2K+/cH5MreCpdWLCnzpvLqrjvgXK63T2RSSXcgkZeDey?=
 =?us-ascii?Q?ZEEKqg5vbvh9TnPc72fRqEfqCeOk+AZxA1X34oM0cq/mRBKLSz6dVa89Sq7d?=
 =?us-ascii?Q?w088dms3XN8kbXZVUOiU536QtyoDixmj6PuuSbx1viIO1e1ZMoyZpi4M2PhY?=
 =?us-ascii?Q?PXCjoLY2NweKaqh+BfIgehvSaxd1Wn9df0IR+2Bc43Id09jatTv6SshxrnO6?=
 =?us-ascii?Q?CHtA/ZK7iR/0tSV31yuOJe5owUR9fO0l5JBtAY5Kz5ou8PwtFX1F33ZJykmT?=
 =?us-ascii?Q?A2iubAexHVcG8XnUKuU0iNKTdsO9eLa5aeVC/UFSPyqt0l5ZIBa7ACo9cjkM?=
 =?us-ascii?Q?W76J5IqD9PReuVOzHy49699Dz6iSgr4Z8s/X0VnpyHoc6z7WxvafI8R3UWqp?=
 =?us-ascii?Q?eVA=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 23dcce3c-e717-48c7-dae1-08dd99f49cba
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 12:23:24.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PPFDDCD3ABAC

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
2.43.0

