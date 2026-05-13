Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56771DF261
	for <git@vger.kernel.org>; Wed, 13 May 2026 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680935; cv=none; b=SNUY2kKdVNg5snxFkzV/mIQd++lsKucx6h6SdJAz1/uvdwe3CqUFuPbbBeFba3ZQLYmYKWhAujJZopuKfHkoPw7TOKk0je77t4hicKTzbNZXkcK4CkSEJrHe6ktkCKE4zRPpeb/l048dHvXLxi35SnAmLQ8+PiF6AB87XmGyFZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680935; c=relaxed/simple;
	bh=fD4Q/yEe3KtRN+FyrxhiiMkJ4pi57BIVCqXeFLZEAng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7oN6BnIVMP4w1m+6npdULwcXxkHtt6ZpTzmmTYuQTJUfCj/LxNoxQJrqmg7Kr02xcfa/GcpjFSjCNx0q5AJZmMf+zEbAfLX07UeuHidienWIxURSgEsrYN2yJtf9U4xT7fov202UAOXU+NXmX9JFpVzG3WPrJ+yVoHX/QU2trE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sn3OdndQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sn3OdndQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b150559bso53529675e9.1
        for <git@vger.kernel.org>; Wed, 13 May 2026 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680932; x=1779285732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=EkjbxapHoWQRVCr0W04GePb7dMea09zsMJ7rgFMoDLU=;
        b=Sn3OdndQLCUb8sGhA8rllijJZlU53yVajnvk+P9VURGnYGu4RAwMK669JDY+1eiFlq
         Lzib5BmiORL5SZdL5UzLh311gDvTu3nWdqxVBz7A3YkBirjIGiT2c0aua1tVTvF0G9a/
         uJJXc+1esFktFQCqjpGVCJKnCACLANEiD8fObfnyADcRfo70/XJilj+ctYf3Vhq5fxAh
         QXeCtliax6Z4cTTiClP9Nn0oXFh900OPJCCJWEMNIxUspZaiOPsV0/hmXRjHhFsZ6gxh
         t5m5IGa7E1IL3trmFmaKlhOMt0Le3kkNJYzwAKF97H3ZlwbvTTw5kCfDsoQFamPp6dLd
         Ii0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680932; x=1779285732;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EkjbxapHoWQRVCr0W04GePb7dMea09zsMJ7rgFMoDLU=;
        b=Ib13K56TDeSFrUgMZD1+iKNFKmgl2LuyTvfPg8Qye3ycU5946gQMg9JGxi9aUVdz9Z
         gvTyyJmlkc791k6y+On0Ijj2Dd/6F4VCYf7HwOgfXmXjINaa1CZRxsgpUTGdY5s3FCoq
         0FMsoOlptaytyUNq/+3/NJo+pNGD53c18ZPxmTYBKl9+qJ7DdQ23Ni37gWjgJklFuhSG
         oDTgZ0maKmZL1SC61XZie/zEEmFSIBcJQ43fP8vPplk/iljasiG1ACxF3o5sQ+5vOjX6
         iMBQjs5K5MIsNki300oBpzT+j6xFsrNrD5Jgf0NpM6ruTNqVVmU4Bu5S7TOwuQ5xDDV4
         R1/A==
X-Forwarded-Encrypted: i=1; AFNElJ+5a6jCWNrFkv14Gg456s+4kfVpe94WhejnCPM/M8ZW8+I4Cf8l3Co5PdO24ljBZ05z/2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvMm0v5VfU5lisc56VNcK+r37sX5eEy5Wz+EIkdzgO9T7m/JPB
	Jf6wtrwhGj4Tur+9JJqFD/x5RYpQQtGcb9zy3XIhl5XOP8MBsy6uiPdz
