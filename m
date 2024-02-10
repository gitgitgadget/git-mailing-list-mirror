Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F75D46F
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707589949; cv=none; b=XZh/JcJlsaYPYCBJOqGQ3yL3nAKTF3OOyK3jEzSwOpXYw2aRkL6wrm//5fz+RhJR7qiNKTOr5SAy6b+LlPFf08J7U2PZTU+uZx8PB7b3NI69zJS4jCjt10FxGJeuZ4EnvfTfSs/6QgRxNeXasGsyuElfmdGtgfiHm4n3zR/4Wic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707589949; c=relaxed/simple;
	bh=SyiUQnpec0f0rcbjGgcvob+64dOKMiCAASzSDAWRKHU=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hzhU1Ue/Q2DD+7rbZ9sE0YHYQpzuSDIUCpWQLWS2oHDrbKNQoyeBNg0+sIV+Ly8BAsEp2T+KAAGFUE1nKumk+OOQlOLFLruW0h6OxYihxiDQSgHwdYU5xGHNebXwr8oi8N0BDId9jKO1NnGtR4lDQ4maWgExzs/pr9AqqpNKjDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0deQeQK; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0deQeQK"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51186925925so248840e87.0
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707589945; x=1708194745; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWIk3/QOmv1eGvS6JNHo+FKfyCK6YRXNAwfwKh+4LjE=;
        b=I0deQeQK8Z8RGLSSVoQ0MqS4zGDhsTqTUKDoOnD6SiRrsOwlxXvOWMHdm7isHzRq1t
         U8Pckfw8J1rPZiz0QfpknLnnUyyzRcs23lz7YzQugzpxiyHNmkSuPlmzIh5fttn/wR0s
         qvRk2Simqyp7kuxcGRbfrPquMpFXeVVAUsiXSuK41G6hnfkLLGiCBGDa+Dv8rf91xYkV
         Vt0+dPSy9IZlq6y3EW0zG64/f1hGp2ethrI8Y5FvOjGm3995WJ2V0JKE/86fE7pfQxxL
         WwJTcudRaD7W6FVL0Q4Qi2R28gDU+qW6oM+Jd8zonvFDdvLuldN8dVd/SQgsgOlmobwX
         lIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707589945; x=1708194745;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FWIk3/QOmv1eGvS6JNHo+FKfyCK6YRXNAwfwKh+4LjE=;
        b=v/vbS70W9wnH9dxIkJM9t3fZR2Ca2Yoam38OVc7cpdGRjL7V8IcidVaQTklPngyUjD
         1AG7rddG5AD06/uCu/9Uf1UiCcG3+IKDJYJVUkblBELetW6ceB1ZYcD8p+3QfHKKSU86
         0lkzUK+LaeJ72Leg/KlvSGx0WBKB2mJ6rvLnuq189YkTNlBhWdbvOlk38YJSpdRkYKlM
         1uVcUdTdyauFbgrGgkh1qQL7fpqvq4byKl8C6Cd+OMd9vP3a1nCau1ZJt/Rrytjt1A5w
         Lug5D+xWuK344oypDKEeEOAMJ9Qe7TJeei1sR595uVC6+77hgd5+4+voRWQYuy+PBjC6
         6ADA==
X-Gm-Message-State: AOJu0Yyh4xnaaMId1AFvnzox4H8+jd0qGjMSWAZUZuCMhs4DTNwS4qv0
	pUN8kpxtdvm6VWL/j8na5to8o49/RNnfS6OO89RLgh20cK1Q3WCgcVOZ8oVK
X-Google-Smtp-Source: AGHT+IFJuJTCdiAZHjUHXGIoO5yHHoMzbWJ9+dkzrWbKapDJF1eT92CWzm/ROmIuPVpoCZpJeQYfZw==
X-Received: by 2002:a05:6512:522:b0:511:6798:64a3 with SMTP id o2-20020a056512052200b00511679864a3mr1550442lfc.34.1707589944663;
        Sat, 10 Feb 2024 10:32:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWu5DHVVMK+3CLwsTmjBxiOXy9Df1yXTJejgnsStNycvuqsBPVjfu2xKKJKHRHm+oB0QCQWgKn/tlfn3DvWPHvyLa3EnjmCnmR6vilG0g==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 25-20020a05600c021900b0040fbba734f3sm3959276wmi.34.2024.02.10.10.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 10:32:24 -0800 (PST)
