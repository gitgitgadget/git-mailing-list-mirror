Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84CF2C4332F
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 05:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhLHFJa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 00:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhLHFJX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 00:09:23 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23794C0617A1
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 21:05:52 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a18so1909089wrn.6
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 21:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=I2/UHoGvNm+CocZZ9iXxsHRP3NzmJ8S8OkdpcGjzFpw=;
        b=IlRq2lN6UXt8E3S67hIOSqYwphZeomC5qjbyKT9Q8vY8M3wDFOp33gJmpUjC6TeWoh
         ccgt4eKlPkWUoADy6nsxdeRHhQA7R0EFyOmuuhmLJ0bXuj+kDukLIUDpiXQ+3ZVQRPjG
         rzN+5KOPsrj2+d1e9yUcnL3qWo1WREq2pHKlBMrnRPim9a2ge6UwYHCWxq3nXYPr2haB
         /RHrqpDR7KMcYScJqCD451U4OCpcF965TcCXQrLcLQWT3V8IQ1BQJLdvZkrR2ooVV6Ki
         dcfUOINcjGMjqCjyzEgLnct8IWt9SR8kHtKPtsOsr+lTODcF8fU2G8Ws5eIiArbYjagW
         WngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=I2/UHoGvNm+CocZZ9iXxsHRP3NzmJ8S8OkdpcGjzFpw=;
        b=oBFQrnJ6EpqUCpfv2bvsw7qMVjA3qk4Z0peuj1NuUOnX+fXAqmBdv1poRnmxxfx8NJ
         KOllpVLXbK4rv0dIoFcWFNX0dVHYXN72eOOP7dn9Ibtx313TaBWV8MfKVlXmBQ5l+54j
         ZjnfzJXnwFlVDya+9C6/MpJxB3Q6xbz8W+JUcdkeVyZ1F2rXrzeQwbicVEZuwYZjf2GF
         h6u1k1FuZyvYuXdjQUH8Ydeusf/GGrQTXafQGFkdRtU27t0T7GltLCV/bh8ffcOpw32B
         kU2K9qDBXEsDrzDt/5edtgAHXvsi11Fis/w39E9jl/EPADJCsdfNF4gwA+Qw3e9HfYyR
         EH+Q==
X-Gm-Message-State: AOAM533q1eyIA1NX/1HOgo10DIo0qRG9bB95Q4eiMNJa1EwUk5CwVgCE
        n7gYbq5SqqcKlgYsZDc9LasQ150oSm0=
X-Google-Smtp-Source: ABdhPJwRAtJeqJotKuuCHhyMnZS8oPvOMsXWD8rDT0+63qsxOpMuMTAicw9eRIshH+RS8264Iqqs3g==
X-Received: by 2002:a05:6000:1862:: with SMTP id d2mr55362618wri.203.1638939950299;
        Tue, 07 Dec 2021 21:05:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm1559444wrq.29.2021.12.07.21.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:05:50 -0800 (PST)
Message-Id: <4c3077f938435508850727e05ad514035f09bebb.1638939946.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
References: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
        <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 05:05:46 +0000
Subject: [PATCH v18 3/3] am: support --allow-empty to record specific empty
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
of an am session, which does create empty commits only when:

    1. index has not changed
    2. lacking a branch

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  7 +++++-
 builtin/am.c             | 39 +++++++++++++++++++++++------
 t/t4150-am.sh            | 54 ++++++++++++++++++++++++++++++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  8 +++++-
 5 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 7676bd58ae7..09107fb1067 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -18,7 +18,7 @@ SYNOPSIS
 	 [--quoted-cr=<action>]
 	 [--empty=(stop|drop|keep)]
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
+	create an empty commit with the contents of the e-mail message
+	as its log message.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index 7a66ad23737..d73e415bbb0 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1152,6 +1152,12 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 
 		printf_ln(_("When you have resolved this problem, run \"%s --continue\"."), cmdline);
 		printf_ln(_("If you prefer to skip this patch, run \"%s --skip\" instead."), cmdline);
+
+		if (advice_enabled(ADVICE_AM_WORK_DIR) &&
+		    is_empty_or_missing_file(am_path(state, "patch")) &&
+		    !repo_index_has_changes(the_repository, NULL, NULL))
+			printf_ln(_("To record the empty patch as an empty commit, run \"%s --allow-empty\"."), cmdline);
+
 		printf_ln(_("To restore the original branch and stop patching, run \"%s --abort\"."), cmdline);
 	}
 
