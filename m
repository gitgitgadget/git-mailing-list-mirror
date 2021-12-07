Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632C2C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 08:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhLGIfg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 03:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbhLGIf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 03:35:29 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3888C061359
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 00:31:59 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v11so27771200wrw.10
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 00:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=J7DLlG6zsP99VZ80Scj5Y3zVfPJjO8z7GJFY3hnxSJs=;
        b=QABG+P8sfJxYGMYFxr1sDKLDvs4marvB8VteJApCR6dvlTmV0Mrop/LnF/3KQoNpDa
         Pw17aWyBEpibKsBbhimt2FbGvyBgBEkCoPRbWIepJCdTXVEB9ApRIo8HCWbL2zcVY2Rv
         7fxawhaYhwpBL6P2V4JQql8aN7F6t9fhEfk/E8IUfK0QOXnQYrRn1qWwiXO4uGpB+/Uw
         ateRxIARw7gqd2EH+YFcUXKMkVJ+zUaL7glRzpByei9bOhjgbwL+OpE7VEtmXBezyi1W
         7PK/9Ehjo+RgQ8EppuD6iK8mMOt2UXMImaDG3/XY8giA6m1ZNAcyWZyV/V8JbQckx1q4
         3cQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=J7DLlG6zsP99VZ80Scj5Y3zVfPJjO8z7GJFY3hnxSJs=;
        b=7TS7Jyqg4PxcbvaNHk/tMDRjw3FMXRnczXx6kaBi58StLf6LDGaFzb4wAikjCsMfAH
         hxS22sV9MP4AtMSAzDoOajsH9e3dNd3+rBbg3oiMMlLn4idUFK1VjY/SNSZ+xy0LIv0+
         gtA7ZUbojZuq6YhtG6MbN+UtiiPFm8fgomgFGHMz8Ro+pdccclgjtAe1X2q5wf3g12Bk
         rDlTvXVC1yaPbN2Y+oWykryF/y5MROPf12u3ZghxHcEgzH+tfdWXSJPw1aLM4KcN0ntG
         jWdmBc83nnUvVWQUGEPs85ZXGgBvTbNlDP25aEDjNvQ1v1UHKpTXjCkunL9n+IXM6Uf9
         Wnuw==
X-Gm-Message-State: AOAM531BtI/338iF9qmjQQu3FweHeb4vAug2YkQpH2QIQknUAlR0ENAV
        1MZcDogD7eP2GtK7I3Y8hiCIDdS2/cc=
X-Google-Smtp-Source: ABdhPJzb4bFd3eD+lrLr4nhAHfprdmrvETCRJr5azJIRg+M/FFd05mkFFFitp0q7ANKlp9mRvvoWPw==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr51891317wru.363.1638865918048;
        Tue, 07 Dec 2021 00:31:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm13984158wrb.2.2021.12.07.00.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 00:31:57 -0800 (PST)
Message-Id: <ea2dc088b37670cd7969a57777798b8f5bdd94e4.1638865913.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
References: <pull.1076.v16.git.1638853295.gitgitgadget@gmail.com>
        <pull.1076.v17.git.1638865913.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 08:31:53 +0000
Subject: [PATCH v17 3/3] am: support --allow-empty to record specific empty
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
 builtin/am.c             | 37 +++++++++++++++++++++-------
 t/t4150-am.sh            | 53 ++++++++++++++++++++++++++++++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  3 +++
 5 files changed, 91 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 7676bd58ae7..8d3aa552a20 100644
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
+	the user can still record the empty patch as an empty commit with
+	the contents of the e-mail message as its log.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index f45aa33366f..89a29ccac89 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1825,7 +1825,8 @@ static void am_run(struct am_state *state, int resume)
 				to_keep = 1;
 				break;
 			case STOP_ON_EMPTY_COMMIT:
-				printf_ln(_("Patch is empty."));
+				printf_ln(_("Patch is empty.\n"
+					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
 				die_user_resolve(state);
 				break;
 			}
@@ -1898,21 +1899,34 @@ next:
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
@@ -2237,7 +2251,8 @@ enum resume_type {
 	RESUME_SKIP,
 	RESUME_ABORT,
 	RESUME_QUIT,
-	RESUME_SHOW_PATCH
+	RESUME_SHOW_PATCH,
+	RESUME_ALLOW_EMPTY
 };
 
 struct resume_mode {
@@ -2390,6 +2405,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
+		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+			N_("record the empty patch as an empty commit"),
+			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2498,7 +2516,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
index ce8e8e79ace..e154b4201b7 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1201,4 +1201,57 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
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
