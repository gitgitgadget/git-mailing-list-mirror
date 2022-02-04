Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B440C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 03:26:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356712AbiBDD0m (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 22:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiBDD0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 22:26:41 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F61C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 19:26:41 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id f80-20020a1c1f53000000b0035399b8bedcso8236044wmf.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 19:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wTKCUaXeW7Vq3F4MQCtkqAl6AylW5lND67AabQ/Xueo=;
        b=qZocY41MqKnkBioA9rumbK3M4TVD7UblKRbcjYT6lLwrWIQXLKoWcdZOjmPBaTZDid
         6NBICSgfFOiXrWPSjSKzMqHwTXtpfdc0Ezq20WvJdHaw1DQs5D1FAPdSjTnr8GD/z7iJ
         BJ2zMSAOGN6UlNiJkdmJrbbfUELIwHNMUTDSqMZQra8D+Hf5GE+GZM+K/1dLLY0SygHS
         A0/ZuckZw/3ykjMUVcIHN1f1AzA8JLafL+1qpf+KL2XcmyVg4V94H1eTTRPX52kWquZM
         NTQWEJDHuvWxJhjFwwge/7F2Vt/7zIt3ExgkK+Sc7Burgijh6oJpRtwb73KsOJNr1o3y
         MNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wTKCUaXeW7Vq3F4MQCtkqAl6AylW5lND67AabQ/Xueo=;
        b=y1GVpxkzZdFfDcIvCC8vOCPfG9Me6U/lc3+fdm8T5gWGEdr7f1mR6HSRBePfyHKpNk
         spaqqNGtri9fR9JX+1NoLfdt0/kf4X2lJLOt4sGOe0EVKvqppUNqgYDDUFsMVxPuFDEl
         dMElYPQfCH/PzD9IL79IKllBZhK4wg9YBw096205LxPuqzdmGy0YuiLv5qxyvRRElW8T
         7IRiibW9pLJpGuSOoda6y6WEwebs9m3Aa1+wYMy1geRzdTkf0lO26fIaUh5HIHKkscMc
         PHJrlt53kd2OQFldNY6n4vgkyER2OLqvoLIsSDlLpz4A1zPavPjbk4djOycq1LVGpOEX
         M0VA==
X-Gm-Message-State: AOAM531SaUdDyQm8H0p3ApaqJoLu0jt7u8B4rolz1wATqNWbv7TuXQ6A
        3MywWRhBMs420g6RTxUSO6nUfocFYJY=
X-Google-Smtp-Source: ABdhPJxgpo2BMMBos0NP9eqcjLfV8Tw2lXmB6ja8QMKgiNATHCBO6gokrmG6kNPhj0EzFVWC7tAfPQ==
X-Received: by 2002:a7b:c942:: with SMTP id i2mr545058wml.166.1643945199150;
        Thu, 03 Feb 2022 19:26:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f8sm632849wry.12.2022.02.03.19.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 19:26:38 -0800 (PST)
Message-Id: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
From:   "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Feb 2022 03:26:35 +0000
Subject: [PATCH v6 0/3] completion: sparse-checkout updates
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

This change updates custom tab completion for the sparse-checkout command.
Specifically, it corrects the following issues with the current method:

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


Changes since V5
================

 * Fix incorrect conditional that was causing failure of non-cone mode test
   (and causing 'seen' CI to fail).
 * Remove __git_comp_directories indentation changes between the second and
   third commits.


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
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1108%2Fldennington%2Fsparse-checkout-bash-completion-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1108/ldennington/sparse-checkout-bash-completion-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/1108

Range-diff vs v5:

 1:  a1c46c763fd ! 1:  23390000dd3 completion: address sparse-checkout issues
     @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
      +		__gitcomp_builtin sparse-checkout_$subcommand "" "--"
       		;;
      +	set,*|add,*)
     -+		if [ $(__git config core.sparseCheckoutCone) ] ||
     -+		[ "$(__git_find_on_cmdline --cone)" ]; then
     ++		if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||
     ++		[ -n "$(__git_find_on_cmdline --cone)" ]; then
      +			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
      +		fi
       	esac
 2:  5b8d53402ae ! 2:  10a190ce6a1 completion: improve sparse-checkout cone mode directory completion
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
       
      +__gitcomp_directories ()
      +{
     -+     local _tmp_dir _tmp_completions
     ++	local _tmp_dir _tmp_completions
      +
     -+     # Get the directory of the current token; this differs from dirname
     -+     # in that it keeps up to the final trailing slash.  If no slash found
     -+     # that's fine too.
     -+     [[ "$cur" =~ .*/ ]]
     -+     _tmp_dir=$BASH_REMATCH
     ++	# Get the directory of the current token; this differs from dirname
     ++	# in that it keeps up to the final trailing slash.  If no slash found
     ++	# that's fine too.
     ++	[[ "$cur" =~ .*/ ]]
     ++	_tmp_dir=$BASH_REMATCH
      +
     -+     # Find possible directory completions, adding trailing '/' characters
     -+     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
     -+         sed -e s%$%/%)"
     ++	# Find possible directory completions, adding trailing '/' characters
     ++	_tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
     ++		sed -e s%$%/%)"
      +
     -+     if [[ -n "$_tmp_completions" ]]; then
     -+         # There were some directory completions, so find ones that
     -+         # start with "$cur", the current token, and put those in COMPREPLY
     -+         local i=0 c IFS=$' \t\n'
     -+         for c in $_tmp_completions; do
     -+             if [[ $c == "$cur"* ]]; then
     -+                 COMPREPLY+=("$c")
     -+             fi
     -+         done
     -+     elif [[ "$cur" =~ /$ ]]; then
     -+         # No possible further completions any deeper, so assume we're at
     -+         # a leaf directory and just consider it complete
     -+         __gitcomp_direct_append "$cur "
     -+     fi
     ++	if [[ -n "$_tmp_completions" ]]; then
     ++		# There were some directory completions, so find ones that
     ++		# start with "$cur", the current token, and put those in COMPREPLY
     ++		local i=0 c IFS=$' \t\n'
     ++		for c in $_tmp_completions; do
     ++		if [[ $c == "$cur"* ]]; then
     ++			COMPREPLY+=("$c")
     ++		fi
     ++		done
     ++	elif [[ "$cur" =~ /$ ]]; then
     ++		# No possible further completions any deeper, so assume we're at
     ++		# a leaf directory and just consider it complete
     ++		__gitcomp_direct_append "$cur "
     ++	fi
      +}
      +
       _git_sparse_checkout ()
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
       	local subcommands="list init set disable add reapply"
      @@ contrib/completion/git-completion.bash: _git_sparse_checkout ()
       	set,*|add,*)
     - 		if [ $(__git config core.sparseCheckoutCone) ] ||
     - 		[ "$(__git_find_on_cmdline --cone)" ]; then
     + 		if [ "$(__git config core.sparseCheckoutCone)" == "true" ] ||
     + 		[ -n "$(__git_find_on_cmdline --cone)" ]; then
      -			__gitcomp "$(git ls-tree -d -r HEAD --name-only)"
      +			__gitcomp_directories
       		fi
 3:  ddf5e583dd7 ! 3:  e805dbb58cc completion: handle unusual characters for sparse-checkout
     @@ contrib/completion/git-completion.bash: _git_show_branch ()
       
       __gitcomp_directories ()
       {
     --     local _tmp_dir _tmp_completions
     --
     --     # Get the directory of the current token; this differs from dirname
     --     # in that it keeps up to the final trailing slash.  If no slash found
     --     # that's fine too.
     --     [[ "$cur" =~ .*/ ]]
     --     _tmp_dir=$BASH_REMATCH
     --
     --     # Find possible directory completions, adding trailing '/' characters
     --     _tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
     --         sed -e s%$%/%)"
     --
     --     if [[ -n "$_tmp_completions" ]]; then
     --         # There were some directory completions, so find ones that
     --         # start with "$cur", the current token, and put those in COMPREPLY
     --         local i=0 c IFS=$' \t\n'
     --         for c in $_tmp_completions; do
     --             if [[ $c == "$cur"* ]]; then
     --                 COMPREPLY+=("$c")
     --             fi
     --         done
     --     elif [[ "$cur" =~ /$ ]]; then
     --         # No possible further completions any deeper, so assume we're at
     --         # a leaf directory and just consider it complete
     --         __gitcomp_direct_append "$cur "
     --     fi
     +-	local _tmp_dir _tmp_completions
      +	local _tmp_dir _tmp_completions _found=0
     -+
     -+	# Get the directory of the current token; this differs from dirname
     -+	# in that it keeps up to the final trailing slash.  If no slash found
     -+	# that's fine too.
     -+	[[ "$cur" =~ .*/ ]]
     -+	_tmp_dir=$BASH_REMATCH
     -+
     + 
     + 	# Get the directory of the current token; this differs from dirname
     + 	# in that it keeps up to the final trailing slash.  If no slash found
     +@@ contrib/completion/git-completion.bash: __gitcomp_directories ()
     + 	[[ "$cur" =~ .*/ ]]
     + 	_tmp_dir=$BASH_REMATCH
     + 
     +-	# Find possible directory completions, adding trailing '/' characters
     +-	_tmp_completions="$(git ls-tree -d --name-only HEAD $_tmp_dir |
     +-		sed -e s%$%/%)"
     +-
     +-	if [[ -n "$_tmp_completions" ]]; then
     +-		# There were some directory completions, so find ones that
     +-		# start with "$cur", the current token, and put those in COMPREPLY
     +-		local i=0 c IFS=$' \t\n'
     +-		for c in $_tmp_completions; do
      +	# Find possible directory completions, adding trailing '/' characters,
      +	# de-quoting, and handling unusual characters.
      +	while IFS= read -r -d $'\0' c ; do
      +		# If there are directory completions, find ones that start
      +		# with "$cur", the current token, and put those in COMPREPLY
     -+		if [[ $c == "$cur"* ]]; then
     + 		if [[ $c == "$cur"* ]]; then
     +-			COMPREPLY+=("$c")
      +			COMPREPLY+=("$c/")
      +			_found=1
     -+		fi
     + 		fi
     +-		done
     +-	elif [[ "$cur" =~ /$ ]]; then
      +	done < <(git ls-tree -z -d --name-only HEAD $_tmp_dir)
      +
      +	if [[ $_found == 0 ]] && [[ "$cur" =~ /$ ]]; then
     -+		# No possible further completions any deeper, so assume we're at
     -+		# a leaf directory and just consider it complete
     -+		__gitcomp_direct_append "$cur "
     -+	fi
     - }
     - 
     - _git_sparse_checkout ()
     + 		# No possible further completions any deeper, so assume we're at
     + 		# a leaf directory and just consider it complete
     + 		__gitcomp_direct_append "$cur "
      
       ## t/t9902-completion.sh ##
      @@ t/t9902-completion.sh: test_expect_success 'cone mode sparse-checkout completes directory names' '

-- 
gitgitgadget
