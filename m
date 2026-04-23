Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012011.outbound.protection.outlook.com [52.103.72.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5F73B38A4
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908334; cv=fail; b=DS7EEAbF5IMNXkRd23FM08rjVFiSRLQkcSrybIaimyZCOKf6CXkyKudo/LATOOAIdwlaWX97AoiGAEEcG+5msHya5PancW1ToSJTxnTcV537OQ4EXqRx+Hi5Q1ERJkM/MXCsHL7pnIwmeNrXFaKpYvoqPkyud4Wo+WgYmS7XnRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908334; c=relaxed/simple;
	bh=HIXCqdgCbpjP4gGyZvqO1xFEIPQQnz0EvWKsbyCY2Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRuVONVkrnMEz7hSr0g5q0FmwxgapDAZS7VeFUWeczhQKy4GJkco3IajQjEjWJTOPYY/dRnLx4S721daOOwTwFzkN9rwi8/av2Tcnc+GXhm+rcrXcFnKSWvo239K0YjfOB1I0ek6fcOmjlUR79UqUHMF+4BOc5fotJc9rsajsd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ciOw7RUB; arc=fail smtp.client-ip=52.103.72.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ciOw7RUB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSwCGUvyIU6PfJP6eF9wvsYj3mZowLgVzGBYO6fPR2a0UmVb786qP8VttX5wrhestAWOQg57duIkAiQdIYDOLpV39lCeRNV1/+2eLcFzeJIsiEb8Ehy+d52mqIxVIwj3di4X7SRFzveTs095Tw620w18ZXP3QSrGn5fHLBj6EuJ0WYOZnCq6ahc/kbEnnL+aDoDSM0XLctGI9GblpF+6asGpNABHdle9K8VfzjpFPJq4Jcb2LdhjDlGBRpEFrnKOkMsJzhWOgCdVkRqF/dMHYfjIchLlH+eQSkRgofo5DmJsXNZEZpLMMj8zK7mHW2O6IG9MVfnWNtEGEGfIvxCi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NctDBOL/E31gEkZsd5voxaPk2cbIRCA4JUFVOTUU6QQ=;
 b=terb11CSvMYGXTEJVKOIlkgrNHChwdh9G0pVteRrJK3/Ln01de59w7W1EhK5E2t3iTWgNuSRcSNqIi66pHTfUYV5gBYhVlwj4S1XV6NqMkMkrNqqZAo8GgkPL/bG4P70uo/QyPJ5T5t2rWqtm+38/BohLqo2iaWlSOPgoYKMXOc89ze5tgduiU6qR5kR3laMqFK5TKPxBksP5r2cF5GpbTS6s8OKu37sZP1mTYS1qp2Y5/91YQ3blkCxqCykx6a1y8orwUoZ5hwKUIk8x8u27TmlyM32PHZRiZoDa0n47zX5LEqsvZIBPJwaQZW/ibFjPv6IWiWg8R4FOlawEeR0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NctDBOL/E31gEkZsd5voxaPk2cbIRCA4JUFVOTUU6QQ=;
 b=ciOw7RUB6iJst9aATGDREC3BHBs7UgcOyixVoO5JovfBm5zIODb12ioQoVDLp5zZVmsuG9KQZO4IOzoHK5fIRs671u14tK8ML3inADdPoewV5Y13xq2sW4ZHYWclUr8a16CXh9aQguvnT2ttmEBAdDwzA6gNKYIMbODHtRcdbGbLG4N+jm/jtJeKQ0hpnv9F0ck23vzKs9KZm2yUaiFDuT8qyBs78xoYmFYdWkd+hcIYOfORz5T6M8EDj3yUvpC57sR4EoqLlCRPgjrayudmkZlkV8EEbYpMS8JkknK/wlz16o5dGAXBRi12OZ70np/6Sn3o7fKx/vAshTKgQY08Jg==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY8P300MB0270.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:263::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:24 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:24 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 05/10] autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINT
