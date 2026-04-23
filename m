Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011061.outbound.protection.outlook.com [52.103.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28753AA195
	for <git@vger.kernel.org>; Thu, 23 Apr 2026 01:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776908308; cv=fail; b=O1a/DvLXtV3PpCWD1b2WNW5o2EN5qymfTupzHeQoin7zfg6qrkUDKwB0XWTMrbqJejIlcCgltiL41jPIfl0e9bxXpl/VxrxrVBzaBgJbLr/UoYrut0y7AYjT62GSavgAFvVyVTmipar5UEVBWH/IwLtt3vEwpazBam7h/KPziUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776908308; c=relaxed/simple;
	bh=VDAbWBNSik73McwuHgkLpZLc5eKd672+VGeS0zkt1rE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VhsIDf6NQAOYSGJ56WU+gZEr0WW6tYiT9hok70/8pz6SY1O7EJedIx3PfUVsn1l7qLGHkS+yPUJkfRWDAqkqMzP/A0RqSGpK8WV92WMKTOLJ6txOP8Onkspkq3vgX3tBKPWGMRNSZvfZBo4oKlB00Y+L9i2esABWB86tUF2ABZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=b25WlRgg; arc=fail smtp.client-ip=52.103.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="b25WlRgg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AvWQp9KabA+qRdJfKxKj84sbHLh03RBAgro6O3Vgu8YeiMHs6ab3BsqtE7KOcX4/7FIDHCo6DO/dpSkwAnC3KDOqGUBbXzawob/qrVVGg5gxhTp6NMtmxZOSpf+RZ1HHQELkuWfCnfr0v/LFox3pyTMQT/YpteNSpOXcphT/Yvde0/ElUJXFDs8Khm6gA32jlaAF8IaspNL1YVeiPAv7U3TIwkpB+/u72Hj+ZZlaBFk6giEQUYl+j4Ks4DzVrHDhPqsS3By1QMRNJksyXVbGvRGbZuh236XF4hcEV4q9uLxmX3LGtLRm+rcBzVfmLcpj2gi/TeLC54ZICJDLza076Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D0+aDIA+QGYaZCYSI35cvrMUyaz3OcrsZiD8cFK6fzw=;
 b=GXpDDbetvelLWEGBgOzcYXL7UvEH+LJxPlMtien9Co/a/Lh2Kc8+rBgNu4aVcYzdgoioqblaJSZGOLfRT86TpE1EGNsxl0rJxpj2Wk3Q7PatmZEg/C5SjZgsn5gR9X5E6B8cH4zgZnh8RMEHuVpdyrtovcpNJi0fdxvT/nnf5WogvKsDTGXFx0wJu2x1mpFL7cAK/0dK6t5vP2kG750e2z5SMSEWKhV1FTj0RpCpHAdmcFUzheeQTEhJlPNP/QxNHE2m3ElROfCVc8SwhQlGyQBOHe22E4owynPXdw7VR2QXm06KOK93VcLM0Iel6IpII65k6O8DPWAIa1ZRkBoEpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D0+aDIA+QGYaZCYSI35cvrMUyaz3OcrsZiD8cFK6fzw=;
 b=b25WlRgg9jnkx3VUFH5ofYi9XaAwVg1wNL7lSbBl/CnRkdKw+kDTpUVLUi1bx1N9heYMbd9zcrln+0sTtm16sJCVriJtbQ4DqSqvtmXXrC+EwrYJ3f/tpEaI6f3v398lJRSwnq/Xuf3ynczoxq9Vq1fQVEb6MQ1Rh8Z/3eZWyGpPwPgzjFn/STPNtNteHMX6OZ49/LIcq21oHL+yonMgx1GwkukYosYQMQjK2VOZb99E2JDeLvPKuN+Qqrr2WYDpBca45ZMBMRDgxqYq4a2y3IOHLbXLnodF5UHawXCrHq/tWrQfScdtxCc1gAyhLgU33zaClaHKmenNs9D2Ze/O9g==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY3PPF5F39D32ED.AUSP300.PROD.OUTLOOK.COM (2603:10c6:18::498) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 01:38:20 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 01:38:19 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aaron Plattner <aplattner@nvidia.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v6 03/10] help: move tty check for autocorrection to autocorrect.c
