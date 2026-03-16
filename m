Received: from SY8PR01CU002.outbound.protection.outlook.com (mail-australiaeastazolkn19010075.outbound.protection.outlook.com [52.103.72.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1C73A0EA6
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675409; cv=fail; b=HUIcEpggJmW4402EApIHyBa0DRBxcE87bI942m1WapIxMYHITfCsLrZOdK0VBzhucfyUs9RmUfirjJ4wb6dBj0zLpCz7MorTQdDIbtjJw7yR84FNicJdZEkko1h23EhB6RpQ+cauzPLxGKjwcfVxHvz6aJJXQ79NMgpYGAYgf6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675409; c=relaxed/simple;
	bh=7xvrlInXrhjvlfJm+YkSIpdwgZZZ+z6fqVRtk4gC3x8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PpGVEVNbT2qHV/FXlsf3bbAGRfMl59ntU/JHAxUoRTKEXFTjOvo5kw7M9B74QUGxetN3pMmbpV1V1gNfc/5xXDz6BsDnsMl5RJk9qP7twpb7hAYkoJqidy3SgvLn6Y3FC5HYLN1SmP3kGNMe2jpm6/RfbFAPouMOeNuOhf1Jun8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C6ChwkA6; arc=fail smtp.client-ip=52.103.72.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C6ChwkA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkMMQhKNE51vtNe3t1MnqtY6hIEPF9iRBsWiVdsgy//6Z5b6mqu+tYWlPLvWeQb34Isv/9DBu70rliveQfbyCc5injIncoW7Mwb1xDDG8Hj1EEKJUvpOTT+BTfnPd0yVrBiuP84XB2iAvmPK9/v2G7SU4phu/WHrIQ3woAOvy4xGp7ib7V+rfd51TTy6XAeREpr8wcxp77cH1+YjiMob1tx3le7Z1XJlzYFgQ+NLSwxIkIELA0HCmXi3rQgLFP5smOK7/K/ZvG4xaPwMlsK+aWnIL/ZG1JF295d/Aqpe2u+sqrLPEKEM7ZMv2ZcUWw8myEOmECL7lCigWo/PnR7NtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeznDU9ySk3xofvYSMUExcl8D579sXNIuDsOFKSvsPI=;
 b=kvHp1LeSH1YHUIlef6TS38ne+j96V94jY21Z/1wkmaUTB/Fi1ysgmuIkIBKyfmggwpp5e2xjqXc9rinfB7UMMnJueQqbJybPCGzObfxMyZMj+zaCU26RughEamtatAQkpy6eABdG/tMX6DMD1u4yeH5ziXahTLKm7SyVf2VxNWJwf2+l8wJaNMRhGy4diSuWBmKAnigoHpeWlEyzQOd3q8X8TXMl7+oA5Z4c5+9z9qeC0z9OIts/+kWKLrvUaPmMON2i5CiHH6Q0xPxL+rmHQ14EeBNA32N4Lh0ZhAsoBP6NDxa2WtGTxtMFAYZoNNK5NBGTmTBdvmdC3tpvSV0ssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeznDU9ySk3xofvYSMUExcl8D579sXNIuDsOFKSvsPI=;
 b=C6ChwkA6myiu+bYobC8vfIY3cpEDwQF6FfX239seh3qMz5Y7g8qYX5gRvaOoMFTqszFbPL76g3300jH+Xujso0so15FlUbCv/1QDMIU2m56izwJHaywhyrxg/ZTMY3NI5UqDa40OD1c+tZmpqOclufHabaf3x2rWqX/viU2njhJWVMAt6O7jTmdUqDYHaDhW/fL5AXg9u+o8Ln8ynQv/fdrzLIUlD31PBt/uV3aZT0p8nXuSuBZzuV1B+xVRPaGbEyVzAVhMCx1ibA1PUKPzjvpKrybFG8suA0Hm+Ecsyog3CrjJ5EDPVf6EMTvGFFue5bOkuL5pXwnSo2C80RTnGQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0774.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:295::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 16 Mar
 2026 15:36:40 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9723.014; Mon, 16 Mar 2026
 15:36:40 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Aaron Plattner <aplattner@nvidia.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v4 05/10] autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINT
Date: Tue, 17 Mar 2026 00:36:18 +0900
Message-ID:
 <SY0P300MB0801BE42AB3C2C483E9976B3CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0279.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::6) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260316153623.569881-6-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0774:EE_
