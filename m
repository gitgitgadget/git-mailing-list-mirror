Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794067297;
	b=kJjkH2F3DZ5RfjcvaIA6t3S2Y9KFsmlqL8PRWfkWdBJwMr8h3sWl+K4IApM0lg+OD0tC
	 G00xuThmubrh9u7tLZZqG5ajkb/XMcTmRCedPKp3fqqRGVGwRxv9WDVEpUkrCNc3SfaCM
	 H9ySZzynFmBLCnq8zKzYPG9LRrJJtNDkI2O0gakd470y+Dc+UIn8m4G90pVVGSPH4HP51
	 bxRqGHygRznd4XOJ2XRkNAsOP2l5R6ipqOrlFY+ocWyUyC7Ea9luzyUUpXrntaEKd6Gqp
	 dONJUpItR33WMmVGlMwtiRhDDaaXiULHtqvseRixbDYxGwCFNgA4BmSCnkGA9NTXzwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794067297;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5TFdSm29xZ2oAG32u2sys6QQJUu+KuNXkKa53zdO1FA=;
	b=L3wyZbZ+4xWB3aAlIziAjs1y36RI8BvEReg8bz/vx9owBEn6CWHXvR4uarduMOxSOlYo
	 Byw1uzj4m+DcWtRBfXv93LY5n9X+Ezkec18tH3Iw5grpZx3nb62pMhLL2KvnDdHECdFoy
	 pEmhCvpJhygeGhAoP9PWx1s8E4L4lIwd7lA5hyGGXHLTRB0VWPOnssIoBRw8cjQGbfLt/
	 CzR/DvQ7TqKupTrdeqZ26OI53XUBJsBSPYWpti4k8cbu4JfEH6ImwvVhxBaEaCTSJQurJ
	 TFzmeyVtmUHe6PeIN2jYgVZjuUr3Vjmh8Sz1PdH94p2BbDYINm80HvpTN7NUuZMubjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zko/zN3O";
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D202606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 16:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D202606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zko/zN3O
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15ea896ddc8so2814329c88.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 08:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794067296; x=1794672096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5TFdSm29xZ2oAG32u2sys6QQJUu+KuNXkKa53zdO1FA=;
        b=zko/zN3OlMoZBCWb+8/Dlr/ovrdQeY1Ug+4/mqGeKHr2zGJ1Qrx1fVvhK+nbRtmiYn
         uI41lJPsxBA1oSfr6u3aPK1WLXYgJWzhbT30i16tz+APadq9kE9RILE7wQn5c7RfG66l
         HQMb5AfR/tvWCWb0VevkHTwG81JG2dNe8ks1MCcCV7+3BDeM94IxAoB68HlU8Xlurj+8
         ots/I1Dn9hoOo/9F7rAr28mpXaE+MBGZoN7MFZUe3P6+rAf4FTkdwwCgr+/OGtWptPsB
         scrjtzuAc6W2UPy3/twKC6VpuxgxaK2MdaqLgWWCJKMtEJlkrCZrVRm5Mb91JeUO0/pP
         JZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794067296; x=1794672096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5TFdSm29xZ2oAG32u2sys6QQJUu+KuNXkKa53zdO1FA=;
        b=yMZPIMqF8QmP/KhqukawigiQFtaKsjW0zlETBXg0lmwWd14IlT9Sx1/xTCFFNvsCpS
         4kSPgza7p6qL51f4Q0rgiRgjolWrT1pih5e42KDp2slP9CrJIEy90ozEy0X/FUmmnnyZ
         rOeAohTNWT8cHmPE2Qb8/fQzF0Q7t2W7vlfsIyL1ZzlyA3hJENvrHM4YEZc94JxwkmH9
         UIPFsimkInDPCBlRl42m7YlzDV8PpAbrri3Kb+3gZesXLg9Y71ibt9PSLthv1lMaA+0k
         7vLD4I8AE8KxtXPcul8yVxu+w49jsh5nuvhgW2FPnUrtRtHorYzHMVFIqJU+iUrWet7e
         uBew==
