Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D9543F08F
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011636; cv=none; b=ReGDHNpbr6qz8ehZrJeYS12lOuxCRQPVX1q94MN9f3LkmcFbmKZtFS1UDwLqRGlFC3bH18/Xn+Penjno2hTIVHUBZevfMwDM1EASu3ol6QCAzwiMfc3TxB/MQ8bdlJzWWufftCzX92uqOfA2przfb/qAUAPjncuRfKaeJXB2uNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011636; c=relaxed/simple;
	bh=D541fbmwKXiWq8TY7Tz5w476skCnMlIRLEuvzOWOC+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QI+toyGB/KcPh1j3vwQ2AFKvhiS8LvjUScngsShud+IHFHwSWq5wGY8LsItpzA97VrMZdc09nOXMLHvA2S7tn16sMG8uAoWBBNojg4/tCp8DG5LXAVKQGUzyuSyMbmKc9N5dOha6PgHG+dmYQTgZIThJxYXl3y6G/Cek2XVd9VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EqxqpkUw; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqxqpkUw"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1460284a91.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011633; x=1786616433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ujk+iFriS+sGqY0hJX56s059lDclrpgsU3Vdl4Lmg+8=;
        b=EqxqpkUwDecoECZYCyvizeGq46MrDT1AvmTp29VzhIBYSQ7/kOKzmSTVxl3NSI+d3P
         R08ER9PMhCCtOcsUnuI+fC9VGgAoLMCT58ci9H3pctecujOVM1nx8jI9F2XynCnnzmUe
         jUyg2cTz5uCHZSvtWdmzWwAwmTBLVBRuqGjNL6CfmIE33spMSZzeP9pt0wSg9Z7EFjMf
         eIW98RfGUTDx+vNg+tLcuEsgAc0ghbxVfaBWnSOkVxnbaa8rmk0sscmq+WaLNsmzyZWi
         wyWSFA6Vl5pWE/Jkjn+Cd3CJ8o1b1EooXiAftCmXGgudO0u1XQQ6/S1bGxBTvwCEo+cA
         Nv3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011633; x=1786616433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ujk+iFriS+sGqY0hJX56s059lDclrpgsU3Vdl4Lmg+8=;
        b=Nm9zZtFuQOJkDksFUsEDfnfBjA9cF59vCG5mUdZuy75nwKtNQrmTFuQYG8KpJEMQNd
         +c6dY5C+u5MjsMz8Oa2GlvxI3do+TueNLGdYvGvbPw51Ae1dVbKMzSnkiIINHaTo2UCh
         NMXZ0IBBu4wr3ScUcpS40avL3QpzbP/8A20KhOuUtSzwxsTLRc+oj7r0Xtr5JnWmG5K1
         DUVW08DdLtAx5/28Q2zpw9wi/oXKGJWG39MDDU+bUGML0b0mmJnUZzQkNpXeoC0iXH81
         487GwTj2Zg54iewz0wCpc5kD91oVzRVb7g9B3Ny0D2lYuJPNjqGZS+qRJZAS1vJF8MDK
         r0XQ==
X-Gm-Message-State: AOJu0Yx+TVfN6ASIZCDxWEF4f+p0/6/9L4mL8xx84gRrs3yl3C/TQ8Wz
	MmWXUegJ3meVe3yavA1i3iDMp7sTmriqeftfxENQoz89FGslWZhXL50m
X-Gm-Gg: AR+sD12nq7CjCt8houLzuxHOKCUq6KWtfA0+USmoooFYqS4DXRpdKHKDP8Eda8NPhMH
	fjkGvK9R+UM98Z5dPM+493De3SGl4jLvv6vu8yziNUQsL4z3uT0lk+3wXXa/EgZCYi9MTD2z3qP
	TR1e1ZrSBSBPzGKilaHiVqr8bjZixZpZWBLkr808TUVZLivcbYf4BFSZMRKVzSAAWvyJ/bKRlGN
	a8/RUs3kleTy30oFBKdW2+UHbQPbCCHWOh9OUkKcfODJXQVqyO0hBrhipDGr+Vq1VYREbrfWzRv
	Wvz3/FIutQYIObAnLVhndHKO4j9iixBiw5riOgpxnTS0hBGptZbUS6oA0iI3ZEnwrISPIdiMMnp
	wpk1YxEh/F79X1XSExn93MKeTOAEzvuzsrUpmnWVVF+q94lGeyrTdDKpkZIJV77oVsBs3eYX2py
	Qo/0gQfQQryc2WZUJH3q0+vPQND4ZB3ygkr62Hk185Avu9Z3u7SbL8GcW3d0ADUQ1wQRsJCEJ/+
	NRgLjXAiaT95Q2l6W4iRGH9vsDNlK+5U+I4NVsGBEyNxOt2EW+AJccvayI8amQUbWyCn2E=
