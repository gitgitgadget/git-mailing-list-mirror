Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674269;
	b=NqWklhLMKSJE48Y0T96gWqzDGklR8VIENeoyD7huKf/1JiRJn9nQR9CaTgz09bAT39wy
	 EmR6zz9Pgg++ebq22CT5A1iy0Asj9FSjJGbNGcW64vJ0XQsA5b7ZufQPsWe2BrqmwRmUV
	 +biRDI/wcGu8OMK8S+UPDSZS2FLjTvd+wBAf3vNYrfkbC5Nytm6HqGekJSavY7ij1HTZI
	 i3on+Odsp11scfXQFIwmD94UIxt9dunulQ4HvNi5Q73Rx3XJRQ6jajn10d9stCT6IAmg6
	 uhI8zAvXZ7nlUYn3lL9mjObI9kx+vdzangQ+28WgAhKuwK7hehUu1YSZz5CHMazjEeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kid38Ohr1DKJBy9avyYDEbUZsuyy0qBdsBWHDRpBsXM=;
	b=zzsxKBe7bNaqfd02O/NYgs9lW+sAXCe7M/ED8gkrHuo+DWngiAtGpzGgBFNIJUrdVjNJ
	 BB3BuWP1Wg6OGUSGo7zUSOJeNTJkiXdtoouhO5ffP5gbWt3XFPuWRZlaGeNTZCxMk8NtT
	 HpNZlpoHT9rx6qlmD2p1PvJ0BYTgtldu0fmfX4kkmUZMW5H77gL+NlFTizjTSV+2di0SC
	 cuEoJB0i9y5fOInetlot1H58rW9CX4iS7+/4PE9rAq9+E+TREPNwRtLuIEXil0E5BpxBg
	 fXwyWfcminOFqc+iIlU6gqSSxOCBba1VKJpFLmHpMPqUwkyM9kb364WHw8zGkUVzsyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/4rXey0";
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D236606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D236606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/4rXey0
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b3acec6677so2701859c88.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 08:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794674268; x=1795279068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kid38Ohr1DKJBy9avyYDEbUZsuyy0qBdsBWHDRpBsXM=;
        b=c/4rXey0iLVkfiWF9RBd8DQYNy9BcSFRqXDrv2BAvY5mXN6URUenYpcvcRjwBfY/B/
         uFpbM22OB/RQOVkgzDvrM1jSpSCvT6rzwnYbnmNKOVtlbsMNsQd4VZOUAtJ/2WlXaJU3
         T7W9Nq+LDO6zOeuKBeJ8+bokgUTkCc30C6dQ4FKQSJkgABvh6XK7oo4sEaVLQEL5HspZ
         jQkrwz2n5MOknTgzywjBp/l0B69+fPkqaODOiEpiMHBFDaI4dF92Z8kuK7v+QBA/SQ5K
         imTmt8MuJwRA8LPRZpuGRWL3OIx6ybqT8GB7540mNxlnqXJ1TH1W1ygtyBZz/zaUpNHW
         qobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794674268; x=1795279068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kid38Ohr1DKJBy9avyYDEbUZsuyy0qBdsBWHDRpBsXM=;
        b=NFPqGC8Z1AI5fVn6v7p+nGFdAdNTH4EOVnFtMp/YMxxKjL2LuBf1/T4tMfbThtdSVV
         7J7Y/aGxAUCy9mLapsKqjOwN5Ij8hGchYADJht8votzPgvnXs170Tk7Mrg0z/dMcyDfg
         ITSn636WbxhOXzkCvpPoWwDayDxoZyyNe6KgpcmViA5eSgqoppRy0h7HnigNie6bc82N
         yKzuEKWRYJmLFtEVmLNLmMCM75H7TPH+Vy8VGIs6aLV9Uw1mYgCla3mkdN9hdV2P5vRl
         48glptdW+kuIB80VrwS+P4y6moQDB6FVrO41UDQAOscgWBOqTq0T2Gwdlj/lC/JJCJsd
         mNyw==
X-Gm-Message-State: APuU4Z/let+s54wqi+R6m8vcxvfMVjcH30OCI8SmXDMyFzlMs7pRq4FD
	+F0hgNWLwsXeUEMVgutKZW+8ky05n3wMrblb68MMp1PUUMlfDrNvKKry