Message-ID: <pull.1660.v3.git.git.1707589943.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
References: <pull.1660.v2.git.git.1706534881.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 10 Feb 2024 18:32:19 +0000
Subject: [PATCH v3 0/4] completion: remove hardcoded config variable names
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

Changes since v2:

 * Moved the addition of the tests to 2/4, and tweaked 3/4 and 4/4 so they
   simply adjust the test names
 * Added a test for user-defined submodule names, as suggested by Patrick
 * Added more details in the commit message of 3/4 around the use of global
   variables as caches
 * Slightly improved commit message wording and fixed typos
 * Added 'local' where suggested
 * Dropped 4/5 which modified 'git help', since it's not needed (thanks
   Patrick!)

Changes since v1:

 * Corrected my email in PATCH 2/5 (sorry for the noise)

v1: This series removes hardcoded config variable names in the
__git_complete_config_variable_name function, partly by adding a new mode to
'git help'. It also adds completion for 'submodule.*' config variables,
which were previously missing.

I think it makes sense to do that in the same series since it's closely
related, and splitting it would result in textual conflicts between both
series if one does not build on top of the other, but I'm open to other
suggestions.

Thanks,

Philippe.

Philippe Blain (4):
  completion: add space after config variable names also in Bash 3
  completion: complete 'submodule.*' config variables
  completion: add and use
    __git_compute_first_level_config_vars_for_section
  completion: add and use
    __git_compute_second_level_config_vars_for_section

 contrib/completion/git-completion.bash | 90 +++++++++++++-------------
 t/t9902-completion.sh                  | 29 +++++++++
 2 files changed, 75 insertions(+), 44 deletions(-)


base-commit: b50a608ba20348cb3dfc16a696816d51780e3f0f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1660%2Fphil-blain%2Fcompletion-submodule-config-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1660/phil-blain/completion-submodule-config-v3
Pull-Request: https://github.com/git/git/pull/1660