X-Received: by 2002:a17:90b:520a:b0:38f:efed:5445 with SMTP id 98e67ed59e1d1-3903c54adafmr13889664a91.4.1786011632827;
        Thu, 06 Aug 2026 03:20:32 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b76cfsm25525901eec.4.2026.08.06.03.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:20:32 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC PATCH v4 0/7] repo: add more path keys to git repo info
Date: Thu,  6 Aug 2026 15:45:49 +0530
Message-ID: <20260806101556.162940-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.55.GIT
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Series adds keys to git repo info.

Keys output paths of repository components:
* path.toplevel: repository tree.
* path.superproject-root: superproject tree from submodules.
* path.hooks: repository hooks.
* path.index: repository index.
* path.grafts: repository grafts.
* path.git-prefix: prefix offset.

The patch also removes an unused header.

Keys support suffixes for format.
Commits contain documentation and tests.

Changes since v3:
* The prefix member has been shifted from startup_info to repo,
  therefore we now omit the header and use repo->prefix everywhere.
  Development of these patches is now based on the latest branch.

* Since strbuf is NUL-terminated, remove all
  `strbuf_addstr(buf, "");` lines from the patches.

* Add relative-path test cases alongside the existing absolute-path
  test cases wherever we don't use the existing helper.

* Renamed `superproject-working-tree` to `superproject-root` because
  I feel the latter is a bit clearer. That said, I'm happy with
  either name, so if you prefer `superproject-working-tree`, I'm
  perfectly fine reverting it.

* Changed almost all the commit messages to make them not overly
  specific.

* Dropped `path.objects` from this series. During a sync discussion
  with my mentors, we concluded that this key should wait, since the
  object database's on-disk layout is expected to change
  significantly as pluggable ODB backends are introduced.

* Removed `repo->prefix` from the absolute path functions (the
  absolute-path variants now pass "" instead).

* Added a `/dev/null` test case for `core.hooksPath`, guarded against
  MINGW since /dev/null doesn't resolve to a real canonicalizable
  path on Windows.

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  repo: add path.superproject-root with absolute and relative suffixes
  repo: add path.hooks with absolute and relative suffixes
  repo: add path.index with absolute and relative suffixes
  repo: add path.grafts with absolute and relative suffixes
  repo: add path.git-prefix
  repo: remove unused setup.h include

 Documentation/git-repo.adoc |  57 +++++++++++++
 builtin/repo.c              | 137 +++++++++++++++++++++++++++++++-
 t/t1900-repo-info.sh        | 154 +++++++++++++++++++++++++++++++++++-
 3 files changed, 345 insertions(+), 3 deletions(-)

