Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E489288514
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 09:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758014705; cv=none; b=P8TbMRVpWy58JxQc7275KKIpOHwjS6cAjYDajfoZxm/aZLF69Rd41jFdVytnV/V4+yEkRV6FdmMv91a0bSKo2WDnTJaugCMf5gz/8P5kdlSfG4uUUqcjhhkLos/3sTe+qhqOxCRU1iRapCNNpYw4dTFwYQwyDSQjiFdpV7NBmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758014705; c=relaxed/simple;
	bh=aE/6bZv++dIh2AQmZcdfe5vmRHQFYPWpSwD9Eptb6aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4ch7lRtss+jrdLRJuvNek+NvkNjaJU3y34SWriNcT7kp/PBqFaW6D61JssPgjgLXrJopj/hKpt8z3AqeXdUPNWJZpeM0ExCv05iaDm8h/O/3YDlTXzSe14/povb0R7xSCB0zf8akSF5/rMH0cWf+JiI5Ws+N3+oqwvy39ntel0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SI9+dWLx; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI9+dWLx"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b9c35bc0aso45911915e9.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 02:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758014702; x=1758619502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XAhWZhcgl7wtzFnD6+qOxmOh/79cOEoNzSGqKo7JXJk=;
        b=SI9+dWLxA5i0eRTRxOixDPkcdE3nag6SNpXHV/KjH/ohBjJbqZHVVdo7O0OKWN18yC
         N+UCmeSTvOm9rdA1KXLSVEAOuPNj4Bub757kdFfGpdPJAfKm27m0hJ/VKrIPSVr3zicl
         vMqL13690QUQdK+nDjnTcf2pJzh2dFrEiWz4X7A5XkSIUnsHNjYUcXbS0vOx+rSKsXAg
         FE5T6VX5Yig0Zkd2sAitYQdUUtGC7YEd9C1YQFPkzU4QIUbnCTvnzwvAcKjSk+499gI/
         bNQLydRLp5hhNLaTpQGzhbd5afhBDmxnekYFszWoDLsIXpd7r6e3ApXh3QANyYWk0ko6
         SPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758014702; x=1758619502;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XAhWZhcgl7wtzFnD6+qOxmOh/79cOEoNzSGqKo7JXJk=;
        b=nioabDiOeFlmfip/Gcbb1+5tZoqlMpdigFh1acJCkH7c0FvgNbQMaOVpYPci853mub
         KIzBYwQWJCD5qkbhP+gQheF8VFDgGZIPscuHmaBGBH38xgEgFP8VwbHjRjDh/b5KgE5H
         QtpnONghr4M4SrjyRJNv27nQu/p5zH7KK1RTN732ZgxkrieCli6CioAXteYQdu09fu/V
         tM08kRMlpqCYjWFtiTXCHaUucjl7XLiSjAgkKByo0fm0qzoLabjhKsQgA0nTx+U7l6Wk
         hGYvbRcdbhx3GEmx0A/T+8OOFhw8rAxpFtBLOR+dwxB2jBtMyL1PRFmpU3WODpHp0IaL
         WAcw==
X-Forwarded-Encrypted: i=1; AJvYcCV7n1UmRBqW/vZW3yLjI7jNa5wObCfroKJNf1vk1NbVEpnm2ej1ydjByk8pe76ZlKGpQl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyexkeTf0Pn6bOZcoZ0Z2hysFfqAMQX+uymlh4HHI3LSozuc8xe
	y8ZKv7qMh0FADHIOIqE+xfcc1NP6hvtDuUzet2ItxcZXMafUjYRQtdVq
X-Gm-Gg: ASbGncvJTP242IrOYdIr8oQg3hc5cwTmqoEn1OCR7Vf6CLTr75y2VPexV/8JYoIvz2m
	YHORocjGuuDIe45ozplM7QNJPGH7XZFpmjTCo4+409m9ymnkXOdrN3Ns3A4hHVatWvOE224/5qT
	6wyvsSdOB/Y5cjG5+tk9yKgNMROb07Y1s38ala/lx3BcxsId/+rENLCw3rrZ78ErUjHZT2zIacF
	PO6yed1rlShrmmLVV1zzVax6T213sIx8uOu7F+RIWIpESDxnCpF67x6MKgVpPSsx3rolvumRiHt
	ck4+weaWL6nBdhZtWYmYMqoZ4GT2WaBv0KAM4TsbpFoj8w0qVDLjbeiooVmNX7FYS87nCWG0+VY
	JsMvCcBhjTsjEQ6d/Br2P0WPmi3Ho31ErWaVI/2VLSWETBGqxoeixVTXBeO9Ehm3FnfDsHPavj5
	8=
