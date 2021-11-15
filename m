Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C2AC433EF
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED3B061BFA
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhKOKm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhKOKm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 05:42:27 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B185C061746
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 02:39:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id s13so29744538wrb.3
        for <git@vger.kernel.org>; Mon, 15 Nov 2021 02:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CUA6xmO3D1R3pDkCW3NAjc28c3guiHDJasjeB2LRtsU=;
        b=nnmM7IhEqA5pfJSHzpk9Bxu2A3WfSHyNGWv4V0O3PZhvxsdl7ATP2kW5s+2uYmOtIp
         2qxY3o7KSITHudpRj2jw6i8/QDQj3ehDn5MP/NEuzQ+si2NBRQIU0yuh7IJedl660XIQ
         2LHOkppstuN3q5eQQM8kPhb6nMoxeoBKSqfAEogaAstcY9r9Y2HipncZzZdm0eMJ4OgJ
         Xc47dVa5oiQhmU1jk57+9VzxnhLx3EbJYxSkAwDBaPovlsKr9DgSO13ppEINKxgkS+R6
         +VX27IGLUfsyQUDfxz/Pt2vgB1/cmB2LTN6N3A6CWLmS4eoThMZzJ5IuIJhgxCNzaBhu
         WoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CUA6xmO3D1R3pDkCW3NAjc28c3guiHDJasjeB2LRtsU=;
        b=rN42AB8tQicU0t43VyS+5cDeaY5XiLPri0dLQ72+PkdCUQ+V8+48mUsB0ReFza3N4l
         Q7qzPQWpy92EtDZKqkpbB0cGyfkPr2AIc31kYELuPAzd++dgvIHO8NLwQthmCd6+8Uy2
         14asPa3euYzvxPFz63w79vyu4Z0w/VNxWLkAqx3YK+0cQirmdDzZESTiY5PHZ2JtO4rI
         2IKQ8xC5zBbFoV10SLKBjWnUxj/ZwCnWia7/xcFU9xJmLExz4BdK8rKbNblFISO2xnEh
         49130STkfk5Jr54TPHeJn6INghIyJNNi0UE3CismB4xswHOWQBiTwD66DfolmeduRrVu
         mVmg==
X-Gm-Message-State: AOAM530bNBm0HZfmqCeevkwf7qLFOChcQZh4Z08nBX3UDgoHwXV9w5xJ
        Do354K2mRP73DIosNzw8urquXmszKJE=
X-Google-Smtp-Source: ABdhPJzSgwekK2627MBAatXvJ/n0TuUCLd32o8rC2BkYGkPjb48VXf8H4wgLXthmkAzhQVjKd5Oc4g==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr46781203wrz.286.1636972770570;
        Mon, 15 Nov 2021 02:39:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k187sm14666862wme.0.2021.11.15.02.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 02:39:30 -0800 (PST)
Message-Id: <pull.1076.v3.git.1636972769.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
References: <pull.1076.v2.git.1636700040.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Nov 2021 10:39:27 +0000
Subject: [PATCH v3 0/2] am: support --empty-commit=(die|skip|asis) option to am empty commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option
 2. rename the --always option to --allow-empty

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Aleen (2):
  doc: git-format-patch: describe the option --always
  am: support --empty-commit option to handle empty patches

 Documentation/git-am.txt           |  9 +++++
 Documentation/git-format-patch.txt |  6 +++-
 builtin/am.c                       | 48 ++++++++++++++++++++++---
 t/t4150-am.sh                      | 58 ++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 6 deletions(-)


