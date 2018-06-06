Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 850B11F403
	for <e@80x24.org>; Wed,  6 Jun 2018 09:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeFFJmH (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Jun 2018 05:42:07 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43277 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932457AbeFFJmF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jun 2018 05:42:05 -0400
Received: by mail-lf0-f66.google.com with SMTP id n15-v6so8069612lfn.10
        for <git@vger.kernel.org>; Wed, 06 Jun 2018 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yLXZZj6cjSVNWHYEwyynJQtSLqWFWWD9LGoJSejSO0Q=;
        b=P177YVmwUFqlfHVSyjTmclVQ0iks4/amrV1hmokRP6uxgJaeyVtnT+tC8sm1DCo4Kz
         Ft1M5L9ujcFPdIYWfw9N2xLN0ZD7wV29ORdUG5XKI+04RbihxZ9ALKnGl81ssO9n1zAh
         aCVJN6InaQVUgW1IqG+wSaNA0aQCXq+JNzawUEZmmdiGW1EKnTnNmSKz/3XYRuEJEJDM
         5tMP0+WwE4YFMcBCICo+hIRkIPPPPgiGGvdLzLaKDhfDma7JoDcUC07qCnAsVMYmPXn8
         BbKLs8OHYKta0EPLCQIeBNC3YUOI80M3N5vY6T3GBvqUpbXL0vo1Z9UADgRfe8mhWz7T
         fNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yLXZZj6cjSVNWHYEwyynJQtSLqWFWWD9LGoJSejSO0Q=;
        b=ZfyQW4xYSSF5W7ilWSpcC6B3whi7wcRsbnZ+XP4PnttU6AaM7WhdHewJ0JLS1YSu4n
         YLy9BfH9iRuTDl5nHQumPEk0A9/GTk5IR9Y4zIEaG+M0W7wWRz5BibpXzoFsiw/ip0yn
         EjTgUufn7pJi6rbWNydNQJEmRFvXPAbv1BxyinED5FuXyEXjsErObaQCCiMKCht7mAnN
         5QB9hFWaejxHcB8QxpMH5/KsC6VXG08mPdkts33ATXtX1PFdiMU5tzXokEatuQLReeER
         /U5H+tlhOE44vbC2N163wYxcqROzcTjHXK2hUEdm6qbEtpm3anrmGA+6QHWLpxQAqnr0
         KfvQ==
X-Gm-Message-State: APt69E29nTtDAgqNC6TjSOxF1BmbPfLz/405VaSznjsqQouAh8M99K31
        Fu1Pm5mC+3oFA9rRioL6sNM=
X-Google-Smtp-Source: ADUXVKKO05UxbGs0JctYOhxhKmtugs/0OVVg1nrYad0abo8/ua2o4+FUKFiX6A8le+vSDRYGKVU1cQ==
X-Received: by 2002:a2e:9d41:: with SMTP id y1-v6mr1545702ljj.112.1528278123602;
        Wed, 06 Jun 2018 02:42:03 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v2-v6sm2987062ljj.71.2018.06.06.02.42.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 02:42:02 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 1/3] parse-options: option to let --git-completion-helper show negative form
Date:   Wed,  6 Jun 2018 11:41:37 +0200
Message-Id: <20180606094139.30906-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.rc0.333.g22e6ee6cdf
In-Reply-To: <20180606094139.30906-1-pclouds@gmail.com>
References: <20180527083828.6919-1-pclouds@gmail.com>
 <20180606094139.30906-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When 7fb6aefd2a (Merge branch 'nd/parseopt-completion' - 2018-03-14)
is merged, the completion for negative form is left out because the
series is alread long and it could be done in a follow up series. This
is it.

--git-completion-helper now provides --no-xxx so that git-completion.bash
can drop the extra custom --no-xxx in the script. It adds a lot more
--no-xxx than what's current provided by the git-completion.bash
script. We'll trim that down later.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 contrib/completion/git-completion.bash | 38 ++++++++++----------------
 parse-options.c                        | 22 ++++++++++++---
 t/t9902-completion.sh                  | 16 +++++++++--
 3 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 961a0ed76f..952e660f06 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1126,7 +1126,7 @@ _git_am ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin am "--no-utf8" \
+		__gitcomp_builtin am "" \
 			"$__git_am_inprogress_options"
 		return
 	esac
@@ -1226,9 +1226,7 @@ _git_branch ()
 		__git_complete_refs --cur="${cur##--set-upstream-to=}"
 		;;
 	--*)
-		__gitcomp_builtin branch "--no-color --no-abbrev
-			--no-track --no-column
-			"
+		__gitcomp_builtin branch
 		;;
 	*)
 		if [ $only_local_ref = "y" -a $has_r = "n" ]; then
@@ -1269,7 +1267,7 @@ _git_checkout ()
 		__gitcomp "diff3 merge" "" "${cur##--conflict=}"
 		;;
 	--*)
-		__gitcomp_builtin checkout "--no-track --no-recurse-submodules"
+		__gitcomp_builtin checkout
 		;;
 	*)
 		# check if --track, --no-track, or --no-guess was specified
@@ -1332,7 +1330,7 @@ _git_clone ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp_builtin clone "--no-single-branch"
+		__gitcomp_builtin clone
 		return
 		;;
 	esac
@@ -1365,7 +1363,7 @@ _git_commit ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin commit "--no-edit --verify"
+		__gitcomp_builtin commit
 		return
 	esac
 
