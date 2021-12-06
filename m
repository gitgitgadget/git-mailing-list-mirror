Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D62C433FE
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 09:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbhLFJpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbhLFJpE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 04:45:04 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B04FC0613F8
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 01:41:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id l16so21076793wrp.11
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 01:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=/bSLprzqqi+R/m2aQorW9JyiWErV/Fh2ybEXf+ZYGcs=;
        b=qtQameW7HvgHz2GvQ3CK48z8nrrJV/H7591YcLud2Bu9fySWJ1VOe8qD4LvGBelQyf
         S+lABKyK/FrIcWc/PSEUm1u3PGbZMANsIEtd8HUsXVK4zUkJBMmqMVD7J2kXH/Aa+avi
         2yJXnNiEwtEcPwksXyk5163e8a7lY7B+553YYOZ1y+tpjLulWwjIUAXwah1f2XhZIUFo
         ALUxDQxkx3kwX9drME6ntP9x88k7wQTGCzyrQfFiHtAP8TnyrgcIqXtWNKsbiUjBGO93
         /N5Id0K/YsFWfclvsbE7s4Z0AJrqgFYiGFOxCYVtResqPZHLekDa2Q2RpPJpTQQFGHFN
         8jFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=/bSLprzqqi+R/m2aQorW9JyiWErV/Fh2ybEXf+ZYGcs=;
        b=z5oinXdmBgbc4FT0k/bla5hpBylzA7WLl+oj0jQGc0+zd1i68l8z/0W9/ZgC5qw8pF
         fMMILGH5DyVjCxs+SrUrt/BEZC9o9fZrXY3Lv8tngYYK5vkRjGPWph/1btyZ1rejXYpL
         EGbc2hh7C0GglQMxF/es7nrzvWUHXtTF4F6jTrvt22VScVPJTuGefD4imeb0eOs3tpJX
         3FvKdzrKpqYwOZT/S/O+xmtc7nqr38VYZJsRVa+0pkr09Nvq/3QFLpi8BjtpRoKHkWlf
         VYijLEernSYUuhVcKHUj/acwx+ZVfIIdDrQafoJk6B/+Q0ZBy0mZ01x4HkT+DinbjHO3
         MA4A==
X-Gm-Message-State: AOAM533asb90891rJt4LGsL8HuSyO6yRRl7Uj7HCop0y+JXlRhJLu9Hn
        aUb4pOyJ3HA5lyAD3h1BjywX8E0UUSg=
X-Google-Smtp-Source: ABdhPJwaP23DdMHjcox6AFtDqoCpWRv37LTgJEUWRpO7h89i29hZz//NStOPczDK/Wb22VaATwjtMA==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr43552668wre.140.1638783693763;
        Mon, 06 Dec 2021 01:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7sm10582481wrw.55.2021.12.06.01.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:41:33 -0800 (PST)
Message-Id: <d669406a312276e3601f1cc876006fddda051d8d.1638783690.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
References: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
        <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 09:41:30 +0000
Subject: [PATCH v15 3/3] am: support --allow-empty to record specific empty
 patches
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>,
        =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= 
        <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?=
 <aleen42@vip.qq.com>

