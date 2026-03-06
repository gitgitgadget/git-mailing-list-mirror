Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E345346FAB
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 13:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772802877; cv=none; b=X1RcoWaYA5FT6Lo6TsgjLwJz/6kevDQtGSG2EV2e7dS6HjR4LPwvw231LVwek39Swq+tznmC8pTK5AqxPpcpkOolChwSsluA1mJq1EJhc7nKIAbNeI79p/Mp6lZtWtD4wZ3k8ajQPp5YDdoAhpq/61ccIkbNQqQ/L2dVHAxxuPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772802877; c=relaxed/simple;
	bh=1WKOk3tsUVJXUpliNpVaWwjFRqkqQx6o9AdPw7Gb6eo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ix2e6NWBfnFHrvCLb08vgVD/LffcyjfS7ChBRK+TCIdVtzh2EN7UChK9DxXETfpRE13tXmdiHLi22oZ65T7hJxanEvaMseOj5YK/i9ihgJLUsvY0mACD9tPzo5UVvYSQmEAnPYGFxxm+ewLcCbWY8wfok7clJO7uqPVshJQtejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CbELgctk; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CbELgctk"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1270adc5121so11449402c88.0
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 05:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772802874; x=1773407674; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o1YIUc3OxEGOujt00liZVXPaud+iaMGGSi2X1Yv87E=;
        b=CbELgctk7KcrYZYizwYMIw2FB9nmDlPrjbeeboycffArExGIz+Eb6LGR5Qq7tFwbOU
         C44WbrtQ+UlhqqJkVuur7Kf9+93MmTfGJXI0W4sDWh53ylLRBtUnvIj5935WiI0jpDF6
         3UzAXez0WZk2vstNDW5daomFPX4SbPZWVHa/6s0Ir1lDZ7lPU8dUzkbekVIMnnxHFpct
         Ed0CbNMvyRLvHvF4z5mms2SmR71OFVN1PmonovpRhAY9KORSFEW0fzlgYfkxcK3JNIXO
         i8oQ1MSA30QrVqyD0dJWOGlrPfJ6U3GesmjgNfSpxElmIn+Lo7e1+rVMkNmrcJJTKek0
         jR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772802874; x=1773407674;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2o1YIUc3OxEGOujt00liZVXPaud+iaMGGSi2X1Yv87E=;
        b=OmM64j3XkpkmjW0ppHd9NtO5ut/IAHsaoZm16HTKDzBd3ImAusrVJTTROaFT5oNQL/
         KGvsfaPiI6ivknqxT4LjAJW2vhUYF9q+1Ui4cyxztw2ljIJLXA9FKgYjsaOnM3tHJPUm
         FdY8PErYKRNMJ6jewOM1iMVQlwdDZJYa142HSeKMapFCdMifc6N0Y1ZUQMLfx7vPi87b
         pIjsvP9ojP70WL3XZfvPAbRQqQg8EXBa9F5WnexTLXo15ymVZq1rPtwB6x10WuOlcW83
         MKbnH4LCDozLkjxggzzLu+46ahs3g2SxY2UGrwMxHVSh0F6wOA1XwraUVjtC0+CrXhoO
         4s8Q==
X-Gm-Message-State: AOJu0Yz/j/Q9lTP4qC39QEXmVIKwZ+9bKfNU/MjYbHg7ssvwGl3ra6Ha
	chFHftmC84Mpi3Av++24Hv5bqppfTpOemE+Hof9si64NYRAl86XFEkWXBt6bgA==
