Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010001.outbound.protection.outlook.com [52.103.68.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84733280A3D
	for <git@vger.kernel.org>; Wed,  7 May 2025 12:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746621452; cv=fail; b=mYchn0AU6C5/mmm1hcgnqnj0ZrIBSvTlfN506xt89Czo/My2pohxf91E7+ozawyc44LepdMwJjwMMaSJMVUeFiLO8Oi6ftDghuHrkPeu51KWHlb2KtT10LswqOhgZfwS1osaQt0Ta7gdIrYJ3Zv3RSv2BilK1lHRiZ86iC/9xGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746621452; c=relaxed/simple;
	bh=xLPWcPUqkE4/EgBTepSoaukeVUglqxtaBz3eqPZsMtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lfAfEpRZMbHIiC+ZdiUxedKibhCVJJwPvh4qr/F7hXCDwIFgVef6+l6FMIs1LfWe+GsRSsf+lJGeYroFzBXKsp9jpwCet0856jnOKII+zgBVoxMRr7rRHtSltd+qlWitZqdJlKyf42NnnmRTJi03T/may3W5H0qNPePXFV1wpuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=fLUEF6dy; arc=fail smtp.client-ip=52.103.68.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="fLUEF6dy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mypdzxk4SzqQeeZ0W/Oz8Zd8ZeebfoFyoNCJDLSvg/brqJbfhymWnd/1BKeeYXL/qO9YbNqQFzNusglkELb+wszSC6816skQS9DwOwZG8uRFc1Gw6z7RbQ6qsyJTMJHu0Mirwr7q1I2913pj6xHWmEFsNtpepnaJ2QfayuVWjn58op8msFE1QinRJc+NsXDuhPObufgxRfCU1Vz/YdntMxUuifWyDd5imobvvZ5CmgT2FLrLB49luJ871HrH71C83Pw3JvLR3lk0MbL7w2eNPic4IngkEOxePG76+XxKEJzbeik57pcfVBCMdDJU+ckh1BiAqA0KzYxvc/SqKFwpGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=TMqfn06FTWR7RYX9LB+EWq0FB1f/vpWKMMNvexOrP91s8QDGcjJvDPWDANctZdm7fnxLvB/gP54BCA5nB7wDrgVdbDsWeSQL9JMjYAHn5PRk4VhoLMAvSvf8tCwoyVwA2m+zso/tmHnovdYYz+krsnn0eB+69ZFpgFx0zPaXHseA8drFLqHBhxUpKZLvA/fl8MDIRNpp43x95bWGD9XXpcgKUtifKDdzaUikbWsJ3odTHAe1ijWo6wjSPg34lY1WU8hHFgtqmc5xWJUnUR5QLHOEAD0Bo8NDnGbYf9qLj0oVyNK0JSLyzIWkCqXwjyvnxPK3d6umGYtrXc/ocDCtwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6ypactJjV6OOCUj37Td6uLvOGKx9uv5fvE/Jn9L3oc=;
 b=fLUEF6dyd/cdimunjwwURibeM87w7SzmthC9yg6fDqUPzKM0ObHuF9Ig40SUuTMXv/z0MJAam/lAsk1RX6Ae7qiJeuMsM1lWO8EYv6Vo6joHE2PsK6KWUUivOJr2OxE53TOxA1NgffKKTDeVEbtbVv9L+iuDaN18/marOyKePqv7TAmeI30SlKEqHlXyHBubag2wxvP8PpH49hLjY9kkXTdTOroFqQYDQPJ6xkzZDj9Xi3ELKH/xsTPTxJAzBEIQ4oqYtaCmrYMkLqSE08vACG9XWPTRGSDjdDgUDbJelIWa34blw9BQ3VfBsuQq5GtOg6QdzVlgj0wU9mUaLpuYpg==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9910.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:128::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 12:37:21 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8699.030; Wed, 7 May 2025
 12:37:21 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Julian Swagemakers <julian@swagemakers.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Zi Yao <ziyao@disroot.org>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v4 3/3] docs: add credential helper for outlook and gmail in OAuth list of helpers
Date: Wed,  7 May 2025 12:33:07 +0000
Message-ID:
 <PN3PR01MB95975EE4AA37873235165E66B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