@@ -1900,19 +1906,31 @@ next:
 /**
  * Resume the current am session after patch application failure. The user did
  * all the hard work, and we do not have to do any patch application. Just
- * trust and commit what the user has in the index and working tree.
+ * trust and commit what the user has in the index and working tree. If `allow_empty`
+ * is true, commit as an empty commit when index has not changed and lacking a patch.
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
+	index_changed = repo_index_has_changes(the_repository, NULL, NULL);
+	if (allow_empty &&
+	    !(!index_changed && is_empty_or_missing_file(am_path(state, "patch"))))
 		die_user_resolve(state);
+
+	if (!index_changed) {
+		if (allow_empty) {
+			printf_ln(_("No changes - recorded it as an empty commit."));
+		} else {
+			printf_ln(_("No changes - did you forget to use 'git add'?\n"
+				    "If there is nothing left to stage, chances are that something else\n"
+				    "already introduced the same changes; you might want to skip this patch."));
+			die_user_resolve(state);
+		}
 	}
 
 	if (unmerged_cache()) {
@@ -2239,7 +2257,8 @@ enum resume_type {
 	RESUME_SKIP,
 	RESUME_ABORT,
 	RESUME_QUIT,
-	RESUME_SHOW_PATCH
+	RESUME_SHOW_PATCH,
+	RESUME_ALLOW_EMPTY,
 };
 
 struct resume_mode {
@@ -2392,6 +2411,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
+		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+			N_("record the empty patch as an empty commit"),
+			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2500,7 +2522,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
index f2a7a68eda0..6b23384685b 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1202,4 +1202,58 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
 	grep "Creating an empty commit: empty commit" output
 '
 
+test_expect_success 'skip an empty patch in the middle of an am session' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty." err &&
+	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
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
+	grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	git am --allow-empty >output &&
+	grep "No changes - recorded it as an empty commit." output &&
+	test_path_is_missing .git/rebase-apply &&
+	git show empty-commit --format="%B" >expected &&
+	git show HEAD --format="%B" >actual &&
+	grep -f actual expected
+'
+
+test_expect_success 'cannot create empty commits when the index is changed' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	: >empty-file &&
+	git add empty-file &&
+	test_must_fail git am --allow-empty >err &&
+	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err
+'
+
+test_expect_success 'cannot create empty commits when there is a clean index due to merge conflicts' '
+	test_when_finished "git am --abort || :" &&
+	git rev-parse HEAD >expected &&
+	test_must_fail git am seq.patch &&
+	test_must_fail git am --allow-empty >err &&
+	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	git rev-parse HEAD >actual &&
+	test_cmp actual expected
+'
+
+test_expect_success 'cannot create empty commits when there is unmerged index due to merge conflicts' '
+	test_when_finished "git am --abort || :" &&
+	git rev-parse HEAD >expected &&
+	test_must_fail git am -3 seq.patch &&
+	test_must_fail git am --allow-empty >err &&
+	! grep "To record the empty patch as an empty commit, run \"git am --allow-empty\"." err &&
+	git rev-parse HEAD >actual &&
+	test_cmp actual expected
+'
+
 test_done
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 7f2956d77ad..2f16d5787ed 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -659,6 +659,7 @@ On branch am_empty
 You are in the middle of an am session.
 The current patch is empty.
   (use "git am --skip" to skip this patch)
+  (use "git am --allow-empty" to record this patch as an empty commit)
   (use "git am --abort" to restore the original branch)
 
 nothing to commit (use -u to show untracked files)
diff --git a/wt-status.c b/wt-status.c
index 5d215f4e4f1..335e723a71e 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1218,17 +1218,23 @@ static void show_merge_in_progress(struct wt_status *s,
 static void show_am_in_progress(struct wt_status *s,
 				const char *color)
 {
+	int am_empty_patch;
+
 	status_printf_ln(s, color,
 		_("You are in the middle of an am session."));
 	if (s->state.am_empty_patch)
 		status_printf_ln(s, color,
 			_("The current patch is empty."));
 	if (s->hints) {
-		if (!s->state.am_empty_patch)
+		am_empty_patch = s->state.am_empty_patch;
+		if (!am_empty_patch)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --continue\")"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --skip\" to skip this patch)"));
+		if (am_empty_patch)
+			status_printf_ln(s, color,
+				_("  (use \"git am --allow-empty\" to record this patch as an empty commit)"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --abort\" to restore the original branch)"));
 	}
-- 
gitgitgadget
