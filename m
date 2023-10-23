Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392A9171B5
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="FLH7oxhg"
Received: from mail.manjaro.org (mail.manjaro.org [IPv6:2a01:4f8:c0c:51f3::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFE0F9
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 08:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1698073531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RZtRXrJzh6yR4nN5Y7CFWI10hAMaaJGPWXh/xwdkxF4=;
	b=FLH7oxhgySV/W6V9pDcVnipIp0OhFYAIU73nFomirFAzlvIXuyi/5k0oQlr6ZrLZw1trwZ
	fSVpf4EnejssV/Phcbiqu6rbCy1TAgMDgv1VUHlZI/vH+hcBraLHEfKuOkz2N56b6G1V1E
	fiLQGd7lK69TzZFVlXMxF89I4rEe4KtZsW6zepKcDJMKXlk2i9sTui9z+2NwXfiaoMG172
	gErMciE3DJ8FFvgXjdrB5uGKVBq+08JUsNtE3JhweUv+GnaoH38TeNyRnF9hZ+APvm44zP
	BL5AkHf18l6BDn+i/kvifLwt4vwdZkPzrfIQ8VUn4a3VaWTrbRhSiZ1Flh8yvA==
Date: Mon, 23 Oct 2023 17:05:31 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Isoken June Ibizugbe <isokenjune@gmail.com>
Cc: git@vger.kernel.org, rjusto@gmail.com
Subject: Re: [PATCH v3] builtin/branch.c: adjust error messages to coding
 guidelines
In-Reply-To: <20231023145708.4029-1-isokenjune@gmail.com>
References: <20231023145708.4029-1-isokenjune@gmail.com>
Message-ID: <39fd1327b2ae4f73689d70561a2f738d@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2023-10-23 16:57, Isoken June Ibizugbe wrote:
> As per the CodingGuidelines document, it is recommended that error
> messages such as die(), error() and warning(),
> should start with a lowercase letter and should not end with a period.
> 
> This patch adjusts tests to match updated messages.
> 
> Signed-off-by: Isoken June Ibizugbe <isokenjune@gmail.com>

Please, wrap the commit comment at the column 78.  That's how it works 
nearly everywhere.

> ---
>  builtin/branch.c          | 66 +++++++++++++++++++--------------------
>  t/t2407-worktree-heads.sh |  2 +-
>  t/t3200-branch.sh         | 16 +++++-----
>  t/t3202-show-branch.sh    | 10 +++---
>  4 files changed, 47 insertions(+), 47 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 2ec190b14a..e7ee9bd0f1 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -173,11 +173,11 @@ static int branch_merged(int kind, const char 
> *name,
>  	    (head_rev ? repo_in_merge_bases(the_repository, rev, head_rev) :
> 0) != merged) {
>  		if (merged)
>  			warning(_("deleting branch '%s' that has been merged to\n"
> -				"         '%s', but not yet merged to HEAD."),
> +				"         '%s', but not yet merged to HEAD"),
>  				name, reference_name);
>  		else
>  			warning(_("not deleting branch '%s' that is not yet merged to\n"
> -				"         '%s', even though it is merged to HEAD."),
> +				"         '%s', even though it is merged to HEAD"),
>  				name, reference_name);
>  	}
>  	free(reference_name_to_free);
> @@ -190,13 +190,13 @@ static int check_branch_commit(const char
> *branchname, const char *refname,
>  {
>  	struct commit *rev = lookup_commit_reference(the_repository, oid);
>  	if (!force && !rev) {
> -		error(_("Couldn't look up commit object for '%s'"), refname);
> +		error(_("couldn't look up commit object for '%s'"), refname);
>  		return -1;
>  	}
>  	if (!force && !branch_merged(kinds, branchname, rev, head_rev)) {
> -		error(_("The branch '%s' is not fully merged.\n"
> +		error(_("the branch '%s' is not fully merged.\n"
>  		      "If you are sure you want to delete it, "
> -		      "run 'git branch -D %s'."), branchname, branchname);
> +		      "run 'git branch -D %s'"), branchname, branchname);
>  		return -1;
>  	}
>  	return 0;
> @@ -207,7 +207,7 @@ static void delete_branch_config(const char 
> *branchname)
>  	struct strbuf buf = STRBUF_INIT;
>  	strbuf_addf(&buf, "branch.%s", branchname);
>  	if (git_config_rename_section(buf.buf, NULL) < 0)
> -		warning(_("Update of config-file failed"));
> +		warning(_("update of config-file failed"));
>  	strbuf_release(&buf);
>  }
> 
> @@ -260,7 +260,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>  		if (kinds == FILTER_REFS_BRANCHES) {
>  			const char *path;
>  			if ((path = branch_checked_out(name))) {
> -				error(_("Cannot delete branch '%s' "
> +				error(_("cannot delete branch '%s' "
>  					"used by worktree at '%s'"),
>  				      bname.buf, path);
>  				ret = 1;
> @@ -275,7 +275,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>  					&oid, &flags);
>  		if (!target) {
>  			if (remote_branch) {
> -				error(_("remote-tracking branch '%s' not found."), bname.buf);
> +				error(_("remote-tracking branch '%s' not found"), bname.buf);
>  			} else {
>  				char *virtual_name = mkpathdup(fmt_remotes, bname.buf);
>  				char *virtual_target = resolve_refdup(virtual_name,
> @@ -290,7 +290,7 @@ static int delete_branches(int argc, const char
> **argv, int force, int kinds,
>  						"Did you forget --remote?"),
>  						bname.buf);
>  				else
> -					error(_("branch '%s' not found."), bname.buf);
> +					error(_("branch '%s' not found"), bname.buf);
>  				FREE_AND_NULL(virtual_target);
>  			}
>  			ret = 1;
> @@ -518,11 +518,11 @@ static void
> reject_rebase_or_bisect_branch(struct worktree **worktrees,
>  			continue;
> 
>  		if (is_worktree_being_rebased(wt, target))
> -			die(_("Branch %s is being rebased at %s"),
> +			die(_("branch %s is being rebased at %s"),
>  			    target, wt->path);
> 
>  		if (is_worktree_being_bisected(wt, target))
> -			die(_("Branch %s is being bisected at %s"),
> +			die(_("branch %s is being bisected at %s"),
>  			    target, wt->path);
>  	}
>  }
> @@ -578,7 +578,7 @@ static void copy_or_rename_branch(const char
> *oldname, const char *newname, int
>  		if (ref_exists(oldref.buf))
>  			recovery = 1;
>  		else
> -			die(_("Invalid branch name: '%s'"), oldname);
> +			die(_("invalid branch name: '%s'"), oldname);
>  	}
> 
>  	for (int i = 0; worktrees[i]; i++) {
> @@ -594,9 +594,9 @@ static void copy_or_rename_branch(const char
> *oldname, const char *newname, int
> 
>  	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
>  		if (oldref_usage & IS_HEAD)
> -			die(_("No commit on branch '%s' yet."), oldname);
> +			die(_("no commit on branch '%s' yet"), oldname);
>  		else
> -			die(_("No branch named '%s'."), oldname);
> +			die(_("no branch named '%s'"), oldname);
>  	}
> 
>  	/*
> @@ -624,32 +624,32 @@ static void copy_or_rename_branch(const char
> *oldname, const char *newname, int
> 
>  	if (!copy && !(oldref_usage & IS_ORPHAN) &&
>  	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
> -		die(_("Branch rename failed"));
> +		die(_("branch rename failed"));
>  	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
> -		die(_("Branch copy failed"));
> +		die(_("branch copy failed"));
> 
>  	if (recovery) {
>  		if (copy)
> -			warning(_("Created a copy of a misnamed branch '%s'"),
> +			warning(_("created a copy of a misnamed branch '%s'"),
>  				interpreted_oldname);
>  		else
> -			warning(_("Renamed a misnamed branch '%s' away"),
> +			warning(_("renamed a misnamed branch '%s' away"),
>  				interpreted_oldname);
>  	}
> 
>  	if (!copy && (oldref_usage & IS_HEAD) &&
>  	    replace_each_worktree_head_symref(worktrees, oldref.buf, 
> newref.buf,
>  					      logmsg.buf))
> -		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
> +		die(_("branch renamed to %s, but HEAD is not updated"), newname);
> 
>  	strbuf_release(&logmsg);
> 
>  	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
>  	strbuf_addf(&newsection, "branch.%s", interpreted_newname);
>  	if (!copy && git_config_rename_section(oldsection.buf, 
> newsection.buf) < 0)
> -		die(_("Branch is renamed, but update of config-file failed"));
> +		die(_("branch is renamed, but update of config-file failed"));
>  	if (copy && strcmp(interpreted_oldname, interpreted_newname) &&
> git_config_copy_section(oldsection.buf, newsection.buf) < 0)
> -		die(_("Branch is copied, but update of config-file failed"));
> +		die(_("branch is copied, but update of config-file failed"));
>  	strbuf_release(&oldref);
>  	strbuf_release(&newref);
>  	strbuf_release(&oldsection);
> @@ -773,7 +773,7 @@ int cmd_branch(int argc, const char **argv, const
> char *prefix)
> 
>  	head = resolve_refdup("HEAD", 0, &head_oid, NULL);
>  	if (!head)
> -		die(_("Failed to resolve HEAD as a valid ref."));
> +		die(_("failed to resolve HEAD as a valid ref"));
>  	if (!strcmp(head, "HEAD"))
>  		filter.detached = 1;
>  	else if (!skip_prefix(head, "refs/heads/", &head))
> @@ -866,7 +866,7 @@ int cmd_branch(int argc, const char **argv, const
> char *prefix)
> 
>  		if (!argc) {
>  			if (filter.detached)
> -				die(_("Cannot give description to detached HEAD"));
> +				die(_("cannot give description to detached HEAD"));
>  			branch_name = head;
>  		} else if (argc == 1) {
>  			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
> @@ -878,8 +878,8 @@ int cmd_branch(int argc, const char **argv, const
> char *prefix)
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
>  		if (!ref_exists(branch_ref.buf))
>  			error((!argc || branch_checked_out(branch_ref.buf))
> -			      ? _("No commit on branch '%s' yet.")
> -			      : _("No branch named '%s'."),
> +			      ? _("no commit on branch '%s' yet")
> +			      : _("no branch named '%s'"),
>  			      branch_name);
>  		else if (!edit_branch_description(branch_name))
>  			ret = 0; /* happy */
> @@ -892,8 +892,8 @@ int cmd_branch(int argc, const char **argv, const
> char *prefix)
>  		if (!argc)
>  			die(_("branch name required"));
>  		else if ((argc == 1) && filter.detached)
> -			die(copy? _("cannot copy the current branch while not on any.")
> -				: _("cannot rename the current branch while not on any."));
> +			die(copy? _("cannot copy the current branch while not on any")
> +				: _("cannot rename the current branch while not on any"));
>  		else if (argc == 1)
>  			copy_or_rename_branch(head, argv[0], copy, copy + rename > 1);
>  		else if (argc == 2)
> @@ -916,14 +916,14 @@ int cmd_branch(int argc, const char **argv,
> const char *prefix)
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))
>  				die(_("could not set upstream of HEAD to %s when "
> -				      "it does not point to any branch."),
> +				      "it does not point to any branch"),
>  				    new_upstream);
>  			die(_("no such branch '%s'"), argv[0]);
>  		}
> 
>  		if (!ref_exists(branch->refname)) {
>  			if (!argc || branch_checked_out(branch->refname))
> -				die(_("No commit on branch '%s' yet."), branch->name);
> +				die(_("no commit on branch '%s' yet"), branch->name);
>  			die(_("branch '%s' does not exist"), branch->name);
>  		}
> 
> @@ -946,12 +946,12 @@ int cmd_branch(int argc, const char **argv,
> const char *prefix)
>  		if (!branch) {
>  			if (!argc || !strcmp(argv[0], "HEAD"))
>  				die(_("could not unset upstream of HEAD when "
> -				      "it does not point to any branch."));
> +				      "it does not point to any branch"));
>  			die(_("no such branch '%s'"), argv[0]);
>  		}
> 
>  		if (!branch_has_merge_config(branch))
> -			die(_("Branch '%s' has no upstream information"), branch->name);
> +			die(_("branch '%s' has no upstream information"), branch->name);
> 
>  		strbuf_reset(&buf);
>  		strbuf_addf(&buf, "branch.%s.remote", branch->name);
> @@ -965,11 +965,11 @@ int cmd_branch(int argc, const char **argv,
> const char *prefix)
>  		const char *start_name = argc == 2 ? argv[1] : head;
> 
>  		if (filter.kind != FILTER_REFS_BRANCHES)
> -			die(_("The -a, and -r, options to 'git branch' do not take a branch 
> name.\n"
> +			die(_("the -a, and -r, options to 'git branch' do not take a branch 
> name.\n"
>  				  "Did you mean to use: -a|-r --list <pattern>?"));
> 
>  		if (track == BRANCH_TRACK_OVERRIDE)
> -			die(_("the '--set-upstream' option is no longer supported. Please
> use '--track' or '--set-upstream-to' instead."));
> +			die(_("the '--set-upstream' option is no longer supported. Please
> use '--track' or '--set-upstream-to' instead"));
> 
>  		if (recurse_submodules) {
>  			create_branches_recursively(the_repository, branch_name,
> diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
> index 469443d8ae..f6835c91dc 100755
> --- a/t/t2407-worktree-heads.sh
> +++ b/t/t2407-worktree-heads.sh
> @@ -45,7 +45,7 @@ test_expect_success 'refuse to overwrite: checked
> out in worktree' '
>  		grep "cannot force update the branch" err &&
> 
>  		test_must_fail git branch -D wt-$i 2>err &&
> -		grep "Cannot delete branch" err || return 1
> +		grep "cannot delete branch" err || return 1
>  	done
>  '
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 080e4f24a6..3182abde27 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -291,10 +291,10 @@ test_expect_success 'git branch -M topic topic
> should work when main is checked
>  test_expect_success 'git branch -M and -C fail on detached HEAD' '
>  	git checkout HEAD^{} &&
>  	test_when_finished git checkout - &&
> -	echo "fatal: cannot rename the current branch while not on any." 
> >expect &&
> +	echo "fatal: cannot rename the current branch while not on any" 
> >expect &&
>  	test_must_fail git branch -M must-fail 2>err &&
>  	test_cmp expect err &&
> -	echo "fatal: cannot copy the current branch while not on any." 
> >expect &&
> +	echo "fatal: cannot copy the current branch while not on any" >expect 
> &&
>  	test_must_fail git branch -C must-fail 2>err &&
>  	test_cmp expect err
>  '
> @@ -943,7 +943,7 @@ test_expect_success 'deleting currently checked
> out branch fails' '
>  	git worktree add -b my7 my7 &&
>  	test_must_fail git -C my7 branch -d my7 &&
>  	test_must_fail git branch -d my7 2>actual &&
> -	grep "^error: Cannot delete branch .my7. used by worktree at " actual 
> &&
> +	grep "^error: cannot delete branch .my7. used by worktree at " actual 
> &&
>  	rm -r my7 &&
>  	git worktree prune
>  '
> @@ -954,7 +954,7 @@ test_expect_success 'deleting in-use branch fails' 
> '
>  	git -C my7 bisect start HEAD HEAD~2 &&
>  	test_must_fail git -C my7 branch -d my7 &&
>  	test_must_fail git branch -d my7 2>actual &&
> -	grep "^error: Cannot delete branch .my7. used by worktree at " actual 
> &&
> +	grep "^error: cannot delete branch .my7. used by worktree at " actual 
> &&
>  	rm -r my7 &&
>  	git worktree prune
>  '
> @@ -1024,7 +1024,7 @@ test_expect_success '--set-upstream-to fails on
> multiple branches' '
>  test_expect_success '--set-upstream-to fails on detached HEAD' '
>  	git checkout HEAD^{} &&
>  	test_when_finished git checkout - &&
> -	echo "fatal: could not set upstream of HEAD to main when it does not
> point to any branch." >expect &&
> +	echo "fatal: could not set upstream of HEAD to main when it does not
> point to any branch" >expect &&
>  	test_must_fail git branch --set-upstream-to main 2>err &&
>  	test_cmp expect err
>  '
> @@ -1072,7 +1072,7 @@ test_expect_success 'use --set-upstream-to
> modify a particular branch' '
>  '
> 
>  test_expect_success '--unset-upstream should fail if given a
> non-existent branch' '
> -	echo "fatal: Branch '"'"'i-dont-exist'"'"' has no upstream
> information" >expect &&
> +	echo "fatal: branch '"'"'i-dont-exist'"'"' has no upstream
> information" >expect &&
>  	test_must_fail git branch --unset-upstream i-dont-exist 2>err &&
>  	test_cmp expect err
>  '
> @@ -1094,7 +1094,7 @@ test_expect_success 'test --unset-upstream on 
> HEAD' '
>  	test_must_fail git config branch.main.remote &&
>  	test_must_fail git config branch.main.merge &&
>  	# fail for a branch without upstream set
> -	echo "fatal: Branch '"'"'main'"'"' has no upstream information" 
> >expect &&
> +	echo "fatal: branch '"'"'main'"'"' has no upstream information" 
> >expect &&
>  	test_must_fail git branch --unset-upstream 2>err &&
>  	test_cmp expect err
>  '
> @@ -1108,7 +1108,7 @@ test_expect_success '--unset-upstream should
> fail on multiple branches' '
>  test_expect_success '--unset-upstream should fail on detached HEAD' '
>  	git checkout HEAD^{} &&
>  	test_when_finished git checkout - &&
> -	echo "fatal: could not unset upstream of HEAD when it does not point
> to any branch." >expect &&
> +	echo "fatal: could not unset upstream of HEAD when it does not point
> to any branch" >expect &&
>  	test_must_fail git branch --unset-upstream 2>err &&
>  	test_cmp expect err
>  '
> diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
> index b17f388f56..2cdb834b37 100755
> --- a/t/t3202-show-branch.sh
> +++ b/t/t3202-show-branch.sh
> @@ -10,7 +10,7 @@ GIT_TEST_DATE_NOW=1251660000; export 
> GIT_TEST_DATE_NOW
>  test_expect_success 'error descriptions on empty repository' '
>  	current=$(git branch --show-current) &&
>  	cat >expect <<-EOF &&
> -	error: No commit on branch '\''$current'\'' yet.
> +	error: no commit on branch '\''$current'\'' yet
>  	EOF
>  	test_must_fail git branch --edit-description 2>actual &&
>  	test_cmp expect actual &&
> @@ -21,7 +21,7 @@ test_expect_success 'error descriptions on empty 
> repository' '
>  test_expect_success 'fatal descriptions on empty repository' '
>  	current=$(git branch --show-current) &&
>  	cat >expect <<-EOF &&
> -	fatal: No commit on branch '\''$current'\'' yet.
> +	fatal: no commit on branch '\''$current'\'' yet
>  	EOF
>  	test_must_fail git branch --set-upstream-to=non-existent 2>actual &&
>  	test_cmp expect actual &&
> @@ -224,7 +224,7 @@ done
> 
>  test_expect_success 'error descriptions on non-existent branch' '
>  	cat >expect <<-EOF &&
> -	error: No branch named '\''non-existent'\'.'
> +	error: no branch named '\''non-existent'\''
>  	EOF
>  	test_must_fail git branch --edit-description non-existent 2>actual &&
>  	test_cmp expect actual
> @@ -238,7 +238,7 @@ test_expect_success 'fatal descriptions on
> non-existent branch' '
>  	test_cmp expect actual &&
> 
>  	cat >expect <<-EOF &&
> -	fatal: No branch named '\''non-existent'\''.
> +	fatal: no branch named '\''non-existent'\''
>  	EOF
>  	test_must_fail git branch -c non-existent new-branch 2>actual &&
>  	test_cmp expect actual &&
> @@ -253,7 +253,7 @@ test_expect_success 'error descriptions on orphan 
> branch' '
>  	test_branch_op_in_wt() {
>  		test_orphan_error() {
>  			test_must_fail git $* 2>actual &&
> -			test_i18ngrep "No commit on branch .orphan-branch. yet.$" actual
> +			test_i18ngrep "no commit on branch .orphan-branch. yet$" actual
>  		} &&
>  		test_orphan_error -C wt branch $1 $2 &&                # implicit 
> branch
>  		test_orphan_error -C wt branch $1 orphan-branch $2 &&  # explicit 
> branch
