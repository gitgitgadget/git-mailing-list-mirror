Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998EB2018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbcF0S0j (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35318 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcF0SZU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id a66so26928893wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iWxAkSLK76cyYYrT5kB5tbR1cXEDAV83jKyzdf+Qcdw=;
        b=EGl1Etm+luVquHZMN0FfBTdOslo1ZpiCO6HA3/PcWnMt9q0cj7KRtoUOIt20xUxtT+
         4bkWsPNYjB2GdPni2/TRWhGR3pS5nocCTnbH3R6MsTAF5riG4U3mteqnItB7WbsEkrar
         o2nq9rm7u8ZMfirJWEWns/WpFA7bgWkXrDNIwphRG4rJnSLLgbHrlYzM2nz8k4ZeRfZw
         98jtYUce/mbXE85a27nAEc8GJYSAuzWbENqS5RoTyXCwU3rfjRiIHY8pc89j2LOfJFqB
         g52tSePiiWAglFSMK96mrafCugJoHmqaUn17ifyjkpNvqHvY71dqvM+mgGBPMOcJBhj6
         De6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iWxAkSLK76cyYYrT5kB5tbR1cXEDAV83jKyzdf+Qcdw=;
        b=WPeS1B055KRDPYrsDAJvvkGw5m27D1q8cPwMe8lh4yhpVkRAjOKh8eK4iv3w6gNdSE
         vvsTzaitpqsEC+CxZY5pw4B2RhpaQbsLHlklnSXiJCrvJLgP/6gxjY0+86k9iWO2cxZG
         Yj7uhbV+fj2CMmpbPOEw//G0MzASInwgJoTdmy1Hzvsq8MItMbTGVRIJpQRGJMVj0QaS
         r5ywHjKHUg8sMJZtLBtFxNJxlb092KyVzKQixNl/+6ohHYoeBruYVWtT9Kx9KkI2HYEW
         9oHyjYgStV9pG/dN5KdgPssCGRzyGrnWhkG90yFfHhj0IaDEv2uSIFffo7gLTVv+0Lyh
         aG/Q==
X-Gm-Message-State: ALyK8tItozhCR337IiL0pPfV3ZvnddQNOoxUqSClC5s5CYJxYytF3dLjnPHnBOUQUS0hnA==
X-Received: by 10.28.60.5 with SMTP id j5mr12492702wma.26.1467051905959;
        Mon, 27 Jun 2016 11:25:05 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:05 -0700 (PDT)
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
Subject: [PATCH v8 11/41] apply: make init_apply_state() return -1 instead of exit()ing
Date:	Mon, 27 Jun 2016 20:23:59 +0200
Message-Id: <20160627182429.31550-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
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
index 1f31bb4..c5a9ee2 100644
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
@@ -76,9 +76,10 @@ void init_apply_state(struct apply_state *state,
 
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
index 4fbd993..2a4a9d1 100644
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
2.9.0.172.gfb57a78

