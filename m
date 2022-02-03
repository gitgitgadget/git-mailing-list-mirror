Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E22C433FE
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 20:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354869AbiBCUrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356599AbiBCUq2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 15:46:28 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB088C0619C2
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 12:44:53 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id j16so7278462wrd.8
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 12:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HrYl4YlsGlk9aphifiA2pqsoOt/0DPqqJ142xmzfig8=;
        b=avSpf7W0nKMv9rQdLDDhV8cT9A8eHGOsWGquQ5rloUI4Oinc1XBGaq1qcUfYOEmGP5
         DRNfKRWUv6SFSJp4GA6F8SkzsfHNlDLXud5z9AfXBPcmp6yVxP69fwjr7nYoRUoo52E1
         23X5l5ybP8wRKjHc8gKmhPRYGbUX/RypCRk2qRv0oauXP032TSzKUwhm4Z5XdxjZ+Lny
         kbu3IXU+VMzm7h0lr33rOCLvTwBlrvlGRXGa2Gf8BM0N2xxoc+mrMb9va3rS5qbqH1UN
         v/9I6AN6v7wLcfLriQXPQBGMdR94/3cHOAChkql9bVeLmbL97fQh6yiE/uNAquoSjPSQ
         zBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HrYl4YlsGlk9aphifiA2pqsoOt/0DPqqJ142xmzfig8=;
        b=mmzllp5VA6+MOTI0CJpJAOBKvoei4N4tx2/2wZE+Gh73RxHEXHIgSzHwpeIxRLU6J4
         9jBxjMCDKf35SZT0oAsKvpwMBm2KpblcXD9ij/9317ewl2x7AafKhkSnHCgQHCXaEbLs
         k7QVf7VVDnM49mXHLwCCcZMX+0FvsJLAT+y+O4nwtFjik8xdN4r2FvdHZ23kMN/WrUZh
         c+qwdUZ2gCm1dA34v2PxWZRyRE1dM54i/KNqaGA8CFP3b6k8gPma/W2d76nnX3CE0KkO
         NC2B5xUoL4DMdQog38WO3/IfsnsvWIhx8HvZftetKsjlCfSA7cCT91IO+Zbfyd0iD1nX
         YJHA==
X-Gm-Message-State: AOAM533MzQoYfkJbRwsWUdhvIOKWQ80e8iVtCMawqD8bMIiWv9cpnslh
        PMIeI2x3ejIdNZ4HrWgucvjzyqnEvtc=
X-Google-Smtp-Source: ABdhPJwIDR150lWXO7YGC6N28fjaOfWt70ewf4mnQ/omw4nWi6yg1X1KzWXfoeORDQjFx+LoL+IBhw==
X-Received: by 2002:a5d:47a9:: with SMTP id 9mr31396583wrb.31.1643921092075;
        Thu, 03 Feb 2022 12:44:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm25773586wry.52.2022.02.03.12.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 12:44:51 -0800 (PST)
Message-Id: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 20:44:48 +0000
Subject: [PATCH v5 0/3] completion: sparse-checkout updates
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
    both file names and directory names. While this may be a less surprising
    behavior for non-cone mode, we want to only show directories in cone
    mode.

The first commit in this series is an intermediate step that fixes issues 1
and 2 above and introduces a simple fix for issue 3 with some performance
and unusual character-related caveats. The next commit adds a new
__gitcomp_directories method that fixes the performance-related caveat from
the first commit by completing just a single level of directories. The final
commit modifies __gitcomp_directories to handle unusual characters in
directory names.


Changes since V4
================

 * Clarify that completing on files and directories is a less-surprising
   behavior in non-cone mode (rather than definitely the correct behavior)
   in commit message and cover letter.
 * Add explicit --no-cone to non-cone mode sparse-checkout completion test.
 * Replace use of __git_complete_index_file with a new version of
   __gitcomp_directories that is able to handle unusual characters.
 * Ensure that users running git sparse-checkout set --cone get cone
   mode-style completion whether or not they already have the cone mode
   config set.
 * Refactor creation of sparse-checkout test repo into a sparse-checkout
   setup test.


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
 * Refactor creation of sparse-checkout repo into a setup test.

