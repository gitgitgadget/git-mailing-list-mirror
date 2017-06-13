Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925B220401
	for <e@80x24.org>; Tue, 13 Jun 2017 06:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752164AbdFMGQc (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 02:16:32 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33746 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752045AbdFMGQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 02:16:31 -0400
Received: by mail-pf0-f171.google.com with SMTP id 83so62484900pfr.0
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eacRrJn1l66TknXpL7eMdcqwo/xcEO9urTW1T+K8dSY=;
        b=dllJvtoMWhNVii4xkSvPYXhwPmtHqZzNjMo1QraIENFRyV+GQYiYxcIRkZ40t765Jo
         iFSvYacuTRhmaq2WRBTkfJGrkSlS05uzMFVDzJaGJS/jQhHKXesDY4pOsZgZKc2oIb++
         0lVFC008hmslNxlw4eyelYPx7BoP5J/t/iNc+X7iz55Pp21Aof8OHlQSU9pJdNgr/sPL
         9uUhsuI48HBWiHau32GvgULWcZgscini+YHEm9uHbzxmg070wttyB6Hh19SfqnMWWJHH
         drV2jdOsuUm+yzMorXUmCDsMHe66cvakGMbiI5DS/ZcQG1ND24izvAWH92bXtOCOxwxP
         GluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eacRrJn1l66TknXpL7eMdcqwo/xcEO9urTW1T+K8dSY=;
        b=sLRbo00XYC2InF2q8sG6FgB0XZe4+OfGTyMKviuNcNfZgBMWMSYGVI2p/TyT8BVh+y
         slyNe1jI8qkghjfA6yjhZ7CHL5n3pn82vaC9EuSjVdwRYhmJEZG/JZTuevwdSQj8hsie
         waCSdacLLGZjusB2ej6aKDxhwERl73exgXIlMs0INlsm7hACIOAavEVYhoiLbTVyElYE
         xa1b5qnwj3ij9kQTkTRicup3iJklTq66CfwzDAAFrL/CEExPulyqVqs4QZAEd/Pnonnl
         M8DMsUKSq6mFELEEvbJNeJ8FOPQXQ9ywI3q3Yy7hFI7VN3BmyK+2FGFReLZJ6UOKBaBH
         Fguw==
X-Gm-Message-State: AODbwcBshboAc5kLOhopcwOH6KpRtBhq8SlNoc/UgbL9B2u3VMhT7Zxh
        38BVFHTAdDSZHgwY
X-Received: by 10.98.217.155 with SMTP id b27mr58866870pfl.17.1497334590576;
        Mon, 12 Jun 2017 23:16:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id y68sm22925968pfy.12.2017.06.12.23.16.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 23:16:29 -0700 (PDT)
Date:   Mon, 12 Jun 2017 23:16:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613061627.GJ154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
 <20170613012337.GH154599@google.com>
 <20170613013817.GE133952@aiede.mtv.corp.google.com>
 <20170613025945.v54vrza2n23tk5pw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613025945.v54vrza2n23tk5pw@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12, Jeff King wrote:
> On Mon, Jun 12, 2017 at 06:38:17PM -0700, Jonathan Nieder wrote:
> 
> > Brandon Williams wrote:
> > > On 06/12, Jonathan Nieder wrote:
> > 
> > >> Alternatively, could this patch rename git_config_with_options?  That
> > >> way any other patch in flight that calls git_config_with_options would
> > >> conflict with this patch, giving us an opportunity to make sure it
> > >> also sets git_dir.  As another nice side benefit it would make it easy
> > >> for someone reading the patch to verify it didn't miss any callers.
> > [...]
> > > And I don't know if I agree with renaming a function just to rename it.
> > 
> > I forgot to say: another way to accomplish the same thing can be to
> > reorder the function's arguments.  The relevant thing is to make code
> > that calls the function without being aware of the new requirements
> > fail to compile.
> 
> If the parameter is now required, then it might make sense for it to
> become an actual function parameter instead of being stuffed into the
> config_options struct. That would give you your breaking change, plus
> make it more obvious to the reader that it is not optional.
> 
> The downside is that has to get shuttled around manually through the
> callstack. Most of the damage is in builtin/config.c, where we call
> git_config_with_options() a lot.
> 
> include_by_gitdir is also a bit annoying, as we pass around the
> config_options struct through our void-pointer callbacks. But we can
> solve that by sticking the git_dir into the include_data struct (whose
> exact purpose is to carry the information we need to handle includes).
> 
> The patch below (on top of Brandon's series does that).

I really don't understand why this has to be so difficult and why a
'breaking change' is even needed.  Duy just added the 'git_dir' field to
the config_options struct in April of this year (2185fde56 config:
handle conditional include when $GIT_DIR is not set up) and now we want
to strip it out again?  That's not even two months. Seems very counter
productive and makes the api more unwieldy.

> 
> > >>> +	if (have_git_dir())
> > >>> +		opts.git_dir = get_git_common_dir();
> > >>
> > >> curious: Why get_git_common_dir() instead of get_git_dir()?
> > >
> > > Needs to be commondir since the config is stored in the common git
> > > directory and not a per worktree git directory.
> > 
> > *puzzled* Why wasn't this needed before, then?  The rest of the patch
> > should result in no functional change, but this part seems different.
> 
> Now I'm puzzled, too. The original that got filled in lazily by the
> config functions was always get_git_dir(). I can buy the argument that
> this was a bug (I'm not familiar enough with worktree to say one way or
> the other), but if it's a fix it should definitely go into another
> patch.

Well actually... in do_git_config_sequence 'git_path("config")' is
called which will convert gitdir to commondir under the hood.  you can't
use vanilla gitdir because the config isn't stored in a worktree's
gitdir but rather in the commondir as the config is shared by all
worktrees.

So maybe we actually need to add a field to the 'config_options' struct
of 'commondir' such that the commondir can be used to load the actual
config file and 'gitdir' can be used to handle the 'IncludeIf' stuff.

> 
> ---
>  builtin/config.c | 17 ++++++++++----
>  config.c         | 43 +++++++++++++++++++----------------
>  config.h         |  4 ++--
>  3 files changed, 37 insertions(+), 27 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index 90f49a6ee..f5dd6f7ff 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -29,6 +29,7 @@ static int actions, types;
>  static int end_null;
>  static int respect_includes_opt = -1;
>  static struct config_options config_options;
> +const char *config_git_dir;
>  static int show_origin;
>  
>  #define ACTION_GET (1<<0)
> @@ -244,7 +245,9 @@ static int get_value(const char *key_, const char *regex_)
>  	}
>  
>  	git_config_with_options(collect_config, &values,
> -				&given_config_source, &config_options);
> +				&given_config_source,
> +				config_git_dir,
> +				&config_options);
>  
>  	ret = !values.nr;
>  
> @@ -322,7 +325,8 @@ static void get_color(const char *var, const char *def_color)
>  	get_color_found = 0;
>  	parsed_color[0] = '\0';
>  	git_config_with_options(git_get_color_config, NULL,
> -				&given_config_source, &config_options);
> +				&given_config_source,
> +				config_git_dir, &config_options);
>  
>  	if (!get_color_found && def_color) {
>  		if (color_parse(def_color, parsed_color) < 0)
> @@ -354,7 +358,8 @@ static int get_colorbool(const char *var, int print)
>  	get_diff_color_found = -1;
>  	get_color_ui_found = -1;
>  	git_config_with_options(git_get_colorbool_config, NULL,
> -				&given_config_source, &config_options);
> +				&given_config_source,
> +				config_git_dir, &config_options);
>  
>  	if (get_colorbool_found < 0) {
>  		if (!strcmp(get_colorbool_slot, "color.diff"))
> @@ -443,7 +448,8 @@ static int get_urlmatch(const char *var, const char *url)
>  	}
>  
>  	git_config_with_options(urlmatch_config_entry, &config,
> -				&given_config_source, &config_options);
> +				&given_config_source, config_git_dir,
> +				&config_options);
>  
>  	ret = !values.nr;
>  
> @@ -540,7 +546,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  	else
>  		config_options.respect_includes = respect_includes_opt;
>  	if (have_git_dir())
> -		config_options.git_dir = get_git_common_dir();
> +		config_git_dir = get_git_common_dir();
>  
>  	if (end_null) {
>  		term = '\0';
> @@ -587,6 +593,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
>  		check_argc(argc, 0, 0);
>  		if (git_config_with_options(show_all_config, NULL,
>  					    &given_config_source,
> +					    config_git_dir,
>  					    &config_options) < 0) {
>  			if (given_config_source.file)
>  				die_errno("unable to read config file '%s'",
> diff --git a/config.c b/config.c
> index 4e2842689..e1566f7b4 100644
> --- a/config.c
> +++ b/config.c
> @@ -208,21 +208,18 @@ static int prepare_include_condition_pattern(struct strbuf *pat)
>  	return prefix;
>  }
>  
> -static int include_by_gitdir(const struct config_options *opts,
> +static int include_by_gitdir(const struct config_include_data *inc,
>  			     const char *cond, size_t cond_len, int icase)
>  {
>  	struct strbuf text = STRBUF_INIT;
>  	struct strbuf pattern = STRBUF_INIT;
>  	int ret = 0, prefix;
> -	const char *git_dir;
>  	int already_tried_absolute = 0;
>  
> -	if (opts->git_dir)
> -		git_dir = opts->git_dir;
> -	else
> +	if (!inc->git_dir)
>  		goto done;
>  
> -	strbuf_realpath(&text, git_dir, 1);
> +	strbuf_realpath(&text, inc->git_dir, 1);
>  	strbuf_add(&pattern, cond, cond_len);
>  	prefix = prepare_include_condition_pattern(&pattern);
>  
> @@ -256,7 +253,7 @@ static int include_by_gitdir(const struct config_options *opts,
>  		 * which'll do the right thing
>  		 */
>  		strbuf_reset(&text);
> -		strbuf_add_absolute_path(&text, git_dir);
> +		strbuf_add_absolute_path(&text, inc->git_dir);
>  		already_tried_absolute = 1;
>  		goto again;
>  	}
> @@ -266,14 +263,14 @@ static int include_by_gitdir(const struct config_options *opts,
>  	return ret;
>  }
>  
> -static int include_condition_is_true(const struct config_options *opts,
> +static int include_condition_is_true(const struct config_include_data *inc,
>  				     const char *cond, size_t cond_len)
>  {
>  
>  	if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> -		return include_by_gitdir(opts, cond, cond_len, 0);
> +		return include_by_gitdir(inc, cond, cond_len, 0);
>  	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> -		return include_by_gitdir(opts, cond, cond_len, 1);
> +		return include_by_gitdir(inc, cond, cond_len, 1);
>  
>  	/* unknown conditionals are always false */
>  	return 0;
> @@ -298,7 +295,7 @@ int git_config_include(const char *var, const char *value, void *data)
>  		ret = handle_path_include(value, inc);
>  
>  	if (!parse_config_key(var, "includeif", &cond, &cond_len, &key) &&
> -	    (cond && include_condition_is_true(inc->opts, cond, cond_len)) &&
> +	    (cond && include_condition_is_true(inc, cond, cond_len)) &&
>  	    !strcmp(key, "path"))
>  		ret = handle_path_include(value, inc);
>  
> @@ -1537,6 +1534,7 @@ int git_config_system(void)
>  }
>  
>  static int do_git_config_sequence(const struct config_options *opts,
> +				  const char *git_dir,
>  				  config_fn_t fn, void *data)
>  {
>  	int ret = 0;
> @@ -1544,8 +1542,8 @@ static int do_git_config_sequence(const struct config_options *opts,
>  	char *user_config = expand_user_path("~/.gitconfig", 0);
>  	char *repo_config;
>  
> -	if (opts->git_dir)
> -		repo_config = mkpathdup("%s/config", opts->git_dir);
> +	if (git_dir)
> +		repo_config = mkpathdup("%s/config", git_dir);
>  	else
>  		repo_config = NULL;
>  
> @@ -1578,6 +1576,7 @@ static int do_git_config_sequence(const struct config_options *opts,
>  
>  int git_config_with_options(config_fn_t fn, void *data,
>  			    struct git_config_source *config_source,
> +			    const char *git_dir,
>  			    const struct config_options *opts)
>  {
>  	struct config_include_data inc = CONFIG_INCLUDE_INIT;
> @@ -1585,7 +1584,7 @@ int git_config_with_options(config_fn_t fn, void *data,
>  	if (opts->respect_includes) {
>  		inc.fn = fn;
>  		inc.data = data;
> -		inc.opts = opts;
> +		inc.git_dir = git_dir;
>  		fn = git_config_include;
>  		data = &inc;
>  	}
> @@ -1601,17 +1600,18 @@ int git_config_with_options(config_fn_t fn, void *data,
>  	else if (config_source && config_source->blob)
>  		return git_config_from_blob_ref(fn, config_source->blob, data);
>  
> -	return do_git_config_sequence(opts, fn, data);
> +	return do_git_config_sequence(opts, git_dir, fn, data);
>  }
>  
>  static void git_config_raw(config_fn_t fn, void *data)
>  {
>  	struct config_options opts = {0};
> +	const char *git_dir;
>  
>  	opts.respect_includes = 1;
>  	if (have_git_dir())
> -		opts.git_dir = get_git_common_dir();
> -	if (git_config_with_options(fn, data, NULL, &opts) < 0)
> +		git_dir = get_git_common_dir();
> +	if (git_config_with_options(fn, data, NULL, git_dir, &opts) < 0)
>  		/*
>  		 * git_config_with_options() normally returns only
>  		 * zero, as most errors are fatal, and
> @@ -1653,11 +1653,12 @@ void read_early_config(config_fn_t cb, void *data)
>  {
>  	struct config_options opts = {0};
>  	struct strbuf buf = STRBUF_INIT;
> +	const char *git_dir;
>  
>  	opts.respect_includes = 1;
>  
>  	if (have_git_dir())
> -		opts.git_dir = get_git_dir();
> +		git_dir = get_git_dir();
>  	/*
>  	 * When setup_git_directory() was not yet asked to discover the
>  	 * GIT_DIR, we ask discover_git_directory() to figure out whether there
> @@ -1667,9 +1668,11 @@ void read_early_config(config_fn_t cb, void *data)
>  	 * call).
>  	 */
>  	else if (discover_git_directory(&buf))
> -		opts.git_dir = buf.buf;
> +		git_dir = buf.buf;
> +	else
> +		git_dir = NULL;
>  
> -	git_config_with_options(cb, data, NULL, &opts);
> +	git_config_with_options(cb, data, NULL, git_dir, &opts);
>  
>  	strbuf_release(&buf);
>  }
> diff --git a/config.h b/config.h
> index c70599bd5..47a8e8845 100644
> --- a/config.h
> +++ b/config.h
> @@ -30,7 +30,6 @@ enum config_origin_type {
>  
>  struct config_options {
>  	unsigned int respect_includes : 1;
> -	const char *git_dir;
>  };
>  
>  typedef int (*config_fn_t)(const char *, const char *, void *);
> @@ -46,6 +45,7 @@ extern void read_early_config(config_fn_t cb, void *data);
>  extern void git_config(config_fn_t fn, void *);
>  extern int git_config_with_options(config_fn_t fn, void *,
>  				   struct git_config_source *config_source,
> +				   const char *git_dir,
>  				   const struct config_options *opts);
>  extern int git_parse_ulong(const char *, unsigned long *);
>  extern int git_parse_maybe_bool(const char *);
> @@ -97,7 +97,7 @@ struct config_include_data {
>  	int depth;
>  	config_fn_t fn;
>  	void *data;
> -	const struct config_options *opts;
> +	const char *git_dir;
>  };
>  #define CONFIG_INCLUDE_INIT { 0 }
>  extern int git_config_include(const char *name, const char *value, void *data);

-- 
Brandon Williams