Date: Thu, 23 Apr 2026 10:37:53 +0900
Message-ID:
 <SY0P300MB0801870630EC7F15000596D7CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801677A2A1E0FD38D06A841CE2A2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:405:372::10) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260423013800.82156-4-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY3PPF5F39D32ED:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b15875a-0961-412e-fe14-08dea0d8fef6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|24021099003|23021999003|25031999004|8060799015|19110799012|51005399006|5072599009|41001999006|15080799012|12121999013|461199028|55001999006|3412199025|440099028|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vmaomBBdnAmOHzC5nCIY0jsEyXYLq4sJQC+tohbqMvH60fpNlou8S+yWJzm0?=
 =?us-ascii?Q?XXCLCbnoPl/384DzCWUoGX5QWgUThmCNJxoCP+z1X+o/Kg+AVu16a8QEQPci?=
 =?us-ascii?Q?E32Wrr+5osB8gKqLhO/7C8eq7m1w/n69fcScQK6Bs0gXSUkH4iiyK9qoZZEP?=
 =?us-ascii?Q?IC7hVvT07TDLkJ2rZd9yjjepTVGBCzYjLCUtzyV5GQZ0yXm5LjSJ7g9yQeDu?=
 =?us-ascii?Q?Jk/8kUpmbpUF/w0jkTtGrhr6y+4NcvQ6z8W/OD25jGIrEwx1rRLpPqCqHjzW?=
 =?us-ascii?Q?N3RyFqpxpQc/xN3nI/w89Tix9xIBpyjXWMPsSQOXNqceI4uVK+jkzHSSkkK0?=
 =?us-ascii?Q?XuKnU6SccrgpvloVVcnPwp48IGcle9jK1gUOVS/qwNDtVR1ZyePxwMwUY7fV?=
 =?us-ascii?Q?aAWkkRGVwqBQwJWta/tUt5acyUmJM47nAbgnfsVpr/U2Ea5GuZRJG4ZS3ynn?=
 =?us-ascii?Q?oMTBgfUpIGKl/PNYmXp3+LtB83l4sJK3e2VGWjp+jIn6XENjjmxBRqg5ABpI?=
 =?us-ascii?Q?MunaPyHCP1/sPVL8FVmYskX8Ga1KbfJ490nfjOwv+iFGEmfM/XAk5vrlFaWs?=
 =?us-ascii?Q?0FkqQuL/oHe1tLR2+kAqc4c2MRSk2PobRlf1gKK6lwiJ34n0GlT3mjKw3Uyj?=
 =?us-ascii?Q?ow4n3ByPzPAGwd0DoqkosHRRM4MgxO49SfSBlDXC2ev9FaFwxNywTzovE8Bs?=
 =?us-ascii?Q?ic9nTs3jnb9ILGW3IkxRiwMQegvwDHMvG+31yoWd5/0RQXTiQ0x8vb7hlTSq?=
 =?us-ascii?Q?0N4Chw1SDrphCSluAVbnbDPg9belqPV4k+kALy2HL6CoyZpad6kMC2253Gl1?=
 =?us-ascii?Q?GJruEJrL6mn5wnKeKq2oGC9lbOXejTY3leS4k1BZxwnExcg9M5tLkrM9gI1k?=
 =?us-ascii?Q?X9EquYJpyqVMV4H72zTPRyjYJ802ERhnqyEMGEhImFmx4WYRetVI0thPFo1R?=
 =?us-ascii?Q?iZahULMyZo7htNYj1OiMgb0tqs9HaGtJSNE4y3efQaeX3RbQs7zd/v0aB0n/?=
 =?us-ascii?Q?jUbF4XdI3sNV0nkKDb6YKP00IHmtAy9E2YoPBMpbJ/kTDceYR469GvYB3Mzf?=
 =?us-ascii?Q?wJPZ6lE/AS9XvW67UgWxv0b45Akutllj/YImmpqdN2DNHdd3grY=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FuwWqI1l5TvI7skR7B2zV08/TzELYvbN1gc3NzSpglD1SHg0xy5FeGBMPcdS?=
 =?us-ascii?Q?1+1pbArXO7cX7GM0aIq3JcQ87OQ6VFQGnxK9r40O/3+kViA67aUmTmkj9oa0?=
 =?us-ascii?Q?LQUH+vf094LhiKeQLvuzaJMA+HwR4sscx5Umh58xeWqQCzeQddZ+/bQEAk71?=
 =?us-ascii?Q?73K5YcOrsMJ+WLUhbMVAz5l9wPsoVJqUpqJEZ0RIdB1puXbn4b5y81HgZASN?=
 =?us-ascii?Q?yO72ueOL2VAYd8ZwNejFruhhZanjoT/Gsw37SS180sniVvpgarfJ1TMEouST?=
 =?us-ascii?Q?ScJMDNvNslkzaxAcmRy03qQ5cNA13hZa5YVGtDGNmQEYIW0X/WsjhIwDpthE?=
 =?us-ascii?Q?vp0gF+EwWmtFql9sn9INex/ppYuWTSXoZMeXU8ZddCMiry6aZ3Iip4n98kLQ?=
 =?us-ascii?Q?KkfueDEdvuUD3OSsqX8UGCmI7/H9eFH5jjyZVWRWZmDd9t75noirSyldt/xH?=
 =?us-ascii?Q?gLf+/WQF3HNDzaniE/pxr6ip1QQBwTbbdMi1THcWQb4U9Aj4zx9cmJ0qaNkO?=
 =?us-ascii?Q?zuKhH64uW73xeiVAw9kyLlBJILZnZsU8nmjBr9+IdBM8Bp6xWFdiCGoNcoG4?=
 =?us-ascii?Q?4RsGfkkp+urBU4m9fuWZjkMtum3tQBX7C6pUNB1lc/KdV6EFrfsnys/51DMQ?=
 =?us-ascii?Q?oMnPRxFpnGFwVnEn1P1i7B2Oh6+OFD2ZuGXMS2wWSUciKn1JDY30KMuRi+qC?=
 =?us-ascii?Q?l2W4Z6U9Wb0EiyvIpRizkeO3rJGygZuZAqr0zYo4i75IOOMzDVXwvOis5nIL?=
 =?us-ascii?Q?/RYOdWYSUdQFX74TZmBGxl9NWlVkMvkglz40M2OYbUqQJUD65m+s4oK4rUec?=
 =?us-ascii?Q?BKkUD7fo3pHfThI6mOl3aKWrMVZK8JswJ0Ey2LGMNIKLTEP6jYDGFB1nKFf5?=
 =?us-ascii?Q?uFTFBqriiO0fjieeJpLlbn8JYDg2vGuxnml/PB6VEtMDZPK2EUENJINDU1J4?=
 =?us-ascii?Q?WbDv0GY1LshTv+KxADAD8Gmi6/32WUacOm/xsXFfR65n3BLcoUUvltY34QLc?=
 =?us-ascii?Q?EqyDHiMQBWK1tsl+2YcuWppRGY+xmwz7eB8+ENbB/3oFHzXgr8Rok+bscr/s?=
 =?us-ascii?Q?PPEuRym3oGix+3gu+jbj5ukJFBDG6OBJDO8ZabkNfyGednX1KKpu0TGHX2DX?=
 =?us-ascii?Q?QbGjbn3TdG+rQtY2BhOMujya1xwvkTzCuZ79kROZ6Dn2AflLh5whji73LWPp?=
 =?us-ascii?Q?DtDvW+N1NU8BhkwB4izhffTNK3fecFL49e0L3Xszd+Q5R7i7UAO6gVttRc7y?=
 =?us-ascii?Q?4xdJ7lXXHEH6FWwrlxxxiS9t6eEluNKlHj4ogE0QYqI7A6YAnisHT0qhAaZw?=
 =?us-ascii?Q?PJ95/x7sdUV6uWXzNJYzWtU5I5Slej3yV5+WScLxxhF06sFgCulyjrBrsQnQ?=
 =?us-ascii?Q?r4gsV1uFcSwky5ZpiaFW4dEpk27D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b15875a-0961-412e-fe14-08dea0d8fef6
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 01:38:19.2101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY3PPF5F39D32ED