X-MS-Office365-Filtering-Correlation-Id: 74dd905b-14a5-4819-b474-08de8371d143
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|8060799015|41001999006|23021999003|15080799012|5072599009|461199028|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6KKCTsj1P+V9pzYINnyssBs+Nm3dv9ALnm4O3L44G5Y/THlgXc06vgcPBLDl?=
 =?us-ascii?Q?t3hppIzMQs2Q0KF3HqysyXK4H7wlj1p9DUq1W+gDJv7AE2BNW9VRZCfbv6Ro?=
 =?us-ascii?Q?msJhwkckuZMQDmF02IhS9sFtbWNo1HDvFdnTEQH2AAyLkjqkfwRKolxHLLBR?=
 =?us-ascii?Q?KJM+tBnwh3ZVNmiA3isaVSwH9wE6vXpW/Hf/HoSH/6Krmk9WbLZHRLVwiW9t?=
 =?us-ascii?Q?n7xgWlvXGNRP2DcEbwXCCKam69wIIbT9iQ9Kw9deOwWnx7yW7o70yBzPhCdf?=
 =?us-ascii?Q?abYCn8MOD2jwwu3liVjlcprXydUjBovRfSFp3YxaAGZCxfDkxSxMmQjUEry5?=
 =?us-ascii?Q?SJiJHIfgjoCCar2lXzxZjq6vWoWCFf0ADdZWciSpXkEykYMOIMAHGVZt4SGL?=
 =?us-ascii?Q?uJzvRbgmyBIah2jxSAQZbMzk/VhS/gg7JC03XhZCiD+tM2GttPU2CFog/8cK?=
 =?us-ascii?Q?koUAhb0lAQbHqQBnARrQYIYP4xA+9h9aado+GBEuiv1l71YTmm/VmnmfBDV2?=
 =?us-ascii?Q?Y8O84xUoY1P8UKETOo3S1mqJNMsbFT3nD627qQqVKjSVLqLJw9z4qeq62RIj?=
 =?us-ascii?Q?zMqX4nEwyRv9Q/gxNbvKaL/By3kmFsZaPN/CKYMfPUuFNcem/YFl9t80VhHJ?=
 =?us-ascii?Q?/qHjAJOhgZ3RBqmpyOnML0gkjpvY/pZEFF4B6ULEtZgTW6SYbyNjbxfAc3g7?=
 =?us-ascii?Q?KtxISiNZPJDHWkI705VGdK4PnPHm+DgbfXunmoXh0VSl9taCm8WdoUJBunbu?=
 =?us-ascii?Q?/w9fAzH6Gy4r5Klwcimrg+NHAKeFFOCa8Hn2cp1RCHF00yhuxg90/QTJzJSo?=
 =?us-ascii?Q?EdpxfWcgoDb8PKyRwMAxGmUxJSc+BF5ZSa40Kt1BYu5Rn1l2BnAYaSTPrOQV?=
 =?us-ascii?Q?M4Lx5H2FxCSYVMJbCH5ZaPodBcGixUhmfCMyekb4IUjHQxaRXBFYfPvbM7wl?=
 =?us-ascii?Q?0CVWbr6JQtoqqOqBWH50T6VusBpXI9wLiUUx3dnx4GKpvr2jeF/OugOZJmd9?=
 =?us-ascii?Q?RZlo?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LKqaHtHF1jdMVOUiSX3LzCWtKjGiwqALq3n/F5q6D4ZJyZxjNkQFvpobY1tc?=
 =?us-ascii?Q?sAj+vtTs8WzZL8a2Gi+CUyyN4noZ2/oeZc3T9i8/32n4LM/UJZ8eoUSJDLhQ?=
 =?us-ascii?Q?nKpb4q1ZCrg8z36Qt5CBLOzOESele6SWospFS9NnchV2VqnX3SaYsfwCJRMn?=
 =?us-ascii?Q?TGNRhF1kVX7k53lvqxDTOGXcybKYXnPWwApIa18IyhlozGoapyd8bH5+zX4H?=
 =?us-ascii?Q?gMGjIqBLZywInT58+ju3ZTYFQ/Q4hncyJ0dCkXzeXAA3WHLD5zt1VrmcUSLN?=
 =?us-ascii?Q?NMzgJuoh8kyZeF1cY80wBvSmvVES3qZNz1IDthJ6oqqVB+A+tERtXb+K/nK2?=
 =?us-ascii?Q?/XUojSfCNKdJZaM+1FWi2SKy8pwOQ6KBHUwGbUPh2SUv5349MRQtq3kM9zjK?=
 =?us-ascii?Q?Lhn8QEQ2yXYIFsG2vRFuBa3xMcXiVl4B5aNfLEWeU2YubVX4aJ6Vt+wa7vZT?=
 =?us-ascii?Q?kniijcUDGVU2kdOrjRdIzaK0xd0zuDPH8lyDqrPY+2fHy0eAvYNAJPGi1AzZ?=
 =?us-ascii?Q?FGFKUkZpP5ik8Ry3n8hjkWeX77WdZKYVHnh3pXa0582jMY6m2kRpNESFu2Lw?=
 =?us-ascii?Q?uxaiXdsNeM6qHuVk6ZbGj6x6LrTE0dhUGq9saGSmNSKHkr9FjnKocZF/uNeU?=
 =?us-ascii?Q?tTv5KMPOaXoyoHO7Ge3n1TAsDy6PsPHktJWIUM8sdLwAvbpcwoaWwGKQhT3u?=
 =?us-ascii?Q?AmOJlEfqM/Bjdox7h/gGt3e1sx4XUr1RCeQFl/PEn5UE8I9ZVBRDI/RwhmmN?=
 =?us-ascii?Q?aJvHxyzreixaBB1GfUdRbm2vbw9ZlVs1VbYhTiVXc9mzQTOFnUl8oS74QZdF?=
 =?us-ascii?Q?ZklbM1fXZWvh3oN7L97mvX8Mkh3/1CODcQfcSePUtej0rxlXqan6gip5wY5p?=
 =?us-ascii?Q?YMg+dsq1G9BMJUpmC3VXG3ZfqY8UNDDaSgecppHALbG1cvndO1/1/Paai/Pq?=
 =?us-ascii?Q?haR93axOjAlelSSGQpyxvxY/YotLeKNUBdink98i8OWlBLabFeJNudU4fLGp?=
 =?us-ascii?Q?I3G+WxMRBz5xaabbOFpw725XqwIB7ll1Bf/ibYUBD/QyheuXffHwLXBwyrSU?=
 =?us-ascii?Q?BhwWYyXlYVbd+hEYlqCCBWI0UozPayPd5PmKvkvUt3+ZLhasdAbin1MuFY6Q?=
 =?us-ascii?Q?/gS2kVPIq0vXPxMj172Gfj03EmXustsxmOUI/qA3w3uEiaI3h2mr5CpdM3yk?=
 =?us-ascii?Q?JszIPPjatdYM3sNtY6YhC6TSc/pHoSZ7RlkNUocudFjAeK/PhQBF1ij5DQIK?=
 =?us-ascii?Q?SmsBlV2mN+f9Q+CZvMWLFxOmlg5eB8rHs2xQ+gWY9ZIVYxeXkbivpCOsJWbW?=
 =?us-ascii?Q?73D2/a+/TauKOEiusQixnFeYoBUsWpmvHPpznw97PyjMi1Xxgj8P2ssCTvgP?=
 =?us-ascii?Q?TBXVMDohQsKVnf4cHAMwwzFZ6rXL?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74dd905b-14a5-4819-b474-08de8371d143
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:36:40.1545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0774

