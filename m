Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFFC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC626134F
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 10:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353319AbhJAKHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 06:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353290AbhJAKGz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 06:06:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B46BC06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 03:05:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k7so14486734wrd.13
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 03:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jIRqKcH2tEa0UjuI9KfVPTfvk6Wug3iny0OUNyQINsM=;
        b=oNV28EPh0vL8iv4nFFUnWA+qAeTqEi0kTnYuPldP1UfaqRVZ11H6UEgBA6JLBNOUju
         epkBHQ5RGiPMLbk59uaK0LOqlAbhrxbgMrx7PTTgH47F0Pr68ABIejy4FoCsyTWOlK8f
         3d6rm1D/kvrq0rcxLQNqBqLwJBNJeHacAw1ytGYlb+Y1a9xyp7hSToNdekiXwrPcRKgK
         NStCw7z9LZGnWodvoN60CUYjS2ptUrAppcRTyIhfPSBXPY4ZleOw1ZH0+wJsDfN6dByM
         zfxonL94QCeZmdOwg7cP2dQL59J/3A7OU0DecJFYkV4/fv1w4PdABQfI1K+/TlUt/tjr
         izCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jIRqKcH2tEa0UjuI9KfVPTfvk6Wug3iny0OUNyQINsM=;
        b=GgO+lqSVhK9vLEJ3jYjYdtgHkL1OtIQc/+FApX9aBDW2FgT0X/kfZ4sJ1S6JhkMYAQ
         VmG1ONyT6/vTrXduaFJUcUz2LBFOGUbGqty6oLky0HoAkVRfk9NLcvtJU2oQTfopm7vd
         29adEPMugmNsiXgkLwurrE7ZXv4V5DQq963O+JZ4IjPawdm5oW24Zh8xd3eqWFyU6PaX
         iqBSTpTTDibA41PLfLIenRLRGclX4iDCq5lb9U3SuqXId+jXIhGWHIe0v3sqA7Xq9MyX
         deyMg/tIWu/nePFeTbe5X5eWLVdVhEMD7ATtP6sScaiw5zxmIM5Ugy4/0nYRpkdbRcA+
         5jqQ==
X-Gm-Message-State: AOAM530O8PMR6tbyqstLqhOvaL0brHG+wvl3vbeSqvhVehfHP9d1Z46K
        tIgG8YJQpsQCXHei50QOdB+4pH8RjHw=
X-Google-Smtp-Source: ABdhPJxeMuDBjbvKncIoIzwMBkj716cotSGhdanBzYxVvDRdyLE8V3jpC2u/0jscB1G0Eag8fZxg0g==
X-Received: by 2002:a5d:6a8f:: with SMTP id s15mr11353043wru.15.1633082709288;
        Fri, 01 Oct 2021 03:05:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a8sm5457832wrp.61.2021.10.01.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 03:05:09 -0700 (PDT)
Message-Id: <267e074e6dbd3c7cf733cd5ba4fa476d2d5e6fd2.1633082702.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 10:04:59 +0000
Subject: [PATCH 08/11] reset_head(): take struct rebase_head_opts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This function already takes a confusingly large number of parameters
some of which are optional or not always required. The following
commits will add a couple more parameters so change it to take a
struct of options first.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 57 ++++++++++++++++++++++++++++++------------------
 reset.c          | 36 +++++++++++++++---------------
 reset.h          | 29 ++++++++++++++++++++----
 sequencer.c      |  5 ++---
 4 files changed, 80 insertions(+), 47 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 89b348ffa75..ae5de271e9a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -777,6 +777,7 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 static int move_to_original_branch(struct rebase_options *opts)
 {
 	struct strbuf orig_head_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
+	struct reset_head_opts ropts = { 0 };
 	int ret;
 
 	if (!opts->head_name)
@@ -789,9 +790,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
 	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
 		    opts->head_name);
-	ret = reset_head(the_repository, NULL, opts->head_name,
-			 RESET_HEAD_REFS_ONLY,
-			 orig_head_reflog.buf, head_reflog.buf, NULL);
+	ropts.branch = opts->head_name;
+	ropts.flags = RESET_HEAD_REFS_ONLY;
+	ropts.orig_head_msg = orig_head_reflog.buf;
+	ropts.head_msg = head_reflog.buf;
+	ret = reset_head(the_repository, &ropts);
 
 	strbuf_release(&orig_head_reflog);
 	strbuf_release(&head_reflog);