TTY checking is the autocorrect config parser's responsibility. It must
ensure the parsed value is correct and reliable. Thus, move the check to
autocorrect_resolve_config().

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 24 ++++++++++++++++--------
 help.c        |  6 ------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 97145d3a53ce..887d2396da44 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -33,18 +33,26 @@ void autocorrect_resolve_config(const char *var, const char *value,
 				const struct config_context *ctx, void *data)
 {
 	int *out = data;
+	int parsed;
 
-	if (!strcmp(var, "help.autocorrect")) {
-		int v = parse_autocorrect(value);
+	if (strcmp(var, "help.autocorrect"))
+		return;
 
-		if (!v) {
-			v = git_config_int(var, value, ctx->kvi);
-			if (v < 0 || v == 1)
-				v = AUTOCORRECT_IMMEDIATELY;
-		}
+	parsed = parse_autocorrect(value);
 
-		*out = v;
+	/*
+	 * Disable autocorrection prompt in a non-interactive session
+	 */
+	if (parsed == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
+		parsed = AUTOCORRECT_NEVER;
+
+	if (!parsed) {
+		parsed = git_config_int(var, value, ctx->kvi);
+		if (parsed < 0 || parsed == 1)
+			parsed = AUTOCORRECT_IMMEDIATELY;
 	}
+
+	*out = parsed;
 }
 
 void autocorrect_confirm(int autocorrect, const char *assumed)
diff --git a/help.c b/help.c
index ab619ed43c7a..d2b29715817e 100644
--- a/help.c
+++ b/help.c
@@ -607,12 +607,6 @@ char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
-	/*
-	 * Disable autocorrection prompt in a non-interactive session
-	 */
-	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
-		cfg.autocorrect = AUTOCORRECT_NEVER;
-
 	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
-- 
2.54.0

