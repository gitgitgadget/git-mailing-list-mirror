Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEC1C2018B
	for <e@80x24.org>; Mon, 27 Jun 2016 18:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbcF0S05 (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:26:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35291 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751875AbcF0SZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:06 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so26928732wme.2
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Qhvva8p0RxreZqQ5fo0ktAdMkNExJfqmgGXL7EQ5Jo8=;
        b=PCaO5Ds81ZhlbcIsx/Ail0/dUwMGzbt3eMxyFXYW0GaQ8xO0ZDIfCkT0tkwELwkW0E
         G+okaA+13Z5Xvszs/E8RiGgxtlDsFu11Wg/snUrdKdmSNnYDcF3RiJm0kfsSvJ2/8E4Y
         vmBmljxQaq/+hN4Ghumf6ZniXPD3OO8rHbcivH82lkrEKB4y0oSHJ1z6SlYEqx/YB/K6
         L1beCLDKPZbLi9JcJb7VgqncTj/SBMzKMfe3j9zyp89ZcrydE6u/lMMTI7ZW7H5hF7PT
         6d8vWbaBy8gtHGLGIb+2WT0ERTBdSQ4VRefP2OvkSqwiqLgHZl8/nUTuSkoPXibFYS2I
         V17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Qhvva8p0RxreZqQ5fo0ktAdMkNExJfqmgGXL7EQ5Jo8=;
        b=QKetk0sYctkgQ7uT+xvQ0bm5Sik/FkZvTkFaiv7UqMbQPdW4KgunXkslsAvuaIy2gZ
         BritmR08L1Jvo0eYV4p1eH/AABxR7QfxV+99Z13ULYrCHQ1W810D8qCRV8JSwdR86Ze0
         drY6sztXfAvKuO5g1zGTQ1GupS2r1nGjrBGBzBqjlWI5tGqOwuudflgsuBQOYxR/9u1d
         /3tUVmPBGg9efSrY55fxNYYl6o5TM4/T1XP4DmhyhNzdXK9GWrfyVwblgu+xiFKYtPbb
         Vr82lAcs68JliFlcsUIZjl5bftw9oTB0p6q0JHyaaDXLxCAFlUtNcETb02PFrULUswuI
         a+wg==
X-Gm-Message-State: ALyK8tLPS9ldEifipfn4aeoHREGArPDOGlibjwavwhw7Zi2RqzbRRDcFWOoBmGk10MW1oA==
X-Received: by 10.28.166.150 with SMTP id p144mr11442079wme.57.1467051904753;
        Mon, 27 Jun 2016 11:25:04 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:04 -0700 (PDT)
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
Subject: [PATCH v8 10/41] builtin/apply: move init_apply_state() to apply.c
Date:	Mon, 27 Jun 2016 20:23:58 +0200
Message-Id: <20160627182429.31550-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we must make init_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into a new "apply.c".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile        |  1 +
 apply.c         | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h         | 10 +++++++
 builtin/apply.c | 88 -------------------------------------------------------
 4 files changed, 102 insertions(+), 88 deletions(-)
 create mode 100644 apply.c

diff --git a/Makefile b/Makefile
index de5a030..51f8583 100644
--- a/Makefile
+++ b/Makefile
@@ -680,6 +680,7 @@ LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
+LIB_OBJS += apply.o
 LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
diff --git a/apply.c b/apply.c
new file mode 100644
index 0000000..1f31bb4
--- /dev/null
+++ b/apply.c
@@ -0,0 +1,91 @@
+#include "cache.h"
+#include "lockfile.h"
+#include "apply.h"
+
+static void git_apply_config(void)
+{
+	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
+	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
+	git_config(git_default_config, NULL);
+}
+
+int parse_whitespace_option(struct apply_state *state, const char *option)
+{
+	if (!option) {
+		state->ws_error_action = warn_on_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "warn")) {
+		state->ws_error_action = warn_on_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "nowarn")) {
+		state->ws_error_action = nowarn_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "error")) {
+		state->ws_error_action = die_on_ws_error;
+		return 0;
+	}
+	if (!strcmp(option, "error-all")) {
+		state->ws_error_action = die_on_ws_error;
+		state->squelch_whitespace_errors = 0;
+		return 0;
+	}
+	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
+		state->ws_error_action = correct_ws_error;
+		return 0;
+	}
+	return error(_("unrecognized whitespace option '%s'"), option);
+}
+
+int parse_ignorewhitespace_option(struct apply_state *state,
+				  const char *option)
+{
+	if (!option || !strcmp(option, "no") ||
+	    !strcmp(option, "false") || !strcmp(option, "never") ||
+	    !strcmp(option, "none")) {
+		state->ws_ignore_action = ignore_ws_none;
+		return 0;
+	}
+	if (!strcmp(option, "change")) {
+		state->ws_ignore_action = ignore_ws_change;
+		return 0;
+	}
+	return error(_("unrecognized whitespace ignore option '%s'"), option);
+}
+
+void init_apply_state(struct apply_state *state,
+		      const char *prefix,
+		      struct lock_file *lock_file)
+{
+	memset(state, 0, sizeof(*state));
+	state->prefix = prefix;
+	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
+	state->lock_file = lock_file;
+	state->newfd = -1;
+	state->apply = 1;
+	state->line_termination = '\n';
+	state->p_value = 1;
+	state->p_context = UINT_MAX;
+	state->squelch_whitespace_errors = 5;
+	state->ws_error_action = warn_on_ws_error;
+	state->ws_ignore_action = ignore_ws_none;
+	state->linenr = 1;
+	strbuf_init(&state->root, 0);
+
+	git_apply_config();
+	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
+		exit(1);
+	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
+		exit(1);
+}
+
+void clear_apply_state(struct apply_state *state)
+{
+	string_list_clear(&state->limit_by_name, 0);
+	string_list_clear(&state->symlink_changes, 0);
+	strbuf_release(&state->root);
+
+	/* &state->fn_table is cleared at the end of apply_patch() */
+}
diff --git a/apply.h b/apply.h
index 7493a40..08c0a25 100644
--- a/apply.h
+++ b/apply.h
@@ -97,4 +97,14 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
+extern int parse_whitespace_option(struct apply_state *state,
+				   const char *option);
+extern int parse_ignorewhitespace_option(struct apply_state *state,
+					 const char *option);
+
+extern void init_apply_state(struct apply_state *state,
+			     const char *prefix,
+			     struct lock_file *lock_file);
+extern void clear_apply_state(struct apply_state *state);
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 7d0bf66..4fbd993 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -27,52 +27,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static int parse_whitespace_option(struct apply_state *state, const char *option)
-{
-	if (!option) {
-		state->ws_error_action = warn_on_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "warn")) {
-		state->ws_error_action = warn_on_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "nowarn")) {
-		state->ws_error_action = nowarn_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "error")) {
-		state->ws_error_action = die_on_ws_error;
-		return 0;
-	}
-	if (!strcmp(option, "error-all")) {
-		state->ws_error_action = die_on_ws_error;
-		state->squelch_whitespace_errors = 0;
-		return 0;
-	}
-	if (!strcmp(option, "strip") || !strcmp(option, "fix")) {
-		state->ws_error_action = correct_ws_error;
-		return 0;
-	}
-	return error(_("unrecognized whitespace option '%s'"), option);
-}
-
-static int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option)
-{
-	if (!option || !strcmp(option, "no") ||
-	    !strcmp(option, "false") || !strcmp(option, "never") ||
-	    !strcmp(option, "none")) {
-		state->ws_ignore_action = ignore_ws_none;
-		return 0;
-	}
-	if (!strcmp(option, "change")) {
-		state->ws_ignore_action = ignore_ws_change;
-		return 0;
-	}
-	return error(_("unrecognized whitespace ignore option '%s'"), option);
-}
-
 static void set_default_whitespace_mode(struct apply_state *state)
 {
 	if (!state->whitespace_option && !apply_default_whitespace)
@@ -4539,13 +4493,6 @@ end:
 	return res;
 }
 
