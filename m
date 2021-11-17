Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E907C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155B661251
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234997AbhKQJg6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:36:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhKQJg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:36:57 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B76EC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:33:59 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso1604343wmf.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 01:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=l1aXA9aJAJYmxiiHgvkG4snP9CiaeMuecGodgNWBI/8=;
        b=P/JGqznfzay4swtMGmMq15kfCFME1x7+bs5Yr1yTmHbQJ1Pp/ZuRd1BAtuOAj++d+z
         cyNy+Gf1ehit+6y4AD41JouxX2R4vkLsGmGeCBZEGK/rKK88jRHP+Mxj4xnUVIbwsq40
         66T7TimUMtMkWHtLWzUG3r/YKDGEaCynxRKtvtc01sZwK8Uu+2h9dBE9Go/JI+2gmTzx
         gHiYUVC+tZAhaG0Y5+ya9IH8YHeNsiequ2zb97QqlYpy0qi12TL36XpjDz3fC+inIirI
         mQQf+eEiujJD7HasgFWppJ75/nF2nloPrvdKp4zT2GnlEZ+hdXUNTGsYQ+veGTI1cH0/
         4q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=l1aXA9aJAJYmxiiHgvkG4snP9CiaeMuecGodgNWBI/8=;
        b=IvTzKToeim1odJsIepGdZks/zyvvn4cPHEEtsVsUrY0le4On/aaP28pOhZjc7FGVcA
         I1zRz0Tzlh2pf06OpwCmQL02t9YSZY+MElqlwRq0O9zc9RavTzE1R6QXo1PkAQ6Y8ew3
         OfUXAdzxOqQJ2PkYSnb+/H3OQee206ITPrJmDLLnngsDORT/b1neNXC3RKAS19E4TFTE
         OTxH12MjEY6UILPcM6NWZ8rbSlpbPicSFxNTmLo4cekIqY4FNj6wiz+JVh97SHGXfnH4
         tDZ8I9XWz47YOzJNLI/hMYsSfm9a6190P5bzZnSLybOg8L9PJbxin1BYKnYfkVwS+o2A
         bRjg==
X-Gm-Message-State: AOAM530x8oDxCDZj19am8Djp9P6Lny4HnCplgkcgXEXW9enzU5naZ3uT
        Deg8/vIUfCcApOAZ1tJdihoFbEa5Ovs=
X-Google-Smtp-Source: ABdhPJxtbCr8GIb3rYkwI3dJ8gQe1Ko7mzUk+OzAORpc3CsPTLvllW9CR7rz9EHcwAgV7cmNNWM1vg==
X-Received: by 2002:a05:600c:2147:: with SMTP id v7mr16400908wml.36.1637141637261;
        Wed, 17 Nov 2021 01:33:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b6sm5041913wmq.45.2021.11.17.01.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 01:33:56 -0800 (PST)
Message-Id: <pull.1076.v5.git.1637141636.gitgitgadget@gmail.com>
In-Reply-To: <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
References: <pull.1076.v4.git.1637039888.gitgitgadget@gmail.com>
From:   "Aleen via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 09:33:54 +0000
Subject: [PATCH v5 0/2] am: support --empty-commit=(die|skip|asis) option to am empty commits
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Aleen =?UTF-8?Q?=E5=BE=90=E6=B2=9B=E6=96=87?= <pwxu@coremail.cn>,
        Aleen <aleen42@vip.qq.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since that git has supported the --always option for the git-format-patch
command to create a patch with an empty commit message, git-am should
support applying and committing with empty patches.

----------------------------------------------------------------------------

Changes since v1:

 1. add a case when not passing the --always option.
 2. rename the --always option to --allow-empty.

----------------------------------------------------------------------------

Changes since v2:

 1. rename the --allow-empty option to --empty-commit.
 2. introduce three different strategies (die|skip|asis) when trying to
    record empty patches as empty commits.

----------------------------------------------------------------------------

Changes since v3:

 1. generate the missed file for test cases.
 2. grep -f cannot be used under Mac OS.

----------------------------------------------------------------------------

Changes since v4:

 1. rename the --empty-commit option to --empty.
 2. rename three different strategies (die|skip|asis) to die, drop and keep
    correspondingly.

----------------------------------------------------------------------------

