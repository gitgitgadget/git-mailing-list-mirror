Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1822018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbcHHVEU (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36085 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbcHHVEN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id i138so316647wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iPe2jtf6hcqwNM//jjfiqOUJ2p5X4e68I4jkFyLQwa4=;
        b=DLDfBECeUWFvIfUhi42NEBlNvE22msSrDlIGCv+y954lSlOqVGcm8c4Po/gleK9O6B
         EIneRPcLsrRSa0eHCsnxhrVVlLOrUjJbeoJSGgULGCEylD+5wkGkzI5weDPP78wbMlbk
         EYjiBUAvRb9xGLwVto4KCL9GoqbjVjXb+q8LYVcUXC7vpaCHpDbGcfjBYuirWRPqngdX
         U8yH6FJIPuFjqmNv8CuKJwOPn4ORvTZPeuLlaAHnc50luf7vGTB68totRUK+IrVLiGFQ
         XgDSen3GAI54IcF8eQEayFNQ5dgY7Q4ABQWqbSlfekwLWoOIbs5YYk0D2KNqbOveivkF
         krxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iPe2jtf6hcqwNM//jjfiqOUJ2p5X4e68I4jkFyLQwa4=;
        b=k4zq9ziJpT763nRchS24B3yj8unF5IuxIIse2ZSRNru8piYgUrsLZOvyHnojwtoRe8
         fc9aWt9CXojGFYleRnL1FSsV99417A1k5NaY2nxlEtRjrQCBBjIpakPQ1RnGH6Sd+CB7
         s5CKHvjy6CeocFQP/EsX5B/GilQY/ekIitk3JbqIj2jMrkY0cH/Oe3Rcy74oCYz5lffP
         OeXjaMDC1kFgbA8QiIY/+WvmjOyUfSEpBW9TlzI7S3Q1XA1+/IflGR6B1z3dGdIqx0Gc
         35Ck/qNZL6BrfSr8SJzuV6bQj5dHRSj3DETpvlns4DJMcMGQSr83c95PkTe3AbUwZwU0
         SdMQ==
X-Gm-Message-State: AEkoouuHRIiDloUnNf9JOlO4iZdaQxPrvfvHtjx7amo+AmusMxmKFCbN28hE131/2rpEQg==
X-Received: by 10.28.48.202 with SMTP id w193mr18425122wmw.54.1470690247171;
        Mon, 08 Aug 2016 14:04:07 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:06 -0700 (PDT)
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
Subject: [PATCH v10 11/40] apply: make init_apply_state() return -1 instead of exit()ing
Date:	Mon,  8 Aug 2016 23:03:08 +0200
Message-Id: <20160808210337.5038-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of exit()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", init_apply_state() should return -1 instead of
calling exit().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c         | 11 ++++++-----
 apply.h         |  6 +++---
 builtin/apply.c |  3 ++-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/apply.c b/apply.c
index c858ca4..6e0e992 100644
--- a/apply.c
+++ b/apply.c
@@ -55,9 +55,9 @@ int parse_ignorewhitespace_option(struct apply_state *state,
 	return error(_("unrecognized whitespace ignore option '%s'"), option);
 }
 
-void init_apply_state(struct apply_state *state,
-		      const char *prefix,
-		      struct lock_file *lock_file)
+int init_apply_state(struct apply_state *state,
+		     const char *prefix,
+		     struct lock_file *lock_file)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
@@ -79,9 +79,10 @@ void init_apply_state(struct apply_state *state,
 
 	git_apply_config();
 	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
+		return -1;
 	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
+		return -1;
+	return 0;
 }
 
 void clear_apply_state(struct apply_state *state)
diff --git a/apply.h b/apply.h
index 08c0a25..e18a18a 100644
--- a/apply.h
+++ b/apply.h
@@ -102,9 +102,9 @@ extern int parse_whitespace_option(struct apply_state *state,
 extern int parse_ignorewhitespace_option(struct apply_state *state,
 					 const char *option);
 
-extern void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file);
+extern int init_apply_state(struct apply_state *state,
+			    const char *prefix,
+			    struct lock_file *lock_file);
 extern void clear_apply_state(struct apply_state *state);
 
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index bb6ff77..61fd316 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4741,7 +4741,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	init_apply_state(&state, prefix, &lock_file);
+	if (init_apply_state(&state, prefix, &lock_file))
+		exit(128);
 
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
-- 
2.9.2.614.g4980f51