@@ -875,13 +878,15 @@ static int run_am(struct rebase_options *opts)
 
 	status = run_command(&format_patch);
 	if (status) {
+		struct reset_head_opts ropts = { 0 };
 		unlink(rebased_patches);
 		free(rebased_patches);
 		strvec_clear(&am.args);
 
-		reset_head(the_repository, &opts->orig_head,
-			   opts->head_name, 0,
-			   NULL, NULL, DEFAULT_REFLOG_ACTION);
+		ropts.oid = &opts->orig_head;
+		ropts.branch = opts->head_name;
+		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+		reset_head(the_repository, &ropts);
 		error(_("\ngit encountered an error while preparing the "
 			"patches to replay\n"
 			"these revisions:\n"
@@ -1101,14 +1106,17 @@ static int rebase_config(const char *var, const char *value, void *data)
 static int checkout_up_to_date(struct rebase_options *options)
 {
 	struct strbuf buf = STRBUF_INIT;
+	struct reset_head_opts ropts = { 0 };
 	int ret = 0;
 
 	strbuf_addf(&buf, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    options->switch_to);
-	if (reset_head(the_repository, &options->orig_head,
-		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, buf.buf, NULL) < 0)
+	ropts.oid = &options->orig_head;
+	ropts.branch = options->head_name;
+	ropts.flags = RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.head_msg = buf.buf;
+	if (reset_head(the_repository, &ropts) < 0)
 		ret = error(_("could not switch to %s"), options->switch_to);
 	strbuf_release(&buf);
 
@@ -1319,6 +1327,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	char *squash_onto_name = NULL;
 	int reschedule_failed_exec = -1;
 	int allow_preemptive_ff = 1;
+	struct reset_head_opts ropts = { 0 };
 	struct option builtin_rebase_options[] = {
 		OPT_STRING(0, "onto", &options.onto_name,
 			   N_("revision"),
@@ -1555,9 +1564,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		rerere_clear(the_repository, &merge_rr);
 		string_list_clear(&merge_rr, 1);
-
-		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
-			       NULL, NULL, NULL) < 0)
+		ropts.flags = RESET_HEAD_HARD;
+		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not discard worktree changes"));
 		remove_branch_state(the_repository, 0);
 		if (read_basic_state(&options))
@@ -1574,9 +1582,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 		if (read_basic_state(&options))
 			exit(1);
-		if (reset_head(the_repository, &options.orig_head,
-			       options.head_name, RESET_HEAD_HARD,
-			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
+		ropts.oid = &options.orig_head;
+		ropts.branch = options.head_name;
+		ropts.flags = RESET_HEAD_HARD;
+		ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+		if (reset_head(the_repository, &ropts) < 0)
 			die(_("could not move back to %s"),
 			    oid_to_hex(&options.orig_head));
 		remove_branch_state(the_repository, 0);
@@ -2063,10 +2073,12 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 
 	strbuf_addf(&msg, "%s: checkout %s",
 		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), options.onto_name);
-	if (reset_head(the_repository, &options.onto->object.oid, NULL,
-		       RESET_HEAD_DETACH | RESET_ORIG_HEAD |
-		       RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
-		       NULL, msg.buf, DEFAULT_REFLOG_ACTION))
+	ropts.oid = &options.onto->object.oid;
+	ropts.flags = RESET_HEAD_DETACH | RESET_ORIG_HEAD |
+			RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	ropts.head_msg = msg.buf;
+	ropts.default_reflog_action = DEFAULT_REFLOG_ACTION;
+	if (reset_head(the_repository, &ropts))
 		die(_("Could not detach HEAD"));
 	strbuf_release(&msg);
 
@@ -2081,8 +2093,11 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		strbuf_addf(&msg, "rebase finished: %s onto %s",
 			options.head_name ? options.head_name : "detached HEAD",
 			oid_to_hex(&options.onto->object.oid));
-		reset_head(the_repository, NULL, options.head_name,
-			   RESET_HEAD_REFS_ONLY, NULL, msg.buf, NULL);
+		memset(&ropts, 0, sizeof(ropts));
+		ropts.branch = options.head_name;
+		ropts.flags = RESET_HEAD_REFS_ONLY;
+		ropts.head_msg = msg.buf;
+		reset_head(the_repository, &ropts);
 		strbuf_release(&msg);
 		ret = finish_rebase(&options);
 		goto cleanup;
diff --git a/reset.c b/reset.c
index be4e18eed98..e77a8ac423d 100644
--- a/reset.c
+++ b/reset.c
@@ -8,13 +8,16 @@
 #include "tree.h"
 #include "unpack-trees.h"
 
-static int update_refs(const struct object_id *oid, const char *switch_to_branch,
-		       const char *reflog_head, const char *reflog_orig_head,
-		       const char *default_reflog_action, unsigned flags)
+static int update_refs(const struct reset_head_opts *opts,
+		       const struct object_id *oid)
 {
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
-	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	unsigned detach_head = opts->flags & RESET_HEAD_DETACH;
+	unsigned run_hook = opts->flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
+	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
+	const char *switch_to_branch = opts->branch;
+	const char *reflog_head = opts->head_msg;
+	const char *reflog_orig_head = opts->orig_head_msg;
+	const char *default_reflog_action = opts->default_reflog_action;
 	struct object_id *orig = NULL, oid_orig, *old_orig = NULL, oid_old_orig;
 	struct strbuf msg = STRBUF_INIT;
 	const char *reflog_action;
@@ -69,14 +72,13 @@ static int update_refs(const struct object_id *oid, const char *switch_to_branch
 	return ret;
 }
 
-int reset_head(struct repository *r, struct object_id *oid,
-	       const char *switch_to_branch, unsigned flags,
-	       const char *reflog_orig_head, const char *reflog_head,
-	       const char *default_reflog_action)
+int reset_head(struct repository *r, const struct reset_head_opts *opts)
 {
-	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
-	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
+	const struct object_id *oid = opts->oid;
+	const char *switch_to_branch = opts->branch;
+	unsigned reset_hard = opts->flags & RESET_HEAD_HARD;
+	unsigned refs_only = opts->flags & RESET_HEAD_REFS_ONLY;
+	unsigned update_orig_head = opts->flags & RESET_ORIG_HEAD;
 	struct object_id head_oid;
 	struct tree_desc desc[2] = { { NULL }, { NULL } };
 	struct lock_file lock = LOCK_INIT;
@@ -102,9 +104,7 @@ int reset_head(struct repository *r, struct object_id *oid,
 		oid = &head_oid;
 
 	if (refs_only)
-		return update_refs(oid, switch_to_branch, reflog_head,
-				   reflog_orig_head, default_reflog_action,
-				   flags);
+		return update_refs(opts, oid);
 
 	action = reset_hard ? "reset" : "checkout";
 	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
@@ -148,9 +148,7 @@ int reset_head(struct repository *r, struct object_id *oid,
 	}
 
 	if (oid != &head_oid || update_orig_head || switch_to_branch)
-		ret = update_refs(oid, switch_to_branch, reflog_head,
-				  reflog_orig_head, default_reflog_action,
-				  flags);
+		ret = update_refs(opts, oid);
 
 leave_reset_head:
 	rollback_lock_file(&lock);
diff --git a/reset.h b/reset.h
index 2daec804259..996d7f569b6 100644
--- a/reset.h
+++ b/reset.h
@@ -12,9 +12,30 @@
 #define RESET_HEAD_REFS_ONLY (1<<3)
 #define RESET_ORIG_HEAD (1<<4)
 
-int reset_head(struct repository *r, struct object_id *oid,
-	       const char *switch_to_branch, unsigned flags,
-	       const char *reflog_orig_head, const char *reflog_head,
-	       const char *default_reflog_action);
+struct reset_head_opts {
+	/* The oid of the commit to checkout/reset to. Defaults to HEAD */
+	const struct object_id *oid;
+	 /* Optional branch to switch to */
+	const char *branch;
+	/* Flags defined above */
+	unsigned flags;
+	 /*
+	  * Optional reflog message for HEAD, if this is not set then
+	  * default_reflog_action must be.
+	  */
+	const char *head_msg;
+	/*
+	 * Optional reflog message for ORIG_HEAD, if this is not set and flags
+	 * contains RESET_ORIG_HEAD then default_reflog_action must be set.
+	 */
+	const char *orig_head_msg;
+	/*
+	 * Action to use in default reflog messages, only required if a ref is
+	 * being updated and the reflog messages above are omitted.
+	 */
+	const char *default_reflog_action;
+};
+
+int reset_head(struct repository *r, const struct reset_head_opts *opts);
 
 #endif
diff --git a/sequencer.c b/sequencer.c
index 56a204f18c5..36ab6854c6b 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4109,6 +4109,7 @@ void create_autostash(struct repository *r, const char *path)
 	if (has_unstaged_changes(r, 1) ||
 	    has_uncommitted_changes(r, 1)) {
 		struct child_process stash = CHILD_PROCESS_INIT;
+		struct reset_head_opts ropts = { .flags = RESET_HEAD_HARD };
 		struct object_id oid;
 
 		strvec_pushl(&stash.args,
@@ -4130,10 +4131,8 @@ void create_autostash(struct repository *r, const char *path)
 			    path);
 		write_file(path, "%s", oid_to_hex(&oid));
 		printf(_("Created autostash: %s\n"), buf.buf);
-		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
-			       NULL) < 0)
+		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
-
 		if (discard_index(r->index) < 0 ||
 			repo_read_index(r) < 0)
 			die(_("could not read index"));
-- 
gitgitgadget

