Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1255E203C1
	for <e@80x24.org>; Thu, 11 Aug 2016 18:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbcHKSrN (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 14:47:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33217 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932434AbcHKSrH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 14:47:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so881585wme.0
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 11:47:06 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+cHgaCZB8zpsU1QnBBhjrBcf1qldYfpxs1ZVJWw4YYo=;
        b=GEq5mAcx3jHEoOJ0qFd/98BZV0mQGSrMcCgQfGKtHtBQuGjljGqc1/t2pl3vlkreoj
         yviejMOJVcRuUHpklWJ0Kd8P+oHOOwIJ6TKIeKRcczjCbjnhB1UE0xq+aGZ0Gc/wUgfW
         kBAjuH1tJ1ZOcZmusH0s5yMxhv4LSo6dfmGvTL/8iYm5iSESAlzrRwdK0IjG2B7Uq+qy
         9WK3+88RuQ7KKe6X5sf485rfruTGzLEBkpVZE14JwAqryD81Ly9n+eXaVx6907TDTsVx
         svu3VRO03KM73+lc9GFTh1UuUiTjLcNfLIrnvBIeKAyI7NO6FR/7hGeOJbubrZBMZ/C1
         5QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+cHgaCZB8zpsU1QnBBhjrBcf1qldYfpxs1ZVJWw4YYo=;
        b=moNlx/ELzMQqHCMzQpJ0HhH866zXdUxE/zIDaPh9H+2/CPkMn+sSMyYDR0Pxz/yO7F
         QA/q+Xtp41mnPho/uF2jKWG4HO+AjQO/JdU6boPM09ioCWUx3p+hWfLlCpE8tsUEd7Rq
         lerho0vf9PD2ysQFgNv7lG4DIlJwId6rkB9VBhCNOWnG8ndmyrSx3e0jV1LfYC2XQMcA
         ZpYiwzJC05y/ZnB0mUgN4uxzhlFa8o2G49MQ4qKhFx9Ab7+vvj/TlwdCxf+hZBfpUITK
         ONXxBfqnPABG1cTzRTsRNWPCa4rZGpORPtqMnKQxQ9VpoZugOI/6/sFtthg9MIKtaIOM
         QJyw==
X-Gm-Message-State: AEkoouveYxcGCv5b2pkaNDhPbFKYtIDrnNW/2VTm2rL44VUpo+IoUsCHnmaX3lkuaWiBYQ==
X-Received: by 10.194.148.232 with SMTP id tv8mr13740735wjb.113.1470941226137;
        Thu, 11 Aug 2016 11:47:06 -0700 (PDT)
Received: from localhost.localdomain ([80.215.37.180])
        by smtp.gmail.com with ESMTPSA id 190sm1047236wmk.13.2016.08.11.11.47.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 11:47:05 -0700 (PDT)
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
	Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v12 10/13] apply: change error_routine when silent
Date:	Thu, 11 Aug 2016 20:44:58 +0200
Message-Id: <20160811184501.384-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.769.gc0f0333
In-Reply-To: <20160811184501.384-1-chriscool@tuxfamily.org>
References: <20160811184501.384-1-chriscool@tuxfamily.org>
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
2.9.2.769.gc0f0333

