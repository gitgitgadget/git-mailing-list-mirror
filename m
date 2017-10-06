Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EE3220372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbdJFUNL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:13:11 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:44183 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbdJFUMt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id 196so3828310wma.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gxwcD9qMzonY74HgdUCN3bvFG429ZQXqVrFSpdUaBrI=;
        b=Dh6CTajJHL4NLZAvJiU3DAKC459o7+sQ0vBVfdhAEK3YzNAkxeCKDaL6MfvCJV8wZL
         Qzy7ng2iN6lKFcGbUVEBOTRFgNJ/RiFPEcUNJ/RbRetWSMmrEYGmyOFHLq/zxOxyzcud
         AeuvzEo6igW2oOCp4ESVm8slBRGQfPCqMLv1XY1Rmx8OV0DJ7F3RJibZkLqbB2uIdiiq
         r+qiLTSHKQtbZxDQ0shotkEXvuYcs9txf2Yu0QrMX9qJ3nsCaEpuUboYNBm1Zlf7lhLK
         5/lsl9adTWWN0KvvweCGQpX76PDWQaz4PLBfZqho8W5Ux/B/LA2Mq2bunjvQGUprmMbc
         f9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gxwcD9qMzonY74HgdUCN3bvFG429ZQXqVrFSpdUaBrI=;
        b=pzeUBuMj6A6CncXak4UGsIhLdT+eD7Fnuv4bNZ4gmtIMpjH+jGgAcE4txzxKJop2WI
         2m1RjchoATBt7xct4oWuU5x+PwJFVKiWlc3jQskbueM/dl2vzr3BDglOAnG5xODM/k8M
         PEvgnaqfE7mlZ3EYmQU1HM1UT2GOqzyYy8fbJGLOOCdPw9KKNy3T0XKHRf11hfd0dgV+
         trDbRRXysW/b+Aqo3pghyqi8nz0ok4VzAowoDuxRxjS5v7/RJpWBnUujMtdDWIZSi5aO
         o5p/h+0oU3zzyMgOH3yb2EaRrqtjzBlxq5gf29PjOJTQDTkGzT3LwfFq40IrR/FVqQHI
         Zdcw==
X-Gm-Message-State: AMCzsaUl/z/ILYzH8vmIjcKO/8Ms1jIft7cojaSvku55G9++msj4+hGK
        8C6neDISI5KQdkUaI4ggAKWOAf+RnXA=
X-Google-Smtp-Source: AOwi7QCkr0Xn3tOvjdqBBrRnCCyFNJIUsMXVV5U1og1blu4zzUFSxWFe+jojAojVElYr3UiZFMtOEQ==
X-Received: by 10.28.165.150 with SMTP id o144mr2968581wme.31.1507320767828;
        Fri, 06 Oct 2017 13:12:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:46 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 07/12] apply: move lockfile into `apply_state`
Date:   Fri,  6 Oct 2017 22:12:09 +0200
Message-Id: <6d058c882643dc45c8d708be98e86c38f25511a9.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have two users of `struct apply_state` and the related functionality
in apply.c. Each user sets up its `apply_state` by handing over a
pointer to its static `lock_file`. (Before 076aa2cbd (tempfile:
auto-allocate tempfiles on heap, 2017-09-05), we could never free
lockfiles, so making them static was a reasonable approach.)

Other than that, they never directly access their `lock_file`s, which
are instead handled by the functionality in apply.c.

To make life easier for the caller and to make it less tempting for a
future caller to mess with the lock, make apply.c fully responsible for
setting up the `lock_file`. As mentioned above, it is now safe to free a
`lock_file`, so we can make the `struct apply_state` contain an actual
`struct lock_file` instead of a pointer to one.

The user in builtin/apply.c is rather simple. For builtin/am.c, we might
worry that the lock state is actually meant to be inherited across
calls. But the lock is only taken as `apply_all_patches()` executes, and
code inspection shows that it will always be released.

Alternatively, we can observe that the lock itself is never queried
directly. When we decide whether we should lock, we check a related
variable `newfd`. That variable is not inherited, so from the point of
view of apply.c, the state machine really is reset with each call to
`init_apply_state()`. (It would be a bug if `newfd` and the lock status
were not in sync. The duplication of information in `newfd` and the lock
will be addressed in the next patch.)

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c         | 14 +++++---------
 apply.h         |  5 ++---
 builtin/am.c    |  3 +--
 builtin/apply.c |  4 +---
 4 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/apply.c b/apply.c
