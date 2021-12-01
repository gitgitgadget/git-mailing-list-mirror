Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56592C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 03:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346509AbhLADlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 22:41:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346490AbhLADk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 22:40:59 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7DBC061756
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 19:37:34 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id v11so48981303wrw.10
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ANq6GH0zHcMhta3OWbtpL2nORyHkXZfXTBczlP8Tjc4=;
        b=N1Fqn/flrAt4fnETRqLod4Zu2HL8f3SQ5hCyZwpIIcBjedIlxGkzdQ4sW+VOPGVagq
         Nm0PnqZJ5OIwq1j9LZi+IcCWTA368DzsDJHOBPsBe6B1rRZAhrKrYF+ALF+hJCXX3rMJ
         EvvE33SgTeTUzbKBUkLPxC4VC/OkiDzVF0OU/jKg7bjKSvDiNfhjI+yZNTrv0pHgBFSV
         GA0Iphm2NL6ofmaPpMYHEVTdNVl06dqv4LLfhrzdMxKQzHdRpk0d0W/pwq/sNphFcVS0
         XBdzruPXsMsnVzR0R3fbAuGMIj/wUZN8Yjus3lyDt7Y1d5fpqhPPJYYXlYEdvGKXY+6p
         /ojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ANq6GH0zHcMhta3OWbtpL2nORyHkXZfXTBczlP8Tjc4=;
        b=wBZ/n431n833Xf5KiqJ4Yw+wUwBQIX8yDEf1UA+I/brnflUl3XjvPxGlaAhTlYavcB
         V0lvhoh+LOCsmi/zppaTZZibY91oVw3nY224R24+wW+MWyQUlTTZun+MIiX8wt+gF6pY
         abwvng/9gr/EOCBrT8YETiFxo3R/ZTg9A0wegmlLD5LJw0NVqYWvFgS4TuAyH16m+e74
         7keGxyBPUIzbqvMsXK/C+G3jvxuvOdy55wAtD3WF2RdItbpjIz0JJmOmNcuVZL37ND8z
         fxT+Quffh6H/DnfKw7Gqj0QvYVrps5f+0DS74ENRK0yELR183d447z/2dXuQNE/0lYez
         6v/w==
X-Gm-Message-State: AOAM533J6uRUL+EvYe328167K9tZghV2Zsx30gwUzPJCBPxWXFDDyN3k
        1k8b7CaLd+EPN5pcWI4oQuClkA2unE8=
X-Google-Smtp-Source: ABdhPJw9G4mjJXldrdar8sQdAmwC79bNYDz2qvu9Fdbd+NbkR1IoxQHdcGGz5pXmNfdM4Cj2j/lS6Q==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr3763562wrx.298.1638329853294;
        Tue, 30 Nov 2021 19:37:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m125sm4007161wmm.39.2021.11.30.19.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 19:37:32 -0800 (PST)
Message-Id: <cbd822d4340f8f3d832e9d6209ee8db6e538fca1.1638329848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
References: <pull.1076.v13.git.1638266115.gitgitgadget@gmail.com>
        <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 03:37:28 +0000
Subject: [PATCH v14 3/3] am: support --allow-empty to record specific empty
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
 Documentation/git-am.txt |  7 ++++++-
 builtin/am.c             | 29 ++++++++++++++++++++---------
 t/t4150-am.sh            | 24 ++++++++++++++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  3 +++
 5 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index cf9cace9678..b6c065b3f7a 100644
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
