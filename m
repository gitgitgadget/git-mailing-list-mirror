Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 572561F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932088AbcIDUS4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:18:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35362 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754208AbcIDUSv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id c133so10465204wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=elfvQjasTPPTdMxOHMtzOEqLvALW3nEZ+0LbDV0Y2FE=;
        b=sL6IMt9F4pAJNUWnUIQlDnsMz7Ew8unRHO7SO6PBiQxKAbmPfNAn2LTs/HpN1myXYA
         VCl9ADYSX5Ekyk9P9MiTX0v4IM+Hr4BYgVAGNLnyCF6NhKRllO7AYidO2Gyt6YcXKIhQ
         PdNZnG5n6qHQ/6IgZOmH09PGms/aPUxJeH0aaAx0CC+G77yY6ski0xlrh0R5kQcCHQq8
         qRbhMHJ5mY6nOzFOa9xM8deCLcYo04loeBA+VIGcryigTrOPwPZjfcyKxcVyztqNEt9F
         auSdMrfKd0gFfY7grLFcC/eUIMHM7OHxp6HJ+J5Yk375cffDRkc/3Y44MjGfH6J7LQnU
         XulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=elfvQjasTPPTdMxOHMtzOEqLvALW3nEZ+0LbDV0Y2FE=;
        b=Zi2v1uYlR85CeYT5hAdf8U4p3PEb2Ydy2KyOUfp/fxhEZOtwYpzBfS/RLYSjQEdrG9
         hbh0mqyB68VKJwTPgNBNCwgdCXZq40+6lEO3Jh/gCzI5HIuSvQ0dqTGl4JvOfp46pFq/
         ufnMjOXnid9MWCVIUMbyrDo1On8GL/Xi+pZe/gpjH8skIKGiVDcOo2p1hUfo3fwcz/AF
         VjYZE4mdBMocRC9gUEdNXEknUSk93K1HAdoCOkbDSt/NXVSYYKe24xqBDtgh/ZoZTo/N
         tlg1DqBayYQ3daFvat0zHxLQ7qGDDRvcIF88DhvI8ivKyQmtD71K5sRhHQF24cx8mOC0
         WSAg==
X-Gm-Message-State: AE9vXwPy1b05p9mJzQK4CDRGHcLrFdkyOaE+cIRtoVqh1WsmE2xzgJ8ms+EJgATA76DURQ==
X-Received: by 10.28.88.144 with SMTP id m138mr11584212wmb.79.1473020328740;
        Sun, 04 Sep 2016 13:18:48 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:48 -0700 (PDT)
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
Subject: [PATCH v14 03/41] builtin/apply: make apply_patch() return -1 or -128 instead of die()ing
Date:   Sun,  4 Sep 2016 22:17:55 +0200
Message-Id: <20160904201833.21676-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To libify `git apply` functionality we have to signal errors
to the caller instead of die()ing.

As a first step in this direction, let's make apply_patch() return
-1 or -128 in case of errors instead of dying. For now its only
caller apply_all_patches() will exit(128) when apply_patch()
return -128 and it will exit(1) when it returns -1.

We exit() with code 128 because that was what die() was doing
and we want to keep the distinction between exiting with code 1
and exiting with code 128.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 60 ++++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 15 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index ed923ca..435030a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4404,6 +4404,15 @@ static struct lock_file lock_file;
 #define INACCURATE_EOF	(1<<0)
 #define RECOUNT		(1<<1)
 
+/*
+ * Try to apply a patch.
+ *
+ * Returns:
+ *  -128 if a bad error happened (like patch unreadable)
+ *  -1 if patch did not apply and user cannot deal with it
+ *   0 if the patch applied
+ *   1 if the patch did not apply but user might fix it
+ */
 static int apply_patch(struct apply_state *state,
 		       int fd,
 		       const char *filename,
@@ -4413,6 +4422,7 @@ static int apply_patch(struct apply_state *state,
 	struct strbuf buf = STRBUF_INIT; /* owns the patch text */
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
+	int res = 0;
 
 	state->patch_input_file = filename;
 	read_patch_file(&buf, fd);
@@ -4445,8 +4455,11 @@ static int apply_patch(struct apply_state *state,
 		offset += nr;
 	}
 
-	if (!list && !skipped_patch)
-		die(_("unrecognized input"));
+	if (!list && !skipped_patch) {
+		error(_("unrecognized input"));
+		res = -128;
+		goto end;
+	}
 
 	if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
 		state->apply = 0;
@@ -4455,21 +4468,23 @@ static int apply_patch(struct apply_state *state,
 	if (state->update_index && state->newfd < 0)
 		state->newfd = hold_locked_index(state->lock_file, 1);
 
-	if (state->check_index) {
-		if (read_cache() < 0)
-			die(_("unable to read index file"));
+	if (state->check_index && read_cache() < 0) {
+		error(_("unable to read index file"));
+		res = -128;
+		goto end;
 	}
 
 	if ((state->check || state->apply) &&
 	    check_patch_list(state, list) < 0 &&
-	    !state->apply_with_reject)
-		exit(1);
+	    !state->apply_with_reject) {
+		res = -1;
+		goto end;
+	}
 
 	if (state->apply && write_out_results(state, list)) {
-		if (state->apply_with_reject)
-			exit(1);
 		/* with --3way, we still need to write the index out */
-		return 1;
+		res = state->apply_with_reject ? -1 : 1;
+		goto end;
 	}
 
 	if (state->fake_ancestor)
@@ -4484,10 +4499,11 @@ static int apply_patch(struct apply_state *state,
 	if (state->summary)
 		summary_patch_list(list);
 
+end:
 	free_patch_list(list);
 	strbuf_release(&buf);
 	string_list_clear(&state->fn_table, 0);
-	return 0;
+	return res;
 }
 
 static void git_apply_config(void)
@@ -4628,6 +4644,7 @@ static int apply_all_patches(struct apply_state *state,
 			     int options)
 {
 	int i;
+	int res;
 	int errs = 0;
 	int read_stdin = 1;
 
@@ -4636,7 +4653,10 @@ static int apply_all_patches(struct apply_state *state,
 		int fd;
 
 		if (!strcmp(arg, "-")) {
-			errs |= apply_patch(state, 0, "<stdin>", options);
+			res = apply_patch(state, 0, "<stdin>", options);
+			if (res < 0)
+				goto end;
+			errs |= res;
 			read_stdin = 0;
 			continue;
 		} else if (0 < state->prefix_length)
@@ -4649,12 +4669,19 @@ static int apply_all_patches(struct apply_state *state,
 			die_errno(_("can't open patch '%s'"), arg);
 		read_stdin = 0;
 		set_default_whitespace_mode(state);
-		errs |= apply_patch(state, fd, arg, options);
+		res = apply_patch(state, fd, arg, options);
+		if (res < 0)
+			goto end;
+		errs |= res;
 		close(fd);
 	}
 	set_default_whitespace_mode(state);
-	if (read_stdin)
-		errs |= apply_patch(state, 0, "<stdin>", options);
+	if (read_stdin) {
+		res = apply_patch(state, 0, "<stdin>", options);
+		if (res < 0)
+			goto end;
+		errs |= res;
+	}
 
 	if (state->whitespace_error) {
 		if (state->squelch_whitespace_errors &&
@@ -4690,6 +4717,9 @@ static int apply_all_patches(struct apply_state *state,
 	}
 
 	return !!errs;
+
+end:
+	exit(res == -1 ? 1 : 128);
 }
 
 int cmd_apply(int argc, const char **argv, const char *prefix)
-- 
2.10.0.41.g9df52c3

