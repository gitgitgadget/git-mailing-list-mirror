Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA381F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755066AbcH0Sqd (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36248 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754890AbcH0SqL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:11 -0400
Received: by mail-it0-f65.google.com with SMTP id x131so2923962ite.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YfzLGWtJGt16N5+Az8BALSQsdT3q7eKGBeOmGw6SJ3g=;
        b=Brmkkscsr6UOsA5Xsezuq26t2Yl59M3w6NQ4b2UFkkE9ohVIk4FYz2PRcAp1V5NxsB
         mCn9hyIuLIacuIvcRIUcgkqy3MJVDlSEqUKcqde/loDK4Np9u9MuH1JQh+yGCvtqoqbf
         TMvAqHnAAEEd86GOL8tubHlS3EhWndR0vKarG0Xq9+VrOFUiQHDskGUw2c5FixfIUAC5
         gjNMBuD/kS5AnYQMvZpJEtoJ04eBDsuZfAz6jWBm6oLNNoQ/4mX60zdg0osLhfcs8TL8
         7OloYHK6UmB9lSpaUv7DKS3VfPGf+aXVe1zgVq1BkAOuYL1IxtgyydRv4mmHwilhia1O
         xdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YfzLGWtJGt16N5+Az8BALSQsdT3q7eKGBeOmGw6SJ3g=;
        b=I5yRyd4m8fGMr3F+4uBnb9RH1+Ga+MzfU2KChHJj/Xf+9kRMPkLmlgYCc6d92LR3ns
         33rG0Qtj5Nt8xXzPKaBJXtQe0AVIPWp6Oq8dwJmQ4VXfdld1B66uWF6N8LB7Qxf2TmMt
         qrx/7r1RzlP0pxOvqDUyY1OgGzPt9mPTWEfk4ihqYt90xu5LRDI+u5u1YnPW6hsDF5bI
         SmY2n8Oh2pGHp34hqHIXCRd07InSjsEyKFZ9Y1o5iIb2I0YFbTYIdDZi9sBx7i49Ke2i
         6fCnUHqE5LYB4494iTfdkx5FDnKsSKhvxG+rwPa9q8tcFd4fLUQKH5m2JeWhbHh59S+c
         6kng==
X-Gm-Message-State: AE9vXwOKyFoLkRrIXa0DMXRlZ+mbXiP8EYpTGtiyK84fZvGRKL3HXmg7dZRMGu27MKF7jw==
X-Received: by 10.36.92.20 with SMTP id q20mr5775304itb.10.1472323570136;
        Sat, 27 Aug 2016 11:46:10 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:09 -0700 (PDT)
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
Subject: [PATCH v13 10/14] apply: change error_routine when silent
Date:   Sat, 27 Aug 2016 20:45:43 +0200
Message-Id: <20160827184547.4365-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.9.2.770.g14ff7d2