X-Gm-Gg: ATEYQzxsfnsGV7whuJHX8f7LNe/mIv7dAf6OGKJ2OpYDq+tDx7yUba65g2Fr8WEI77C
	JZRY49PUw0wBOy0t5Ox1/HqqxqsglyjfMlgGG6sVy0jlpcAFapvA4TQ2aVChfmsxAlczUURne9C
	DoxTs0HNjBotUwpgQYzcKsXX8qQglSdSoLVjyn+jmbXIkDtlnddnaZCKwSeQocRvAxYsSKaPX5C
	73uyZKPqaO9Nfyu8v60o7z6hplW7ypNa7oW40z1MYv9YWktchjNqqlUU9vF3WuokOujf0vS/P0H
	voJVYFtsIKAlM1w9Aau1HUAZSbgCdi6ZXYFoDwLXM14O+3h0d43mLJshbjQp1EulDZ/ycGJkuG0
	tDwYLPrbzgjV8+pySIFqK/3vuT4QZglJOY7dnjHhGICHgY8s36vTCo0vBC2SBvGns3ZCkBfduQl
	a4wmaCwrDtOw8S+9ewRxKJDgpY0Q==
X-Received: by 2002:a05:7300:cd90:b0:2be:2b16:b99f with SMTP id 5a478bee46e88-2be4de928fcmr722034eec.13.1772802873808;
        Fri, 06 Mar 2026 05:14:33 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.130])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be4f948324sm1258875eec.17.2026.03.06.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 05:14:32 -0800 (PST)
Message-Id: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
References: <pull.2202.v2.git.git.1772207333.gitgitgadget@gmail.com>
From: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 06 Mar 2026 13:14:29 +0000
Subject: [PATCH v3 0/3] branch: add prefixes to new branch names
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
    Junio C Hamano <gitster@pobox.com>,
    Yoann Valeri <yoann.valeri@cea.fr>,
    Yoann Valeri <yoann.valeri@cea.fr>

This PR adds a way to add prefixes to a new branch being created. The goal
is mostly to ease the developer process of creating new branches by adding
shortcuts that can be set either with a command-line option or with
configuration parameter. This is useful especially when you have to do
similar backports on multiple branches, removing a bit of the need for
finding names or typing the names over and over again.

Changes since v1:

 * Added a '--no-prefix' option to git branch

Changes since v2:

 * Changed the PR structure, with 3 patches:
   * first patch adds the '--name-prefix' option
   * second adds the 'branch.namePrefix' configuration parameter
   * third adds the '--no-name-prefix' option
 * Those patches only target 'git branch' now

VALERI Yoann (3):
  branch: add '--name-prefix' option
  branch: add 'branch.namePrefix' config param
  branch: add '--no-name-prefix' option

 Documentation/config/branch.adoc |  5 +++++
 Documentation/git-branch.adoc    | 11 ++++++++++-
 branch.c                         | 21 ++++++++++++++++++++
 branch.h                         | 12 +++++++++++
 builtin/branch.c                 | 25 +++++++++++++++--------
 t/t3200-branch.sh                | 34 ++++++++++++++++++++++++++++++++
 6 files changed, 99 insertions(+), 9 deletions(-)


base-commit: 2cc71917514657b93014134350864f4849edfc83
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2202%2Fvaleriyoann%2Fbranch-with-prefix-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2202/valeriyoann/branch-with-prefix-v3
Pull-Request: https://github.com/git/git/pull/2202

