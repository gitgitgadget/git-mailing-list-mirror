Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42F661F404
	for <e@80x24.org>; Sat,  8 Sep 2018 02:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbeIHGrt (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 02:47:49 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54967 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeIHGrt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 02:47:49 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so16262450wmb.4
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dDlDDwHDomhztteeGQx66qwKfEi6P2tjXICjT5a9sXQ=;
        b=RlrL55SoRGF8U+DmfSiPJU0r/XKKA4H79oUMvO4Cd0UG9wFyW2sqe9roWOK64B6in3
         9dJVVv8CsGuHTTPaTEXlr3GOEmhhcvkTH74gpOoJk4FJwtoFENfbVwBovj0JYRKaHvlK
         3nsgE8QVEr3iUW69mKKfpMgYIwaAOjExZuLK5u2VIiuonWUZmr2QgcRuVN9xWCQni64p
         Dm5LFXNwUfo+UFcZkKk3D9R4BWnXH+8AUuOe72JcBnOiyyDLiO0PkXBmrvpC2mVPJ/Mb
         X1E33/F+naUP2pWgGZcS+VVrv1ARDeArnlwvfk4qb9mdipjhZt2ZgvWNqSqs+7HNYFwR
         Y44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dDlDDwHDomhztteeGQx66qwKfEi6P2tjXICjT5a9sXQ=;
        b=pt8asS4ArYFzG8EuiG6M939OdpWRVMRlmJUXcamK/Tpzfv0/bcXddO3lDD5acnUoUb
         5D59SlYm4dZNPGkR5feivuloYdLhnSlw64Sgc7Jx2sUlcBhelyKRv+MCIIhZX32uTgjy
         QUp2AdKfgA0/LR2ej85+2Cfo/lFHaitSD5Zfngon2cCmRBebUJosWKGhtV7RyP3qwBgN
         N1Yrgcvcig7XGkb4eyloySRez04+8WfHhx5j+KRpCU98IKWNODQby7CAxZUj/i3S4Y1g
         uRnm15xEz6CpYlwqLG6IMsI/zUx1Ry1vufKAyZ1dYr/DK+qyB1yeLA46KIp9qGEhVp8O
         qKzQ==
X-Gm-Message-State: APzg51BdBrxiieoOYPMW9It6W5vJdd6ffLBzQJXGwMu/J52MmMjEi6fF
        MTkEs1t+yKk15hsIvMkgw1EsDIFF
X-Google-Smtp-Source: ANB0VdYyhCaGU+Up+NxdWvAEz94xgwYPvN9U+uC+TxzqmU+BK1WapQZQSmIrRWLmsjBpi4x2A0oq+A==
X-Received: by 2002:a1c:4d09:: with SMTP id o9-v6mr7007558wmh.134.1536372242934;
        Fri, 07 Sep 2018 19:04:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 88-v6sm8546695wrf.95.2018.09.07.19.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 19:04:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, allan.jensen@qt.io,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] Revert "Merge branch 'sb/submodule-core-worktree'" (was Re: Old submodules broken in 2.19rc1 and 2.19rc2)
References: <2659750.rG6xLiZASK@twilight>
        <CAGZ79kaVQ0T=acpviOoD+8XVxYsefNkO7c5d+d0Wc0iCbr2Evw@mail.gmail.com>
        <20180907223515.GD103699@aiede.svl.corp.google.com>
        <CAGZ79kZvuGEPOSTUqT+y6nxs6W5qaP-BbHT_WQQE7+n=RVNsrw@mail.gmail.com>
        <20180908000946.GA225427@aiede.svl.corp.google.com>