X-Gm-Gg: AYBFou2C7XeSoaXQuwYSPe8FBsbewU+WgcJNcasnkQyV2KJsjqXJtZaFiP4VRGO3P+f
	cc+UrTDXgz1NTpWcrMEnqyBLAhf3W3mnqW8fqfZXS8ltiCf+n2coSyhGyPIkH6OvgFQw7LuiBFi
	5mBR3igMGO84o65TG0wZLB8L6oy9cBtJesO4HPCs3KMta4metQUcyKPAihsixqo7gqxVSDFQ21M
	7h2BpTrFOnjZL9VxY/h5Hd7DPCJan0Lm1DvOOY3JmlXJvQYbR8Stu55UTt0O9MyiqPecRl2DNwv
	1ZgZ+8Z8e+/hdKdbylv9GzOJlIhmOuAZltRDIyFPkVpf1xf7Y7OxbQWkmq8+/OoG0lCS2K7tg9G
	MIuFQwNBT0s7FWBjkDHMSnNvyNDlipCN7XGmV+hDSfxcPQVNy4pKOuYtMtRPvkgisugFMT9WoSu
	LmJpQIzU9LETYEc1zlFh6eTvqS5LczSLu16Ec0KpEz1uS4zC2BTi3264V0FZit8hmTRzukWK1z/
	lIcGEJp0nzAWxbWbOlQC9QSnFhSE9KGILJy80t3WkZ9Rh3hMR3qBVMrS4WLrrZs+D7VjDKqeQck
	trX75D/n7LVYikN1M1xe9fBWzltFBB352dakFJ2UHPGPAg3vnOFwD04BMOCvCryOd44IMgUJIzK
	S5/R2kKnMANK+M9NehqiiFsgIP/JIuI0pS/k=
X-Received: by 2002:a05:7023:d0c:b0:1a2:fa1d:1de5 with SMTP id a92af1059eb24-1b5030f284cmr6669511c88.20.1794674267404;
        Sat, 14 Nov 2026 08:37:47 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm18093657c88.14.2026.11.14.08.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:37:47 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk
Subject: [GSoC Patch v9 0/5] repo: add path keys to repo info
Date: Sat, 14 Nov 2026 22:07:10 +0530
Message-ID: <20261114163715.257705-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.56.0-rc2
In-Reply-To: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series continues the work to expose repository paths and
metadata via the `git repo info` command. It introduces several keys for
querying repository paths in standard absolute and relative formats, as well
as refactoring `get_superproject_working_tree()` to operate on a `struct
repository *`.

The path keys added in this series are:
  - `path.workingtree.absolute` / `path.workingtree.relative`: The root
    directory of the working tree (or an empty string in bare repositories).
  - `path.superprojectworkingtree.absolute` /
    `path.superprojectworkingtree.relative`: The root of the superproject
    when inside a submodule.
  - `path.index.absolute` / `path.index.relative`: The repository's active
    index file.
  - `path.prefix`: The prefix from the worktree root to the current
    working directory.

Changes since v8:
  - Dropped `path.hooks` and `path.cdup`.
  - Renamed `path.toplevel.*` to `path.workingtree.*` to align with the
    standard "working tree" glossary term while avoiding hyphens in
    configuration variable names.
  - Renamed `path.superproject-root.*` to `path.superprojectworkingtree.*`
    to provide a descriptive name for scripts while avoiding hyphens.
  - Renamed `path.git-prefix` to `path.prefix` to shorten it and avoid
    hyphens.

K Jayatheerth (5):
  repo: add path.workingtree with absolute and relative suffix
    formatting
  submodule: use repository to find superproject
  repo: add path.superprojectworkingtree with absolute and relative
    suffixes
  repo: add path.index with absolute and relative suffixes
  repo: add path.prefix

 Documentation/git-repo.adoc |  37 +++++++++++
 builtin/repo.c              |  78 +++++++++++++++++++++++
 builtin/rev-parse.c         |   2 +-
 submodule.c                 |  43 ++++++-------
 submodule.h                 |   2 +-
 t/t1500-rev-parse.sh        |  20 ++++++
 t/t1900-repo-info.sh        | 120 ++++++++++++++++++++++++++++++++++++
 7 files changed, 279 insertions(+), 23 deletions(-)

