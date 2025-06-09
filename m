Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010012.outbound.protection.outlook.com [52.103.68.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E140921FF24
	for <git@vger.kernel.org>; Mon,  9 Jun 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749500615; cv=fail; b=bH8PMTAU+PlXZ/PUtvDbEOF5bnLFAH+fv75rznLPCFEM3ypEQtxsj1cJE4i0FoynXEn96IRoMmWzvxavlgWn+VbA73uzUaNE9r3EWc/7d1vJuWA1fhw/veqrsBgaiCetihsPWSdZbVyetdgfFiHhamoYpXP61mD31+lRbUPJGGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749500615; c=relaxed/simple;
	bh=4co1M+z6CI3cGUnoCbnZp53mgKEE/qdj8Jkl5uRmkZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=guUSaNm+zx2miYwMrgfvHUYb8hQzvCG7l3hHTB18r8cGtL3wGnhTwsF6L/0n+MS+44/0DfunJW3/yL/4udFaRlMDdaV2GjxL3xCsIQXD50Zhlpi7/PClc9D5aOZQES6p+7Ee7m3YUsq7xmy2IHll4lovPzA7WfOEqjVGxqDq8e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=I8fUI9Ww; arc=fail smtp.client-ip=52.103.68.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="I8fUI9Ww"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK7oT76lI/qKm8LrlGErdbGKBICzftRzKKoSpnABBtMI14KASXzm9gqhq0DRQmvOQFDBKdZJPY9nUIm/3sGpczuoIcerbuZOYi4werwggWEJSv6jO7HfarPlGl2bf41QxaOpgP3yYj1Hvu9/6Lr7zapmkIIivIWcfT3Atse+gh/9v2iEuMirmVPxNt7lArlfjsmxuGy7PbcJiSN9k8uy5y/YM07doNYVbEN1NQAQhdY+Vl9khxnp2uIGZVSGXcA7/KlnSzQOdRpJZWHuCqdsxEqpWVuhJj/eQuwridkIL+MsjrgTTX432pO834TmMhGLWgC+Ffg9VPX0hbo88dNUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sCwk5FdqDvipK4UtgtubqMYixdmGFLu4YcqOfuoH9A=;
 b=DqTEsf1sXI398ZhCICxTSHLmN2rPAYgoKtRNb4dKObkJN0V7EOHFpQUi7GpaZ5bWTnXQxHZFF4osTaOrJX6u5uJPKssGeXnfzxv8Yfi2dhhw80hji+DA5xLgH0VaVLQRidYipI+g7Lyf5tf4hVsOjcJdngF9Izs6kxRnYdb9yjQvbKGsh5pSxJ3zh4ytZYvWKaX+6fqOmbBRbuA176fHmzfPXfWdKyIfgPXcJHh3knFyhW6AW6v8dVwmCuSk1hgLiDTs21DqlDurPgdIMHXIIVHUe2NUUg6zLh42cpyAI2g8ZN+cgcfiIvDCV2AwFsdiUzp/mR1sqgE4a8KyxEjpLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sCwk5FdqDvipK4UtgtubqMYixdmGFLu4YcqOfuoH9A=;
 b=I8fUI9WwLpgBAVZMRJzQQDtBSOw4CxRrNhixo0sJ6IOCFHP4TkSOg6u3xkIpqGthgIfkUeludmcwLC5jWSL7n9kmJuEIP7yr9RccH1xqsfl74QxsaJc82MURjHrKDX1U1awdQWPn3Fyo8ZaFasBJoXeAOG8Fyyg/h6//XpOu4UkfxrNgrE9ywdMve3IhmacGF3WM5MUI5MALr9odT8RJAH4hy7WrIGp9+Iw2JBrUC3H6yu0xakgDWiIEnSWH8QrFIhqwzhpCXPtb/L2Jg4TAm5FTRQWRu72oX0d4l56bL+NGVTPRhWDfWNrVWYXIK3+ucTcphZKWD2GLqg4akkZZuA==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB4380.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:18::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Mon, 9 Jun
 2025 20:23:26 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 20:23:26 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v18 01/10] imap-send: fix bug causing cfg->folder being set to NULL