Range-diff against v3:
1:  baed121c74 ! 1:  3880485020 repo: add path.toplevel with absolute and relative suffix formatting
    @@ Commit message
     
         Scripts frequently need to find the root directory of a repository's
         working tree. Currently, this requires using `git rev-parse --show-toplevel`
    -    or inferring it from other path components.
    +    or inferring it from other repository information.
     
         Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
         to `git repo info`. This allows scripts to retrieve the top-level
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +{
     +	const char *work_tree = repo_get_work_tree(repo);
     +
    -+	if (!work_tree) {
    -+		strbuf_addstr(buf, "");
    ++	if (!work_tree)
     +		return 0;
    -+	}
     +
    -+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +{
     +	const char *work_tree = repo_get_work_tree(repo);
     +
    -+	if (!work_tree) {
    -+		strbuf_addstr(buf, "");
    ++	if (!work_tree)
     +		return 0;
    -+	}
     +
    -+	format_path(buf, work_tree, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
     +	)
     +'
     +
    -+test_expect_success 'path.toplevel returns empty in a bare repository' '
    ++test_expect_success 'path.toplevel absolute and relative in a bare repository' '
     +	test_when_finished "rm -rf bare.git" &&
     +	git init --bare bare.git &&
     +	(
     +		cd bare.git &&
    -+		echo "path.toplevel.absolute=" >expect &&
    -+		git repo info path.toplevel.absolute >actual &&
    -+		test_cmp expect actual
    ++
    ++		echo "path.toplevel.absolute=" >expect.abs &&
    ++		git repo info path.toplevel.absolute >actual.abs &&
    ++		test_cmp expect.abs actual.abs &&
    ++
    ++		echo "path.toplevel.relative=" >expect.rel &&
    ++		git repo info path.toplevel.relative >actual.rel &&
    ++		test_cmp expect.rel actual.rel
     +	)
     +'
     +
2:  2f363b6358 ! 2:  1b7b0d286c repo: add path.superproject-working-tree with absolute and relative suffixes
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.superproject-working-tree with absolute and relative suffixes
    +    repo: add path.superproject-root with absolute and relative suffixes
     
         Scripts working in multi-repository setups often need to identify the
         top-level working tree of a superproject from within a submodule.
         Currently, this is only exposed via `git rev-parse
         --show-superproject-working-tree`.
     
    -    Introduce `path.superproject-working-tree.absolute` and
    -    `path.superproject-working-tree.relative` keys to `git repo info`.
    +    Introduce `path.superproject-root.absolute` and
    +    `path.superproject-root.relative` keys to `git repo info`.
         This exposes the core submodule context via a scriptable config-like key
         using standard format rules.
     
    @@ Documentation/git-repo.adoc: values that they return:
      `path.gitdir.relative`::
      	The path to the Git repository directory relative to the current working directory.
      
    -+`path.superproject-working-tree.absolute`::
    ++`path.superproject-root.absolute`::
     +	The canonical absolute path to the working tree root of the superproject
     +	if the current repository is an initialized submodule. Outputs an empty
     +	string if not in a submodule.
     +
    -+`path.superproject-working-tree.relative`::
    ++`path.superproject-root.relative`::
     +	The path to the working tree root of the superproject relative to the
     +	current working directory if the current repository is an initialized
     +	submodule. Outputs an empty string if not in a submodule.
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +
     +	if (!get_superproject_working_tree(&superproject)) {
     +		strbuf_release(&superproject);
    -+		strbuf_addstr(buf, "");
     +		return 0;
     +	}
     +
    -+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
     +	strbuf_release(&superproject);
     +	return 0;
     +}
     +
    -+static int get_path_superproject_relative(struct repository *repo UNUSED, struct strbuf *buf)
    ++static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
     +	if (!get_superproject_working_tree(&superproject)) {
     +		strbuf_release(&superproject);
    -+		strbuf_addstr(buf, "");
     +		return 0;
     +	}
     +
    -+	format_path(buf, superproject.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
     +	strbuf_release(&superproject);
     +	return 0;
     +}
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.commondir.relative", get_path_commondir_relative },
      	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    -+	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
    -+	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
    ++	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    ++	{ "path.superproject-root.relative", get_path_superproject_relative },
      	{ "path.toplevel.absolute", get_path_toplevel_absolute },
      	{ "path.toplevel.relative", get_path_toplevel_relative },
      	{ "references.format", get_references_format },
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_expect_success 'path.superproject-working-tree absolute and relative' '
    ++test_expect_success 'path.superproject-root absolute and relative' '
     +	test_when_finished "rm -rf sub super" &&
     +	git init sub &&
     +	test_commit -C sub initial &&
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
     +		cd sub &&
     +		ROOT="$(test-tool path-utils real_path ..)" &&
     +
    -+		echo "path.superproject-working-tree.absolute=$ROOT" >expect.abs &&
    -+		git repo info path.superproject-working-tree.absolute >actual.abs &&
    ++		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
    ++		git repo info path.superproject-root.absolute >actual.abs &&
     +		test_cmp expect.abs actual.abs &&
     +
    -+		echo "path.superproject-working-tree.relative=../" >expect.rel &&
    -+		git repo info path.superproject-working-tree.relative >actual.rel &&
    ++		echo "path.superproject-root.relative=../" >expect.rel &&
    ++		git repo info path.superproject-root.relative >actual.rel &&
     +		test_cmp expect.rel actual.rel
     +	)
     +'
     +
    -+test_expect_success 'path.superproject-working-tree returns empty when not in a submodule' '
    ++test_expect_success 'path.superproject-root returns empty when not in a submodule' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
    -+		echo "path.superproject-working-tree.absolute=" >expect &&
    -+		git repo info path.superproject-working-tree.absolute >actual &&
    -+		test_cmp expect actual
    ++
    ++		echo "path.superproject-root.absolute=" >expect.abs &&
    ++		git repo info path.superproject-root.absolute >actual.abs &&
    ++		test_cmp expect.abs actual.abs &&
    ++
    ++		echo "path.superproject-root.relative=" >expect.rel &&
    ++		git repo info path.superproject-root.relative >actual.rel &&
    ++		test_cmp expect.rel actual.rel
     +	)
     +'
     +
