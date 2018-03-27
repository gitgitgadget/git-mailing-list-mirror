Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8068D1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752538AbeC0XZq (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:25:46 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34327 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752517AbeC0XZn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:25:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id q6so240602pgr.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0QMLjxipQrktoNQdttmvZNJOl30vVuDN5I3pP97jotk=;
        b=WGthJbLyoDMg5cyQbupPB9nICTevPulr2M2Z8ou01ehn9xSSacV3P2RAhqa8XLPi/y
         F6FlrVBqkBE5hWgeDp6JjLgoR3beg1LB/imEg9L+y9uBQCTo/ZXq52ELu//YXP/aVcL+
         qMSfkxOhDAuj8YR7ZXl4MP1xacSC1qIhpHeL+oCPCRXIGbnG4xahJSS1C0LhWYtP6x5w
         K8AYI6J3GYrH7UP1YhODvNGcstdHmyT13BgGu0tTFBjACv8TGy5M6kdfpa104Rt1R2BZ
         2yWvvJ1H9EFkTuktJEgCEQY+qAiZwQd2ROstBDJbCyKefSrhFQgXyq2vpPnYsA4Q55y3
         uvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0QMLjxipQrktoNQdttmvZNJOl30vVuDN5I3pP97jotk=;
        b=KHJOfj1qhfkhmZrZlUqn58EyHVB/PfkBQAgdDNVeE0Ik1+p37uRkNRlUrJjrX8BgbH
         8vTFclOk5vv/Rn6XlLT6V0y7+fEHuIrPdWpPXopQY9DtC7/QwhL1V9DM6vth3216j7jb
         AuVp6A0cPrdoAszhRdauehsKroc35fh/AOTsx0+d/AinTf5euNLqccmlEEuaP1eikc5p
         g0J4eMhyhrEemF+4TI7O7EgOHyWjjXXeOzvqgQU/wnzpwMXLsix7Nn3MHDqrmHwvfOyx
         CTlXf2cCktewItHLCIx2RvknpJGMihhKIKR4Pp0sWibcGW8RuKcSXPTDiVwOpZQot52Z
         Suzw==
X-Gm-Message-State: AElRT7FPsEYAIwyHqIYdG6dVUVsToqQWqPBkMVBJ89Txc21INGMxHIV7
        FrCcNF+eOsvcoZ4BLOy2Z5J4ZA==
X-Google-Smtp-Source: AIpwx4/ta+KwXdUwLdN9rOGdv4Tydfz8CTAS6Mzi1sGUm/dcawOJjVHVzRMnn1mnE0MniwLQIod+uA==
X-Received: by 10.167.130.22 with SMTP id k22mr981193pfi.73.1522193142560;
        Tue, 27 Mar 2018 16:25:42 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id d83sm5234408pfl.176.2018.03.27.16.25.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Mar 2018 16:25:41 -0700 (PDT)
Date:   Tue, 27 Mar 2018 16:25:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, seanwbehan@riseup.net, hvoigt@hvoigt.net
Subject: Re: [PATCH 5/5] submodule: fixup nested submodules after moving the
 submodule
Message-ID: <20180327232540.GB215480@google.com>
References: <20180327213918.77851-1-sbeller@google.com>
 <20180327213918.77851-6-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327213918.77851-6-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Stefan Beller wrote:
> connect_work_tree_and_git_dir is used to connect a submodule worktree with
> its git directory and vice versa after events that require a reconnection
> such as moving around the working tree. As submodules can have nested
> submoduled themselves, we'd also want to fix the nested submodules when
> asked to. Add an option to recurse into the nested submodules and connect
> them as well.
> 
> As submodules are identified by their name (which determines their git
> directory in relation to their superprojects git directory) internally
> and by their path in the working tree of the superproject, we need to
> make sure that the mapping of name <-> path is kept intact. We can do
> that in the git-mv command by writing out the gitmodules file and first
> and then force a reload of the submodule config machinery.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/mv.c                |  6 ++--
>  builtin/submodule--helper.c |  3 +-
>  dir.c                       | 70 +++++++++++++++++++++++++++++++++++--
>  dir.h                       | 12 ++++++-
>  submodule.c                 |  6 ++--
>  t/t7001-mv.sh               |  2 +-
>  6 files changed, 87 insertions(+), 12 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 6d141f7a53..7a63667d64 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -276,10 +276,12 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			die_errno(_("renaming '%s' failed"), src);
>  		}
>  		if (submodule_gitfile[i]) {
> -			if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
> -				connect_work_tree_and_git_dir(dst, submodule_gitfile[i]);
>  			if (!update_path_in_gitmodules(src, dst))
>  				gitmodules_modified = 1;
> +			if (submodule_gitfile[i] != SUBMODULE_WITH_GITDIR)
> +				connect_work_tree_and_git_dir(dst,
> +							      submodule_gitfile[i],
> +							      1);
>  		}
>  
>  		if (mode == WORKING_DIRECTORY)
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index a921fbbf56..05fd657f99 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -1259,8 +1259,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
>  		strbuf_reset(&sb);
>  	}
>  
> -	/* Connect module worktree and git dir */
> -	connect_work_tree_and_git_dir(path, sm_gitdir);
> +	connect_work_tree_and_git_dir(path, sm_gitdir, 0);
>  
>  	p = git_pathdup_submodule(path, "config");
>  	if (!p)
> diff --git a/dir.c b/dir.c
> index dedbf5d476..313176e291 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -19,6 +19,7 @@
>  #include "varint.h"
>  #include "ewah/ewok.h"
>  #include "fsmonitor.h"
> +#include "submodule-config.h"
>  
>  /*
>   * Tells read_directory_recursive how a file or directory should be treated.
> @@ -3010,8 +3011,67 @@ void untracked_cache_add_to_index(struct index_state *istate,
>  	untracked_cache_invalidate_path(istate, path, 1);
>  }
>  
> -/* Update gitfile and core.worktree setting to connect work tree and git dir */
> -void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
> +static void connect_wt_gitdir_in_nested(const char *sub_worktree,
> +					const char *sub_gitdir,
> +					struct repository *superproject)
> +{
> +	int i;
> +	struct repository subrepo;

You never clear this struct which means it leaks the memory it points
to.

> +	struct strbuf sub_wt = STRBUF_INIT;
> +	struct strbuf sub_gd = STRBUF_INIT;
> +	const struct submodule *sub;
> +	const char *super_worktree,
> +		   *sub_path; /* path inside the superproject */
> +
> +	/* subrepo got moved, so superproject has outdated information */
> +	submodule_free(superproject);
> +
> +	super_worktree = real_pathdup(superproject->worktree, 1);
> +
> +	sub_path = sub_worktree + strlen(super_worktree) + 1;
> +
> +	if (repo_submodule_init(&subrepo, superproject, sub_path))
> +		return;
> +
> +	repo_read_index(&subrepo);

You may want to check the return value to see if reading the index was
successful.

> +
> +	for (i = 0; i < subrepo.index->cache_nr; i++) {
> +		const struct cache_entry *ce = subrepo.index->cache[i];
> +
> +		if (!S_ISGITLINK(ce->ce_mode))
> +			continue;
> +
> +		while (i + 1 < subrepo.index->cache_nr &&
> +		       !strcmp(ce->name, subrepo.index->cache[i + 1]->name))
> +			/*
> +			 * Skip entries with the same name in different stages
> +			 * to make sure an entry is returned only once.
> +			 */
> +			i++;
> +
> +		sub = submodule_from_path(&subrepo, &null_oid, ce->name);
> +		if (!sub)
> +			/* submodule not checked out? */
> +			continue;
> +
> +		strbuf_reset(&sub_wt);
> +		strbuf_addf(&sub_wt, "%s/%s/.git", sub_worktree, sub->path);
> +
> +		strbuf_reset(&sub_gd);
> +		strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
> +
> +		strbuf_setlen(&sub_wt, sub_wt.len - strlen("/.git"));
> +
> +		if (is_submodule_active(&subrepo, ce->name)) {
> +			connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 0);
> +			connect_wt_gitdir_in_nested(sub_wt.buf, sub_gd.buf, &subrepo);
> +		}
> +	}
> +}
> +
> +void connect_work_tree_and_git_dir(const char *work_tree_,
> +				   const char *git_dir_,
> +				   int recurse_into_nested)
>  {
>  	struct strbuf gitfile_sb = STRBUF_INIT;
>  	struct strbuf cfg_sb = STRBUF_INIT;
> @@ -3041,6 +3101,10 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  	strbuf_release(&gitfile_sb);
>  	strbuf_release(&cfg_sb);
>  	strbuf_release(&rel_path);
> +
> +	if (recurse_into_nested)
> +		connect_wt_gitdir_in_nested(work_tree, git_dir, the_repository);
> +
>  	free(work_tree);
>  	free(git_dir);
>  }
> @@ -3054,5 +3118,5 @@ void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
>  		die_errno(_("could not migrate git directory from '%s' to '%s'"),
>  			old_git_dir, new_git_dir);
>  
> -	connect_work_tree_and_git_dir(path, new_git_dir);
> +	connect_work_tree_and_git_dir(path, new_git_dir, 0);
>  }
> diff --git a/dir.h b/dir.h
> index b0758b82a2..3870193e52 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -359,7 +359,17 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
>  void write_untracked_extension(struct strbuf *out, struct untracked_cache *untracked);
>  void add_untracked_cache(struct index_state *istate);
>  void remove_untracked_cache(struct index_state *istate);
> -extern void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
> +
> +/*
> + * Connect a worktree to a git directory by creating (or overwriting) a
> + * '.git' file containing the location of the git directory. In the git
> + * directory set the core.worktree setting to indicate where the worktree is.
> + * When `recurse_into_nested` is set, recurse into any nested submodules,
> + * connecting them as well.
> + */
> +extern void connect_work_tree_and_git_dir(const char *work_tree,
> +					  const char *git_dir,
> +					  int recurse_into_nested);
>  extern void relocate_gitdir(const char *path,
>  			    const char *old_git_dir,
>  			    const char *new_git_dir);
> diff --git a/submodule.c b/submodule.c
> index 89d0aee086..c2dac6c00f 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1624,7 +1624,7 @@ int submodule_move_head(const char *path,
>  		} else {
>  			char *gitdir = xstrfmt("%s/modules/%s",
>  				    get_git_common_dir(), sub->name);
> -			connect_work_tree_and_git_dir(path, gitdir);
> +			connect_work_tree_and_git_dir(path, gitdir, 0);
>  			free(gitdir);
>  
>  			/* make sure the index is clean as well */
> @@ -1634,7 +1634,7 @@ int submodule_move_head(const char *path,
>  		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
>  			char *gitdir = xstrfmt("%s/modules/%s",
>  				    get_git_common_dir(), sub->name);
> -			connect_work_tree_and_git_dir(path, gitdir);
> +			connect_work_tree_and_git_dir(path, gitdir, 1);
>  			free(gitdir);
>  		}
>  	}
> @@ -1947,7 +1947,7 @@ void absorb_git_dir_into_superproject(const char *prefix,
>  		if (!sub)
>  			die(_("could not lookup name for submodule '%s'"), path);
>  		connect_work_tree_and_git_dir(path,
> -			git_path("modules/%s", sub->name));
> +			git_path("modules/%s", sub->name), 0);
>  	} else {
>  		/* Is it already absorbed into the superprojects git dir? */
>  		char *real_sub_git_dir = real_pathdup(sub_git_dir, 1);
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index d4e6485a26..ff70244620 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -497,7 +497,7 @@ test_expect_success 'moving a submodule in nested directories' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_failure 'moving nested submodules' '
> +test_expect_success 'moving nested submodules' '
>  	git commit -am "cleanup commit" &&
>  	mkdir sub_nested_nested &&
>  	(cd sub_nested_nested &&
> -- 
> 2.17.0.rc1.321.gba9d0f2565-goog
> 

-- 
Brandon Williams