Range-diff against v8:
1:  27b9811163 ! 1:  6cb242828b repo: add path.toplevel with absolute and relative suffix formatting
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.toplevel with absolute and relative suffix formatting
    +    repo: add path.workingtree with absolute and relative suffix formatting
     
         Scripts frequently need to find the root directory of a repository's
         working tree. Currently, this requires using `git rev-parse --show-toplevel`
         or inferring it from other repository information.
     
    -    Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
    +    Introduce `path.workingtree.absolute` and `path.workingtree.relative` keys
         to `git repo info`. This allows scripts to retrieve the top-level
         working tree path in a predictable, strictly formatted manner without
         relying on `rev-parse`.
    @@ Documentation/git-repo.adoc: values that they return:
      `path.gitdir.relative`::
      	The path to the Git repository directory relative to the current working directory.
      
    -+`path.toplevel.absolute`::
    ++`path.workingtree.absolute`::
     +	The canonical absolute path to the top-level directory of the
     +	repository's working tree. Outputs an empty string if the repository
     +	is bare.
     +
    -+`path.toplevel.relative`::
    ++`path.workingtree.relative`::
     +	The path to the top-level directory of the repository's working
     +	tree relative to the current working directory. Outputs an empty
     +	string if the repository is bare.
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
      	return 0;
      }
      
    -+static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
    ++static int get_path_workingtree_absolute(struct repository *repo, struct strbuf *buf)
     +{
     +	const char *work_tree = repo_get_work_tree(repo);
     +
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	return 0;
     +}
     +
    -+static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
    ++static int get_path_workingtree_relative(struct repository *repo, struct strbuf *buf)
     +{
     +	const char *work_tree = repo_get_work_tree(repo);
     +
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.commondir.relative", get_path_commondir_relative },
      	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    -+	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    -+	{ "path.toplevel.relative", get_path_toplevel_relative },
    ++	{ "path.workingtree.absolute", get_path_workingtree_absolute },
    ++	{ "path.workingtree.relative", get_path_workingtree_relative },
      	{ "references.format", get_references_format },
      };
      
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_expect_success 'path.toplevel absolute and relative' '
    ++test_expect_success 'path.workingtree absolute and relative' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
     +
     +		ROOT="$(test-tool path-utils real_path ..)" &&
     +
    -+		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
    -+		git repo info path.toplevel.absolute >actual.abs &&
    ++		echo "path.workingtree.absolute=$ROOT" >expect.abs &&
    ++		git repo info path.workingtree.absolute >actual.abs &&
     +		test_cmp expect.abs actual.abs &&
     +
    -+		echo "path.toplevel.relative=../" >expect.rel &&
    -+		git repo info path.toplevel.relative >actual.rel &&
    ++		echo "path.workingtree.relative=../" >expect.rel &&
    ++		git repo info path.workingtree.relative >actual.rel &&
     +		test_cmp expect.rel actual.rel
     +	)
     +'
     +
    -+test_expect_success 'path.toplevel absolute and relative in a bare repository' '
    ++test_expect_success 'path.workingtree absolute and relative in a bare repository' '
     +	test_when_finished "rm -rf bare.git" &&
     +	git init --bare bare.git &&
     +	(
     +		cd bare.git &&
     +
    -+		echo "path.toplevel.absolute=" >expect.abs &&
    -+		git repo info path.toplevel.absolute >actual.abs &&
    ++		echo "path.workingtree.absolute=" >expect.abs &&
    ++		git repo info path.workingtree.absolute >actual.abs &&
     +		test_cmp expect.abs actual.abs &&
     +
    -+		echo "path.toplevel.relative=" >expect.rel &&
    -+		git repo info path.toplevel.relative >actual.rel &&
    ++		echo "path.workingtree.relative=" >expect.rel &&
    ++		git repo info path.workingtree.relative >actual.rel &&
     +		test_cmp expect.rel actual.rel
     +	)
     +'