X-Gm-Gg: Acq92OGf6mwm7mXCKCZnSA3+ipX0VKibW6vLSGWuBBOC7Lm+o5Jd2MmUambOhaFLd7N
	zsO5UOZbIM7Yq5cU1xn8mbh0oMwM0VLonn+bffBaKatWEMLW7WqDI/l3QYYLZ04lZG3h8dcyfGU
	TmbfurK+q1Zim79n21UW95MrLxUO645FMA+q1CWgBlI22sXtYTtYxk6/Wkx2nJj00fIdKBy+UtV
	hoGtTcdreuoN3E6M9kKvZIGTfADvKefvCJMmyWoZiebas7sw5tdzFww9W5swSBmsVA60Lw5tESR
	MJ23P+kyjzx0ruu+ClEwk9Dc1OF5OHYjjwQzhNYJikMliNf3wS2IE90OQSdqEzUBmWdF/czxfE/
	+U5KFf3hQn3nLphQqg17gd51LQDuFAfyO7/RlMmuxMaSm1ZIebhvmwRCm72TtHKSswMeCVRxXWY
	8qlhAOVbSMM8aXEtVK7lijURpYsErrGgF/DxDFRuPRpd5YxZqy0qcOFz/wJjxgssROch7DxAS3H
	luSmw==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35f1 with SMTP id 5b1f17b1804b1-48fc9a030eemr43900635e9.4.1778680932101;
        Wed, 13 May 2026 07:02:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491304505sm41164693f8f.22.2026.05.13.07.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 07:02:11 -0700 (PDT)
Message-ID: <bea48414-217b-4860-9279-fe94e3687c28@gmail.com>
Date: Wed, 13 May 2026 15:02:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3] ignore: note info/exclude lives in GIT_COMMON_DIR, not
 GIT_DIR
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org
Cc: "brian m . carlson" <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Elijah Newren <newren@gmail.com>, Andrew Berry <andrew@furrypaws.ca>,
 Jeff King <peff@peff.net>, Derrick Stolee <stolee@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>,
 Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
 Dan Drake <dan@dandrake.org>, Alex Galvin <agalvin@comqi.com>
References: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
 <ec97ad3f054e90b675f099a36a81a23bb4b2a0ed.1778620784.git.ben.knoble+github@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <ec97ad3f054e90b675f099a36a81a23bb4b2a0ed.1778620784.git.ben.knoble+github@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ben

On 12/05/2026 22:21, D. Ben Knoble wrote:
> gitignore(5) says that the per-repository ignore file is
> $GIT_DIR/info/exclude, but in a worktree that is not the case:
> 
>      git rev-parse --git-path info/exclude
>      /path/to/main/worktree/.git/info/exclude
>      git rev-parse --git-common-dir
>      /path/to/main/worktree/.git
> 
> We actually use $GIT_COMMON_DIR/info/exclude. Adjust the documentation
> and some code comments to say so.

Thanks for the re-roll, this looks good to me

Phillip

> Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
> ---
> 
> Notes (benknoble/commits):
>      Changes in v3:
>      
>      Adjust more occurrences
>      
>      Link to v2: <d58b6e921d3005c6170fc6c47f175214acb3fa68.1778249267.git.ben.knoble+github@gmail.com>
>      
>      Changes in v2:
>      
>      Only adjust the documentation.
>      
>      brian points out that a more general extension would allow using more
>      info/ files as "per-worktree," which I don't have the impetus to
>      implement myself.
>      
>      Phillip and Junio asked for a concrete use case:
>      
>          A colleague is developing a tool for managing the "skill files" of
>          various LLM tools (Claude, Windsurf, etc.). The files have
>          requirements that make it hard to generically ignore them (e.g.,
>          filenames and front-matter have to match), but different tasks
>          (corresponding to worktrees) may want different active skills, so it
>          is desirable to ignore the files. Think of this like node_modules.
>      
>          Unfortunately, since per-worktree ignores don't work, the current
>          solution is to put a .gitignore file in the corresponding directory
>          with the installed skills that ignores itself and the installed
>          skills.
>      
>      Since overall reactions seem fairly negative (or require a more general
>      extension, which I think is probably the right course but not simply
>      implemented), I've opted to adjust the docs. They originally confused
>      me, as I was surprised when my colleague reported that per-worktree
>      ignores didn't work (the docs imply they should by use of $GIT_DIR).
>      
>      Link to v1: <e3ee0a11b566dd2cc605447c111ae4620bce0fe6.1777050300.git.ben.knoble+github@gmail.com>
>      
>      v1 notes:
>      
>      Discussed briefly at https://lore.kernel.org/git/CALnO6CCXmA+ATT7CuyWkU6P8qmLCCpMi5Ppr1c78s0heznpVyw@mail.gmail.com/T
>      
>      This is based on next (4f69b47b94 (Merge branch 'ps/test-set-e-clean'
>      into next, 2026-04-23)) but cleanly applies to master (94f057755b (Git
>      2.54, 2026-04-19)) and seen (50541634cb (Merge branch
>      'js/parseopt-subcommand-autocorrection' into seen, 2026-04-23)).
> 
>   Documentation/git-ls-files.adoc    |  2 +-
>   Documentation/git-svn.adoc         |  2 +-
>   Documentation/gitformat-index.adoc |  4 ++--
>   Documentation/gitignore.adoc       | 12 ++++++------
>   dir.c                              |  4 ++--
>   dir.h                              |  2 +-
>   6 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/git-ls-files.adoc b/Documentation/git-ls-files.adoc
> index 58c529afbe..2b175388e1 100644
> --- a/Documentation/git-ls-files.adoc
> +++ b/Documentation/git-ls-files.adoc
> @@ -331,7 +331,7 @@ can give `--exclude-per-directory=.gitignore`, and then specify:
>     1. The file specified by the `core.excludesfile` configuration
>        variable, if exists, or the `$XDG_CONFIG_HOME/git/ignore` file.
>   
> -  2. The `$GIT_DIR/info/exclude` file.
> +  2. The `$GIT_COMMON_DIR/info/exclude` file.
>   
>   via the `--exclude-from=` option.
>   
> diff --git a/Documentation/git-svn.adoc b/Documentation/git-svn.adoc
> index c26c12bab3..2a7fa60465 100644
> --- a/Documentation/git-svn.adoc
> +++ b/Documentation/git-svn.adoc
> @@ -439,7 +439,7 @@ Any other arguments are passed directly to 'git log'
>   'show-ignore'::
>   	Recursively finds and lists the svn:ignore and svn:global-ignores
>   	properties on directories. The output is suitable for appending to
> -	the $GIT_DIR/info/exclude file.
> +	the $GIT_COMMON_DIR/info/exclude file.
>   
>   'mkdirs'::
>   	Attempts to recreate empty directories that core Git cannot track
> diff --git a/Documentation/gitformat-index.adoc b/Documentation/gitformat-index.adoc
> index 145cace1fe..f6a427cb49 100644
> --- a/Documentation/gitformat-index.adoc
> +++ b/Documentation/gitformat-index.adoc
> @@ -291,14 +291,14 @@ Git index format
>       sequence in variable width encoding. Each string describes the
>       environment where the cache can be used.
>   
> -  - Stat data of $GIT_DIR/info/exclude. See "Index entry" section from
> +  - Stat data of $GIT_COMMON_DIR/info/exclude. See "Index entry" section from
>       ctime field until "file size".
>   
>     - Stat data of core.excludesFile
>   
>     - 32-bit dir_flags (see struct dir_struct)
>   
> -  - Hash of $GIT_DIR/info/exclude. A null hash means the file
> +  - Hash of $GIT_COMMON_DIR/info/exclude. A null hash means the file
>       does not exist.
>   
>     - Hash of core.excludesFile. A null hash means the file does
> diff --git a/Documentation/gitignore.adoc b/Documentation/gitignore.adoc
> index a3d24e5c34..7979e50f18 100644
> --- a/Documentation/gitignore.adoc
> +++ b/Documentation/gitignore.adoc
> @@ -7,7 +7,7 @@ gitignore - Specifies intentionally untracked files to ignore
>   
>   SYNOPSIS
>   --------
> -$XDG_CONFIG_HOME/git/ignore, $GIT_DIR/info/exclude, .gitignore
> +$XDG_CONFIG_HOME/git/ignore, $GIT_COMMON_DIR/info/exclude, .gitignore
>   
>   DESCRIPTION
>   -----------
> @@ -34,7 +34,7 @@ precedence, the last matching pattern decides the outcome):
>      includes such `.gitignore` files in its repository, containing patterns for
>      files generated as part of the project build.
>   
> - * Patterns read from `$GIT_DIR/info/exclude`.
> + * Patterns read from `$GIT_COMMON_DIR/info/exclude`.
>   
>    * Patterns read from the file specified by the configuration
>      variable `core.excludesFile`.
> @@ -50,7 +50,7 @@ be used.
>      specific to a particular repository but which do not need to be shared
>      with other related repositories (e.g., auxiliary files that live inside
>      the repository but are specific to one user's workflow) should go into
> -   the `$GIT_DIR/info/exclude` file.
> +   the `$GIT_COMMON_DIR/info/exclude` file.
>   
>    * Patterns which a user wants Git to
>      ignore in all situations (e.g., backup or temporary files generated by
> @@ -97,7 +97,7 @@ PATTERN FORMAT
>      match at any level below the `.gitignore` level.
>   
>    - Patterns read from exclude sources that are outside the working tree,
> -   such as $GIT_DIR/info/exclude and core.excludesFile, are treated as if
> +   such as $GIT_COMMON_DIR/info/exclude and core.excludesFile, are treated as if
>      they are specified at the root of the working tree, i.e. a leading "/"
>      in such patterns anchors the match at the root of the repository.
>   
> @@ -146,8 +146,8 @@ CONFIGURATION
>   
>   The optional configuration variable `core.excludesFile` indicates a path to a
>   file containing patterns of file names to exclude, similar to
> -`$GIT_DIR/info/exclude`.  Patterns in the exclude file are used in addition to
> -those in `$GIT_DIR/info/exclude`.
> +`$GIT_COMMON_DIR/info/exclude`. Patterns in the exclude file are used in
> +addition to those in `$GIT_COMMON_DIR/info/exclude`.
>   
>   NOTES
>   -----
> diff --git a/dir.c b/dir.c
> index fcb8f6dd2a..33c81c256e 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2985,7 +2985,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>   		return NULL;
>   
>   	/*
> -	 * We only support $GIT_DIR/info/exclude and core.excludesfile
> +	 * We only support $GIT_COMMON_DIR/info/exclude and core.excludesfile
>   	 * as the global ignore rule files. Any other additions
>   	 * (e.g. from command line) invalidate the cache. This
>   	 * condition also catches running setup_standard_excludes()
> @@ -3078,7 +3078,7 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>   		istate->cache_changed |= UNTRACKED_CHANGED;
>   	}
>   
> -	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
> +	/* Validate $GIT_COMMON_DIR/info/exclude and core.excludesfile */
>   	root = dir->untracked->root;
>   	if (!oideq(&dir->internal.ss_info_exclude.oid,
>   		   &dir->untracked->ss_info_exclude.oid)) {
> diff --git a/dir.h b/dir.h
> index 20d4a078d6..83e0f648a8 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -153,7 +153,7 @@ struct oid_stat {
>    *   - The list of files and directories of the directory in question
>    *   - The $GIT_DIR/index
>    *   - dir_struct flags
> - *   - The content of $GIT_DIR/info/exclude
> + *   - The content of $GIT_COMMON_DIR/info/exclude
>    *   - The content of core.excludesfile
>    *   - The content (or the lack) of .gitignore of all parent directories
>    *     from $GIT_WORK_TREE
> 
> base-commit: 59709faab07346122d819453f4ad6f3ccdaf618e

