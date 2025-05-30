Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011039.outbound.protection.outlook.com [52.103.68.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E0A258A
	for <git@vger.kernel.org>; Fri, 30 May 2025 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748626383; cv=fail; b=OTbWtsyQotR8NyLkDsYL1IvanJqZQ92+xmy8FG884BhcLMJ0UzX57W6BSd+5jnp2m0YEiloMrREWa4IfT2HAdKRA2PKlG3ZLL6OpYsHiJoaODpldFQEe+6yHwnU70pEOCNaKFSJ4iIyurHLMgo8ZHzd7upfW5isFmSYd9uH/5rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748626383; c=relaxed/simple;
	bh=tDbiCljSM/gc102Sp1d71UdahmFcdppufTGtkFp7Qz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nh04fgkpRYF+IME/2jY0MSkoh579RaWhvGYHhM6n4cXm0nbGaGW1os8Ca/1A7wWNGuasH+IT72Wa3zUkloVzj087u/YF4p/Uzc34bzrgdj4hJh61zuUBznJdli0PZYYaRQ4rby+Wo480tYveE6V0iJIY+eDeaA0tiUsRTK98tOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=qhzZVo1r; arc=fail smtp.client-ip=52.103.68.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="qhzZVo1r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQZuFlcY5Xxe2okzEhYInMlWiF1xzmLj8oTm1Tz30TkbHCWya9vFKN1kS1Jm+iyU2IOK48qZLeu0gLGrVd00aN59YIp35uw/dKZgpHV3MO1OsHkvoc1nbG+mhqXDCxaedehxnfEQQdgRCi58f62Dl6cpviCHC+fllXQnecMuiCd6ja/eXRux8J0uztdqH2ht9LhKh+LTxLZ78M3nIkbYDi3sP7z+tOcvCZtA+1R3Jq4lNPJAClg2oscZrpvq1YIvFk4CgdLBv/ji/BRHFb6JgGKSWIgXM6N74IZ59MBIwTzFNdLtOT0gxXmi1HgaYy9a7UhJ0KNYwYRW+K8E1RfC1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Wqn/jrJ8CDSQqAfbeQy2sKUGUtDx5WhvMpEcLj5nZw=;
 b=sS6ihGhcsGTeJ4SOJdjm0YX65wiSuOtGLrSRlykPcaJAJZMXKLz4FciLhZc7UuPLb0Fx59i0oYip+KGxjHtTFetm1bpEzhPrkEHogcpbQTlb4/mI2UXHYISNczy054TjqweMQ8D0Gi6o12kXvNEb8JkAnSNft4LCN5C0SiqMbzJs1P7YR1ksAYUnB5q+Xx+f2yLMWrTMWTfJbVKEEzjdYCrHRKafezTmCVWA+kwfu1PC/lCmv/YX/3NdT7xkjqt+NGQkifEy6fVdAnLtHpSAtg7M+QgXUQNml7kwW9m/igyok5g8fsVltT15SIbfSbVBBVFWxVNivHS1/osKGvxpCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Wqn/jrJ8CDSQqAfbeQy2sKUGUtDx5WhvMpEcLj5nZw=;
 b=qhzZVo1rafKtp2MF2TQ7Ku4jpwPzMUFiMKD90U1hvrgFnaPtMGOtD6GoYy+sEUerAXWVcf7hr+CvGtlul/6FnQwEovoRYx4NlR5ArbhpWJ0lSYS5aBFXWNFYvJsIdHKP0FLuDUI1tSdVZ+XNXc/qFdLf7e19Y4Lk7w3HKXf+z0/IagMwOV9lxuaf7nnMP9iEpPIpKYLp/6Vf6KMxjUC98fpttzsnoukmD2dfUO7NT9r1jvUcIG2SumAPyvhrb3bMvOmG/mwbB1pNXrAre7zrIg/1/63XYfH2+45v5g8MwUdXWsZ/mRkyYwXoqLuvVuvjwgWOZ4TSGkvrakI2BQjVrg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB5501.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:4b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Fri, 30 May
 2025 17:32:49 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.031; Fri, 30 May 2025
 17:32:49 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	sandals@crustytoothpaste.net,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v9 8/9] imap-send: display the destination mailbox when sending a message
Date: Fri, 30 May 2025 23:02:21 +0530
Message-ID:
 <PN3PR01MB9597BCBC9EE3A93DA00A98FFB861A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
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
 <20250530173222.20211-9-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB5501:EE_