@@ -1468,7 +1466,7 @@ _git_fetch ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin fetch "--no-tags"
+		__gitcomp_builtin fetch
 		return
 		;;
 	esac
@@ -1505,7 +1503,7 @@ _git_fsck ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp_builtin fsck "--no-reflogs"
+		__gitcomp_builtin fsck
 		return
 		;;
 	esac
@@ -1612,7 +1610,7 @@ _git_ls_files ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp_builtin ls-files "--no-empty-directory"
+		__gitcomp_builtin ls-files
 		return
 		;;
 	esac
@@ -1763,12 +1761,7 @@ _git_merge ()
 
 	case "$cur" in
 	--*)
-		__gitcomp_builtin merge "--no-rerere-autoupdate
-				--no-commit --no-edit --no-ff
-				--no-log --no-progress
-				--no-squash --no-stat
-				--no-verify-signatures
-				"
+		__gitcomp_builtin merge
 		return
 	esac
 	__git_complete_refs
@@ -1867,10 +1860,7 @@ _git_pull ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin pull "--no-autostash --no-commit --no-edit
-					--no-ff --no-log --no-progress --no-rebase
-					--no-squash --no-stat --no-tags
-					--no-verify-signatures"
+		__gitcomp_builtin pull
 
 		return
 		;;
@@ -2061,7 +2051,7 @@ _git_status ()
 		return
 		;;
 	--*)
-		__gitcomp_builtin status "--no-column"
+		__gitcomp_builtin status
 		return
 		;;
 	esac
@@ -2615,7 +2605,7 @@ _git_remote ()
 
 	case "$subcommand,$cur" in
 	add,--*)
-		__gitcomp_builtin remote_add "--no-tags"
+		__gitcomp_builtin remote_add
 		;;
 	add,*)
 		;;
@@ -2695,7 +2685,7 @@ _git_revert ()
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp_builtin revert "--no-edit" \
+		__gitcomp_builtin revert "" \
 			"$__git_revert_inprogress_options"
 		return
 		;;
@@ -2765,7 +2755,7 @@ _git_show_branch ()
 {
 	case "$cur" in
 	--*)
-		__gitcomp_builtin show-branch "--no-color"
+		__gitcomp_builtin show-branch
 		return
 		;;
 	esac
diff --git a/parse-options.c b/parse-options.c
index 0f7059a8ab..b86612148f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -427,15 +427,12 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	parse_options_check(options);
 }
 
-/*
- * TODO: we are not completing the --no-XXX form yet because there are
- * many options that do not suppress it properly.
- */
 static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 			const struct option *opts)
 {
 	for (; opts->type != OPTION_END; opts++) {
 		const char *suffix = "";
+		int has_unset_form = 0;
 
 		if (!opts->long_name)
 			continue;
@@ -450,6 +447,8 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 		case OPTION_INTEGER:
 		case OPTION_MAGNITUDE:
 		case OPTION_CALLBACK:
+			has_unset_form = 1;
+
 			if (opts->flags & PARSE_OPT_NOARG)
 				break;
 			if (opts->flags & PARSE_OPT_OPTARG)
@@ -458,12 +457,27 @@ static int show_gitcomp(struct parse_opt_ctx_t *ctx,
 				break;
 			suffix = "=";
 			break;
+		case OPTION_BIT:
+		case OPTION_NEGBIT:
+		case OPTION_COUNTUP:
+		case OPTION_SET_INT:
+			has_unset_form = 1;
+			break;
 		default:
 			break;
 		}
 		if (opts->flags & PARSE_OPT_COMP_ARG)
 			suffix = "=";
 		printf(" --%s%s", opts->long_name, suffix);
+
+		if (has_unset_form && !(opts->flags & PARSE_OPT_NONEG)) {
+			const char *name;
+
+			if (skip_prefix(opts->long_name, "no-", &name))
+				printf(" --%s", name);
+			else
+				printf(" --no-%s", opts->long_name);
+		}
 	}
 	fputc('\n', stdout);
 	exit(0);
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 1b34caa1e1..07c3e3b760 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1237,20 +1237,31 @@ test_expect_success 'double dash "git" itself' '
 test_expect_success 'double dash "git checkout"' '
 	test_completion "git checkout --" <<-\EOF
 	--quiet Z
+	--no-quiet Z
 	--detach Z
+	--no-detach Z
 	--track Z
+	--no-track Z
 	--orphan=Z
+	--no-orphan Z
 	--ours Z
+	--no-ours Z
 	--theirs Z
+	--no-theirs Z
 	--merge Z
+	--no-merge Z
 	--conflict=Z
+	--no-conflict Z
 	--patch Z
+	--no-patch Z
 	--ignore-skip-worktree-bits Z
+	--no-ignore-skip-worktree-bits Z
 	--ignore-other-worktrees Z
+	--no-ignore-other-worktrees Z
 	--recurse-submodules Z
-	--progress Z
-	--no-track Z
 	--no-recurse-submodules Z
+	--progress Z
+	--no-progress Z
 	EOF
 '
 
@@ -1457,6 +1468,7 @@ test_expect_success 'completion used <cmd> completion for alias: !f() { : git <c
 test_expect_success 'completion without explicit _git_xxx function' '
 	test_completion "git version --" <<-\EOF
 	--build-options Z
+	--no-build-options Z
 	EOF
 '
 
-- 
2.18.0.rc0.333.g22e6ee6cdf

