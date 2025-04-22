Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51901E9B37
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312225; cv=fail; b=VCUDe1Aa7udFgrUIK0WozTjQ9A5JLvrk7hy8rQd4WbGx2CZ/3pes0kPjW0T5xIBEY6s8VNqhgzB31pXs2T0epnwfni5cbe6QW1xpxnkEqAarmlXyDcUCYgGDBgnBjNoCLr+pw3pjBgCkz+nNbk2sP5fc5FfP5a5WWF4hykHn9Pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312225; c=relaxed/simple;
	bh=pOFL47bFbBEtxT4/W0peDHnpKPui4fDXx7kudYlG4SE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=H/EmhRnEZgO1YMETHH/jNGrDLt2hBmEqNEzQ/ZGNgd/TvASlDy6urkQ5CAmcQNlmwwNF+Cyw9mTiLrof0jSVnC23UHnayGLzlludD87qzKktfbZBo1Ug3/mZh5NKXyBWQsiZI4K33uKNdBIx6uuDii7V5/bJtoSYeerghzk5Nvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=U8cyt3XN; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="U8cyt3XN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fZcKCg33PiXH4xI1Ap52mPUadxA8Sdx1Ebq7LXhLrbHf+pyFm6lzY3pzLaVpt2U4+nTTvS/NjUgeSq2Rwghgv4Ik+coihR6W5EjTCsNexDZpmywtQDHtQ6v+bpH3auD63SQOFfgVCqGBjjvVBPw8pUxi/wlFxNgtK933Dr5rAoyWaryyr0xEvVHZRlO9L152RP4i+GLtCxDxFKCa0vDI3AZdVXGnquO/bM/hDt7Zw2iQM+gN/W63BRB15Sl4pDXGgHInG+HREw8ldHRtCutlcNBavcirXosMwNRL+8LEbybJQ42yR/vYnXtaYDSfZ6tuZ8u+ZXg0IQgaYqDlx6ezVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=it49EdBsAseWnFORbLYpQXxKkMWJ+r0vTgPsuAVB6y0=;
 b=Dy/iadBX12l9tFOt2wY1CXgL2rRifzHT0BPDOiCWZKAAlYlTmgaYMDXHpeX6CfY33Eg+nCw3PkrJRkwuCpYo9f7LEL3X81jpmDgTE6pP+4wYSCifN0esLLXYyosl0oG96LEg0AqMc4B0L/6B/jjV9rXisKsOA5buQkDP3cu/daHL5rKU13v5CVT8vn6OqpaBLOaTdPYMvS5HF7DHEEa6QH5UF2nmCUu1S1/DGznTECNJJt4hwCxloOpz9Ne9SS6VxdQU9x+7C2pzPvXyfTp39dhOdKVhYmuv/iHsVovvB+gchyiUq7ckNUScIg4zop+f3xyv+MqgMdsFrhBTK6hOvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it49EdBsAseWnFORbLYpQXxKkMWJ+r0vTgPsuAVB6y0=;
 b=U8cyt3XNRa6zyYot3HZZ91MJgCtVh/bCJvpRublGHYfsEbgj/TmK7yUMbJjlEcla67sk69lvYhyOhvfi3JLbBcR3ocDcr4oCdlduOkV7UCW1ijtJaEcSLmMu9clXwycURIPMak6HvkbhUhmiMzXGbpi42H/IuGpBVrQ6dA1uQT9pz+QwK1tyI5W4K/TWGtkfi38a0eUkZmtRGyVt8TELzVvWVeGLdAkyxJl5ngKXPOC6fiimwgxt7GYeInx1Im6P7DV+jlsYMoGGjvEtJx3YfUDFPmpKVmsj0lHYdTsvL6C9XAXQqhPf1ijjkpCi9p3/VILqRJNZFA2VHIooEn2kiQ==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by MA0PR01MB8754.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a01:c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.36; Tue, 22 Apr
 2025 08:56:59 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 08:56:59 +0000
From: Aditya Garg <gargaditya08@live.com>
To: Julian Swagemakers <julian@swagemakers.org>,
	git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Cc: M Hickford <mirth.hickford@gmail.com>,
	sandals@crustytoothpaste.net,
	Shengyu Qu <wiagn233@outlook.com>
