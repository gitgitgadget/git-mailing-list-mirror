Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E9171F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932454AbcIDUU3 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:29 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36157 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932172AbcIDUTA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id l65so2665691wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lsPdVgqD5m5x86x+/K8MHPvwnOA+31/JInMlqn/JKlg=;
        b=C8yLxho65XWsH4hZN/ph+a3K/lBXr4CI0DAIGqlT0YnJiXTIB5jOw8yr7/PZ2LXXjt
         7WWjWrRlk5Uyuys4MQFds1YFZbSjPiye12cC8o/56meeuItOdSQRCkYAQq8zRtXyUnuE
         rTDrnrhOcwCX2fOTQtN50CnTKqfS1V5RbpTspgujrQicjy4nInBDmnqqsJfK86KUuLab
         7t8CtXlZUroqXgEDPSFh1Qi/L/mm9XuzYX2otb2rqfWi6FJwemmJo+bcfg35gXcXD8cc
         6TCVrbm4pyhsVkLHLlbegy6mXKmSMVdGAOinrsEtUhlLGB4yWhXRC0trm9J6bphNuiYY
         xG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lsPdVgqD5m5x86x+/K8MHPvwnOA+31/JInMlqn/JKlg=;
        b=HbM1A0wcol+8NREec9w6XfWVX0uHKT2d1aPP6GnoidddY4zhw0QS28A3JaPo9EjYoh
         sbHny7tejFgO/AYvY5a741Sk8r0PYAhuKLf19mo5PTWrqcLQzkNFy0Z6mGyPRR+bidIM
         G0748fMSg3axZCDLRmHdtSbfZ3FhRBq9+q0qvbAxD3zydWkwPLz24+sOeObv5H0XvOKe
         aoKg3GAA1Y/Z7+P7gTvoF9AOjMYvv0EClnD5b5n9zP1UaGYhNsvQ8n3f0GCg+9WboWS9
         C9WjOFxHmlmO9D8R2Ky2W/Qffzgab2ZWhJrKRJlI6jTwZVmqYyNySsPfQhTYbZlVcHxk
         ilFQ==
X-Gm-Message-State: AE9vXwPr8chGBK8J3IHI4M8qkPlDDl4MuqMh5quoQjowZt9ZNsTDNsUQqF5Jpxpj2rhxZw==
X-Received: by 10.194.107.69 with SMTP id ha5mr27325505wjb.100.1473020338872;
        Sun, 04 Sep 2016 13:18:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:58 -0700 (PDT)
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
Subject: [PATCH v14 10/41] builtin/apply: move init_apply_state() to apply.c
Date:   Sun,  4 Sep 2016 22:18:02 +0200
Message-Id: <20160904201833.21676-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we must make init_apply_state()
usable outside "builtin/apply.c".

Let's do that by moving it into a new "apply.c".

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Makefile        |  1 +
 apply.c         | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 apply.h         | 10 ++++++
 builtin/apply.c | 91 -------------------------------------------------------
 4 files changed, 105 insertions(+), 91 deletions(-)
 create mode 100644 apply.c

diff --git a/Makefile b/Makefile
index d96ecb7..c6ac236 100644
--- a/Makefile
+++ b/Makefile
@@ -691,6 +691,7 @@ LIB_OBJS += abspath.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
+LIB_OBJS += apply.o
 LIB_OBJS += archive.o
 LIB_OBJS += archive-tar.o
 LIB_OBJS += archive-zip.o
diff --git a/apply.c b/apply.c
new file mode 100644
index 0000000..c858ca4
--- /dev/null
+++ b/apply.c
@@ -0,0 +1,94 @@
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
+	string_list_init(&state->fn_table, 0);
+	string_list_init(&state->limit_by_name, 0);
+	string_list_init(&state->symlink_changes, 0);
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
index ecb1f7a..bb6ff77 100644
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
@@ -4539,13 +4493,6 @@ static int apply_patch(struct apply_state *state,
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
@@ -4604,44 +4551,6 @@ static int option_parse_directory(const struct option *opt,
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
-	string_list_init(&state->fn_table, 0);
-	string_list_init(&state->limit_by_name, 0);
-	string_list_init(&state->symlink_changes, 0);
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
2.10.0.41.g9df52c3