X-Gm-Message-State: APuU4Z9Ih9aOB32djZsJHfr1q+OrN3Ts/lItsZgL9swddrRKLYNA1DAd
	x7wocaTspESjZIpQIeh72DWroZo6jWKkAOivwUmRZjH83atCpBfie1n5
X-Gm-Gg: AYBFou2nkyJ3FA+w1wkZaiHbbhKbCYzJY9lwurMblEZrSmPF67ammfI72tTQIZXAYli
	G5n8+5IO+rwwq/4cH3B1khoIc19pGV/3gV1Ni7KOpTVjIlwGocWbspNKF8me2YYPu5/8egA9EiH
	+7FRIrVw0DcoHxbZpDi43zmc/SlCpmV9O3ek85TBdj5ZzJ0wsx6fqrJO8EMqHsb0Y3At+dUR8ph
	CrhODMDoPl1VFU2e7vQncYj+sGW5R4gpXVDSru2v3vbG/p2A0UwlrNAnGllFHVog1ZNtyiU8CCj
	6QYisiO1vUAUF6z9RC9/1rYRy9Qm95wj1hMwkZmYTYtqYWv5yeiFnZw8GIuWbV+iW6PxmxE0ie+
	DWOnCqTwCIbQ/KrIoHvka8J21GWKgnqy4iI2DR69y8e4IzaCcSU22E+LhyQNiotIpZ+QVto0CxT
	NQ/zG4a/e02SXZH+o4kPMkkMfNL6S0BdNjBEkQPAgXckQC7s+Fo3uvnfQxQRlZ4hYioAbwMIg/L
	10CdItz4eXDVSvv60wfhWE2s4h0Q4T23SFzStwFB75R/cskD3Dbbk6OoJtw5GL+GFSquFYlJlI+
	1qSW9ze5KjbCEsuY6o2hUwltQXXUvTms889hJLmpsw6S8jHlpVXGqqLRY2vWypgnsKRvDq09W90
	T2rzMRErO8qxNn19wyv+zPmnXvHCfcUQfbBXD
X-Received: by 2002:a05:701b:4194:10b0:169:bef5:f445 with SMTP id a92af1059eb24-1b25d28848cmr7977682c88.4.1794067295783;
        Sat, 07 Nov 2026 08:01:35 -0800 (PST)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4a5628sm16264618c88.10.2026.11.07.08.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 08:01:35 -0800 (PST)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: git@vger.kernel.org,
	jltobler@gmail.com,
	lucasseikioshiro@gmail.com
Subject: [GSoC Patch v8 0/7] repo: add path keys to repo info
Date: Sat,  7 Nov 2026 21:30:53 +0530
Message-ID: <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
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
  - `path.toplevel.absolute` / `path.toplevel.relative`: The root directory
    of the working tree (or an empty string in bare repositories).
  - `path.superproject-root.absolute` / `path.superproject-root.relative`:
    The root of the superproject when inside a submodule.
  - `path.hooks.absolute` / `path.hooks.relative`: The repository's hooks
    directory (respecting `core.hooksPath`, including `/dev/null`).
  - `path.index.absolute` / `path.index.relative`: The repository's active
    index file.
  - `path.git-prefix`: The prefix from the worktree root to the current
    working directory.
  - `path.cdup`: The relative path from the current directory up to the
    worktree root.

