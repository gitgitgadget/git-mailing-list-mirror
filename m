Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD642018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbcHHVFc (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:32 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35714 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbcHHVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:04 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so17865313wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2og5v4fEQDksGq5SqiE2qpKg3CQGCEGJPj3zV/WzZiY=;
        b=UVZk3/5xw8gWeYCKm4zPCygE9eV1u7W2BLuR+EYOQj69SKsmTfAvodMHclBmIEx5X6
         DgdD41XeZgPyUGXfkpQlUPahxzc5WbhWdK+9Ww4yYIzWl4Afm/dZr67b9gvz53j+3GYA
         VYwY26jvPyaNOST6iGB+9LVpImMyahAqd0mV0aTEKkhQT/bXDrbvQmghIO/AOTNBP4IL
         9F/ax7bsXMUkL/XTjyGty/PebXh32mPcgDr6wajV0rFsUu90kYUxXAeOdA61+U6rSTbz
         19LsaHc/4C25ucWDP6faM1D88CggKUShtnUc5fhCeo5C4VxfzYNh1wVa91XYXL9r+DTO
         2Fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2og5v4fEQDksGq5SqiE2qpKg3CQGCEGJPj3zV/WzZiY=;
        b=hGqvPv5a9mbfB+cTGZSqWtRgo9hBtU9lUeJQ4vqF271iOI6Jsqc9g4EgaN264Xb1yk
         27DLpB/JvSKL2lWz175Y7sL7LihYTL8+p4e577D9sc8sbXqkYGHI0BHf/TvI5iUAOhAy
         Ox1f02Lx63NElxlW55zXLJL9xSjJQJ5QK0qchSbxnRnDsMHFA0oTfMr0+gUANYSlBaPG
         8fYnhcbuZb025iX5XweMnMZyDSTRSyDxdNKVVQ/tlcjyppaXa7oBwBwss4qgEKLZYE1n
         7qVOgbo2oYFsE1/UnmijeLfuRk1fOQrZHYwGufT/j4nYRBSqmmAuO+tW5lfN3hZg5US8
         uSiA==
X-Gm-Message-State: AEkoouv27kVe/9DsgjPB9qRCZf2KBbh68rb5Nxl8mjmDPVr939vqn8H99AcowCkFiSb8sw==
X-Received: by 10.28.208.140 with SMTP id h134mr19144954wmg.101.1470690243107;
        Mon, 08 Aug 2016 14:04:03 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:02 -0700 (PDT)
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
Subject: [PATCH v10 08/40] builtin/apply: make parse_whitespace_option() return -1 instead of die()ing
Date:	Mon,  8 Aug 2016 23:03:05 +0200
Message-Id: <20160808210337.5038-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
2.9.2.614.g4980f51

