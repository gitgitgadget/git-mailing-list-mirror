Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E47DB1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 13:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933957AbeFYNow (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 09:44:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50703 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755569AbeFYNos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 09:44:48 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so9343319wmd.0
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S4abVajqHpDwaDGRcD4CqnBmFMKSZjUUk4+vkVsLV9U=;
        b=byVK8KrsKszuKqyv1sxLr0HDEiW0XXmQApuV95f90+nom/VUlnKUcVESJNbfByItlQ
         1jesWrq5rw4Twqm8Q2MwjkIIpwJfi8jUc3GdZjMwcV9Dn3XRCy/W6E+crh9shF+tAHsE
         ZD1mw6HnhXJazC1jdDaSUATUIceF492cV2eAj1khn2boepqEh/g7Oe8L3utgTmrTd2xv
         PfIxzFq5hhfE+UcLtDiSKpAfHX6x1m7CijIe+B5DsRfp18rtA1O4xm/WhLlTehIFVBpC
         fDb7BopR5ECsUmTa2ALW4+Vgl+aXqsZOxC0G8qH/G8rWxZ9LZDyWNDIOumf3jCjMnuRQ
         +YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S4abVajqHpDwaDGRcD4CqnBmFMKSZjUUk4+vkVsLV9U=;
        b=rCgsIqsJsQ17yW5L83fYjDyJp8sFLiNyKqiLAQFy8a12WYZKO6HAJxSimiC+uOsrAn
         wDkuoLRsJ0T2tdT+W4TsCoqWiBlkIYLf2H4BqbUYaDZH9+kddIbVdFQcMBg9dHkfCEDd
         69GEo8tMUVRxkSP6+yMoyk/mtVHDu8JzmA3OtDUNvc0lvvMOaEobPO9ljLcwLxPvnUos
         Wi2Lq9rqiw6iQQHyL4LA3IaW1zlVYWEuNOKtRBzeWvFh4BgAUVscCM0k9SpvFbtJao1Q
         R+hSzEdh+vK9PXugwmJ4mVffOehAr3fTmDPE8hmAXdwmBL8IwlDfInZh1+VlrmElG77A
         hgDQ==
X-Gm-Message-State: APt69E02mmX8VMd7wlq8V3u3Jd3zQFlXNORSEayWl/9TkadwFLy+vS8e
        1mWy08kodQellsxgBNK8Y8PqzUYQ
X-Google-Smtp-Source: AAOMgpdSjTRa8rGgxE3UQlpN2Lm3QNojkS+FZMzhauTOLoCgQejQxhAR9/v/GG4ycUwdK+FvFqKO2A==
X-Received: by 2002:a1c:bfc8:: with SMTP id o69-v6mr1193093wmi.8.1529934286907;
        Mon, 25 Jun 2018 06:44:46 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-38-233.w86-221.abo.wanadoo.fr. [86.221.117.233])
        by smtp.googlemail.com with ESMTPSA id 13-v6sm11020369wmi.2.2018.06.25.06.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 06:44:45 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v4 2/3] rebase -i: rewrite checkout_onto() in C
Date:   Mon, 25 Jun 2018 15:44:18 +0200
Message-Id: <20180625134419.18435-3-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180625134419.18435-1-alban.gruin@gmail.com>
References: <20180621141732.19952-1-alban.gruin@gmail.com>
 <20180625134419.18435-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites checkout_onto() from shell to C. The new version is called
detach_onto(), given its role.

A new command (“detach-onto”) is added to rebase--helper.c, as well as
a new flag, “verbose”, to avoid silencing the output of the checkout
operation called by detach_onto().

The function `run_git_checkout()` will also be used in the next commit,
therefore its code is not part of `detach_onto()`.

The shell version is then stripped in favour of a call to the helper.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  9 +++++++--
 git-rebase--interactive.sh | 13 ++++---------
 sequencer.c                | 36 ++++++++++++++++++++++++++++++++++++
 sequencer.h                |  4 ++++
 4 files changed, 51 insertions(+), 11 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index d2990b210..2dfd55c76 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -12,12 +12,12 @@ static const char * const builtin_rebase_helper_usage[] = {
 int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 {
 	struct replay_opts opts = REPLAY_OPTS_INIT;
-	unsigned flags = 0, keep_empty = 0, rebase_merges = 0;
+	unsigned flags = 0, keep_empty = 0, rebase_merges = 0, verbose = 0;
 	int abbreviate_commands = 0, rebase_cousins = -1;
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, DETACH_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -27,6 +27,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -50,6 +51,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "detach-onto", &command,
+			    N_("checkout a commit"), DETACH_ONTO),
 		OPT_END()
 	};
 
@@ -93,5 +96,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == DETACH_ONTO && argc == 4)
+		return !!detach_onto(&opts, argv[1], argv[2], argv[3], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f..2f5761d49 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -70,13 +70,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Switch to the branch in $into and notify it in the reflog
-checkout_onto () {
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
-	git update-ref ORIG_HEAD $orig_head
-}
-
 get_missing_commit_check_level () {
 	check_level=$(git config --get rebase.missingCommitsCheck)
 	check_level=${check_level:-ignore}
@@ -188,7 +181,8 @@ EOF
 
 	git rebase--helper --check-todo-list || {
 		ret=$?
-		checkout_onto
+		git rebase--helper --detach-onto "$onto_name" "$onto" \
+		    "$orig_head" ${verbose:+--verbose}
 		exit $ret
 	}
 
@@ -198,7 +192,8 @@ EOF
 	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
 	die "Could not skip unnecessary pick commands"
 
-	checkout_onto
+	git rebase--helper --detach-onto "$onto_name" "$onto" "$orig_head" \
+	    ${verbose:+--verbose}
 	require_clean_work_tree "rebase"
 	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
 	     --continue
diff --git a/sequencer.c b/sequencer.c
index 9a9725e23..ee6374921 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3129,6 +3129,42 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int run_git_checkout(struct replay_opts *opts, const char *commit,
+				int verbose, const char *action)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	argv_array_push(&cmd.args, "checkout");
+	argv_array_push(&cmd.args, commit);
+	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+
+	if (verbose)
+		return run_command(&cmd);
+	else
+		return run_command_silent_on_success(&cmd);
+}
+
+int detach_onto(struct replay_opts *opts,
+		const char *onto_name, const char *onto,
+		const char *orig_head, unsigned verbose)
+{
+	struct object_id oid;
+	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
+
+	if (get_oid(orig_head, &oid))
+		return error(_("%s: not a valid OID"), orig_head);
+
+	if (run_git_checkout(opts, onto, verbose, action)) {
+		apply_autostash(opts);
+		sequencer_remove_state(opts);
+		return error(_("could not detach HEAD"));
+	}
+
+	return update_ref(NULL, "ORIG_HEAD", &oid, NULL, 0, UPDATE_REFS_MSG_ON_ERR);
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 35730b13e..9f0ac5e75 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -100,6 +100,10 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int detach_onto(struct replay_opts *opts,
+		const char *onto_name, const char *onto,
+		const char *orig_head, unsigned verbose);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.18.0