Subject: [PATCH v2 0/2] send-email: add oauth2 support and fix outlook breaking threads
Date: Tue, 22 Apr 2025 08:54:23 +0000
Message-ID:
 <PN3PR01MB959739CFCF4D1EFC14259F8BB8BB2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email @GIT_VERSION@
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PNYPR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2b7::10) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID: <20250422085616.9679-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|MA0PR01MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e8228d-6f51-4b18-1d5b-08dd817ba403
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|461199028|8060799006|19110799003|5072599009|15080799006|7092599003|10035399004|440099028|3412199025|4302099013|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/FhYyEE9Z6cqdWY2B+MM3yJuSoRk4Aw5XvfkPD8oFUSy7NzRN4GQ3hLSmEPs?=
 =?us-ascii?Q?PePfBtVSgh3WBexbeVM11ifM4Sxy2rHnzRod2erGexp6HlPLEaNE8dmQi2Ns?=
 =?us-ascii?Q?b+yjF5uzR5oSt7AnLlkGZy+sh83CKQ0qsLMOjJ0Z0STOBHTCDH7EOB0Cm821?=
 =?us-ascii?Q?W2WOXqjz1cp5O+RWEQTu5N8wGlMNF+PqvenSkwORZFPGRENrkaKwOfxVYf/E?=
 =?us-ascii?Q?POV5Y3X/5ahptPNQvHA3sk+x2D5oTa8PnSIZFkmduk1dH6mJQMa+n9XR2A2b?=
 =?us-ascii?Q?KOaHUJiAE2e3G9n95hATAQDjsbOrTMgFSExBfTbu+xpTwPJsTabmzwJbvH4q?=
 =?us-ascii?Q?itnQOp5LYF1gFH5vKh+uBruLV8NM1f5COKYD0QSzT/VusKnT7Tyokq3p2PNd?=
 =?us-ascii?Q?MWw3zOa1A0FYVH6BeSZYsfrrcrleesEf2uZcLxOKOiRfll7c/3bmeNXkvubw?=
 =?us-ascii?Q?6cYzhGYUdsOE4UiUAQ1l6UShxODoIb3/ZbDSgVGND0yusFpgyCUUTGS2y4mu?=
 =?us-ascii?Q?L08PIFSQNeMkuNttfykYNyejEOHs5228tGFogsZf0W+YkcpVG51ue3I+jhua?=
 =?us-ascii?Q?eW1psEE9HEmPqeu14nruRTHHuxJtyd35kpFv6+IjXJJvDadaq/hRkr/cg+H6?=
 =?us-ascii?Q?TWn7AMpZ66L2gGpcaOI2uh/mkOX6TUQfQVowf+NxcSSmzWlrNhe/EiTw+Mbj?=
 =?us-ascii?Q?okf5VYBzL1hD17PrCh7uqwsH8QKLW1SK2WT5CJzTik1bkMUqSOmKV1P/kWTc?=
 =?us-ascii?Q?dnZr4GeyMRGmBL3CkkQO3/3MphkmqXDieHYjbCekUo8zxpO9kqVEStuhBFYz?=
 =?us-ascii?Q?kZIjXYoRdD4eVJQbj63lGLpjw072X2PaHzElBPqXaAQ0QLdvdIreaOuFavzK?=
 =?us-ascii?Q?+mvbAvhLT1TJOrvZttP96vYuZXDbCsIVzDGJhYy4Nr2qvgFN7mG3dqkcc2Og?=
 =?us-ascii?Q?zhbu4711tiV9b5Tm91vOJLBpsDdZQt0Ph/QxrSMCDuj/v/kGDEnj8Vw2Coh4?=
 =?us-ascii?Q?7ux40DvGn+6E4YZrcX1Jvg2+cNOJYriI6J33No2gJWet7iVVo4qVt3+VR6ji?=
 =?us-ascii?Q?EL4dKQ1KsuhaSrMrwCVH4mxoU2l0U33Gt03UiNhIG3O8ibUUJX6dcD2wodwV?=
 =?us-ascii?Q?GHl2p/p7INOaxr8b3N6fj7U+VRDe/UAmojWl+PXtdO3lXIIt/y/M3k5DaSlG?=
 =?us-ascii?Q?FhshIO1VZJZXvQoZx0UksU+r/mP3/ATWbP3KNMkUZxOTN/eXJPUwe4L5gqPa?=
 =?us-ascii?Q?Lz4xFRGXsKAiJQdfWxwyvkQllr04bI71ueOnHhq5GUCDI8RUtEyz+krfFAuD?=
 =?us-ascii?Q?o9Q=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9xhaz7zWpzuD1f3r+Wedp/YwROwvspL/JV4w4N5dnP032Q4+eyvPpqkrgmo?=
 =?us-ascii?Q?ooKOqcGlTAWg1oEzovy1JLRO464JNvMm+G1vt3uJhCnV6YIRyT7E8RKYWxFz?=
 =?us-ascii?Q?u5CZfJMAdvRvhDDV3oNcFrRY9Tp6UGylxTCTfSUgRV+JLT6v4HA0V4eD4g7r?=
 =?us-ascii?Q?kJ7YnibGXjYeO+2xUzTjBZcRGU0LE9Uaeji9Nq/yp3B462OAITBOqBKKwCiO?=
 =?us-ascii?Q?vIgLGMFjhlmMkpkJmrO6bgjlxfZFtIIKIXCejkpLmXFshKEfPEAWSsb1/TFS?=
 =?us-ascii?Q?QirtdCjY9S+2lwbNkczTHsmIIu/VBJSCQhUWb07Cvzrhk9G0phtGAUYGLzfD?=
 =?us-ascii?Q?NkiiIDwLJMtu9ztG6CBYEZ0StrsAmcerlnSkh3n1B3rYmMmRl0OlZPDzmuQj?=
 =?us-ascii?Q?pVx4BDXNm85vjR7DmK561B0ytaeavmxXCH0ETMkO2VyA65S+OvccJTIkRoks?=
 =?us-ascii?Q?byRYiRg8v0kv978U8wkYiKiUm2kMZHpLmS5pbsfcc/AVfa5XHmrgGonffa6t?=
 =?us-ascii?Q?KQLXe7xGgJ+/SI5/j3aKBJBF/d0OW4Yf3pw560x266dVCA7XZ3pITCBuWxp2?=
 =?us-ascii?Q?L769FlooE+VNGwjFX2UeDmVvKD/WU8kz7p718ZdRHYcwRAOmRhuklB9dyZQi?=
 =?us-ascii?Q?DTB00OwLVDHGVpJBuUc9RdyuKyx1tZUhKADGTKcDn2sxCrwhPUPf7fpof2N/?=
 =?us-ascii?Q?/Nd2D0TndDrD93zn3me/lzQ9XzlaeO53Xf1RKCZBct/cuz5g3FAM07MzsR7h?=
 =?us-ascii?Q?HGaIKJ6QB/FG7VANZDW5ZlvXzbTXVO9eWlGeEUyflykL/f1ikSIF9pxDxqwi?=
 =?us-ascii?Q?GP6jocLvK3qXZ0j/7Jugco2KCe0a4KmwrrDTd54GCJM7Z5ilYrkdNYd+UATI?=
 =?us-ascii?Q?FNU9A0lz5VC7KBQTVvL0UzWm4sccDPEmFSw2Rw3mYb47hIR5E96+xulGsvwM?=
 =?us-ascii?Q?LfLkwX5dG8I0HltdpdxClSeLUnrc4hHJwm3vBlxrVF0PZXzOhpfG+NG5AKwQ?=
 =?us-ascii?Q?RXxROvwOx9Pm6oBVsedWwf1nB/tRT+qAjlMSng7PiKkBWk6Spw7j/nttPte8?=
 =?us-ascii?Q?yv9AjDbvIaT8AMYEx6CRyo1SdqImatLxpvrjRxjqIgmSiwktkgVABVFpMC32?=
 =?us-ascii?Q?baP7xDS0S5GaTqBHfmoe8XK9Oo//AkCFL8li6YdPPJ9AflwMNVQuu9seCxIU?=
 =?us-ascii?Q?Knoj5MXjD4McHgCMJ5XW+ke1T4xnGMpaTM65aA3fLjTeQagHKGAgEu3r+/o?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-ae5c4.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e8228d-6f51-4b18-1d5b-08dd817ba403
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 08:56:59.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA0PR01MB8754

Hi all!

This patch series includes two changes:

1. It adds support for Oauth2 authentication, which is now compulsory by Microsoft.
   This patch has been rebased to the latest version from the original version
   at https://lore.kernel.org/git/20250125190131.48717-1-julian@swagemakers.org/

2. The second patch makes the script reply to the message id set by the outlook,
   since outlook has its own proprietary way to handle message ids,
   and does not allow user to set their own. As a result, threads were breaking.

Detailed description of each patch has been done in the respective patches

BTW, I am sending this series using the patched send-email by these patches from
Outlook!

v2: Fix errors flagged by the CI

Aditya Garg (1):
  send-email: retrieve Message-ID from outlook SMTP server

Julian Swagemakers (1):
  send-email: implement SMTP bearer authentication

 Documentation/git-send-email.adoc |  5 ++-
 git-send-email.perl               | 75 ++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

-- 
2.49.0