Date: Thu, 23 Apr 2026 10:37:55 +0900
Message-ID:
 <SY0P300MB080173E3DC433F8E4D215C7ACE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-6-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY8P300MB0270:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9f9e9d-8e8d-4d51-082c-08dea0d90176
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|55001999006|41001999006|19110799012|15080799012|8060799015|461199028|5072599009|25031999004|23021999003|51005399006|40105399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EyjDYbaTPBUgi4R+QRjXytFnm19PxDB15qUgnech2QdkE6DZG8G3S2+ockY?=
 =?us-ascii?Q?yU/lIuDhHdu+YSm4jlx0GpBmDyPK0deNOrqO8uXKfvD5eNTGd32H6nSMymyK?=
 =?us-ascii?Q?TrMS5LVeCh8cpD89i2WiSVPi5pBAuxyELtsaHhH3r67uMOFFxgx7WRRlA896?=
 =?us-ascii?Q?lzvGXv1dh05/B+iGvHewssIKia/JO0UtZPMS/5D/SgmxzGssC9jFMLqMjDsb?=
 =?us-ascii?Q?paXob+oDPZXNzRcSt5BRuHdG9jUyAsX/Cc3hntnbaeD17bqSU/78Eizu5FYz?=
 =?us-ascii?Q?Cr58P5iMtZL3jUHwQJo0ae6ytZdiomt6sEm+EjqWSQ0nYBfJ8Xm0lw6bCv6g?=
 =?us-ascii?Q?0K/gzOVUbh76Z5cUkO463EZwuRseftqCje5lIhIeqr91jQLXu7VMyai5r811?=
 =?us-ascii?Q?vnqJd8RlQ+7wdsxjXSvaafwNEnrh/ZZReSTCdxkx4FBDNQTvJI6Wy2DNXyFm?=
 =?us-ascii?Q?v/4NdIDsg/4BEE2CdpcB/a4p58J4h6fEDyCvZ5st3cS1/sMIm1AFJKPAb1kJ?=
 =?us-ascii?Q?uzX/78AL1lwYhNResRmVDTs4vbZBEp1bD/I2WeTORZgOwU5DVGsjH2CofQjP?=
 =?us-ascii?Q?13O2q8y0h8uYcE/hqFTg/1+501t/3mT/aEdvBgR91hqjozbGH4dwBK/smLwT?=
 =?us-ascii?Q?cWlwmKyyAyXz5DCtGeK+DmjC4Gat63snqpqHGtdaHurQiC5yXil6iMMUqlnc?=
 =?us-ascii?Q?HBfugn3OMMUaeX2TQtfVzgSb5KVXEiK3YdWRfe354ZsbwqbtR1PnFoBPyhZK?=
 =?us-ascii?Q?VjbdzrHh6vXSae85m0lxywt4bgqzSvMt2bo6/yrwUFiv7nP+oGR8WcLX0ows?=
 =?us-ascii?Q?gitPZSmoWoHXurKIo2uB4RI97pPw0FgTFzSgEB8wjaKt03koMvb1iO+XJMSL?=
 =?us-ascii?Q?7icXSw205xAutp8L/a1Xg3jeJt6TSjjAAJdAC8E9gY9VJv8WOmVbY0FZJzR5?=
 =?us-ascii?Q?D5k8FFYRpnbc+DSk4Q7WQRiqhzzMrtxkufX6v4F3K1RwccXvp9fmLvCu8H+h?=
 =?us-ascii?Q?HKtO1KMUdM+wMi4ww41mQ1orA30qK+18iMUmfSqfWGruRaIgBTgYTg9o0SmM?=
 =?us-ascii?Q?4uLPVp9l?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7/kiH2hpXvm06StgTE7PZqHmZsuIpsvpzrdtaRPr4O/Rz72DOvsisOBlf8Rf?=
 =?us-ascii?Q?9DRUhi0SkO88dOnlWaSmLZm3DDoncsTFJG6FxPtvaq5TMN73R1JPfq11o3Nf?=
 =?us-ascii?Q?hzR+Hvw5pk02NWhwrqEBbXedv0jxesZZA1UUmDEFm0K46AxbCT0+NhZZJIYZ?=
 =?us-ascii?Q?NdHG3CmV8pJn8ad1Yw5tRw0cW1H6scDj/JdNlWqpVkzrVb4ga3aLg2i5C786?=
 =?us-ascii?Q?VPJNIa319IAQSeO4V+2zUnIHT9EZ6kSxzl++HHF9HQHUF9KPGh7pENmpUrYn?=
 =?us-ascii?Q?Cyp81snwGUqXggFILST8c/2IrYmJ5+6o38K6r0+8t7vCot5OObgzH5WLTW3i?=
 =?us-ascii?Q?i7Zqmk0KY48myoZZX+xdy3JgVbWZwLE7b4kZiIFzBuQWr8LvYRWZIjA5MA08?=
 =?us-ascii?Q?bvr441+Ztuk7OlKeHUgRsmnN8QgCzKB6OWNRJomO00r4CBgNWp6bcafu6Fv6?=
 =?us-ascii?Q?AE8Npq1xKSfurktfPnknn5X2Wp2iI0o0aN/lsu0QBRGRABDWAgdv13w4be2/?=
 =?us-ascii?Q?K3rAE1NbZZ/JzB86Oozbua0KTtqtVC792883QFasU668SnOw3AL/YrxspYui?=
 =?us-ascii?Q?zO81jp69xbteYWZ5AmhWvgmHaUoGVz13r4enk1VywHlWm7xpT335il9AvkmZ?=
 =?us-ascii?Q?q23pjntDkkhXDxGFb5/15gjS8IPu1DQt3lsMM+3ASmKXqD7p7nrZYEoMpqZx?=
 =?us-ascii?Q?5YUFDnUJsDO4UDV4HKeInj6rFLNxq5Bgh+dUBw2rYSWmkvIV+G0uCUAYdLDO?=
 =?us-ascii?Q?CkNmIJXEmSn0Ghtwd+34Ecz5f5JR1/cHwOxYDp4Sj2eIOLXe7SmokgQRwbfI?=
 =?us-ascii?Q?tcgH4JNJ55EK1r7VufKFVs0hW4rgMIsJaXrCaCxtIz03l6exwU64egCXzyhe?=
 =?us-ascii?Q?D/ewiMIxWmGvxBanC8IC/n5SRaqZ7FC3Pkk8LWwJmzUcKD5OJQ/meqxr+SV1?=
 =?us-ascii?Q?SMFc7eOfbfFf2cgwigT1dCuOqpg2Zm3U/n4BE90JQHtmg2LrPy68tB8unN/Z?=
 =?us-ascii?Q?JZIgvjQNwE5OsjrjTP7f+/D8UbBw7UKtKWBK4Da4dBmSpTgagIH8zxwdyPns?=
 =?us-ascii?Q?ZHocsFzymlUQGo6GeN37rWidPScC0n7cX3PLjra4/235X6B6p0Je/YwM5KSY?=
 =?us-ascii?Q?hyDYaDN9XYLRdh6PuJF0EzruEIwofiI8GLGUGe6l04qSKmqkO65rpphlnn5N?=
 =?us-ascii?Q?UvITdt2M5zkFxaGF+0uG5VDKkd/h1yDfKkZP59CGx7WYPZry1zUFqRmZ7jCq?=
 =?us-ascii?Q?H84n5t2WjhJhErzmHZGJmeU8YkUlCPw1WlE+txO64GmOKLaLUt/FO4ttDwto?=
 =?us-ascii?Q?qFKTQBZzEgpaDkmQ7ARmjKT7jwZ79Twf5GOuWedbwvvMFVgfyjjgPXZh4sLk?=
 =?us-ascii?Q?9Vy2Nb8tS7MOHsKGOoTUlxAzCuDN?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f9e9d-8e8d-4d51-082c-08dea0d90176
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:23.7352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY8P300MB0270

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
index 353596c17d82..c7dab8395ee2 100644
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
2.54.0

