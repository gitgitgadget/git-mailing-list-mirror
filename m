Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D0DC4332F
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 07:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhLIH3h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhLIH3e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 02:29:34 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2EEC0617A1
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 23:26:01 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso5807400wmr.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 23:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=FmFN0U8K3IVSKEAmqYWqF0sO3K3LF9JCGAfoRofATQY=;
        b=AeBf+INhu04wTb+Ma1oExJMnQioKteNp5yNvufHepabcfRRT8fNh6YrgnoU9wrcvkb
         Sm8eQL0M2yeb2BXqPFuucOGbK7euedS7g+k4CzrxF1Yc2DLvGyBL37CVp39W4oVdp25B
         7wU2mFxdkwn3ZFG/jjMJ1dU1k/heEjXHXMI/pUtI1IQoRWl8X/KdRCawMNphFV/YUclH
         FWP9TC+klCdLQ8ZzVPjAFim3PPRgnHiIvWetet3TnfkwRspnLhRctBqLquzSDqmcIHkn
         F7cLmZ2RP7jPQEoqd5q/yN0zQZ6s/rF2ro+L8huInMDGvWoOzV2SJUTjv5ZcLXkSu+l7
         Rxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=FmFN0U8K3IVSKEAmqYWqF0sO3K3LF9JCGAfoRofATQY=;
        b=QTkSk5aBLW/xbVVXxPscrBijkelQyIRRfqhBK2G2kVHIRUUQVo3MwcL/G2xFZr2AOd
         S/vNZk99zcSpTwgGKQjLjScVFGIVgHs5rtRlL+PNZ6BP6nqMCjM39oihxCwZhqtzKVrP
         dAW+3yPK16HtJzyV0Z0ciXBNhzhzxvGZlRurPup0WFI+VSQr+psxtfpS2l5L70s1tZ7o
         Ki5auVyrhwrbpA4L+xm20lbiE4V2fFN8RXIBQbecmRzXdC1bs7urPC0EsfgNze+ilkDB
         /u0u9cCCmTz9azjBlmkEKgAvQeDYPVCvYOcUP/UP1YigwWWK2lIFTAvJZHJUbahhtphy
         8QhQ==
X-Gm-Message-State: AOAM530UMvlZsuI7EYt4izx8IpopiYuSA6wNeAHzDUAXEfNBDJijf22Y
        iXH1ERot3lWCASoiehz2eN8Hg3gMeCs=
X-Google-Smtp-Source: ABdhPJxtWZd3Bot+vyfwa/cLoEOxbQknKLZN+yUSX53ObYApgjBEUh7HO7KtzrmLKDWKz17DMXae5g==
X-Received: by 2002:a05:600c:4f92:: with SMTP id n18mr4729217wmq.123.1639034759722;
        Wed, 08 Dec 2021 23:25:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 38sm5186480wrc.1.2021.12.08.23.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 23:25:59 -0800 (PST)
Message-Id: <37875e8d3130133ac3c897fddacc0bf186ba3b1c.1639034755.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
        <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 07:25:55 +0000
Subject: [PATCH v19 3/3] am: support --allow-empty to record specific empty
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

    1. the index has not changed
    2. lacking a branch

When the index has changed, "--allow-empty" will create a non-empty
commit like passing "--continue" or "--resolved".

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  7 ++++-
 builtin/am.c             | 32 ++++++++++++++++------
 t/t4150-am.sh            | 57 ++++++++++++++++++++++++++++++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  8 +++++-
 5 files changed, 95 insertions(+), 10 deletions(-)

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
index 7a66ad23737..f2e7e533881 100644
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
 
@@ -1900,19 +1906,24 @@ next:
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
 	validate_resume_state(state);
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
-		printf_ln(_("No changes - did you forget to use 'git add'?\n"
-			"If there is nothing left to stage, chances are that something else\n"
-			"already introduced the same changes; you might want to skip this patch."));
-		die_user_resolve(state);
+		if (allow_empty && is_empty_or_missing_file(am_path(state, "patch"))) {
+			printf_ln(_("No changes - recorded it as an empty commit."));
+		} else {
+			printf_ln(_("No changes - did you forget to use 'git add'?\n"
+				    "If there is nothing left to stage, chances are that something else\n"
+				    "already introduced the same changes; you might want to skip this patch."));
+			die_user_resolve(state);
+		}
 	}
 
 	if (unmerged_cache()) {
@@ -2239,7 +2250,8 @@ enum resume_type {
 	RESUME_SKIP,
 	RESUME_ABORT,
 	RESUME_QUIT,
-	RESUME_SHOW_PATCH
+	RESUME_SHOW_PATCH,
+	RESUME_ALLOW_EMPTY,
 };
 
 struct resume_mode {
@@ -2392,6 +2404,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
+		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+			N_("record the empty patch as an empty commit"),
+			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2500,7 +2515,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
index f2a7a68eda0..2db2c5dfe58 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1202,4 +1202,61 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
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
+test_expect_success 'create an non-empty commit when the index IS changed though "--allow-empty" is given' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	: >empty-file &&
+	git add empty-file &&
+	git am --allow-empty &&
+	git show empty-commit --format="%B" >expected &&
+	git show HEAD --format="%B" >actual &&
+	grep -f actual expected &&
+	git diff HEAD^..HEAD --name-only
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
