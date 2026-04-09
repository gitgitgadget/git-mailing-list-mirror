Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF73B6379
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775731394; cv=none; b=qYOrgbwjLDKunNUQalLWH2GJh48V2Z74BQ/OskDmLZ2YfHPnXaDf7mfTBnnYtujnIBsp16+vA/k3TgfXM25utDorzOxEaKx/ZdrafT499RqAnaX9xGNmjKuyQ22DeTd0FTKVriZr2bC3yGeqOJblWoy7k5URiGc90sBSuf47DaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775731394; c=relaxed/simple;
	bh=BBAIqt0t4LysbJQILHTVIIfXdnHUHJPCwuXgPqG0Gaw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qjZ1EX9DsGchM2qBmy8a0lstZbkZqK1R8gsdtuMOX9MmF5pMItTPFyC5b1RkryJjFqJgrhNIMzbkt+3guAmIzFfqXMOXua8Hc1F3lbdwupb0K0BFOesxhsTbU8bLSG6lRHPCDZEhRR5g9Ki/sSdL8jvZCrTIFT3oRyXsZNR6PMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0xgjUv9; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0xgjUv9"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a7bbe9d0so6102541cf.0
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 03:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775731391; x=1776336191; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hYfPaWSJ0J08dbV8dqdFq+C41sFzxB7yeU1HRVYMOf8=;
        b=T0xgjUv9C/0qDt/2ubHJXbCG7/WJKXVY2Ys3k/+aeIx5/MvWFVU3GWEA+m8cYASqty
         aDZWIgy+fV4pASc6sfve8RmCYs6GOnBktnJ+UIM1UhCQwJ8F6FevMGfv/u8zxX73jwI9
         hnuR71Zj6WmeeTYDFfB2nwaw3vc/BjgeAjtNtgiWUz/5bzTv2SWum+Nq5IUbvpz2zvwb
         H0p8YCwXwVoMIaLZTXztmmJ+Ik4Q47BRTCFSPA6DzXea7KSI2ggGRfGqef/xOSmoEBW5
         FPXX1wNdQtbfIbJgTH/ZZQL/LGUlW1GcbOysNsTju17FCjDSf2hNlI6qIHdnyX7pQge7
         G3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775731391; x=1776336191;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hYfPaWSJ0J08dbV8dqdFq+C41sFzxB7yeU1HRVYMOf8=;
        b=RRFEsCx8px1HqhF8e5t3/VoLxvtPthQJllR1QhMDQnHPQYqyZcuM51ZuSrOuaaR7Bg
         JHPeFLFuowL+w59kzLCcLTQdjie1iHEy0liBYjnamU/C9U1W2KuW1S+fi3QmjfjbqP9t
         FSh3ozmE/y/ebhX6xGW0dL5rvaNDxCfx5pRJ3ZzZe1yx9MeRL3OplXe5xW/vGE1lIFkP
         XXjtJ612tyM7P9xcSZFudByxiJYxF+o+Gpp/TEMhUXfwnyoD5p1awBEa+aWzudQW+Blg
         tGFSIBAXYrKlvR/RE2MW40vw83cD0Ugq0ftrXM4h9553YYcCQqneQPLZAa/rk3SlLe1C
         Sgag==
X-Gm-Message-State: AOJu0YzxpIp2i6Bc1TGMr8gPS36ql3+A/6mxD5IiTDJw2EFsNrany1il
	ep89pZZUHV+YXMM5zdSuICF8e4h/nbyLunv3OxNjhB52aOxVtVA5+Dgp8pomOQ==