In-Reply-To: <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597208F139D23AF3436B16AB888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN2PEPF000001AE.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::a) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <20250507123704.18348-4-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 1edfc3df-2077-4462-ae88-08dd8d63e843
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799009|8060799009|19110799006|461199028|7092599006|5072599009|1602099012|440099028|3412199025|4302099013|34005399003|10035399007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9Pi/7mrzw7HYj1x3bULENhPVAUrjyqFG+F/IpFjt4/gVTBhk54lOpmymjzc?=
 =?us-ascii?Q?g1LOC8/HMlMXfVWE/yYPLP4xuWtA+57n1jPPIUM6ho6c9NREM74CZpvMBUFp?=
 =?us-ascii?Q?5VjtSenbz/rJTV+T0iW8eYqRUSXAfC2mAfLbqrpZepKSKDOCzxbyGRu1qDIS?=
 =?us-ascii?Q?DY+v+SoH8ZH5zKgDr4Ziqw3nXqPnBEksG70JGM5rBoCpuvJvoNXObAXFoO8I?=
 =?us-ascii?Q?NglMWJ51mR5BadAg8gaYL41e2/BD6hlv2TfB3WULGshU8RMW9Y/XV8Eu/kPq?=
 =?us-ascii?Q?vCWs9d+CP+6grUCjJdhyQjWEUpYB/HtBjyKDqRM38Tn6DfXQ0H7Ns1c3Qt11?=
 =?us-ascii?Q?MzGwnsbvn4QYkF8BU9Wi6UcxAUh6PuluaiRlz+MREPYKChugxmjtPE675A3B?=
 =?us-ascii?Q?jKvTr+xLvKHaMHsG5HwcgStPEqJV6OLkU7MFNIGw1c7+HQ+TB6hB4RqBt9nh?=
 =?us-ascii?Q?JsOTa0KlrYqz/UN/R0k3DqCi7WSadQxXaXI/10/Gc4w6y0qVU0eK/YG7+yRa?=
 =?us-ascii?Q?INIHnYzPzLmodTE2M9OfE+aIUe6oLySSEFew6v7VH3Jl0/829rU073CD4M0+?=
 =?us-ascii?Q?ZmCTOlTfzcJgoFXFagTt4+7qCrjYEvQ6Z3R3JJEISNtQEYkh1uIbucBnbbjx?=
 =?us-ascii?Q?gwzOM7hbBRYytyIBckTFvxz3fuPNTTQIKRdadBUK+QS1jcCn3fE0Fg/g6w0V?=
 =?us-ascii?Q?1QGe9TjOINeISq2MGhIIavehSh+KS/RpGU+6DHBeWklvqgT7x+gYVBGoAh0C?=
 =?us-ascii?Q?VCDPe5suOipWIiiOQg3XAA5DYJlQCbsO9PxHCAckDD8ZmyXz8XX5+knysDky?=
 =?us-ascii?Q?Rudiu3w87sI516qsjUq1zcS1rriMYuPNw/iDN15zZ0FJssI5sx1JidnzcYuG?=
 =?us-ascii?Q?dbJFd+QiHLMR2VjcaDDamoThcZNEF8+UFivvViyoCJl78OZtI1Orx9P5s1wV?=
 =?us-ascii?Q?NSwWkiVKcjBXhzRU+gBjwrnSeoNuhDg134MjyKIPbvlrjCxVSvsvXF655arb?=
 =?us-ascii?Q?9clAO+wYiBWMezEHGKs/2h7My0zI9EzKnY6uDWT4Oy0tnchYinPhbc75YZ5z?=
 =?us-ascii?Q?LvCadI0+DlhIMw+snnYielAqUYRExp6CqUcG+bppiFpL2adEfSjy9TjG/3+B?=
 =?us-ascii?Q?3KLeOxglvKKx8QIINvTTdEkjKmeRQJfmBf+kxcsYHYM29CLrUq97aQrrQ+um?=
 =?us-ascii?Q?PZosG+588idUaU9FmFGwXnJGK0KEIkfBmBM8g9v1O9+TdNrVpwjTgwRzrnVR?=
 =?us-ascii?Q?weWZ8swgn0PtS4O0BKEi?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZLnFTPqgoHkuGRsmsmCFi+v8hfR118HhHaG3WklSLHgVO9y+1qcq9dc255vl?=
 =?us-ascii?Q?VsdrKV5ULQQOGpElIdj7B+5bPU9t1y66BFqTnJknlKOAaOL4BWDbDrvlZ8Kw?=
 =?us-ascii?Q?kPvQxvQHJBS1zCNlYjaR6pNt2rCfywQVCREvSa9fcCTR4Xz6KL91/J4pz3pb?=
 =?us-ascii?Q?zsGda2g1SKFmxPM3j6jPx1iqlXotabYCgFzjBnnw41pTvuBslfvk5puNnmyX?=
 =?us-ascii?Q?KEH9Zd/CkeRl/hHye+bEL4oCiP05yeMnGXsKraK0Uu1EYgpMIe1A0X+iDSyk?=
 =?us-ascii?Q?2uYvYztL21fyCK/CbBcPytPhJeBtxO3z5LWLBr0L/3ZkzmBV09AYH2ktw/i6?=
 =?us-ascii?Q?zw7RnttcM+jWJHxjhl7PwcVYZOVRP3189v7StdWekkE9rzae3qq1IFpcy/y8?=
 =?us-ascii?Q?QtFOZX2SB2ykUDnUm+EjH2twUhWjhi5hh10hXuY1vcYyflOdFb90Tf537IXl?=
 =?us-ascii?Q?IKCEJYlNmoyKqx8geX4HiF4wY5FWujPtK57sY2qHTUJQmcFu9X1nnJXWhWuL?=
 =?us-ascii?Q?mxsi1TOIWU+IGBFjkZgEv4gWcTwyIwzn0q9U/cNSNGSRlZUaYUy7rgu3E3Cw?=
 =?us-ascii?Q?Gqgdc1Oey6SxXB6KgznrlZE59SPExQJQYE5l2JwDAo0UGBoc/6brCl8QZgZ6?=
 =?us-ascii?Q?LylCXvpUyyhMCnLsZQCWXS+D1hztJ8bG4pASH2UCPsDJxIn7KzYlJ05l9MiW?=
 =?us-ascii?Q?QUN5OGVUf8MJwrPG86x3QEFuwM3OkyXX7nw5Fi5aA8lARQYH3nCBCAHxIa1+?=
 =?us-ascii?Q?JxtmLkv4H4QufBK3i+EBJE/I3scx6p/unqP3aUyA9jiYaG9skAFhemOw6OUo?=
 =?us-ascii?Q?C6hLD+n41WPfFwafBeMljAMqPk+fKTOtFc4rnsN335AYSCDOH3gLqfYZH25C?=
 =?us-ascii?Q?VV5jOnstT5IF9j7V+xxfHOAzs47rucwMazBr19rsD5HFKcepp/4mAnZhvuVE?=
 =?us-ascii?Q?c+k+bib3joiNdingewqrTw+ENKH2Pn/xKVPy2M+SPfUFoyypoVtnXg5YtC+M?=
 =?us-ascii?Q?TbsklWXuKDGFBNqlZ9l4KL1lKP2UzXDysvAcKBJ6f+Fiy4tK60T4RGJru523?=
 =?us-ascii?Q?rPjEdgvEQebY4RTOsWgn4+aR3BUB6OxN1nD5gtk9Su9jTjPiJMiHV7slFNDQ?=
 =?us-ascii?Q?vvE+Dd2whdDtTtOdetm+Ov++uddwTY6Q/Ly7ozMWWhIS+Fp9N5GZO8/xKtUv?=
 =?us-ascii?Q?JdKRoLmmsDcb2svvX/Su29vdN+i82Do82OMOyPd+f4oJTOU/KKkvcAya8YM?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1edfc3df-2077-4462-ae88-08dd8d63e843
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:37:19.9996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9910

This commit adds the `git-credential-outlook` and `git-credential-gmail`
helpers to the list of OAuth helpers.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/gitcredentials.adoc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/gitcredentials.adoc b/Documentation/gitcredentials.adoc
index 3337bb475d..b49923db02 100644
--- a/Documentation/gitcredentials.adoc
+++ b/Documentation/gitcredentials.adoc
@@ -133,6 +133,10 @@ Popular helpers with OAuth support include:
 
     - https://github.com/hickford/git-credential-oauth[git-credential-oauth] (cross platform, included in many Linux distributions)
 
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-gmail] (cross platform, dedicated helper to authenticate Gmail accounts for linkgit:git-send-email[1])
+
+    - https://github.com/AdityaGarg8/git-credential-email[git-credential-outlook] (cross platform, dedicated helper to authenticate Microsoft Outlook accounts for linkgit:git-send-email[1])
+
 CREDENTIAL CONTEXTS
 -------------------
 
-- 
2.49.0

