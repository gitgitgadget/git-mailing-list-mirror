Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEAFC1FAEB
	for <e@80x24.org>; Fri,  9 Jun 2017 00:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751413AbdFIAIz (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 20:08:55 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34899 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdFIAIy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 20:08:54 -0400
Received: by mail-pg0-f43.google.com with SMTP id k71so20870317pgd.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2017 17:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Vsd/ruDy7QlHBwY+voAUlviTJ+VNhgWpUv4I+mZsFc=;
        b=W5R8UyIjkaQl/MYUCzQYtr/C/uHHsxNxWBxcfYBgqz9j5fL3pLy8yD4ldaGMYMyIOY
         oyNS3Ji8b8sttM218Yo30E6ccFaS8mfoodZkw5VCkFWkWf2sG9LqrrhAGztrGTfRunTK
         wQoc1UN4+d88NbMHh/O4KIj14cCWCNqHu7I49rvpqZ80AX0R8DMqTXrjjMNXrz1avjzd
         jh6S3CvJ1gDNj7RBXxH/JMaY9voMrRZtxMBztOgm8RVvTWQs0cXdVDx+e2hrrM4xFGEi
         XgtusPhGnSzwNoyQf5znZ9VDyfs9ZGm+cw0zHDD/pBRjnzd4fg6xqva7qbJYZ8IjJhf1
         XnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Vsd/ruDy7QlHBwY+voAUlviTJ+VNhgWpUv4I+mZsFc=;
        b=qQ7ksiCbRknwrsVD+G+tVe37Xa68lxX1x1m5WkMld1u3yQr8iA9tQ2z1Qr/AUjx/M2
         eQkwpeoE5D3Fd4n3cCAxLNJh9u3dBwpJaumS/dlSZUXQsHJ+S5uBZkYZBlHrAvHw4BUf
         YATVxvL+MK2Txc9u8086jupFouE6rTvLX142bDB6Ce44Kk9O6H6WhUoxSVeCHLSYd9iW
         o3GkaPE0+miFC5/MJUh5C/Jz+LFhcK1If6fRoVQKM4gDkGzROivGH204yS6I/sviWkjf
         md3NBLTc+BdDVYQS4dEyqkcJ2lkgC866K+36pwFWmaJNG27q2dvbhjf5N/SFMXjflZZ6
         x1nQ==
X-Gm-Message-State: AODbwcDTzFIf6pUGUFE/VYzHanreAxtL9WnxvOh/3bX6gI827lE1pFzu
        Ynz7Pl7xFeQc7OWMsuhnzQ==
X-Received: by 10.99.64.3 with SMTP id n3mr39617447pga.71.1496966931424;
        Thu, 08 Jun 2017 17:08:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:4d0d:6f3d:27f:3a24])
        by smtp.gmail.com with ESMTPSA id g78sm4242787pfb.122.2017.06.08.17.08.49
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 08 Jun 2017 17:08:50 -0700 (PDT)
Date:   Thu, 8 Jun 2017 17:08:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, jacob.keller@gmail.com,
        Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        peartben@gmail.com, pclouds@gmail.com, gitster@pobox.com,
        peff@peff.net, git@jeffhostetler.com, avarab@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 32/32] ls-files: use repository object
Message-ID: <20170609000849.GA130522@google.com>
References: <20170531214417.38857-1-bmwill@google.com>
 <20170608234100.188529-1-bmwill@google.com>
 <20170608234100.188529-33-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170608234100.188529-33-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/08, Brandon Williams wrote:
> Convert ls-files to use a repository struct and recurse submodules
> inprocess.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/ls-files.c                     | 198 ++++++++++++++-------------------
>  git.c                                  |   2 +-
>  repository.c                           |   4 +
>  repository.h                           |   1 +
>  t/t3007-ls-files-recurse-submodules.sh |  39 +++++++
>  5 files changed, 129 insertions(+), 115 deletions(-)
> 
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index 6a0302a28..503fed5a1 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -5,7 +5,9 @@
>   *
>   * Copyright (C) Linus Torvalds, 2005
>   */
> +#define NO_THE_INDEX_COMPATIBILITY_MACROS
>  #include "cache.h"
> +#include "repository.h"
>  #include "config.h"
>  #include "quote.h"
>  #include "dir.h"
> @@ -32,10 +34,8 @@ static int line_terminator = '\n';
>  static int debug_mode;
>  static int show_eol;
>  static int recurse_submodules;
> -static struct argv_array submodule_options = ARGV_ARRAY_INIT;
>  
>  static const char *prefix;
> -static const char *super_prefix;
>  static int max_prefix_len;
>  static int prefix_len;
>  static struct pathspec pathspec;
> @@ -73,25 +73,12 @@ static void write_eolinfo(const struct index_state *istate,
>  
>  static void write_name(const char *name)
>  {
> -	/*
> -	 * Prepend the super_prefix to name to construct the full_name to be
> -	 * written.
> -	 */
> -	struct strbuf full_name = STRBUF_INIT;
> -	if (super_prefix) {
> -		strbuf_addstr(&full_name, super_prefix);
> -		strbuf_addstr(&full_name, name);
> -		name = full_name.buf;
> -	}
> -
>  	/*
>  	 * With "--full-name", prefix_len=0; this caller needs to pass
>  	 * an empty string in that case (a NULL is good for "").
>  	 */
>  	write_name_quoted_relative(name, prefix_len ? prefix : NULL,
>  				   stdout, line_terminator);
> -
> -	strbuf_release(&full_name);
>  }
>  
>  static const char *get_tag(const struct cache_entry *ce, const char *tag)
> @@ -210,82 +197,41 @@ static void show_killed_files(const struct index_state *istate,
>  	}
>  }
>  
> -/*
> - * Compile an argv_array with all of the options supported by --recurse_submodules
> - */
> -static void compile_submodule_options(const char **argv,
> -				      const struct dir_struct *dir,
> -				      int show_tag)
> -{
> -	if (line_terminator == '\0')
> -		argv_array_push(&submodule_options, "-z");
> -	if (show_tag)
> -		argv_array_push(&submodule_options, "-t");
> -	if (show_valid_bit)
> -		argv_array_push(&submodule_options, "-v");
> -	if (show_cached)
> -		argv_array_push(&submodule_options, "--cached");
> -	if (show_eol)
> -		argv_array_push(&submodule_options, "--eol");
> -	if (debug_mode)
> -		argv_array_push(&submodule_options, "--debug");
> -
> -	/* Add Pathspecs */
> -	argv_array_push(&submodule_options, "--");
> -	for (; *argv; argv++)
> -		argv_array_push(&submodule_options, *argv);
> -}
> +static void show_files(struct repository *repo, struct dir_struct *dir);
>  
> -/**
> - * Recursively call ls-files on a submodule
> - */
> -static void show_gitlink(const struct cache_entry *ce)
> +static void show_submodule(const struct repository *superproject,
> +			   struct dir_struct *dir, const char *path)
>  {
> -	struct child_process cp = CHILD_PROCESS_INIT;
> -	int status;
> -	char *dir;
> -
> -	prepare_submodule_repo_env(&cp.env_array);
> -	argv_array_push(&cp.env_array, GIT_DIR_ENVIRONMENT);
> -
> -	if (prefix_len)
> -		argv_array_pushf(&cp.env_array, "%s=%s",
> -				 GIT_TOPLEVEL_PREFIX_ENVIRONMENT,
> -				 prefix);
> -	argv_array_pushf(&cp.args, "--super-prefix=%s%s/",
> -			 super_prefix ? super_prefix : "",
> -			 ce->name);
> -	argv_array_push(&cp.args, "ls-files");
> -	argv_array_push(&cp.args, "--recurse-submodules");
> -
> -	/* add supported options */
> -	argv_array_pushv(&cp.args, submodule_options.argv);
> -
> -	cp.git_cmd = 1;
> -	dir = mkpathdup("%s/%s", get_git_work_tree(), ce->name);
> -	cp.dir = dir;
> -	status = run_command(&cp);
> -	free(dir);
> -	if (status)
> -		exit(status);
> +	struct repository submodule;
> +	char *gitdir = mkpathdup("%s/%s", superproject->worktree, path);
> +	repo_init(&submodule, gitdir);
> +
> +	repo_read_index(&submodule);
> +	repo_read_gitmodules(&submodule);
> +
> +	if (superproject->submodule_prefix)
> +		submodule.submodule_prefix = xstrfmt("%s%s/", superproject->submodule_prefix, path);
> +	else
> +		submodule.submodule_prefix = xstrfmt("%s/", path);
> +	show_files(&submodule, dir);
> +
> +	repo_clear(&submodule);
> +	free(gitdir);
>  }
>  
> -static void show_ce_entry(const char *tag, const struct cache_entry *ce)
> +static void show_ce(struct repository *repo, struct dir_struct *dir,
> +		    const struct cache_entry *ce, const char *fullname,
> +		    const char *tag)
>  {
> -	struct strbuf name = STRBUF_INIT;
> -	int len = max_prefix_len;
> -	if (super_prefix)
> -		strbuf_addstr(&name, super_prefix);
> -	strbuf_addstr(&name, ce->name);
> -
> -	if (len > ce_namelen(ce))
> +	if (max_prefix_len > strlen(fullname))
>  		die("git ls-files: internal error - cache entry not superset of prefix");
>  
>  	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
> -	    submodule_path_match(&pathspec, name.buf, ps_matched)) {
> -		show_gitlink(ce);
> -	} else if (match_pathspec(&pathspec, name.buf, name.len,
> -				  len, ps_matched,
> +	    submodule_path_match(&pathspec, fullname, ps_matched) &&
> +	    is_submodule_active(repo, ce->name)) {
> +		show_submodule(repo, dir, ce->name);
> +	} else if (match_pathspec(&pathspec, fullname, strlen(fullname),
> +				  max_prefix_len, ps_matched,
>  				  S_ISDIR(ce->ce_mode) ||
>  				  S_ISGITLINK(ce->ce_mode))) {
>  		tag = get_tag(ce, tag);
> @@ -299,12 +245,11 @@ static void show_ce_entry(const char *tag, const struct cache_entry *ce)
>  			       find_unique_abbrev(ce->oid.hash, abbrev),
>  			       ce_stage(ce));
>  		}
> -		write_eolinfo(&the_index, ce, ce->name);
> -		write_name(ce->name);
> +
> +		write_eolinfo(repo->index, ce, fullname);
> +		write_name(fullname);
>  		print_debug(ce);
>  	}
> -
> -	strbuf_release(&name);
>  }
>  
>  static void show_ru_info(const struct index_state *istate)
> @@ -337,59 +282,79 @@ static void show_ru_info(const struct index_state *istate)
>  }
>  
>  static int ce_excluded(struct dir_struct *dir, struct index_state *istate,
> -		       const struct cache_entry *ce)
> +		       const char *fullname, const struct cache_entry *ce)
>  {
>  	int dtype = ce_to_dtype(ce);
> -	return is_excluded(dir, istate, ce->name, &dtype);
> +	return is_excluded(dir, istate, fullname, &dtype);
> +}
> +
> +static void construct_fullname(struct strbuf *out, const struct repository *repo,
> +			       const struct cache_entry *ce)
> +{
> +	strbuf_reset(out);
> +	if (repo->submodule_prefix)
> +		strbuf_addstr(out, repo->submodule_prefix);
> +	strbuf_addstr(out, ce->name);
>  }
>  
> -static void show_files(struct index_state *istate, struct dir_struct *dir)
> +static void show_files(struct repository *repo, struct dir_struct *dir)
>  {
>  	int i;
> +	struct strbuf fullname = STRBUF_INIT;
>  
>  	/* For cached/deleted files we don't need to even do the readdir */
>  	if (show_others || show_killed) {
>  		if (!show_others)
>  			dir->flags |= DIR_COLLECT_KILLED_ONLY;
> -		fill_directory(dir, istate, &pathspec);
> +		fill_directory(dir, repo->index, &pathspec);
>  		if (show_others)
> -			show_other_files(istate, dir);
> +			show_other_files(repo->index, dir);
>  		if (show_killed)
> -			show_killed_files(istate, dir);
> +			show_killed_files(repo->index, dir);
>  	}
>  	if (show_cached || show_stage) {
> -		for (i = 0; i < istate->cache_nr; i++) {
> -			const struct cache_entry *ce = istate->cache[i];
> +		for (i = 0; i < repo->index->cache_nr; i++) {
> +			const struct cache_entry *ce = repo->index->cache[i];
> +
> +			construct_fullname(&fullname, repo, ce);
> +
>  			if ((dir->flags & DIR_SHOW_IGNORED) &&
> -			    !ce_excluded(dir, istate, ce))
> +			    !ce_excluded(dir, repo->index, fullname.buf, ce))
>  				continue;
>  			if (show_unmerged && !ce_stage(ce))
>  				continue;
>  			if (ce->ce_flags & CE_UPDATE)
>  				continue;
> -			show_ce_entry(ce_stage(ce) ? tag_unmerged :
> -				(ce_skip_worktree(ce) ? tag_skip_worktree : tag_cached), ce);
> +			show_ce(repo, dir, ce, fullname.buf,
> +				ce_stage(ce) ? tag_unmerged :
> +				(ce_skip_worktree(ce) ? tag_skip_worktree :
> +				 tag_cached));
>  		}
>  	}
>  	if (show_deleted || show_modified) {
> -		for (i = 0; i < istate->cache_nr; i++) {
> -			const struct cache_entry *ce = istate->cache[i];
> +		for (i = 0; i < repo->index->cache_nr; i++) {
> +			const struct cache_entry *ce = repo->index->cache[i];
>  			struct stat st;
>  			int err;
> +
> +			construct_fullname(&fullname, repo, ce);
> +
>  			if ((dir->flags & DIR_SHOW_IGNORED) &&
> -			    !ce_excluded(dir, istate, ce))
> +			    !ce_excluded(dir, repo->index, fullname.buf, ce))
>  				continue;
>  			if (ce->ce_flags & CE_UPDATE)
>  				continue;
>  			if (ce_skip_worktree(ce))
>  				continue;
> -			err = lstat(ce->name, &st);
> +			err = lstat(fullname.buf, &st);
>  			if (show_deleted && err)
> -				show_ce_entry(tag_removed, ce);
> -			if (show_modified && ie_modified(istate, ce, &st, 0))
> -				show_ce_entry(tag_modified, ce);
> +				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +			if (show_modified && ie_modified(repo->index, ce, &st, 0))
> +				show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  		}
>  	}
> +
> +	strbuf_release(&fullname);
>  }
>  
>  /*
> @@ -614,10 +579,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	prefix = cmd_prefix;
>  	if (prefix)
>  		prefix_len = strlen(prefix);
> -	super_prefix = get_super_prefix();
>  	git_config(git_default_config, NULL);
>  
> -	if (read_cache() < 0)
> +	if (repo_read_index(the_repository))

oops, looks like this should have been:

    if (repo_read_index(the_repository) < 0)

>  		die("index file corrupt");
>  
>  	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
> @@ -650,8 +614,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	if (require_work_tree && !is_inside_work_tree())
>  		setup_work_tree();
>  
> -	if (recurse_submodules)
> -		compile_submodule_options(argv, &dir, show_tag);
> +	if (recurse_submodules) {
> +		repo_read_gitmodules(the_repository);
> +	}
>  
>  	if (recurse_submodules &&
>  	    (show_stage || show_deleted || show_others || show_unmerged ||
> @@ -669,7 +634,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  	/*
>  	 * Find common prefix for all pathspec's
>  	 * This is used as a performance optimization which unfortunately cannot
> -	 * be done when recursing into submodules
> +	 * be done when recursing into submodules because when a pathspec is
> +	 * given which spans repository boundaries you can't simply remove the
> +	 * submodule entry because the pathspec may match something inside the
> +	 * submodule.
>  	 */
>  	if (recurse_submodules)
>  		max_prefix = NULL;
> @@ -677,7 +645,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		max_prefix = common_prefix(&pathspec);
>  	max_prefix_len = get_common_prefix_len(max_prefix);
>  
> -	prune_index(&the_index, max_prefix, max_prefix_len);
> +	prune_index(the_repository->index, max_prefix, max_prefix_len);
>  
>  	/* Treat unmatching pathspec elements as errors */
>  	if (pathspec.nr && error_unmatch)
> @@ -698,11 +666,13 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		 */
>  		if (show_stage || show_unmerged)
>  			die("ls-files --with-tree is incompatible with -s or -u");
> -		overlay_tree_on_index(&the_index, with_tree, max_prefix);
> +		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
>  	}
> -	show_files(&the_index, &dir);
> +
> +	show_files(the_repository, &dir);
> +
>  	if (show_resolve_undo)
> -		show_ru_info(&the_index);
> +		show_ru_info(the_repository->index);
>  
>  	if (ps_matched) {
>  		int bad;
> diff --git a/git.c b/git.c
> index 594436e43..16c6e325d 100644
> --- a/git.c
> +++ b/git.c
> @@ -442,7 +442,7 @@ static struct cmd_struct commands[] = {
>  	{ "init-db", cmd_init_db },
>  	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
>  	{ "log", cmd_log, RUN_SETUP },
> -	{ "ls-files", cmd_ls_files, RUN_SETUP | SUPPORT_SUPER_PREFIX },
> +	{ "ls-files", cmd_ls_files, RUN_SETUP },
>  	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
>  	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
>  	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY },
> diff --git a/repository.c b/repository.c
> index 98a851d20..9f899a34a 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -152,6 +152,8 @@ int repo_init(struct repository *repo, const char *gitdir)
>  	if (verify_repo_format(&format, repo->commondir))
>  		goto error;
>  
> +	repo_set_worktree(repo, gitdir);
> +
>  	return 0;
>  
>  error:
> @@ -180,6 +182,8 @@ void repo_clear(struct repository *repo)
>  	repo_clear_env(repo);
>  	free(repo->worktree);
>  	repo->worktree = NULL;
> +	free(repo->submodule_prefix);
> +	repo->submodule_prefix = NULL;
>  
>  	if (repo->config) {
>  		git_configset_clear(repo->config);
> diff --git a/repository.h b/repository.h
> index d9f1f721b..eea9a88aa 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -14,6 +14,7 @@ struct repository {
>  	char *graft_file;
>  	char *namespace;
>  	char *worktree;
> +	char *submodule_prefix;
>  
>  	/* Subsystems */
>  	/*
> diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recurse-submodules.sh
> index ebb956fd1..318b5bce7 100755
> --- a/t/t3007-ls-files-recurse-submodules.sh
> +++ b/t/t3007-ls-files-recurse-submodules.sh
> @@ -135,6 +135,45 @@ test_expect_success '--recurse-submodules and pathspecs setup' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'inactive submodule' '
> +	test_when_finished "git config --bool submodule.submodule.active true" &&
> +	test_when_finished "git -C submodule config --bool submodule.subsub.active true" &&
> +	git config --bool submodule.submodule.active "false" &&
> +
> +	cat >expect <<-\EOF &&
> +	.gitmodules
> +	a
> +	b/b
> +	h.txt
> +	sib/file
> +	sub/file
> +	submodule
> +	EOF
> +
> +	git ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual &&
> +
> +	git config --bool submodule.submodule.active "true" &&
> +	git -C submodule config --bool submodule.subsub.active "false" &&
> +
> +	cat >expect <<-\EOF &&
> +	.gitmodules
> +	a
> +	b/b
> +	h.txt
> +	sib/file
> +	sub/file
> +	submodule/.gitmodules
> +	submodule/c
> +	submodule/f.TXT
> +	submodule/g.txt
> +	submodule/subsub
> +	EOF
> +
> +	git ls-files --recurse-submodules >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success '--recurse-submodules and pathspecs' '
>  	cat >expect <<-\EOF &&
>  	h.txt
> -- 
> 2.13.1.508.gb3defc5cc-goog
> 

-- 
Brandon Williams