Changes since v7:
  - Dropped `path.grafts`.
  - In patch 2 (`submodule: use repository to find superproject`), moved the
    test for `--git-dir` to `t/t1500-rev-parse.sh` exercising the existing
    `rev-parse --show-superproject-working-tree` interface (since
    `path.superproject-root` is only added in patch 3), and ensured clean
    isolation of test directories (`sub` and `super`).
  - In patch 3 (`path.superproject-root`), simplified the getter functions
    by eliminating redundant early returns.
  - In patch 4 (`path.hooks`):
    - Special-cased `/dev/null` in both `path.hooks.absolute` and
      `path.hooks.relative` to output `/dev/null` directly, making it easy
      for scripts to detect when hooks are disabled. Documented this
      behavior in `Documentation/git-repo.adoc`.
    - Reverted changes to the `test_repo_info_path` helper in
      `t/t1900-repo-info.sh` and wrote a standalone test block for the
      `/dev/null` case.
    - Set `hooksPath = /dev/null` directly in the config file rather than
      passing it through `git config core.hooksPath /dev/null` to prevent
      MSYS2 argument mangling on Windows (which rewrites `/dev/null` to
      `nul`), allowing the test to run portably on all platforms without
      requiring `!MINGW`.
  - In patch 7 (`path.cdup`), removed unnecessary braces on the single-line
    `if`, added an early return when invoked outside a worktree, and ensured
    `cd repo` in the test runs within a subshell.

Thanks to Justin Tobler and Lucas Seiki Oshiro for their reviews and
mentorship.

K Jayatheerth (7):
  repo: add path.toplevel with absolute and relative suffix formatting
  submodule: use repository to find superproject
  repo: add path.superproject-root with absolute and relative suffixes
  repo: add path.hooks with absolute and relative suffixes
  repo: add path.index with absolute and relative suffixes
  repo: add path.git-prefix
  repo: add path.cdup

 Documentation/git-repo.adoc |  52 ++++++++++
 builtin/repo.c              | 131 +++++++++++++++++++++++++
 builtin/rev-parse.c         |   2 +-
 submodule.c                 |  43 +++++----
 submodule.h                 |   2 +-
 t/t1500-rev-parse.sh        |  20 ++++
 t/t1900-repo-info.sh        | 185 ++++++++++++++++++++++++++++++++++++
 7 files changed, 412 insertions(+), 23 deletions(-)

