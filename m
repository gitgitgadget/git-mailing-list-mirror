Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E772B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbeHJTXF (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 15:23:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34872 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729651AbeHJTXF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 15:23:05 -0400
Received: by mail-wm0-f66.google.com with SMTP id o18-v6so2599982wmc.0
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z92Xkx+QkAuM5jyF1vtuPmxcinySrYGfx1yB8ZwTlHg=;
        b=RyI3LuZDE+yIHnLRXxCQURAOC1uNHwUvCi4U3NiOm61ODl/MupvASXRL9dKfj+yVUJ
         YgeFVhW9j7Llcu2Nj/YnOzSlempNXZljiO5o/HSzu2iL3NvDQl9DaH1uxdWHEm+wDwlv
         HUodkMYzctYpzCNScE1/J5xQuhWUlH1yeJDio6kuXAd1F2w8wVcVhXUeRwnvg0AZJnI5
         x1tBPs3zdfGa4dePCRt9KfO/VbRhqIH7tydjrVxFFttuU6xuVDRCUsN2HJ9YuZIaiiWF
         BMMp+Oie1u+J+mTh48HYgrxlCtVTzRdtEHT/lc7zlEb4Ehhy3DYeJ0iB1A7DFyu/Zfr5
         AgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z92Xkx+QkAuM5jyF1vtuPmxcinySrYGfx1yB8ZwTlHg=;
        b=UjG1nOBK+SuXARuCBUKpXomNy8HjtXLoiGvdSuC0xTY0eDDmQZVTsINuAa/Vcrfqhe
         GBa8ge0hbolFY00XLBbIMKACYUxbp8jt9HfmsAWyOBNrpVYNYC5aAQcDDzG9QpaK6+OC
         GGFiduIzQApMF3Ga21QHEd5ta0lf9LutK6hi7Vh2qHBL1JVh3OrI/80XaVK3HjP5cyGG
         KFUBNk1QbKaN2n3Nv6Jo4Wi6A3ooBdISm9ShpDEs2nYdSvqGPOKN9SUCAT4K8B1H/hlF
         4h34JSNt7bCoarc30tAX1CKUvTmiJPCQ3Rg8Z/6Nkk2oyCyfzaXpt4ucQJfdJi90dsS5
         ebjA==
X-Gm-Message-State: AOUpUlGDJQUk/KohTx/0s0EDM83+uqHDr8PDOEFP7MwxoPnbF4MPmqVT
        Zj1ycDggtR588LU3yKM3vhjFld8L
X-Google-Smtp-Source: AA+uWPxsHozjEljHmQRy5ccENH2XnJsLnxx6S466OAhpx7MfOnoLi11zMWmvIoIsCbhBWTdRSFGC5A==
X-Received: by 2002:a1c:4405:: with SMTP id r5-v6mr1904535wma.4.1533919945650;
        Fri, 10 Aug 2018 09:52:25 -0700 (PDT)
Received: from localhost.localdomain (AToulouse-658-1-25-156.w86-222.abo.wanadoo.fr. [86.222.24.156])
        by smtp.googlemail.com with ESMTPSA id i125-v6sm3108302wmd.23.2018.08.10.09.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 09:52:24 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk, gitster@pobox.com,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [GSoC][PATCH v6 07/20] rebase -i: rewrite checkout_onto() in C
Date:   Fri, 10 Aug 2018 18:51:34 +0200
Message-Id: <20180810165147.4779-8-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810165147.4779-1-alban.gruin@gmail.com>
References: <20180731180003.5421-1-alban.gruin@gmail.com>
 <20180810165147.4779-1-alban.gruin@gmail.com>
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
No changes since v5.

 builtin/rebase--helper.c   |  7 ++++++-
 git-rebase--interactive.sh | 25 ++++---------------------
 sequencer.c                | 19 +++++++++++++++++++
 sequencer.h                |  3 +++
 4 files changed, 32 insertions(+), 22 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 0e76dadba6..7d9426d23c 100644
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
 
@@ -99,5 +102,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!edit_todo_list(flags);
 	if (command == PREPARE_BRANCH && argc == 2)
 		return !!prepare_branch_to_be_rebased(&opts, argv[1]);
+	if (command == CHECKOUT_ONTO && argc == 4)
+		return !!checkout_onto(&opts, argv[1], argv[2], argv[3]);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 77e972bb6c..b68f108f28 100644
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
index c1cfa2ee5c..48447d7f0e 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3171,6 +3171,25 @@ int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit)
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
index f619b02a13..d2b54adf45 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -110,6 +110,9 @@ void commit_post_rewrite(const struct commit *current_head,
 			 const struct object_id *new_head);
 
 int prepare_branch_to_be_rebased(struct replay_opts *opts, const char *commit);
+int checkout_onto(struct replay_opts *opts,
+		  const char *onto_name, const char *onto,
+		  const char *orig_head);
 
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
-- 
2.18.0