X-Gm-Gg: AeBDietziUsISUol9eSVw4eEsQtS8nN1GOlIuY1tb17i/vPkrizw1iW/+cmPEhhfZv+
	oL2ZssWnw/JhdiGpyQ4UWaMrzX0Pg+O2zdIvoJrL/OF1JmT1ZmlHCHm3lhS6cUeikRW5y1z6r9y
	TfUZorU1Kb8ARAczqA2rJo3P0bwBLB6BIBbChTK6ekC6OQGJEidXLnU+4DdMkOJ24SLElUrylYa
	Pm4XtjBj+sLMwGZlna4AkBVe8zaI1+bU3aZThfrWVjx2mqcGo5KvevZxeZ0rmwVWKhECZT3t+d3
	YKNFifwGHDEabHNlqmh9bVJznyRJLgUlfKcMJM1PBxehtBCQJZIKKoysbkUcXZ31c8EROAByGEZ
	5dokZRL/DOTXl7yQcOP1QAzUcrYMmqsYYLABRLkiyHvZwY/o1fBOB06wvY5jJIT/tn75+QA8AGp
	0Stm7S6eQEUF4VIVtqIyvrfADOCxQl/5vTNeYa
X-Received: by 2002:ac8:5a0c:0:b0:50d:7f60:621f with SMTP id d75a77b69052e-50d7f6065demr281580681cf.29.1775731391257;
        Thu, 09 Apr 2026 03:43:11 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.28.177])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50d4b1a05a2sm182123221cf.2.2026.04.09.03.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 03:43:10 -0700 (PDT)
Message-Id: <pull.2202.v4.git.git.1775731390.gitgitgadget@gmail.com>
In-Reply-To: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
References: <pull.2202.v3.git.git.1772802872.gitgitgadget@gmail.com>
From: "Yoann Valeri via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:43:08 +0000
Subject: [PATCH v4 0/2] branch: add prefixes to new branch names
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
    Eric Sunshine <sunshine@sunshineco.com>,
    Yoann Valeri <yoann.valeri@cea.fr>

This PR adds a way to add prefixes to a new branch being created. The goal
is mostly to ease the developer process of creating new branches by adding
shortcuts that can be set either with a command-line option or with
configuration parameter. This is useful especially when you have to do
similar backports on multiple branches, removing a bit of the need for
finding names or typing the names over and over again.

