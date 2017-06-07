Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550A11FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751838AbdFGS0T (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:26:19 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:34711 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbdFGS0R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:26:17 -0400
Received: by mail-pg0-f50.google.com with SMTP id v18so7943257pgb.1
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=np17QYxcdX+FjbfO3DlP5kobffaWGFbLkePqfuxQUZ0=;
        b=GVt/xNU88IWgRMGiyRWc4Xp/65OWiecI/AgJWuUpXlirBBjuRzNMIa724BHOP7pzu8
         QHiTmGEWrCy9epLhC3I3+hIFsr281PULdC0sWl1xBuV5yn6VWSqZsTxxBwyuBsYQXqMW
         Q458jWxto4hMz7ybWBcvsRtLWw9bChklytdUEnuMJ6f2BC+0v3YIJGJ/rwH/+ag4VIbb
         QJF6dwS0EKCDLRa+QwF9Dc0fUsaJPko+OlvwTluBocxVaVlg7T3o3ggvXt31zNTE1DGu
         hga8jX7s7wZ+y5kwc1salnMZzSx8AAi6hKA3NXC/IUfFdOq+2+1Ot7TkFdG+nK5ZqKAK
         yQUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=np17QYxcdX+FjbfO3DlP5kobffaWGFbLkePqfuxQUZ0=;
        b=mwbd6ynoEX8UCf4MSXOjCl+Uo6zLCi6H9i8jU7UmKbHhUSUyRPDvB92yk9AYedcUQ4
         HkPzvM2nP1cffphQlMmTnwsOl8DDItuibzIxtekaAJE7ws2VX8rfx5UTDm0/+UoZqEkp
         rPAkKAs14KD+OueDR3asEiYan3AWXMqc6wIuqJCjC9jBoSI/EDO1co7wU+UWcY//INUq
         YZe6K2FGVP1P4yy//faTdai8inyxN9038TTk2AJyeiv5LbD3AyUHq4ZP99ZOMe4BBgNY
         g1dXtiSjXDfEHOBU0iOeL+AJvjuLrX/AcAz9lbp98ZgeEnkIJJIAMsAwhoTJqeX9MaT0
         LJHw==
X-Gm-Message-State: AODbwcCl4pSWorVQyrtgOXeLVypDFM8KAsOu9mfx+amLrT50WBSXvBWh
        d3efLvvz+uu3SD7Z
X-Received: by 10.99.101.132 with SMTP id z126mr33725377pgb.194.1496859976318;
        Wed, 07 Jun 2017 11:26:16 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id c123sm4779310pfa.100.2017.06.07.11.26.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 11:26:15 -0700 (PDT)
Date:   Wed, 7 Jun 2017 11:26:14 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/9] Use the early config machinery to expand aliases
Message-ID: <20170607182614.GF110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b916e1f5055486795c784d55704b4720598f1a9.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Johannes Schindelin wrote:
> We already taught alias_lookup() to use the early config if the .git/
> directory was not yet discovered, of course, however, since we called
> setup_git_directory_gently() before expanding the alias (if any), we
> only used the early config code path only if outside of any Git-managed
> directory.
> 
> With this commit, we finally switch over to really using the early
> config code path.
> 
> Rather than just chdir()ing into the indicated directory in case of an
> alias expanding to a shell command, we simply set up the .git/ directory
> so that e.g. GIT_PREFIX is set as expected.
> 
> This change also fixes a known issue where Git tried to read the pager
> config from an incorrect path in a subdirectory of a Git worktree if an
> alias expanded to a shell command.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  git.c            | 59 +++++++-------------------------------------------------
>  t/t7006-pager.sh |  2 +-
>  2 files changed, 8 insertions(+), 53 deletions(-)
> 
> diff --git a/git.c b/git.c
> index 4163beaead4..c82cd455948 100644
> --- a/git.c
> +++ b/git.c
> @@ -16,50 +16,6 @@ const char git_more_info_string[] =
>  	   "to read about a specific subcommand or concept.");
>  
>  static int use_pager = -1;
> -static char *orig_cwd;
> -static const char *env_names[] = {
> -	GIT_DIR_ENVIRONMENT,
> -	GIT_WORK_TREE_ENVIRONMENT,
> -	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
> -	GIT_PREFIX_ENVIRONMENT
> -};
> -static char *orig_env[4];
> -static int save_restore_env_balance;
> -
> -static void save_env_before_alias(void)
> -{
> -	int i;
> -
> -	assert(save_restore_env_balance == 0);
> -	save_restore_env_balance = 1;
> -	orig_cwd = xgetcwd();
> -	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
> -		orig_env[i] = getenv(env_names[i]);
> -		orig_env[i] = xstrdup_or_null(orig_env[i]);
> -	}
> -}
> -
> -static void restore_env(int external_alias)
> -{
> -	int i;
> -
> -	assert(save_restore_env_balance == 1);
> -	save_restore_env_balance = 0;
> -	if (!external_alias && orig_cwd && chdir(orig_cwd))
> -		die_errno("could not move to %s", orig_cwd);
> -	free(orig_cwd);
> -	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
> -		if (external_alias &&
> -		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
> -			continue;
> -		if (orig_env[i]) {
> -			setenv(env_names[i], orig_env[i], 1);
> -			free(orig_env[i]);
> -		} else {
> -			unsetenv(env_names[i]);
> -		}
> -	}
> -}

