Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBFEC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 21:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239030AbiA0VV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 16:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiA0VV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 16:21:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92910C061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:57 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m14so6836704wrg.12
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Rdo+fAQ6eb/QXBw68NX2d1AXuoponS+8eh1PdksF2g=;
        b=Qv+xf3qIsa1CEqjjDtXs4Q6D0gb+xanlc3uAKopOatgwsMOaTSK6T0H4Pnm8R88Zby
         IAAxo5scbUu6aSWRuN8Xov0sUB1AzhL11PEsvpITK8Yhfz8wv/us/boNnV9Vnc8VdmBQ
         MAc12OC4S5jBjXbQalHTeiQNRsjA5hEtiTuB4BUVHAPySR/gjrRRiCEdzcHewnUcqpYQ
         30p/DPSv7viW+6Fz7VoIdvCtrZbBoGlOMgoRV4QysnDh1RdOw9b1Eg7qH0H5UTr6OUFZ
         /BJkCOk9qj+IN8ktJw/7BU+80D4w1w9NcPMuKq2OlCJ8baC0lLE7NDiSnF+2laHZclMu
         8ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Rdo+fAQ6eb/QXBw68NX2d1AXuoponS+8eh1PdksF2g=;
        b=gplEHGwyYYN9yw8hEH6ID6OPuq6PsSBV92Reh0Sv2WVqlshVAW3oByDgj3hnKlleYf
         5RE+HOUQVB6dLGkwietR9dIulQThQIFfFVn9n4WAQzFUDGM2kOUQI9y0M4LKsTJCcFUO
         jFeboEz/3LTd5e0qel8wn60/h89JIaZ+N2VMnmR84UvRt65K9qsDDC7/xIg7Q6VqqkMw
         sRRLfu8sBA+U69JSOFr3Fy2GtsYvUl8I9uv73bb/fQBKrt1/1kXoK6nF7rK0ojwAfLex
         Dh7zNzMVoLE2rWJuWawPtiNnEH8+GVUNZrglR36i/TzgvbF1cyNs7Fn275y3qFt5V9tN
         UQHw==
X-Gm-Message-State: AOAM530rgmrmpiHsT6OyrfKenntPGJzUwDIE/gr2SpephQbONrrxJsGe
        2vTMtmAnoOQBL3TGiwvwj6NWy0v+lxY=
X-Google-Smtp-Source: ABdhPJybOmhqfVxBBABnXK63YCQgUR0BAWeHchKsJ2XbUA1U3g0XGOmY6Tvi5RKQe+LMyabjPCKLDw==
X-Received: by 2002:a5d:64e7:: with SMTP id g7mr4388994wri.711.1643318515749;
        Thu, 27 Jan 2022 13:21:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u9sm337852wmc.11.2022.01.27.13.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 13:21:55 -0800 (PST)
Message-Id: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
References: <pull.1108.v3.git.1641841193.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 Jan 2022 21:21:51 +0000
Subject: [PATCH v4 0/3] completion: sparse-checkout updates
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, johannes.schindelin@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on en/sparse-checkout-set. It updates custom tab
completion for the sparse-checkout command. Specifically, it corrects the
following issues with the current method:

 1. git sparse-checkout <TAB> results in an incomplete list of subcommands
    (it is missing reapply and add).
 2. Options for subcommands are not tab-completable.
 3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
    both file names and directory names. While this is the desired behavior
    for non-cone mode, we want to only show directories in cone mode.

The first commit in this series is a set of tests that highlight each of the
above issues. The next commit updates the _git_sparse_checkout method in
git-completion.bash to enable previously-failing tests to pass. The final
commit modifies the original implementation (which recursively printed
prospective directories for completion) to only print directories at the
current level for improved performance.


Changes since V3
================

 * Update commit descriptions to begin with completion instead of
   sparse-checkout.
 * Remove explicit completion of --help, as this is inconsistent with the
   rest of the completion script.
 * Use __gitcomp_builtin to auto-complete subcommand options (and remove
   option completion test from previous iterations, as it is no longer
   necessary).
 * Use __git_complete_index_file helper function in place of __gitcomp
   "$(git ls-tree -d -r HEAD --name-only).
 * If in cone-mode sparse checkout, only show directory completions. If in
   non-cone mode sparse checkout show both files and directories.


Changes since V2
================

 * Change use of $prev to $subcommand in _git_sparse_checkout() method in
   git-completion.bash.
 * State explicitly that directory completion applies in both cone and
   non-cone mode in 'sparse-checkout: custom tab completion' commit
 * Add new patch with __gitcomp_directories method to improve performance by
   only outputting directories at the current level.