Range-diff vs v2:

 1:  837d92a6c27 = 1:  837d92a6c27 completion: add space after config variable names also in Bash 3
 2:  426374ff9b3 ! 2:  6b75582ee35 completion: complete 'submodule.*' config variables
     @@ Commit message
          Add the appropriate branches to the case statement, making use of the
          in-tree '.gitmodules' to list relevant submodules.
      
     +    Add corresponding tests in t9902-completion.sh, making sure we complete
     +    both first level submodule config variables as well as second level
     +    variables involving submodule names.
     +
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: __git_complete_config_variable_name ()
       	url.*.*)
       		local pfx="${cur_%.*}."
       		cur_="${cur_##*.}"
     +
     + ## t/t9902-completion.sh ##
     +@@ t/t9902-completion.sh: test_expect_success 'git config - variable name include' '
     + 	EOF
     + '
     + 
     ++test_expect_success 'setup for git config submodule tests' '
     ++	test_create_repo sub &&
     ++	test_commit -C sub initial &&
     ++	git submodule add ./sub
     ++'
     ++
     ++test_expect_success 'git config - variable name - submodule' '
     ++	test_completion "git config submodule." <<-\EOF
     ++	submodule.active Z
     ++	submodule.alternateErrorStrategy Z
     ++	submodule.alternateLocation Z
     ++	submodule.fetchJobs Z
     ++	submodule.propagateBranches Z
     ++	submodule.recurse Z
     ++	submodule.sub.Z
     ++	EOF
     ++'
     ++
     ++test_expect_success 'git config - variable name - submodule names' '
     ++	test_completion "git config submodule.sub." <<-\EOF
     ++	submodule.sub.url Z
     ++	submodule.sub.update Z
     ++	submodule.sub.branch Z
     ++	submodule.sub.fetchRecurseSubmodules Z
     ++	submodule.sub.ignore Z
     ++	submodule.sub.active Z
     ++	EOF
     ++'
     ++
     + test_expect_success 'git config - value' '
     + 	test_completion "git config color.pager " <<-\EOF
     + 	false Z
 3:  838aabf2858 ! 3:  fb210325394 completion: add and use __git_compute_first_level_config_vars_for_section
     @@ Commit message
      
          The function __git_complete_config_variable_name in the Bash completion
          script hardcodes several config variable names. These variables are
     -    those in config section where user-defined names can appear, such as
     +    those in config sections where user-defined names can appear, such as
          "branch.<name>". These sections are treated first by the case statement,
          and the two last "catch all" cases are used for other sections, making
          use of the __git_compute_config_vars and __git_compute_config_sections
     @@ Commit message
          like 'branch.autoSetupMerge, 'remote.pushDefault', etc.  Use this
          function and the variables it defines in the 'branch.*', 'remote.*' and
          'submodule.*' switches of the case statement instead of hardcoding the
     -    corresponding config variables.  Note that we use indirect expansion
     -    instead of associative arrays because those are not supported in Bash 3,
     -    on which macOS is stuck for licensing reasons.
     +    corresponding config variables.  Note that we use indirect expansion to
     +    create a variable for each section, instead of using a single
     +    associative array indexed by section names, because associative arrays
     +    are not supported in Bash 3, on which macOS is stuck for licensing
     +    reasons.
      
     -    Add a test to make sure the new function works correctly by verfying it
     -    lists all 'submodule' config variables. This has the downside that this
     -    test must be updated when new 'submodule' configuration are added, but
     -    this should be a small burden since it happens infrequently.
     +    Use the existing pattern in the completion script of using global
     +    variables to cache the list of config variables for each section. The
     +    rationale for such caching is explained in eaa4e6ee2a (Speed up bash
     +    completion loading, 2009-11-17), and the current approach to using and
     +    defining them via 'test -n' is explained in cf0ff02a38 (completion: work
     +    around zsh option propagation bug, 2012-02-02).
     +
     +    Adjust the name of one of the tests added in the previous commit,
     +    reflecting that it now also tests the new function.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     @@ contrib/completion/git-completion.bash: __git_compute_config_vars ()
       
      +__git_compute_first_level_config_vars_for_section ()
      +{
     -+	section="$1"
     ++	local section="$1"
      +	__git_compute_config_vars
      +	local this_section="__git_first_level_config_vars_for_section_${section}"
      +	test -n "${!this_section}" ||
     @@ contrib/completion/git-completion.bash: __git_complete_config_variable_name ()
       	url.*.*)
      
       ## t/t9902-completion.sh ##
     -@@ t/t9902-completion.sh: test_expect_success 'git config - variable name include' '
     - 	EOF
     +@@ t/t9902-completion.sh: test_expect_success 'setup for git config submodule tests' '
     + 	git submodule add ./sub
       '
       
     -+test_expect_success 'git config - variable name - __git_compute_first_level_config_vars_for_section' '
     -+	test_completion "git config submodule." <<-\EOF
     -+	submodule.active Z
     -+	submodule.alternateErrorStrategy Z
     -+	submodule.alternateLocation Z
     -+	submodule.fetchJobs Z
     -+	submodule.propagateBranches Z
     -+	submodule.recurse Z
     -+	EOF
     -+'
     -+
     - test_expect_success 'git config - value' '
     - 	test_completion "git config color.pager " <<-\EOF
     - 	false Z
     +-test_expect_success 'git config - variable name - submodule' '
     ++test_expect_success 'git config - variable name - submodule and __git_compute_first_level_config_vars_for_section' '
     + 	test_completion "git config submodule." <<-\EOF
     + 	submodule.active Z
     + 	submodule.alternateErrorStrategy Z
 4:  d442a039b27 < -:  ----------- builtin/help: add --config-all-for-completion
 5:  a2e792c911e ! 4:  69fc02bb6b4 completion: add an use __git_compute_second_level_config_vars_for_section
     @@ Metadata
      Author: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## Commit message ##
     -    completion: add an use __git_compute_second_level_config_vars_for_section
     +    completion: add and use __git_compute_second_level_config_vars_for_section
      
          In a previous commit we removed some hardcoded config variable names from
          function __git_complete_config_variable_name in the completion script by
     @@ Commit message
          configuration variables, meaning 'branch.<name>.upstream',
          'remote.<name>.url', etc. where <name> is a user-defined name.
      
     -    Making use of the new --config-all-for-completion flag to 'git help'
     -    introduced in the previous commit, add a new function,
     -    __git_compute_second_level_config_vars_for_section. This function takes
     -    as argument a config section name and computes the corresponding
     -    second-level config variables, i.e. those that contain a '<' which
     -    indicates the start of a placeholder. Note that as in
     +    Making use of the new existing --config flag to 'git help', add a new
     +    function, __git_compute_second_level_config_vars_for_section. This
     +    function takes as argument a config section name and computes the
     +    corresponding second-level config variables, i.e. those that contain a
     +    '<' which indicates the start of a placeholder. Note that as in
          __git_compute_first_level_config_vars_for_section added previsouly, we
          use indirect expansion instead of associative arrays to stay compatible
          with Bash 3 on which macOS is stuck for licensing reasons.
      
     +    As explained in the previous commit, we use the existing pattern in the
     +    completion script of using global variables to cache the list of
     +    variables for each section.
     +
          Use this new function and the variables it defines in
          __git_complete_config_variable_name to remove hardcoded config
          variables, and add a test to verify the new function.  Use a single
          'case' for all sections with second-level variables names, since the
          code for each of them is now exactly the same.
      
     +    Adjust the name of a test added in a previous commit to reflect that it
     +    now tests the added function.
     +
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
       ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: __git_compute_config_vars ()
      +__git_compute_config_vars_all ()
      +{
      +	test -n "$__git_config_vars_all" ||
     -+	__git_config_vars_all="$(git help --config-all-for-completion)"
     ++	__git_config_vars_all="$(git --no-pager help --config)"
      +}
      +
       __git_compute_first_level_config_vars_for_section ()
       {
     - 	section="$1"
     + 	local section="$1"
      @@ contrib/completion/git-completion.bash: __git_compute_first_level_config_vars_for_section ()
       	printf -v "__git_first_level_config_vars_for_section_${section}" %s "$(echo "$__git_config_vars" | grep -E "^${section}\.[a-z]" | awk -F. '{print $2}')"
       }
       
      +__git_compute_second_level_config_vars_for_section ()
      +{
     -+	section="$1"
     ++	local section="$1"
      +	__git_compute_config_vars_all
      +	local this_section="__git_second_level_config_vars_for_section_${section}"
      +	test -n "${!this_section}" ||
     @@ contrib/completion/git-completion.bash: __git_complete_config_variable_name ()
       		__gitcomp "$__git_config_vars" "" "$cur_" "$sfx"
      
       ## t/t9902-completion.sh ##
     -@@ t/t9902-completion.sh: test_expect_success 'git config - variable name - __git_compute_first_level_conf
     - 	submodule.recurse Z
     +@@ t/t9902-completion.sh: test_expect_success 'git config - variable name - submodule and __git_compute_fi
       	EOF
       '
     -+test_expect_success 'git config - variable name - __git_compute_second_level_config_vars_for_section' '
     -+	test_completion "git config branch.main." <<-\EOF
     -+	branch.main.description Z
     -+	branch.main.remote Z
     -+	branch.main.pushRemote Z
     -+	branch.main.merge Z
     -+	branch.main.mergeOptions Z
     -+	branch.main.rebase Z
     -+	EOF
     -+'
       
     - test_expect_success 'git config - value' '
     - 	test_completion "git config color.pager " <<-\EOF
     +-test_expect_success 'git config - variable name - submodule names' '
     ++test_expect_success 'git config - variable name - __git_compute_second_level_config_vars_for_section' '
     + 	test_completion "git config submodule.sub." <<-\EOF
     + 	submodule.sub.url Z
     + 	submodule.sub.update Z

-- 
gitgitgadget
