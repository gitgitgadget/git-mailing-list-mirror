Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C9EE1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 15:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966851AbeFSPpI (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 11:45:08 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34816 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966410AbeFSPpG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 11:45:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id j15-v6so1373266wme.0
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 08:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WpS9xC7hrPfefk1Q8gqUiVaWdG8g0Rk8Ag0S31EZ7j0=;
        b=ep3pmsSAl/IgEd5IlAFg01BWOhW7jC4KqlB/0sk5JS2khk/ZhCXQ61BVlhxa0ly7+d
         uVSaNEoc99X0ku4qMVtpZGsfy4v/wENK/YLoZ81YK+a3ZRlbCb8SKXbeq6YbLfGudNDc
         crHsaJqXn0o7Krx5h3f+KxbHJYu0gyqboevdvDdXdmh+k2OgnF1wzXcS56RTAIa3ML0+
         tg6t6TMhfXO+vkaPaE59LubprA6ZsOSrNBbN/RYydFNJ+CpqM8zjDYDadQn06n4PaKI3
         7wEIPm5nkSe4xDBw5Bq4qlzcUcu6oyRHFcEfrCXtlW7AYjf4Cfl7DHnUlPmJf3XvOjYg
         V8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WpS9xC7hrPfefk1Q8gqUiVaWdG8g0Rk8Ag0S31EZ7j0=;
        b=UqUIdqDV20ecLfxfniE14To8JcCY5THYNOBC2+kqkOviJboNChKZNz3lMBKiFjDe4A
         MBGDc4U99yC1Jpt+EQCSBtV6jPMk4y1gEeYMUEg53HaumpUN2B2a+PzWVnL1bPGkiQu+
         W5kn1fndLQx5Q2fKTc6cA+3DvZYRqpNGCZGi0vbf5aDTwWMlluQVggSUppAbye9RKpsA
         3KSgGIj2qDAXd6lEawNB/kaozauWFtqhf1FpmyS7hVTJtRG+LVgQSvYctkwuY/RZT7w/
         S/Al0lri5K5qSv69/P/Z4YWm5AXLGnS3NmhDzmW2SjckUkNlYcnby3dUHJEnyjWTQ2ha
         e2YA==
X-Gm-Message-State: APt69E3OsD2H8cHgwNSB4CgeqCmb9rtb4QAzHpQypwb1jTuzY0k6V7De
        VuiMDEsNwyQWvf3nnCPxADaHwTCG
X-Google-Smtp-Source: ADUXVKKrq7wsIoBBLLnviXYvARqeOsKgC+1rsZJZT/dDGqmaVwRnMfU14sf6VVWrgX4YFBE2rUs6Qw==
X-Received: by 2002:a1c:7153:: with SMTP id m80-v6mr11529053wmc.7.1529423104554;
        Tue, 19 Jun 2018 08:45:04 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-40-196.w86-221.abo.wanadoo.fr. [86.221.119.196])
        by smtp.googlemail.com with ESMTPSA id q77-v6sm596176wmg.25.2018.06.19.08.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 08:45:02 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v2 3/3] rebase -i: rewrite checkout_onto() in C
Date:   Tue, 19 Jun 2018 17:44:21 +0200
Message-Id: <20180619154421.14999-4-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180619154421.14999-1-alban.gruin@gmail.com>
References: <20180618131844.13408-1-alban.gruin@gmail.com>
 <20180619154421.14999-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites checkout_onto() from shell to C.

A new command (“checkout-onto”) is added to rebase--helper.c. The shell
version is then stripped.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 25 ++++---------------------
 sequencer.c                | 19 +++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 7cd74da2e..19c1dba9a 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -17,7 +17,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, CHECKOUT_BASE,
+		CHECKOUT_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -53,6 +54,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "checkout-base", &command,
 			    N_("checkout the base commit"), CHECKOUT_BASE),
+		OPT_CMDMODE(0, "checkout-onto", &command,
+			    N_("checkout a commit"), CHECKOUT_ONTO),
 		OPT_END()
 	};
 
@@ -98,5 +101,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == CHECKOUT_BASE && argc == 2)
 		return !!checkout_base_commit(&opts, argv[1], verbose);
+	if (command == CHECKOUT_ONTO && argc == 4)
+		return !!checkout_onto(&opts, argv[1], argv[2], argv[3], verbose);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index af46cf9c2..7b6142a76 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -28,17 +28,6 @@ case "$comment_char" in
 	;;
 esac
 
-orig_reflog_action="$GIT_REFLOG_ACTION"
-
-comment_for_reflog () {
-	case "$orig_reflog_action" in
-	''|rebase*)
-		GIT_REFLOG_ACTION="rebase -i ($1)"
-		export GIT_REFLOG_ACTION
-		;;
-	esac
-}
-
 die_abort () {
 	apply_autostash
 	rm -rf "$state_dir"
@@ -70,14 +59,6 @@ collapse_todo_ids() {
 	git rebase--helper --shorten-ids
 }
 
-# Switch to the branch in $into and notify it in the reflog
-checkout_onto () {
-	comment_for_reflog start
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
-	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
-	git update-ref ORIG_HEAD $orig_head
-}
-
 get_missing_commit_check_level () {
 	check_level=$(git config --get rebase.missingCommitsCheck)
 	check_level=${check_level:-ignore}
@@ -176,7 +157,8 @@ EOF
 
 	git rebase--helper --check-todo-list || {
 		ret=$?
-		checkout_onto
+		git rebase--helper --checkout-onto "$onto_name" "$onto" \
+		    "$orig_head" ${verbose:+--verbose}
 		exit $ret
 	}
 
@@ -186,7 +168,8 @@ EOF
 	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
 	die "Could not skip unnecessary pick commands"
 
-	checkout_onto
+	git rebase--helper --checkout-onto "$onto_name" "$onto" "$orig_head" \
+	    ${verbose:+--verbose}
 	require_clean_work_tree "rebase"
 	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
 	     --continue
diff --git a/sequencer.c b/sequencer.c
index a7a73e3ef..9165bf96c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3161,6 +3161,25 @@ int checkout_base_commit(struct replay_opts *opts, const char *commit,
 	return 0;
 }
 
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose)
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
index 42c3dda81..eda03ce32 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -102,6 +102,9 @@ void commit_post_rewrite(const struct commit *current_head,
 
 int checkout_base_commit(struct replay_opts *opts, const char *commit,
 			 int verbose);
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head, unsigned verbose);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.16.4

