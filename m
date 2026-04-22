Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012070.outbound.protection.outlook.com [52.103.72.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A23CF663
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860396; cv=fail; b=iFDMdFip6gJT1MAL0ugDuzdwKDFviVQ55S3ZNiPIXkh8Fr19X9NJUv7IUtwprJ7TswjgWb6r8Nj3aeBEEtLD/bNwOFz5P46zHS5+4I36ZZRdVca2TXjcLJL40/deuVMtsquY2aMAxCgtcpapNN78TYNFb3gwJwRPDsegb32q6BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860396; c=relaxed/simple;
	bh=pfyTSrdQBFsv2SHJ2kOGcVUdh8fuz5VLr8A67I1WKdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bQkkK7suNGByB/teoFp9TOv1s7T4m1bv7W6kDO1QpnELgqsciQpxes70CPzdz2FsdtYNOQPunyLuvuzJT9+ISijZD0uiau8U/+x+YLNWB1WulptxxCEmMiCqaJs3nZvJabIZncIWBAPCrsJaMuZPH21AgZ8unfFvUPiyaUXgQoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UN8tZMS5; arc=fail smtp.client-ip=52.103.72.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UN8tZMS5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QznON7faxS4hAboADdC4umclYA+E8LbRf208GIQcKvPvfwQoP9RYg+PZqaszWofrp/zZnOZU4KPKK2CPxwz/f2TaWWXPO9Chn9tC2LUxfMTJ5htyW0LGKx0rw3VwhF1B9OLxB+zb68vMwut8w/ewaHZmczGV5hxKXBFH0FkW9vx+KIb5hvCb0Xv/xokiDtzHxec32j0HPthFO0I0mKcm2RXVL+Wj7nWrX5dvUQLGc4rIHwADEBLzEnG/PxtqZoUoz37SrsN6M2YlZoBbO4t8XLsiYTksrLplR48L9ln8gRSXHQThqn8kONeCN3b+wAk+mE7soC+UzkTi8B/C/iP5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRwluA8TVC/V259LRcOowVzzyZlmZixBQJwFEv1dj00=;
 b=VnPFlJRZG7o0/LPGVt/AfZT99kZ9QLHiqQT96qiaATyI4nItqgtsaXnBTwrDfYjd1AR5Wx52jFkalUXcq9KqbRfZp6Lk3sJVZFVqNIj0OrX9x0A1eHnt1u+ERBpOCBQ13oL6e1zO0rXV5GFUBMmwFLPH3ktOLRzi9wV0qORV+HLUX4MOjjUYILEyG5apnOnjEyZjX1gqqhgd9uaVDkGdr3IlfmxO6tjt4uBHzFMdBWcNLlUsdBVCJurmnfLO9pwr3JGVuEmMATkR1NQqZDytfyst6FaUXUJ5w55FatmJRp7rcP1MWEK/8X+retgERLvROHBhzDMS5gKR0FzdajRAAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRwluA8TVC/V259LRcOowVzzyZlmZixBQJwFEv1dj00=;
 b=UN8tZMS5WANmRcJvxuTG1/SjA7tBx/BWgV6GhH/HzoWGJnHyXhsX2L5hNhaAt7CPIYVNif0WUUFl7tWX1ZhoG2+FC7ZdjDVF1z9KeS93WQtQ2+8MVNnabz6Q2WlT6vrIvgR/nWu4AWTO77bNFC+cw1Eb2WUEgL+VBG00faTDOYW4AKlkCL4qnfXRwFn7lhNpCjSCbaJ8/3h7wFRWz24hAfMQ4eoEdIpbn1kNAdPMsYobcsSOZxo/XeAP0PTycp8urmY3+2SQTAZJsA7yMzHcpVeEP7Z77sPUdjxD7wHnynYcZy0ND51X+MUwTTOea6blv14N+aEhNhrQu3ITCx3klQ==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY0P300MB0530.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 12:19:51 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 12:19:51 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: aplattner@nvidia.com,
	gitster@pobox.com,
	karthik.188@gmail.com,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v5 04/10] autocorrect: use mode and delay instead of magic numbers
