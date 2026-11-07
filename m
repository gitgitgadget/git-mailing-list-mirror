Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081427;
	b=qAk6DMgnpssl9J/ObzqcTquKTNwOof3TlqWRAzbec+3JH2CAYxwrhErR4BnfBt/bVr07
	 LHRtuUuoryb5dpaPkDY2hAuCdAZGJ5BvA5kbdqfYSIbIZ1YhgkPg/WA5VlCcrFBPj4fpz
	 crEnwDHVj6iANEkt7O4my4BBLvo7mqfJA9yKdSCNqNGKkf7/JIc60dJaX/YcaI8ytytfx
	 /kLnI1NNmlRt9yySzRXEjsxbU8Me9L0PLBIiJw+ecOs3snGAv16CB+F3VK8NtRv5WaLul
	 VFTuAB8m+86IPQEvrstagxTP36DunNRQnsnNuFCVTxnVwFGRqUH5G6rrp30aHPgEv2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081427;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Reply-To:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=3PJglLzxYrEeOXLHiCP1j39tqytjEBiZbp9CkbYCBSE=;
	b=EL7Bvux3f5yPbUwJDmpwDCamdAOF4wN7GiNV0kDREBhAbq/mzlyuYG0y0yzupxAw6Z15
	 98mPGXNSH2yqyOwGchGiGNZ4OL4CTKBwdJIMitKW9yM6zrKOoYJSmvXX6+L/vj5lDdIzs
	 RWoIUuKx3IHOzWxM1XRpuTbeAGS3i9PiHAk9IwoZpDOLXA5EOP97LyT38eTqnrBs/GnQX
	 ANYi1EG3h4p+vU3/Hvbj5MkVOizlPQWMpDDFw0G90KIbq14HgKgOEMgcIbFSEJMo5QkB/
	 h/8cC/5zXZpJOt2W0L/MdRvmFJEkG/V+2IrmShCCOHUxZq17rAD8/q/lGJWHG2M07kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pYH76eyX;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A4A606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37A4A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pYH76eyX
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so11575025e9.2
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 11:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081425; x=1794686225; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3PJglLzxYrEeOXLHiCP1j39tqytjEBiZbp9CkbYCBSE=;
        b=pYH76eyXLWIaPMk4pI1CxRc2lXU3elo1byFx31iVIZqtZvZYmRqBu5S9+b98NkDJrP
         6CFZ2rCrwuVJYNXn50bHu6VYeT43GqmSqRckkmGyLVmlMI7QDAwRIaYy8inbawa+tYQ3
         NLGDIEhS58h2KnwrAqCn5yS1Li+QC3F7esO2J7s/YnrFfA0uEilYms7E7uPKcQi7vo69
         o8Td02CMKDI72dOA2Y6AswjgAk/m6kqkkfZ+4Uqdx5qXq3DdYqYDz4yISn1Lk1QKZk8D
         g2nBpqi0QbqIatAmPZlHeUSvk2gaJbwxpXzKiuNgx6b7mINpPXudFMDsq810K7HPLcuR
         aKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081425; x=1794686225;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PJglLzxYrEeOXLHiCP1j39tqytjEBiZbp9CkbYCBSE=;
        b=EdATVUk3G8voLUAeXdV3eaSH0Y5PtI+8xW4BVO+bftuKe/3oS+x6ckubT6DE2ZzobD
         31cW9IVNkuk80CBf4aP80jTtTbrFZFm1D+lrZNC6+1ISJLdJOPTGHzaU665YrubbVbXn
         IkPg5ciNEBV2RJrEUogu+MRt7rEnm4NnRoRWxGQ5O3HNJgCxDd3hEd7CayD669J7aFNT
         e7UwPp5TBiEQP0ao/USNEJ1R4Q+YJjrmmsWakAb9/S2c0YxHbKmdxXuDdS/lD45pEf6I
         L/b9zL1N8jo8wjPaOfxoAbajoB9bLaDA2Np2r4P19pDCypjQKK1drakYN8pRL5/bVVsR
         1ugw==
X-Gm-Message-State: APuU4Z+3klYmU2FahzlvBfbwuHbcczgF0r1QcPRuqN/w3ZbsixlE011S
	MFfPT+kmgRuykQNXe88p5VaHYaY7pvLI+M29cmB2CT2I8XTfzToXyL4A