2:  2274dd8be2 = 2:  9da5ce8a69 submodule: use repository to find superproject
3:  34c54cdafd ! 3:  deaf3ae42e repo: add path.superproject-root with absolute and relative suffixes
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.superproject-root with absolute and relative suffixes
    +    repo: add path.superprojectworkingtree with absolute and relative suffixes
     
         Scripts working in multi-repository setups often need to identify the
         top-level working tree of a superproject from within a submodule.
         Currently, this is only exposed via `git rev-parse
         --show-superproject-working-tree`.
     
    -    Introduce `path.superproject-root.absolute` and
    -    `path.superproject-root.relative` keys to `git repo info`.
    +    Introduce `path.superprojectworkingtree.absolute` and
    +    `path.superprojectworkingtree.relative` keys to `git repo info`.
         This exposes the core submodule context via a scriptable config-like key
         using standard format rules.
     
    @@ Documentation/git-repo.adoc: values that they return:
      `path.gitdir.relative`::
      	The path to the Git repository directory relative to the current working directory.
      
    -+`path.superproject-root.absolute`::
    ++`path.superprojectworkingtree.absolute`::
     +	The canonical absolute path to the working tree root of the superproject
     +	if the current repository is an initialized submodule. Outputs an empty
     +	string if not in a submodule.
     +
    -+`path.superproject-root.relative`::
    ++`path.superprojectworkingtree.relative`::
     +	The path to the working tree root of the superproject relative to the
     +	current working directory if the current repository is an initialized
     +	submodule. Outputs an empty string if not in a submodule.
     +
    - `path.toplevel.absolute`::
    + `path.workingtree.absolute`::
      	The canonical absolute path to the top-level directory of the
      	repository's working tree. Outputs an empty string if the repository
     
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
      	return 0;
      }
      
    -+static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
    ++static int get_path_superprojectworkingtree_absolute(struct repository *repo, struct strbuf *buf)
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	return 0;
     +}
     +
    -+static int get_path_superproject_relative(struct repository *repo, struct strbuf *buf)
    ++static int get_path_superprojectworkingtree_relative(struct repository *repo, struct strbuf *buf)
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	return 0;
     +}
     +
    - static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_path_workingtree_absolute(struct repository *repo, struct strbuf *buf)
      {
      	const char *work_tree = repo_get_work_tree(repo);
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.commondir.relative", get_path_commondir_relative },
      	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    -+	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    -+	{ "path.superproject-root.relative", get_path_superproject_relative },
    - 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    - 	{ "path.toplevel.relative", get_path_toplevel_relative },
    ++	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
    ++	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
    + 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
    + 	{ "path.workingtree.relative", get_path_workingtree_relative },
      	{ "references.format", get_references_format },
     
      ## t/t1900-repo-info.sh ##
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_expect_success 'path.superproject-root absolute and relative' '
    ++test_expect_success 'path.superprojectworkingtree absolute and relative' '
     +	test_when_finished "rm -rf sub super" &&
     +	git init sub &&
     +	test_commit -C sub initial &&
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
     +		cd sub &&
     +		ROOT="$(test-tool path-utils real_path ..)" &&
     +
    -+		echo "path.superproject-root.absolute=$ROOT" >expect.abs &&
    -+		git repo info path.superproject-root.absolute >actual.abs &&
    ++		echo "path.superprojectworkingtree.absolute=$ROOT" >expect.abs &&
    ++		git repo info path.superprojectworkingtree.absolute >actual.abs &&
     +		test_cmp expect.abs actual.abs &&
     +
    -+		echo "path.superproject-root.relative=../" >expect.rel &&
    -+		git repo info path.superproject-root.relative >actual.rel &&
    ++		echo "path.superprojectworkingtree.relative=../" >expect.rel &&
    ++		git repo info path.superprojectworkingtree.relative >actual.rel &&
     +		test_cmp expect.rel actual.rel
     +	)
     +'
     +
    -+test_expect_success 'path.superproject-root returns empty when not in a submodule' '
    ++test_expect_success 'path.superprojectworkingtree returns empty when not in a submodule' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
     +
    -+		echo "path.superproject-root.absolute=" >expect.abs &&
    -+		git repo info path.superproject-root.absolute >actual.abs &&
    ++		echo "path.superprojectworkingtree.absolute=" >expect.abs &&
    ++		git repo info path.superprojectworkingtree.absolute >actual.abs &&
     +		test_cmp expect.abs actual.abs &&
     +
    -+		echo "path.superproject-root.relative=" >expect.rel &&
    -+		git repo info path.superproject-root.relative >actual.rel &&
    ++		echo "path.superprojectworkingtree.relative=" >expect.rel &&
    ++		git repo info path.superprojectworkingtree.relative >actual.rel &&
     +		test_cmp expect.rel actual.rel
     +	)
     +'
     +
    - test_expect_success 'path.toplevel absolute and relative' '
    + test_expect_success 'path.workingtree absolute and relative' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
