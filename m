Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A041FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 18:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751843AbdFGSNi (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 14:13:38 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33020 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdFGSNg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 14:13:36 -0400
Received: by mail-pf0-f182.google.com with SMTP id 83so8337998pfr.0
        for <git@vger.kernel.org>; Wed, 07 Jun 2017 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G7HBD4q73ebJ4RSs2jRXcj/Cg9rD88xC5QeDoezgccU=;
        b=FUEb/qXMYY+LtS71uvt6jRkELjNZiK89GGyP32jMyfh8jA0dq40X6XEqdPXpL1O8ld
         aT55q8lVpKqF5vsnRrbyvogwXlF2I9gl4nyZY9MIf386oZDSUEYod8nZcAdBQF3PZPkR
         cD9N1Y28sbKdQ63YFPuu+hq25Jr8IaRw+6a++/zmeemA5ZHwGd9mtG0JyxE8xKrZujhO
         bbjXHqOVFCIopuym6Cd2IALFeL/xtn95SMoUc4hdmpoJhlq4VMk9B2Qkc6kFrtbWHqsY
         SGAnfiyvn0QUa51Me6X4VI3ldY03vQ7XDAWhYxc8Il8hO1r2WOVwcyGAQ7cCAhGQgvXE
         386A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G7HBD4q73ebJ4RSs2jRXcj/Cg9rD88xC5QeDoezgccU=;
        b=auPxTFUj+1vgv8KEIhFHNVIDAzeVYjyDl7YdntCKca+wPPalpwmKls/RaFMm3VcGp6
         hOaTzhfTLKCAByW3VpoyI6GlKKoAhNwd+TJno8trtKSbvdk+qjVgezl1odCc6QfEpsMM
         dfREGTIjFSk/WmdQuqIVSbehf3Vsyt9TjLrFWB+0rUmcog3zZ2nwkxySi1qU1qtGUK2Y
         ETvPkg1X59ShhroDsG/rIYFVeW4VWa5Q3CNAacvTLAZ/QCcO1TZWw4++d21l/jWM5lor
         7LQ09iwEryGY2XepH4hsPUZSdcdOJugcFVMpSsncmOT45XsIzExPni1Hbpp2fugt8HXg
         gryQ==
X-Gm-Message-State: AODbwcCBJroQbg7nMHyodeRGC6XoEzqgZN92EZpUgYgRaQbMdiHIMp8O
        /le6lA4DWUH4OiyU
X-Received: by 10.98.153.153 with SMTP id t25mr33067127pfk.160.1496859215903;
        Wed, 07 Jun 2017 11:13:35 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:793b:8a31:813b:ceb2])
        by smtp.gmail.com with ESMTPSA id z3sm5459847pfk.99.2017.06.07.11.13.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Jun 2017 11:13:34 -0700 (PDT)
Date:   Wed, 7 Jun 2017 11:13:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/9] read_early_config(): optionally return the
 worktree's top-level directory
Message-ID: <20170607181333.GD110638@google.com>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
 <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d339785a007c2805bdc17c4e24da713a5996703.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Johannes Schindelin wrote:
> So far, when we invoked the early config code path, we implicitly
> determined the top-level directory of the worktree while discovering the
> .git/ directory.
> 
> And then we simply forgot that information.
> 
> However, when we expand aliases, we very much need that information, as
> aliases expanding to shell commands, i.e. whose value starts with an
> exclamation point, have to be executed in the top-level directory of the
> worktree. There are exceptions abound, not only with non-shell aliases
> (which are supposed to be executed in the original working directory
> instead), but also when being started inside the .git/ directory or in a
> worktree created via `git worktree add`.
> 
> In preparation for allowing the alias machinery to make use of the early
> config machinery, let's add an optional strbuf parameter to the
> read_early_config() function; if not NULL, the path of said top-level
> directory is appended to the strbuf. As a special case, nothing is
> appended if setup_git_directory() would have restored the original
> working directory before returning.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  cache.h                |  5 +++--
>  config.c               |  4 ++--
>  help.c                 |  2 +-
>  pager.c                |  4 ++--
>  setup.c                | 12 ++++++++++--
>  t/helper/test-config.c |  2 +-
>  6 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 4d92aae0e81..a8bbddf5955 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -530,7 +530,7 @@ extern void setup_work_tree(void);
>   * appended to gitdir. The return value is either NULL if no repository was
>   * found, or pointing to the path inside gitdir's buffer.
>   */
> -extern const char *discover_git_directory(struct strbuf *gitdir);
> +extern const char *discover_git_directory(struct strbuf *gitdir, struct strbuf *worktree_dir);
>  extern const char *setup_git_directory_gently(int *);
>  extern const char *setup_git_directory(void);
>  extern char *prefix_path(const char *prefix, int len, const char *path);
> @@ -1913,7 +1913,8 @@ extern int git_config_from_blob_sha1(config_fn_t fn, const char *name,
>  				     const unsigned char *sha1, void *data);
>  extern void git_config_push_parameter(const char *text);
>  extern int git_config_from_parameters(config_fn_t fn, void *data);
> -extern void read_early_config(config_fn_t cb, void *data);
> +extern void read_early_config(config_fn_t cb, void *data,
> +			      struct strbuf *worktree_dir);
>  extern void git_config(config_fn_t fn, void *);
>  extern int git_config_with_options(config_fn_t fn, void *,
>  				   struct git_config_source *config_source,
> diff --git a/config.c b/config.c
> index 9b88531a70d..3d78c11fc00 100644
> --- a/config.c
> +++ b/config.c
> @@ -1651,7 +1651,7 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
>  	}
>  }
>  
> -void read_early_config(config_fn_t cb, void *data)
> +void read_early_config(config_fn_t cb, void *data, struct strbuf *worktree_dir)
>  {
>  	struct config_options opts = {0};
>  	struct strbuf buf = STRBUF_INIT;
> @@ -1668,7 +1668,7 @@ void read_early_config(config_fn_t cb, void *data)
>  	 * notably, the current working directory is still the same after the
>  	 * call).
>  	 */
> -	else if (discover_git_directory(&buf))
> +	else if (discover_git_directory(&buf, worktree_dir))
>  		opts.git_dir = buf.buf;

