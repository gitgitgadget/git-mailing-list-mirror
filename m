Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40CB01F42D
	for <e@80x24.org>; Wed, 28 Mar 2018 17:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752457AbeC1Rfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 13:35:47 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34927 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeC1Rfq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 13:35:46 -0400
Received: by mail-pf0-f194.google.com with SMTP id u86so1270330pfd.2
        for <git@vger.kernel.org>; Wed, 28 Mar 2018 10:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=djcQYdxarKKiwKagU3prorThgJaXL7JgfHMaicPvAo4=;
        b=CRMZUVfJ9QiOrnXj/oOOAW4xIKoR9M9xxcMva2mxVxBqaQPnbqv7gKraB0N6U/V/vv
         mo30BYGQs+qzeCYPMm/6ZcqcToCBPrUOUJjbvzW6h/nabkUUmuz8euFyPBNKINhSatV1
         8arjNBZeb0ftbKrvOO0kjs5bB49pyN1CMI6othJMbHmBj6WMGewgawIhowOHvDzDj2bx
         i7GC7oCvyBoULfrpJq+A6CjyefY+nc+SqpS+grVB6ghZRTL7/uFAUUY3Mrk/mpUZctpa
         cm+Nlt6MTHW9liqOJWZ6o1fWs+t6UrJzFtGSk+o7UnvD+6d6hADQT8dYBZ66p1dwJDAe
         UtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=djcQYdxarKKiwKagU3prorThgJaXL7JgfHMaicPvAo4=;
        b=L3Y2FFn0gqNZkL+hWu4nA5hw6BdnWd+XNA1lAAOCAuHIuOebT7srOPc0ksp5spjD7P
         nwEFJCYhAX/BOS1Tma9CuWRhxxE21d8+1oMbxqZQVlENoHFSYPgDZU2du9MOAOgZZqtB
         yBeuVRwe4ty3PtA79m20b0Z9PTI5SX2ycgJqEQYMx4KG7DvNyoK+q4+12GIjsbr4uwzL
         /znht4xScnfHIhH7YbAFXrTzg+lcBsQPl0+AkqOFqzSSZieqUkNPOVMvlZrGy03RUNRh
         vR3cFETxLsUxaQgCgWh1czFVrOu+k5muJLftL3c/hF60yuh8yYAzIz8HDPb0Rrwz7DwO
         whMA==
X-Gm-Message-State: AElRT7GyIAtvV6naiiSNCJZGFCA4+LYpIoapTWfkod4hQ0jfP0dQhDY6
        wM7Yb0WOqBRhsrpXRcEwZLxXLtzhWWI=
X-Google-Smtp-Source: AIpwx49NRER3fCvarwg6BPyxMt/7IDOuxPLa03DqmgSPYm0r6OJfpl1bPjy46vlQzGaCYFGKxzCubQ==
X-Received: by 2002:a17:902:9045:: with SMTP id w5-v6mr4645398plz.52.1522258545296;
        Wed, 28 Mar 2018 10:35:45 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id p8sm7612609pgf.75.2018.03.28.10.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Mar 2018 10:35:44 -0700 (PDT)
Date:   Wed, 28 Mar 2018 10:35:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, hvoigt@hvoigt.net,
        jonathantanmy@google.com, seanwbehan@riseup.net
Subject: Re: [PATCH 5/6] submodule: fixup nested submodules after moving the
 submodule
Message-ID: <20180328173543.GA159395@google.com>
References: <CAGZ79kaQYjepND8EdgB73meBsShOc5aBporiK2Bo40fqcar0gg@mail.gmail.com>
 <20180328172449.27012-1-sbeller@google.com>
 <20180328172449.27012-6-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328172449.27012-6-sbeller@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/28, Stefan Beller wrote:
> connect_work_tree_and_git_dir is used to connect a submodule worktree with
> its git directory and vice versa after events that require a reconnection
> such as moving around the working tree. As submodules can have nested
> submodules themselves, we'd also want to fix the nested submodules when
> asked to. Add an option to recurse into the nested submodules and connect
> them as well.
> 
> As submodules are identified by their name (which determines their git
> directory in relation to their superproject's git directory) internally
> and by their path in the working tree of the superproject, we need to
> make sure that the mapping of name <-> path is kept intact. We can do
> that in the git-mv command by writing out the gitmodules file first
> and then forcing a reload of the submodule config machinery.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/mv.c                |  6 ++--
>  builtin/submodule--helper.c |  3 +-
>  dir.c                       | 63 +++++++++++++++++++++++++++++++++++--
>  dir.h                       | 12 ++++++-
>  submodule.c                 |  6 ++--
>  t/t7001-mv.sh               |  2 +-
>  6 files changed, 80 insertions(+), 12 deletions(-)
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
> index dedbf5d476..71947c0ef3 100644
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
> @@ -3010,8 +3011,60 @@ void untracked_cache_add_to_index(struct index_state *istate,
>  	untracked_cache_invalidate_path(istate, path, 1);
>  }
>  
> -/* Update gitfile and core.worktree setting to connect work tree and git dir */
> -void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
> +static void connect_wt_gitdir_in_nested(const char *sub_worktree,
> +					const char *sub_gitdir)
> +{
> +	int i;
> +	struct repository subrepo;
> +	struct strbuf sub_wt = STRBUF_INIT;
> +	struct strbuf sub_gd = STRBUF_INIT;
> +
> +	const struct submodule *sub;
> +
> +	if (repo_init(&subrepo, sub_gitdir, sub_worktree))
> +		return;

Note that in Duy's object-store series he made this function private
(IIRC) so this will result in some clash of the two series.

> +
> +	if (repo_read_index(&subrepo) < 0)
> +		die("index file corrupt in repo %s", subrepo.gitdir);
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
> +		if (is_submodule_active(&subrepo, ce->name)) {
> +			strbuf_addf(&sub_wt, "%s/%s", sub_worktree, sub->path);
> +			strbuf_addf(&sub_gd, "%s/modules/%s", sub_gitdir, sub->name);
> +
> +			connect_work_tree_and_git_dir(sub_wt.buf, sub_gd.buf, 0);
> +			connect_wt_gitdir_in_nested(sub_wt.buf, sub_gd.buf);
> +
> +			strbuf_reset(&sub_wt);
> +			strbuf_reset(&sub_gd);
> +		}
> +	}
> +	strbuf_release(&sub_wt);
> +	strbuf_release(&sub_gd);
> +	repo_clear(&subrepo);
> +}
> +
> +void connect_work_tree_and_git_dir(const char *work_tree_,
> +				   const char *git_dir_,
> +				   int recurse_into_nested)
>  {
>  	struct strbuf gitfile_sb = STRBUF_INIT;
>  	struct strbuf cfg_sb = STRBUF_INIT;
> @@ -3041,6 +3094,10 @@ void connect_work_tree_and_git_dir(const char *work_tree_, const char *git_dir_)
>  	strbuf_release(&gitfile_sb);
>  	strbuf_release(&cfg_sb);
>  	strbuf_release(&rel_path);
> +
> +	if (recurse_into_nested)
> +		connect_wt_gitdir_in_nested(work_tree, git_dir);
> +
>  	free(work_tree);
>  	free(git_dir);
>  }
> @@ -3054,5 +3111,5 @@ void relocate_gitdir(const char *path, const char *old_git_dir, const char *new_
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
