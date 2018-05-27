Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975F01F51C
	for <e@80x24.org>; Sun, 27 May 2018 08:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936185AbeE0Iip (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 May 2018 04:38:45 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33207 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934407AbeE0Iim (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 May 2018 04:38:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id x12-v6so38648879wmc.0
        for <git@vger.kernel.org>; Sun, 27 May 2018 01:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVVanqkJEK2STKp/Ya4PPpeLNJmhlZ38WPbGPr9HiOY=;
        b=sJc4LW0qrBqF6BMdf10VVHwQZm33+Kc1xuoZuyJT13Ss8GoxRg0JKcTC6T984I5S9Y
         8qflNMR52cg1tINZ83mnAq9EuQIZFmlCZjflM+Y990Fos9d9jYSt43b+ez+KiQaETpPa
         AR0bqB0VK40GiM9DuhQXwFx5FsPEuvQk8yfiGw9mx3YhFUeq93Io+aOQxn2KKdqr0cx2
         DX2FviNIqLkk8YdOPVYtbrZ4JZzy7LrSuMHdiwCTAl5fCEMkJaMH70J1rYsjlRrsU/7x
         nCffmrvq8aBsbEeD6yUDBh0Wypql3xkug5Jwki8oJrlaKTCbWkz3MGqRGGQt62QzlNOT
         TCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVVanqkJEK2STKp/Ya4PPpeLNJmhlZ38WPbGPr9HiOY=;
        b=cHSlaKJ6RWy2puCoOnDme2JqHBk7Pq+nwKkomCQs5nc8bDjuhoVqFR4BO2144/tV3L
         o8NNpaafoVXqtnGyr+4WORv561Qq5yoEOMWJ1xkex5E/NvPCJRwFTBnP+Cz+vSG8STnC
         F6J84CtXghcxhkNso2qKUCqhLLGiskEIDDSw7EXhHmTCyH6qK5zcwktZcUr69wdm1pe2
         rpPJNt+Mjhe0Mr47t+dPeDC5/DkR2ARPsP6rcO7O+FkSUFmg136N6iNTRtUzS314Jl1c
         myoBeDt6BRywRem0+o0eMTxtYvVT836SSEDf+9Yz5Q/S6Ix+FWqhy6I0Ual0Vy5fMhsZ
         lINw==
X-Gm-Message-State: ALKqPwcJnnQ7UuaaDHc5ab4rWLe0GHCd/cJ1baX4pFed/YY1P4h+SASq
        Y0pEE5d+UDJ1AJeOI39P/1cWOQ==
X-Google-Smtp-Source: AB8JxZpcnOyMEbGJCa6fgcK0itc7/swC/R+gF+WY7PI3yFlYSUDseg6bfd+o1mDM1TDYmq3uVEr25Q==
X-Received: by 2002:a2e:2402:: with SMTP id k2-v6mr5887232ljk.20.1527410321518;
        Sun, 27 May 2018 01:38:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id c1-v6sm5297468ljk.80.2018.05.27.01.38.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 May 2018 01:38:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] parse-options: option to let --git-completion-helper show negative form
Date:   Sun, 27 May 2018 10:38:26 +0200
Message-Id: <20180527083828.6919-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180527083828.6919-1-pclouds@gmail.com>
References: <20180417181300.23683-1-pclouds@gmail.com>
 <20180527083828.6919-1-pclouds@gmail.com>
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
2.17.0.705.g3525833791

