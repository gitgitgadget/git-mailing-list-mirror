Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0784220193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbcHHVFR (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:17 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36498 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbcHHVE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:59 -0400
Received: by mail-wm0-f65.google.com with SMTP id i138so320117wmf.3
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Kc7tPbEk5hsrrgXhC1dSpeek0BULLMO6tIRXwWpYtj8=;
        b=jttTis6O5Ka5oYgl6NNQCUa6DcOfG5/5tlo/3cU/abUbBaMdf2ypSpaXQi+CxSejb9
         yhcmB79gMPetswIJrLQUu8YHyDPZhkX21eqbAuP52Qlr9fKaylLfYC1q9cmft8amOJln
         /L+sLj4fz8NwFAkCYazX5uSEnTlOxAklCmoVfUyE3UADpdSbew1nu1oy/6cR6gbDG1mk
         Dx/KCjCXH9OxUINkM90j2dcM+96IDENjkJbGOUKCRwIzvWka19cT70jlVkqlUEgtipjK
         d4QnxQullz+iPPh5UwQvzEtfJeYKej5vzsx0AGbDg4AkpjBXIzeqevQ1J0LUhUSzMBfn
         OpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Kc7tPbEk5hsrrgXhC1dSpeek0BULLMO6tIRXwWpYtj8=;
        b=OZ1HAzdeGj1Bd7qBT/slYQ/gSjjpX+BVvu8Z6Mm5d06aYkrKL6dEqmKBkrmj8ANnRw
         igxkSbfU/S8wD4RdR+R14rBMvyG3sOtRiEZ9NIXusOLRWesWXSj7enBAGdzmjYTdaiw5
         p5RLDEtnIC1kUKktAU22HML/RVvAkcB8OlT4TE3kUm3wE/bDK7Vfq7xJIhHYhsnt51Z2
         SUvb0Ex8Rr8xUNS4LwUl0w0sFc85ae0SmRPbENxyh28jgHT9qkEtxriVMwFtIlCXJDt3
         xjDzTf94G5UMycjmTDZldXm7rJ1jj4I+MinNUbpRPY10Zp1mNHnhgJqvNNQTYzEGf21o
         gCmQ==
X-Gm-Message-State: AEkoouuslPfx87mgYf2yZ/q2fDikjur/dw4JpcQgZiQY2ZrB7OKLxo7s9zY/fanPNPCjXw==
X-Received: by 10.194.95.105 with SMTP id dj9mr85448746wjb.20.1470690293409;
        Mon, 08 Aug 2016 14:04:53 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:52 -0700 (PDT)
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
Subject: [PATCH v10 38/40] apply: change error_routine when silent
Date:	Mon,  8 Aug 2016 23:03:35 +0200
Message-Id: <20160808210337.5038-39-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To avoid printing anything when applying with
`state->apply_verbosity == verbosity_silent`, let's save the
existing warn and error routines before applying, and let's
replace them with a routine that does nothing.

Then after applying, let's restore the saved routines.

Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 21 ++++++++++++++++++++-
 apply.h |  8 ++++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index ddbb0a2..bf81b70 100644
--- a/apply.c
+++ b/apply.c
@@ -112,6 +112,11 @@ void clear_apply_state(struct apply_state *state)
 	/* &state->fn_table is cleared at the end of apply_patch() */
 }
 
+static void mute_routine(const char *bla, va_list params)
+{
+	/* do nothing */
+}
+
 int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
@@ -144,6 +149,13 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	if (!state->lock_file)
 		return error("BUG: state->lock_file should not be NULL");
 
+	if (state->apply_verbosity <= verbosity_silent) {
+		state->saved_error_routine = get_error_routine();
+		state->saved_warn_routine = get_warn_routine();
+		set_error_routine(mute_routine);
+		set_warn_routine(mute_routine);
+	}
+
 	return 0;
 }
 
@@ -4864,7 +4876,7 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
-	return !!errs;
+	res = !!errs;
 
 end:
 	if (state->newfd >= 0) {
@@ -4872,5 +4884,12 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
+	if (state->apply_verbosity <= verbosity_silent) {
+		set_error_routine(state->saved_error_routine);
+		set_warn_routine(state->saved_warn_routine);
+	}
+
+	if (res > -1)
+		return res;
 	return (res == -1 ? 1 : 128);
 }
diff --git a/apply.h b/apply.h
index bd4eb6d..5cde641 100644
--- a/apply.h
+++ b/apply.h
@@ -94,6 +94,14 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	/*
+	 * This is to save reporting routines before using
+	 * set_error_routine() or set_warn_routine() to install muting
+	 * routines when in verbosity_silent mode.
+	 */
+	void (*saved_error_routine)(const char *err, va_list params);
+	void (*saved_warn_routine)(const char *warn, va_list params);
+
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
 	enum apply_ws_ignore ws_ignore_action;
-- 
2.9.2.614.g4980f51

