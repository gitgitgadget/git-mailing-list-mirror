Received: from MEUPR01CU001.outbound.protection.outlook.com (mail-australiasoutheastazolkn19010001.outbound.protection.outlook.com [52.103.73.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DDD388E62
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 11:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.73.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142889; cv=fail; b=nT8L+M0IudrAxndffyIS6ZsZ1f/nkluc3Wi2PRDofZHlAadnfSksnGDYsqJd/x6RucOYRtjS/mmOPLGo0XP/tMpsofYHQvPYbznHVKxsNx22ou5uUaZ/UwhN5oGFsMxWv/m/0o8W0Hp4W1M3r/NRdhQprEmsiISpa/cstsHbLgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142889; c=relaxed/simple;
	bh=dqIDnBdPO6+DTk9u2KJXvKPoM20lAzouPAf3i6Kqikk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LiCxudTjhRm3K6fXjUfFfhootVkDEMwtE9A2VKP0V/yGFX1PFdYq2FewhQc9y2IUEHK8fa/e8dtHm/L1hejFFqYOnC/E2jJzb8fMT4wGFkcp/jiPLTv3lqLeSv6QhYcOR1DZvE3xfdpUQ0MrR0FluUQXjHlPQpO+qXvzNouF9s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ipoBOOmw; arc=fail smtp.client-ip=52.103.73.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=barroit.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ipoBOOmw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyVoGFtGp7IkUCKSLv0XPLl4CsJRKhn1u5sjAK1HaTnk0Ubvp0M/jZ9Husj35leTe3RtlraooTkb9S6ClNWu2iZrIN9FFL39H0KgKVpE6S+W7G1VTPKIkt52fY5Dy073OGmt3w1q0N5Ul/rCPrpwPDcobYq/8S78pQfa7HMxi/tOkEHuYchImTaHnkkdHlk48+d6q237Jl5TVfzj9O/ublcNNy0q46TSddnEaFDwiRYhC4AvHWtPZiCnyXdwqX8z2z+X4odS4E00XTHRh0h9EpXhUHuUgA6ZF2E/KsP1e+DACs0fthOGH1nvn6XaOpZnGvyhw2buALl35kcVoSkydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YPRi/DbKCcJdniBErs1aKUPvLl4Sxmm6qMpOWEcicw=;
 b=rPncrUb9uk6UaRV8sY9SqZxli6+Ki/ppX+tb/83DqwH4tYmsirZ4dSJ8XVqJo3OgrvCZuv5gcxJKR8JOYDJ0Pxy3eJV59OqlREFp3HXHFiI0KcbUPcdCHldIecRi7nvj8XMnDMr0ApUjPtCrflGRjvXXqs8IKOSbq/sfOQsx/6YkqH3PboE0TyTJ3R0g6QQmCTAfr1As8pV7p2LvWFck1JFkJnOfK59RZyOZ58VeNI4lzutD9AlucjcaflK+N1tSsmaWv1lKS44okAWvReiqPxBGqQJrkhDD/QSomewUFEK7UExFUIftEer0x/9gA3SJ0jKvyTF8/f4CzzrTCXMUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YPRi/DbKCcJdniBErs1aKUPvLl4Sxmm6qMpOWEcicw=;
 b=ipoBOOmwKXNWUnLubIdlNKzCYs8ZvTMm4eAwhFHrbpTF2KygUfIVBq+6NkCRaDOrANktAkBzjZFvUVkT2heL7qKRyibuJ74LV14KC3G2vW8BvlyzcpR9QP8sHOHhhlr41vmhj6XeNGSvjrxWuIsJiHCI3ov9oRIauKTfzBmVVjknqMrhNmZVBihVSeBbd8krMG+XrtIL664ON9VW/HuI+6zbhtcAPvuA9wbuWREgX57jqkIZLvxBIiEnkS8wbqIU+y4VyxqtN+cLshrsWbaPEaCllUh2t6/O8njJxttkj0BmUtuoCT7FqwxFn8qML8vwjiQTB5rqQgxKEcjpMdUjoA==
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:27f::21)
 by SY7P300MB1392.AUSP300.PROD.OUTLOOK.COM (2603:10c6:10:2c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 11:41:21 +0000
Received: from SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a]) by SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 ([fe80::68d9:aadc:5a52:bb7a%6]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 11:41:21 +0000
From: Jiamu Sun <39@barroit.sh>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jiamu Sun <39@barroit.sh>
Subject: [PATCH v3 3/8] help: move tty check for autocorrection to autocorrect.c
Date: Tue, 10 Mar 2026 20:41:02 +0900
Message-ID:
 <SY0P300MB0801E98F538F5320E7B663F0CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
 <SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:27f::21)
