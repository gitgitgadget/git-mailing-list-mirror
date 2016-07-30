Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFC091F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbcG3R1i (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34407 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753587AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so20054052wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:26:37 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yQ3zzu9YWwZztGkt+4/mleAi6Lmi5b9LpospWlsO6A4=;
        b=FZpVz0MYfqyvxZItPfrpHaMZ9FG4MLMfwWeuCya02zS8WaMSO0wMTQvI9/D37JYo1N
         ubDNbkgODXTvm6ksPfNDCOqLQU5Dl/yCOBrTOQSs4Gs5VoSnAVljX74H0rZWmLxFU2um
         OsYcsrXqKAGe0mu2x0MAJ/x8Q8Jy1ch3IbnlR7q+q0Dw/iKfVfmzUyEGia7MMdZbO37U
         RThUgDFsoiJtIxXXPeuVQ5qeVpVvtdroZNLFTe8t3uS4VWo4hXG4iZPklIx6lvVwUOIH
         f5XZie5Jor52UmsGMsdNvZPmhGtdYT0BOCrZRejA0n/aP5wRNGt1QAjjTBXuvCSdN07i
         Wx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yQ3zzu9YWwZztGkt+4/mleAi6Lmi5b9LpospWlsO6A4=;
        b=AsGuT2lS7Lj+6L221BMndsAiinaPBKBX3d+jR/ajM0JiCbLaibMjmSXDN/tUwMhiOD
         O30UXWTCNjOAnk2FF8hy/dokR+p73wopzeXuH5WbqxxNIoMJAI4A97IPLIxeY07VGzpc
         RIMIZmDbnj8MUizPvuXRCSecnMveN6/FW9A9ug/u0JrzmBhtq96OfRk6NA3AVQSX+NPV
         Kpu0qgWTzcwQuYCUycBjQxdabWHnI1FRGxNte9m+MAHR1bH9m2fNEFhYgXG9ZbaN7m0P
         EPEndt/M53PM5ly85pKXfsPt7Z6vi4mH5bQA4mlGz2GSkz694K7KmNafd76Cl1hnRzsl
         tgrg==
X-Gm-Message-State: AEkoouukurslkGv1BbrffmCwaeLGwUBFhlmwpaRA+MFYSN3Lwpn8EIoiLYub2gaFNW7Cjw==
X-Received: by 10.194.61.205 with SMTP id s13mr42676247wjr.86.1469899597092;
        Sat, 30 Jul 2016 10:26:37 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:26:36 -0700 (PDT)
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
Subject: [PATCH v9 39/41] apply: change error_routine when silent
Date:	Sat, 30 Jul 2016 19:25:07 +0200
Message-Id: <20160730172509.22939-40-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To avoid printing anything when applying with
`state->apply_verbosity == verbosity_silent`, let's save the
existing warn and error routines before applying and replace
them with a routine that does nothing.

Then after applying, let's restore the saved routines.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 21 ++++++++++++++++++++-
 apply.h |  4 ++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index e109acd..51985c1 100644
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
 
@@ -4861,7 +4873,7 @@ int apply_all_patches(struct apply_state *state,
 		state->newfd = -1;
 	}
 
-	return !!errs;
+	res = !!errs;
 
 end:
 	if (state->newfd >= 0) {
@@ -4869,5 +4881,12 @@ int apply_all_patches(struct apply_state *state,
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
index 6d6d8cd..f0d39a8 100644
--- a/apply.h
+++ b/apply.h
@@ -94,6 +94,10 @@ struct apply_state {
 	 */
 	struct string_list fn_table;
 
+	/* This is to save some reporting routines */
+	void (*saved_error_routine)(const char *err, va_list params);
+	void (*saved_warn_routine)(const char *warn, va_list params);
+
 	/* These control whitespace errors */
 	enum apply_ws_error_action ws_error_action;
 	enum apply_ws_ignore ws_ignore_action;
-- 
2.9.2.558.gf53e569