X-Gm-Gg: AYBFou3EVx7IaZ2WM8Z93NDsmyL9XlK++XY83sPcG0ERvcytADg0/zCxBfOWiNy/HS7
	0SKGZSOtg8aOeQb7aUJL/QpPXiSRN6MQtJmxe3DJ/eBnw6ag/Aa7EiwUKmmLBB1f+SNu7P0FGcw
	dqFwb7sv8MmzCJzVnV6Hv1dudL2oX13g1ENdr1xhGElFmTOrxEo2I5TxDbYl+gqxMPH/lqx03hH
	bT2bKeFjPxuWNW7mTlVsr/u9b9/Hh3GmVEU/nGk3jLgA7NxMSXby6T3hqAjwkAT83uCwHre7Oba
	LGcrhPE5IAs47lc4ZYbWkQI1rUcEXGcpBIFToRbWSvwVJOXfqfFGjEY2CqrgsZVjEuWmUN4mlAy
	ATz8S37YXfYJDwaYvD0QGc5JNpsMFaXAbQu5CYWQvvbBB8fIaui8CHO5IQmB59AdxaMvvtVc6El
	fGAwcAPSsp9aa0K9NltQF+KMw1UMG4PxolxVnLdi5RDyfHVoQwVDseKxMFRef3wtSAWkgggWUty
	hhaUs6Zg0ZRxB03NCvEQ5Ii7p8zGTNUI5p5tDN9o3ZBFXp58QXggA1Giz45N2t2WjNfZj6Pg+c3
	1ijWjrmafUbz5H0g5JrhgjsSlY4PaY9AkEVPz87z6e2uxjna1iPJifMDpwrZxZF0bKrXz9JbSG3
	Ds5NK1HuzbC+QkWKek722AEZ7mtM=
X-Received: by 2002:a05:600c:64c5:b0:4b0:a7aa:843 with SMTP id 5b1f17b1804b1-4b6df4f1dfdmr107823275e9.25.1794081425177;
        Sat, 07 Nov 2026 11:57:05 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723283dsm10756184f8f.23.2026.11.07.11.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Nov 2026 11:57:03 -0800 (PST)
Message-ID: <9582c0da-7aff-466c-a510-ce5a10054df4@gmail.com>
Date: Sat, 7 Nov 2026 19:57:02 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC Patch v8 0/7] repo: add path keys to repo info
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, lucasseikioshiro@gmail.com
References: <20260716012138.6714-1-jayatheerthkulkarni2005@gmail.com>
 <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261107160100.122243-1-jayatheerthkulkarni2005@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07/11/2026 16:00, K Jayatheerth wrote:

I'm a bit late to the party, I like the idea of adding some more paths 
to "git repo", but I have a few comments about the design of this series.

> This patch series continues the work to expose repository paths and
> metadata via the `git repo info` command. It introduces several keys for
> querying repository paths in standard absolute and relative formats, as well
> as refactoring `get_superproject_working_tree()` to operate on a `struct
> repository *`.
> 
> The path keys added in this series are:
>    - `path.toplevel.absolute` / `path.toplevel.relative`: The root directory
>      of the working tree (or an empty string in bare repositories).

In our documentation and glossary, we call this directory the "working 
tree" so I think "path.working-tree.*" would be a better name, rather 
than copying the name from the equivalent rev-parse option.

>    - `path.superproject-root.absolute` / `path.superproject-root.relative`:
>      The root of the superproject when inside a submodule.

Personally, I'd prefer "path.superproject-working-tree.*" here, though I 
see Justin thought that was a bit of a mouthful. As this command is for 
use in scripts I'd rather have a descriptive name.

>    - `path.hooks.absolute` / `path.hooks.relative`: The repository's hooks
>      directory (respecting `core.hooksPath`, including `/dev/null`).

Given we have config based hooks now, do we really want to add this? 
Scripts that want to run hooks should be using "git hook run" and 
scripts that want to install hooks should be using the config based 
hooks so that they co-exist with the user's existing hooks.

>    - `path.index.absolute` / `path.index.relative`: The repository's active
>      index file.
>    - `path.git-prefix`: The prefix from the worktree root to the current
>      working directory.

The "git-" prefix seems a bit odd to me, maybe "path.prefix" would be a 
better name for an option that returns the prefix to add to paths?