Range-diff against v7:
5:  351b4b7de7 ! 1:  27b9811163 repo: add path.grafts with absolute and relative suffixes
    @@ Metadata
     Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## Commit message ##
    -    repo: add path.grafts with absolute and relative suffixes
    +    repo: add path.toplevel with absolute and relative suffix formatting
     
    -    The repository grafts file specifies alternate parent relationships for
    -    commits and may be used by repository tooling that needs to inspect or
    -    manage grafts. Scripts currently retrieve its location by invoking
    -    `git rev-parse --git-path info/grafts`.
    +    Scripts frequently need to find the root directory of a repository's
    +    working tree. Currently, this requires using `git rev-parse --show-toplevel`
    +    or inferring it from other repository information.
     
    -    Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
    -    `git repo info`. This exposes the grafts file location as a scriptable
    -    config-like key using standard format rules, allowing scripts to
    -    retrieve it through the same interface as other repository path
    -    information.
    +    Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
    +    to `git repo info`. This allows scripts to retrieve the top-level
    +    working tree path in a predictable, strictly formatted manner without
    +    relying on `rev-parse`.
    +
    +    If requested in a bare repository where no working tree exists, the
    +    command returns an empty string.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
    @@ Documentation/git-repo.adoc: values that they return:
      `path.gitdir.relative`::
      	The path to the Git repository directory relative to the current working directory.
      
    -+`path.grafts.absolute`::
    -+	The canonical absolute path to the repository's graft file.
    -+	Respects the `GIT_GRAFT_FILE` environment override. The path is
    -+	returned regardless of whether the file currently exists on disk.
    ++`path.toplevel.absolute`::
    ++	The canonical absolute path to the top-level directory of the
    ++	repository's working tree. Outputs an empty string if the repository
    ++	is bare.
     +
    -+`path.grafts.relative`::
    -+	The path to the repository's graft file relative to the current
    -+	working directory. Respects the `GIT_GRAFT_FILE` environment
    -+	override. The path is returned regardless of whether the file
    -+	currently exists on disk.
    ++`path.toplevel.relative`::
    ++	The path to the top-level directory of the repository's working
    ++	tree relative to the current working directory. Outputs an empty
    ++	string if the repository is bare.
     +
    - `path.hooks.absolute`::
    - 	The canonical absolute path to the repository's hooks directory.
    - 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
    + `references.format`::
    + 	The reference storage format. The valid values are:
    + +
     
      ## builtin/repo.c ##
     @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
      	return 0;
      }
      
    -+static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
    ++static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
     +{
    -+	const char *graft_file = repo_get_graft_file(repo);
    ++	const char *work_tree = repo_get_work_tree(repo);
     +
    -+	if (!graft_file)
    -+		return error(_("unable to get graft file"));
    ++	if (!work_tree)
    ++		return 0;
     +
    -+	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
    ++	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
     +	return 0;
     +}
     +
    -+static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
    ++static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
     +{
    -+	const char *graft_file = repo_get_graft_file(repo);
    ++	const char *work_tree = repo_get_work_tree(repo);
     +
    -+	if (!graft_file)
    -+		return error(_("unable to get graft file"));
    ++	if (!work_tree)
    ++		return 0;
     +
    -+	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
    ++	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
     +	return 0;
     +}
     +
    - static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
    + static int get_references_format(struct repository *repo, struct strbuf *buf)
      {
    - 	struct strbuf hooks_path = STRBUF_INIT;
    + 	strbuf_addstr(buf,
     @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.commondir.relative", get_path_commondir_relative },
      	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    -+	{ "path.grafts.absolute", get_path_grafts_absolute },
    -+	{ "path.grafts.relative", get_path_grafts_relative },
    - 	{ "path.hooks.absolute", get_path_hooks_absolute },
    - 	{ "path.hooks.relative", get_path_hooks_relative },
    - 	{ "path.index.absolute", get_path_index_absolute },
    ++	{ "path.toplevel.absolute", get_path_toplevel_absolute },
    ++	{ "path.toplevel.relative", get_path_toplevel_relative },
    + 	{ "references.format", get_references_format },
    + };
    + 
     
      ## t/t1900-repo-info.sh ##
     @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
      
    -+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
    ++test_expect_success 'path.toplevel absolute and relative' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		mkdir -p repo/sub &&
    ++		cd repo/sub &&
     +
    -+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
    -+	'custom-graft-file' \
    -+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
    ++		ROOT="$(test-tool path-utils real_path ..)" &&
     +
    - test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
    - 
    - test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
    ++		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
    ++		git repo info path.toplevel.absolute >actual.abs &&
    ++		test_cmp expect.abs actual.abs &&
    ++
    ++		echo "path.toplevel.relative=../" >expect.rel &&
    ++		git repo info path.toplevel.relative >actual.rel &&
    ++		test_cmp expect.rel actual.rel
    ++	)
    ++'
    ++
    ++test_expect_success 'path.toplevel absolute and relative in a bare repository' '
    ++	test_when_finished "rm -rf bare.git" &&
    ++	git init --bare bare.git &&
    ++	(
    ++		cd bare.git &&
    ++
    ++		echo "path.toplevel.absolute=" >expect.abs &&
    ++		git repo info path.toplevel.absolute >actual.abs &&
    ++		test_cmp expect.abs actual.abs &&
    ++
    ++		echo "path.toplevel.relative=" >expect.rel &&
    ++		git repo info path.toplevel.relative >actual.rel &&
    ++		test_cmp expect.rel actual.rel
    ++	)
    ++'
    ++
    + test_done
1:  7c90603a1b ! 2:  2274dd8be2 submodule: use repository to find superproject
    @@ submodule.h: void absorb_git_dir_into_superproject(const char *path,
      
      #endif
     
    - ## t/t7400-submodule-basic.sh ##
    -@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add fails when name is reused' '
    + ## t/t1500-rev-parse.sh ##
    +@@ t/t1500-rev-parse.sh: test_expect_success ':/ and HEAD^{/} favor more recent matching commits' '
      	)
      '
      
    -+test_expect_success 'path.superproject-root works with --git-dir' '
    ++test_expect_success '--show-superproject-working-tree works with --git-dir' '
    ++	rm -rf sub super &&
     +	test_when_finished "rm -rf sub super" &&
     +	git init sub &&
     +	test_commit -C sub initial &&
    @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add fails when name i
     +		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
     +		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
     +
    -+		echo "path.superproject-root.absolute=$SUPER_ROOT" >expect &&
    -+		git --git-dir="$MODULE_DIR" repo info path.superproject-root.absolute >actual &&
    ++		echo "$SUPER_ROOT" >expect &&
    ++		git --git-dir="$MODULE_DIR" rev-parse --show-superproject-working-tree >actual &&
     +		test_cmp expect actual
     +	)
     +'
