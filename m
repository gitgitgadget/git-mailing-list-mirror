Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C671F447
	for <e@80x24.org>; Tue, 28 Aug 2018 12:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbeH1QCe (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:02:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39586 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeH1QCe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:02:34 -0400
Received: by mail-wr1-f66.google.com with SMTP id o37-v6so1352554wrf.6
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fnDeXbI0pf9jnsFWJy4t8NthnFGi87a2OFdqc8qEwgo=;
        b=Uf75K+XaZAA8ZbE1YiQnNeqMNYU3re1jlGel4KHx9CvgHO3pUgB1BGXBj8J/XzJaft
         uDoH+9ybYc/IWyq80p6KmNLSsyqnoTQpbkhwqprN0DFnWtXgTNKb3OGKo6XwiC0pfV+X
         kBMxlJ94iRXuIovb71S4PEJyKRZKbKGTjQkANnE/soopeVFwRA/TWzzvNW9od6vO/wR/
         1+FGD743UEWIYqIo1ywHnjQfjHWBj8af4/UsPbQEl7Cg+/ZxN+13t6fOUPVAbyirdIIZ
         myPuic9p14a0vBGNUQHv2Cwanf7lVBOa98RBzEO0LSkHpic1gS6vnm4+3oNnZ1heJtik
         8g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fnDeXbI0pf9jnsFWJy4t8NthnFGi87a2OFdqc8qEwgo=;
        b=uHZGMeMwEsEE25KlONvJP/Fx8rzSbDTL1PTy/xAqW2T49XG7ZYhlGU6uCgZL2IZ02X
         edCKR9hUH9rQfUnU95y4MZ/N4feIw35+896UeZ/L8gUk+km0k0IKCGUF2IHivWSbI4Kn
         OA2Z5kJ55ze2tVwvm0AQ2j5otcc+xbeJTiCQJAzN3QHJdYQiuHPyH9YjWs762E2YBsN+
         KPkJ6ZJuUAxAd1Hy7VcmAyNvLUuKSExE8B89SjuWPcf+vqn33TOs2AF9PoFUzC/KgVA2
         Pr3C+GLKkAerGTTZqF9kYCsjlsM+MjPlp1yfPOLP1kmz3vZaYoCY8zXzi2OZUrwiFh0v
         IUNQ==
X-Gm-Message-State: APzg51BoG1m0kFl8H6MK7uJjiRLBlR0xAC2fM32I7rLKXYNBVO+l3BNO
        GUwjWCj4peMxtgFkkRXLpchYuizb
X-Google-Smtp-Source: ANB0VdaHWTH8TyK+cpaAb6NB7uGgC8kHQj9hP0HZi+FWhf7nOgWJncwJiSeaD5FLPHLmrTzQmSsI1w==
X-Received: by 2002:adf:f28c:: with SMTP id k12-v6mr968188wro.263.1535458270648;
        Tue, 28 Aug 2018 05:11:10 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-33-140.w86-221.abo.wanadoo.fr. [86.221.112.140])
        by smtp.googlemail.com with ESMTPSA id y206-v6sm1702790wmg.14.2018.08.28.05.11.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:11:09 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v7 06/20] rebase -i: rewrite setup_reflog_action() in C
Date:   Tue, 28 Aug 2018 14:10:31 +0200
Message-Id: <20180828121045.14933-7-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180828121045.14933-1-alban.gruin@gmail.com>
References: <20180810165147.4779-1-alban.gruin@gmail.com>
 <20180828121045.14933-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This rewrites (the misnamed) setup_reflog_action() from shell to C. The
new version is called prepare_branch_to_be_rebased().

A new command is added to rebase--helper.c, “checkout-base”, as well as
a new flag, “verbose”, to avoid silencing the output of the checkout
operation called by checkout_base_commit().

The function `run_git_checkout()` will also be used in the next commit,
therefore its code is not part of `checkout_base_commit()`.

The shell version is then stripped in favour of a call to the helper.

As $GIT_REFLOG_ACTION is no longer set at the first call of
checkout_onto(), a call to comment_for_reflog() is added at the
beginning of this function.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
No changes since v6.

 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 16 ++--------------
 sequencer.c                | 30 ++++++++++++++++++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 731a64971d..0e76dadba6 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -18,7 +18,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -28,6 +28,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "rebase-merges", &rebase_merges, N_("rebase merge commits")),
 		OPT_BOOL(0, "rebase-cousins", &rebase_cousins,
 			 N_("keep original branch points of cousins")),
+		OPT__VERBOSE(&opts.verbose, N_("be verbose")),
 		OPT_CMDMODE(0, "continue", &command, N_("continue rebase"),
 				CONTINUE),
 		OPT_CMDMODE(0, "abort", &command, N_("abort rebase"),
@@ -51,6 +52,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE(0, "edit-todo", &command,
 			    N_("edit the todo list during an interactive rebase"),
 			    EDIT_TODO),
+		OPT_CMDMODE(0, "prepare-branch", &command,
+			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
 		OPT_END()
 	};
 
@@ -94,5 +97,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!append_todo_help(0, keep_empty);
 	if (command == EDIT_TODO && argc == 1)
 		return !!edit_todo_list(flags);
+	if (command == PREPARE_BRANCH && argc == 2)
+		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 2defe607f4..77e972bb6c 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -72,6 +72,7 @@ collapse_todo_ids() {
 
 # Switch to the branch in $into and notify it in the reflog
 checkout_onto () {
+	comment_for_reflog start
 	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
 	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
 	git update-ref ORIG_HEAD $orig_head
@@ -119,19 +120,6 @@ initiate_action () {
 	esac
 }
 
-setup_reflog_action () {
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
-	fi
-}
-
 init_basic_state () {
 	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
 	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
@@ -211,7 +199,7 @@ git_rebase__interactive () {
 		return 0
 	fi
 
-	setup_reflog_action
+	git rebase--helper --prepare-branch "$switch_to" ${verbose:+--verbose}
 	init_basic_state
 
 	init_revisions_and_shortrevisions
diff --git a/sequencer.c b/sequencer.c
index eaa1aa7deb..c1cfa2ee5c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3141,6 +3141,36 @@ static const char *reflog_message(struct replay_opts *opts,
 	return buf.buf;
 }
 
+static int run_git_checkout(struct replay_opts *opts, const char *commit,
+			    const char *action)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+
+	cmd.git_cmd = 1;
+
+	argv_array_push(&cmd.args, "checkout");
+	argv_array_push(&cmd.args, commit);
+	argv_array_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
+
+	if (opts->verbose)
+		return run_command(&cmd);
+	else
+		return run_command_silent_on_success(&cmd);
+}
+
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
+{
+	const char *action;
+
+	if (commit && *commit) {
+		action = reflog_message(opts, "start", "checkout %s", commit);
+		if (run_git_checkout(opts, commit, action))
+			return error(_("could not checkout %s"), commit);
+	}
+
+	return 0;
+}
+
 static const char rescheduled_advice[] =
 N_("Could not execute the todo command\n"
 "\n"
diff --git a/sequencer.h b/sequencer.h
index 792e448b67..f619b02a13 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -109,6 +109,8 @@ int update_head_with_reflog(const struct commit *old_head,
 void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
+int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
 void print_commit_summary(const char *prefix, const struct object_id *oid,
-- 
2.18.0