index c022af53a..5a6ca10a7 100644
--- a/apply.c
+++ b/apply.c
@@ -75,12 +75,10 @@ static int parse_ignorewhitespace_option(struct apply_state *state,
 }
 
 int init_apply_state(struct apply_state *state,
-		     const char *prefix,
-		     struct lock_file *lock_file)
+		     const char *prefix)
 {
 	memset(state, 0, sizeof(*state));
 	state->prefix = prefix;
-	state->lock_file = lock_file;
 	state->newfd = -1;
 	state->apply = 1;
 	state->line_termination = '\n';
@@ -146,8 +144,6 @@ int check_apply_state(struct apply_state *state, int force_apply)
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
-	if (!state->lock_file)
-		return error("BUG: state->lock_file should not be NULL");
 
 	if (state->apply_verbosity <= verbosity_silent) {
 		state->saved_error_routine = get_error_routine();
@@ -4711,11 +4707,11 @@ static int apply_patch(struct apply_state *state,
 	state->update_index = state->check_index && state->apply;
 	if (state->update_index && state->newfd < 0) {
 		if (state->index_file)
-			state->newfd = hold_lock_file_for_update(state->lock_file,
+			state->newfd = hold_lock_file_for_update(&state->lock_file,
 								 state->index_file,
 								 LOCK_DIE_ON_ERROR);
 		else
-			state->newfd = hold_locked_index(state->lock_file, LOCK_DIE_ON_ERROR);
+			state->newfd = hold_locked_index(&state->lock_file, LOCK_DIE_ON_ERROR);
 	}
 
 	if (state->check_index && read_apply_cache(state) < 0) {
@@ -4911,7 +4907,7 @@ int apply_all_patches(struct apply_state *state,
 	}
 
 	if (state->update_index) {
-		res = write_locked_index(&the_index, state->lock_file, COMMIT_LOCK);
+		res = write_locked_index(&the_index, &state->lock_file, COMMIT_LOCK);
 		if (res) {
 			error(_("Unable to write new index file"));
 			res = -128;
@@ -4924,7 +4920,7 @@ int apply_all_patches(struct apply_state *state,
 
 end:
 	if (state->newfd >= 0) {
-		rollback_lock_file(state->lock_file);
+		rollback_lock_file(&state->lock_file);
 		state->newfd = -1;
 	}
 
diff --git a/apply.h b/apply.h
index d9b395770..cf00cda17 100644
--- a/apply.h
+++ b/apply.h
@@ -37,7 +37,7 @@ struct apply_state {
 	const char *prefix;
 
 	/* These are lock_file related */
-	struct lock_file *lock_file;
+	struct lock_file lock_file;
 	int newfd;
 
 	/* These control what gets looked at and modified */
@@ -116,8 +116,7 @@ extern int apply_parse_options(int argc, const char **argv,
 			       int *force_apply, int *options,
 			       const char * const *apply_usage);
 extern int init_apply_state(struct apply_state *state,
-			    const char *prefix,
-			    struct lock_file *lock_file);
+			    const char *prefix);
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
diff --git a/builtin/am.c b/builtin/am.c
index 4e16fd428..40968428d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1488,11 +1488,10 @@ static int run_apply(const struct am_state *state, const char *index_file)
 	struct argv_array apply_opts = ARGV_ARRAY_INIT;
 	struct apply_state apply_state;
 	int res, opts_left;
-	static struct lock_file lock_file;
 	int force_apply = 0;
 	int options = 0;
 
-	if (init_apply_state(&apply_state, NULL, &lock_file))
+	if (init_apply_state(&apply_state, NULL))
 		die("BUG: init_apply_state() failed");
 
 	argv_array_push(&apply_opts, "apply");
diff --git a/builtin/apply.c b/builtin/apply.c
index 81b9a61c3..48d398933 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -9,8 +9,6 @@ static const char * const apply_usage[] = {
 	NULL
 };
 
-static struct lock_file lock_file;
-
 int cmd_apply(int argc, const char **argv, const char *prefix)
 {
 	int force_apply = 0;
@@ -18,7 +16,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	int ret;
 	struct apply_state state;
 
-	if (init_apply_state(&state, prefix, &lock_file))
+	if (init_apply_state(&state, prefix))
 		exit(128);
 
 	argc = apply_parse_options(argc, argv,
-- 
2.15.0.rc0