2:  1bfb0c8c1d ! 3:  34c54cdafd repo: add path.superproject-root with absolute and relative suffixes
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
    -+	if (!get_superproject_working_tree(repo, &superproject)) {
    -+		strbuf_release(&superproject);
    -+		return 0;
    -+	}
    ++	if (get_superproject_working_tree(repo, &superproject))
    ++		format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
     +
    -+	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
     +	strbuf_release(&superproject);
     +	return 0;
     +}
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +{
     +	struct strbuf superproject = STRBUF_INIT;
     +
    -+	if (!get_superproject_working_tree(repo, &superproject)) {
    -+		strbuf_release(&superproject);
    -+		return 0;
    -+	}
    ++	if (get_superproject_working_tree(repo, &superproject))
    ++		format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
     +
    -+	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
     +	strbuf_release(&superproject);
     +	return 0;
     +}
3:  09d2937fcd ! 4:  985403c7b3 repo: add path.hooks with absolute and relative suffixes
    @@ Documentation/git-repo.adoc: values that they return:
     +
     +`path.hooks.relative`::
     +	The path to the repository's hooks directory relative to the current
    -+	working directory. Respects the `core.hooksPath` configuration.
    ++	working directory. Respects the `core.hooksPath` configuration. If
    ++	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
     +
      `path.superproject-root.absolute`::
      	The canonical absolute path to the working tree root of the superproject
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	struct strbuf hooks_path = STRBUF_INIT;
     +
     +	repo_git_path_replace(repo, &hooks_path, "hooks");
    -+	format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
    ++	if (!strcmp(hooks_path.buf, "/dev/null"))
    ++		strbuf_addstr(buf, "/dev/null");
    ++	else
    ++		format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
    ++
     +	strbuf_release(&hooks_path);
     +	return 0;
     +}
    @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
     +	struct strbuf hooks_path = STRBUF_INIT;
     +
     +	repo_git_path_replace(repo, &hooks_path, "hooks");
    -+	format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
    ++	if (!strcmp(hooks_path.buf, "/dev/null"))
    ++		strbuf_addstr(buf, "/dev/null");
    ++	else
    ++		format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
    ++
     +	strbuf_release(&hooks_path);
     +	return 0;
     +}
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.toplevel.absolute", get_path_toplevel_absolute },
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: test_repo_info_path () {
    - 			cd repo/sub &&
    - 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
    - 			eval "$init_command" &&
    --			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
    -+			case "$expected_dir" in
    -+			/*) EXPECT_ABS="$expected_dir" ;;
    -+			*) EXPECT_ABS="$ROOT/$expected_dir" ;;
    -+			esac &&
    -+			echo "path.$field_name.absolute=$EXPECT_ABS" >expect &&
    - 			git repo info "path.$field_name.absolute" >actual &&
    - 			test_cmp expect actual
    - 		)
    -@@ t/t1900-repo-info.sh: test_repo_info_path () {
    - 			cd repo/sub &&
    - 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
    - 			eval "$init_command" &&
    --			echo "path.$field_name.relative=../$expected_dir" >expect &&
    -+			case "$expected_dir" in
    -+			/*) EXPECT_REL="$(test-tool path-utils relative_path "$expected_dir" "$PWD")" ;;
    -+			*) EXPECT_REL="../$expected_dir" ;;
    -+			esac &&
    -+			echo "path.$field_name.relative=$EXPECT_REL" >expect &&
    - 			git repo info "path.$field_name.relative" >actual &&
    - 			test_cmp expect actual
    - 		)
     @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
      	'.git' \
      	'GIT_DIR="../.git" && export GIT_DIR'
    @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
     +	'custom-hooks' \
     +	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
     +
    -+# /dev/null is not a real, canonicalizable filesystem path on Windows,
    -+# so path resolution for core.hooksPath=/dev/null cannot be expected to
    -+# produce a literal "/dev/null" the way it does on POSIX systems.
    -+if ! test_have_prereq MINGW
    -+then
    -+	test_repo_info_path 'hooks with core.hooksPath=/dev/null' 'hooks' \
    -+		'/dev/null' \
    -+		'git config core.hooksPath /dev/null'
    -+fi
    ++test_expect_success 'hooks with core.hooksPath=/dev/null' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		mkdir -p repo/sub &&
    ++		cd repo/sub &&
    ++		cat >>../.git/config <<-\EOF &&
    ++		[core]
    ++			hooksPath = /dev/null
    ++		EOF
    ++		echo "path.hooks.absolute=/dev/null" >expect.abs &&
    ++		echo "path.hooks.relative=/dev/null" >expect.rel &&
    ++		git repo info path.hooks.absolute >actual.abs &&
    ++		git repo info path.hooks.relative >actual.rel &&
    ++		test_cmp expect.abs actual.abs &&
    ++		test_cmp expect.rel actual.rel
    ++	)
    ++'
     +
      test_expect_success 'path.superproject-root absolute and relative' '
      	test_when_finished "rm -rf sub super" &&
4:  d0c186f150 ! 5:  486836ae52 repo: add path.index with absolute and relative suffixes
    @@ Commit message
     
      ## Documentation/git-repo.adoc ##
     @@ Documentation/git-repo.adoc: values that they return:
    - 	The path to the repository's hooks directory relative to the current
    - 	working directory. Respects the `core.hooksPath` configuration.
    + 	working directory. Respects the `core.hooksPath` configuration. If
    + 	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
      
     +`path.index.absolute`::
     +	The canonical absolute path to the repository's current index file.
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
      	{ "path.toplevel.absolute", get_path_toplevel_absolute },
     
      ## t/t1900-repo-info.sh ##
    -@@ t/t1900-repo-info.sh: then
    - 		'git config core.hooksPath /dev/null'
    - fi
    +@@ t/t1900-repo-info.sh: test_expect_success 'hooks with core.hooksPath=/dev/null' '
    + 	)
    + '
      
     +test_repo_info_path 'index standard' 'index' '.git/index'
     +
6:  ef69d4aa8c ! 6:  91a8dc3ab1 repo: add path.git-prefix
    @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
     +	{ "path.git-prefix", get_path_git_prefix },
      	{ "path.gitdir.absolute", get_path_gitdir_absolute },
      	{ "path.gitdir.relative", get_path_gitdir_relative },
    - 	{ "path.grafts.absolute", get_path_grafts_absolute },
    + 	{ "path.hooks.absolute", get_path_hooks_absolute },
     
      ## t/t1900-repo-info.sh ##
     @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
7:  3e61728dba ! 7:  84a9fb4060 repo: add path.cdup
    @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
     +	if (!is_inside_work_tree(repo)) {
     +		const char *worktree = repo_get_work_tree(repo);
     +
    -+		if (worktree) {
    ++		if (worktree)
     +			strbuf_addstr(buf, worktree);
    -+		}
    ++		return 0;
     +	}
     +
     +	while (pfx) {
    @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commond
     +test_expect_success 'path.cdup cwd outside the working tree' '
     +	test_when_finished "rm -rf repo" &&
     +	mkdir -p repo/tmp/x &&
    -+	cd repo &&
    -+	git init test &&
     +	(
    -+		echo path.cdup=$(pwd)/tmp/x >./test/expect &&
    ++		cd repo &&
    ++		git init test &&
    ++		echo "path.cdup=$(pwd)/tmp/x" >test/expect &&
     +		cd test &&
     +		GIT_WORK_TREE=../tmp/x &&
     +		export GIT_WORK_TREE &&
-- 
2.56.0-rc2