X-Microsoft-Original-Message-ID: <20260310114107.1086103-4-39@barroit.sh>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: Jiamu Sun <sunjiamu@outlook.com>
X-MS-Exchange-MessageSentRepresentingType: 2
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SY0P300MB0801:EE_|SY7P300MB1392:EE_
X-MS-Office365-Filtering-Correlation-Id: 10fb1a5d-b940-4f28-abb0-08de7e99f345
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|51005399006|19110799012|8060799015|12121999013|41001999006|25031999004|23021999003|15080799012|440099028|3412199025|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ghLUildp6aG/bWxswEc6gWSUboF0kGi70GzP9ictqK5LkHjZczg4lwUvq+Ag?=
 =?us-ascii?Q?H0RHFe7kqr9XsKft8FQdQrdrCchnmxFNifoI1ptpKbbTEuufmyxgKDGivxjh?=
 =?us-ascii?Q?kY+2Wk/shGS2mny6DtUGptdtUuW9cu396g+KgZds1PbbmKilGkc0uajTNNkK?=
 =?us-ascii?Q?GZot/PcaEpmijRT8b0hVowiCxliGPV4TnKTw0BzgcsFzX5HOtTHo1Bs+f0fe?=
 =?us-ascii?Q?F+9Gpm7JnnkPYhyL3oDZUXkoLb/nvAvf0Lrxuf/YLaSS018HLDlJ7YgHrsr8?=
 =?us-ascii?Q?yEHyCaIzjI7yyMR3MlwUiHn/b9reVjTlHnjTv/QjITuJYY1lRmeC8aRIT5pj?=
 =?us-ascii?Q?/YLlROZJqGzbf6emCH40jhlAe8/rvJiyfspLkXSylYNQxOBhhD+ttDYq5+Rx?=
 =?us-ascii?Q?Emgmz8hA7NZc/BqFalwZwqviMPQi7F3bt5MchYiT2MbRyU5Tz4/FR5pIvWWA?=
 =?us-ascii?Q?8dxTun4qt0D1FWfwTz8BwZ42fWFQqzKYdJQ+qLRzyWmSO9pxKlexeQcn/rn3?=
 =?us-ascii?Q?aNFwVqmxAIFwUAqhsB38ajVI5tc64Y0lucYd1N3omuOQtn4MrbBWorXZLR8R?=
 =?us-ascii?Q?0oD2tS/Sa82xQ+ouYEWmk3XTWcPI8MbItAh/MPp9vW+20YWJ4MT8FrksyRJW?=
 =?us-ascii?Q?VdFiy2b3Wjiv+SURjniuMvL5S0MLCIa/0klcvqsU69TEb5yj7IwbBKPjGfdg?=
 =?us-ascii?Q?zdux0NsMUuDwSTNXuLqvlP1McLDOFySckE5DIh1RK8AN1OHa/Ts0o1Q6GRrH?=
 =?us-ascii?Q?0wgGfNmqNwij16wS866N+T6gLf+KrqMfe2AY0XjHsrs9TUfj0miatFf9DL9w?=
 =?us-ascii?Q?4KfxTUndxzYcIt8YLOzwikFG1y7ua118RCFa/xl7A1byrC1i0MUqbV0pN9EV?=
 =?us-ascii?Q?lN3yMhNIx0VkxkoFVVL45mPyel+dkvfTKSrSc3+4k5ni1sqVHWvW1+zXHU/V?=
 =?us-ascii?Q?vUKqnycuyFebBRWTibvmu2DTjpKPM4JdAaPpdN60/kQI4g1YQCGQ02kUZ2d/?=
 =?us-ascii?Q?9UJrSToPlOxYqH8Q3MFOYpl2/g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QDD1N1+SNOPwEe7ugk+WEXDxticawxlwtIbqYSFNPKXy6fpaTtoq/FuvfcXC?=
 =?us-ascii?Q?JPnm/fMHyI+zH/IA989OaAC2U/iZn8jHwqLvTpIE+0QsFQos4rT6qO7PwUvN?=
 =?us-ascii?Q?1cUxbubk2AZEcxJ+zJGwtlk1KGIX5y5HaV61RuoHhEP6uT5vC0OMQghGtDMQ?=
 =?us-ascii?Q?kRejR2huKySUhTs107aQ9D9porh294+C7kZHwWS2JNWnZR7//h2upvdU4oIi?=
 =?us-ascii?Q?FhsILrJuS9YFaeuKCNSZLTqZQpi6PzPbkx1fiIHKOEE1ugmDhdZEEwyP49t/?=
 =?us-ascii?Q?FPf3qAf1RXpXathIMFadptNCODe7FZD4rkizxZ6cB5WG0qOdzDYicROxtbkF?=
 =?us-ascii?Q?+49ePOYVpj6WDHb1siCvRV4lDcEYCyTBsWjywlrwydYnvU5CsAzmogPOxMhy?=
 =?us-ascii?Q?3HGEK56VCgQfED9Avl3gfHkhpRNdMMaQhPGV0s0qL9vWP6py2wDYI0XRS1RE?=
 =?us-ascii?Q?SXtsygBXO5rOJe6XIS0r8xwaVKXeusF63pochD2xiSI/PO7Kjk6UFdISKQ8L?=
 =?us-ascii?Q?9A/CDTanJTVbytSiXGD6cJJPZ+wJZMcx+lM0+/9GobrkDVUh6rRp+bK6VX8b?=
 =?us-ascii?Q?r5yOQj8lWjOJx3n7fJyK3ddLl8vK30fgP9hUL5ozk/U8LsK4hEOrLVaOzjKm?=
 =?us-ascii?Q?YgR/w1aP1TtYdXbdvOb0HXOfv1fEbxfkNPuqSHw43rC0BKMC6CSsGJkP06Qu?=
 =?us-ascii?Q?BPFcc8ffZeE5Dp5n99UQYXM6hDLBPbKiK1aIPOzMY3tPvZaWQqZ4jovyg+U6?=
 =?us-ascii?Q?Wdq70LiKetwZRCqrBP9AhZWfY3IXF40A5rluyqrGpu+2TUUI3h8P+3/LEKk4?=
 =?us-ascii?Q?YK6Msx3opW+Hvj4DojhcceuW6zurcFsE8eL+Hz1Vs7Tnhb1fCVcUgGx3YPHL?=
 =?us-ascii?Q?xe4VSCs1A350ly/S4pzt6QEOXelbQyNE6gCU87B+dnNT8cw34VL6n+JLX2Nt?=
 =?us-ascii?Q?ogXlt82wtjiTFJS3SXHd39yNMK94srqmWz4/DEbP3Qg6PunKkIju1ZGMUrne?=
 =?us-ascii?Q?ZvrY/64etbY59QoPVPotPLLsNZTDgHrcBRnCCuHFYtIPy93CaaxzUhuFdvx1?=
 =?us-ascii?Q?fPj0p+u1sJ1byrSE1yXz2e1XOoZdmcoC1FwKHfH578+2AeXSdeS1n5u9yyER?=
 =?us-ascii?Q?4qX+zymxaZg8QwcuHU9o1uIS7Hhb6rbo8HucPXb8/guCUClfhZWrv1j9YlXy?=
 =?us-ascii?Q?FtOzgD1tm+SAmm8DDDYAIijfwqfd20F23tw4PNiEb/e535iS1z/ivpOMQPXM?=
 =?us-ascii?Q?Tn8hgmJ72rYk9fcpr0vuX9i/FTvdy31eRZNpUl9cZM2ENX3kqPday9PD9rZt?=
 =?us-ascii?Q?fclF1RnqCQoQ8Sr12ew2izrC7nUflTf758lTzgIV7Pd0QtrzywTT/QlK5f5H?=
 =?us-ascii?Q?MwFGty+jKcguKcl7r2xyVtawJNG/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10fb1a5d-b940-4f28-abb0-08de7e99f345
