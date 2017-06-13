Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA7120D0C
	for <e@80x24.org>; Tue, 13 Jun 2017 18:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752987AbdFMS0L (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 14:26:11 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:36449 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752565AbdFMS0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 14:26:10 -0400
Received: by mail-pg0-f54.google.com with SMTP id a70so64225433pge.3
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1P2z/r5G5K3IVbhV8932NWWjR8aaDKzTp77e6d6SQKc=;
        b=g66UNsPnIHGmpIyAyVctGEJNAkAbz2Bfl4pJa/yRt4Yx7BX77MkDYv+/qRQgp3UdoS
         yZERRXmVK/TZJwUKHBFnh8ZqkqQmuy3rNWJV+kXFQYew0qEE/SouRASxc/reiNUakaFn
         aBGL5cYSdBqxo2HJ02UENYSTvzq4ya4aVuWoz3pVr8jx/aDwTq78245kB2xnOxcFV1Mg
         G5auuii3xhtuP47pReJweFrI/1KD8zR6A2LXUImq3aWCRvytra1JrKry5AnH9AeJowrl
         HfuccDHeZbuFwqPQTtmyziZQYAZOmvRnNnuw7vlieGE6zkJzV26LSNqMvd5ma3T0cmG5
         F38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1P2z/r5G5K3IVbhV8932NWWjR8aaDKzTp77e6d6SQKc=;
        b=VEHF2DFLgiaeZG0QqYte24xL6NzBaovFOYFqA3juJ7ym003vgrwAulwkDeA4EsoD+P
         W0oqRQSBHst+he7LvqTbkWwEfwn/hlDTE39TKWU+RucL0sR/yjFAWtm+B9gSoKj+hv/i
         PXHhNzfrG7tAkKvwfd6XRmVS8j1hnPgTupxxh6VDnOel16GBJACzMpskWX5hJDFoOi6Q
         AqQidLwFoqix9vs4+Dmz6tV2oaqi3d6UZlPbwHv9Nmv+/+3ovQUXL5i//3z8DSe8otPD
         MAGy9wG6MF3oxpYwhuvJY6CQkcN83fpzUcESPJE/PMbyKa2edSmkDZIvkt4De+XSMgMb
         fzwg==
X-Gm-Message-State: AKS2vOx2wEEA+Xni/5ZHP+hu+kF6fSGgV6iB0+wSe0/s34Txwcv8SNY2
        1TBYoGb9bTjvmafx
X-Received: by 10.98.62.65 with SMTP id l62mr874481pfa.114.1497378368933;
        Tue, 13 Jun 2017 11:26:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:dd0d:448e:29f9:5e86])
        by smtp.gmail.com with ESMTPSA id n90sm20446700pfb.127.2017.06.13.11.26.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Jun 2017 11:26:07 -0700 (PDT)
Date:   Tue, 13 Jun 2017 11:26:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand aliases
Message-ID: <20170613182606.GO154599@google.com>
References: <cover.1497355444.git.johannes.schindelin@gmx.de>
 <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/13, Johannes Schindelin wrote:
> Instead of discovering the .git/ directory, read the config and then
> trying to painstakingly reset all the global state if we did not find a
> matching alias, let's use the early config machinery instead.
> 
> It may look like unnecessary work to discover the .git/ directory in the
> early config machinery and then call setup_git_directory_gently() in the
> case of a shell alias, repeating the very same discovery *again*.
> However, we have to do this as the early config machinery takes pains
> *not* to touch any global state, while shell aliases expect a possibly
> changed working directory and at least the GIT_PREFIX and GIT_DIR
> variables to be set.
> 
> Also, one might be tempted to streamline the code in alias_lookup() to
> *not* use a strbuf for the key. However, if the config reports an error,
> it is far superior to tell the user that the `alias.xyz` key had a
> problem than to claim that it was the `xyz` key.
> 
> This change also fixes a known issue where Git tried to read the pager
> config from an incorrect path in a subdirectory of a Git worktree if an
> alias expanded to a shell command.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

