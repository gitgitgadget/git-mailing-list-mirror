Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F34B1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbcG3RoQ (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:44:16 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35260 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbcG3RoH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:44:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so20085243wmg.2
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:44:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YdXjNUdoe7I493wQ0JfZE/79zdlJ5tdfHEyr8jGQ6Vc=;
        b=FaGCBFoRdLJvNsvccyV+mECiTFLX9qRrf2XUQqtrjHXqk9x/lcV+AtAR5X2+Sa/78b
         1JT4WRqGvZfp1QG+UPBlIGyQJDx4FXra9g5zJXGPNxRanOmOwV2CQsTr/HA7lA2b1yIJ
         n038POV1cHniP20mDddEkClX3YoJf+a8gpzgjxRumjNgiqhmAFPfu2A0nDMOFaxzv5VU
         9VLvPkSbiUJZnjc/DUMbk8TXS6b3DzV1mpwC6WsO+82GbhfdykRUsXRyy/uhwnHoAUJJ
         CuU/AwEJ3v55vPv2DQLdg4+gPgXe+KhR/ZsRhVpJjx4Rfk1mEaAnWTrSF1a/P1AOhKk5
         9opA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YdXjNUdoe7I493wQ0JfZE/79zdlJ5tdfHEyr8jGQ6Vc=;
        b=Fnye3MQkgyFZDBXxyd3WnraaLBHKnH/amtYg+6ZeheW3KttA0TPWK2Gx4NctJAdUBJ
         2+PuQ/Tnzqrrex7k/YGmPtXef1sixw1Etc7HJYl0k9AjN/v4mjEhOHBTQgWdmpxwCkYf
         wldTJSxZKBEragIb6ee6khWC59NPtTSNU1V17471+Cq0Z3L/GaOdP8hBVTDk8A8XUpoW
         glzLlmyztMAynL0fOWKvWwhL6MxaXw/HLkB+OIqxK2pet+T+UV/fSeMtnkMaMZDO9MND
         b5BsE6t359WKMmbGrWhYtdqW24uWLQ0pvGjEhFdKQeKHQRNMJJzrDCr1ER1OGT2aHX7G
         ARjQ==
X-Gm-Message-State: AEkoouvBohnP0PfDhNGyRdzIGVCCoNr6BMeCdME8l+FErf/xMotszN6Q3oIGT6nO10G4NA==
X-Received: by 10.194.149.176 with SMTP id ub16mr43556408wjb.54.1469899535702;
        Sat, 30 Jul 2016 10:25:35 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:35 -0700 (PDT)
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
Subject: [PATCH v9 08/41] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date:	Sat, 30 Jul 2016 19:24:36 +0200
Message-Id: <20160730172509.22939-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
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
index 9939a83..be32dfd 100644
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
2.9.2.558.gf53e569

