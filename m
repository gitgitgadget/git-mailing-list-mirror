Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E25C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 07:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhLIH3f (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbhLIH3d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 02:29:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F9C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 23:26:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 133so3463770wme.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 23:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=6Kj24tlXWCV8yMExEWhkVxL04WsWvuYAzDSFuoqmtTo=;
        b=NSZ0bNEAe5jFzMRe1Lfjuo/kgJax0QyQf7BtM6lAnOaAfw0rolN1dh9Y9ZboMTXNcI
         mtUv2OteP7VdFeuiRuT4XlBDF7Vk+e0YTPu8jyonF9F9Q2AiHOOqvN22+6K40SmEr5qh
         mrhJ6JFkJDj1axjUrFnia0XZQtW6JD2ct4Wk9Gi8UD4SyICPX294ohtxo6Muc27ZNLwW
         oQxwFYdP5AlVC7tSQiZxQU7gcpJb1Qz8OTcEBG9l8VIsdLJFlIA2w/KwRUEBvw5EIKKm
         wbb2Q0ftqu6YgrrGwMDqqJDk6Mjk7yL7/q7PSO+36ONn5Vy+n2AOTU9ixS1JCE5HLNsd
         4PmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=6Kj24tlXWCV8yMExEWhkVxL04WsWvuYAzDSFuoqmtTo=;
        b=wgPpi+/oYBh1zlQ4jtMj2rAYNM+edRsfNaRiTAJ1d+5mcG2gbJynGTrteChB4mqoCL
         8MqXW+PtFWdaIJPxwzSvOPmMw5Iv5gfozK19pFFKAaZpwBPeoF/8z9GrVuYjxaUUThhr
         y4JgbhR0qDWQohmvJ3S5laaH01vrUe9dfEbmrT3mkoZ9Zsaszi/SeatWderNclq3JFBK
         VcIqkyXSKJcsf1a8zI4Fbe2SNJFNG4hUvwYoSuvOS508/jSQNedfcMrkwmYQ9XpLEmlK
         u/ExXHqAIgMUREiyFJcAgsCf0XL+C/pCeTEKJ1rsYUfS8KWzVwPHMhA1NQvINeyiDKBP
         4CmQ==
X-Gm-Message-State: AOAM532jtUb95HMOKTEkPqz2hRWDQsb/so3jVWTI0w9dQvoVl0rGLrQz
        JddG/yH/DQJOT0CiE0ZgalQySvJE7bM=
X-Google-Smtp-Source: ABdhPJxoT3X/pF1QonLErhjxLU4ohLJ3Ogi+7htirV4QygV/lQ0gwR8dKn5Sq6+jdcM565I8/OlGtw==
X-Received: by 2002:a05:600c:c1:: with SMTP id u1mr4891150wmm.163.1639034758880;
        Wed, 08 Dec 2021 23:25:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z14sm4722705wrp.70.2021.12.08.23.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 23:25:58 -0800 (PST)
Message-Id: <56953d416d99fa01f0011ced3ce3289f0f7c7623.1639034755.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
References: <pull.1076.v18.git.1638939946.gitgitgadget@gmail.com>
        <pull.1076.v19.git.1639034755.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 07:25:54 +0000
Subject: [PATCH v19 2/3] am: support --empty=<option> to handle empty patches
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

Since that the command 'git-format-patch' can include patches of
commits that emit no changes, the 'git-am' command should also
support an option, named as '--empty', to specify how to handle
those empty patches. In this commit, we have implemented three
valid options ('stop', 'drop' and 'keep').

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  9 +++++++
 builtin/am.c             | 57 ++++++++++++++++++++++++++++++++++++----
 t/t4150-am.sh            | 50 +++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..7676bd58ae7 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
+	 [--empty=(stop|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -63,6 +64,14 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--empty=(stop|drop|keep)::
+	By default, or when the option is set to 'stop', the command
+	errors out on an input e-mail message lacking a patch
+	and stops into the middle of the current am session. When this
+	option is set to 'drop', skip such an e-mail message instead.
+	When this option is set to 'keep', create an empty commit,
+	recording the contents of the e-mail message as its log.
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..7a66ad23737 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,12 @@ enum show_patch_type {
 	SHOW_PATCH_DIFF = 1,
 };
 
+enum empty_action {
+	STOP_ON_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of an am session */
+	DROP_EMPTY_COMMIT,         /* skip with a notice message, unless "--quiet" has been passed */
+	KEEP_EMPTY_COMMIT,         /* keep recording as empty commits */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -118,6 +124,7 @@ struct am_state {
 	int message_id;
 	int scissors; /* enum scissors_type */
 	int quoted_cr; /* enum quoted_cr_action */
+	int empty_type; /* enum empty_action */
 	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -178,6 +185,25 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
+static int am_option_parse_empty(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "stop"))
+		*opt_value = STOP_ON_EMPTY_COMMIT;
+	else if (!strcmp(arg, "drop"))
+		*opt_value = DROP_EMPTY_COMMIT;
+	else if (!strcmp(arg, "keep"))
+		*opt_value = KEEP_EMPTY_COMMIT;
+	else
+		return error(_("Invalid value for --empty: %s"), arg);
+
+	return 0;
+}
+
 /**
  * Returns path relative to the am_state directory.
  */
@@ -1248,11 +1274,6 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_or_missing_file(am_path(state, "patch"))) {
-		printf_ln(_("Patch is empty."));
-		die_user_resolve(state);
-	}
-
 	strbuf_addstr(&msg, "\n\n");
 	strbuf_addbuf(&msg, &mi.log_message);
 	strbuf_stripspace(&msg, 0);
@@ -1763,6 +1784,7 @@ static void am_run(struct am_state *state, int resume)
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
 		int apply_status;
+		int to_keep;
 
 		reset_ident_date();
 
@@ -1792,8 +1814,29 @@ static void am_run(struct am_state *state, int resume)
 		if (state->interactive && do_interactive(state))
 			goto next;
 
+		to_keep = 0;
+		if (is_empty_or_missing_file(am_path(state, "patch"))) {
+			switch (state->empty_type) {
+			case DROP_EMPTY_COMMIT:
+				say(state, stdout, _("Skipping: %.*s"), linelen(state->msg), state->msg);
+				goto next;
+				break;
+			case KEEP_EMPTY_COMMIT:
+				to_keep = 1;
+				say(state, stdout, _("Creating an empty commit: %.*s"),
+					linelen(state->msg), state->msg);
+				break;
+			case STOP_ON_EMPTY_COMMIT:
+				printf_ln(_("Patch is empty."));
+				die_user_resolve(state);
+				break;
+			}
+		}
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
+		if (to_keep)
+			goto commit;
 
 		say(state, stdout, _("Applying: %.*s"), linelen(state->msg), state->msg);
 
@@ -1827,6 +1870,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2401,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_CALLBACK_F(STOP_ON_EMPTY_COMMIT, "empty", &state.empty_type, "{stop,drop,keep}",
+		  N_("how to handle empty patches"),
+		  PARSE_OPT_NONEG, am_option_parse_empty),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..f2a7a68eda0 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -196,6 +196,12 @@ test_expect_success setup '
 
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
 
+	git checkout -b empty-commit &&
+	git commit -m "empty commit" --allow-empty &&
+
+	: >empty.patch &&
+	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
+
 	# reset time
 	sane_unset test_tick &&
 	test_tick
@@ -1152,4 +1158,48 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
+test_expect_success 'an empty input file is error regardless of --empty option' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am --empty=drop empty.patch 2>actual &&
+	echo "Patch format detection failed." >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'invalid when passing the --empty option alone' '
+	test_when_finished "git am --abort || :" &&
+	git checkout empty-commit^ &&
+	test_must_fail git am --empty empty-commit.patch 2>err &&
+	echo "error: Invalid value for --empty: empty-commit.patch" >expected &&
+	test_cmp expected err
+'
+
+test_expect_success 'a message without a patch is an error (default)' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am empty-commit.patch >err &&
+	grep "Patch is empty" err
+'
+
+test_expect_success 'a message without a patch is an error where an explicit "--empty=stop" is given' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am --empty=stop empty-commit.patch >err &&
+	grep "Patch is empty." err
+'
+
+test_expect_success 'a message without a patch will be skipped when "--empty=drop" is given' '
+	git am --empty=drop empty-commit.patch >output &&
+	git rev-parse empty-commit^ >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+	grep "Skipping: empty commit" output
+'
+
+test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
+	git am --empty=keep empty-commit.patch >output &&
+	test_path_is_missing .git/rebase-apply &&
+	git show empty-commit --format="%B" >expected &&
+	git show HEAD --format="%B" >actual &&
+	grep -f actual expected &&
+	grep "Creating an empty commit: empty commit" output
+'
+
 test_done
-- 
gitgitgadget