So because I've been looking at the config machinery lately, I've
noticed a lot of issues with how things are handled with respect to
gitdir vs commondir.  Essentially the config resides at commondir/config
always, and only at gitdir/config when not working with a worktree.
Because of this, your patches point out a bug in how early config is
handled.  I'll illustrate this using aliases.

Before this series (because aliases are read using the standard config
machinery):

  > git init main
  > git -C main config alias.test '!echo hello'
  > git -C main test
    hello
  > git -C main worktree add ../worktree
  > git -C worktree test
    hello

After this series (using read_early_config()):

  > git init main
  > git -C main config alias.test '!echo hello'
  > git -C main test
    hello
  > git -C main worktree add ../worktree
  > git -C worktree test
    git: 'test' is not a git command. See 'git --help'.

The issue is that read_early_config passes the gitdir and not the
commondir when reading the config.

The solution would be to add a 'commondir' field to the config_options
struct and populate that before reading the config.  I'm planning on
fixing this in v2 of my config cleanup series which I'll hopefully have
finished by the end of the day.

> ---
>  alias.c          | 31 ++++++++++++++++++++++++-------
>  git.c            | 55 ++++---------------------------------------------------
>  t/t7006-pager.sh |  2 +-
>  3 files changed, 29 insertions(+), 59 deletions(-)
> 
> diff --git a/alias.c b/alias.c
> index 3b90397a99d..6bdc9363037 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -1,14 +1,31 @@
>  #include "cache.h"
>  
> +struct config_alias_data
> +{
> +	struct strbuf key;
> +	char *v;
> +};
> +
> +static int config_alias_cb(const char *key, const char *value, void *d)
> +{
> +	struct config_alias_data *data = d;
> +
> +	if (!strcmp(key, data->key.buf))
> +		return git_config_string((const char **)&data->v, key, value);
> +
> +	return 0;
> +}
> +
>  char *alias_lookup(const char *alias)
>  {
> -	char *v = NULL;
> -	struct strbuf key = STRBUF_INIT;
> -	strbuf_addf(&key, "alias.%s", alias);
> -	if (git_config_key_is_valid(key.buf))
> -		git_config_get_string(key.buf, &v);
> -	strbuf_release(&key);
> -	return v;
> +	struct config_alias_data data = { STRBUF_INIT, NULL };
> +
> +	strbuf_addf(&data.key, "alias.%s", alias);
> +	if (git_config_key_is_valid(data.key.buf))
> +		read_early_config(config_alias_cb, &data);
> +	strbuf_release(&data.key);
> +
> +	return data.v;
>  }
>  
>  #define SPLIT_CMDLINE_BAD_ENDING 1
> diff --git a/git.c b/git.c
> index 8ff44f081d4..58ef570294d 100644
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
>  
>  static void commit_pager_choice(void) {
>  	switch (use_pager) {
> @@ -250,19 +206,18 @@ static int handle_alias(int *argcp, const char ***argv)
>  	const char **new_argv;
>  	const char *alias_command;
>  	char *alias_string;
> -	int unused_nongit;
> -
> -	save_env_before_alias();
> -	setup_git_directory_gently(&unused_nongit);
>  
>  	alias_command = (*argv)[0];
>  	alias_string = alias_lookup(alias_command);
>  	if (alias_string) {
>  		if (alias_string[0] == '!') {
>  			struct child_process child = CHILD_PROCESS_INIT;
> +			int nongit_ok;
> +
> +			/* Aliases expect GIT_PREFIX, GIT_DIR etc to be set */
> +			setup_git_directory_gently(&nongit_ok);
>  
>  			commit_pager_choice();
> -			restore_env(1);
>  
>  			child.use_shell = 1;
>  			argv_array_push(&child.args, alias_string + 1);
> @@ -308,8 +263,6 @@ static int handle_alias(int *argcp, const char ***argv)
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