X-Google-Smtp-Source: AGHT+IG0NIxaqqjT8wUlT2t7bz/H/h4k6VLqUQA22Vyp1vO2ZxefJ6FwwuPx+qYCsoMMIf6kGz5Q0w==
X-Received: by 2002:a05:600c:604b:b0:45b:73be:c707 with SMTP id 5b1f17b1804b1-45f211fad57mr88138845e9.22.1758014701269;
        Tue, 16 Sep 2025 02:25:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372aea2sm220747005e9.7.2025.09.16.02.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 02:25:00 -0700 (PDT)
Message-ID: <4736597d-1144-43ce-8c09-e78e4563765b@gmail.com>
Date: Tue, 16 Sep 2025 10:24:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] Teach git-stash to use --index from config
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <20250510183358.36806-1-ben.knoble+github@gmail.com>
 <cover.1757982870.git.ben.knoble+github@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <cover.1757982870.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ben

On 16/09/2025 01:37, D. Ben Knoble wrote:
> 
> PS I've left some new t3903 tests as copy-pasta for now to get feedback
> on the rest of the series; there are bits of that file that could use an
> update to the modern style (e.g., not using "test 1 = $(cat file)").
> Since some new tests are substantially similar to old tests that use
> this style, such cleanup is /probably/ warranted but will delay eyeballs
> on the core of this series.

In situations like this even if we don't convert the old tests, I think 
it is worth using a modern style for the new ones. Some people argue 
that the style within a file should be consistent but in practice that 
means if someone decides to clean them up in the future they have even 
more work to do and in the meantime we have a harder time debugging test 
failures.

The cleanups in patches 1 and 2 look very welcome. I've left a comment 
about the tests on patch 4.

Thanks