Date: Mon,  9 Jun 2025 20:22:46 +0000
Message-ID:
 <PN3PR01MB95971E7AE1C3C2CBCEA5743EB86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597929CF956CBB1B8B7D909B86BA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYP287CA0052.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:23e::25) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250609202255.4341-2-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: e51888b8-66eb-4c76-1c0e-08dda7937d42
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799009|7092599006|461199028|5072599009|19110799006|15080799009|8022599003|41001999006|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eKnQdVidxZ175RR4F7I4CEv4x/XTK2LP5lQG9MmkV6zs/gBLfTOsuIkCXQqS?=
 =?us-ascii?Q?D2fL76idf4IxSYLxE1GUGbUKGo2AX/ygT/uqokR2ehf+g6GzbF7QtUqpc8i2?=
 =?us-ascii?Q?Q7Y3RGeJarnEWfZ4m6yWfV4EmbUH/uM7KpcN/6H2d0treHpiBcw5PgDL/Py8?=
 =?us-ascii?Q?IFqEaWtZuU7cC40rfp0e+vpd2AUG3WDjLWrRHbnu+sFFCU1BbAMkWr/EBBX+?=
 =?us-ascii?Q?/AuyH4yzhqVKMGJhflKE4bP8fazR6OSiNUOO9daNo107drQkGTTwTdQVtTS7?=
 =?us-ascii?Q?3qcP4fcJKwzmP0U8Mow1fPYskXYD+C29j1suIe66l1O3PoY3OjZt6KRuqG3i?=
 =?us-ascii?Q?xVU1GGGm4IR0KkoKE5s27GcE5UwE4cJfZb3zOsxFAfAVs/tN9adGNywkijWl?=
 =?us-ascii?Q?f8l819cRlv3gd5Pd27+jjNn3lplR49jkSqUngTteyOYrou+Vkr5hn4PQjkjp?=
 =?us-ascii?Q?hMIQ29+0veCuPYmCWSJODAbi8x5xaHSurM5gO2QOv/8ty8MszWrs3V36q3qG?=
 =?us-ascii?Q?I2j4Nma1Mn6yEWFqDHjNL+ScTpRQ7ff6tE7ljfMw9HftflisEGhxXXD5EdMD?=
 =?us-ascii?Q?d0MsoFyFZePdPpwnhIm3G0J3wx7CgbLq4fLbpmq+EcKSNJDaOeIrec3B2rCv?=
 =?us-ascii?Q?irACm9FIeJi3sOuorBI/jV3bTMIa2WrKvdELKcKitCclkEdftYKXf0fyy4NE?=
 =?us-ascii?Q?Ul9vx2HCgLf+Q77tjw3gZ08LyKvQPKK1jCA/FmkUbu7qTWa6v8BA/P+FQUGg?=
 =?us-ascii?Q?wT/JUHHcocUnP/RgGv6jeL9e99knja1KzW24KK/cdACfgKF21yD7GDn44Lu7?=
 =?us-ascii?Q?O8PR9v3zzQ6pY6ZdyOkkBqceNDfytSuomqSXPd93UlfScdvgLQ5ARsT5i7W/?=
 =?us-ascii?Q?/shHbPmpnxBHS17cx/UqGfKnMfKnrTg/9PVNqTPSyy4LiTmzqFpl4A2vf/yb?=
 =?us-ascii?Q?oZvAGGhOKKE6+KEVkQhkkkmLKfNCssGeNv34sZjf9ORjb4CARIocU48RuQH+?=
 =?us-ascii?Q?q2/hF160mIsrlp5Bsc3FyTYlqX3FpB2x/vLsI2cRBxWvWyhPLjex0C3YCH5J?=
 =?us-ascii?Q?fJy7f8tr1ckBBmI1+8S7OfA7i0P9+CUIlbANSGbn5iQu1B2HXGQ61Cg+1BvP?=
 =?us-ascii?Q?21NfTZhLBeO8s7X/FCV7RE7RatTw02xgUgtmRUV2RUHrScmawt80OB8fA+vV?=
 =?us-ascii?Q?ofr330rqrx/U+vIgNAifhhlzlXp17m/fr9oWFA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PgsHuRUxWWYGgDLnps5l9DUsr3gjZEVnSi6T1h0TYvMFabnlopqCO8mboGZg?=
 =?us-ascii?Q?sQ4VlTYFUx07t5XB2VhFLhe+7iObpNcI0NgROA+Kf8JN24W+sTOxCE3b0/6X?=
 =?us-ascii?Q?BArxzA0QNlyHYGoBeg1w5u3G43uLrKt4I7WMu1A8rn3/a4CmL4Ka8c2fJbqt?=
 =?us-ascii?Q?vPol7LfY5+KJpUgLS/l4V8HcQv2K9P4LnqCV4TrjyfP0CJCOS+B9rB15yA4b?=
 =?us-ascii?Q?bNL58hphvoImhIBfHpdkbSEpW+Cx8CtKXIWJ0Zbf4VxbJlIFSH9QVvlYxvsY?=
 =?us-ascii?Q?jvDHWX2Cd8wnoTIbdOpfQ4UFSiGq1lTsF16IoNcN0nO1NFEvxAfaVplUlufU?=
 =?us-ascii?Q?DBpWmK3r6x7W/zSsGWpdWZ3SyeTUzb+RpKtQUbLEyeD4ohNx1QGQaEbSUlXV?=
 =?us-ascii?Q?CBnaitGA+KyHA9BRY1S5Uv0SD7NGexe+28N61h/5hBIEd8S0RqWMrU+xHZVE?=
 =?us-ascii?Q?xoKn1ZAErLYbz3m69aRR4ImOqdso2JZ0ayb+dNIwv3B3f9Cms+nIFV46jcbJ?=
 =?us-ascii?Q?VTP5iwIEWtr3jPHsTQsqzQUqPz2LRH9s/VXOQy5MhkF+sRATWM/1kIwE/0eW?=
 =?us-ascii?Q?zl52MPY8lVaLo6b2QWTmfdBQ/3NDHAo3I6N+apIp9y3AZM6mgKvlP3RE6gc/?=
 =?us-ascii?Q?19m9KtRxcELeekhFa2pdKCqSlwvXhNkQaj6zR7nLvaVUI2OKtBQ63j+aJC1z?=
 =?us-ascii?Q?sAfzYn4MzZvu6O7R/QKVDJA7ENz2sYhMO+2E/BdkgGOwuSmSI+58hAPlNHCX?=
 =?us-ascii?Q?F3hkKEO3eAld6hiUkzo2AfOJq01Ccmziy8aEB4sK8wIVtDRi1khzBGt0FFHp?=
 =?us-ascii?Q?CEfnvyIzLIDSgWg2wtCmfZ7pXm4GezLcnZf7uhAcjeXTuwGd9eGYG4H/GTMX?=
 =?us-ascii?Q?DJE68Y/pppBwID0hEGB1aPT/da3WO4iJ/BqoB2Ze+M/Ituz750G3x6EGxrKP?=
 =?us-ascii?Q?Zg/8q33yNwQcxglNJtx5JrNqE2Tn3Tm8E4i9c07VRmq6RkWyMV0nNvaGvaTI?=
 =?us-ascii?Q?1O0UGPRYT+/38jribhb3675oltKm8rTR7BV6d7/QoblPvcBhybP1XVpTK4cU?=
 =?us-ascii?Q?+ctyaMVLo/i6NxAEibKhfdyWQdIMPfeqmmN+rFnbef7hZ2+nqkZw2tnn8j6B?=
 =?us-ascii?Q?gcwnij3NPCXmbriwIQwo3kTdNdcK31lkaA8Y3sgkico2zTXh84nkKa+upTwb?=
 =?us-ascii?Q?nYxdNw6cdbQLVoQ5dBGP4fYTIwWE+Ge56dXVII5wrXcCYQFmlP3cADJ3T8w?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: e51888b8-66eb-4c76-1c0e-08dda7937d42
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:23:26.2364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB4380

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
2.49.0

