Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDF3CE483
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860398; cv=fail; b=bPZD5sIuKIRe44DkF4MAKdGePeiueS9ERGQqW+G4Jhc2QDU2ZCaSJ54INJIVlxZn4JoHuD5yOtrg2t68Uv+DvVAvTARYUCaVCx1GGJmlB+/zftG8IdK+qEudvFAJ1WBzYkl1B2eSR7b41oWnN4jdlcEryhDFbwvv2MZH90FV9LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860398; c=relaxed/simple;
	bh=V5zckcQxKhjeHRlrAstbcNkSZsvRppRqpeeu1O5CXmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WH3+c1hOfUYK3xQne3HDIeFhyy7gKg5plVDN8h9cn2GJNlx+UpMDDsWsj+/HqAckMxPvhMbh9uji+De21eO+UXwcZywPXrY2zH2/aiK8e4BN+aiYK/tNWWi5HJdnBK21lwwnSb7FKn1GUhUHP7LLeXfbqMvjh6fZSsq4wYVSCZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=le8O6P4W; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="le8O6P4W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AExcOt1NWhCxKX0qb7yGd+JHX3F2gpfcBO1w7TXxax45QYoVlZOJGqqixbaDdtfQCFsBkMelzBwYJMsuOvsQa4aoHZCAcfnmnMqKHDvtY3T60ljWElZgHVOL4sWS06zlkGlql04g82ko8lX3GzewjVcgoV8uokzjS9PBVJHbwwumdi7c+duQk7z1T1FO+8NB49qW0m/goKDKvE7Ha3nt75DrEp5Fj5uDsTWSrhXIX+3vDgyftFspndPj9MB+8g3p9MEN2qGi1Ilx4t3Ivcp5YwdkO+yErBm8H7EfojWSJpW6WMhHfSlzYaqNvkcvULZatKVJDCiskZlAUOR/q5tvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nriWBHMI5KyLCEnsGRWP39I39OMhkeor62iGkyKZKY=;
 b=bX71+A/SQfvbcZBCNOh5qz41ferSBGX1JIM3e+nHqm3dIpxq77m41rj7E9TX2K0aTmCCmlOSnt80MT7zs0Y8rrwNnQJU3Hu73VNBZvR4f/Sd4mBAxwPDYj0XQwfQZqfAligsgT4/dbmA2I2caMdZf9GWdEwLi8m7v5FTLAuSLMQYmtw4xztg7Mp9NYbBpxj2/SL4adqFDGNMhkk9JQ/5OzoEvuTIlz8QlxJEZHARPfnnQhyYlwVPB3f9fn3bd1+Q4FO0UYxYARpHxiG2+G/jz9JejiSX470WwW6oo3YmYrfNJmnh79ZSDxauebzyVHMYpsRFaUARlDDn16CKpuJ2bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nriWBHMI5KyLCEnsGRWP39I39OMhkeor62iGkyKZKY=;
 b=le8O6P4WYE9Wt8B29Gfmb11iKjWRR0N5HFAh/AYD2JcK0Ol/g7aLuna13+c6JtkQjPQPd541zFl98tDrkcgTwVplqsZbs6Eiu0Q/qUxGz8jmKj/YmsWLdTXJywUjtUrn0CuAt1oqoz39DGwe4muQZ/03UL3elYkmxX/cO8Fy85zYQyxkoluEdTmxWq+5Bfk8KfmuuCfKxDOFXa2m52B3lfiwFSEa1e2J+2p01DZeHGUbCmWr8hGap9/qUPw4FVdhtIKrwl90VlOpO4rcVmFjUWPKi+fyVr+CZsOKszHV3EKVDD33B9dndFC59nAFXm4EIf19+/BuIXyHqGuI3s7p1w==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:53 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:53 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 05/10] autocorrect: rename AUTOCORRECT_SHOW to AUTOCORRECT_HINT