base-commit: b550198c73edd4cc058832dcf74b41aeec2adba2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v2:

 1:  71e6989375c ! 1:  9f1b3dd6d0b doc: git-format-patch: specify the option --always
     @@ Metadata
      Author: Aleen <aleen42@vip.qq.com>
      
       ## Commit message ##
     -    doc: git-format-patch: specify the option --always
     +    doc: git-format-patch: describe the option --always
      
          Signed-off-by: Aleen <aleen42@vip.qq.com>
      
       ## Documentation/git-format-patch.txt ##
      @@ Documentation/git-format-patch.txt: SYNOPSIS
     - 		   [--range-diff=<previous> [--creation-factor=<percent>]]
     - 		   [--filename-max-length=<n>]
     - 		   [--progress]
     -+		   [--always]
     - 		   [<common diff options>]
     - 		   [ <since> | <revision range> ]
     - 
     -@@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
     - --progress::
     - 	Show progress reports on stderr as patches are generated.
     + 		   [-n | --numbered | -N | --no-numbered]
     + 		   [--start-number <n>] [--numbered-files]
     + 		   [--in-reply-to=<message id>] [--suffix=.<sfx>]
     +-		   [--ignore-if-in-upstream]
     ++		   [--ignore-if-in-upstream] [--always]
     + 		   [--cover-from-description=<mode>]
     + 		   [--rfc] [--subject-prefix=<subject prefix>]
     + 		   [(--reroll-count|-v) <n>]
     +@@ Documentation/git-format-patch.txt: will want to ensure that threading is disabled for `git send-email`.
     + 	patches being generated, and any patch that matches is
     + 	ignored.
       
      +--always::
     -+	Patch commits with detailed commit messages,
     -+	even if they emit no changes. (see linkgit:git-diff-tree[1])
     ++	Include patches for commits that do not introduce any change,
     ++	which are omitted by default.
      +
     - CONFIGURATION
     - -------------
     - You can specify extra mail header lines to be added to each message,
     + --cover-from-description=<mode>::
     + 	Controls which parts of the cover letter will be automatically
     + 	populated using the branch's description.
 2:  59b1417da37 ! 2:  ef33ce8c6f9 am: support --always option to am empty commits
     @@ Metadata
      Author: Aleen <aleen42@vip.qq.com>
      
       ## Commit message ##
     -    am: support --always option to am empty commits
     +    am: support --empty-commit option to handle empty patches
      
          Signed-off-by: Aleen <aleen42@vip.qq.com>
      
     @@ Documentation/git-am.txt: SYNOPSIS
       	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
       	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
       	 [--quoted-cr=<action>]
     -+	 [--always]
     ++	 [--empty-commit=(die|skip|asis)]
       	 [(<mbox> | <Maildir>)...]
       'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
       
     -@@ Documentation/git-am.txt: default.   You can use `--no-utf8` to override this.
     - 	countermand both `commit.gpgSign` configuration variable, and
     - 	earlier `--gpg-sign`.
     +@@ Documentation/git-am.txt: OPTIONS
     + --quoted-cr=<action>::
     + 	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
       
     -+--always::
     -+	Apply patches of commits with detailed commit messages,
     -+	even if they emit no changes. (see linkgit:git-format-patch[1])
     ++--empty-commit=(die|skip|asis)::
     ++	The command usually errors out when seeing an input e-mail
     ++	message that lacks a patch. When this option is set to
     ++	'skip', skip such an e-mail message without outputting error.
     ++	When this option is set to 'asis', create an empty commit,
     ++	recording the contents of the e-mail message as its log.
     ++	'die' is specified by default.
      +
     - --continue::
     - -r::
     - --resolved::
     + -m::
     + --message-id::
     + 	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
      
       ## builtin/am.c ##
     -@@ builtin/am.c: struct am_state {
     - 	int ignore_date;
     - 	int allow_rerere_autoupdate;
     - 	const char *sign_commit;
     -+	int always;
     -+	int empty_commit;
     - 	int rebasing;
     +@@ builtin/am.c: enum show_patch_type {
     + 	SHOW_PATCH_DIFF = 1,
       };
       
     ++enum empty_commit_action {
     ++	DIE_EMPTY_COMMIT = 0,  /* output errors */
     ++	SKIP_EMPTY_COMMIT,     /* skip without outputting errors */
     ++	ASIS_EMPTY_COMMIT      /* keep recording as empty commits */
     ++};
     ++
     + struct am_state {
     + 	/* state directory path */
     + 	char *dir;
     +@@ builtin/am.c: struct am_state {
     + 	int message_id;
     + 	int scissors; /* enum scissors_type */
     + 	int quoted_cr; /* enum quoted_cr_action */
     ++	int empty_commit; /* enum empty_commit_action */
     + 	struct strvec git_apply_opts;
     + 	const char *resolvemsg;
     + 	int committer_date_is_author_date;
     +@@ builtin/am.c: static int am_option_parse_quoted_cr(const struct option *opt,
     + 	return 0;
     + }
     + 
     ++static int am_option_parse_empty_commit(const struct option *opt,
     ++				     const char *arg, int unset)
     ++{
     ++	int *opt_value = opt->value;
     ++
     ++	if (unset || !strcmp(arg, "die"))
     ++		*opt_value = DIE_EMPTY_COMMIT;
     ++	else if (!strcmp(arg, "skip"))
     ++		*opt_value = SKIP_EMPTY_COMMIT;
     ++	else if (!strcmp(arg, "asis"))
     ++		*opt_value = ASIS_EMPTY_COMMIT;
     ++	else
     ++		return error(_("Invalid value for --empty-commit: %s"), arg);
     ++
     ++	return 0;
     ++}
     ++
     + /**
     +  * Returns path relative to the am_state directory.
     +  */
      @@ builtin/am.c: static int parse_mail(struct am_state *state, const char *mail)
     + 		goto finish;
       	}
       
     - 	if (is_empty_or_missing_file(am_path(state, "patch"))) {
     +-	if (is_empty_or_missing_file(am_path(state, "patch"))) {
      -		printf_ln(_("Patch is empty."));
      -		die_user_resolve(state);
     -+		if (state->always) {
     -+			state->empty_commit = 1;
     -+		} else {
     -+			printf_ln(_("Patch is empty."));
     -+			die_user_resolve(state);
     -+		}
     - 	}
     - 
     +-	}
     +-
       	strbuf_addstr(&msg, "\n\n");
     + 	strbuf_addbuf(&msg, &mi.log_message);
     + 	strbuf_stripspace(&msg, 0);
      @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
       		if (state->interactive && do_interactive(state))
       			goto next;
       
     -+		if (state->empty_commit)
     -+			goto commit;
     ++		if (is_empty_or_missing_file(am_path(state, "patch"))) {
     ++			if (state->empty_commit == SKIP_EMPTY_COMMIT)
     ++				goto next;
     ++			else if (state->empty_commit == ASIS_EMPTY_COMMIT) {
     ++				if (run_applypatch_msg_hook(state))
     ++					exit(1);
     ++				else
     ++					goto commit;
     ++			} else if (state->empty_commit == DIE_EMPTY_COMMIT) {
     ++				printf_ln(_("Patch is empty."));
     ++				die_user_resolve(state);
     ++			}
     ++		}
      +
       		if (run_applypatch_msg_hook(state))
       			exit(1);
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
       		  N_("GPG-sign commits"),
       		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
     -+		OPT_BOOL(0, "always", &state.always,
     -+			N_("always apply patch event if the patch is empty")),
     -+		OPT_HIDDEN_BOOL(0, "empty-commit", &state.empty_commit,
     -+			N_("(internal use for skipping git-apply to empty commits)")),
     ++		{ OPTION_CALLBACK, 0, "empty-commit", &state.empty_commit,
     ++		  "(die|skip|asis)",
     ++		  N_("specify how to handle empty patches"),
     ++		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
       		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
       			N_("(internal use for git-rebase)")),
       		OPT_END()
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
       	git -C client am ../patch
       '
       
     -+test_expect_success 'am a real empty patch with the --always option' '
     -+	rm -fr .git/rebase-apply &&
     -+	git reset --hard &&
     -+	test_must_fail git am --always empty.patch 2>actual &&
     ++test_expect_success 'still output error with --empty-commit when meeting empty files' '
     ++	test_must_fail git am --empty-commit=skip empty.patch 2>actual &&
      +	echo Patch format detection failed. >expected &&
      +	test_cmp expected actual
      +'
      +
     -+test_expect_success 'am a patch with empty commits' '
     -+	grep "empty commit" empty-commit.patch &&
     -+	rm -fr .git/rebase-apply &&
     -+	git reset --hard &&
     ++test_expect_success 'error when meeting e-mail message that lacks a patch by default' '
      +	git checkout empty-commit^ &&
     -+	git am --always empty-commit.patch &&
     ++	test_must_fail git am empty-commit.patch >err &&
     ++	test_path_is_dir .git/rebase-apply &&
     ++	test_i18ngrep "Patch is empty." err &&
     ++	rm -fr .git/rebase-apply &&
     ++
     ++	test_must_fail git am --empty-commit=die empty-commit.patch >err &&
     ++	test_path_is_dir .git/rebase-apply &&
     ++	test_i18ngrep "Patch is empty." err &&
     ++	rm -fr .git/rebase-apply &&
     ++
     ++	test_must_fail git am --empty-commit=die cover-letter.patch >err &&
     ++	test_path_is_dir .git/rebase-apply &&
     ++	test_i18ngrep "Patch is empty." err &&
     ++	rm -fr .git/rebase-apply
     ++'
     ++
     ++test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
     ++	git am --empty-commit=skip empty-commit.patch >err &&
     ++	test_path_is_missing .git/rebase-apply &&
     ++	git rev-parse empty-commit^ >expected &&
     ++	git rev-parse HEAD >actual &&
     ++	test_cmp expected actual &&
     ++
     ++	git am --empty-commit=skip cover-letter.patch >err &&
     ++	test_path_is_missing .git/rebase-apply &&
     ++	git rev-parse empty-commit^ >expected &&
     ++	git rev-parse HEAD >actual &&
     ++	test_cmp expected actual
     ++'
     ++
     ++test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
     ++	git am --empty-commit=asis empty-commit.patch &&
     ++	test_path_is_missing .git/rebase-apply &&
     ++	git show empty-commit --format="%B" >expected &&
     ++	git show HEAD --format="%B" >actual &&
     ++	grep -f actual expected &&
     ++
     ++	git am --empty-commit=asis cover-letter.patch &&
      +	test_path_is_missing .git/rebase-apply &&
     -+	git cat-file commit HEAD >actual &&
     -+	test_i18ngrep "empty commit" actual
     ++	git show empty-commit --format="%B" >expected &&
     ++	git show HEAD --format="%B" >actual &&
     ++	grep -f actual expected
      +'
      +
       test_done
 3:  da024ced668 < -:  ----------- test: am: add the case when not passing the --always option
 4:  45e9720f40b < -:  ----------- chore: am: rename the --always option to --allow-empty

-- 
gitgitgadget