4:  985403c7b3 < -:  ---------- repo: add path.hooks with absolute and relative suffixes
5:  486836ae52 ! 4:  de9e189714 repo: add path.index with absolute and relative suffixes
    @@ Commit message
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
    - 	working directory. Respects the `core.hooksPath` configuration. If
    - 	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
    + `path.gitdir.relative`::
    + 	The path to the Git repository directory relative to the current working directory.
      
     +`path.index.absolute`::
     +	The canonical absolute path to the repository's current index file.
    @@ Documentation/git-repo.adoc: values that they return:
     +	Returns the configured index path even if the repository is bare or the
     +	file does not exist.
     +
    - `path.superproject-root.absolute`::
    + `path.superprojectworkingtree.absolute`::
      	The canonical absolute path to the working tree root of the superproject
      	if the current repository is an initialized submodule. Outputs an empty
     
      ## builtin/repo.c ##
    -@@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, struct strbuf *buf)
    +@@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
      	return 0;
      }
      
    @@ builtin/repo.c: static int get_path_hooks_relative(struct repository *repo, stru
     +	return 0;
     +}
     +
    - static int get_path_superproject_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_path_superprojectworkingtree_absolute(struct repository *repo, struct strbuf *buf)
      {
      	struct strbuf superproject = STRBUF_INIT;
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    + 	{ "path.commondir.relative", get_path_commondir_relative },
    + 	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    - 	{ "path.hooks.absolute", get_path_hooks_absolute },
    - 	{ "path.hooks.relative", get_path_hooks_relative },
     +	{ "path.index.absolute", get_path_index_absolute },
     +	{ "path.index.relative", get_path_index_relative },
    - 	{ "path.superproject-root.absolute", get_path_superproject_absolute },
    - 	{ "path.superproject-root.relative", get_path_superproject_relative },
    - 	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    + 	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
    + 	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
    + 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_expect_success 'hooks with core.hooksPath=/dev/null' '
    - 	)
    - '
    +@@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
    + 	'.git' \
    + 	'GIT_DIR="../.git" && export GIT_DIR'
      
     +test_repo_info_path 'index standard' 'index' '.git/index'
     +
    @@ t/t1900-repo-info.sh: test_expect_success 'hooks with core.hooksPath=/dev/null'
     +	)
     +'
     +
    - test_expect_success 'path.superproject-root absolute and relative' '
    + test_expect_success 'path.superprojectworkingtree absolute and relative' '
      	test_when_finished "rm -rf sub super" &&
      	git init sub &&