Aleen (2):
  doc: git-format-patch: describe the option --always
  am: support --empty option to handle empty patches

 Documentation/git-am.txt           |  9 ++++
 Documentation/git-format-patch.txt |  6 ++-
 builtin/am.c                       | 48 ++++++++++++++++++--
 t/t4150-am.sh                      | 73 ++++++++++++++++++++++++++++++
 4 files changed, 130 insertions(+), 6 deletions(-)


base-commit: b550198c73edd4cc058832dcf74b41aeec2adba2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1076%2Faleen42%2Fnext-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1076/aleen42/next-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1076

Range-diff vs v4:

 1:  9f1b3dd6d0b = 1:  9f1b3dd6d0b doc: git-format-patch: describe the option --always
 2:  b7e30c9b7ab ! 2:  96d8573dc80 am: support --empty-commit option to handle empty patches
     @@ Metadata
      Author: Aleen <aleen42@vip.qq.com>
      
       ## Commit message ##
     -    am: support --empty-commit option to handle empty patches
     +    am: support --empty option to handle empty patches
      
          Signed-off-by: Aleen <aleen42@vip.qq.com>
      
     @@ Documentation/git-am.txt: SYNOPSIS
       	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
       	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
       	 [--quoted-cr=<action>]
     -+	 [--empty-commit=(die|skip|asis)]
     ++	 [--empty=(die|drop|keep)]
       	 [(<mbox> | <Maildir>)...]
       'git am' (--continue | --skip | --abort | --quit | --show-current-patch[=(diff|raw)])
       
     @@ Documentation/git-am.txt: OPTIONS
       --quoted-cr=<action>::
       	This flag will be passed down to 'git mailinfo' (see linkgit:git-mailinfo[1]).
       
     -+--empty-commit=(die|skip|asis)::
     ++--empty-commit=(die|drop|keep)::
      +	The command usually errors out when seeing an input e-mail
      +	message that lacks a patch. When this option is set to
     -+	'skip', skip such an e-mail message without outputting error.
     -+	When this option is set to 'asis', create an empty commit,
     ++	'drop', skip such an e-mail message without outputting error.
     ++	When this option is set to 'keep', create an empty commit,
      +	recording the contents of the e-mail message as its log.
      +	'die' is specified by default.
      +
     @@ builtin/am.c: enum show_patch_type {
       	SHOW_PATCH_DIFF = 1,
       };
       
     -+enum empty_commit_action {
     ++enum empty_action {
      +	DIE_EMPTY_COMMIT = 0,  /* output errors */
     -+	SKIP_EMPTY_COMMIT,     /* skip without outputting errors */
     -+	ASIS_EMPTY_COMMIT      /* keep recording as empty commits */
     ++	DROP_EMPTY_COMMIT,     /* skip without outputting errors */
     ++	KEEP_EMPTY_COMMIT      /* keep recording as empty commits */
      +};
      +
       struct am_state {
     @@ builtin/am.c: struct am_state {
       	int message_id;
       	int scissors; /* enum scissors_type */
       	int quoted_cr; /* enum quoted_cr_action */
     -+	int empty_commit; /* enum empty_commit_action */
     ++	int empty_type; /* enum empty_action */
       	struct strvec git_apply_opts;
       	const char *resolvemsg;
       	int committer_date_is_author_date;
     @@ builtin/am.c: static int am_option_parse_quoted_cr(const struct option *opt,
      +
      +	if (unset || !strcmp(arg, "die"))
      +		*opt_value = DIE_EMPTY_COMMIT;
     -+	else if (!strcmp(arg, "skip"))
     -+		*opt_value = SKIP_EMPTY_COMMIT;
     -+	else if (!strcmp(arg, "asis"))
     -+		*opt_value = ASIS_EMPTY_COMMIT;
     ++	else if (!strcmp(arg, "drop"))
     ++		*opt_value = DROP_EMPTY_COMMIT;
     ++	else if (!strcmp(arg, "keep"))
     ++		*opt_value = KEEP_EMPTY_COMMIT;
      +	else
     -+		return error(_("Invalid value for --empty-commit: %s"), arg);
     ++		return error(_("Invalid value for --empty: %s"), arg);
      +
      +	return 0;
      +}
     @@ builtin/am.c: static void am_run(struct am_state *state, int resume)
       			goto next;
       
      +		if (is_empty_or_missing_file(am_path(state, "patch"))) {
     -+			if (state->empty_commit == SKIP_EMPTY_COMMIT)
     ++			if (state->empty_type == DROP_EMPTY_COMMIT)
      +				goto next;
     -+			else if (state->empty_commit == ASIS_EMPTY_COMMIT) {
     ++			else if (state->empty_type == KEEP_EMPTY_COMMIT) {
      +				if (run_applypatch_msg_hook(state))
      +					exit(1);
      +				else
      +					goto commit;
     -+			} else if (state->empty_commit == DIE_EMPTY_COMMIT) {
     ++			} else if (state->empty_type == DIE_EMPTY_COMMIT) {
      +				printf_ln(_("Patch is empty."));
      +				die_user_resolve(state);
      +			}
     @@ builtin/am.c: int cmd_am(int argc, const char **argv, const char *prefix)
       		{ OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_("key-id"),
       		  N_("GPG-sign commits"),
       		  PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
     -+		{ OPTION_CALLBACK, 0, "empty-commit", &state.empty_commit,
     -+		  "(die|skip|asis)",
     ++		{ OPTION_CALLBACK, 0, "empty", &state.empty_type,
     ++		  "(die|drop|keep)",
      +		  N_("specify how to handle empty patches"),
      +		  PARSE_OPT_OPTARG, am_option_parse_empty_commit },
       		OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
       	git -C client am ../patch
       '
       
     -+test_expect_success 'still output error with --empty-commit when meeting empty files' '
     -+	test_must_fail git am --empty-commit=skip empty.patch 2>actual &&
     ++test_expect_success 'still output error with --empty when meeting empty files' '
     ++	test_must_fail git am --empty=drop empty.patch 2>actual &&
      +	echo Patch format detection failed. >expected &&
      +	test_cmp expected actual
      +'
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +	test_i18ngrep "Patch is empty." err &&
      +	rm -fr .git/rebase-apply &&
      +
     -+	test_must_fail git am --empty-commit=die empty-commit.patch >err &&
     ++	test_must_fail git am --empty=die empty-commit.patch >err &&
      +	test_path_is_dir .git/rebase-apply &&
      +	test_i18ngrep "Patch is empty." err &&
      +	rm -fr .git/rebase-apply &&
      +
     -+	test_must_fail git am --empty-commit=die cover-letter.patch >err &&
     ++	test_must_fail git am --empty=die cover-letter.patch >err &&
      +	test_path_is_dir .git/rebase-apply &&
      +	test_i18ngrep "Patch is empty." err &&
      +	rm -fr .git/rebase-apply
      +'
      +
      +test_expect_success 'skip without error when meeting e-mail message that lacks a patch' '
     -+	git am --empty-commit=skip empty-commit.patch >err &&
     ++	git am --empty=drop empty-commit.patch >err &&
      +	test_path_is_missing .git/rebase-apply &&
      +	git rev-parse empty-commit^ >expected &&
      +	git rev-parse HEAD >actual &&
      +	test_cmp expected actual &&
      +
     -+	git am --empty-commit=skip cover-letter.patch >err &&
     ++	git am --empty=drop cover-letter.patch >err &&
      +	test_path_is_missing .git/rebase-apply &&
      +	test_cmp_rev empty-commit^ HEAD
      +'
      +
      +test_expect_success 'record as an empty commit when meeting e-mail message that lacks a patch' '
     -+	git am --empty-commit=asis empty-commit.patch &&
     ++	git am --empty=keep empty-commit.patch &&
      +	test_path_is_missing .git/rebase-apply &&
      +	{
      +		git show empty-commit --format="%B" &&
     @@ t/t4150-am.sh: test_expect_success 'apply binary blob in partial clone' '
      +	git show HEAD --format="%B" >actual &&
      +	test_cmp actual expected &&
      +
     -+	git am --empty-commit=asis cover-letter.patch &&
     ++	git am --empty=keep cover-letter.patch &&
      +	test_path_is_missing .git/rebase-apply &&
      +	{
      +		echo "*** SUBJECT HERE ***" &&

-- 
gitgitgadget