Thanks, Lessley

Lessley Dennington (3):
  completion: address sparse-checkout issues
  completion: improve sparse-checkout cone mode directory completion
  completion: handle unusual characters for sparse-checkout

 contrib/completion/git-completion.bash |  44 ++++++++--
 t/t9902-completion.sh                  | 117 +++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 8 deletions(-)


base-commit: dfac9b609f86cd4f6ce896df9e1172d2a02cde48
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1108

Range-diff vs v4:

 1:  5bb598a055d ! 1:  a1c46c763fd completion: add sparse-checkout tests
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    completion: add sparse-checkout tests
     +    completion: address sparse-checkout issues
      
     -    Add tests for missing/incorrect components of custom tab completion for
     -    the sparse-checkout command. These tests specifically highlight the
     -    following:
     +    Correct multiple issues with tab completion of the git sparse-checkout
     +    command. These issues were:
      
     -    1. git sparse-checkout <TAB> results in an incomplete list of subcommands
     -    (it is missing reapply and add).
     -    2. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
     -    both file names and directory names. While this is the correct behavior
     -    for non-cone mode, cone mode sparse checkouts should complete only
     -    directory names.
     +    1. git sparse-checkout <TAB> previously resulted in an incomplete list of
     +    subcommands (it was missing reapply and add).
     +    2. Subcommand options were not tab-completable.
     +    3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> showed
     +    both file names and directory names. While this may be a less surprising
     +    behavior for non-cone mode, cone mode sparse checkouts should complete
     +    only directory names.
      
     -    Although the first two of these tests currently fail, they will succeed
     -    with the sparse-checkout modifications in git-completion.bash in the next
     -    commit in this series.
     +    Note that while the new strategy of just using git ls-tree to complete on
     +    directory names is simple and a step in the right direction, it does have
     +    some caveats. These are:
     +
     +    1. Likelihood of poor performance in large monorepos (as a result of
     +    recursively completing directory names).
     +    2. Inability to handle paths containing unusual characters.
     +
     +    These caveats will be fixed by subsequent commits in this series.
      
          Signed-off-by: Lessley Dennington <lessleydennington@gmail.com>
      
     + ## contrib/completion/git-completion.bash ##
     +@@ contrib/completion/git-completion.bash: _git_show_branch ()
     + 
     + _git_sparse_checkout ()
     + {
     +-	local subcommands="list init set disable"
     ++	local subcommands="list init set disable add reapply"
     + 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
     + 	if [ -z "$subcommand" ]; then
     + 		__gitcomp "$subcommands"
     +@@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
     + 	fi
     + 
     + 	case "$subcommand,$cur" in
     +-	init,--*)
     +-		__gitcomp "--cone"
     +-		;;
     +-	set,--*)
     +-		__gitcomp "--stdin"
     +-		;;
     +-	*)
     ++	*,--*)
     ++		__gitcomp_builtin sparse-checkout_$subcommand "" "--"
     + 		;;
     ++	set,*|add,*)
     ++		if [ $(__git config core.sparseCheckoutCone) ] ||
     ++		[ "$(__git_find_on_cmdline --cone)" ]; then
     ++			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
     ++		fi
     + 	esac
     + }
     + 
     +
       ## t/t9902-completion.sh ##
      @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, complete only references' '
       	EOF
       '
       
     -+test_expect_failure 'sparse-checkout completes subcommands' '
     -+	test_completion "git sparse-checkout " <<-\EOF
     -+	list Z
     -+	init Z
     -+	set Z
     -+	add Z
     -+	reapply Z
     -+	disable Z
     -+	EOF
     -+'
     -+
     -+test_expect_failure 'cone mode sparse-checkout completes directory names' '
     ++test_expect_success 'setup sparse-checkout tests' '
      +	# set up sparse-checkout repo
      +	git init sparse-checkout &&
      +	(
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +		touch folder3/t.txt &&
      +		git add . &&
      +		git commit -am "Initial commit"
     -+	) &&
     ++	)
     ++'
     ++
     ++test_expect_success 'sparse-checkout completes subcommands' '
     ++	test_completion "git sparse-checkout " <<-\EOF
     ++	list Z
     ++	init Z
     ++	set Z
     ++	add Z
     ++	reapply Z
     ++	disable Z
     ++	EOF
     ++'
      +
     ++test_expect_success 'cone mode sparse-checkout completes directory names' '
      +	# initialize sparse-checkout definitions
      +	git -C sparse-checkout sparse-checkout set --cone folder1/0 folder3 &&
      +
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +	(
      +		cd sparse-checkout &&
      +		test_completion "git sparse-checkout set f" <<-\EOF
     -+		folder1
     -+		folder2
     -+		folder3
     -+		EOF
     -+	) &&
     -+
     -+	(
     -+		cd sparse-checkout &&
     -+		test_completion "git sparse-checkout set folder1/" <<-\EOF
     -+		folder1/0
     -+		EOF
     -+	) &&
     -+
     -+	(
     -+		cd sparse-checkout &&
     -+		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
     -+		folder1/0/1
     ++		folder1 Z
     ++		folder1/0 Z
     ++		folder1/0/1 Z
     ++		folder2 Z
     ++		folder2/0 Z
     ++		folder3 Z
      +		EOF
      +	) &&
      +
      +	(
      +		cd sparse-checkout/folder1 &&
     -+		test_completion "git sparse-checkout add 0" <<-\EOF
     -+		0
     ++		test_completion "git sparse-checkout add " <<-\EOF
     ++		./ Z
     ++		0 Z
     ++		0/1 Z
      +		EOF
      +	)
      +'
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
      +	# reset sparse-checkout repo to non-cone mode
      +	git -C sparse-checkout sparse-checkout disable &&
     -+	git -C sparse-checkout sparse-checkout set &&
     ++	git -C sparse-checkout sparse-checkout set --no-cone &&
      +
     -+	# test tab completion
      +	(
      +		cd sparse-checkout &&
      +		# expected to be empty since we have not configured
     @@ t/t9902-completion.sh: test_expect_success 'git checkout - with --detach, comple
      +		EOF
      +	)
      +'
     ++
     ++test_expect_success 'git sparse-checkout set --cone completes directory names' '
     ++	git -C sparse-checkout sparse-checkout disable &&
     ++
     ++	(
     ++		cd sparse-checkout &&
     ++		test_completion "git sparse-checkout set --cone f" <<-\EOF
     ++		folder1 Z
     ++		folder1/0 Z
     ++		folder1/0/1 Z
     ++		folder2 Z
     ++		folder2/0 Z
     ++		folder3 Z
     ++		EOF
     ++	)
     ++'
      +
       test_expect_success 'git switch - with -d, complete all references' '
       	test_completion "git switch -d " <<-\EOF
 2:  7d70beb2a6b < -:  ----------- completion: sparse-checkout updates
 3:  760cae85bd4 ! 2:  5b8d53402ae completion: ensure cone mode completion with multiple <TAB>s
     @@ Metadata
      Author: Lessley Dennington <lessleydennington@gmail.com>
      
       ## Commit message ##
     -    completion: ensure cone mode completion with multiple <TAB>s
     +    completion: improve sparse-checkout cone mode directory completion
      
     -    Ensure users in a cone mode sparse checkout can tab-complete to
     -    directories at multiple levels with multiple <TAB>s. For example, if path
     -    a/b/c/ exists in the current directory, running a<TAB>b<TAB> will result
     -    in:
     +    Use new __gitcomp_directories method to complete directory names in cone
     +    mode sparse-checkouts. This method addresses the caveat of poor
     +    performance in monorepos from the previous commit (by completing only one
     +    level of directories).
      
     -            a/b/c/
     -
     -    The 'sparse-checkout completes directory names' test has also been
     -    updated with trailing slashes according to these changes.
     +    The unusual character caveat from the previous commit will be fixed by the
     +    final commit in this series.
      
          Co-authored-by: Elijah Newren <newren@gmail.com>
          Co-authored-by: Lessley Dennington <lessleydennington@gmail.com>
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
       _git_sparse_checkout ()
       {
       	local subcommands="list init set disable add reapply"
     - 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
     --
     - 	if [ -z "$subcommand" ]; then
     - 		__gitcomp "$subcommands"
     - 		return
      @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
     - 		;;
     - 		set,*|add,*)
     - 			if [ $(__git config core.sparseCheckoutCone) ]; then
     --				__git_complete_index_file "--directory"
     -+				__gitcomp_directories
     - 			fi
     - 		;;
     + 	set,*|add,*)
     + 		if [ $(__git config core.sparseCheckoutCone) ] ||
     + 		[ "$(__git_find_on_cmdline --cone)" ]; then
     +-			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
     ++			__gitcomp_directories
     + 		fi
       	esac
     + }
      
       ## t/t9902-completion.sh ##
      @@ t/t9902-completion.sh: test_expect_success 'cone mode sparse-checkout completes directory names' '
       	(
       		cd sparse-checkout &&
       		test_completion "git sparse-checkout set f" <<-\EOF
     --		folder1
     --		folder2
     --		folder3
     +-		folder1 Z
     +-		folder1/0 Z
     +-		folder1/0/1 Z
     +-		folder2 Z
     +-		folder2/0 Z
     +-		folder3 Z
      +		folder1/
      +		folder2/
      +		folder3/
     - 		EOF
     - 	) &&
     - 
     - 	(
     - 		cd sparse-checkout &&
     - 		test_completion "git sparse-checkout set folder1/" <<-\EOF
     --		folder1/0
     ++		EOF
     ++	) &&
     ++
     ++	(
     ++		cd sparse-checkout &&
     ++		test_completion "git sparse-checkout set folder1/" <<-\EOF
      +		folder1/0/
     - 		EOF
     - 	) &&
     - 
     - 	(
     - 		cd sparse-checkout &&
     - 		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
     --		folder1/0/1
     ++		EOF
     ++	) &&
     ++
     ++	(
     ++		cd sparse-checkout &&
     ++		test_completion "git sparse-checkout set folder1/0/" <<-\EOF
      +		folder1/0/1/
       		EOF
       	) &&
       
       	(
       		cd sparse-checkout/folder1 &&
     - 		test_completion "git sparse-checkout add 0" <<-\EOF
     --		0
     +-		test_completion "git sparse-checkout add " <<-\EOF
     +-		./ Z
     +-		0 Z
     +-		0/1 Z
     ++		test_completion "git sparse-checkout add 0" <<-\EOF
      +		0/
       		EOF
       	)
       '
     +@@ t/t9902-completion.sh: test_expect_success 'git sparse-checkout set --cone completes directory names' '
     + 	(
     + 		cd sparse-checkout &&
     + 		test_completion "git sparse-checkout set --cone f" <<-\EOF
     +-		folder1 Z
     +-		folder1/0 Z
     +-		folder1/0/1 Z
     +-		folder2 Z
     +-		folder2/0 Z
     +-		folder3 Z
     ++		folder1/
     ++		folder2/
     ++		folder3/
     + 		EOF
     + 	)
     + '
 -:  ----------- > 3:  ddf5e583dd7 completion: handle unusual characters for sparse-checkout

-- 
gitgitgadget