6:  91a8dc3ab1 < -:  ---------- repo: add path.git-prefix
7:  84a9fb4060 ! 5:  97035f59f4 repo: add path.cdup
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.cdup
    +    repo: add path.prefix
     
    -    Scripts sometimes need the relative path from the current working
    -    directory to the repository's working tree root (cdup). While this
    -    information can be retrieved through `git rev-parse --show-cdup`,
    -    `git repo info` does not currently expose it as a scriptable key.
    +    Scripts sometimes need the path from the repository's working tree root
    +    to the current working directory. While this information can be derived
    +    through existing Git commands, `git repo info` does not currently expose
    +    it as a scriptable key.
     
    -    Introduce the `path.cdup` key to `git repo info`. The key returns the
    -    path from the current working directory to the root of the working tree,
    +    Introduce the `path.prefix` key to `git repo info`. The key returns
    +    the path from the working tree root to the current working directory,
         returning the empty string when invoked from the working tree root.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
    @@ Commit message
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
    - `object.format`::
    - 	The object format (hash algorithm) used in the repository.
    + 	Returns the configured index path even if the repository is bare or the
    + 	file does not exist.
      
    -+`path.cdup`::
    -+	When the command is invoked from a subdirectory, show the
    -+	path of the top-level directory relative to the current
    -+	directory (typically a sequence of "../", or an empty string).
    ++`path.prefix`::
    ++	The path from the root of the working tree to the current working
    ++	directory. Returns the empty string when the current working directory
    ++	is the root of the working tree.
     +
    - `path.commondir.absolute`::
    - 	The canonical absolute path to the Git repository's common
    - 	directory (the shared `.git` directory containing objects,
    + `path.superprojectworkingtree.absolute`::
    + 	The canonical absolute path to the working tree root of the superproject
    + 	if the current repository is an initialized submodule. Outputs an empty
     
      ## builtin/repo.c ##
    -@@ builtin/repo.c: static int get_object_format(struct repository *repo, struct strbuf *buf)
    +@@ builtin/repo.c: static int get_path_commondir_relative(struct repository *repo, struct strbuf *b
      	return 0;
      }
      
    -+static int get_path_cdup(struct repository *repo, struct strbuf *buf)
    ++static int get_path_prefix(struct repository *repo, struct strbuf *buf)
     +{
    -+	const char *pfx = repo->prefix;
    -+
    -+	if (!is_inside_work_tree(repo)) {
    -+		const char *worktree = repo_get_work_tree(repo);
    -+
    -+		if (worktree)
    -+			strbuf_addstr(buf, worktree);
    -+		return 0;
    -+	}
    -+
    -+	while (pfx) {
    -+		pfx = strchr(pfx, '/');
    -+		if (pfx) {
    -+			pfx++;
    -+			strbuf_addstr(buf, "../");
    -+		}
    -+	}
    ++	/*
    ++	 * repo->prefix is NULL when the current working directory is
    ++	 * the worktree root.
    ++	 */
    ++	strbuf_addstr(buf, repo->prefix ? repo->prefix : "");
     +	return 0;
     +}
     +
    - static int get_path_commondir_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_path_gitdir_absolute(struct repository *repo, struct strbuf *buf)
      {
    - 	const char *common_dir = repo_get_common_dir(repo);
    + 	const char *git_dir = repo_get_git_dir(repo);
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
    - 	{ "layout.bare", get_layout_bare },
    - 	{ "layout.shallow", get_layout_shallow },
    - 	{ "object.format", get_object_format },
    -+	{ "path.cdup", get_path_cdup },
    - 	{ "path.commondir.absolute", get_path_commondir_absolute },
    - 	{ "path.commondir.relative", get_path_commondir_relative },
    - 	{ "path.git-prefix", get_path_git_prefix },
    + 	{ "path.gitdir.relative", get_path_gitdir_relative },
    + 	{ "path.index.absolute", get_path_index_absolute },
    + 	{ "path.index.relative", get_path_index_relative },
    ++	{ "path.prefix", get_path_prefix },
    + 	{ "path.superprojectworkingtree.absolute", get_path_superprojectworkingtree_absolute },
    + 	{ "path.superprojectworkingtree.relative", get_path_superprojectworkingtree_relative },
    + 	{ "path.workingtree.absolute", get_path_workingtree_absolute },
     
      ## t/t1900-repo-info.sh ##
     @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_expect_success 'path.cdup at repository root' '
    ++test_expect_success 'path.prefix at repository root' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	(
     +		cd repo &&
    -+		echo "path.cdup=" >expect &&
    -+		git repo info path.cdup >actual &&
    ++		echo "path.prefix=" >expect &&
    ++		git repo info path.prefix >actual &&
     +		test_cmp expect actual
     +	)
     +'
     +
    -+test_expect_success 'path.cdup in subdirectory' '
    ++test_expect_success 'path.prefix in subdirectory' '
     +	test_when_finished "rm -rf repo" &&
     +	git init repo &&
     +	mkdir -p repo/sub/dir &&
     +	(
     +		cd repo/sub/dir &&
    -+		echo "path.cdup=../../" >expect &&
    -+		git repo info path.cdup >actual &&
    ++		echo "path.prefix=sub/dir/" >expect &&
    ++		git repo info path.prefix >actual &&
     +		test_cmp expect actual
     +	)
     +'
     +
    -+test_expect_success 'path.cdup cwd outside the working tree' '
    -+	test_when_finished "rm -rf repo" &&
    -+	mkdir -p repo/tmp/x &&
    -+	(
    -+		cd repo &&
    -+		git init test &&
    -+		echo "path.cdup=$(pwd)/tmp/x" >test/expect &&
    -+		cd test &&
    -+		GIT_WORK_TREE=../tmp/x &&
    -+		export GIT_WORK_TREE &&
    -+		GIT_DIR=$(pwd)/.git &&
    -+		export GIT_DIR &&
    -+		git repo info path.cdup >actual &&
    -+		test_cmp expect actual
    -+	)
    -+'
    -+
    - test_expect_success 'path.git-prefix at repository root' '
    - 	test_when_finished "rm -rf repo" &&
    - 	git init repo &&
    + test_repo_info_path 'gitdir standard' 'gitdir' '.git'
    + 
    + test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
-- 
2.56.0-rc2