Date:   Fri, 07 Sep 2018 19:04:01 -0700
In-Reply-To: <20180908000946.GA225427@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Fri, 7 Sep 2018 17:09:46 -0700")
Message-ID: <xmqqmussvj72.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> It is late in the release cycle, so revert the whole 3-patch series.
> We can try again later for 2.20.
>
> Reported-by: Allan Sandfeld Jensen <allan.jensen@qt.io>
> Helped-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Stefan Beller wrote:
>> Jonathan Nieder wrote:
>
>>> I think we
>>> should revert e98317508c0 in "master" (for 2.19) and keep making use
>>> of that 'second try' in "next" (for 2.20).
>>
>> Actually I'd rather revert the whole topic leading up to
>> 7e25437d35a (Merge branch 'sb/submodule-core-worktree', 2018-07-18)
>> as the last patch in there doesn't work well without e98317508c0 IIRC.
>>
>> And having only the first patch would bring an inconsistent state as
>> then different commands behave differently w.r.t. setting core.worktree.
>
> Like this (generated using "git revert -m1)?

OK.  Thanks for taking care of it.

>
>  builtin/submodule--helper.c | 26 --------------------------
>  git-submodule.sh            |  5 -----
>  submodule.c                 | 14 --------------
>  submodule.h                 |  2 --
>  t/lib-submodule-update.sh   |  5 ++---
>  t/t7400-submodule-basic.sh  |  5 -----
>  6 files changed, 2 insertions(+), 55 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index b56028ba9d..f6fb8991f3 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1123,8 +1123,6 @@ static void deinit_submodule(const char *path, const char *prefix,
>  		if (!(flags & OPT_QUIET))
>  			printf(format, displaypath);
>  
> -		submodule_unset_core_worktree(sub);
> -
>  		strbuf_release(&sb_rm);
>  	}
>  
> @@ -2005,29 +2003,6 @@ static int check_name(int argc, const char **argv, const char *prefix)
>  	return 0;
>  }
>  
> -static int connect_gitdir_workingtree(int argc, const char **argv, const char *prefix)
> -{
> -	struct strbuf sb = STRBUF_INIT;
> -	const char *name, *path;
> -	char *sm_gitdir;
> -
> -	if (argc != 3)
> -		BUG("submodule--helper connect-gitdir-workingtree <name> <path>");
> -
> -	name = argv[1];
> -	path = argv[2];
> -
> -	strbuf_addf(&sb, "%s/modules/%s", get_git_dir(), name);
> -	sm_gitdir = absolute_pathdup(sb.buf);
> -
> -	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
> -
> -	strbuf_release(&sb);
> -	free(sm_gitdir);
> -
> -	return 0;
> -}
> -
>  #define SUPPORT_SUPER_PREFIX (1<<0)
>  
>  struct cmd_struct {
> @@ -2041,7 +2016,6 @@ static struct cmd_struct commands[] = {
>  	{"name", module_name, 0},
>  	{"clone", module_clone, 0},
>  	{"update-clone", update_clone, 0},
> -	{"connect-gitdir-workingtree", connect_gitdir_workingtree, 0},
>  	{"relative-path", resolve_relative_path, 0},
>  	{"resolve-relative-url", resolve_relative_url, 0},
>  	{"resolve-relative-url-test", resolve_relative_url_test, 0},
> diff --git a/git-submodule.sh b/git-submodule.sh
> index f7fd80345c..1cb2c0a31b 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -580,11 +580,6 @@ cmd_update()
>  			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
>  		fi
>  
> -		if ! $(git config -f "$(git rev-parse --git-common-dir)/modules/$name/config" core.worktree) 2>/dev/null
> -		then
> -			git submodule--helper connect-gitdir-workingtree "$name" "$sm_path"
> -		fi
> -
>  		if test "$subsha1" != "$sha1" || test -n "$force"
>  		then
>  			subforce=$force
> diff --git a/submodule.c b/submodule.c
> index 50cbf5f13e..a2b266fbfa 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1534,18 +1534,6 @@ int bad_to_remove_submodule(const char *path, unsigned flags)
>  	return ret;
>  }
>  
> -void submodule_unset_core_worktree(const struct submodule *sub)
> -{
> -	char *config_path = xstrfmt("%s/modules/%s/config",
> -				    get_git_common_dir(), sub->name);
> -
> -	if (git_config_set_in_file_gently(config_path, "core.worktree", NULL))
> -		warning(_("Could not unset core.worktree setting in submodule '%s'"),
> -			  sub->path);
> -
> -	free(config_path);
> -}
> -
>  static const char *get_super_prefix_or_empty(void)
>  {
>  	const char *s = get_super_prefix();
> @@ -1711,8 +1699,6 @@ int submodule_move_head(const char *path,
>  
>  			if (is_empty_dir(path))
>  				rmdir_or_warn(path);
> -
> -			submodule_unset_core_worktree(sub);
>  		}
>  	}
>  out:
> diff --git a/submodule.h b/submodule.h
> index 7d476cefa7..e452919aa4 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -127,8 +127,6 @@ int submodule_move_head(const char *path,
>  			const char *new_head,
>  			unsigned flags);
>  
> -void submodule_unset_core_worktree(const struct submodule *sub);
> -
>  /*
>   * Prepare the "env_array" parameter of a "struct child_process" for executing
>   * a submodule by clearing any repo-specific environment variables, but
> diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
> index 5b56b23166..016391723c 100755
> --- a/t/lib-submodule-update.sh
> +++ b/t/lib-submodule-update.sh
> @@ -235,7 +235,7 @@ reset_work_tree_to_interested () {
>  	then
>  		mkdir -p submodule_update/.git/modules/sub1/modules &&
>  		cp -r submodule_update_repo/.git/modules/sub1/modules/sub2 submodule_update/.git/modules/sub1/modules/sub2
> -		# core.worktree is unset for sub2 as it is not checked out
> +		GIT_WORK_TREE=. git -C submodule_update/.git/modules/sub1/modules/sub2 config --unset core.worktree
>  	fi &&
>  	# indicate we are interested in the submodule:
>  	git -C submodule_update config submodule.sub1.url "bogus" &&
> @@ -709,8 +709,7 @@ test_submodule_recursing_with_args_common() {
>  			git branch -t remove_sub1 origin/remove_sub1 &&
>  			$command remove_sub1 &&
>  			test_superproject_content origin/remove_sub1 &&
> -			! test -e sub1 &&
> -			test_must_fail git config -f .git/modules/sub1/config core.worktree
> +			! test -e sub1
>  		)
>  	'
>  	# ... absorbing a .git directory along the way.
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7d3d984210..c0ffc1022a 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -984,11 +984,6 @@ test_expect_success 'submodule deinit should remove the whole submodule section
>  	rmdir init
>  '
>  
> -test_expect_success 'submodule deinit should unset core.worktree' '
> -	test_path_is_file .git/modules/example/config &&
> -	test_must_fail git config -f .git/modules/example/config core.worktree
> -'
> -
>  test_expect_success 'submodule deinit from subdirectory' '
>  	git submodule update --init &&
>  	git config submodule.example.foo bar &&
