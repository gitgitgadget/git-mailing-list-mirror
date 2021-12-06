Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E92DAC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 09:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhLFJpR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 04:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241403AbhLFJpD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 04:45:03 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9831FC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 01:41:34 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id c4so21056870wrd.9
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 01:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=T4KDeaLG8iJyh5RbtD8rkOrZKo7E1Kb4lyzYDGcsus8=;
        b=B/NbPlaKqq5XFku7TATWP1xW4enFGgf9AThA5OT8TsYIFQqUlxQhhaKvSBwnhTWKaI
         kudaFl6CEQVn0kZoadeuZW4fdfvBUMeEPCnkolZUFqfXQN5lXSgOr8ScwziykPnBSPc7
         3BthHgzNHg71bjOxrqDNx+n9v4A/G+Hkckdc/zFytc+K6CJSE29iVCU8VPNTIRR/suGu
         8mzLyrofHVAaFVBBQFC3bUwXuWrs5+Wmytxz79qCVnxIWT5oPqTPNxKjEwQ6pQUUnkZv
         hMKougI6UvuqxnRzARTwy4qsUEcp8Po9XoQ1ZgisaRWJeDbhK7DCy+xSLocG7TRKoLnU
         JfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=T4KDeaLG8iJyh5RbtD8rkOrZKo7E1Kb4lyzYDGcsus8=;
        b=TbrsD1xk7FUDSxOPXx++cIA04O5naMdPmaHMR/g8YTi2pwme5rlVIWCsihnTKvexGi
         mhohyfOnhBasxNhJFhKgjdEXEEp/X1ZZ0425JV1d4YsPQjxgnJyXdhQO8Ep2/FliusIA
         PPEb2Hh3JFLq9CvgNGELPGgHgTEL2CPA4Et8TPob/Xx6QIXhqloHL+9axNX9dLHyTXDt
         PM3KGV6pA1EWwbJpP6SN0SJMTegxMLDALj6tMLZRFitz2o+kBhaiKFwvlrlwNkvx/qk/
         BWwPSxP9v762cfTaLkjJJEpAT8f1Yew4f4cMRrR9eGq9d27quEjyu9cBgs4n4pubmjSc
         JnTQ==
X-Gm-Message-State: AOAM531i5Jj0AawXWt3K121jzHJNA+YlBNaUgMRjv2wVjK0lWoubtJsx
        C6oit9xWqjS0JKAQYtOQxOE1BZd6Wy8=
X-Google-Smtp-Source: ABdhPJzlqco+SMljup5vjlbpdAsJLvDQXMOTFAs1FoQsFqiL8tYVtPEuvcEKXj/ZRvKHpcLys8a68Q==
X-Received: by 2002:a5d:6e8d:: with SMTP id k13mr43403929wrz.449.1638783693007;
        Mon, 06 Dec 2021 01:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm10597152wrq.11.2021.12.06.01.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 01:41:32 -0800 (PST)
Message-Id: <8ec8e212672898b9adec2dcc63d7997f5446cfff.1638783690.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
References: <pull.1076.v14.git.1638329848.gitgitgadget@gmail.com>
        <pull.1076.v15.git.1638783690.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=E5=BE=90=E6=B2=9B=E6=96=87=20=28Aleen=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 09:41:29 +0000
Subject: [PATCH v15 2/3] am: support --empty=<option> to handle empty patches
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
valid options ('die', 'drop' and 'keep').

Signed-off-by: 徐沛文 (Aleen) <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  9 ++++++
 builtin/am.c             | 60 ++++++++++++++++++++++++++++++++++++----
 t/t4150-am.sh            | 50 +++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..4c31c39bf81 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -16,6 +16,7 @@ SYNOPSIS
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
 	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
+	 [--empty=(die|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
 'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
 
@@ -63,6 +64,14 @@ OPTIONS
 --quoted-cr=<action>::
 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
 
+--empty=(die|drop|keep)::
+	By default, the command errors out on an input e-mail message
+	lacking a patch and stops into the middle of the current am session.
+	When this option is set to 'die', the whole session dies with error.
+	When this option is set to 'drop', skip such an e-mail message instead.
+	When this option is set to 'keep', create an empty commit,
+	recording the contents of the e-mail message as its log.
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..43a3b1cf038 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,13 @@ enum show_patch_type {
 	SHOW_PATCH_DIFF = 1,
 };
 
+enum empty_action {
+	ERR_EMPTY_COMMIT = 0,  /* output errors and stop in the middle of an am session */
+	DIE_EMPTY_COMMIT,      /* output errors and stop the whole am session */
+	DROP_EMPTY_COMMIT,     /* skip with a notice message, unless "--quiet" has been passed */
+	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
+};
+
 struct am_state {
 	/* state directory path */
 	char *dir;
@@ -118,6 +125,7 @@ struct am_state {
 	int message_id;
 	int scissors; /* enum scissors_type */
 	int quoted_cr; /* enum quoted_cr_action */
+	int empty_type; /* enum empty_action */
 	struct strvec git_apply_opts;
 	const char *resolvemsg;
 	int committer_date_is_author_date;
@@ -178,6 +186,25 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
+static int am_option_parse_empty(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+
+	if (!strcmp(arg, "die"))
+		*opt_value = DIE_EMPTY_COMMIT;
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
@@ -1248,11 +1275,6 @@ static int parse_mail(struct am_state *state, const char *mail)
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
@@ -1763,6 +1785,7 @@ static void am_run(struct am_state *state, int resume)
 	while (state->cur <= state->last) {
 		const char *mail = am_path(state, msgnum(state));
 		int apply_status;
+		int to_keep;
 
 		reset_ident_date();
 
@@ -1792,8 +1815,31 @@ static void am_run(struct am_state *state, int resume)
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
+				break;
+			case DIE_EMPTY_COMMIT:
+				am_destroy(state);
+				die(_("Patch is empty."));
+				break;
+			case ERR_EMPTY_COMMIT:
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
 
@@ -1827,6 +1873,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2404,9 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		OPT_CALLBACK_F(ERR_EMPTY_COMMIT, "empty", &state.empty_type, "{die,drop,keep}",
+		  N_("how to handle empty patches"),
+		  PARSE_OPT_NONEG, am_option_parse_empty),
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..f2b765644e5 100755
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
+test_expect_success 'a message without a patch is an error and stop in the middle of an am session (default)' '
+	test_when_finished "git am --abort || :" &&
+	test_must_fail git am empty-commit.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	grep "Patch is empty" err
+'
+
+test_expect_success 'a message without a patch is an error and exit where an explicit "--empty=die" is given' '
+	test_must_fail git am --empty=die empty-commit.patch 2>err &&
+	test_path_is_missing .git/rebase-apply &&
+	grep "fatal: Patch is empty." err
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
+	git am --empty=keep empty-commit.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	git show empty-commit --format="%s" >expected &&
+	git show HEAD --format="%s" >actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
gitgitgadget

