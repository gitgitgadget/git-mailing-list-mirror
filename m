Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4135EC4332F
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE1C61B29
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 10:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbhKRKyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 05:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343541AbhKRKxl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 05:53:41 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECDAC061766
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:40 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so4466362wmz.2
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 02:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hbR2BAFXxmmqevWL28y749P1hqntSsfEdeh3GdRA0N4=;
        b=qdLMVHytue4sylHUAJzOiypejrIStKYkkSxi+SOqBB5ylapx6ehrYLKc96xHVlpu5D
         JwVPjSxB/V323viGi4EhSfk9qRH/PJl2qKDv1bRgkbco+GcOxOWa4D6y8exJscX6k4Mp
         EGzgpukJIHCLoziRibtiOwSJyY5BluYh2ouoeEdG8FkV9uTypZ2S7Dt51F2s92XIW8yi
         2djG7YpUNxlWNEmorXP6j1WchrbuqeE6xXk0P20BC03lvisbuihiB9G9zHtQ3SDq41X6
         S/Mv60AWEGRBylGvfpVWN8sq+wHut/KZZy07B2/WNWUhgcdFKDP5Wp8dxialYk56ay4t
         vYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hbR2BAFXxmmqevWL28y749P1hqntSsfEdeh3GdRA0N4=;
        b=fjsCzq6akC6qEb4whuAXiamdKkL/EN/an+HiDdeXZmFsQNHpVghbMuFcBHps4gTUkV
         d2UUWTpsXGIAD3pQj/RimKh84VFxQODB7e80YTxDjmCeNa9lHLQtwEpruivJFqRRtfl8
         c0RJhsa9hJxCnPuaR1kgStZZawPF/K0GV7eIgwJpHK8Y5Jv+lH2Keb7GxoF7/DStcvxQ
         fAQ20+DEBxgOWxvZYGq5k1y/eecL3/dgg1ktujL40Ai4v/TOJwO7JZyfhjH2Zzs9rs7o
         Xd3ZnQF5eDh+JDTBtITtiMIrJPC9IQrVDYbMqJ/20pVxpPhV4RibiGvVDWP91y6JrDWp
         vkQQ==
X-Gm-Message-State: AOAM533EDvAfcfDflAi7sxSL6GYJ+0v+N3n01JTtepbKCB4iIghN00/Q
        iek78WgwaLuE+qISMMse1cXNKj8Si0A=
X-Google-Smtp-Source: ABdhPJxcjIysJnpf3jujE+2U7le85OHCiOT6YjfpJx+4+k0Q5UlIVY3u58v5ySstwINLLzf9CT3dPw==
X-Received: by 2002:a7b:c194:: with SMTP id y20mr9172009wmi.61.1637232639011;
        Thu, 18 Nov 2021 02:50:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b14sm3591489wrd.24.2021.11.18.02.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:50:38 -0800 (PST)
Message-Id: <96d8573dc808bc32990842675ca32a0d1e8a8cef.1637232636.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
References: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
        <pull.1076.v6.git.1637232636.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Nov 2021 10:50:35 +0000
Subject: [PATCH v6 2/3] am: support --empty option to handle empty patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>, Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Aleen <aleen42@vip.qq.com>

Signed-off-by: Aleen <aleen42@vip.qq.com>
---
 Documentation/git-am.txt |  9 +++++
 builtin/am.c             | 48 +++++++++++++++++++++++---
 t/t4150-am.sh            | 73 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 125 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 0a4a984dfde..665bc89ca9f 100644
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
 
+--empty-commit=(die|drop|keep)::
+	The command usually errors out when seeing an input e-mail
+	message that lacks a patch. When this option is set to
+	'drop', skip such an e-mail message without outputting error.
+	When this option is set to 'keep', create an empty commit,
+	recording the contents of the e-mail message as its log.
+	'die' is specified by default.
+
 -m::
 --message-id::
 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
diff --git a/builtin/am.c b/builtin/am.c
index 8677ea2348a..1a3ed87b445 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -87,6 +87,12 @@ enum show_patch_type {
 	SHOW_PATCH_DIFF = 1,
 };
 