Date: Wed, 22 Apr 2026 21:18:04 +0900
Message-ID:
 <SY0P300MB08015E4816BE4B04727A4D44CE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB080186A23FB9582AD793F0D1CE40A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801AE56F740AD087D22B35ACE2D2@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0104.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b4::20) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260422121810.307862-5-39@barroit.sh>
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
X-MS-Office365-Filtering-Correlation-Id: 8c533031-1cc1-43a0-55b7-08dea0697411
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|25031999004|5072599009|15080799012|23021999003|461199028|8060799015|19110799012|51005399006|55001999006|41001999006|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9n9qfx/30UUlOQfrMO11y1Ro91Tdi5OIcIqDnUqx5kdl0gIOS98WzF3bIA5?=
 =?us-ascii?Q?YM2XsTYuKEpdwvLedmvr+3GGJhop/wkDTO4xwQ/mYcW1vm7x25s+tVcOMWKg?=
 =?us-ascii?Q?cL/nIeqirnr7eKxFcgqOjyVu7YEO9IDR8S/ZloODU6SuxXw1hSCigB5dqwXy?=
 =?us-ascii?Q?lPL7dtDUfJE5oePvMaWXEl3SDcKbfJGe7CSjZqUQEXB2ewoh1VRlrB4vsa0r?=
 =?us-ascii?Q?rSwi+zp3cDV/3YO2lUQWiywGVplJmqaacd1QeLJjorCxKP2XaHlczqGEr+pY?=
 =?us-ascii?Q?XCqKalFZkN+2T4kpAVBYpDvdVuEvK4G7VdHYjGuJKwZjmJhfn1omT4Sb0laB?=
 =?us-ascii?Q?0Ll3dfqKQ3c87a18kSzUlYsMaN+Tl0tglyRlT4+4nzhVZeKQgY97kBUEeAjv?=
 =?us-ascii?Q?FTPdyJ/Cf+Jl22CdVqpSOD5wXDCzRGofmVA8bznIDho+F83bbLPhLJ9TvdZT?=
 =?us-ascii?Q?KjkoCtkqJ6bZRpqs7NA93WJ4MVcmm/h1S0iLsaCSMTPx8UJzy2pNzZJfFuBZ?=
 =?us-ascii?Q?lq2aRQYr1BWWOG2hgEUP0vIRuM5AwG4C0h9o1Cs8ZvN2Jxs9Ux9En8k1EhdX?=
 =?us-ascii?Q?obirQLg/wBQnnDoR/3xoyHcQSMFxy124SQNE+qHrRi3WN+0eILCg1LGNEBr5?=
 =?us-ascii?Q?AQvDXiaGJTNnY0aCfj+GJSTb2EqF2lcH4YzG39LDCu01imXVnfa5kCdxX0GB?=
 =?us-ascii?Q?rZStd9tiTUOeKHO5xB6HB+O+9+5llDkSno7UUSSgCjQPMSBlLjih2FlEeM3J?=
 =?us-ascii?Q?MB7QAjy1i97H4kdmGlXONTWKy/NihCQvJCexPnoRtNG/0QUIvudCz0NgQDLy?=
 =?us-ascii?Q?9gO26DOQtnHBATPrascsUUDvIEr0/MoSSGtkv5FTmq8uwzEroSeUIgnVqWHg?=
 =?us-ascii?Q?ShO5Mvx4cR5YNViOdaucUyvUyZopn2satrFZf9etFfgxNyO188HaihZfVcfk?=
 =?us-ascii?Q?jey8ComxM8lz2TJtVNcGoKVpAayBADNqHBTR6VokdA9g5GVMO0s8UOhKliTc?=
 =?us-ascii?Q?+B1HFACVVZy+O5g4jcNvBqdbAJr3nc1X9S4Vyhc6jfQ+nrU=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zesngUsfGt4iyylMQVzSi+o5dZ/Z7ePX99tGI78pQ4GqO5Rwfu+4L4Kp5cmu?=
 =?us-ascii?Q?HmoV5AXRmFq//7fB8nlIayeW/C+RzTnm/qoTXvRrA0kS6lh2h1tNvjCS2wrX?=
 =?us-ascii?Q?xioUUsw5jS3Ar9Mnjk+XVVLC8ErbS05pDYkUAswPo7yPdPYc8mGYGuSJMZLU?=
 =?us-ascii?Q?y+Ax6WLGhpubQPM7/l++OjSYFruwbHBeGpEEu2EHia2/1ZW0dcpGOwviusC8?=
 =?us-ascii?Q?4gJ60bTTJ1ZOCE/Ix2PzWVlN4QXtb6+z297h7z0WkxEUXgR5tI5SpbopCF7s?=
 =?us-ascii?Q?nVTv5DtUPlBoAgp8T7ljWQc8Nf0+8wFHiO9lQYoHFO+2b+8CZOwjQZ2EKW8v?=
 =?us-ascii?Q?EryE2IV5VaGOxHlP7ej1jltwUxRX85bKtz4Ty2Cf1GK3sqbgXj3iNW7K5tNw?=
 =?us-ascii?Q?SQnlrqAcUJ4rLEyMRpiNPIatvbO5TsuKr//TtBHD8MA4/vdM7+k5VuqDm7xp?=
 =?us-ascii?Q?o429uMf5BMj3yfcvGKimAtvZLwMjsBDABljU2bJny8cpm9tk5hAcPWVg/Yfg?=
 =?us-ascii?Q?nADHrToePI5GZqw5AkHvD4FSQU5qAr/9qVU1GhUfD90zYRbu8LXVcRx7wIvk?=
 =?us-ascii?Q?OaC2IvxRZnb5zfcTPNRJy+Ujse05CmsLqRK+0TTus34cbtZ1JvmT7/qoPkMN?=
 =?us-ascii?Q?yhF+KOzk/MZLMW5rltyo3evi8D9W2p2kDKy421ZIVV05xCm1oYZxFQPqq1yp?=
 =?us-ascii?Q?NCUuC9iKl5rEjNeWICgpQaAxTSe3+uzBejopyGcZrTf2I6HoyjfzR7AUEaTh?=
 =?us-ascii?Q?XdBhx/J7efNx/gEH0FL3BsTkfPauZx6CHzrzWDYDIYE5LfYppqVmb8l1QeSr?=
 =?us-ascii?Q?QJ93EtpJlIn9mPpFKaa8YsMzW6mZGXMMh1baTSkxt+dp7jkfGyzBcZPIepQh?=
 =?us-ascii?Q?X4Efu7U4LXciwxEF8cfzFtEChBoQu11FsUZ3sf+iFnMcBsgMpEFnahcQ84nx?=
 =?us-ascii?Q?+5qm84XR42XK9mHuj83wN7JXrzAFmsgRYISXc0VmHqJ9BnQvFtCR7FyPONAg?=
 =?us-ascii?Q?erbhuVSPrO0N5atsMJx2UbzycjoQRlZgRF0vqrNMNqyiJzkgeT1SE81zz26L?=
 =?us-ascii?Q?GTr8zADK7i5Ec4eQn11uxQy2VDY4caf3EskVOuAy2pu4eGwjNim+eE9qDJ3/?=
 =?us-ascii?Q?ZHwABWlO33kexNRaWjIhwblkFaHGVyNLJssSCGaxjVdSHaRZS3MStS1+f3Ce?=
 =?us-ascii?Q?xrRcRDpWN9lcTZbNKFUZIMFUeA/MBkN7aT7usmYEHS6U6jDB9F3tcZk/TAlk?=
 =?us-ascii?Q?WPfyJhZu5xsiRqE22Ibt3ntFgBQoOWkfiRKRDHwmQGJtWEjlR1V0BDAKdOzV?=
 =?us-ascii?Q?HbTg+fqQtIubDqh7eXsOHfAaTo+mfEZuomoqjOUaDrftRwaVPZ06i3K9D8vg?=
 =?us-ascii?Q?TnJx3ncqFRIQJgw2rtqKhVRyUfuH?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c533031-1cc1-43a0-55b7-08dea0697411
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 12:19:51.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY0P300MB0530