X-MS-Exchange-CrossTenant-AuthSource: SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 11:41:21.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P300MB1392

TTY checking is the autocorrect config parser's responsibility. It must
ensure the parsed value is correct and reliable. Thus, move the check to
autocorr_resolve_config().

Signed-off-by: Jiamu Sun <39@barroit.sh>
---
In parse_autocorrect() I kept the if/else if cascade. In my opinion,
this is not a style change. It's a control-flow clarification, because
those returns describe different states of the mode. Chaining them
together is better than leaving them discrete.

Also, I dropped the float cast in the delay calculation, which is
redundant.

 autocorrect.c | 50 +++++++++++++++++++++++++++++---------------------
 autocorrect.h | 20 ++++++++++++++------
 help.c        | 17 ++++++-----------
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/autocorrect.c b/autocorrect.c
index 1037f032019b..50d7f116d85d 100644
--- a/autocorrect.c
+++ b/autocorrect.c
@@ -6,7 +6,7 @@
 #include "prompt.h"
 #include "gettext.h"
 
-static int parse_autocorrect(const char *value)
+static enum autocorr_mode parse_autocorrect(const char *value)
 {
 	switch (git_parse_maybe_bool_text(value)) {
 		case 1:
@@ -19,41 +19,49 @@ static int parse_autocorrect(const char *value)
 
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
 
 void autocorr_resolve_config(const char *var, const char *value,
 			     const struct config_context *ctx, void *data)
 {
-	int *out = data;
+	struct autocorr *conf = data;
+
+	if (strcmp(var, "help.autocorrect"))
+		return;
+
+	conf->mode = parse_autocorrect(value);
 
-	if (!strcmp(var, "help.autocorrect")) {
-		int v = parse_autocorrect(value);
+	/*
+	 * Disable autocorrection prompt in a non-interactive session.
+	 */
+	if (conf->mode == AUTOCORRECT_PROMPT && (!isatty(0) || !isatty(2)))
+		conf->mode = AUTOCORRECT_NEVER;
 
-		if (!v) {
-			v = git_config_int(var, value, ctx->kvi);
-			if (v < 0 || v == 1)
-				v = AUTOCORRECT_IMMEDIATELY;
-		}
+	if (conf->mode == AUTOCORRECT_DELAY) {
+		conf->delay = git_config_int(var, value, ctx->kvi);
 
-		*out = v;
+		if (!conf->delay)
+			conf->mode = AUTOCORRECT_SHOW;
+		else if (conf->delay <= 1)
+			conf->mode = AUTOCORRECT_IMMEDIATELY;
 	}
 }
 
-void autocorr_confirm(int autocorrect, const char *assumed)
+void autocorr_confirm(struct autocorr *conf, const char *assumed)
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
 
@@ -63,10 +71,10 @@ void autocorr_confirm(int autocorrect, const char *assumed)
 
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
index 45609990c77e..ce4a68379f2f 100644
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
 
+enum autocorr_mode {
+	AUTOCORRECT_SHOW,
+	AUTOCORRECT_NEVER,
+	AUTOCORRECT_PROMPT,
+	AUTOCORRECT_IMMEDIATELY,
+	AUTOCORRECT_DELAY,
+};
+
+struct autocorr {
+	enum autocorr_mode mode;
+	int delay;
+};
+
 void autocorr_resolve_config(const char *var, const char *value,
 			     const struct config_context *ctx, void *data);
 
-void autocorr_confirm(int autocorr, const char *assumed);
+void autocorr_confirm(struct autocorr *conf, const char *assumed);
 
 #endif /* AUTOCORRECT_H */
diff --git a/help.c b/help.c
index 6be3ec9dfb12..566d33299b9a 100644
--- a/help.c
+++ b/help.c
@@ -538,7 +538,7 @@ int is_in_cmdlist(struct cmdnames *c, const char *s)
 }
 
 struct help_unknown_cmd_config {
-	int autocorrect;
+	struct autocorr autocorr;
 	struct cmdnames aliases;
 };
 
@@ -550,7 +550,7 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	const char *subsection, *key;
 	size_t subsection_len;
 
-	autocorr_resolve_config(var, value, ctx, &cfg->autocorrect);
+	autocorr_resolve_config(var, value, ctx, &cfg->autocorr);
 
 	/* Also use aliases for command lookup */
 	if (!parse_config_key(var, "alias", &subsection, &subsection_len,
@@ -607,13 +607,7 @@ char *help_unknown_cmd(const char *cmd)
 
 	read_early_config(the_repository, git_unknown_cmd_config, &cfg);
 
-	/*
-	 * Disable autocorrection prompt in a non-interactive session
-	 */
-	if ((cfg.autocorrect == AUTOCORRECT_PROMPT) && (!isatty(0) || !isatty(2)))
-		cfg.autocorrect = AUTOCORRECT_NEVER;
-
-	if (cfg.autocorrect == AUTOCORRECT_NEVER) {
+	if (cfg.autocorr.mode == AUTOCORRECT_NEVER) {
 		fprintf_ln(stderr, _("git: '%s' is not a git command. See 'git --help'."), cmd);
 		exit(1);
 	}
@@ -679,7 +673,8 @@ char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (cfg.autocorrect && cfg.autocorrect != AUTOCORRECT_SHOW && n == 1 &&
+
+	if (cfg.autocorr.mode != AUTOCORRECT_SHOW && n == 1 &&
 	    SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
@@ -688,7 +683,7 @@ char *help_unknown_cmd(const char *cmd)
 			     "which does not exist."),
 			   cmd);
 
-		autocorr_confirm(cfg.autocorrect, assumed);
+		autocorr_confirm(&cfg.autocorr, assumed);
 
 		cmdnames_release(&cfg.aliases);
 		cmdnames_release(&main_cmds);
-- 
2.53.0