+enum empty_action {
+	DIE_EMPTY_COMMIT = 0,  /* output errors */
+	DROP_EMPTY_COMMIT,     /* skip without outputting errors */
+	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
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
@@ -178,6 +185,23 @@ static int am_option_parse_quoted_cr(const struct option *opt,
 	return 0;
 }
 
+static int am_option_parse_empty_commit(const struct option *opt,
+				     const char *arg, int unset)
+{
+	int *opt_value = opt->value;
+
+	if (unset || !strcmp(arg, "die"))
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
@@ -1248,11 +1272,6 @@ static int parse_mail(struct am_state *state, const char *mail)
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
@@ -1792,6 +1811,20 @@ static void am_run(struct am_state *state, int resume)
 		if (state->interactive && do_interactive(state))
 			goto next;
 
+		if (is_empty_or_missing_file(am_path(state, "patch"))) {
+			if (state->empty_type == DROP_EMPTY_COMMIT)
+				goto next;
+			else if (state->empty_type == KEEP_EMPTY_COMMIT) {
+				if (run_applypatch_msg_hook(state))
+					exit(1);
+				else
+					goto commit;
+			} else if (state->empty_type == DIE_EMPTY_COMMIT) {
+				printf_ln(_("Patch is empty."));
+				die_user_resolve(state);
+			}
+		}
+
 		if (run_applypatch_msg_hook(state))
 			exit(1);
 
@@ -1827,6 +1860,7 @@ static void am_run(struct am_state *state, int resume)
 			die_user_resolve(state);
 		}
 
+commit:
 		do_commit(state);
 
 next:
@@ -2357,6 +2391,10 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
 		  N_("GPG-sign commits"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
+		{ OPTION_CALLBACK, 0, "empty", &state.empty_type,
+		  "(die|drop|keep)",
+		  N_("specify how to handle empty patches"),
+		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
 		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
 			N_("(internal use for git-rebase)")),
 		OPT_END()
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 2aaaa0d7ded..3119556884d 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -196,6 +196,13 @@ test_expect_success setup '
 
 	git format-patch -M --stdout lorem^ >rename-add.patch &&
 
+	git checkout -b empty-commit &&
+	git commit -m "empty commit" --allow-empty &&
+
+	git format-patch --stdout empty-commit^ >empty.patch &&
+	git format-patch --stdout --cover-letter empty-commit^ >cover-letter.patch &&
+	git format-patch --always --stdout empty-commit^ >empty-commit.patch &&
+
 	# reset time
 	sane_unset test_tick &&
 	test_tick
@@ -1152,4 +1159,70 @@ test_expect_success 'apply binary blob in partial clone' '
 	git -C client am ../patch
 '
 
+test_expect_success 'still output error with --empty when meeting empty files' '
+	test_must_fail git am --empty=drop empty.patch 2>actual &&
+	echo Patch format detection failed. >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
+	git checkout empty-commit^ &&
+	test_must_fail git am empty-commit.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err &&
+	rm -fr .git/rebase-apply &&
+
+	test_must_fail git am --empty=die empty-commit.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err &&
+	rm -fr .git/rebase-apply &&
+
+	test_must_fail git am --empty=die cover-letter.patch >err &&
+	test_path_is_dir .git/rebase-apply &&
+	test_i18ngrep "Patch is empty." err &&
+	rm -fr .git/rebase-apply
+'
+
+test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
+	git am --empty=drop empty-commit.patch >err &&
+	test_path_is_missing .git/rebase-apply &&
+	git rev-parse empty-commit^ >expected &&
+	git rev-parse HEAD >actual &&
+	test_cmp expected actual &&
+
+	git am --empty=drop cover-letter.patch >err &&
+	test_path_is_missing .git/rebase-apply &&
+	test_cmp_rev empty-commit^ HEAD
+'
+
+test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
+	git am --empty=keep empty-commit.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	{
+		git show empty-commit --format="%B" &&
+		echo "--" &&
+		git version | sed -e "s/^git version //" &&
+		echo
+	} >expected &&
+	git show HEAD --format="%B" >actual &&
+	test_cmp actual expected &&
+
+	git am --empty=keep cover-letter.patch &&
+	test_path_is_missing .git/rebase-apply &&
+	{
+		echo "*** SUBJECT HERE ***" &&
+		echo &&
+		echo "*** BLURB HERE ***" &&
+		echo &&
+		echo "A U Thor (1):" &&
+		printf "  " &&
+		git show empty-commit --format="%B" &&
+		echo "--" &&
+		git version | sed -e "s/^git version //" &&
+		echo
+	} >expected &&
+	git show HEAD --format="%B" >actual &&
+	test_cmp actual expected
+'
+
 test_done
-- 
gitgitgadget