Phillip
> Published-as: https://github.com/benknoble/git/tree/stash-apply-index
> v1: https://lore.kernel.org/git/20250510183358.36806-1-ben.knoble+github@gmail.com/
> 
> D. Ben Knoble (4):
>    t3903: reduce dependencies on previous tests
>    t3905: remove unneeded blank line
>    stash: refactor private config globals
>    stash: honor stash.index in apply, pop modes
> 
>   Documentation/config/stash.adoc    |   5 +
>   builtin/stash.c                    |  17 ++--
>   t/t3903-stash.sh                   | 158 +++++++++++++++++++++++++++++
>   t/t3904-stash-patch.sh             |  11 ++
>   t/t3905-stash-include-untracked.sh |  49 ++++++++-
>   5 files changed, 232 insertions(+), 8 deletions(-)
> 
> Diff-intervalle contre v1 :
>   1:  1328eb8eac =  1:  1328eb8eac t3903: reduce dependencies on previous tests
>   2:  8ac06ad62d =  2:  8ac06ad62d t3905: remove unneeded blank line
>   3:  c068f1dc0b <  -:  ---------- BreakingChanges: announce stash {apply,pop} will imply --index
>   4:  8caff91c0e <  -:  ---------- stash: restore the index by default when breaking changes are enabled
>   5:  387427bb8c <  -:  ---------- t0450: mark stash documentation as a known discrepancy
>   9:  c72a1fe6ea !  3:  bf0a561ce3 t3906: adjust stash submodule tests to account for breaking changes
>      @@ Metadata
>       Author: D. Ben Knoble <ben.knoble+github@gmail.com>
>       
>        ## Commit message ##
>      -    t3906: adjust stash submodule tests to account for breaking changes
>      +    stash: refactor private config globals
>       
>      -    I cannot explain _why_ this occurs, but it seems that automatically
>      -    unstashing the index from previous commits resolves some known failures
>      -    in t3906 (which are captured by t/lib-submodule-updates.sh).
>      +    A subsequent commit will access a new config variable in the stash
>      +    subcommand implementations, which requires the variables to be declared
>      +    before the relevant functions. Prep with a pure refactoring change to
>      +    consolidate config-related globals with the rest of the globals.
>       
>      -    In particular:
>      -    - 'replace tracked file with submodule creates empty directory' succeeds
>      -      with breaking changes;
>      -    - all KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR tests
>      -      succeed with breaking changes;
>      -    - all KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES suceed with
>      -      breaking changes.
>      +    Best-viewed-with: --color-moved
>       
>      - ## t/lib-submodule-update.sh ##
>      -@@ t/lib-submodule-update.sh: test_submodule_switch_common ()
>      - 	'
>      - 	# Replacing a tracked file with a submodule produces an empty
>      - 	# directory ...
>      --	test_expect_$RESULT "$command: replace tracked file with submodule creates empty directory" '
>      -+	test_expect_$RESULT !WITH_BREAKING_CHANGES "$command: replace tracked file with submodule creates empty directory" '
>      -+		prolog &&
>      -+		reset_work_tree_to replace_sub1_with_file &&
>      -+		(
>      -+			cd submodule_update &&
>      -+			git branch -t replace_file_with_sub1 origin/replace_file_with_sub1 &&
>      -+			$command replace_file_with_sub1 &&
>      -+			test_superproject_content origin/replace_file_with_sub1 &&
>      -+			test_dir_is_empty sub1 &&
>      -+			git submodule update --init --recursive &&
>      -+			test_submodule_content sub1 origin/replace_file_with_sub1
>      -+		)
>      -+	'
>      -+	# (unless we automatically unstash the index!)
>      -+	test_expect_success WITH_BREAKING_CHANGES "$command: replace tracked file with submodule creates empty directory" '
>      - 		prolog &&
>      - 		reset_work_tree_to replace_sub1_with_file &&
>      - 		(
>      -@@ t/lib-submodule-update.sh: test_submodule_switch_common ()
>      - 	'
>      - 	# ... as does removing a directory with tracked files with a
>      - 	# submodule.
>      --	if test "$KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR" = 1
>      -+	if ! test_have_prereq WITH_BREAKING_CHANGES &&
>      -+		test "$KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR" = 1
>      - 	then
>      - 		# Non fast-forward merges fail with "Directory sub1 doesn't
>      - 		# exist. sub1" because the empty submodule directory is not
>      -@@ t/lib-submodule-update.sh: test_submodule_switch_common ()
>      - 	'
>      + ## builtin/stash.c ##
>      +@@ builtin/stash.c: static const char * const git_stash_save_usage[] = {
>      + static const char ref_stash[] = "refs/stash";
>      + static struct strbuf stash_index_path = STRBUF_INIT;
>        
>      - 	######################## Disappearing submodule #######################
>      --	# Removing a submodule doesn't remove its work tree ...
>      --	if test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
>      -+	# Removing a submodule doesn't remove its work tree (unless stash applies the index!) ...
>      -+	if ! test_have_prereq WITH_BREAKING_CHANGES &&
>      -+		test "$KNOWN_FAILURE_STASH_DOES_IGNORE_SUBMODULE_CHANGES" = 1
>      - 	then
>      - 		RESULT="failure"
>      - 	else
>      ++static int show_stat = 1;
>      ++static int show_patch;
>      ++static int show_include_untracked;
>      ++
>      + /*
>      +  * w_commit is set to the commit containing the working tree
>      +  * b_commit is set to the base commit
>      +@@ builtin/stash.c: static int list_stash(int argc, const char **argv, const char *prefix,
>      + 	return run_command(&cp);
>      + }
>      +
>      +-static int show_stat = 1;
>      +-static int show_patch;
>      +-static int show_include_untracked;
>      +-
>      + static int git_stash_config(const char *var, const char *value,
>      + 			    const struct config_context *ctx, void *cb)
>      + {
>   6:  0a12983c00 !  4:  585e124467 t3903: adjust stash test to account for --[no-]index with breaking changes
>      @@ Metadata
>       Author: D. Ben Knoble <ben.knoble+github@gmail.com>
>       
>        ## Commit message ##
>      -    t3903: adjust stash test to account for --[no-]index with breaking changes
>      +    stash: honor stash.index in apply, pop modes
>       
>      -    A few tests check the results of the index after applying a stash; with
>      -    breaking changes from previous commits that automatically restore the
>      -    stashed index, the expected values are wrong.
>      +    With stash.index=true, git-stash(1) command now tries to reinstate the
>      +    index by default in the "apply" and "pop" modes. Not doing so creates a
>      +    common trap [1], [2]: "git stash apply" is not the reverse of "git stash
>      +    push" because carefully staged indices are lost and have to be manually
>      +    recreated. OTOH, this mode is not always desirable and may create more
>      +    conflicts when applying stashes. As usual, "--no-index" will disable
>      +    this behavior if you set "stash.index".
>       
>      -    A few of the relevant tests check the restoration of <pathspec>s; with
>      -    the aforementioned breaking changes, things get more interesting. In
>      -    particular, if we "git stash push -- foo" but have "bar" in the index,
>      -    then when applying the stash we get a conflict: "bar" was not removed
>      -    from the index by the stash, but it was included in the recorded index
>      -    in the stash. In those cases, apply the stash with "--no-index" (which
>      -    would be the required user behavior).
>      +    [1]: https://lore.kernel.org/git/CAPx1GvcxyDDQmCssMjEnt6JoV6qPc5ZUpgPLX3mpUC_4PNYA1w@mail.gmail.com/
>      +    [2]: https://lore.kernel.org/git/c5a811ac-8cd3-c389-ac6d-29020a648c87@gmail.com/
>       
>      -    Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
>      + ## Documentation/config/stash.adoc ##
>      +@@
>      ++stash.index::
>      ++	If this is set to true, `git stash apply` and `git stash pop` will
>      ++	behave as if `--index` was supplied. Defaults to false. See the
>      ++	descriptions in linkgit:git-stash[1].
>      ++
>      + stash.showIncludeUntracked::
>      + 	If this is set to true, the `git stash show` command will show
>      + 	the untracked files of a stash entry.  Defaults to false. See
>       
>      -
>      - ## Notes ##
>      -    It looks like the pathspec filtering is not applied to the stashed
>      -    index; should it be?
>      + ## builtin/stash.c ##
>      +@@ builtin/stash.c: static struct strbuf stash_index_path = STRBUF_INIT;
>      + static int show_stat = 1;
>      + static int show_patch;
>      + static int show_include_untracked;
>      ++static int use_index;
>      +
>      + /*
>      +  * w_commit is set to the commit containing the working tree
>      +@@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char *prefix,
>      + {
>      + 	int ret = -1;
>      + 	int quiet = 0;
>      +-	int index = 0;
>      ++	int index = use_index;
>      + 	struct stash_info info = STASH_INFO_INIT;
>      + 	struct option options[] = {
>      + 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
>      +@@ builtin/stash.c: static int pop_stash(int argc, const char **argv, const char *prefix,
>      + 		     struct repository *repo UNUSED)
>      + {
>      + 	int ret = -1;
>      +-	int index = 0;
>      ++	int index = use_index;
>      + 	int quiet = 0;
>      + 	struct stash_info info = STASH_INFO_INIT;
>      + 	struct option options[] = {
>      +@@ builtin/stash.c: static int git_stash_config(const char *var, const char *value,
>      + 		show_include_untracked = git_config_bool(var, value);
>      + 		return 0;
>      + 	}
>      ++	if (!strcmp(var, "stash.index")) {
>      ++		use_index = git_config_bool(var, value);
>      ++		return 0;
>      ++	}
>      + 	return git_diff_basic_config(var, value, ctx, cb);
>      + }
>      +
>       
>        ## t/t3903-stash.sh ##
>      -@@ t/t3903-stash.sh: setup_stash()
>      - 	test_cmp expect file
>      - '
>      -
>      --test_expect_success 'apply stashed changes' '
>      -+test_expect_success !WITH_BREAKING_CHANGES 'apply stashed changes' '
>      - 	git reset --hard &&
>      - 	echo 5 >other-file &&
>      - 	git add other-file &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test 1 = $(git show HEAD:file)
>        '
>        
>      -+test_expect_success WITH_BREAKING_CHANGES 'apply stashed changes' '
>      -+	git reset --hard &&
>      ++test_expect_success 'apply stashed changes with stash.index' '
>      ++	test_config stash.index true &&
>      ++	git reset --hard HEAD^ &&
>       +	echo 5 >other-file &&
>       +	git add other-file &&
>       +	test_tick &&
>      @@ t/t3903-stash.sh: setup_stash()
>        test_expect_success 'apply stashed changes (including index)' '
>        	git reset --hard HEAD^ &&
>        	echo 6 >other-file &&
>      -@@ t/t3903-stash.sh: setup_stash()
>      - 	test_must_fail git stash drop --foo
>      - '
>      -
>      --test_expect_success 'drop top stash' '
>      -+test_expect_success !WITH_BREAKING_CHANGES 'drop top stash' '
>      - 	git reset --hard &&
>      - 	git stash list >expected &&
>      - 	echo 7 >file &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test 1 = $(git show HEAD:file)
>        '
>        
>      --test_expect_success 'drop middle stash' '
>      -+test_expect_success WITH_BREAKING_CHANGES 'drop top stash' '
>      ++test_expect_success 'drop top stash with stash.index' '
>      ++	test_config stash.index true &&
>       +	git reset --hard &&
>       +	git stash list >expected &&
>       +	echo 7 >file &&
>      @@ t/t3903-stash.sh: setup_stash()
>       +	test 1 = $(git show HEAD:file)
>       +'
>       +
>      -+test_expect_success !WITH_BREAKING_CHANGES 'drop middle stash' '
>      + test_expect_success 'drop middle stash' '
>        	git reset --hard &&
>        	echo 8 >file &&
>      - 	git stash &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test 1 = $(git show HEAD:file)
>        '
>        
>      --test_expect_success 'drop middle stash by index' '
>      -+test_expect_success WITH_BREAKING_CHANGES 'drop middle stash' '
>      ++test_expect_success 'drop middle stash with stash.index' '
>      ++	test_config stash.index true &&
>       +	git reset --hard &&
>       +	echo 8 >file &&
>       +	git stash &&
>      @@ t/t3903-stash.sh: setup_stash()
>       +	test 1 = $(git show HEAD:file)
>       +'
>       +
>      -+test_expect_success !WITH_BREAKING_CHANGES 'drop middle stash by index' '
>      + test_expect_success 'drop middle stash by index' '
>        	git reset --hard &&
>        	echo 8 >file &&
>      - 	git stash &&
>      -@@ t/t3903-stash.sh: setup_stash()
>      - 	test_cmp expect actual
>      - '
>      -
>      --test_expect_success 'stash pop' '
>      -+test_expect_success !WITH_BREAKING_CHANGES 'stash pop' '
>      - 	git reset --hard &&
>      - 	git stash pop &&
>      - 	test 3 = $(cat file) &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test 0 = $(git stash list | wc -l)
>        '
>        
>      -+test_expect_success WITH_BREAKING_CHANGES 'stash pop' '
>      ++test_expect_success 'stash pop with stash.index' '
>      ++	test_config stash.index true &&
>       +	git reset --hard &&
>      ++	setup_stash &&
>       +	git stash pop &&
>       +	test 3 = $(cat file) &&
>       +	test 2 = $(git show :file) &&
>      @@ t/t3903-stash.sh: setup_stash()
>        	test_must_be_empty output.out
>        '
>        
>      --test_expect_success 'pop -q works and is quiet' '
>      -+test_expect_success !WITH_BREAKING_CHANGES 'pop -q works and is quiet' '
>      - 	git stash pop -q >output.out 2>&1 &&
>      - 	echo bar >expect &&
>      - 	git show :file >actual &&
>      -@@ t/t3903-stash.sh: setup_stash()
>      - 	test_must_be_empty output.out
>      - '
>      -
>      -+test_expect_success WITH_BREAKING_CHANGES 'pop -q works and is quiet' '
>      ++test_expect_success 'pop -q works and is quiet with stash.index' '
>      ++	# Added file, deleted file, modified file all staged for commit
>      ++	echo foo >new-file &&
>      ++	echo test >file &&
>      ++	git add new-file file &&
>      ++	git rm other-file &&
>      ++	git stash &&
>      ++
>      ++	test_config stash.index true &&
>       +	git stash pop -q >output.out 2>&1 &&
>       +	echo test >expect &&
>       +	git show :file >actual &&
>      @@ t/t3903-stash.sh: setup_stash()
>        test_expect_success 'pop -q --index works and is quiet' '
>        	echo foo >file &&
>        	git add file &&
>      -@@ t/t3903-stash.sh: setup_stash()
>      - 	test_cmp expect actual
>      - '
>      -
>      --test_expect_success 'stash -- <pathspec> stashes and restores the file' '
>      -+test_expect_success !WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes and restores the file' '
>      - 	>foo &&
>      - 	>bar &&
>      - 	git add foo bar &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test_path_is_file bar
>        '
>        
>      --test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
>      -+test_expect_success WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes and restores the file' '
>      ++test_expect_success 'stash -- <pathspec> stashes and restores the file with stash.index' '
>      ++	test_config stash.index true &&
>       +	>foo &&
>       +	>bar &&
>       +	git add foo bar &&
>      @@ t/t3903-stash.sh: setup_stash()
>       +	test_path_is_file bar
>       +'
>       +
>      -+test_expect_success !WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes in subdirectory' '
>      + test_expect_success 'stash -- <pathspec> stashes in subdirectory' '
>        	mkdir sub &&
>        	>foo &&
>      - 	>bar &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test_path_is_file bar
>        '
>        
>      --test_expect_success 'stash with multiple pathspec arguments' '
>      -+test_expect_success WITH_BREAKING_CHANGES 'stash -- <pathspec> stashes in subdirectory' '
>      ++test_expect_success 'stash -- <pathspec> stashes in subdirectory with stash.index' '
>      ++	test_config stash.index true &&
>      ++	rm -r sub &&
>       +	mkdir sub &&
>       +	>foo &&
>       +	>bar &&
>      @@ t/t3903-stash.sh: setup_stash()
>       +	test_path_is_file bar
>       +'
>       +
>      -+test_expect_success !WITH_BREAKING_CHANGES 'stash with multiple pathspec arguments' '
>      + test_expect_success 'stash with multiple pathspec arguments' '
>        	>foo &&
>        	>bar &&
>      - 	>extra &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test_path_is_file extra
>        '
>        
>      --test_expect_success 'stash with file including $IFS character' '
>      -+test_expect_success WITH_BREAKING_CHANGES 'stash with multiple pathspec arguments' '
>      ++test_expect_success 'stash with multiple pathspec arguments with stash.index' '
>      ++	test_config stash.index true &&
>       +	>foo &&
>       +	>bar &&
>       +	>extra &&
>      @@ t/t3903-stash.sh: setup_stash()
>       +	test_path_is_file extra
>       +'
>       +
>      -+test_expect_success !WITH_BREAKING_CHANGES 'stash with file including $IFS character' '
>      + test_expect_success 'stash with file including $IFS character' '
>        	>"foo bar" &&
>        	>foo &&
>      - 	>bar &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test_path_is_file bar
>        '
>        
>      -+test_expect_success WITH_BREAKING_CHANGES 'stash with file including $IFS character' '
>      ++test_expect_success 'stash with file including $IFS character with stash.index' '
>      ++	test_config stash.index true &&
>       +	>"foo bar" &&
>       +	>foo &&
>       +	>bar &&
>      @@ t/t3903-stash.sh: setup_stash()
>        test_expect_success 'stash with pathspec matching multiple paths' '
>        	echo original >file &&
>        	echo original >other-file &&
>      -@@ t/t3903-stash.sh: setup_stash()
>      - 	test_path_is_file untracked
>      - '
>      -
>      --test_expect_success 'stash without verb with pathspec' '
>      -+test_expect_success !WITH_BREAKING_CHANGES 'stash without verb with pathspec' '
>      - 	>"foo bar" &&
>      - 	>foo &&
>      - 	>bar &&
>       @@ t/t3903-stash.sh: setup_stash()
>        	test_path_is_file bar
>        '
>        
>      -+test_expect_success WITH_BREAKING_CHANGES 'stash without verb with pathspec' '
>      ++test_expect_success 'stash without verb with pathspec with stash.index' '
>      ++	test_config stash.index true &&
>       +	>"foo bar" &&
>       +	>foo &&
>       +	>bar &&
>      @@ t/t3903-stash.sh: setup_stash()
>        test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
>        	git reset &&
>        	>foo &&
>      +
>      + ## t/t3904-stash-patch.sh ##
>      +@@
>      + 	verify_state dir/foo work head
>      + '
>      +
>      ++test_expect_success 'git stash -p with stash.index' '
>      ++	test_config stash.index true &&
>      ++	set_state HEAD HEADfile_work HEADfile_index &&
>      ++	set_state dir/foo work index &&
>      ++	test_write_lines y n y | git stash save -p &&
>      ++	git reset --hard &&
>      ++	git stash apply &&
>      ++	verify_state HEAD HEADfile_work HEADfile_index &&
>      ++	verify_state dir/foo head index
>      ++'
>      ++
>      + test_expect_success 'git stash -p --no-keep-index' '
>      + 	set_state HEAD HEADfile_work HEADfile_index &&
>      + 	set_state bar bar_work bar_index &&
>      +
>      + ## t/t3905-stash-include-untracked.sh ##
>      +@@
>      +
>      + . ./test-lib.sh
>      +
>      +-test_expect_success 'stash save --include-untracked some dirty working directory' '
>      ++setup() {
>      + 	echo 1 >file &&
>      + 	git add file &&
>      + 	test_tick &&
>      +@@
>      + 	git stash --include-untracked &&
>      + 	git diff-files --quiet &&
>      + 	git diff-index --cached --quiet HEAD
>      ++}
>      ++
>      ++test_expect_success 'stash save --include-untracked some dirty working directory' '
>      ++	setup
>      + '
>      +
>      + test_expect_success 'stash save --include-untracked cleaned the untracked files' '
>      +@@
>      + 	test_cmp untracked_expect untracked/untracked
>      + '
>      +
>      ++test_expect_success 'stash pop after save --include-untracked leaves files untracked again with stash.index' '
>      ++	git init repo &&
>      ++	test_when_finished rm -r repo &&
>      ++	(
>      ++		cd repo &&
>      ++		git config stash.index true &&
>      ++		setup &&
>      ++		cat >expect <<-EOF &&
>      ++		MM file
>      ++		?? HEAD
>      ++		?? actual
>      ++		?? expect
>      ++		?? file2
>      ++		?? untracked/
>      ++		EOF
>      ++
>      ++		git stash pop &&
>      ++		git status --porcelain >actual &&
>      ++		test_cmp expect actual &&
>      ++		echo 1 >expect_file2 &&
>      ++		test_cmp expect_file2 file2 &&
>      ++		echo untracked >untracked_expect &&
>      ++		test_cmp untracked_expect untracked/untracked
>      ++	)
>      ++'
>      ++
>      + test_expect_success 'clean up untracked/ directory to prepare for next tests' '
>      + 	git clean --force --quiet -d
>      + '
>      +@@
>      + 	test_path_is_file bar
>      + '
>      +
>      ++test_expect_success 'stash push with $IFS character with stash.index' '
>      ++	test_config stash.index true &&
>      ++	>"foo bar" &&
>      ++	>foo &&
>      ++	>bar &&
>      ++	git add foo* &&
>      ++	git stash push --include-untracked -- "foo b*" &&
>      ++	test_path_is_missing "foo bar" &&
>      ++	test_path_is_file foo &&
>      ++	test_path_is_file bar &&
>      ++	git stash pop --no-index &&
>      ++	test_path_is_file "foo bar" &&
>      ++	test_path_is_file foo &&
>      ++	test_path_is_file bar
>      ++'
>      ++
>      + test_expect_success 'stash previously ignored file' '
>      + 	cat >.gitignore <<-EOF &&
>      + 	ignored
>   7:  4b92d47e16 <  -:  ---------- t3904: adjust stash -p test to account for index states with breaking changes
>   8:  af14dee1be <  -:  ---------- t3905: adjust stash -u tests for breaking changes
> 
> base-commit: 1ee85f0e215f22b0878d0ad4b2445d12bbb63887

