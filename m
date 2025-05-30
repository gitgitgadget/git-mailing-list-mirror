Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318991925AB
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626372; cv=fail; b=V3reCfOSZkRHxa3fmlwOEzx2Q5ukWAEV4osQ3V+T1MbKpIO66nSiOSWnMs6E8zoRn24e3YmL2xTKMXDu+ATKpa4/OxcK1q0z1/kELkhQmaVXFXyDWCnPPVJmiqikMXU8UhnHwK1Z71XCEWZUnWeuUPuDqMZ67r+U2MJZBwcd2OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626372; c=relaxed/simple;
	bh=emCXEosWeUNJfEimtg70RYAysw9zZBsBAK/kBM0acRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f659zs2dxGf77vHWBQZYqWzWD4O+RXp0W+r/wA8gaQ8vGOBJjdI0Sbko+mUmpukXWuHHbugY9Du+jkiboP5GD7Hm62CL9RBr5yI0Dh2mXhhts3ij69VS8iD6M2tVvQeMncPDgTIp+EY0AqNU68WPXW0/K4Tuh2kJ5k55shkM38c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=hAy5Fy1O; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="hAy5Fy1O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b4T5F3REtqW5jlAaZSfEHjimLc4eHfVx+DxwBJ4DIEw6sZm4/qxdeFRZdo0Sk5twt7jXgfxLbzI4y/6Fl19phKo0EppAlyoRLdDJ9GzvUyuECsYfmTav7Am/0UUJnEiq7ZF+q4JhWK6YktKzfeImcArnohM+LytN/o2gLjf4mMd9ONZMMh349t1FljdirTGCuyjaFol/2SSZj7D5XQbKursKJwy167XhLlNznKqSUxJvJSn3EMa/T8EiU2YoWAEnF5a43y3Ecyy1b6HZwWp9V5zktFMoh1S3n3ogsbBEsIioiaHD9USBjvXOsdqZgPUlaqYi9ZSI1dzVi+FxMfV+iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fur0h7XfXvz7QGNbdlCdZ5A4WLs5ejZdFV30EUPBRpE=;
 b=p4RU8ius0ceoJxP7uIxD2NuoMxLNu3xdi6MUFGa6Zhv/aK1Xw5vIsEAEpo+8Y6RpSS1LaP4YEwqFSELthk5uoWyFgLLd7gN4j8e6IL/jNiDZYtUJPDbdjKff+6QOGUiURc0qZvhE40lF08qcIIxpj0+KslyzRD50zYXaMz410PFHs9MO50FCNCgrrNuSgVmsmj3+qx1AtCpGdgzyJLHBCIt56pvzDCZNUvTSDftcTdmegceENl7R6k1i9jK/Gd8DlmwFjyIQkeUatJ3X/ZevnHYQ3rnWdVEfE8CC2On1aATmNcQqRiuXkvYolcVU4K9cJVTaSLRXUwS9j1dnG0sl9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fur0h7XfXvz7QGNbdlCdZ5A4WLs5ejZdFV30EUPBRpE=;
 b=hAy5Fy1OjnFD2jSIUa2os+jNtS05rQwwgz8Di8DMhfN6u3W2VgktRgE396KHCxxg/j9j8scUJmLCJFMik4UZEu/azZA5E7jBOtT5rLNZ9hYLsWuVERC0Gp0w96K2sBw6+0uudtbtn7sFumd3KsXBLD3E0D1rP2gwYmVvfmQ53i/P402Fb0cu4cQAFc9h1vyjWQwEWGJxLTuo35UtV0kyBJVjrEgQJ04rl+GznmZ08XGYZHepI2V49gTWKFJjhJvOQ3wj1ZeDYaA8qc8fyTOA6zi0C6yawpT9Zjv/8n+JnIMmQB1Rxii2+2HlKDzmo7U25hMqaeB451Hwia82Pma0/w==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:43 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:43 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 1/9] imap-send: fix bug causing cfg->folder being set to NULL