X-MS-Office365-Filtering-Correlation-Id: 81cc961b-3636-4dcd-c14a-08dd9f9fffa0
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|7092599006|19110799006|15080799009|8060799009|56899033|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UBcwTOcyaUharribwOgha9cAmfuwy0ZRlNuXQUh4rQ2dN2cy1k8KkklaZHts?=
 =?us-ascii?Q?ok6N6lMNa64yWUh9RUVCTRq+2Ssek+hfya9mO2BJzlEwozNyO1zhl++/WzcL?=
 =?us-ascii?Q?fgSxMPrpGA7MJLn/LQjcRwG0G+sWHw21UKK7tQ3sN4CZeId+jYJcAt00CSFY?=
 =?us-ascii?Q?9vPP6PIi22JbNOEneL/buz2g5DQJnwiuSTUXlhxsYAobg4gAkiWZpN6mGZqa?=
 =?us-ascii?Q?10NHNPhfTgnB5V/5uIKqHf/+mR3h0xL6x/cwONrf4NQehpYxDUZfOm1MI90w?=
 =?us-ascii?Q?sBjXd7AeYI2JKsZogdfaW0/nwmb7BYehKbrfmikNOgOyaHTPWOrZfSlqxhJq?=
 =?us-ascii?Q?QTstLmOQFuMXENSkQYflohVGoDdRwSU/Rgc6xxnxdKcfnqw6I29exWCNuHqU?=
 =?us-ascii?Q?2/e1OjjjP+FF80b/aTKY7Hq702/Ii8d6LH2jyWeLFGWUF4z05EdO8Nhd3Qpg?=
 =?us-ascii?Q?f2WHHi0epKR6P2SzpG+vBAxdMVTpbocx8GuDrSrN3lOVcipxHEOpPCZiarY1?=
 =?us-ascii?Q?1ruwKeIGh6TPTo1IFKOpTb4rnPFq3doGmEBhMEUmAgzJtiWkD2TKG3S0EEWC?=
 =?us-ascii?Q?JwIj0QMKNPKnfidBzSHc2M6qowIpjDyFcumbLmQ84DmdN9v1ntrMDUWofK1y?=
 =?us-ascii?Q?NKUBNQ4yt/rnpLzeZcTTrJbzyU2Q6u8jFl4y1XtY+6XJlAq9bybmqfI+VZaW?=
 =?us-ascii?Q?5chdL0skf55tLOp57T0RTIeQEXnms72mRVvQtbMPfx75oFSjvRfU6VbXn2la?=
 =?us-ascii?Q?IDe1dmykO17IwzkxA46x3lF1sZbeb3nquTiJKSVD/k1dp6N3FFBTXA2JdN3D?=
 =?us-ascii?Q?x3ZoI25F/a/mZLBSLcz8FIvDIrZVhQUO9Ukt+Rn+Dap880Ad/vSxeU7lcRaQ?=
 =?us-ascii?Q?bhpr2kojY88skIAA1Psv4axQP71FRo2lIdNYWILTh4R3eu98yzHB4MjIZKEw?=
 =?us-ascii?Q?YdfQirNA8fXFWeMo0k/eYfYlk9Xn92zVFIcLl9JLoJgijB/R0BhjXPgS0xTH?=
 =?us-ascii?Q?D9ab+E2YvqGpPqLsvxWsjOnkeVit5I4Wsrsk2f0J/krOeoAAz2k1aXP6QDv/?=
 =?us-ascii?Q?YZiJqgPzXryom+cu2XRMrhYlr+uaeytCVKdqsSg4UJCJEZ7p3z8=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aQhyftNoPz4ttMOxmMMbsDMOWPnDXL+wk11psTN0mjOmRx1uG+bf7O1oAAQm?=
 =?us-ascii?Q?Ls8WBrCYTz81Z+lp4tFW4wrrlR6xRPo6LRrZNwKPn7LUxy/krxbQ76tZWiHM?=
 =?us-ascii?Q?UGtaej5rgyAToeoJLr0RL9kZnlAx6dpnvMJbcsyGP/R5KTI429482pd9FxxN?=
 =?us-ascii?Q?pgtE7/b1xEQkSKy0hnyf5cHo+wjs3cl4vrrmoCJM68S83srWfQQjLTYK6Wq9?=
 =?us-ascii?Q?fX9C/w44DI9fnEa1T69q4ZfU5qC6twFJOPJz3BBlX74Wgtl/tjglSYdNXTdF?=
 =?us-ascii?Q?HXB4w+tBXUTZw3saBK3Xffu0NHJ2+ZJHpW3/b56U9I8JSLwG8LaxDY7Hp4yO?=
 =?us-ascii?Q?2o90pauDt8ZpZwTC1v8tqBK/vSLlQ09qNtbbSo/SQbwD0CxyhDRYMUL7fwo1?=
 =?us-ascii?Q?RvwO2dAKrqfudFcEJK6KmpFSHQ/CDCHVPOu2f8GP7z8zge0rbqqOugHo5YW2?=
 =?us-ascii?Q?/OdJc2zB7boolLMEb8oNEE1Y/FLoZ8ynEk3FrCD8D2ZT4XPYho/0l37BWBBS?=
 =?us-ascii?Q?sazr8toZSgmkWg0hBUkyWRDtcl50CeAzUhbWzMMdE+WM4csV+6sSwJk3iKFo?=
 =?us-ascii?Q?XRC9VP0Tft18OrMAh3jGxWVuKTMrCrpjhVnlTOX4njuG6+gySPXfxldhY6x+?=
 =?us-ascii?Q?8EhRKYNIaT+Q2iQcYE2fbmpyD9gLp6o4ATNtj6KOFlunTphHjKQhCHRQ4EOR?=
 =?us-ascii?Q?y9CVCpRv+g/+p7p7wlnnGRsKIEB41vy4H2oTI/pGHxMpDeqyTH+JRu+re3EJ?=
 =?us-ascii?Q?+Wu5PEclM/U8ZoI3B4okcBcxDU8E9sXgj6BnXkWnSPwBLyjUMEjzHGKbiiN4?=
 =?us-ascii?Q?KT/QNjz+qQe9BUng4gFgCFBWI31XltBSLhO7AMdsHwMz4UxWpA9zgkZj8Tu3?=
 =?us-ascii?Q?zjK8Og0qOwqGLgT7aCp2RrEn5DXARIlvHYx2H9OKztg+3ZIzgkbuo1oe7cIA?=
 =?us-ascii?Q?Zr6iLx5tUY9h9a4M3hI2KwfhmpOiqEROw0yPwBqJ/wO5Fswoe8K3NwwBR0Ct?=
 =?us-ascii?Q?xVLgP+GF8QoTsP4g8NBtZghH6Q1gYDfaRSqhgEKegkVre9RxH17d0ZYGk6Z8?=
 =?us-ascii?Q?AgWCSExOEHXDGYumnF8iGKwjqXQZFZP7bBLSgJfiJjDBNM3NYPtfVS231nWb?=
 =?us-ascii?Q?c3qYYxDKhCBwsI3tzKR1/27fRzH6fHWUO8im9gWp95bKIqJO50IBmJhubYsv?=
 =?us-ascii?Q?IFS3AEefAhKPwOkFo+22iulqWuOFSqIYn7FT17iGswMfToGyQvsn54sKRhPR?=
 =?us-ascii?Q?B06W7GOwbfjISP59ODxIrPO6XAN4eZ0KjQ3JbpWS5kABjTkxoLckeG5FFZqc?=
 =?us-ascii?Q?kuB7By87uIbzOYSG5acW+vxy?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 81cc961b-3636-4dcd-c14a-08dd9f9fffa0
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 17:32:49.6674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB5501

Whenever we sent a message using the `imap-send` command, it would
display a log showing the number of messages which are to be sent.
For example:

    Sending 1 message
     100% (1/1) done

This had been made more informative by adding the name of the destination
folder as well:

    Sending 1 message to Drafts folder...
     100% (1/1) done

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 imap-send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index c963ce62d8..95b78fda42 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1596,7 +1596,8 @@ static int append_msgs_to_imap(struct imap_server_conf *server,
 	}
 	ctx->name = server->folder;
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 
@@ -1704,7 +1705,8 @@ static int curl_append_msgs_to_imap(struct imap_server_conf *server,
 	curl = setup_curl(server, &cred);
 	curl_easy_setopt(curl, CURLOPT_READDATA, &msgbuf);
 
-	fprintf(stderr, "Sending %d message%s\n", total, (total != 1) ? "s" : "");
+	fprintf(stderr, "Sending %d message%s to %s folder...\n",
+		total, (total != 1) ? "s" : "", server->folder);
 	while (1) {
 		unsigned percent = n * 100 / total;
 		int prev_len;
-- 
2.49.0.639.ge2dd5d9d81

