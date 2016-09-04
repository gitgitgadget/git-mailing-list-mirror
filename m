Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DCE1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:21:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754248AbcIDUU4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:56 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33791 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbcIDUS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:57 -0400
Received: by mail-wm0-f68.google.com with SMTP id w207so10455404wmw.0
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jKY8nIalxIi8TaJVTh3n51cONNUV25ij8X+a635gUQI=;
        b=SM24U7b7siEXm/5UKxZEOZlbqY/vvb242QIU/0YhAVEn0/zbgOm2X4Xg/n6it+aTzH
         eiuPc7KzqU0DjqTQ8E5lSGWxTPUXsKLFJgz4IXV0Kpjl32Eg1BpN7yvUs6eIS645dXs4
         gSpUE++UVyTUbCpqtsslE1wq2jZXmgatdT2dCpH2j/vfIL4zNb42ZtnbayQqBJgSzbGq
         Kr17TrUgtba2c8tVGatOv4iaaV3EPdvQopkwe9SNi728Qfkv6UDee4bcHKCWcny+xSBw
         rqhB17ulrfStCo1geSKD4WdKHsAvYSG61N2pE2dW77Ece5VfECKl0EMtowPmsw86dj76
         HkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jKY8nIalxIi8TaJVTh3n51cONNUV25ij8X+a635gUQI=;
        b=hos7V3w13GtUnZIc7r3Bg35GZvXxYwCXoLCAkUjm7gKKvNj4m1GB75eKtL1uykqmlK
         RNfgUaJwgPJdQ+R9A+/mSbheWpGOC4RkCpJxzypDVvox7TAlWOFtubodsRAtwz+N1M8L
         JZupPHexdaNAIpY+m/wjD3PRI8zYnPLye15ts2YSO/yGLrnRkIBpPWoh/I2a7RzShHrw
         nyVRbqggVvPEvW0VuEuR56OfMAEH7ghfioqImeEt8hfNpG8m14m/YznBzAvooiQzIDAU
         E4H77RH+h/pdEleHzrsNuGaNLEDH038HRCAPuWMG78o1YUlk6oWJJeKD3VRLTFKLrI3N
         5PxA==
X-Gm-Message-State: AE9vXwOeeW4Ok78jZB2d2iQq2wWk9F5X+OnmDCFAraRXrcOoLwSU/ijl2PeCExoHkmispQ==
X-Received: by 10.195.12.163 with SMTP id er3mr30480978wjd.49.1473020335718;
        Sun, 04 Sep 2016 13:18:55 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:55 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v14 08/41] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date:   Sun,  4 Sep 2016 22:18:00 +0200
Message-Id: <20160904201833.21676-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_whitespace_option() should return -1 instead
of calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 10aaba7..06a76f2 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -27,34 +27,34 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static void parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "warn")) {
 		state->ws_error_action = warn_on_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "nowarn")) {
 		state->ws_error_action = nowarn_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "error")) {
 		state->ws_error_action = die_on_ws_error;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "error-all")) {
 		state->ws_error_action = die_on_ws_error;
 		state->squelch_whitespace_errors = 0;
-		return;
+		return 0;
 	}
 	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
 		state->ws_error_action = correct_ws_error;
-		return;
+		return 0;
 	}
-	die(_("unrecognized whitespace option '%s'"), option);
+	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
 static void parse_ignorewhitespace_option(struct apply_state *state,
@@ -4589,7 +4589,8 @@ static int option_parse_whitespace(const struct option *opt,
 {
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
-	parse_whitespace_option(state, arg);
+	if (parse_whitespace_option(state, arg))
+		exit(1);
 	return 0;
 }
 
@@ -4626,8 +4627,8 @@ static void init_apply_state(struct apply_state *state,
 	strbuf_init(&state->root, 0);
 
 	git_apply_config();
-	if (apply_default_whitespace)
-		parse_whitespace_option(state, apply_default_whitespace);
+	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
+		exit(1);
 	if (apply_default_ignorewhitespace)
 		parse_ignorewhitespace_option(state, apply_default_ignorewhitespace);
 }
-- 
2.10.0.41.g9df52c3