Date: Wed, 22 Apr 2026 21:18:05 +0900
Message-ID:
 <SY0P300MB0801893D2DD10EDEB682D722CE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-6-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY0P300MB0530:EE_
X-MS-Office365-Filtering-Correlation-Id: b39d3480-a5eb-4b1c-b072-08dea06974de
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/CjsMqmic6ItdL3nXAhqGGoLF9Y17AmaiqDTTGCnYV/FnEjTt/Z5onalsLD+?=
 =?us-ascii?Q?OPCSqdB15/rmPC5/mT9PBg8ljJWUmpDbvSyy5pH1tAOccsP/P4uFei70+D6H?=
 =?us-ascii?Q?I+rwRvQRw+IztR0Grw/l/qPl8XvPYYVaysGK18GOIcuewNTasvNTDiKwgKUs?=
 =?us-ascii?Q?2pY7vMBwl/afLSIp9JZjMMA/6PQHoBwLG2SMR1oTfXIn5VdsbsDQ+nW+uYSw?=
 =?us-ascii?Q?OqgczWzgcogt/U1NK1WSH1ENo9WqODcBi0oT6QjVUf9cAnK4r3YRnE/VDad3?=
 =?us-ascii?Q?kuVW8PfWVzX5CWidE1eD8ZUvw+Av00/go047xREVyLEpRMi17VeyiD7noMMP?=
 =?us-ascii?Q?PgIk4aakfaZBdsMTfHTg4Yr9t6psyi9SKVUt0gjxa2vLCn6o31a7UhaYt2XY?=
 =?us-ascii?Q?efK/MUiaOD+Llf1+7tVHZ+WZxqGlD/tD90aQVtkwAOAwGd/AaaezjWrr1I5H?=
 =?us-ascii?Q?yUmu2KyXqE3zIWRBGvnI28qk9fATmp56Fll4aSTzN8jOVEdptc8d1xMp2IIJ?=
 =?us-ascii?Q?kvXIj3vW7TDiH8G4jc0tmxonW7XM1MOpaEm0JGXbuygsnTTA5GitISjul2A3?=
 =?us-ascii?Q?806jDDN68QRTBtQ4JwSgQq7nAs6WHKmva/eauTzIw0I5PyqfKB1sMzlhEWeI?=
 =?us-ascii?Q?QS9Uv83ahduAQ5THlURp6/EcYkaz2wI3jF9F0nVBD5PsVVA2mLmWdVrCMu+L?=
 =?us-ascii?Q?mCB2s7C9Btr4NKN3RrCfm2q3zB+Ta5yalpwzglvlzCV/BY5cz5BNoiUKmptF?=
 =?us-ascii?Q?pBS4owK/lc0jBrKH3izjGP/zsVBKxAyv7FddGRqMpaeeCs/83yNrFZZpvpZZ?=
 =?us-ascii?Q?bzRmlgrXysMKi9rVwn0hyGhSUuHglkiWKFChcwg4RxhuL1e7TEKFZ6H4irK6?=
 =?us-ascii?Q?ZG1eX6MUACUgkXhYTf0wXrQVqtm2UD3hMOtI4M1MVEyxdnNX7COcLJQXgwDZ?=
 =?us-ascii?Q?aFpOrGVOFuGXtgQIf/VJp6Ddahje2k/0W/2Yc+OKGC1P/Yvy1rpMhR2vs0PK?=
 =?us-ascii?Q?EQpMhc5WmVraceAyR1K8G+TbAbA2zq2p20BZAVV2jh/+Sv4=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vzh+3I453LpHOLT6cJqlrxwOmMzVbLSsF6uj4FqEtecG+X0MeJr1VccL+GP?=
 =?us-ascii?Q?d1rwtCVnGsHGw+x+xZibtUTTkb27aBv6kdqxX1UhN8T/CfnXLi2KR4JUb3/Y?=
 =?us-ascii?Q?dNGh5FytUxAmCbeS7giOWaM85chzBI2RMG/6MbGCycp0a3C2k3ltEsKZxYsP?=
 =?us-ascii?Q?ElpARHJGMJutrTWwBlVl5eC4nPpUJeB6RnxWl959gPtHpVxnWDQ7YTInmgYO?=
 =?us-ascii?Q?fs5LD5E5KqN8IO/COpLJzt8myTmBMr3UC9ylBd95v/jA0XSvuFHfcgQ7MZ0F?=
 =?us-ascii?Q?gvzB/Nf3YYrKhDQNgPV4mCCPbAs7FClTIF6r0M7WhMYPU8I0QqWYjz7YHXK/?=
 =?us-ascii?Q?xPqnsCqqW4WN3n0CufCsDggmr6imTBWTk7wtcJGv/K5BhkXZaKJm0g0L4Hou?=
 =?us-ascii?Q?NymM7ulLd1Nn29ShCpuYTn0wLRQJBAgfIlreYi6D9Zn2HoD/DNEk53loAtSP?=
 =?us-ascii?Q?i4teH8c/R9ZMeFkVZT14MZiUw7AuR98UvQ7pC8bHDynjkVdaF8iv64UyM0Mc?=
 =?us-ascii?Q?28BYnf505FWgWWfNNOK7BVfTDRAvrc7TwsA6XuSY+1T0NCPimpmDPgAavZX0?=
 =?us-ascii?Q?kAHQ0D8LR1JtVoJIwPs674xZZmBtuRvQFeLwu3KBtzfmSMti/eNDld71d9JQ?=
 =?us-ascii?Q?S/MpScgRzE+Yb0heBiEmfJinNSyDuuDz4/7Opy+MmVy+WtCE93VOr7HcB9ha?=
 =?us-ascii?Q?RTQ0z9ti8z7eEiRxtm89bsU0HrXqkEJ1jpXTMoINpAnxD4b66YqKzDoPsF45?=
 =?us-ascii?Q?O1W7I9lInp1l9OWs2aw0qKZ9jIOzupDPCUtiYVDG8D4HLtmC458eKPULjB5s?=
 =?us-ascii?Q?jqfWdWEUv/3leEnGEi/4yHXV429k014MGFXfVl0Yd1IBL/2CgzqU28ElSldt?=
 =?us-ascii?Q?zY/UKeVrTcGNOybqjlV9I7ISzPoH04lur7KDAFrjmHCURfebF5LKCRW/WslL?=
 =?us-ascii?Q?mpXq2NVZ1j4wSU02gGVFY+x2EFpAndNR6oKZ9WOlD0EQLrh+hwupdfDRufAY?=
 =?us-ascii?Q?HqIEfRn9g2CIXa0dBcEqltjDYVB4NqEbRKWtPX8VOklDvEtL2PpxHg/ZFbCx?=
 =?us-ascii?Q?T3abz5DOF8caAre2x/aFcSCsRqfrppKR8xqODNU4e1ZqSeVgQ6fynpOCjm5i?=
 =?us-ascii?Q?8Q+zakw1TbczMC5vYyzBRDctXtGjG0uqilSLmnuLjUqE5y3WObZdWp2QmKFx?=
 =?us-ascii?Q?7BM+eOEEU++MnJRQQonwSfpDRIl1SpQMFvDKC/gnG1qU8m4iM/xSg0Pbuy2I?=
 =?us-ascii?Q?dhNi25//7tcrWQU8+edmHSGA0lyszH01eNWOTDCB/8E1yL7UcWTzwucvvtIP?=
 =?us-ascii?Q?g3Fo8h8YQiEt7LBf1+xtKef7y6Fw7atwRhNAQmP4N+PYxE2NZcSbXw0P9TwL?=
 =?us-ascii?Q?bdWrHaNU3PDX8y//MNAqulSQ/TIO?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39d3480-a5eb-4b1c-b072-08dea06974de
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:52.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

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
2.53.0