-static void git_apply_config(void)
-{
-	git_config_get_string_const("apply.whitespace", &apply_default_whitespace);
-	git_config_get_string_const("apply.ignorewhitespace", &apply_default_ignorewhitespace);
-	git_config(git_default_config, NULL);
-}
-
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -4604,41 +4551,6 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void init_apply_state(struct apply_state *state,
-			     const char *prefix,
-			     struct lock_file *lock_file)
-{
-	memset(state, 0, sizeof(*state));
-	state->prefix = prefix;
-	state->prefix_length = state->prefix ? strlen(state->prefix) : 0;
-	state->lock_file = lock_file;
-	state->newfd = -1;
-	state->apply = 1;
-	state->line_termination = '\n';
-	state->p_value = 1;
-	state->p_context = UINT_MAX;
-	state->squelch_whitespace_errors = 5;
-	state->ws_error_action = warn_on_ws_error;
-	state->ws_ignore_action = ignore_ws_none;
-	state->linenr = 1;
-	strbuf_init(&state->root, 0);
-
-	git_apply_config();
-	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
-		exit(1);
-	if (apply_default_ignorewhitespace && parse_ignorewhitespace_option(state, apply_default_ignorewhitespace))
-		exit(1);
-}
-
-static void clear_apply_state(struct apply_state *state)
-{
-	string_list_clear(&state->limit_by_name, 0);
-	string_list_clear(&state->symlink_changes, 0);
-	strbuf_release(&state->root);
-
-	/* &state->fn_table is cleared at the end of apply_patch() */
-}
-
 static void check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
-- 
2.9.0.172.gfb57a78