This option helps to record specific empty patches in the middle
of an am session. However, it is a valid resume value only when:

    1. index has not changed
    2. lacking a branch

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  7 +++++-
 builtin/am.c             | 42 ++++++++++++++++++++++++-------
 t/t4150-am.sh            | 53 ++++++++++++++++++++++++++++++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  3 +++
 5 files changed, 96 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 4c31c39bf81..a5223143222 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	 [--quoted-cr=<action>]
 	 [--empty=(die|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
+'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)] | --allow-empty)
 
 DESCRIPTION
 -----------
@@ -200,6 +200,11 @@ default.   You can use `--no-utf8` to override this.
 	the e-mail message; if `diff`, show the diff portion only.
 	Defaults to `raw`.
 
+--allow-empty::
+	After a patch failure on an input e-mail message lacking a patch,
+	the user can still record the empty patch as an empty commit with
+	the contents of the e-mail message as its log.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index 43a3b1cf038..974924cb83d 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1830,7 +1830,8 @@ static void am_run(struct am_state *state, int resume)
 				die(_("Patch is empty."));
 				break;
 			case ERR_EMPTY_COMMIT:
-				printf_ln(_("Patch is empty."));
+				printf_ln(_("Patch is empty.\n"
+					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
 				die_user_resolve(state);
 				break;
 			}
@@ -1903,21 +1904,39 @@ next:
 /**
  * Resume the current am session after patch application failure. The user did
  * all the hard work, and we do not have to do any patch application. Just
- * trust and commit what the user has in the index and working tree.
+ * trust and commit what the user has in the index and working tree. If `allow_empty`
+ * is true, commit as an empty commit when there is no changes.
  */
-static void am_resolve(struct am_state *state)
+static void am_resolve(struct am_state *state, int allow_empty)
 {
+	int index_changed;
+
 	validate_resume_state(state);
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
-	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
-		printf_ln(_("No changes - did you forget to use 'git add'?\n"
-			"If there is nothing left to stage, chances are that something else\n"
-			"already introduced the same changes; you might want to skip this patch."));
+	/**
+	 * "--allow-empty" is a valid resume value only when:
+	 *   1. index has not changed
+	 *   2. lacking a patch
+	 */
+	index_changed = repo_index_has_changes(the_repository, NULL, NULL);
+	if (allow_empty && (index_changed || !is_empty_or_missing_file(am_path(state, "patch")))) {
+		printf_ln(_("Invalid resume value."));
 		die_user_resolve(state);
 	}
 
+	if (!index_changed) {
+		if (allow_empty)
+			printf_ln(_("No changes - record it as an empty commit."));
+		else {
+			printf_ln(_("No changes - did you forget to use 'git add'?\n"
+				    "If there is nothing left to stage, chances are that something else\n"
+				    "already introduced the same changes; you might want to skip this patch."));
+			die_user_resolve(state);
+		}
+	}
+
 	if (unmerged_cache()) {
 		printf_ln(_("You still have unmerged paths in your index.\n"
 			"You should 'git add' each file with resolved conflicts to mark them as such.\n"
@@ -2242,7 +2261,8 @@ enum resume_type {
 	RESUME_SKIP,
 	RESUME_ABORT,
 	RESUME_QUIT,
-	RESUME_SHOW_PATCH
+	RESUME_SHOW_PATCH,
+	RESUME_ALLOW_EMPTY
 };
 
 struct resume_mode {
@@ -2395,6 +2415,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
+		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+			N_("record the empty patch as an empty commit"),
+			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2503,7 +2526,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		am_run(&state, 1);
 		break;
 	case RESUME_RESOLVED:
-		am_resolve(&state);
+	case RESUME_ALLOW_EMPTY:
+		am_resolve(&state, resume.mode == RESUME_ALLOW_EMPTY ? 1 : 0);
 		break;
 	case RESUME_SKIP:
 		am_skip(&state);
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index f2b765644e5..3f81aa3d6a1 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1202,4 +1202,57 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
 	test_cmp actual expected
 '
 
+test_expect_success 'skip an empty patch in the middle of an am session' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty." err &&
+	grep "If you want to record it as an empty commit, run \"git am --allow-empty\"." err &&
+	git am --skip &&
+	test_path_is_missing .git/rebase-apply &&
+	git rev-parse empty-commit^ >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'record an empty patch as an empty commit in the middle of an am session' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty." err &&
+	grep "If you want to record it as an empty commit, run \"git am --allow-empty\"." err &&
+	git am --allow-empty &&
+	test_path_is_missing .git/rebase-apply &&
+	git show empty-commit --format="%s" >expected &&
+	git show HEAD --format="%s" >actual &&
+	test_cmp actual expected
+'
+
+test_expect_success 'cannot create empty commits when the index is changed' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	: >empty-file &&
+	git add empty-file &&
+	test_must_fail git am --allow-empty >err &&
+	grep "Invalid resume value." err
+'
+
+test_expect_success 'cannot create empty commits when there is a clean index due to merge conflicts' '
+	test_when_finished "git am --abort || :" &&
+	git rev-parse HEAD >expected &&
+	test_must_fail git am seq.patch &&
+	test_must_fail git am --allow-empty >err &&
+	grep "Invalid resume value." err &&
+	git rev-parse HEAD >actual &&
+	test_cmp actual expected
+'
+
+test_expect_success 'cannot create empty commits when there is unmerged index due to merge conflicts' '
+	test_when_finished "git am --abort || :" &&
+	git rev-parse HEAD >expected &&
+	test_must_fail git am -3 seq.patch &&
+	test_must_fail git am --allow-empty >err &&
+	grep "Invalid resume value." err &&
+	git rev-parse HEAD >actual &&
+	test_cmp actual expected
+'
+
 test_done
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 7f2956d77ad..9309becfe03 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -658,6 +658,7 @@ test_expect_success 'status in an am session: empty patch' '
 On branch am_empty
 You are in the middle of an am session.
 The current patch is empty.
+  (use "git am --allow-empty" to record this patch as an empty commit)
   (use "git am --skip" to skip this patch)
   (use "git am --abort" to restore the original branch)
 
diff --git a/wt-status.c b/wt-status.c
index 5d215f4e4f1..d578a0e9192 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1227,6 +1227,9 @@ static void show_am_in_progress(struct wt_status *s,
 		if (!s->state.am_empty_patch)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --continue\")"));
+		else
+			status_printf_ln(s, color,
+				_("  (use \"git am --allow-empty\" to record this patch as an empty commit)"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
-- 
gitgitgadget
