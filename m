Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B44526F47C
	for <git@vger.kernel.org>; Wed, 13 May 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680748; cv=none; b=FMIfZbPo6F4KwDvC9zteq6YU9GBbBr3fKe6zXQwAwen20EphtYYJ0QB7QEp3gyTYNXo549vWj5ROHSaDqpqy8BCz/kAf5eNlLaAk2N/pHxpuXFQrD/ISr6vIKfU1SuibuvuhyIFpo1g9/wG/0bTB02TiA3Qs8oSnNDYwSl8kgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680748; c=relaxed/simple;
	bh=bXwuVKsF8+YY8nLoCwwsrPllVYTQwTM1zz1fPiiBWmk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OmttyJuiNwjczE9XK+vXr3bjVuxwmfNPOAFWvfC+yr/P655zYr/li3jMXQYoikJRzQCf8SANFjfy2Nptqn1yBn+uB47FenJvLgvnBXDg1RgVRz3slkJ9C6Amgya5KSSEqpg9oh8l5jsJ6gxsOUDL9L0YQdFWG5zMtPUQWSCyVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRorO0i8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRorO0i8"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so68196265e9.2
        for <git@vger.kernel.org>; Wed, 13 May 2026 06:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680745; x=1779285545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i/wY9HVXZGyfgH1efTUpz0tlJjmyUQjdmfQOHFokgbI=;
        b=NRorO0i8S18vsHAdc9b3q37a4oKDKB+4YEYlzWvnCrnKsL4loAaINdTTwMRQHC+LrS
         2KY+AZHfXCZ7Lkr9+spqjuSi5fnypif7nQtiYL0bAgwfG7+zJuJPhg4gcT6FiBBQizcG
         q+hY/BdovrgA0yo3KprOdliz9h9x4JGxsufFhwqUmGioPQYVAkrmZXW67t/PJy/MScMf
         QZyVVoZ8bKhknsqCd6V3BU8JChxXHU/39XulL0/Yp+odofiniq1oxPI8DsrBwDIzKPmJ
         YB62SJK5/9fLzW3rxiy1Mc4yXBlmX+VxYGtTCWafdn1iWJbO3DhDCIJqY7HX6w96Lxdo
         2P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680745; x=1779285545;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/wY9HVXZGyfgH1efTUpz0tlJjmyUQjdmfQOHFokgbI=;
        b=NqvrJhiagkxqUN+noATfePRrFn3fNHhQSTEJQN5o8es9sP/mWDWDZAMTWvB+hcmalP
         IqUmss7mmCcKvKoZVDh8UWa7IJeZAO8IPPpLLzTLCwxxOZO4KdZj7pSJawi8WwgqmWh8
         geTPIWpQgO/rMowXrDHfY657gAHsNT6CqYu+dErnE0/1Ftl3M7Syujh6rAthOWzTF9v1
         UYpaGNJFoDp9gdjaAlK+JcGNR+koolLThQNi1CehEkPUP6xBMsMS1hLeQlwvOTKnXtMo
         Y1C0Pvfk5fIrylw/99rgJDlGbBt4H1rQl/t5WzEbwRHnfhUpc5aLuFBzAaXNFu1fhetD
         n+eQ==
X-Forwarded-Encrypted: i=1; AFNElJ/yzsKUF/s8JdE9ofsaGTODX6SxxBBstT4r87WV0NeM+3wlGQaXlBK0xXFS+DsunfSBnnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhhhJT3jvfgjG7BbfU16xtXVpwvjGyv9XO/Q5Vf+z6nAa46AT9
	MEC7EtGVmhC9N/ij/vXNx+3VFlyj9qJ4koCwhQq7MootCWPhoAC5kdJS
X-Gm-Gg: Acq92OGQbugohRkwWsBRDyw5OfKV09H0f8lgi4AOHyhPgNMdNR/qhpK0bbv4kzjXxl5
	HhoIAJrhb8gei5jlNmMmKL9rfTiMLhrKg2DVeOD+iN1kG+k3L7Ggk+o1A37oK2SlonQN6dcY/xb
	sxDiIcF747J60RIKBSu67A9Yy2mpjIDXXZNbtKTir1/PFRYkt/gFjvX8xHUu0RoDDEBSpfDgAno
	pE0K8ewF/KPhubdySVQXkGmP7aJmcN/cW/w/T0QXCZs8c2j4UwzJ7UwsCiNUPOSphwWY1ecgJCQ
	Jnr4uIHX2bMCXRsL4HwB+6FxtUxB7JqXT1Xwoh2CY0dLIJw31JPw64XpdkjNsjfouuKOEHaDdPC
	/aY3hym9Fu7PEJsdumHGAaOFMziSWy1mDKqhmCTrZmMML+kKyWMtDlh7sVQDD0J2CzhppvwG+WQ
	EJ7UaDLoQ1/2Ul+3JRXGoI6f8Rb75o0QO1vl/LzBL/xtLemciVWL1erqMea7DhIFvZt1nRUEyvj
	+mBCg==