Range-diff vs v2:

 1:  49641fb34c ! 1:  6cbb950d8b branch: add 'branch.addCurrentBranchAsPrefix' config param
     @@ Metadata
      Author: VALERI Yoann <yoann.valeri@cea.fr>
      
       ## Commit message ##
     -    branch: add 'branch.addCurrentBranchAsPrefix' config param
     +    branch: add '--name-prefix' option
      
     -    This patch adds a new configuration parameter for the branch creation
     -    feature: 'branch.addCurrentBranchAsPrefix'. When set to true, if one
     -    creates a new branch with either `git branch`, `git checkout -[bB]` or
     -    `git switch -[cC]`, we will now retrieve the current branch's name, and
     -    use it as prefix for the name of the newly created branch, alongside a
     -    hyphen separating the two.
     -
     -    For instance, using this parameter, and attempting to create a branch
     -    'test' while on the 'main' branch will instead create a branch
     -    'main-test'.
     -
     -    This parameters is useful for projects handling many branches, with
     -    features often needing backport on different branches, so as to reduce
     -    the time taken to create branches without having to come up with clever
     -    names.
     +    This patch adds a '--name-prefix' option to add a prefix to a newly
     +    created branch. It can use a regular string or a token as prefix. The
     +    only token currently handled is '@{current}', which is substituted for
     +    the current branch's name.
      
          Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
      
     - ## Documentation/config/branch.adoc ##
     -@@ Documentation/config/branch.adoc: This option defaults to `never`.
     - 	value of this variable will be used as the default.
     - 	See linkgit:git-for-each-ref[1] field names for valid values.
     - 
     -+`branch.addCurrentBranchAsPrefix`::
     -+	When a new branch is created with `git branch`, `git switch` or `git
     -+	checkout` use the name of the current branch as a prefix for the new
     -+	branch's name, alongside the one provided by the user, with a hyphen in the
     -+	middle. For instance, using this configuration variable, creating the branch
     -+	`test` while on `main` will create the branch `main-test`. False by default.
     -+
     - `branch.<name>.remote`::
     - 	When on branch _<name>_, it tells `git fetch` and `git push`
     - 	which remote to fetch from or push to.  The remote to push to
     + ## Documentation/git-branch.adoc ##
     +@@ Documentation/git-branch.adoc: git branch [--color[=<when>] | --no-color] [--show-current]
     + 	   [(-r|--remotes) | (-a|--all)]
     + 	   [--list] [<pattern>...]
     + git branch [--track[=(direct|inherit)] | --no-track] [-f]
     +-	   [--recurse-submodules] <branch-name> [<start-point>]
     ++	   [--recurse-submodules] [--name-prefix=<token>]
     ++           <branch-name> [<start-point>]
     + git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
     + git branch --unset-upstream [<branch-name>]
     + git branch (-m|-M) [<old-branch>] <new-branch>
     +@@ Documentation/git-branch.adoc: Note that this will create the new branch, but it will not switch the
     + working tree to it; use `git switch <new-branch>` to switch to the
     + new branch.
     + 
     ++With a `--name-prefix` option, you can add a prefix to the branch to create.
     ++This can either a simple name, or a token. Currently, only '@{current}' is
     ++managed as token, and will use the current branch name as prefix.
     ++
     + When a local branch is started off a remote-tracking branch, Git sets up the
     + branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
     + configuration entries) so that `git pull` will appropriately merge from
     +@@ Documentation/git-branch.adoc: superproject's "origin/main", but tracks the submodule's "origin/main".
     + 	and the object it points at.  _<format>_ is the same as
     + 	that of linkgit:git-for-each-ref[1].
     + 
     ++`--name-prefix <token>`::
     ++	A string that will be used as prefix to the name of the new branch to
     ++        create. Can be '@{current}' to use the current branch's name.
     ++
     + _<branch-name>_::
     + 	The name of the branch to create or delete.
     + 	The new branch name must pass all checks defined by
      
       ## branch.c ##
      @@ branch.c: int read_branch_desc(struct strbuf *buf, const char *branch_name)
       	return 0;
       }
       
     -+void add_branch_prefix(const char *current_branch,
     -+					   const char *target_branch, struct strbuf *buf)
     ++void add_branch_prefix(const char *name_prefix,
     ++					   const char *current_branch, struct strbuf *buf)
      +{
      +	int value = 0;
      +
     -+	repo_config_get_bool(the_repository,
     -+						 "branch.addCurrentBranchAsPrefix", &value);
     ++	if (!name_prefix)
     ++		return;
      +
     -+	if (value)
     -+		strbuf_addf(buf, "%s-%s", current_branch, target_branch);
     -+	else
     -+		strbuf_addstr(buf, target_branch);
     ++	if (name_prefix[0] != '@') {
     ++		strbuf_addstr(buf, name_prefix);
     ++		return;
     ++	}
     ++
     ++	if (strcmp(name_prefix, "@{current}") == 0)
     ++		strbuf_addstr(buf, current_branch);
      +}
      +
       /*
     @@ branch.h: int install_branch_config(int flag, const char *local, const char *ori
       int read_branch_desc(struct strbuf *, const char *branch_name);
       
      +/*
     -+ * Fetch the configuration parameter 'branch.addCurrentBranchAsPrefix' and
     -+ * fill the buffer 'buf' with '<current_branch>-<target_branch>' if true,
     -+ * otherwise just '<current_branch>'.
     ++ * Store in 'buf' a prefix to the name of a branch to create by using the given
     ++ * string 'name_prefix'. It can either be a simple string to a shorthand
     ++ * starting with '@'.
     ++ *
     ++ * Currently, only '@{current}' is managed, and will use 'current_branch' as
     ++ * prefix.
      + */
     -+void add_branch_prefix(const char *current_branch,
     -+					   const char *target_branch, struct strbuf *buf);
     ++void add_branch_prefix(const char *name_prefix, const char *current_branch,
     ++					   struct strbuf *buf);
     ++
      +
       /*
        * Check if a branch is checked out in the main worktree or any linked
        * worktree and die (with a message describing its checkout location) if
      
       ## builtin/branch.c ##
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
     + 	struct ref_format format = REF_FORMAT_INIT;
     + 	int ret;
     ++	const char *name_prefix = NULL;
     + 
     + 	struct option options[] = {
     + 		OPT_GROUP(N_("Generic options")),
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
     + 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
     + 		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
     ++		OPT_STRING(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create")),
     + 		OPT_END(),
     + 	};
     + 
      @@ builtin/branch.c: int cmd_branch(int argc,
       	} else if (!noncreate_actions && argc > 0 && argc <= 2) {
       		const char *branch_name = argv[0];
     @@ builtin/branch.c: int cmd_branch(int argc,
       
      -		if (recurse_submodules) {
      -			create_branches_recursively(the_repository, branch_name,
     -+		add_branch_prefix(start_name, branch_name, &new_branch_name);
     ++		add_branch_prefix(name_prefix, start_name, &new_branch_name);
     ++		strbuf_addstr(&new_branch_name, branch_name);
      +
      +		if (recurse_submodules)
      +			create_branches_recursively(the_repository, new_branch_name.buf,
     @@ builtin/branch.c: int cmd_branch(int argc,
       		usage_with_options(builtin_branch_usage, options);
       
      
     - ## builtin/checkout.c ##
     -@@ builtin/checkout.c: static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
     - 	release_revisions(&revs);
     - }
     - 
     -+static void get_current_branch_info(struct branch_info *branch_info)
     -+{
     -+	struct object_id rev;
     -+	int flag;
     -+
     -+	branch_info->path = refs_resolve_refdup(get_main_ref_store(the_repository),
     -+											"HEAD", 0, &rev, &flag);
     -+
     -+	if (branch_info->path)
     -+		branch_info->commit = lookup_commit_reference_gently(the_repository,
     -+															 &rev, 1);
     -+
     -+	if (!(flag & REF_ISSYMREF))
     -+		FREE_AND_NULL(branch_info->path);
     -+
     -+	if (branch_info->path) {
     -+		const char *const prefix = "refs/heads/";
     -+		const char *p;
     -+
     -+		if (skip_prefix(branch_info->path, prefix, &p))
     -+			branch_info->name = xstrdup(p);
     -+	}
     -+}
     -+
     - static int switch_branches(const struct checkout_opts *opts,
     - 			   struct branch_info *new_branch_info)
     - {
     - 	int ret = 0;
     - 	struct branch_info old_branch_info = { 0 };
     --	struct object_id rev;
     --	int flag, writeout_error = 0;
     -+	int writeout_error = 0;
     - 	int do_merge = 1;
     - 
     - 	trace2_cmd_mode("branch");
     - 
     - 	memset(&old_branch_info, 0, sizeof(old_branch_info));
     --	old_branch_info.path = refs_resolve_refdup(get_main_ref_store(the_repository),
     --						   "HEAD", 0, &rev, &flag);
     --	if (old_branch_info.path)
     --		old_branch_info.commit = lookup_commit_reference_gently(the_repository, &rev, 1);
     --	if (!(flag & REF_ISSYMREF))
     --		FREE_AND_NULL(old_branch_info.path);
     --
     --	if (old_branch_info.path) {
     --		const char *const prefix = "refs/heads/";
     --		const char *p;
     --		if (skip_prefix(old_branch_info.path, prefix, &p))
     --			old_branch_info.name = xstrdup(p);
     --	}
     -+	get_current_branch_info(&old_branch_info);
     - 
     - 	if (opts->new_orphan_branch && opts->orphan_from_empty_tree) {
     - 		if (new_branch_info->name)
     -@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
     - 	int parseopt_flags = 0;
     - 	struct branch_info new_branch_info = { 0 };
     - 	int ret;
     -+	struct strbuf full_branch_name = { 0 };
     - 
     - 	opts->overwrite_ignore = 1;
     - 	opts->prefix = prefix;
     -@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
     - 	}
     - 
     - 	if (opts->new_branch) {
     -+		struct branch_info current_branch = { 0 };
     - 		struct strbuf buf = STRBUF_INIT;
     -+		strbuf_init(&full_branch_name, 0);
     -+
     -+		get_current_branch_info(&current_branch);
     -+		add_branch_prefix(current_branch.name, opts->new_branch,
     -+						  &full_branch_name);
     -+		branch_info_release(&current_branch);
     -+		opts->new_branch = full_branch_name.buf;
     - 
     - 		if (opts->new_branch_force)
     - 			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
     -@@ builtin/checkout.c: static int checkout_main(int argc, const char **argv, const char *prefix,
     - 	clear_pathspec(&opts->pathspec);
     - 	free(opts->pathspec_from_file);
     - 	free(options);
     -+	if (full_branch_name.buf)
     -+		strbuf_release(&full_branch_name);
     - 
     - 	return ret;
     - }
     -
     - ## t/t2018-checkout-branch.sh ##
     -@@ t/t2018-checkout-branch.sh: test_expect_success 'checkout -b rejects an extra path argument' '
     - 	test_grep "Cannot update paths and switch to branch" err
     - '
     - 
     -+test_expect_success 'checkout -b with prefix is valid' '
     -+	git checkout -b main &&
     -+	git checkout -b checkoutb-with-prefix &&
     -+	git checkout main &&
     -+	test_config branch.addCurrentBranchAsPrefix false &&
     -+	test_must_fail git checkout -b checkoutb-with-prefix &&
     -+	test_config branch.addCurrentBranchAsPrefix true &&
     -+	git checkout -b checkoutb-with-prefix &&
     -+	git checkout -b checkoutb-with-prefix &&
     -+	test_ref_exists refs/heads/checkoutb-with-prefix &&
     -+	test_ref_exists refs/heads/main-checkoutb-with-prefix &&
     -+	test_ref_exists refs/heads/main-checkoutb-with-prefix-checkoutb-with-prefix
     -+'
     -+
     -+test_expect_success 'checkout -B with prefix is valid' '
     -+	git checkout main &&
     -+	git checkout -B checkoutB-with-prefix &&
     -+	git checkout main &&
     -+	test_config branch.addCurrentBranchAsPrefix false &&
     -+	git checkout -B checkoutB-with-prefix &&
     -+	test_config branch.addCurrentBranchAsPrefix true &&
     -+	git checkout -B checkoutB-with-prefix &&
     -+	test_ref_exists refs/heads/checkoutB-with-prefix &&
     -+	test_ref_exists refs/heads/checkoutB-with-prefix-checkoutB-with-prefix
     -+'
     -+
     - test_done
     -
     - ## t/t2060-switch.sh ##
     -@@ t/t2060-switch.sh: test_expect_success 'switch back when temporarily detached and checked out elsew
     - 	git -C wt2 switch --ignore-other-worktrees shared
     - '
     - 
     -+test_expect_success 'switch -c with prefix is valid' '
     -+	git switch main &&
     -+	git switch -c switchc-with-prefix &&
     -+	git checkout main &&
     -+	test_config branch.addCurrentBranchAsPrefix false &&
     -+	test_must_fail git switch -c switchc-with-prefix &&
     -+	test_config branch.addCurrentBranchAsPrefix true &&
     -+	git switch -c switchc-with-prefix &&
     -+	git switch -c switchc-with-prefix &&
     -+	test_ref_exists refs/heads/switchc-with-prefix &&
     -+	test_ref_exists refs/heads/main-switchc-with-prefix &&
     -+	test_ref_exists refs/heads/main-switchc-with-prefix-switchc-with-prefix
     -+'
     -+
     -+test_expect_success 'switch -C with prefix is valid' '
     -+	git switch main &&
     -+	git switch -C switchC-with-prefix &&
     -+	git checkout main &&
     -+	test_config branch.addCurrentBranchAsPrefix false &&
     -+	git switch -C switchC-with-prefix &&
     -+	test_config branch.addCurrentBranchAsPrefix true &&
     -+	git switch -C switchC-with-prefix &&
     -+	test_ref_exists refs/heads/switchC-with-prefix &&
     -+	test_ref_exists refs/heads/switchC-with-prefix-switchC-with-prefix
     -+'
     -+
     - test_done
     -
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'create branch with prefix' '
     ++test_expect_success 'create branch with --name-prefix' '
      +	git config branch.autosetupmerge false &&
      +	git branch branch-with-prefix &&
     -+	test_config branch.addCurrentBranchAsPrefix false &&
     -+	test_must_fail git branch branch-with-prefix &&
     -+	test_config branch.addCurrentBranchAsPrefix true &&
     -+	git branch branch-with-prefix &&
     -+	git checkout branch-with-prefix &&
     -+	git branch branch-with-prefix &&
     ++	git branch --name-prefix "blob" -- -with-prefix &&
     ++	test_must_fail git branch --name-prefix "blob" -- -with-prefix &&
     ++	git branch --name-prefix "@{current}" -- -with-prefix &&
     ++	git switch blob-with-prefix &&
     ++	git branch --name-prefix "@{current}" -- -with-prefix &&
     ++	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
      +	test_ref_exists refs/heads/branch-with-prefix &&
     -+	test_ref_exists refs/heads/main-branch-with-prefix &&
     -+	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix
     ++	test_ref_exists refs/heads/main-with-prefix &&
     ++	test_ref_exists refs/heads/blob-with-prefix &&
     ++	test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
     ++	git checkout main &&
     ++	git branch -D branch-with-prefix main-with-prefix blob-with-prefix &&
     ++	git branch -D blob-with-prefix-with-prefix
      +'
      +
       test_done
 -:  ---------- > 2:  d51f71708c branch: add 'branch.namePrefix' config param
 2:  0fbdf031cb ! 3:  8f45374007 branch: add a no-prefix option
     @@ Metadata
      Author: VALERI Yoann <yoann.valeri@cea.fr>
      
       ## Commit message ##
     -    branch: add a no-prefix option
     +    branch: add '--no-name-prefix' option
      
     -    This patch adds a '--no-prefix' option to 'git branch' to selectively
     -    override the 'branch.addCurrentBranchAsPrefix' configuration parameter.
     +    This patch adds the '--no-name-prefix' option to prevent adding any
     +    prefix to the branch being created, whether through the '--name-prefix'
     +    option or the 'branch.namePrefix' configuration parameter.
          Signed-off-by: VALERI Yoann <yoann.valeri@cea.fr>
      
       ## builtin/branch.c ##
     @@ builtin/branch.c: int cmd_branch(int argc,
       	int delete = 0, rename = 0, copy = 0, list = 0,
      -	    unset_upstream = 0, show_current = 0, edit_description = 0;
      +	    unset_upstream = 0, show_current = 0, edit_description = 0,
     -+	    no_prefix = 0;
     ++		no_name_prefix = 0;
       	const char *new_upstream = NULL;
       	int noncreate_actions = 0;
       	/* possible options */
     @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
       		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
       		OPT_STRING(  0 , "format", &format.format, N_("format"), N_("format to use for the output")),
     -+		OPT_BOOL(0, "no-prefix", &no_prefix, N_("do not add a prefix to the branch being created")),
     +-		OPT_STRING(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create")),
     ++		OPT_STRING_F(0, "name-prefix", &name_prefix, N_("name"), N_("prefix for the branch to create"), PARSE_OPT_NONEG),
     ++		OPT_BOOL(0, "no-name-prefix", &no_name_prefix, N_("do not use any prefix for the branch to create")),
       		OPT_END(),
       	};
       
     @@ builtin/branch.c: int cmd_branch(int argc,
       		if (track == BRANCH_TRACK_OVERRIDE)
       			die(_("the '--set-upstream' option is no longer supported. Please use '--track' or '--set-upstream-to' instead"));
       
     --		add_branch_prefix(start_name, branch_name, &new_branch_name);
     -+		if (!no_prefix)
     -+			add_branch_prefix(start_name, branch_name, &new_branch_name);
     -+		else
     -+			strbuf_addstr(&new_branch_name, branch_name);
     +-		add_branch_prefix(name_prefix, start_name, &new_branch_name);
     ++		if (!no_name_prefix)
     ++			add_branch_prefix(name_prefix, start_name, &new_branch_name);
     + 		strbuf_addstr(&new_branch_name, branch_name);
       
       		if (recurse_submodules)
     - 			create_branches_recursively(the_repository, new_branch_name.buf,
      
       ## t/t3200-branch.sh ##
     -@@ t/t3200-branch.sh: test_expect_success 'create branch with prefix' '
     - 	git branch branch-with-prefix &&
     - 	git checkout branch-with-prefix &&
     - 	git branch branch-with-prefix &&
     -+	git branch branch-with-no-prefix --no-prefix &&
     +@@ t/t3200-branch.sh: test_expect_success 'create branch with --name-prefix' '
     + 	git switch blob-with-prefix &&
     + 	git branch --name-prefix "@{current}" -- -with-prefix &&
     + 	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
     ++	git branch --name-prefix "blob" --no-name-prefix branch-with-no-prefix &&
       	test_ref_exists refs/heads/branch-with-prefix &&
     - 	test_ref_exists refs/heads/main-branch-with-prefix &&
     --	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix
     -+	test_ref_exists refs/heads/branch-with-prefix-branch-with-prefix &&
     -+	test_ref_exists refs/heads/branch-with-no-prefix
     + 	test_ref_exists refs/heads/main-with-prefix &&
     + 	test_ref_exists refs/heads/blob-with-prefix &&
     + 	test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
     ++	test_ref_exists refs/heads/branch-with-no-prefix &&
     + 	git checkout main &&
     + 	git branch -D branch-with-prefix main-with-prefix blob-with-prefix &&
     +-	git branch -D blob-with-prefix-with-prefix
     ++	git branch -D blob-with-prefix-with-prefix branch-with-no-prefix
     + '
     + 
     + test_expect_success 'create branch with config prefix' '
     +@@ t/t3200-branch.sh: test_expect_success 'create branch with config prefix' '
     + 	test_config branch.namePrefix "@{current}" &&
     + 	git checkout main &&
     + 	git branch -- -with-prefix &&
     ++	git branch --no-name-prefix branch-with-no-prefix &&
     + 	test_ref_exists refs/heads/blob-with-prefix &&
     + 	test_ref_exists refs/heads/main-with-prefix &&
     +-	git branch -D blob-with-prefix main-with-prefix
     ++	test_ref_exists refs/heads/branch-with-no-prefix &&
     ++	git branch -D blob-with-prefix main-with-prefix branch-with-no-prefix
       '
       
       test_done

-- 
gitgitgadget
