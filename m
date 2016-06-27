Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51B882018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbcF0S0p (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:45 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36222 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbcF0SZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:17 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so26936636wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:04 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=S5yUbfK2YLRFEB6RcVMauUdFbzDCvEHA+HyVSUROHc4=;
        b=AohKP8Thzl6a9XCAR3aRHWQuZrJ+9WuDrgc+JMcQ0VZk4D9nAAZHV8W/0rn0dWgsg/
         XFN7UcTxxGBZtrJHLYL+2COrT7My5AI9pd2tsHS6p7RTKsaBtLT9YHKFRmKXRKApJak1
         UF9C5R8j1IxQmeG+tmZELuV8gzclDk9ujg2Glh+IbyyzsfY1Tod3OVIjZbcUcaEQE0Jb
         67hyG1I7X6W2CLjnD1RZBLF8t3jUNwEI2HK+LljnJnIMpVq166fwj6xvCG5Ji0EMayDQ
         y9xB/1nO3ZsgcGnuI0dzlIZ0b82dTMIQzb9/zY8aMDARjs42kbs2d2fict5BJWWmUs0q
         NmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=S5yUbfK2YLRFEB6RcVMauUdFbzDCvEHA+HyVSUROHc4=;
        b=hJzgVHh954xvscrZNp4z7iTcJ4fqqFlSOIUsyWBuZTf/+E4DI5eQ12ij43oH12BIzU
         p7swE3KcNVWQIY/gcogbnVgaHCPN2E2jjZMN1o+E7ol7u0EyF+A8hT9zL4Mw/4J9J2Bp
         xe/ghdl1NOxsd9Q4ti/8TIh9YXPx3GWvEPDpHWe+D/8H/+4oXQMEsAfJVUfO8yC1iCVi
         iOCiUfmdtJ4lWfR+/Sjgs7/FIcnKg/6AYtbN23OTljCJb2Ytjs0MJ9ZidqBuxXyvKicW
         pl47rAek6xihWQ2kaap0QN9OKRqpozBlSnh1dlRgOIvKA49dFeOwXNWoNj6o/1sJ1lqx
         JEPw==
X-Gm-Message-State: ALyK8tJxrQuJzQsANH6vvAmCPEJ+cIkef5PkiN7munA8hRKcdPbMAK7rUYmELmSTmSmdJA==
X-Received: by 10.194.97.201 with SMTP id ec9mr2083422wjb.117.1467051901956;
        Mon, 27 Jun 2016 11:25:01 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:01 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 08/41] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date:	Mon, 27 Jun 2016 20:23:56 +0200
Message-Id: <20160627182429.31550-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
index 65927f1..40e8397 100644
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
 
@@ -4623,8 +4624,8 @@ static void init_apply_state(struct apply_state *state,
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
2.9.0.172.gfb57a78