Drop magic numbers and describe autocorrect config with a mode enum and
an integer delay. This reduces errors when mutating config values and
makes the values easier to access.

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
 autocorrect.c | 46 +++++++++++++++++++++++-----------------------
 autocorrect.h | 20 ++++++++++++++------
 help.c        |  9 +++++----
 3 files changed, 42 insertions(+), 33 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 887d2396da44..2484546fc731 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -6,7 +6,7 @@
 #include "prompt.h"
 #include "gettext.h"
 
-static int parse_autocorrect(const char *value)
+static enum autocorrect_mode parse_autocorrect(const char *value)
 {
 	switch (git_parse_maybe_bool_text(value)) {
 	case 1:
@@ -19,49 +19,49 @@ static int parse_autocorrect(const char *value)
 
 	if (!strcmp(value, "prompt"))
 		return AUTOCORRECT_PROMPT;
-	if (!strcmp(value, "never"))
+	else if (!strcmp(value, "never"))
 		return AUTOCORRECT_NEVER;
-	if (!strcmp(value, "immediate"))
+	else if (!strcmp(value, "immediate"))
 		return AUTOCORRECT_IMMEDIATELY;
-	if (!strcmp(value, "show"))
+	else if (!strcmp(value, "show"))
 		return AUTOCORRECT_SHOW;
-
-	return 0;
+	else
+		return AUTOCORRECT_DELAY;
 }
 
 void autocorrect_resolve_config(const char *var, const char *value,
 				const struct config_context *ctx, void *data)
 {
-	int *out = data;
-	int parsed;
+	struct autocorrect *conf = data;
 
 	if (strcmp(var, "help.autocorrect"))
 		return;
 
-	parsed = parse_autocorrect(value);
+	conf->mode = parse_autocorrect(value);
 
 	/*
 	 * Disable autocorrection prompt in a non-interactive session
 	 */
-	if (parsed == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
-		parsed = AUTOCORRECT_NEVER;
+	if (conf->mode == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
+		conf->mode = AUTOCORRECT_NEVER;
 
-	if (!parsed) {
-		parsed = git_config_int(var, value, ctx->kvi);
-		if (parsed < 0 || parsed == 1)
-			parsed = AUTOCORRECT_IMMEDIATELY;
-	}
+	if (conf->mode == AUTOCORRECT_DELAY) {
+		conf->delay = git_config_int(var, value, ctx->kvi);
 
-	*out = parsed;
+		if (!conf->delay)
+			conf->mode = AUTOCORRECT_SHOW;
+		else if (conf->delay < 0 || conf->delay == 1)
+			conf->mode = AUTOCORRECT_IMMEDIATELY;
+	}
 }
 
-void autocorrect_confirm(int autocorrect, const char *assumed)
+void autocorrect_confirm(struct autocorrect *conf, const char *assumed)
 {
-	if (autocorrect == AUTOCORRECT_IMMEDIATELY) {
+	if (conf->mode == AUTOCORRECT_IMMEDIATELY) {
 		fprintf_ln(stderr,
 			   _("Continuing under the assumption that you meant '%s'."),
 			   assumed);
-	} else if (autocorrect == AUTOCORRECT_PROMPT) {
+	} else if (conf->mode == AUTOCORRECT_PROMPT) {
 		char *answer;
 		struct strbuf msg = STRBUF_INIT;
 
@@ -71,10 +71,10 @@ void autocorrect_confirm(int autocorrect, const char *assumed)
 
 		if (!(starts_with(answer, "y") || starts_with(answer, "Y")))
 			exit(1);
-	} else {
+	} else if (conf->mode == AUTOCORRECT_DELAY) {
 		fprintf_ln(stderr,
 			   _("Continuing in %0.1f seconds, assuming that you meant '%s'."),
-			   (float)autocorrect / 10.0, assumed);
-		sleep_millisec(autocorrect * 100);
+			   conf->delay / 10.0, assumed);
+		sleep_millisec(conf->delay * 100);
 	}
 }
diff --git a/autocorrect.h b/autocorrect.h
index f5fadf9d9605..5506a36f11a7 100644
--- a/autocorrect.h
+++ b/autocorrect.h
@@ -1,16 +1,24 @@
 #ifndef AUTOCORRECT_H
 #define AUTOCORRECT_H
 
-#define AUTOCORRECT_SHOW (-4)
-#define AUTOCORRECT_PROMPT (-3)
-#define AUTOCORRECT_NEVER (-2)
-#define AUTOCORRECT_IMMEDIATELY (-1)
-
 struct config_context;
 
+enum autocorrect_mode {
+	AUTOCORRECT_SHOW,
+	AUTOCORRECT_NEVER,
+	AUTOCORRECT_PROMPT,
+	AUTOCORRECT_IMMEDIATELY,
+	AUTOCORRECT_DELAY,
+};
+
+struct autocorrect {
+	enum autocorrect_mode mode;
+	int delay;
+};
+
 void autocorrect_resolve_config(const char *var, const char *value,
 				const struct config_context *ctx, void *data);
 
-void autocorrect_confirm(int autocorrect, const char *assumed);
+void autocorrect_confirm(struct autocorrect *conf, const char *assumed);
 
 #endif /* AUTOCORRECT_H */
diff --git a/help.c b/help.c
index d2b29715817e..353596c17d82 100644
--- a/help.c
+++ b/help.c
@@ -538,7 +538,7 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 struct help_unknown_cmd_config {
-	int autocorrect;
+	struct autocorrect autocorrect;
 	struct cmdnames aliases;
 };
 
@@ -607,7 +607,7 @@ char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
-	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
+	if (cfg.autocorrect.mode == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
@@ -673,7 +673,8 @@ char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (cfg.autocorrect && cfg.autocorrect != AUTOCORRECT_SHOW && n == 1 &&
+
+	if (cfg.autocorrect.mode != AUTOCORRECT_SHOW && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
@@ -682,7 +683,7 @@ char *help_unknown_cmd(const char *cmd)
 			     "which does not exist."),
 			   cmd);
 
-		autocorrect_confirm(cfg.autocorrect, assumed);
+		autocorrect_confirm(&cfg.autocorrect, assumed);
 
 		cmdnames_release(&cfg.aliases);
 		cmdnames_release(&main_cmds);
-- 
2.53.0