4:  e3facc7989 ! 3:  517f621eb0 repo: add path.hooks with absolute and relative suffix formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.hooks with absolute and relative suffix formatting
    +    repo: add path.hooks with absolute and relative suffixes
     
    -    External tool integrations and validation systems need a stable way to
    -    identify where the repository hooks are stored. Currently, this involves
    -    relying on `git rev-parse --git-path hooks` or querying `core.hooksPath`
    -    manually.
    +    Hooks are an integral part of a repository's configuration and are
    +    commonly used by tooling to automate repository-specific workflows.
    +    Currently, scripts typically retrieve the hooks directory by invoking
    +    `git rev-parse --git-path hooks`.
     
         Introduce `path.hooks.absolute` and `path.hooks.relative` keys to
    -    `git repo info`. This allows tools to discover the active hooks location
    -    natively, ensuring proper resolution regardless of whether Git is using
    -    the standard `.git/hooks` structure or a custom `core.hooksPath` setup.
    +    `git repo info`. This exposes the hooks directory as a scriptable
    +    config-like key using standard format rules, allowing scripts to
    +    retrieve it through the same interface as other repository path
    +    information.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc: values that they return:
      
     +`path.hooks.absolute`::
     +	The canonical absolute path to the repository's hooks directory.
    -+	Respects `core.hooksPath` configuration adjustments.
    ++	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
    ++	set to `/dev/null`, that value is returned unchanged.
     +
     +`path.hooks.relative`::
     +	The path to the repository's hooks directory relative to the current
    -+	working directory. Respects `core.hooksPath` configuration adjustments.
    ++	working directory. Respects the `core.hooksPath` configuration.
     +
    - `path.objects.absolute`::
    - 	The canonical absolute path to the repository's object database directory.
    - 	Respects the `GIT_OBJECT_DIRECTORY` environment override.
    + `path.superproject-root.absolute`::
    + 	The canonical absolute path to the working tree root of the superproject
    + 	if the current repository is an initialized submodule. Outputs an empty
     
      ## builtin/repo.c ##
     @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	struct strbuf hooks_path = STRBUF_INIT;
     +
     +	repo_git_path_replace(repo, &hooks_path, "hooks");
    -+	format_path(buf, hooks_path.buf, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
     +	strbuf_release(&hooks_path);
     +	return 0;
     +}
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	struct strbuf hooks_path = STRBUF_INIT;
     +
     +	repo_git_path_replace(repo, &hooks_path, "hooks");
    -+	format_path(buf, hooks_path.buf, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
     +	strbuf_release(&hooks_path);
     +	return 0;
     +}
     +
    - static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
      {
    - 	const char *obj_dir = repo_get_object_directory(repo);
    + 	struct strbuf superproject = STRBUF_INIT;
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.commondir.relative", get_path_commondir_relative },
      	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
     +	{ "path.hooks.absolute", get_path_hooks_absolute },
     +	{ "path.hooks.relative", get_path_hooks_relative },
    - 	{ "path.objects.absolute", get_path_objects_absolute },
    - 	{ "path.objects.relative", get_path_objects_relative },
    - 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
    + 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    + 	{ "path.superproject-root.relative", get_path_superproject_relative },
    + 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
     
      ## t/t1900-repo-info.sh ##
    +@@ t/t1900-repo-info.sh: test_repo_info_path () {
    + 			cd repo/sub &&
    + 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
    + 			eval "$init_command" &&
    +-			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
    ++			case "$expected_dir" in
    ++			/*) EXPECT_ABS="$expected_dir" ;;
    ++			*) EXPECT_ABS="$ROOT/$expected_dir" ;;
    ++			esac &&
    ++			echo "path.$field_name.absolute=$EXPECT_ABS" >expect &&
    + 			git repo info "path.$field_name.absolute" >actual &&
    + 			test_cmp expect actual
    + 		)
    +@@ t/t1900-repo-info.sh: test_repo_info_path () {
    + 			cd repo/sub &&
    + 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
    + 			eval "$init_command" &&
    +-			echo "path.$field_name.relative=../$expected_dir" >expect &&
    ++			case "$expected_dir" in
    ++			/*) EXPECT_REL="$(test-tool path-utils relative_path "$expected_dir" "$PWD")" ;;
    ++			*) EXPECT_REL="../$expected_dir" ;;
    ++			esac &&
    ++			echo "path.$field_name.relative=$EXPECT_REL" >expect &&
    + 			git repo info "path.$field_name.relative" >actual &&
    + 			test_cmp expect actual
    + 		)
     @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_repo_info_path 'hooks standard fallback' 'hooks' '.git/hooks'
    ++test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
     +
     +test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
     +	'custom-hooks' \
     +	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
     +
    - test_repo_info_path 'objects standard' 'objects' '.git/objects'
    - 
    - test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
    ++# /dev/null is not a real, canonicalizable filesystem path on Windows,
    ++# so path resolution for core.hooksPath=/dev/null cannot be expected to
    ++# produce a literal "/dev/null" the way it does on POSIX systems.
    ++if ! test_have_prereq MINGW
    ++then
    ++	test_repo_info_path 'hooks with core.hooksPath=/dev/null' 'hooks' \
    ++		'/dev/null' \
    ++		'git config core.hooksPath /dev/null'
    ++fi
    ++
    + test_expect_success 'path.superproject-root absolute and relative' '
    + 	test_when_finished "rm -rf sub super" &&
    + 	git init sub &&
5:  ab157b8b49 ! 4:  37d28712de repo: add path.index with absolute and relative suffix formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.index with absolute and relative suffix formatting
    +    repo: add path.index with absolute and relative suffixes
     
    -    External script workflows and formatting layers require straightforward
    -    access to the location of the index staging file. Currently, tracking
    -    this necessitates a legacy call to `git rev-parse --git-path index` or
    -    `--show-toplevel` logic abstractions.
    +    The repository index is a fundamental component used by Git and related
    +    tooling to track the working tree state. Scripts that interact with the
    +    index currently retrieve its location by invoking
    +    `git rev-parse --git-path index`.
     
         Introduce `path.index.absolute` and `path.index.relative` keys to
    -    `git repo info`. This allows tooling utilities to discover the active
    -    index context cleanly while scaling transparently with localized
    -    `GIT_INDEX_FILE` environment overrides.
    +    `git repo info`. This exposes the index file location as a scriptable
    +    config-like key using standard format rules, allowing scripts to
    +    retrieve it through the same interface as other repository path
    +    information.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Commit message
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
      	The path to the repository's hooks directory relative to the current
    - 	working directory. Respects `core.hooksPath` configuration adjustments.
    + 	working directory. Respects the `core.hooksPath` configuration.
      
     +`path.index.absolute`::
     +	The canonical absolute path to the repository's current index file.
    -+	Respects the `GIT_INDEX_FILE` environment override. The returned path
    -+	reflects the configured/default index location regardless of whether the
    -+	repository is bare or whether the file currently exists.
    ++	Respects the `GIT_INDEX_FILE` environment override. Returns the
    ++	configured index path even if the repository is bare or the file does
    ++	not exist.
     +
     +`path.index.relative`::
     +	The path to the repository's current index file relative to the current
     +	working directory. Respects the `GIT_INDEX_FILE` environment override.
    -+	The returned path reflects the configured/default index location regardless
    -+	of whether the repository is bare or whether the file currently exists.
    ++	Returns the configured index path even if the repository is bare or the
    ++	file does not exist.
     +
    - `path.objects.absolute`::
    - 	The canonical absolute path to the repository's object database directory.
    - 	Respects the `GIT_OBJECT_DIRECTORY` environment override.
    + `path.superproject-root.absolute`::
    + 	The canonical absolute path to the working tree root of the superproject
    + 	if the current repository is an initialized submodule. Outputs an empty
     
      ## builtin/repo.c ##
     @@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
    @@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, stru
     +	if (!index_file)
     +		return error(_("unable to get index file"));
     +
    -+	format_path(buf, index_file, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, index_file, "", PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, stru
     +	if (!index_file)
     +		return error(_("unable to get index file"));
     +
    -+	format_path(buf, index_file, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, index_file, repo->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
    - static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
      {
    - 	const char *obj_dir = repo_get_object_directory(repo);
    + 	struct strbuf superproject = STRBUF_INIT;
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.gitdir.relative", get_path_gitdir_relative },
      	{ "path.hooks.absolute", get_path_hooks_absolute },
      	{ "path.hooks.relative", get_path_hooks_relative },
     +	{ "path.index.absolute", get_path_index_absolute },
     +	{ "path.index.relative", get_path_index_relative },
    - 	{ "path.objects.absolute", get_path_objects_absolute },
    - 	{ "path.objects.relative", get_path_objects_relative },
    - 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
    + 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    + 	{ "path.superproject-root.relative", get_path_superproject_relative },
    + 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
    - 	'custom-hooks' \
    - 	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
    +@@ t/t1900-repo-info.sh: then
    + 		'git config core.hooksPath /dev/null'
    + fi
      
     +test_repo_info_path 'index standard' 'index' '.git/index'
     +
    @@ t/t1900-repo-info.sh: test_repo_info_path 'hooks with core.hooksPath override' '
     +	)
     +'
     +
    - test_repo_info_path 'objects standard' 'objects' '.git/objects'
    - 
    - test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
    + test_expect_success 'path.superproject-root absolute and relative' '
    + 	test_when_finished "rm -rf sub super" &&
    + 	git init sub &&
6:  d80719367b ! 5:  d88340f5a6 repo: add path.grafts with absolute and relative suffix formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.grafts with absolute and relative suffix formatting
    +    repo: add path.grafts with absolute and relative suffixes
     
    -    External toolchains managing specialized history rewrites or legacy
    -    history splices require access to the location of the repository grafts
    -    file. Currently, this requires a legacy call to `git rev-parse --git-path info/grafts`.
    +    The repository grafts file specifies alternate parent relationships for
    +    commits and may be used by repository tooling that needs to inspect or
    +    manage grafts. Scripts currently retrieve its location by invoking
    +    `git rev-parse --git-path info/grafts`.
     
         Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
    -    `git repo info`. This allows scripting layers to query the active grafts
    -    context cleanly while scaling transparently with active `GIT_GRAFT_FILE`
    -    environment variable overrides.
    +    `git repo info`. This exposes the grafts file location as a scriptable
    +    config-like key using standard format rules, allowing scripts to
    +    retrieve it through the same interface as other repository path
    +    information.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc: values that they return:
      	The path to the Git repository directory relative to the current working directory.
      
     +`path.grafts.absolute`::
    -+	The canonical absolute path to the repository grafts file.
    -+	Respects the `GIT_GRAFT_FILE` environment override. The path is returned
    -+	regardless of whether the file currently exists on disk.
    ++	The canonical absolute path to the repository's graft file.
    ++	Respects the `GIT_GRAFT_FILE` environment override. The path is
    ++	returned regardless of whether the file currently exists on disk.
     +
     +`path.grafts.relative`::
    -+	The path to the repository grafts file relative to the current working
    -+	directory. Respects the `GIT_GRAFT_FILE` environment override. The path
    -+	is returned regardless of whether the file currently exists on disk.
    ++	The path to the repository's graft file relative to the current
    ++	working directory. Respects the `GIT_GRAFT_FILE` environment
    ++	override. The path is returned regardless of whether the file
    ++	currently exists on disk.
     +
      `path.hooks.absolute`::
      	The canonical absolute path to the repository's hooks directory.
    - 	Respects `core.hooksPath` configuration adjustments.
    + 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
     
      ## builtin/repo.c ##
     @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	if (!graft_file)
     +		return error(_("unable to get graft file"));
     +
    -+	format_path(buf, graft_file, startup_info->prefix, PATH_FORMAT_CANONICAL);
    ++	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	if (!graft_file)
     +		return error(_("unable to get graft file"));
     +
    -+	format_path(buf, graft_file, startup_info->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
     +	'custom-graft-file' \
     +	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
     +
    - test_repo_info_path 'hooks standard fallback' 'hooks' '.git/hooks'
    + test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
      
      test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
7:  ac6aee77e8 ! 6:  38b19d8bfd repo: add path.git-prefix path key
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.git-prefix path key
    +    repo: add path.git-prefix
     
    -    Scripts and command-line prompt integrations frequently need to know their
    -    relative depth inside a repository working tree layout. Currently, this
    -    is retrieved using `git rev-parse --show-prefix`.
    +    Scripts sometimes need the path from the repository's working tree root
    +    to the current working directory. While this information can be derived
    +    through existing Git commands, `git repo info` does not currently expose
    +    it as a scriptable key.
     
    -    Introduce the `path.git-prefix` key to `git repo info`. This mirrors the
    -    prefix location tracking framework as a standalone key, returning the
    -    exact relative path offset complete with a trailing slash, or an empty
    -    string if run directly at the repository working tree root.
    +    Introduce the `path.git-prefix` key to `git repo info`. The key returns
    +    the path from the working tree root to the current working directory,
    +    returning the empty string when invoked from the working tree root.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc: values that they return:
      	the current working directory.
      
     +`path.git-prefix`::
    -+	The relative path from the top-level directory of the working tree to
    -+	the current working directory (including a trailing slash). Outputs an
    -+	empty string if executed at the root of the working tree.
    ++	The path from the root of the working tree to the current working
    ++	directory. Returns the empty string when the current working directory
    ++	is the root of the working tree.
     +
      `path.gitdir.absolute`::
      	The canonical absolute path to the Git repository directory (the `.git` directory).
    @@ builtin/repo.c: static int get_path_commondir_relative(struct repository *repo,
      	return 0;
      }
      
    -+static int get_path_git_prefix(struct repository *repo UNUSED, struct strbuf *buf)
    ++static int get_path_git_prefix(struct repository *repo, struct strbuf *buf)
     +{
     +	/*
    -+	 * startup_info->prefix is NULL if we are at the working tree root.
    -+	 * We add an empty string to ensure the buffer is cleanly initialized.
    ++	 * repo->prefix is NULL when the current working directory is
    ++	 * the worktree root.
     +	 */
    -+	strbuf_addstr(buf, startup_info->prefix ? startup_info->prefix : "");
    ++	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
     +	return 0;
     +}
     +
    @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commond
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_expect_success 'path.git-prefix at root and in a subdirectory' '
    ++test_expect_success 'path.git-prefix at repository root' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
    ++		echo "path.git-prefix=" >expect &&
    ++		git repo info path.git-prefix >actual &&
    ++		test_cmp expect actual
    ++	)
    ++'
     +
    -+		echo "path.git-prefix=" >expect.root &&
    -+		git repo info path.git-prefix >actual.root &&
    -+		test_cmp expect.root actual.root &&
    -+
    -+		mkdir -p sub/dir &&
    -+		cd sub/dir &&
    -+
    -+		echo "path.git-prefix=sub/dir/" >expect.sub &&
    -+		git repo info path.git-prefix >actual.sub &&
    -+		test_cmp expect.sub actual.sub
    ++test_expect_success 'path.git-prefix in subdirectory' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	mkdir -p repo/sub/dir &&
    ++	(
    ++		cd repo/sub/dir &&
    ++		echo "path.git-prefix=sub/dir/" >expect &&
    ++		git repo info path.git-prefix >actual &&
    ++		test_cmp expect actual
     +	)
     +'
     +