One instance of where this feature would be useful is for software stacks
based on distribution versions (for instance the Ocean software stack for
HPC centers https://ocean.eupex.eu/). Here, stacks for the different
versions are organized in git branches, one per versions. Since multiple
softwares will go on multiple version branches, we have to create the same
package for each of those version branches, which result one work branch per
version branch. For instance, if we want to update a package for AlmaLinux
8.10, we have to create another branch specifically for that package and
that version. Therefore, if we have a lot of version branches to update,
that means double the work branches, and specifying each time the version
branch the work branch is based on becomes annoying and can be error prone.
That is especially true if many people (around 40 for the Ocean stack) work
on this stack.

So I propose this new feature to simplify this process. While it could be
done with a script or an alias, both of those require either the developer
to share the script or to create it, or to define an alias they may forget.
Hence, an even easier way to ease the process is with this configuration
parameter which is a one and done deal.

Changes since v1:

 * Added a '--no-prefix' option to git branch

Changes since v2:

 * Changed the PR structure, with 3 patches:
   * first patch adds the '--name-prefix' option
   * second adds the 'branch.namePrefix' configuration parameter
   * third adds the '--no-name-prefix' option
 * Those patches only target 'git branch' now

Changes since v3:

 * Changed the PR structure, with 2 patches:
   * first patch adds the '--[no-]name-prefix' option
   * second adds the 'branch.namePrefix' configuration parameter
 * Fixed the different issues pointed out by reviewers, especially regarding
   option/configuration management

VALERI Yoann (2):
  branch: add '--name-prefix' option
  branch: add 'branch.namePrefix' config param

 Documentation/config/branch.adoc |  6 ++++
 Documentation/git-branch.adoc    | 11 +++++-
 branch.c                         | 57 ++++++++++++++++++++++++++++++++
 branch.h                         | 12 +++++++
 builtin/branch.c                 | 29 ++++++++++++----
 t/t3200-branch.sh                | 39 ++++++++++++++++++++++
 6 files changed, 146 insertions(+), 8 deletions(-)


base-commit: 256554692df0685b45e60778b08802b720880c50
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2202%2Fvaleriyoann%2Fbranch-with-prefix-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2202/valeriyoann/branch-with-prefix-v4
Pull-Request: https://github.com/git/git/pull/2202

Range-diff vs v3:

 1:  6cbb950d8b ! 1:  322f94d121 branch: add '--name-prefix' option
     @@ Documentation/git-branch.adoc: git branch [--color[=<when>] | --no-color] [--sho
       git branch [--track[=(direct|inherit)] | --no-track] [-f]
      -	   [--recurse-submodules] <branch-name> [<start-point>]
      +	   [--recurse-submodules] [--name-prefix=<token>]
     -+           <branch-name> [<start-point>]
     ++	   <branch-name> [<start-point>]
       git branch (--set-upstream-to=<upstream>|-u <upstream>) [<branch-name>]
       git branch --unset-upstream [<branch-name>]
       git branch (-m|-M) [<old-branch>] <new-branch>
     @@ Documentation/git-branch.adoc: Note that this will create the new branch, but it
       new branch.
       
      +With a `--name-prefix` option, you can add a prefix to the branch to create.
     -+This can either a simple name, or a token. Currently, only '@{current}' is
     -+managed as token, and will use the current branch name as prefix.
     ++This can either be a simple name, or a token. Currently, only '@{current}' is
     ++supported as token, and will use the current branch name as prefix.
      +
       When a local branch is started off a remote-tracking branch, Git sets up the
       branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
     @@ branch.c: int read_branch_desc(struct strbuf *buf, const char *branch_name)
       	return 0;
       }
       
     -+void add_branch_prefix(const char *name_prefix,
     -+					   const char *current_branch, struct strbuf *buf)
     ++static char *get_current_branch_name(void)
      +{
     -+	int value = 0;
     ++	const char *const prefix = "refs/heads/";
     ++	struct object_id rev;
     ++	const char *p;
     ++	char *output;
     ++	char *path;
     ++	int flag;
      +
     ++	path = refs_resolve_refdup(get_main_ref_store(the_repository),
     ++							   "HEAD", 0, &rev, &flag);
     ++	if (!path) {
     ++		warning(_("Failed to get the current branch's path"));
     ++		return NULL;
     ++	} else if (!(flag & REF_ISSYMREF)) {
     ++		FREE_AND_NULL(path);
     ++		warning(_("Failed to get the current branch's name"));
     ++		return NULL;
     ++	}
     ++
     ++	if (skip_prefix(path, prefix, &p)) {
     ++		output = xstrdup(p);
     ++		free(path);
     ++		return output;
     ++	}
     ++
     ++	warning(_("Failed to get the current branch's name"));
     ++	return NULL;
     ++}
     ++
     ++int add_branch_prefix(const char *name_prefix, struct strbuf *buf)
     ++{
      +	if (!name_prefix)
     -+		return;
     ++		return 0;
      +
      +	if (name_prefix[0] != '@') {
      +		strbuf_addstr(buf, name_prefix);
     -+		return;
     ++		return 0;
     ++	}
     ++
     ++	if (strcmp(name_prefix, "@{current}") == 0) {
     ++		char *current_branch_name = get_current_branch_name();
     ++
     ++		if (!current_branch_name)
     ++			return 1;
     ++
     ++		strbuf_addstr(buf, current_branch_name);
     ++		free(current_branch_name);
     ++	} else {
     ++		advise(_("Token '%s' unrecognized, only '@{current}' is managed currently"),
     ++			   name_prefix);
     ++		return 1;
      +	}
      +
     -+	if (strcmp(name_prefix, "@{current}") == 0)
     -+		strbuf_addstr(buf, current_branch);
     ++	return 0;
      +}
      +
       /*
     @@ branch.h: int install_branch_config(int flag, const char *local, const char *ori
      + * string 'name_prefix'. It can either be a simple string to a shorthand
      + * starting with '@'.
      + *
     -+ * Currently, only '@{current}' is managed, and will use 'current_branch' as
     -+ * prefix.
     ++ * Currently, only '@{current}' is managed, and will retrieve the current branch
     ++ * to use as prefix.
     ++ *
     ++ * Return 1 if the function failed to set the branch prefix, 0 otherwise.
      + */
     -+void add_branch_prefix(const char *name_prefix, const char *current_branch,
     -+					   struct strbuf *buf);
     -+
     ++int add_branch_prefix(const char *name_prefix, struct strbuf *buf);
      +
       /*
        * Check if a branch is checked out in the main worktree or any linked
     @@ builtin/branch.c
      @@ builtin/branch.c: int cmd_branch(int argc,
       	struct string_list sorting_options = STRING_LIST_INIT_DUP;
       	struct ref_format format = REF_FORMAT_INIT;
     + 	struct repo_config_values *cfg = repo_config_values(the_repository);
     ++	char *name_prefix = NULL;
       	int ret;
     -+	const char *name_prefix = NULL;
       
       	struct option options[] = {
     - 		OPT_GROUP(N_("Generic options")),
      @@ builtin/branch.c: int cmd_branch(int argc,
       		OPT_BOOL('i', "ignore-case", &icase, N_("sorting and filtering are case insensitive")),
       		OPT_BOOL(0, "recurse-submodules", &recurse_submodules_explicit, N_("recurse through submodules")),
     @@ builtin/branch.c: int cmd_branch(int argc,
       		const char *branch_name = argv[0];
       		const char *start_name = argc == 2 ? argv[1] : head;
      +		struct strbuf new_branch_name = STRBUF_INIT;
     ++		int rc;
       
       		if (filter.kind != FILTER_REFS_BRANCHES)
       			die(_("the -a, and -r, options to 'git branch' do not take a branch name.\n"
     @@ builtin/branch.c: int cmd_branch(int argc,
       
      -		if (recurse_submodules) {
      -			create_branches_recursively(the_repository, branch_name,
     -+		add_branch_prefix(name_prefix, start_name, &new_branch_name);
     ++		rc = add_branch_prefix(name_prefix, &new_branch_name);
     ++		if (rc)
     ++			die(_("Failed to add a branch prefix to '%s'"), branch_name);
     ++
      +		strbuf_addstr(&new_branch_name, branch_name);
      +
      +		if (recurse_submodules)
     @@ t/t3200-branch.sh: test_expect_success 'errors if given a bad branch name' '
       '
       
      +test_expect_success 'create branch with --name-prefix' '
     -+	git config branch.autosetupmerge false &&
     ++	test_config branch.autosetupmerge false &&
      +	git branch branch-with-prefix &&
     ++	test_ref_exists refs/heads/branch-with-prefix &&
      +	git branch --name-prefix "blob" -- -with-prefix &&
     ++	test_ref_exists refs/heads/blob-with-prefix &&
      +	test_must_fail git branch --name-prefix "blob" -- -with-prefix &&
      +	git branch --name-prefix "@{current}" -- -with-prefix &&
     ++	test_ref_exists refs/heads/main-with-prefix &&
      +	git switch blob-with-prefix &&
      +	git branch --name-prefix "@{current}" -- -with-prefix &&
     -+	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
     -+	test_ref_exists refs/heads/branch-with-prefix &&
     -+	test_ref_exists refs/heads/main-with-prefix &&
     -+	test_ref_exists refs/heads/blob-with-prefix &&
      +	test_ref_exists refs/heads/blob-with-prefix-with-prefix &&
     ++	test_must_fail git branch --name-prefix "@{current}" -- -with-prefix &&
     ++	git branch --name-prefix "blob" --no-name-prefix branch-with-no-prefix &&
     ++	test_ref_exists refs/heads/branch-with-no-prefix &&
      +	git checkout main &&
     ++	test_config alias.bn "branch --name-prefix=blob" &&
     ++	git bn --no-name-prefix bn-with-no-prefix &&
     ++	test_ref_exists refs/heads/bn-with-no-prefix &&
      +	git branch -D branch-with-prefix main-with-prefix blob-with-prefix &&
     -+	git branch -D blob-with-prefix-with-prefix
     ++	git branch -D blob-with-prefix-with-prefix branch-with-no-prefix &&
     ++	git branch -D bn-with-no-prefix
      +'
      +
       test_done
 2:  d51f71708c ! 2:  80d1ffde9d branch: add 'branch.namePrefix' config param
     @@ Documentation/config/branch.adoc: This option defaults to `never`.
      +`branch.namePrefix`::
      +	When a new branch is created with `git branch`, use the provided value as
      +	prefix for its name. Can be '@{current}' to use the current branch's name
     -+	as prefix.
     ++	as prefix. This value can be overriden by using the '--[no-]name-prefix'
     ++	option of `git branch`.
      +
       `branch.<name>.remote`::
       	When on branch _<name>_, it tells `git fetch` and `git push`
       	which remote to fetch from or push to.  The remote to push to
      
     - ## branch.c ##
     -@@ branch.c: int read_branch_desc(struct strbuf *buf, const char *branch_name)
     - void add_branch_prefix(const char *name_prefix,
     - 					   const char *current_branch, struct strbuf *buf)
     - {
     --	int value = 0;
     -+	char *config_prefix = NULL;
     + ## builtin/branch.c ##
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 	struct ref_format format = REF_FORMAT_INIT;
     + 	struct repo_config_values *cfg = repo_config_values(the_repository);
     + 	char *name_prefix = NULL;
     ++	char *safekeep_name_prefix;
     + 	int ret;
       
     --	if (!name_prefix)
     --		return;
     -+	if (!name_prefix) {
     -+		if (repo_config_get_string(the_repository, "branch.namePrefix",
     -+								   &config_prefix))
     -+			return;
     + 	struct option options[] = {
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 	else if (!skip_prefix(head, "refs/heads/", &head))
     + 		die(_("HEAD not found below refs/heads!"));
       
     --	if (name_prefix[0] != '@') {
     --		strbuf_addstr(buf, name_prefix);
     --		return;
     -+		name_prefix = config_prefix;
     - 	}
     - 
     --	if (strcmp(name_prefix, "@{current}") == 0)
     -+	if (name_prefix[0] != '@')
     -+		strbuf_addstr(buf, name_prefix);
     -+	else if (strcmp(name_prefix, "@{current}") == 0)
     - 		strbuf_addstr(buf, current_branch);
     ++	repo_config_get_string(the_repository, "branch.namePrefix", &name_prefix);
     ++	safekeep_name_prefix = name_prefix;
      +
     -+    free(config_prefix);
     - }
     + 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
     + 			     0);
     + 
     +@@ builtin/branch.c: int cmd_branch(int argc,
     + 	ret = 0;
       
     - /*
     + out:
     ++	free(safekeep_name_prefix);
     + 	string_list_clear(&sorting_options, 0);
     + 	return ret;
     + }
      
       ## t/t3200-branch.sh ##
      @@ t/t3200-branch.sh: test_expect_success 'create branch with --name-prefix' '
     - 	git branch -D blob-with-prefix-with-prefix
     + 	git branch -D bn-with-no-prefix
       '
       
      +test_expect_success 'create branch with config prefix' '
     ++	test_config branch.autosetupmerge false &&
      +	test_config branch.namePrefix blob &&
      +	git branch -- -with-prefix &&
     ++	test_ref_exists refs/heads/blob-with-prefix &&
      +	test_must_fail git branch -- -with-prefix &&
      +	test_config branch.namePrefix "@{current}" &&
      +	git checkout main &&
      +	git branch -- -with-prefix &&
     -+	test_ref_exists refs/heads/blob-with-prefix &&
      +	test_ref_exists refs/heads/main-with-prefix &&
     -+	git branch -D blob-with-prefix main-with-prefix
     ++	git branch --no-name-prefix branch-with-no-prefix &&
     ++	test_ref_exists refs/heads/branch-with-no-prefix &&
     ++	git branch -D blob-with-prefix main-with-prefix branch-with-no-prefix
      +'
      +
       test_done
 3:  8f45374007 < -:  ---------- branch: add '--no-name-prefix' option

-- 
gitgitgadget
