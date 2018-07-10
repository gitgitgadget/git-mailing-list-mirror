Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B9D1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 12:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeGJMRZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 08:17:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42210 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933176AbeGJMRY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:24 -0400
Received: by mail-wr1-f66.google.com with SMTP id p1-v6so14373643wrs.9
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 05:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GXXnZGyZFhbpMmJB2e/uLEXVQqlRzQaA6/FrOVnAssc=;
        b=eKQDR77f8O4YNkcEcAiFApJ5Hxiru3JwRaf15Yj2xz2jQ+w9IPbaKAU5mixHekCKTJ
         KAcUQWa0WnkeFDVsB+ARg+SK6/X5N2wjsbcnw1WMpI6ZopGCJVLl/8mO64hfKNkC+vAZ
         d1vTl0NqivqFz3NvcqbTsVqz9lceuZ+LHUwUOt69lqQwtZ8mTCyTcaovb70mLn9I3S6A
         IrRrWljENnRB6sffm08LcxcxRpz6vIyPHs+IFy2rPei4/IOXkJiNEDFKfOLhY4zd8VS+
         HLheG+Jo2JcjIvgUifxYn3sFcFhUukhNDGeTTbHFnSKnDzDhsMI6ncOmYW9x0E1serKv
         2IDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GXXnZGyZFhbpMmJB2e/uLEXVQqlRzQaA6/FrOVnAssc=;
        b=sbGH1H/nujYZdO53+26mAhaOFw9A/HUdgyfFz6OeTKwC5qHvvWELrciRRfkW9SFwVI
         xygDJuIT2v/CEy2Ce4jytyHSqrBaV35F9F/1aSQm1BSNLO/Fs30fuWdTiw5mBYXj486I
         xX4rqhL/DEYCAeQN9slQb2eKZDttEOzME1rbsmmHc27ZsgZX5dVJWO0jwTv3LfbQIYWz
         /m/qQ6d58QC4NboO/xp29lLILbo2Ov0ylNLil2u3e7/Uxo+HQcX+nNyJqfMxzrOlpX1G
         rf8qxnifP6niqLmBazRMhU7ViwkD2t7UCjdFeTWuAX719aFc3oNU/EHBCq8Iqm8x57bn
         QBfg==
X-Gm-Message-State: APt69E27vhww6UjJvLCvInP9dJx/0Tw1M9fYWULjgzm19HtaYyOjSb+M
        psfMXxg6f+3xWKsPWP4udzXQlnRO
X-Google-Smtp-Source: AAOMgpcjdWU5eZg58WzAq8AknD+xrwNokGk+j5r3VLVgSUrVJNjWGjHcR/k32SBQneNoCQLsa3fnmw==
X-Received: by 2002:a5d:4091:: with SMTP id o17-v6mr16120116wrp.133.1531225042683;
        Tue, 10 Jul 2018 05:17:22 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-239-37.w90-38.abo.wanadoo.fr. [90.38.238.37])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm28244334wre.95.2018.07.10.05.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 05:17:21 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v3 07/13] rebase -i: rewrite checkout_onto() in C
Date:   Tue, 10 Jul 2018 14:15:51 +0200
Message-Id: <20180710121557.6698-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180710121557.6698-1-alban.gruin@gmail.com>
References: <20180702105717.26386-1-alban.gruin@gmail.com>
 <20180710121557.6698-1-alban.gruin@gmail.com>
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
index 76bdc6fdb..1d9595bdb 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -18,7 +18,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	enum {
 		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_OIDS, EXPAND_OIDS,
 		CHECK_TODO_LIST, SKIP_UNNECESSARY_PICKS, REARRANGE_SQUASH,
-		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH
+		ADD_EXEC, APPEND_TODO_HELP, EDIT_TODO, PREPARE_BRANCH,
+		CHECKOUT_ONTO
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -54,6 +55,8 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 			    EDIT_TODO),
 		OPT_CMDMODE(0, "prepare-branch", &command,
 			    N_("prepare the branch to be rebased"), PREPARE_BRANCH),
+		OPT_CMDMODE(0, "checkout-onto", &command,
+			    N_("checkout a commit"), CHECKOUT_ONTO),
 		OPT_END()
 	};
 
@@ -100,5 +103,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
+	if (command == CHECKOUT_ONTO && argc == 4)
+		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 77e972bb6..b68f108f2 100644
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
index b5ea35f21..2b6ddc6cf 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3162,6 +3162,25 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
 	return 0;
 }
 
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head)
+{
+	struct object_id oid;
+	const char *action = reflog_message(opts, "start", "checkout %s", onto_name);
+
+	if (get_oid(orig_head, &oid))
+		return error(_("%s: not a valid OID"), orig_head);
+
+	if (run_git_checkout(opts, onto, action)) {
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
index 93da713fe..11a533461 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -107,6 +107,9 @@ void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.18.0

