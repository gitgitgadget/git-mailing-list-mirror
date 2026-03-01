Received: from MA0PR01CU012.outbound.protection.outlook.com (mail-southindiaazolkn19011025.outbound.protection.outlook.com [52.103.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70DD2DB787
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 07:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772348749; cv=fail; b=lFsujmP2OZgXuCHgkso0dz6hBj1Z95j9CWczZ6LsbQ0EaC8HFDVtO+8rcDdilA/F8XzKwfImzdsZm1joM1Iwg41y5rJrsXDy5xflVsydVOsDkn7vi5vG1PRfcPcyszGWGcw8EvZ4Px3y8nFhq+RjYDqwjPPO24neJ5pYhBbvAtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772348749; c=relaxed/simple;
	bh=wdjH+C48WjtSLDTkWQKNnC/yfVewZH7c3Qe4mE9suwU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bDM0NsXFauWpYMWVDJCVBaWqopoZQpGJNQJ9ce1VaixN6HwyF6WwPKyEnGWa2/745iKwteG/NUJK8ydNl8yOakoTGhj778URBvlkjZ41MrxI/ky0y3DuDqbGQRgbwxrL/EMNQl5K+6rOhdMeQYxhrSvIllr3UoH3CNA9ANIO5XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=XkmQbmw9; arc=fail smtp.client-ip=52.103.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="XkmQbmw9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMUy5q+hzeRvHRaj3/UwmscQPB8JAlao6cNA45tPAru7ObFGPeqAJImfUGgorUy2tAuyXsrYE2TFwaE3kLXEzs3H55AiBi9ouaA2zd9RA8LS79WL+8/Kc4WxN+Wo2aF6dtm7azbmLhKhj3BjsIlM4lIVImL6k4DOTMgxVDvIkzrajRBO1UPSFaSchHUeJ63dZ2/7DC/jvsSHm9HAOE2Ak6z/sMxzc5h+/2TBsbxbetCsnzr8XI4X/F2mru4szI5j5SXG+euDupluuOQugjl4cmMKkagRdhT1fYoVdTupwCMQF9O+Rb5bO1Nw99ierDbiAsvqwxOlVtSgiSqy6s5/jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZy9dsP5QjL1/v02vNFi7+c9Wj42mGhPNvFoL8GunZ0=;
 b=CHAoBM566gKqgZageh7UScligEovtMUc/77QmPA7uhYjBXmpgkm8or+alpZ3qrwxBQ95IrZLMAuaAMilTu2fKvmEhSogT+15DGq/uOYQASufPDhpd3ZFFbO8865cdk7DuPIYdO/Ri+1E9fKeFAaoVhZ+71pN3Z8I9xewPQwWyd5zzfu+wMW8iFISWkbyfHUWoG6Hp42mdioA6xBgw5fF2l1mqiDhKdvDOmTXByW/zHXsSoaB+fws69lond1DSnjQAuV2VnJ45jAyXxopcv/dhrJ2LPkP4tFbgNh8FvWiuxefq3Xlm7tyNkIWH2j4KuVxqq96PutYZldeeG0c9bi6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZy9dsP5QjL1/v02vNFi7+c9Wj42mGhPNvFoL8GunZ0=;
 b=XkmQbmw96OcXHAf/aOzS8vqWfOpae1gwFTmEAVwh+UvUPc/618joyewh1toKEZcfAGBD+2tbBeiR01HTW9Iz+SvDNc64eTv10NRwZmq/+1kCdyaKSkddTzGFIQAXHTyT6Q3rVWLkT+762X0sCpONqoO801wbo0YJ5FvjnNqi+4u1a08u1afCQUPKVpKWHaJ+qEie38CwJmM2ks2fWcJ2pFWhZiZ7LoGfegbJtrQtQpkVrQs3FX8mBxfR/+kxiwqQJgg7wWAFxPl3vDEYi/RNHuD9Kj+cVUwp0/xBO4LWYW+PteEH/65+7ly+lW+vcTRmslaREqTTK5ILDVARO6gDqw==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PN3PR01MB6837.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:91::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sun, 1 Mar
 2026 07:05:44 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9654.015; Sun, 1 Mar 2026
 07:05:43 +0000
From: Your Name <gargaditya08@live.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] docs: add hydroxide as an option for ProtonMail users
Date: Sun,  1 Mar 2026 07:05:30 +0000
Message-ID:
 <MAUPR01MB115461E9C238F9952EEB1C38BB871A@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::12) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <20260301070530.21607-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|PN3PR01MB6837:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cee0db7-8ca3-4ee6-0005-08de7760f302
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|8060799015|461199028|8022599003|5062599005|5072599009|23021999003|19110799012|10035399007|440099028|3412199025|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ux1TKDwdKay2RvBOaFvlylRDvSzC6dRwthljTROXwa4EfcOJNuU10NKk0HfY?=
 =?us-ascii?Q?bGBXTeh3hYISqvCU5EU5be/+m06naHRmcNnOwYeSoxVYv3QFvEAM3FVXlIlw?=
 =?us-ascii?Q?QtaPxfC3aEOu/xDaxNI7WAVqeJlaVm3vVXrgD4DdXOt1hRqskM4AKqGhqU21?=
 =?us-ascii?Q?V0YsB2lEVNDffD/ugxKUXjlRnTxtuWXfBZjUgUnvDvT83Ai384ceFsDVjm8C?=
 =?us-ascii?Q?4Olb+k160vjfirZLoowu86f9Mdx2Ec0G+sI1bWXuFeB2HRrrOWetnxE5wW7h?=
 =?us-ascii?Q?YJysSxa2e41WUfiEabNUvBJIABddRS+6jHMD0iE4Pt3PuoKQYsgPxLadTZTA?=
 =?us-ascii?Q?H48ksofW+0VUQRjPL/oJvPjgoUf+eCBMw0GCbOH03QHL8qDAZhD7MYhMr1JO?=
 =?us-ascii?Q?xXmFjKJarckjKsK59DUZEU5vKMrqLjHiUsu/R0uPc6Uax5gdNHIkH9xqaRyI?=
 =?us-ascii?Q?ZH2um2Pt72vWkfQgDo6rxFri2WzU7l2csPdHjtibBoZN+5fWAHQuc0yiIyLg?=
 =?us-ascii?Q?TEPVR4IaxY8TsX+sX7omQpI+UB8czl1vlBk3u+ZothQw8yBkRKGGAU5nrjsd?=
 =?us-ascii?Q?UCWeXMGBlWZjWqTFj5HvTCoRacQVAzt1+rYS6FbkIr8a+U3a4LHRdzkX+UTE?=
 =?us-ascii?Q?6vNy8WnFJWExB9Hc7/8W8ku6aAfvUVV1CXs72gl6U/SQRHiFbPEsF2NVnToX?=
 =?us-ascii?Q?GMRUKE6GZR0dI1E+MJdPuvbroacHjtaHzR6EjW8r77W5bSeC/1KbKRqkY+8f?=
 =?us-ascii?Q?jfpJiYN2rUtSt40hIoA+V5np/qDxTj3VNs5/WdXH2jEFRl7fLW+WjGN6Ffni?=
 =?us-ascii?Q?cErs6Fnxcc8NGAv+FSAWhorbAPT8/pEyBdctikBz/BqqMoyJwtvNfu5BKEY4?=
 =?us-ascii?Q?CcqaRO3CfGIlnKrryN4MW9A0jpYItHYcE0r8XdJ0w1PGR6co/0Aht6A1IOms?=
 =?us-ascii?Q?YuNMW8usITgr9VLcXRp2nA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n0rht+8orMmnGTpNH1qCSuykGvsmU9F4QFZ7Ku2dPJT0ZFaIXQ4V2YkpBQ9F?=
 =?us-ascii?Q?NxhsuKfqnq36t6M+snmXYAXxGRxR/Zq2L3ZS5cuEc1al6VMSB4P8G3rvKTk4?=
 =?us-ascii?Q?yKlTr4JtrMtVbb3uTzz2Pk35SuX3odVqpdDvO4G/dwpAcnkA5NnCQMINeEZw?=
 =?us-ascii?Q?P0d5dyURVE0ohWA4fXR7SUi/zrRCT7q7USHegpHLGTk/4ck6TLQ7gg6AkRun?=
 =?us-ascii?Q?9djb7plyfDaG45zIOFfuwFrggO/t4c8KBQSv5SZQIXwaJ6whce9sQj+mbQ52?=
 =?us-ascii?Q?wI5Xu0dlGkQlSwMSMkkD6P839RTN6XnNcLtnr1K6TEeQWUTFk86vkaKdYC5v?=
 =?us-ascii?Q?gZt69K4/CpzGpkSMyHc14V6Rq9uAC30BRQonq01l5l/g4YLpbQLhLfJjYcRX?=
 =?us-ascii?Q?T5/VFDto1lcsmVO62CVcdadcI2DV5iYI72/7J/5rsyAI2a4JZmSQTtattvYm?=
 =?us-ascii?Q?S9AqnroGs/JlNRpB7wN+gz6OG5nm0fAb8JX7TBPxXbxQmnDwM4TlwaxUVbQT?=
 =?us-ascii?Q?gQtk+KpWtFESJXMQqh+J8zTzJFRhsuOqCTz65wn91zv7U5rmiTIY8EvD4xqC?=
 =?us-ascii?Q?ZHdTddUXToF3TQ9dca48BRn+1LvluAIa6yBQmGL9C4R2MswBy6g1uY1GU2Os?=
 =?us-ascii?Q?X49Ek42J+Np3wn3JAVBx5nlsQTrlMu+hcP6bpETe393l2XNrg6GrZNO3aD7s?=
 =?us-ascii?Q?tP/dfeXt9HKFIpByED8S1c/NyEUokCOk3E46Tcnpyl/YdQwtErsQE4gMLU5J?=
 =?us-ascii?Q?yxtlnSDCu+0tbVi19zhgO4tn/yuM3j6M3FkxLkpq/9rq/rJ9KoSp7oRyar0L?=
 =?us-ascii?Q?GARvICxydWpXqf6sGD6e+B1qM/ldtvHv1vCY2x3TwYAiFhCQxrlF3k5ZHqCw?=
 =?us-ascii?Q?DhqlR/uLatBvABLP19GH2lY49MWr1Bf7UTRC3ph63VSu1ACp1leuD+c7q2TK?=
 =?us-ascii?Q?dGOqtL2ljtvPxZ1XtCVtdOo3J6Q924NDGcgd7bOeSBHeM0eAjf1GvHp7YRxt?=
 =?us-ascii?Q?ooYVIePb3+4GyC9hn68BdyKvdtfu7VlZqutpDYCj1Ph9tWqe0oK/IRhDgpog?=
 =?us-ascii?Q?7fQ9xVhQpuNqNtuhPT6BXV0xIu30NY96WbbkPlVtA2WTSBjNhNQfBoisz9vR?=
 =?us-ascii?Q?M2tgr685PhWGU0hyU7gD0Mn6NMZ7Sjj63EGKKtnkO2jdnCPdYcZvZTk5qZmF?=
 =?us-ascii?Q?ZmrL5wohnZ1Ho1k71d0TfevLLKYUBZihDmjY9eBzcFZ7NqGNeKoyeL16sCpg?=
 =?us-ascii?Q?73HfKp5JERIYLQy2KE4eIJ6MAsi/3+7EaQoTfH8/PuyYo60mOJcUHadKicC8?=
 =?us-ascii?Q?sWlK9pm80A6WBwzQGStxyGFKUYjp1ydFHqS+ZvrUECSKnk9cnKzp/OLnZrwg?=
 =?us-ascii?Q?rFbMGuv2jCQKaCbvwk8Zn/dnbA5/?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cee0db7-8ca3-4ee6-0005-08de7760f302
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 07:05:43.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3PR01MB6837

From: Aditya Garg <gargaditya08@live.com>

Hydroxide is a very popular third party client for ProtonMail free
accounts. Recently the project was resurrected and now it works
properly. Add it as an option for using with send-email.

Signed-off-by: Aditya Garg <gargaditya08@live.com>
---
 Documentation/git-send-email.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index 741f748614..724c9d5e9b 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -646,6 +646,7 @@ customer of Proton Mail, you can use
 https://proton.me/mail/bridge[Proton Mail Bridge]
 officially provided by Proton Mail to create a local SMTP server for sending
 emails. For both free and paid users, community maintained projects like
+https://github.com/emersion/hydroxide[hydroxide] and
 https://github.com/AdityaGarg8/git-credential-email[git-protonmail] can be
 used.
 
-- 
2.52.0