Changes since V1
================

 * Rebase onto en/sparse-checkout-set.
 * Add subcommand options (including --no-cone) for set and reapply.
 * Extend 'sparse-checkout completes subcommand options' test to validate
   new set/reapply subcommand options.
 * No longer set index.sparse to false in 'sparse-checkout completes
   directory names' test.

Thanks, Lessley

Lessley Dennington (3):
  completion: add sparse-checkout tests
  completion: sparse-checkout updates
  completion: ensure cone mode completion with multiple <TAB>s

 contrib/completion/git-completion.bash | 44 ++++++++++++---
 t/t9902-completion.sh                  | 75 ++++++++++++++++++++++++++
 2 files changed, 112 insertions(+), 7 deletions(-)


base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1108

Range-diff vs v3:

 1:  bbc2d21e1d1 ! 1:  5bb598a055d sparse-checkout: custom tab completion tests
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    sparse-checkout: custom tab completion tests
     +    completion: add sparse-checkout tests
      
     -    Add tests for missing/incorrect components of custom tab completion for the
     -    sparse-checkout command. These tests specifically highlight the following:
     +    Add tests for missing/incorrect components of custom tab completion for
     +    the sparse-checkout command. These tests specifically highlight the
     +    following:
      
          1. git sparse-checkout <TAB> results in an incomplete list of subcommands
          (it is missing reapply and add).
     -    2. git sparse-checkout --<TAB> does not complete the help option.
     -    3. Options for subcommands are not tab-completable.
     -    4. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
     -    both file names and directory names.
     +    2. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
     +    both file names and directory names. While this is the correct behavior
     +    for non-cone mode, cone mode sparse checkouts should complete only
     +    directory names.
      
     -    Although these tests currently fail, they will succeed with the
     -    sparse-checkout modifications in git-completion.bash in the next commit in
     -    this series.
     +    Although the first two of these tests currently fail, they will succeed
     +    with the sparse-checkout modifications in git-completion.bash in the next
     +    commit in this series.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
      
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +	EOF
      +'
      +
     -+test_expect_failure 'sparse-checkout completes options' '
     -+	test_completion "git sparse-checkout --" <<-\EOF
     -+	--help Z
     -+	EOF
     -+'
     -+
     -+test_expect_failure 'sparse-checkout completes subcommand options' '
     -+	test_completion "git sparse-checkout init --" <<-\EOF &&
     -+	--cone Z
     -+	--no-cone Z
     -+	--sparse-index Z
     -+	--no-sparse-index Z
     -+	EOF
     -+
     -+	test_completion "git sparse-checkout set --" <<-\EOF &&
     -+	--cone Z
     -+	--no-cone Z
     -+	--sparse-index Z
     -+	--no-sparse-index Z
     -+	--stdin Z
     -+	EOF
     -+
     -+	test_completion "git sparse-checkout reapply --" <<-\EOF &&
     -+	--cone Z
     -+	--no-cone Z
     -+	--sparse-index Z
     -+	--no-sparse-index Z
     -+	EOF
     -+
     -+	test_completion "git sparse-checkout add --" <<-\EOF
     -+	--stdin Z
     -+	EOF
     -+'
     -+
     -+test_expect_failure 'sparse-checkout completes directory names' '
     ++test_expect_failure 'cone mode sparse-checkout completes directory names' '
      +	# set up sparse-checkout repo
      +	git init sparse-checkout &&
      +	(
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +	) &&
      +
      +	# initialize sparse-checkout definitions
     -+	git -C sparse-checkout sparse-checkout init --cone &&
     -+	git -C sparse-checkout sparse-checkout set folder1/0 folder3 &&
     ++	git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
      +
      +	# test tab completion
      +	(
      +		cd sparse-checkout &&
      +		test_completion "git sparse-checkout set f" <<-\EOF
     -+		folder1 Z
     -+		folder1/0 Z
     -+		folder1/0/1 Z
     -+		folder2 Z
     -+		folder2/0 Z
     -+		folder3 Z
     ++		folder1
     ++		folder2
     ++		folder3
     ++		EOF
     ++	) &&
     ++
     ++	(
     ++		cd sparse-checkout &&
     ++		test_completion "git sparse-checkout set folder1/" <<-\EOF
     ++		folder1/0
     ++		EOF
     ++	) &&
     ++
     ++	(
     ++		cd sparse-checkout &&
     ++		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
     ++		folder1/0/1
      +		EOF
      +	) &&
      +
      +	(
      +		cd sparse-checkout/folder1 &&
     -+		test_completion "git sparse-checkout add " <<-\EOF
     -+		./ Z
     -+		0 Z
     -+		0/1 Z
     ++		test_completion "git sparse-checkout add 0" <<-\EOF
     ++		0
     ++		EOF
     ++	)
     ++'
     ++
     ++test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
     ++	# reset sparse-checkout repo to non-cone mode
     ++	git -C sparse-checkout sparse-checkout disable &&
     ++	git -C sparse-checkout sparse-checkout set &&
     ++
     ++	# test tab completion
     ++	(
     ++		cd sparse-checkout &&
     ++		# expected to be empty since we have not configured
     ++		# custom completion for non-cone mode
     ++		test_completion "git sparse-checkout set f" <<-\EOF
     ++
      +		EOF
      +	)
      +'
 2:  256e5f034c6 ! 2:  7d70beb2a6b sparse-checkout: custom tab completion
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    sparse-checkout: custom tab completion
     +    completion: sparse-checkout updates
      
     -    Fix custom tab completion for sparse-checkout command. This will ensure:
     +    Fix custom tab completion for the sparse-checkout command. This will
     +    ensure:
      
          1. The full list of subcommands is provided when users enter git
          sparse-checkout <TAB>.
     -    2. The --help option is tab-completable.
     -    3. Subcommand options are tab-completable.
     -    4. A list of directories (but not files) is provided when users enter git
     -    sparse-checkout add <TAB> or git sparse-checkout set <TAB>. It is
     -    important to note that this will apply for both cone mode and non-cone
     -    mode (even though non-cone mode matches on patterns rather than
     -    directories).
     +    2. Subcommand options are tab-completable.
     +    3. A list of directories (but not files) is provided when users enter git
     +    sparse-checkout add <TAB> or git sparse-checkout set <TAB> in cone mode
     +    only. In non-cone mode, these commands will continue to complete both
     +    directory and file names.
      
          Failing tests that were added in the previous commit to verify these
          scenarios are now passing with these updates.
     @@ Commit message
      
       ## contrib/completion/git-completion.bash ##
      @@ contrib/completion/git-completion.bash: _git_show_branch ()
     - 	__git_complete_revlist
     - }
       
     -+__git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
     -+
       _git_sparse_checkout ()
       {
      -	local subcommands="list init set disable"
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
       	local subcommand="$(__git_find_on_cmdline "$subcommands")"
      +
       	if [ -z "$subcommand" ]; then
     --		__gitcomp "$subcommands"
     --		return
     -+		case "$cur" in
     -+			--*)
     -+				__gitcomp "--help"
     -+				;;
     -+			*)
     -+				__gitcomp "$subcommands"
     -+				;;
     -+		esac
     + 		__gitcomp "$subcommands"
     + 		return
       	fi
       
     --	case "$subcommand,$cur" in
     + 	case "$subcommand,$cur" in
      -	init,--*)
      -		__gitcomp "--cone"
      -		;;
      -	set,--*)
      -		__gitcomp "--stdin"
     --		;;
     ++		*,--*)
     ++			__gitcomp_builtin sparse-checkout_$subcommand "" "--"
     + 		;;
      -	*)
     --		;;
     -+	case "$subcommand" in
     -+		set)
     -+			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
     -+			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
     -+			;;
     -+		add)
     -+			__gitcomp "--stdin"
     -+			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
     -+			;;
     -+		init|reapply)
     -+			__gitcomp "$__git_sparse_checkout_subcommand_opts"
     -+			;;
     -+		*)
     -+			;;
     ++		set,*|add,*)
     ++			if [ $(__git config core.sparseCheckoutCone) ]; then
     ++				__git_complete_index_file "--directory"
     ++			fi
     + 		;;
       	esac
       }
     - 
      
       ## t/t9902-completion.sh ##
      @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, complete only references' '
     @@ t/t9902-completion.sh: test_expect_failure 'sparse-checkout completes subcommand
       	EOF
       '
       
     --test_expect_failure 'sparse-checkout completes options' '
     -+test_expect_success 'sparse-checkout completes options' '
     - 	test_completion "git sparse-checkout --" <<-\EOF
     - 	--help Z
     - 	EOF
     - '
     - 
     --test_expect_failure 'sparse-checkout completes subcommand options' '
     -+test_expect_success 'sparse-checkout completes subcommand options' '
     - 	test_completion "git sparse-checkout init --" <<-\EOF &&
     - 	--cone Z
     - 	--no-cone Z
     -@@ t/t9902-completion.sh: test_expect_failure 'sparse-checkout completes subcommand options' '
     - 	EOF
     - '
     - 
     --test_expect_failure 'sparse-checkout completes directory names' '
     -+test_expect_success 'sparse-checkout completes directory names' '
     +-test_expect_failure 'cone mode sparse-checkout completes directory names' '
     ++test_expect_success 'cone mode sparse-checkout completes directory names' '
       	# set up sparse-checkout repo
       	git init sparse-checkout &&
       	(
 3:  aa9ea67180d ! 3:  760cae85bd4 sparse-checkout: limit tab completion to a single level
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    sparse-checkout: limit tab completion to a single level
     +    completion: ensure cone mode completion with multiple <TAB>s
      
     -    Ensure only directories at the current level will be tab-completed with
     -    the sparse-checkout command. For example, if paths a/b/c/ and a/d/ exist
     -    in the current directory, running a/<TAB> will result in:
     +    Ensure users in a cone mode sparse checkout can tab-complete to
     +    directories at multiple levels with multiple <TAB>s. For example, if path
     +    a/b/c/ exists in the current directory, running a<TAB>b<TAB> will result
     +    in:
      
     -            a/b/
     -            a/d/
     +            a/b/c/
      
          The 'sparse-checkout completes directory names' test has also been
     -    updated/extended according to these changes.
     +    updated with trailing slashes according to these changes.
      
          Co-authored-by: Elijah Newren <newren@gmail.com>
          Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
      +     fi
      +}
      +
     - __git_sparse_checkout_subcommand_opts="--cone --no-cone --sparse-index --no-sparse-index"
     - 
       _git_sparse_checkout ()
     + {
     + 	local subcommands="list init set disable add reapply"
     + 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
     +-
     + 	if [ -z "$subcommand" ]; then
     + 		__gitcomp "$subcommands"
     + 		return
      @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
     - 	case "$subcommand" in
     - 		set)
     - 			__gitcomp "$__git_sparse_checkout_subcommand_opts --stdin"
     --			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
     -+			__gitcomp_directories
     - 			;;
     - 		add)
     - 			__gitcomp "--stdin"
     --			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
     -+			__gitcomp_directories
     - 			;;
     - 		init|reapply)
     - 			__gitcomp "$__git_sparse_checkout_subcommand_opts"
     + 		;;
     + 		set,*|add,*)
     + 			if [ $(__git config core.sparseCheckoutCone) ]; then
     +-				__git_complete_index_file "--directory"
     ++				__gitcomp_directories
     + 			fi
     + 		;;
     + 	esac
      
       ## t/t9902-completion.sh ##
     -@@ t/t9902-completion.sh: test_expect_success 'sparse-checkout completes directory names' '
     +@@ t/t9902-completion.sh: test_expect_success 'cone mode sparse-checkout completes directory names' '
       	(
       		cd sparse-checkout &&
       		test_completion "git sparse-checkout set f" <<-\EOF
     --		folder1 Z
     --		folder1/0 Z
     --		folder1/0/1 Z
     --		folder2 Z
     --		folder2/0 Z
     --		folder3 Z
     +-		folder1
     +-		folder2
     +-		folder3
      +		folder1/
      +		folder2/
      +		folder3/
     -+		EOF
     -+	) &&
     -+
     -+	(
     -+		cd sparse-checkout &&
     -+		test_completion "git sparse-checkout set folder1/" <<-\EOF
     + 		EOF
     + 	) &&
     + 
     + 	(
     + 		cd sparse-checkout &&
     + 		test_completion "git sparse-checkout set folder1/" <<-\EOF
     +-		folder1/0
      +		folder1/0/
     -+		EOF
     -+	) &&
     -+
     -+	(
     -+		cd sparse-checkout &&
     -+		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
     + 		EOF
     + 	) &&
     + 
     + 	(
     + 		cd sparse-checkout &&
     + 		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
     +-		folder1/0/1
      +		folder1/0/1/
       		EOF
       	) &&
       
       	(
       		cd sparse-checkout/folder1 &&
     --		test_completion "git sparse-checkout add " <<-\EOF
     --		./ Z
     --		0 Z
     --		0/1 Z
     -+		test_completion "git sparse-checkout add 0" <<-\EOF
     + 		test_completion "git sparse-checkout add 0" <<-\EOF
     +-		0
      +		0/
       		EOF
       	)

-- 
gitgitgadget
