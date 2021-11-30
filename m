Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C6AC433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 09:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhK3J6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 04:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236323AbhK3J6j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 04:58:39 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD57C061748
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:55:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q3so20227300wru.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 01:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qQ/tV7aiTBmu+tfB7h7nj/1ysPK8Mdb8bmh6ZN8wB7g=;
        b=DtjDe339UV/90iw1TQDwl9BxMQ2kPsi7Y0BaRaWMfcktF1johXTfsVwBLHWlF/x3iN
         khrN9pH7I0t2lPvsomYKDLAn3AOM8HvVIwSLyEwZXGnR75ggHCGPpqvflRpWEcNixnKO
         sr7CLdfWmG9t+4wpx/i3N1dHXokUCQ/84Bl62S+pOBD2ThZ0lh9d6sET7OuSqW3sy6VZ
         l+m8/YqLpwJtX9NOvLSzDHagG5ct13vDqZR4LGRz07yklPPkcRJsFY7e81bmIhmftYjL
         VNmICdoKRLtYF3rr42Wy8T8TjN1xgCgb4OL9eG7QqjmKxlhhFSKnhGJ2cPehvFQ/eipd
         6kOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qQ/tV7aiTBmu+tfB7h7nj/1ysPK8Mdb8bmh6ZN8wB7g=;
        b=lsRf+R0S6rv2sTceE/9hMWyGtg2WEE4Soip4O2gxmmx193/4Kbsi24T4+AbgfrDXG1
         8FO2NALTZ5fH96xfVFKAcFWQohQ+Bgt9qJgOtEq/ZukUQHRnQrULrF8qYEZYl6ykjZnT
         Wupo1TXokOIxHzoD5MXr7LMCjpOJ/luqo8J7R3OrxFCitwzaN+B+5Cp0hpg/Vk/JWIeS
         GOljFh5xhMjVY+x3NfE6qTiPB5CaqOtrXMlV1qnKrfKkKYAKRE401cQQmFi7D6mmYtdQ
         J66TKVG75ZMfBelnByzeH62hLPawFkCFqJ+uwBmH3GORKSvFVDbronrAQT17e6jqZnkh
         XInA==
X-Gm-Message-State: AOAM533I/ojMATIfUBOhDgIXiONKn2W0o7pPklbeKSkkuS1UVu/VFGEa
        s6NfI4vz74+iyVNUavtLdiXVZIgYn7M=
X-Google-Smtp-Source: ABdhPJzuyZ5lwmKrhTcsKVSgZUr32HQMnX+RS/5ho4bo6J1RbC9sZ5iKixCuvbUnrqbgHnDqXFP86A==
X-Received: by 2002:a5d:530e:: with SMTP id e14mr40699019wrv.12.1638266118477;
        Tue, 30 Nov 2021 01:55:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r8sm20182239wrz.43.2021.11.30.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 01:55:18 -0800 (PST)
Message-Id: <08bd397ae7a4e4320c00b85a4faf2d86ef29edab.1638266115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
References: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
        <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 09:55:15 +0000
Subject: [PATCH v13 3/3] am: support --allow-empty to record specific empty
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
of an am session.

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  6 +++++-
 builtin/am.c             | 29 ++++++++++++++++++++---------
 t/t4150-am.sh            | 24 ++++++++++++++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  3 +++
 5 files changed, 53 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ba17063f621..f2c5e3e37e0 100644
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
@@ -199,6 +199,10 @@ default.   You can use `--no-utf8` to override this.
 	the e-mail message; if `diff`, show the diff portion only.
 	Defaults to `raw`.
 
+--allow-empty::
+	Record the empty patch as an empty commit with
+	the contents of the e-mail message as its log.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index cc6512275aa..58c7638b9bc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1825,7 +1825,8 @@ static void am_run(struct am_state *state, int resume)
 				to_keep = 1;
 				break;
 			case DIE_EMPTY_COMMIT:
-				printf_ln(_("Patch is empty."));
+				printf_ln(_("Patch is empty.\n"
+					    "If you want to record it as an empty commit, run \"git am --allow-empty\"."));
 				die_user_resolve(state);
 				break;
 			}
@@ -1898,19 +1899,24 @@ next:
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
 	validate_resume_state(state);
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
 	if (!repo_index_has_changes(the_repository, NULL, NULL)) {
-		printf_ln(_("No changes - did you forget to use 'git add'?\n"
-			"If there is nothing left to stage, chances are that something else\n"
-			"already introduced the same changes; you might want to skip this patch."));
-		die_user_resolve(state);
+		if (allow_empty)
+			printf_ln(_("No changes - record it as an empty commit."));
+		else {
+			printf_ln(_("No changes - did you forget to use 'git add'?\n"
+				    "If there is nothing left to stage, chances are that something else\n"
+				    "already introduced the same changes; you might want to skip this patch."));
+			die_user_resolve(state);
+		}
 	}
 
 	if (unmerged_cache()) {
@@ -2237,7 +2243,8 @@ enum resume_type {
 	RESUME_SKIP,
 	RESUME_ABORT,
 	RESUME_QUIT,
-	RESUME_SHOW_PATCH
+	RESUME_SHOW_PATCH,
+	RESUME_ALLOW_EMPTY
 };
 
 struct resume_mode {
@@ -2390,6 +2397,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
+		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+			N_("record the empty patch as an empty commit"),
+			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2498,7 +2508,8 @@ int cmd_am(int argc, const char **argv, const char *prefix)
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
index 8c8bd4db220..3e60460022f 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1201,4 +1201,28 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
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
