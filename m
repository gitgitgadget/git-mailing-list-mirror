Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8272C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 05:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbhK3Fky (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 00:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhK3Fkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 00:40:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F37C061714
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:37:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so41592166wrs.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 21:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=MJaR4k2YSZTQw2eOmzlyVLO7C29QxKO0MLGOkxtt1HQ=;
        b=S0+lfp7GnaZ6LYhymoXj+XohvOLNhayLLS+ppU2gkeRCfwQSz51poUvlPYd3efy94h
         7AtT6IBUbACE38rI7/0snVsQuAuJfCVUNRd8yi6uKBjHihzfYMRgw30QCD7P2IseAyop
         bqZgT1yO9qEo3sKa7xrXd/Fsq8MgX2vRauXrSTN99bzuNZDnrbzF2a7tAwKC2oU+Bg8C
         AJqKVeqHNpAIOoPbhxNZW/z2N/s7OoSTsaASSCScfkYYfIA4/EPQT32BpVhXZTqUBnxg
         MH47plUUWPp0g0GIuPSNVajvhTSi8zvfZ1DF+sIz3HmQWLUSnM5Lz7jr8bY+wQZsuUOj
         0gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=MJaR4k2YSZTQw2eOmzlyVLO7C29QxKO0MLGOkxtt1HQ=;
        b=oQxZTwVhIudO1sAfzaTJLB1VAZUNweMdTEEU6l2zQ/KziL19+cXmBOoyhu27kG866H
         6dLhkxSk7jyOdGidtyGSzlJwTIKOf3VwW37gGPIuJJDY16rFZdYflMcSGnpOnagI9iVd
         bgcX9r2Lnr3BLsG6U7m8JmOibrK7OLjKiIQzMhyqsd/7c7MXKoU8FHeWKBxnB1AARtA2
         N6sQCsReWwGzC4W2R5cYinWPw/ImuIkn/NjsmOtSDQ2LS8mtkkF8P+15+fou1XEksvyx
         yjX68S32PC7n2OxZAEALCJfD25Sumdjgk/4oc3m9tyTdKaNPUM+etYI3G6v7Rp/UqoQ8
         R/Zg==
X-Gm-Message-State: AOAM530fTsvM83DW4lX3rF5ZRFtun0POD81cgCKGnfQ2xdK1q6zXSVwA
        g5BGDEYU4kzEYpwqLj1e4DiCj+1mAq0=
X-Google-Smtp-Source: ABdhPJw1DWOB798VXPgiS//gZg6HqKUHXGzmWX8hM6hpRj2QQhcaK9F70u49qXd75ZeeLjKhEihQGg==
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr37936145wrv.278.1638250648754;
        Mon, 29 Nov 2021 21:37:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az4sm1233084wmb.20.2021.11.29.21.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 21:37:28 -0800 (PST)
Message-Id: <d44dac09c872257306d9718564820435e8a07ca2.1638250645.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
References: <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com>
        <pull.1076.v12.git.1638250645.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 05:37:25 +0000
Subject: [PATCH v12 3/3] am: support --allow-empty to record specific empty
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
 builtin/am.c             | 24 +++++++++++++++++++-----
 t/t4150-am.sh            | 12 ++++++++++++
 t/t7512-status-help.sh   |  1 +
 wt-status.c              |  3 +++
 5 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ba17063f621..fe3af32f7f7 100644
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
+	Keep recording the empty patch as an empty commit with
+	the contents of the e-mail message as its log.
+
 DISCUSSION
 ----------
 
diff --git a/builtin/am.c b/builtin/am.c
index cc6512275aa..2ae6fabb28a 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1825,7 +1825,8 @@ static void am_run(struct am_state *state, int resume)
 				to_keep = 1;
 				break;
 			case DIE_EMPTY_COMMIT:
-				printf_ln(_("Patch is empty."));
+				printf_ln(_("Patch is empty.\n"
+							"If you want to keep recording it, run \"git am --allow-empty\"."));
 				die_user_resolve(state);
 				break;
 			}
@@ -1898,10 +1899,15 @@ next:
 /**
  * Resume the current am session after patch application failure. The user did
  * all the hard work, and we do not have to do any patch application. Just
- * trust and commit what the user has in the index and working tree.
+ * trust and commit what the user has in the index and working tree. If `allow_empty`
+ * is true, commit as an empty commit.
  */
-static void am_resolve(struct am_state *state)
+static void am_resolve(struct am_state *state, int allow_empty)
 {
+	if (allow_empty) {
+		goto commit;
+	}
+
 	validate_resume_state(state);
 
 	say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
@@ -1928,6 +1934,7 @@ static void am_resolve(struct am_state *state)
 
 	repo_rerere(the_repository, 0);
 
+commit:
 	do_commit(state);
 
 next:
@@ -2237,7 +2244,8 @@ enum resume_type {
 	RESUME_SKIP,
 	RESUME_ABORT,
 	RESUME_QUIT,
-	RESUME_SHOW_PATCH
+	RESUME_SHOW_PATCH,
+	RESUME_ALLOW_EMPTY
 };
 
 struct resume_mode {
@@ -2390,6 +2398,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		  N_("show the patch being applied"),
 		  PARSE_OPT_CMDMODE | PARSE_OPT_OPTARG | PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
 		  parse_opt_show_current_patch, RESUME_SHOW_PATCH },
+		OPT_CMDMODE(0, "allow-empty", &resume.mode,
+			N_("keep recording the empty patch as empty commits"),
+			RESUME_ALLOW_EMPTY),
 		OPT_BOOL(0, "committer-date-is-author-date",
 			&state.committer_date_is_author_date,
 			N_("lie about committer date")),
@@ -2498,7 +2509,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		am_run(&state, 1);
 		break;
 	case RESUME_RESOLVED:
-		am_resolve(&state);
+		am_resolve(&state, 0);
+		break;
+	case RESUME_ALLOW_EMPTY:
+		am_resolve(&state, 1);
 		break;
 	case RESUME_SKIP:
 		am_skip(&state);
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 8c8bd4db220..cab21411f00 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1201,4 +1201,16 @@ test_expect_success 'record as an empty commit when meeting e-mail message that
 	test_cmp actual expected
 '
 
+
+test_expect_success 'record as an empty commit in the middle of an am session' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty." err &&
+	grep "If you want to keep recording it, run \"git am --allow-empty\"." err &&
+	git am --allow-empty &&
+	git show empty-commit --format="%s" >expected &&
+	git show HEAD --format="%s" >actual &&
+	test_cmp actual expected
+'
+
 test_done
diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 7f2956d77ad..5513018154e 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -658,6 +658,7 @@ test_expect_success 'status in an am session: empty patch' '
 On branch am_empty
 You are in the middle of an am session.
 The current patch is empty.
+  (use "git am --allow-empty" to keep recording this empty patch)
   (use "git am --skip" to skip this patch)
   (use "git am --abort" to restore the original branch)
 
diff --git a/wt-status.c b/wt-status.c
index 5d215f4e4f1..d036f88a6b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1227,6 +1227,9 @@ static void show_am_in_progress(struct wt_status *s,
 		if (!s->state.am_empty_patch)
 			status_printf_ln(s, color,
 				_("  (fix conflicts and then run \"git am --continue\")"));
+		else
+			status_printf_ln(s, color,
+				_("  (use \"git am --allow-empty\" to keep recording this empty patch)"));
 		status_printf_ln(s, color,
 			_("  (use \"git am --skip\" to skip this patch)"));
 		status_printf_ln(s, color,
-- 
gitgitgadget