Date: Fri, 30 May 2025 23:02:14 +0530
Message-ID:
 <PN3PR01MB9597B41B3091DB81D604D33FB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.49.0.635.g6f2668de07
In-Reply-To: <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597B444D85F7A7D1B6546C3B861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BMXPR01CA0083.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::23) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250530173222.20211-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a56714-4116-444e-571b-08dd9f9ffbb9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQHHVPlUqvKngnGFkFEGN18RxVsDUqe00YI1NBldzbcyx3Li65innjNVIP08?=
 =?us-ascii?Q?G3XUEzoXoFU0W49l74yK23orRqH0Lxjdzs5zwcIgc40/CMeJHaSRVe4C9TaU?=
 =?us-ascii?Q?dzcUckwuMZV7kdgkUwcWVrrElxlMLTlHrdHOfAAfnUyynUI5VhMLiM/+qizZ?=
 =?us-ascii?Q?fqbjR8KlQy5hOD7R5x8ayeObJ0JEQH+oXOlaLHIZCk4yx8KNi6QykKVlv2OH?=
 =?us-ascii?Q?g94S8q3XmX9rGPCoAraHSaW8/43B8JVDJd0+o9lQifHhWWx2pvMi8rFslqvM?=
 =?us-ascii?Q?ywTdDm+0mOg5G5JsZd83G/KYnufnf3rLaPKTGRmDNLdkaexp1/YSXC6ToeXa?=
 =?us-ascii?Q?8IfzviwHZ+JwnCAzcAxPtozODoI4Vsns1javjvXEF6GmF+CibQpJLxpZ8kH5?=
 =?us-ascii?Q?hX/3rf6wikdWLeBKBOJ1+zBVt3+BfRFCpjOvNS2ssLjffRVmFjXiXlhk/lk1?=
 =?us-ascii?Q?W7XgM+fh4qQdzEMMiY1Rwj4tKTa/9pyihojZCaoUAz4kY5sVzSzF2HmtTQ0h?=
 =?us-ascii?Q?/rF3aLUjSQK1UVrFtBqKlxWPwTYNw4b+SwMZiJac2qiU+JfoEoXZ+Qf9xA5k?=
 =?us-ascii?Q?MfbHqaMjM13FZPUqOKmsJiigZlwReB90mrhqB33Lg4Etvz9EM3skn1rhOSJe?=
 =?us-ascii?Q?5dIooQTsllrla75nLnOIpBxDQGQo411cle/f4yJKH2kBuAusZZeqlj9+yPeH?=
 =?us-ascii?Q?5So3ybGS6tVXVce3tYP1xbjxf9e4HFaR0pLa2gpeBE0USlJYXySlBqqhIfCC?=
 =?us-ascii?Q?I/hDqYVuP18q/b9Y/G18SFFsiguUaWdWOzKXEv0IMo+Baz8vekf0D9VyOMhA?=
 =?us-ascii?Q?7j5hDZ7CjdZb+ikmsTjB3wW3mz4gftgcqK0LPfmQ0yJmFJSZemNHBhNbtVzJ?=
 =?us-ascii?Q?h9cLCgvLNMSDZRPP3w47oepjWVEBTJkoH3j9hmVRntZY7zh8lNxVBmrt1jfZ?=
 =?us-ascii?Q?tG+B/HWIYoOvsI4p5WOg/zdp++K8+HGdc1BO4jslSuigZ9C5oW8GATMsqYnj?=
 =?us-ascii?Q?YKTSE5yK1gUunZXlDmTEaX3HgVmSVcE5RHMaHjjLl+fjq9J1c2fALLsGYxI4?=
 =?us-ascii?Q?XeoBuqfSh6fM1inKOf/hxzzELp0/J3ES1qD72X5tTKqJa/9sh0vca/T9BjFk?=
 =?us-ascii?Q?ibUr/kgB5BOoMsY7lCUvickfMtK57YEPWQaD6av78F5w3zRXYyWeliw=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zFohD5rhOUbV7D4qeisk8A952vBE4zXJM2WReqFSsnz3bjS5Nugu6dXuKWax?=
 =?us-ascii?Q?DNjF3yIAH9h0+qsyw6CtXclgjVC/XaI64xgXoyH1TjfJfvO31rEODGOWnF/d?=
 =?us-ascii?Q?c9w/8ObKhIhR0bDOe6VsihPwBgGkj3nG+pfa9Uo4+jptoUNTJiOAthSzKABq?=
 =?us-ascii?Q?uaUXOHF/1z5T/2NsxEeTSi/ScGfdhpbmaady/FuFH7FcG963181GFN9LSLZP?=
 =?us-ascii?Q?Eaf1dCHRJt8eSQpOjwhaQaDLciymkXNh4eSbNFezbojn5jjkMn9eqnDqzDFO?=
 =?us-ascii?Q?vAUy8VUuD/KAEoGN5F3e15sr/oEaGVjufM/m5+u6NEU/HY4EGSOohCrnKsuF?=
 =?us-ascii?Q?w6I/AbtyCpKhn8gTnQT1sxToWqJvPGuQk3RAUEYrRRJ1xEIWJppeOwKwOtC8?=
 =?us-ascii?Q?pxtwjNp/fmufy35JWCMqSvPCcZOP6onsBOM67+ozDTXPLf/5BwTVgnt5KlAl?=
 =?us-ascii?Q?KwXvnsBwQ9WFjjc7n+iL9xMfvgzBrlC3mNS8smrUn3wyrmTA4SJgZEW8esdW?=
 =?us-ascii?Q?3djbXx5FeyzXtyLbiRcWb8n1sKG/6Zn+H+SSRuk464POKT43gFCNOIIwU47o?=
 =?us-ascii?Q?GYOR+YbgtBfl9MFmDtdEvazeT8ci5zHZEDdT3S6dHGKwmKGXXoIv5WCqJzuM?=
 =?us-ascii?Q?NIlJxW6Sb50ClM/cLF6WmztkpL0/iLmxlysbME62Xnk/67F1Ao8ezt5V+ozT?=
 =?us-ascii?Q?ST3aaZYXGM6w5ucrOPAi6v7HB1UvdLdS+ztRVLpZ4Z+zD9YB/GOw4pS3bYW0?=
 =?us-ascii?Q?xWhS83hUUJUm9xPV17a2PpJNlWhcdVcvicRZOY0RSKz4MyYvmoSOhujz7A9M?=
 =?us-ascii?Q?w0cUJkbymq/K8p6GUHWJeaZvZLKyMYbFA7Temoq1yVWIjaY9qR91AnYeihHo?=
 =?us-ascii?Q?IwkPn5M3IfVOsMwfxQ+0H8cFgeLvOFtzFRRC/xjowz9MIIZIjQsYSDZvWuS6?=
 =?us-ascii?Q?QkaWBZpqk3EpwEvqJiTrbTMDVR2U7saQ0CDDvr84RcUwmp/eZdx+LcZfb/tY?=
 =?us-ascii?Q?Yd6e+68djth5bNG5DeHcSC+ItguxQKK69E6PeOsc2j0i1vnyAYv12q1mmQPw?=
 =?us-ascii?Q?71PuTEiPcr08KetEjEmrl8RldvTFDpK1jpM7G+YF6EaZBT2hPxJmdLjzHUy/?=
 =?us-ascii?Q?sP/VrN5mc9BBK8DDSTeqFZHc+4KUG20bpfxmniOsMTft6ZG9GAtMwK8X3pvU?=
 =?us-ascii?Q?3RhXgrAS5cQUd1UEcqODfdQJWuXRofG6dOG8Xic3YEUrz6/dfq2KEiNAuKX1?=
 =?us-ascii?Q?w6fvKXh8csvSGRGwQcOBpXSHwv8aPSZe4Uvqftv3nTexVuZxoK1v5rjR5o1p?=
 =?us-ascii?Q?kWqR2h3rXxWWvXLG5bL4hMiC?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a56714-4116-444e-571b-08dd9f9ffbb9
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:43.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

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
2.49.0.639.ge2dd5d9d81