3:  736c8e0576 ! 7:  f28ee4e169 repo: add path.objects with absolute and relative suffix formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.objects with absolute and relative suffix formatting
    +    repo: remove unused setup.h include
     
    -    Tools and deployment hooks frequently query the location of the object
    -    database directory. Currently, this relies on legacy parsing methods or
    -    manually inspecting `git rev-parse --git-path objects`.
    +    The repository prefix is now stored in `struct repository`, so
    +    builtin/repo.c no longer uses any declarations from setup.h.
     
    -    Introduce `path.objects.absolute` and `path.objects.relative` keys to
    -    `git repo info`. This allows tools to discover the object database
    -    location safely while natively adhering to active `GIT_OBJECT_DIRECTORY`
    -    environment variable overrides.
    +    Remove the now-unused include.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
         Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
    - ## Documentation/git-repo.adoc ##
    -@@ Documentation/git-repo.adoc: values that they return:
    - `path.gitdir.relative`::
    - 	The path to the Git repository directory relative to the current working directory.
    - 
    -+`path.objects.absolute`::
    -+	The canonical absolute path to the repository's object database directory.
    -+	Respects the `GIT_OBJECT_DIRECTORY` environment override.
    -+
    -+`path.objects.relative`::
    -+	The path to the repository's object database directory relative to the
    -+	current working directory. Respects the `GIT_OBJECT_DIRECTORY`
    -+	environment override.
    -+
    - `path.superproject-working-tree.absolute`::
    - 	The canonical absolute path to the working tree root of the superproject
    - 	if the current repository is an initialized submodule. Outputs an empty
    -
      ## builtin/repo.c ##
    -@@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
    - 	return 0;
    - }
    - 
    -+static int get_path_objects_absolute(struct repository *repo, struct strbuf *buf)
    -+{
    -+	const char *obj_dir = repo_get_object_directory(repo);
    -+
    -+	if (!obj_dir)
    -+		return error(_("unable to get object directory"));
    -+
    -+	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_CANONICAL);
    -+	return 0;
    -+}
    -+
    -+static int get_path_objects_relative(struct repository *repo, struct strbuf *buf)
    -+{
    -+	const char *obj_dir = repo_get_object_directory(repo);
    -+
    -+	if (!obj_dir)
    -+		return error(_("unable to get object directory"));
    -+
    -+	format_path(buf, obj_dir, startup_info->prefix, PATH_FORMAT_RELATIVE);
    -+	return 0;
    -+}
    -+
    - static int get_path_superproject_absolute(struct repository *repo UNUSED, struct strbuf *buf)
    - {
    - 	struct strbuf superproject = STRBUF_INIT;
    -@@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    - 	{ "path.commondir.relative", get_path_commondir_relative },
    - 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
    - 	{ "path.gitdir.relative", get_path_gitdir_relative },
    -+	{ "path.objects.absolute", get_path_objects_absolute },
    -+	{ "path.objects.relative", get_path_objects_relative },
    - 	{ "path.superproject-working-tree.absolute", get_path_superproject_absolute },
    - 	{ "path.superproject-working-tree.relative", get_path_superproject_relative },
    - 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    -
    - ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
    - 	'.git' \
    - 	'GIT_DIR="../.git" && export GIT_DIR'
    - 
    -+test_repo_info_path 'objects standard' 'objects' '.git/objects'
    -+
    -+test_repo_info_path 'objects with GIT_OBJECT_DIRECTORY override' 'objects' \
    -+	'custom-objects' \
    -+	'GIT_OBJECT_DIRECTORY="$ROOT/custom-objects" && export GIT_OBJECT_DIRECTORY &&
    -+	 mkdir -p "$ROOT/custom-objects"'
    -+
    - test_expect_success 'path.superproject-working-tree absolute and relative' '
    - 	test_when_finished "rm -rf sub super" &&
    - 	git init sub &&
    +@@
    + #include "ref-filter.h"
    + #include "refs.h"
    + #include "revision.h"
    +-#include "setup.h"
    + #include "strbuf.h"
    + #include "string-list.h"
    + #include "shallow.h"
-- 
2.55.GIT