I like seeing chunks of old code being deleted :D

>  
>  static void commit_pager_choice(void) {
>  	switch (use_pager) {
> @@ -245,36 +201,37 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
>  
>  static int handle_alias(int *argcp, const char ***argv)
>  {
> +	struct strbuf worktree_dir = STRBUF_INIT;
>  	int envchanged = 0, ret = 0, saved_errno = errno;
>  	int count, option_count;
>  	const char **new_argv;
>  	const char *alias_command;
>  	char *alias_string;
> -	int unused_nongit;
> -
> -	save_env_before_alias();
> -	setup_git_directory_gently(&unused_nongit);
>  
>  	alias_command = (*argv)[0];
> -	alias_string = alias_lookup(alias_command, NULL);
> +	alias_string = alias_lookup(alias_command, &worktree_dir);
>  	if (alias_string) {
>  		if (alias_string[0] == '!') {
>  			struct child_process child = CHILD_PROCESS_INIT;
>  
> +			if (worktree_dir.len)
> +				setup_git_directory();

So if there is a worktree then we run the setup code explicitly.  I
assume that is to ensure that all envvars are setup properly before
running the alias.  Just interesting to note that the actual value of
worktree_dir is never used, its just used essentially as a boolean
indicator of there being a worktree/gitdir/repository.  I'm not
suggesting to change from what you have here, its just food for thought.

> +
>  			commit_pager_choice();
> -			restore_env(1);
>  
>  			child.use_shell = 1;
>  			argv_array_push(&child.args, alias_string + 1);
>  			argv_array_pushv(&child.args, (*argv) + 1);
>  
>  			ret = run_command(&child);
> +			strbuf_release(&worktree_dir);
>  			if (ret >= 0)   /* normal exit */
>  				exit(ret);
>  
>  			die_errno("While expanding alias '%s': '%s'",
>  			    alias_command, alias_string + 1);
>  		}
> +		strbuf_release(&worktree_dir);
>  		count = split_cmdline(alias_string, &new_argv);
>  		if (count < 0)
>  			die("Bad alias.%s string: %s", alias_command,
> @@ -308,8 +265,6 @@ static int handle_alias(int *argcp, const char ***argv)
>  		ret = 1;
>  	}
>  
> -	restore_env(0);
> -
>  	errno = saved_errno;
>  
>  	return ret;
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 83881ec3a0c..20b4d83c281 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -391,7 +391,7 @@ test_expect_success TTY 'core.pager in repo config works and retains cwd' '
>  	)
>  '
>  
> -test_expect_failure TTY 'core.pager is found via alias in subdirectory' '
> +test_expect_success TTY 'core.pager is found via alias in subdirectory' '
>  	sane_unset GIT_PAGER &&
>  	test_config core.pager "cat >via-alias" &&
>  	(
> -- 
> 2.13.0.windows.1.460.g13f583bedb5

-- 
Brandon Williams