>    - `path.cdup`: The relative path from the current directory up to the
>      worktree root.

How does this differ from path.working-tree.relative? I've never really 
understood "git rev-parse --cdup" - if you're in the repository root 
directory, 'cd "$(git rev-parse --cdup)"' dumps you in your home 
directory which has always seemed a bit surprising to me.

One note on the tests - our test suite is quite slow, so it would be 
good to avoid initializing new repositories for each test where we are 
checking these paths.

Thanks

Phillip

> Changes since v7:
>    - Dropped `path.grafts`.
>    - In patch 2 (`submodule: use repository to find superproject`), moved the
>      test for `--git-dir` to `t/t1500-rev-parse.sh` exercising the existing
>      `rev-parse --show-superproject-working-tree` interface (since
>      `path.superproject-root` is only added in patch 3), and ensured clean
>      isolation of test directories (`sub` and `super`).
>    - In patch 3 (`path.superproject-root`), simplified the getter functions
>      by eliminating redundant early returns.
>    - In patch 4 (`path.hooks`):
>      - Special-cased `/dev/null` in both `path.hooks.absolute` and
>        `path.hooks.relative` to output `/dev/null` directly, making it easy
>        for scripts to detect when hooks are disabled. Documented this
>        behavior in `Documentation/git-repo.adoc`.
>      - Reverted changes to the `test_repo_info_path` helper in
>        `t/t1900-repo-info.sh` and wrote a standalone test block for the
>        `/dev/null` case.
>      - Set `hooksPath = /dev/null` directly in the config file rather than
>        passing it through `git config core.hooksPath /dev/null` to prevent
>        MSYS2 argument mangling on Windows (which rewrites `/dev/null` to
>        `nul`), allowing the test to run portably on all platforms without
>        requiring `!MINGW`.
>    - In patch 7 (`path.cdup`), removed unnecessary braces on the single-line
>      `if`, added an early return when invoked outside a worktree, and ensured
>      `cd repo` in the test runs within a subshell.
> 
> Thanks to Justin Tobler and Lucas Seiki Oshiro for their reviews and
> mentorship.
> 
> K Jayatheerth (7):
>    repo: add path.toplevel with absolute and relative suffix formatting
>    submodule: use repository to find superproject
>    repo: add path.superproject-root with absolute and relative suffixes
>    repo: add path.hooks with absolute and relative suffixes
>    repo: add path.index with absolute and relative suffixes
>    repo: add path.git-prefix
>    repo: add path.cdup
> 
>   Documentation/git-repo.adoc |  52 ++++++++++
>   builtin/repo.c              | 131 +++++++++++++++++++++++++
>   builtin/rev-parse.c         |   2 +-
>   submodule.c                 |  43 +++++----
>   submodule.h                 |   2 +-
>   t/t1500-rev-parse.sh        |  20 ++++
>   t/t1900-repo-info.sh        | 185 ++++++++++++++++++++++++++++++++++++
>   7 files changed, 412 insertions(+), 23 deletions(-)
> 
> Range-diff against v7:
> 5:  351b4b7de7 ! 1:  27b9811163 repo: add path.grafts with absolute and relative suffixes
>      @@ Metadata
>       Author: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
>       
>        ## Commit message ##
>      -    repo: add path.grafts with absolute and relative suffixes
>      +    repo: add path.toplevel with absolute and relative suffix formatting
>       
>      -    The repository grafts file specifies alternate parent relationships for
>      -    commits and may be used by repository tooling that needs to inspect or
>      -    manage grafts. Scripts currently retrieve its location by invoking
>      -    `git rev-parse --git-path info/grafts`.
>      +    Scripts frequently need to find the root directory of a repository's
>      +    working tree. Currently, this requires using `git rev-parse --show-toplevel`
>      +    or inferring it from other repository information.
>       
>      -    Introduce `path.grafts.absolute` and `path.grafts.relative` keys to
>      -    `git repo info`. This exposes the grafts file location as a scriptable
>      -    config-like key using standard format rules, allowing scripts to
>      -    retrieve it through the same interface as other repository path
>      -    information.
>      +    Introduce `path.toplevel.absolute` and `path.toplevel.relative` keys
>      +    to `git repo info`. This allows scripts to retrieve the top-level
>      +    working tree path in a predictable, strictly formatted manner without
>      +    relying on `rev-parse`.
>      +
>      +    If requested in a bare repository where no working tree exists, the
>      +    command returns an empty string.
>       
>           Mentored-by: Justin Tobler <jltobler@gmail.com>
>           Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
>      @@ Documentation/git-repo.adoc: values that they return:
>        `path.gitdir.relative`::
>        	The path to the Git repository directory relative to the current working directory.
>        
>      -+`path.grafts.absolute`::
>      -+	The canonical absolute path to the repository's graft file.
>      -+	Respects the `GIT_GRAFT_FILE` environment override. The path is
>      -+	returned regardless of whether the file currently exists on disk.
>      ++`path.toplevel.absolute`::
>      ++	The canonical absolute path to the top-level directory of the
>      ++	repository's working tree. Outputs an empty string if the repository
>      ++	is bare.
>       +
>      -+`path.grafts.relative`::
>      -+	The path to the repository's graft file relative to the current
>      -+	working directory. Respects the `GIT_GRAFT_FILE` environment
>      -+	override. The path is returned regardless of whether the file
>      -+	currently exists on disk.
>      ++`path.toplevel.relative`::
>      ++	The path to the top-level directory of the repository's working
>      ++	tree relative to the current working directory. Outputs an empty
>      ++	string if the repository is bare.
>       +
>      - `path.hooks.absolute`::
>      - 	The canonical absolute path to the repository's hooks directory.
>      - 	Respects the `core.hooksPath` configuration. If `core.hooksPath` is
>      + `references.format`::
>      + 	The reference storage format. The valid values are:
>      + +
>       
>        ## builtin/repo.c ##
>       @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, struct strbuf *buf)
>        	return 0;
>        }
>        
>      -+static int get_path_grafts_absolute(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_toplevel_absolute(struct repository *repo, struct strbuf *buf)
>       +{
>      -+	const char *graft_file = repo_get_graft_file(repo);
>      ++	const char *work_tree = repo_get_work_tree(repo);
>       +
>      -+	if (!graft_file)
>      -+		return error(_("unable to get graft file"));
>      ++	if (!work_tree)
>      ++		return 0;
>       +
>      -+	format_path(buf, graft_file, "", PATH_FORMAT_CANONICAL);
>      ++	format_path(buf, work_tree, "", PATH_FORMAT_CANONICAL);
>       +	return 0;
>       +}
>       +
>      -+static int get_path_grafts_relative(struct repository *repo, struct strbuf *buf)
>      ++static int get_path_toplevel_relative(struct repository *repo, struct strbuf *buf)
>       +{
>      -+	const char *graft_file = repo_get_graft_file(repo);
>      ++	const char *work_tree = repo_get_work_tree(repo);
>       +
>      -+	if (!graft_file)
>      -+		return error(_("unable to get graft file"));
>      ++	if (!work_tree)
>      ++		return 0;
>       +
>      -+	format_path(buf, graft_file, repo->prefix, PATH_FORMAT_RELATIVE);
>      ++	format_path(buf, work_tree, repo->prefix, PATH_FORMAT_RELATIVE);
>       +	return 0;
>       +}
>       +
>      - static int get_path_hooks_absolute(struct repository *repo, struct strbuf *buf)
>      + static int get_references_format(struct repository *repo, struct strbuf *buf)
>        {
>      - 	struct strbuf hooks_path = STRBUF_INIT;
>      + 	strbuf_addstr(buf,
>       @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>        	{ "path.commondir.relative", get_path_commondir_relative },
>        	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>        	{ "path.gitdir.relative", get_path_gitdir_relative },
>      -+	{ "path.grafts.absolute", get_path_grafts_absolute },
>      -+	{ "path.grafts.relative", get_path_grafts_relative },
>      - 	{ "path.hooks.absolute", get_path_hooks_absolute },
>      - 	{ "path.hooks.relative", get_path_hooks_relative },
>      - 	{ "path.index.absolute", get_path_index_absolute },
>      ++	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>      ++	{ "path.toplevel.relative", get_path_toplevel_relative },
>      + 	{ "references.format", get_references_format },
>      + };
>      +
>       
>        ## t/t1900-repo-info.sh ##
>       @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
>        	'.git' \
>        	'GIT_DIR="../.git" && export GIT_DIR'
>        
>      -+test_repo_info_path 'grafts standard' 'grafts' '.git/info/grafts'
>      ++test_expect_success 'path.toplevel absolute and relative' '
>      ++	test_when_finished "rm -rf repo" &&
>      ++	git init repo &&
>      ++	(
>      ++		mkdir -p repo/sub &&
>      ++		cd repo/sub &&
>       +
>      -+test_repo_info_path 'grafts with GIT_GRAFT_FILE override' 'grafts' \
>      -+	'custom-graft-file' \
>      -+	'GIT_GRAFT_FILE="$ROOT/custom-graft-file" && export GIT_GRAFT_FILE'
>      ++		ROOT="$(test-tool path-utils real_path ..)" &&
>       +
>      - test_repo_info_path 'hooks standard' 'hooks' '.git/hooks'
>      -
>      - test_repo_info_path 'hooks with core.hooksPath override' 'hooks' \
>      ++		echo "path.toplevel.absolute=$ROOT" >expect.abs &&
>      ++		git repo info path.toplevel.absolute >actual.abs &&
>      ++		test_cmp expect.abs actual.abs &&
>      ++
>      ++		echo "path.toplevel.relative=../" >expect.rel &&
>      ++		git repo info path.toplevel.relative >actual.rel &&
>      ++		test_cmp expect.rel actual.rel
>      ++	)
>      ++'
>      ++
>      ++test_expect_success 'path.toplevel absolute and relative in a bare repository' '
>      ++	test_when_finished "rm -rf bare.git" &&
>      ++	git init --bare bare.git &&
>      ++	(
>      ++		cd bare.git &&
>      ++
>      ++		echo "path.toplevel.absolute=" >expect.abs &&
>      ++		git repo info path.toplevel.absolute >actual.abs &&
>      ++		test_cmp expect.abs actual.abs &&
>      ++
>      ++		echo "path.toplevel.relative=" >expect.rel &&
>      ++		git repo info path.toplevel.relative >actual.rel &&
>      ++		test_cmp expect.rel actual.rel
>      ++	)
>      ++'
>      ++
>      + test_done
> 1:  7c90603a1b ! 2:  2274dd8be2 submodule: use repository to find superproject
>      @@ submodule.h: void absorb_git_dir_into_superproject(const char *path,
>        
>        #endif
>       
>      - ## t/t7400-submodule-basic.sh ##
>      -@@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add fails when name is reused' '
>      + ## t/t1500-rev-parse.sh ##
>      +@@ t/t1500-rev-parse.sh: test_expect_success ':/ and HEAD^{/} favor more recent matching commits' '
>        	)
>        '
>        
>      -+test_expect_success 'path.superproject-root works with --git-dir' '
>      ++test_expect_success '--show-superproject-working-tree works with --git-dir' '
>      ++	rm -rf sub super &&
>       +	test_when_finished "rm -rf sub super" &&
>       +	git init sub &&
>       +	test_commit -C sub initial &&
>      @@ t/t7400-submodule-basic.sh: test_expect_success 'submodule add fails when name i
>       +		SUPER_ROOT="$(test-tool path-utils real_path .)" &&
>       +		MODULE_DIR="$SUPER_ROOT/.git/modules/sub" &&
>       +
>      -+		echo "path.superproject-root.absolute=$SUPER_ROOT" >expect &&
>      -+		git --git-dir="$MODULE_DIR" repo info path.superproject-root.absolute >actual &&
>      ++		echo "$SUPER_ROOT" >expect &&
>      ++		git --git-dir="$MODULE_DIR" rev-parse --show-superproject-working-tree >actual &&
>       +		test_cmp expect actual
>       +	)
>       +'
> 2:  1bfb0c8c1d ! 3:  34c54cdafd repo: add path.superproject-root with absolute and relative suffixes
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +{
>       +	struct strbuf superproject = STRBUF_INIT;
>       +
>      -+	if (!get_superproject_working_tree(repo, &superproject)) {
>      -+		strbuf_release(&superproject);
>      -+		return 0;
>      -+	}
>      ++	if (get_superproject_working_tree(repo, &superproject))
>      ++		format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
>       +
>      -+	format_path(buf, superproject.buf, "", PATH_FORMAT_CANONICAL);
>       +	strbuf_release(&superproject);
>       +	return 0;
>       +}
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +{
>       +	struct strbuf superproject = STRBUF_INIT;
>       +
>      -+	if (!get_superproject_working_tree(repo, &superproject)) {
>      -+		strbuf_release(&superproject);
>      -+		return 0;
>      -+	}
>      ++	if (get_superproject_working_tree(repo, &superproject))
>      ++		format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
>       +
>      -+	format_path(buf, superproject.buf, repo->prefix, PATH_FORMAT_RELATIVE);
>       +	strbuf_release(&superproject);
>       +	return 0;
>       +}
> 3:  09d2937fcd ! 4:  985403c7b3 repo: add path.hooks with absolute and relative suffixes
>      @@ Documentation/git-repo.adoc: values that they return:
>       +
>       +`path.hooks.relative`::
>       +	The path to the repository's hooks directory relative to the current
>      -+	working directory. Respects the `core.hooksPath` configuration.
>      ++	working directory. Respects the `core.hooksPath` configuration. If
>      ++	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
>       +
>        `path.superproject-root.absolute`::
>        	The canonical absolute path to the working tree root of the superproject
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +	struct strbuf hooks_path = STRBUF_INIT;
>       +
>       +	repo_git_path_replace(repo, &hooks_path, "hooks");
>      -+	format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
>      ++	if (!strcmp(hooks_path.buf, "/dev/null"))
>      ++		strbuf_addstr(buf, "/dev/null");
>      ++	else
>      ++		format_path(buf, hooks_path.buf, "", PATH_FORMAT_CANONICAL);
>      ++
>       +	strbuf_release(&hooks_path);
>       +	return 0;
>       +}
>      @@ builtin/repo.c: static int get_path_gitdir_relative(struct repository *repo, str
>       +	struct strbuf hooks_path = STRBUF_INIT;
>       +
>       +	repo_git_path_replace(repo, &hooks_path, "hooks");
>      -+	format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
>      ++	if (!strcmp(hooks_path.buf, "/dev/null"))
>      ++		strbuf_addstr(buf, "/dev/null");
>      ++	else
>      ++		format_path(buf, hooks_path.buf, repo->prefix, PATH_FORMAT_RELATIVE);
>      ++
>       +	strbuf_release(&hooks_path);
>       +	return 0;
>       +}
>      @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>        	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>       
>        ## t/t1900-repo-info.sh ##
>      -@@ t/t1900-repo-info.sh: test_repo_info_path () {
>      - 			cd repo/sub &&
>      - 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
>      - 			eval "$init_command" &&
>      --			echo "path.$field_name.absolute=$ROOT/$expected_dir" >expect &&
>      -+			case "$expected_dir" in
>      -+			/*) EXPECT_ABS="$expected_dir" ;;
>      -+			*) EXPECT_ABS="$ROOT/$expected_dir" ;;
>      -+			esac &&
>      -+			echo "path.$field_name.absolute=$EXPECT_ABS" >expect &&
>      - 			git repo info "path.$field_name.absolute" >actual &&
>      - 			test_cmp expect actual
>      - 		)
>      -@@ t/t1900-repo-info.sh: test_repo_info_path () {
>      - 			cd repo/sub &&
>      - 			ROOT="$(test-tool path-utils real_path ..)" && export ROOT &&
>      - 			eval "$init_command" &&
>      --			echo "path.$field_name.relative=../$expected_dir" >expect &&
>      -+			case "$expected_dir" in
>      -+			/*) EXPECT_REL="$(test-tool path-utils relative_path "$expected_dir" "$PWD")" ;;
>      -+			*) EXPECT_REL="../$expected_dir" ;;
>      -+			esac &&
>      -+			echo "path.$field_name.relative=$EXPECT_REL" >expect &&
>      - 			git repo info "path.$field_name.relative" >actual &&
>      - 			test_cmp expect actual
>      - 		)
>       @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir' \
>        	'.git' \
>        	'GIT_DIR="../.git" && export GIT_DIR'
>      @@ t/t1900-repo-info.sh: test_repo_info_path 'gitdir with explicit GIT_DIR' 'gitdir
>       +	'custom-hooks' \
>       +	'git config core.hooksPath "$ROOT/custom-hooks" && mkdir -p "$ROOT/custom-hooks"'
>       +
>      -+# /dev/null is not a real, canonicalizable filesystem path on Windows,
>      -+# so path resolution for core.hooksPath=/dev/null cannot be expected to
>      -+# produce a literal "/dev/null" the way it does on POSIX systems.
>      -+if ! test_have_prereq MINGW
>      -+then
>      -+	test_repo_info_path 'hooks with core.hooksPath=/dev/null' 'hooks' \
>      -+		'/dev/null' \
>      -+		'git config core.hooksPath /dev/null'
>      -+fi
>      ++test_expect_success 'hooks with core.hooksPath=/dev/null' '
>      ++	test_when_finished "rm -rf repo" &&
>      ++	git init repo &&
>      ++	(
>      ++		mkdir -p repo/sub &&
>      ++		cd repo/sub &&
>      ++		cat >>../.git/config <<-\EOF &&
>      ++		[core]
>      ++			hooksPath = /dev/null
>      ++		EOF
>      ++		echo "path.hooks.absolute=/dev/null" >expect.abs &&
>      ++		echo "path.hooks.relative=/dev/null" >expect.rel &&
>      ++		git repo info path.hooks.absolute >actual.abs &&
>      ++		git repo info path.hooks.relative >actual.rel &&
>      ++		test_cmp expect.abs actual.abs &&
>      ++		test_cmp expect.rel actual.rel
>      ++	)
>      ++'
>       +
>        test_expect_success 'path.superproject-root absolute and relative' '
>        	test_when_finished "rm -rf sub super" &&
> 4:  d0c186f150 ! 5:  486836ae52 repo: add path.index with absolute and relative suffixes
>      @@ Commit message
>       
>        ## Documentation/git-repo.adoc ##
>       @@ Documentation/git-repo.adoc: values that they return:
>      - 	The path to the repository's hooks directory relative to the current
>      - 	working directory. Respects the `core.hooksPath` configuration.
>      + 	working directory. Respects the `core.hooksPath` configuration. If
>      + 	`core.hooksPath` is set to `/dev/null`, that value is returned unchanged.
>        
>       +`path.index.absolute`::
>       +	The canonical absolute path to the repository's current index file.
>      @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>        	{ "path.toplevel.absolute", get_path_toplevel_absolute },
>       
>        ## t/t1900-repo-info.sh ##
>      -@@ t/t1900-repo-info.sh: then
>      - 		'git config core.hooksPath /dev/null'
>      - fi
>      +@@ t/t1900-repo-info.sh: test_expect_success 'hooks with core.hooksPath=/dev/null' '
>      + 	)
>      + '
>        
>       +test_repo_info_path 'index standard' 'index' '.git/index'
>       +
> 6:  ef69d4aa8c ! 6:  91a8dc3ab1 repo: add path.git-prefix
>      @@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
>       +	{ "path.git-prefix", get_path_git_prefix },
>        	{ "path.gitdir.absolute", get_path_gitdir_absolute },
>        	{ "path.gitdir.relative", get_path_gitdir_relative },
>      - 	{ "path.grafts.absolute", get_path_grafts_absolute },
>      + 	{ "path.hooks.absolute", get_path_hooks_absolute },
>       
>        ## t/t1900-repo-info.sh ##
>       @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commondir' \
> 7:  3e61728dba ! 7:  84a9fb4060 repo: add path.cdup
>      @@ builtin/repo.c: static int get_object_format(struct repository *repo, struct str
>       +	if (!is_inside_work_tree(repo)) {
>       +		const char *worktree = repo_get_work_tree(repo);
>       +
>      -+		if (worktree) {
>      ++		if (worktree)
>       +			strbuf_addstr(buf, worktree);
>      -+		}
>      ++		return 0;
>       +	}
>       +
>       +	while (pfx) {
>      @@ t/t1900-repo-info.sh: test_repo_info_path 'commondir with only GIT_DIR' 'commond
>       +test_expect_success 'path.cdup cwd outside the working tree' '
>       +	test_when_finished "rm -rf repo" &&
>       +	mkdir -p repo/tmp/x &&
>      -+	cd repo &&
>      -+	git init test &&
>       +	(
>      -+		echo path.cdup=$(pwd)/tmp/x >./test/expect &&
>      ++		cd repo &&
>      ++		git init test &&
>      ++		echo "path.cdup=$(pwd)/tmp/x" >test/expect &&
>       +		cd test &&
>       +		GIT_WORK_TREE=../tmp/x &&
>       +		export GIT_WORK_TREE &&