X-Received: by 2002:a05:600c:8b2b:b0:489:1d74:56d with SMTP id 5b1f17b1804b1-48fc9a4db09mr54770135e9.29.1778680745258;
        Wed, 13 May 2026 06:59:05 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3cf0cdsm78561445e9.2.2026.05.13.06.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 06:59:04 -0700 (PDT)
Message-ID: <2989eb07-2933-4b5a-9e5c-33ef9b805528@gmail.com>
Date: Wed, 13 May 2026 14:59:00 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
To: me@black-desk.cn, git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20260513-includeif-worktree-v4-0-f8e6212d1fba@black-desk.cn>
 <20260513-includeif-worktree-v4-2-f8e6212d1fba@black-desk.cn>
Content-Language: en-US
In-Reply-To: <20260513-includeif-worktree-v4-2-f8e6212d1fba@black-desk.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2026 09:08, Chen Linxuan via B4 Relay wrote:
> From: Chen Linxuan <me@black-desk.cn>
> 
> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
> index 62eebe7c5450..6299b1e3a019 100644
> --- a/Documentation/config.adoc
> +++ b/Documentation/config.adoc
> @@ -146,6 +146,46 @@ refer to linkgit:gitignore[5] for details. For convenience:
>   	This is the same as `gitdir` except that matching is done
>   	case-insensitively (e.g. on case-insensitive file systems)
>   
> +`worktree`::
> +	The data that follows the keyword `worktree` and a colon is used as a
> +	glob pattern. If the working directory of the current worktree matches
> +	the pattern, the include condition is met.
> ++
> +The worktree location is the path where files are checked out (as returned
> +by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
> +matches the `.git` directory path. In a linked worktree, the worktree path
> +is the directory where that worktree's files are located, not the main
> +repository's `.git` directory.
> ++
> +The pattern uses the same glob syntax as `gitdir` (including `~/`, `./`,
> +`**/`, and trailing-`/` prefix matching). This condition will never match
> +in a bare repository (which has no worktree).
> ++
> +This is useful when you want to apply configuration based on where the
> +working tree is located on the filesystem. For example, a contributor who
> +works on the same project both personally and as an employee can use
> +different `user.name` and `user.email` values depending on which directory
> +the worktree is checked out under:
> ++
> +----
> +[includeIf "worktree:/home/user/work/"]
> +    path = ~/.config/git/work.inc
> +[includeIf "worktree:/home/user/personal/"]
> +    path = ~/.config/git/personal.inc
> +----
> ++
> +While `extensions.worktreeConfig` (see linkgit:git-worktree[1]) also supports
> +per-worktree configuration, it stores the config inside each repository's
> +`.git/config.worktree` file and requires running `git config --worktree`
> +inside each worktree individually. In contrast, `includeIf "worktree:..."`
> +can be set once in a global or system-level configuration file (e.g.
> +`~/.config/git/config`) and applies to all repositories at once based on
> +their worktree location.

Thanks for expanding the documentation - this looks good to me.

Phillip

> +`worktree/i`::
> +	This is the same as `worktree` except that matching is done
> +	case-insensitively (e.g. on case-insensitive file systems)
> +
>   `onbranch`::
>   	The data that follows the keyword `onbranch` and a colon is taken to be a
>   	pattern with standard globbing wildcards and two additional
> @@ -244,6 +284,14 @@ Example
>   [includeIf "gitdir:~/to/group/"]
>   	path = /path/to/foo.inc
>   
> +; include if the worktree is at /path/to/project-build
> +[includeIf "worktree:/path/to/project-build"]
> +	path = build-config.inc
> +
> +; include for all worktrees inside /path/to/group
> +[includeIf "worktree:/path/to/group/"]
> +	path = group-config.inc
> +
>   ; relative paths are always relative to the including
>   ; file (if the condition is true); their location is not
>   ; affected by the condition
> diff --git a/config.c b/config.c
> index 7d5dae0e8450..6d0c2d0725e4 100644
> --- a/config.c
> +++ b/config.c
> @@ -400,6 +400,12 @@ static int include_condition_is_true(const struct key_value_info *kvi,
>   		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
>   	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>   		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 0);
> +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
> +				       cond, cond_len, 1);
>   	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
>   		return include_by_branch(inc, cond, cond_len);
>   	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index 6e51f892f320..07b6fb649cd2 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -396,4 +396,117 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
>   	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
>   '
>   
> +# worktree: conditional include tests
> +
> +test_expect_success 'conditional include, worktree bare repo' '
> +	git init --bare wt-bare &&
> +	(
> +		cd wt-bare &&
> +		echo "[includeIf \"worktree:/\"]path=bar-bare" >>config &&
> +		echo "[test]wtbare=1" >bar-bare &&
> +		test_must_fail git config test.wtbare
> +	)
> +'
> +
> +test_expect_success 'conditional include, worktree multiple worktrees' '
> +	git init wt-multi &&
> +	(
> +		cd wt-multi &&
> +		test_commit initial &&
> +		git worktree add -b linked-branch ../wt-linked HEAD &&
> +		git worktree add -b prefix-branch ../wt-prefix/linked HEAD
> +	) &&
> +	wt_main="$(cd wt-multi && pwd)" &&
> +	wt_linked="$(cd wt-linked && pwd)" &&
> +	wt_prefix_parent="$(cd wt-prefix && pwd)" &&
> +	cat >>wt-multi/.git/config <<-EOF &&
> +	[includeIf "worktree:$wt_main"]
> +		path = main-config
> +	[includeIf "worktree:$wt_linked"]
> +		path = linked-config
> +	[includeIf "worktree:$wt_prefix_parent/"]
> +		path = prefix-config
> +	EOF
> +	echo "[test]mainvar=main" >wt-multi/.git/main-config &&
> +	echo "[test]linkedvar=linked" >wt-multi/.git/linked-config &&
> +	echo "[test]prefixvar=prefix" >wt-multi/.git/prefix-config &&
> +	echo main >expect &&
> +	git -C wt-multi config test.mainvar >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C wt-multi config test.linkedvar &&
> +	test_must_fail git -C wt-multi config test.prefixvar &&
> +	echo linked >expect &&
> +	git -C wt-linked config test.linkedvar >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C wt-linked config test.mainvar &&
> +	test_must_fail git -C wt-linked config test.prefixvar &&
> +	echo prefix >expect &&
> +	git -C wt-prefix/linked config test.prefixvar >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C wt-prefix/linked config test.mainvar &&
> +	test_must_fail git -C wt-prefix/linked config test.linkedvar
> +'
> +
> +test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
> +	mkdir real-wt &&
> +	ln -s real-wt link-wt &&
> +	git init link-wt/repo &&
> +	(
> +		cd link-wt/repo &&
> +		# repo->worktree resolves symlinks, so use real path in pattern
> +		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
> +		echo "[test]wtlink=2" >.git/bar-link &&
> +		echo 2 >expect &&
> +		git config test.wtlink >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'conditional include, worktree, icase' '
> +	git init wt-icase &&
> +	(
> +		cd wt-icase &&
> +		test_commit initial &&
> +		wt_path="$(pwd)" &&
> +		wt_upper=$(echo "$wt_path" | tr a-z A-Z) &&
> +		echo "[includeIf \"worktree/i:$wt_upper\"]path=icase-inc" >>.git/config &&
> +		echo "[test]wticase=1" >.git/icase-inc &&
> +		echo 1 >expect &&
> +		git config test.wticase >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
> +# The "worktree" condition cannot match during early config reading
> +# because the repository object is not yet fully initialized and
> +# repo_get_work_tree() returns NULL.
> +test_expect_success 'conditional include, worktree does not match in early config' '
> +	git init wt-early &&
> +	(
> +		cd wt-early &&
> +		test_commit initial &&
> +		wt_path="$(pwd)" &&
> +		echo "[includeIf \"worktree:$wt_path\"]path=early-inc" >>.git/config &&
> +		echo "[test]wtearly=1" >.git/early-inc &&
> +		test-tool config read_early_config test.wtearly >actual &&
> +		test_must_be_empty actual
> +	)
> +'
> +
> +test_expect_success 'conditional include, worktree without repository' '
> +	test_when_finished "rm -f .gitconfig config.inc" &&
> +	git config set -f .gitconfig "includeIf.worktree:/.path" config.inc &&
> +	git config set -f config.inc foo.bar baz &&
> +	git config get foo.bar &&
> +	test_must_fail nongit git config get foo.bar
> +'
> +
> +test_expect_success 'conditional include, worktree without repository but explicit nonexistent Git directory' '
> +	test_when_finished "rm -f .gitconfig config.inc" &&
> +	git config set -f .gitconfig "includeIf.worktree:/.path" config.inc &&
> +	git config set -f config.inc foo.bar baz &&
> +	git config get foo.bar &&
> +	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
> +'
> +
>   test_done
> 