AUTOCORRECT_SHOW is ambiguous. Its purpose is to show commands similar
to the unknown one and take no other action. Rename it to fit the
semantics.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 6 +++---
 autocorrect.h | 2 +-
 help.c        | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 2484546fc731..de0fa282c934 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -12,7 +12,7 @@ static enum autocorrect_mode parse_autocorrect(const char *value)
 	case 1:
 		return AUTOCORRECT_IMMEDIATELY;
 	case 0:
-		return AUTOCORRECT_SHOW;
+		return AUTOCORRECT_HINT;
 	default: /* other random text */
 		break;
 	}
@@ -24,7 +24,7 @@ static enum autocorrect_mode parse_autocorrect(const char *value)
 	else if (!strcmp(value, "immediate"))
 		return AUTOCORRECT_IMMEDIATELY;
 	else if (!strcmp(value, "show"))
-		return AUTOCORRECT_SHOW;
+		return AUTOCORRECT_HINT;
 	else
 		return AUTOCORRECT_DELAY;
 }
@@ -49,7 +49,7 @@ void autocorrect_resolve_config(const char *var, const char *value,
 		conf->delay = git_config_int(var, value, ctx->kvi);
 
 		if (!conf->delay)
-			conf->mode = AUTOCORRECT_SHOW;
+			conf->mode = AUTOCORRECT_HINT;
 		else if (conf->delay < 0 || conf->delay == 1)
 			conf->mode = AUTOCORRECT_IMMEDIATELY;
 	}
diff --git a/autocorrect.h b/autocorrect.h
index 5506a36f11a7..328807242c15 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -4,7 +4,7 @@
 struct config_context;
 
 enum autocorrect_mode {
-	AUTOCORRECT_SHOW,
+	AUTOCORRECT_HINT,
 	AUTOCORRECT_NEVER,
 	AUTOCORRECT_PROMPT,
 	AUTOCORRECT_IMMEDIATELY,
diff --git a/help.c b/help.c
index a89ac5aced99..2d441ded3f14 100644
--- a/help.c
+++ b/help.c
@@ -674,7 +674,7 @@ char *help_unknown_cmd(const char *cmd)
 			; /* still counting */
 	}
 
-	if (cfg.autocorrect.mode != AUTOCORRECT_SHOW && n == 1 &&
+	if (cfg.autocorrect.mode != AUTOCORRECT_HINT && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
-- 
2.53.0