It feels kind of weird to get back worktree info after calling
read_early_config but I understand why you need to get it.  One thing to
consider is the 'if' statement not shown here since you aren't adding any
worktree information if that branch is taken.  Maybe we can drop the
first if statement all together as 'read_early_config' is used before
setup is run and it should really only be triggered when setup has been
run.

>  
>  	git_config_with_options(cb, data, NULL, &opts);
> diff --git a/help.c b/help.c
> index b44c55ec2da..f78747e8413 100644
> --- a/help.c
> +++ b/help.c
> @@ -289,7 +289,7 @@ const char *help_unknown_cmd(const char *cmd)
>  	memset(&other_cmds, 0, sizeof(other_cmds));
>  	memset(&aliases, 0, sizeof(aliases));
>  
> -	read_early_config(git_unknown_cmd_config, NULL);
> +	read_early_config(git_unknown_cmd_config, NULL, NULL);
>  
>  	load_command_list("git-", &main_cmds, &other_cmds);
>  
> diff --git a/pager.c b/pager.c
> index c113d898a4a..857cf5ecb32 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -53,7 +53,7 @@ const char *git_pager(int stdout_is_tty)
>  	pager = getenv("GIT_PAGER");
>  	if (!pager) {
>  		if (!pager_program)
> -			read_early_config(core_pager_config, NULL);
> +			read_early_config(core_pager_config, NULL, NULL);
>  		pager = pager_program;
>  	}
>  	if (!pager)
> @@ -214,7 +214,7 @@ int check_pager_config(const char *cmd)
>  	data.want = -1;
>  	data.value = NULL;
>  
> -	read_early_config(pager_command_config, &data);
> +	read_early_config(pager_command_config, &data, NULL);
>  
>  	if (data.value)
>  		pager_program = data.value;
> diff --git a/setup.c b/setup.c
> index 2435186e448..771822fd0ca 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -945,10 +945,11 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  	}
>  }
>  
> -const char *discover_git_directory(struct strbuf *gitdir)
> +const char *discover_git_directory(struct strbuf *gitdir,
> +				   struct strbuf *worktree_dir)
>  {
>  	struct strbuf dir = STRBUF_INIT, err = STRBUF_INIT;
> -	size_t gitdir_offset = gitdir->len, cwd_len;
> +	size_t gitdir_offset = gitdir->len, cwd_len, worktree_dir_offset;
>  	struct repository_format candidate;
>  
>  	if (strbuf_getcwd(&dir))
> @@ -973,6 +974,11 @@ const char *discover_git_directory(struct strbuf *gitdir)
>  		strbuf_insert(gitdir, gitdir_offset, dir.buf, dir.len);
>  	}
>  
> +	if (worktree_dir) {
> +		worktree_dir_offset = worktree_dir->len;
> +		strbuf_addbuf(worktree_dir, &dir);
> +	}
> +
>  	strbuf_reset(&dir);
>  	strbuf_addf(&dir, "%s/config", gitdir->buf + gitdir_offset);
>  	read_repository_format(&candidate, dir.buf);
> @@ -983,6 +989,8 @@ const char *discover_git_directory(struct strbuf *gitdir)
>  			gitdir->buf + gitdir_offset, err.buf);
>  		strbuf_release(&err);
>  		strbuf_setlen(gitdir, gitdir_offset);
> +		if (worktree_dir)
> +			strbuf_setlen(worktree_dir, worktree_dir_offset);
>  		return NULL;
>  	}
>  
> diff --git a/t/helper/test-config.c b/t/helper/test-config.c
> index 8e3ed6a76cb..5e1e78f8fa2 100644
> --- a/t/helper/test-config.c
> +++ b/t/helper/test-config.c
> @@ -84,7 +84,7 @@ int cmd_main(int argc, const char **argv)
>  	struct config_set cs;
>  
>  	if (argc == 3 && !strcmp(argv[1], "read_early_config")) {
> -		read_early_config(early_config_cb, (void *)argv[2]);
> +		read_early_config(early_config_cb, (void *)argv[2], NULL);
>  		return 0;
>  	}
>  
> -- 
> 2.13.0.windows.1.460.g13f583bedb5
> 
> 

-- 
Brandon Williams
