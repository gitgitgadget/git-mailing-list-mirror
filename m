Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA1EC433FE
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 19:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241904AbhL3T06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 14:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbhL3T05 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 14:26:57 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2614C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:26:56 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e5so52203332wrc.5
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 11:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HRqYWdQDx9G1BQPn3YU6r4SSkAyUoMgGyP8vZUwHMi8=;
        b=f5mjLehJn89kRCJwx6xM6p5anPQcV9154njL+EeGplUQLgZjjfHkUd2nTYA+4OSdl8
         4ukze/YF2IxdBkMEHgjooX8NrTWfNs4P+eYPrr+cTXrBUzenQfRUPSvWBk2x5DIilPx3
         PkCecF5te46lWeJyZQPQ8+t0yB7yg2vvgRPhbL65n5nln7I9HjkPEE5mDMHjUjWMPHyq
         MBIOWWMftgfqmMOQaA1joVt+V4xhWXpnUj8mhTkHpVTBrKq7Mu85EgyE7RoX+/vdwWrx
         MDsysoOU+XdAgqGaiKd1EJz1HIZYSaJuMHlcQqEZyZovDnAmc6edEa7f3TzCaH6Hjy3N
         pm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HRqYWdQDx9G1BQPn3YU6r4SSkAyUoMgGyP8vZUwHMi8=;
        b=U+99RavZ4Nez5R8SAuVYWz6vTViER1zhi1NXp8sDbHTHpS12T41VeemoN0eRX4iJSw
         t5DBYO6J67JS8U/QWzdaHMe5fJ543wdzs/Ic7LNXHDWjwo4ydrXM7MEGfGSl7E4EW80T
         HgSoRYvVuC4XOGBxRdgKUQRPv/xhHpVPI77WPFR69nzuyQ6d+ZLieVo/EMwwzHS+amGp
         ldvcENvxq4xjFwNECjZ807lUZvxthktOvbAbZ8hcZ49s6/4LCokB1PJFAxTyg2pfHMR0
         PJZbKR0wGNABxyi/g6m1SNvek1Sb48Bl+T5oZcZZwROSbi1t19IL8Ep/YkcgbKKEUBFW
         A+ig==
X-Gm-Message-State: AOAM5323OanYSW3y/2rkplwpOrj7yjbfeJEeP00X4QtUM7Nch7vMw9vp
        PWCuAzs1BuNYoXOsGJT1ST/xXr1ZHlw=
X-Google-Smtp-Source: ABdhPJxeGeHLWvg/jhubrgSR7ML5LdhbUrKaiwuFIPlVq9sU6wL4RnvzmBHi5XOwMDBbbW//EvdukA==
X-Received: by 2002:a5d:5051:: with SMTP id h17mr25998070wrt.222.1640892414991;
        Thu, 30 Dec 2021 11:26:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14sm23973311wro.58.2021.12.30.11.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 11:26:54 -0800 (PST)
Message-Id: <pull.1108.v2.git.1640892413.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
References: <pull.1108.git.1640824351.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 19:26:51 +0000
Subject: [PATCH v2 0/2] sparse checkout: custom bash completion updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on en/sparse-checkout-set. It updates custom tab
completion for the sparse-checkout command. Specifically, it corrects the
following issues with the current method:

 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
    (it is missing reapply and add).
 2. git sparse-checkout --<TAB> does not complete the help option.
 3. Options for subcommands are not tab-completable.
 4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
    both file names and directory names.

The first commit in this series is a set of failing tests that highlight
each of the above issues. The next commit updates the _git_sparse_checkout
method in git-completion.bash to enable each of these tests to pass.


Changes since V1
================

 * Rebase onto en/sparse-checkout-set.
 * Add subcommand options (including --no-cone) for set and reapply.
 * Extend 'sparse-checkout completes subcommand options' test to validate
   new set/reapply subcommand options.
 * No longer set index.sparse to false in 'sparse-checkout completes
   directory names' test.

Thanks, Lessley

Lessley Dennington (2):
  sparse-checkout: custom tab completion tests
  sparse-checkout: custom tab completion

 contrib/completion/git-completion.bash | 38 ++++++++----
 t/t9902-completion.sh                  | 85 ++++++++++++++++++++++++++
 2 files changed, 111 insertions(+), 12 deletions(-)


base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1108

Range-diff vs v1:

 1:  a7f3ae5cdda ! 1:  955fcab0052 sparse-checkout: custom tab completion tests
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +test_expect_failure 'sparse-checkout completes subcommand options' '
      +	test_completion "git sparse-checkout init --" <<-\EOF &&
      +	--cone Z
     ++	--no-cone Z
      +	--sparse-index Z
      +	--no-sparse-index Z
      +	EOF
      +
      +	test_completion "git sparse-checkout set --" <<-\EOF &&
     ++	--cone Z
     ++	--no-cone Z
     ++	--sparse-index Z
     ++	--no-sparse-index Z
      +	--stdin Z
      +	EOF
      +
     ++	test_completion "git sparse-checkout reapply --" <<-\EOF &&
     ++	--cone Z
     ++	--no-cone Z
     ++	--sparse-index Z
     ++	--no-sparse-index Z
     ++	EOF
     ++
      +	test_completion "git sparse-checkout add --" <<-\EOF
      +	--stdin Z
      +	EOF
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +	) &&
      +
      +	# initialize sparse-checkout definitions
     -+	git -C sparse-checkout config index.sparse false &&
      +	git -C sparse-checkout sparse-checkout init --cone &&
      +	git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
      +
 2:  ab51236d18c ! 2:  cecf501e076 sparse-checkout: custom tab completion
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
       	__git_complete_revlist
       }
       
     -+__git_sparse_checkout_init_opts="--cone --sparse-index --no-sparse-index"
     ++__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
      +
       _git_sparse_checkout ()
       {
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
      -	*)
      -		;;
      +	case "$prev" in
     -+		init)
     -+			__gitcomp "$__git_sparse_checkout_init_opts"
     ++		set)
     ++			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
     ++			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
      +			;;
     -+		add|set)
     ++		add)
      +			__gitcomp "--stdin"
      +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
      +			;;
     ++		init|reapply)
     ++			__gitcomp "$__git_sparse_checkout_subcommand_opts"
     ++			;;
      +		*)
      +			;;
       	esac
     @@ t/t9902-completion.sh: test_expect_failure 'sparse-checkout completes subcommand
      +test_expect_success 'sparse-checkout completes subcommand options' '
       	test_completion "git sparse-checkout init --" <<-\EOF &&
       	--cone Z
     - 	--sparse-index Z
     + 	--no-cone Z
      @@ t/t9902-completion.sh: test_expect_failure 'sparse-checkout completes subcommand options' '
       	EOF
       '

-- 
gitgitgadget
