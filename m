Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAC161F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751206AbeACWQp (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:16:45 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36122 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750945AbeACWQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:16:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id b76so299535wmg.1
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 14:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Osav6hMEMWhDUyaFfXoK3MRxn1EtYJVcLWVwcp15lM0=;
        b=QCQFthYkxmO4yo3+WOdEaTrfDlt0p4BYjXdYRMlKItCHHjjtkkqFCvJQAY+svmvLIc
         IKTgN1P039JhwasZ5eyLSpORlUYZuCQj09ySq0MQxnET4f+a9kEWuxB6Ln1cEtlM9krl
         JDA2l3kECs7yFH7CT5rp/P8GWDNzYUMfC1FW3LPgkc1GWUeakjbD5Op4pYHmMTX+UHgQ
         bmHxVkTZmd9yPiSurdcU4DmhVlvTJ6oB90oGXKC0Ggt/dne/QGnm8mCR8U9FB76ENO68
         i4yLyfwBMxVxOD3MfECauoAWwKcAbSNrHgybiWTSLHdPkMn0w8M3a7lpfVpex/4c2a1p
         W8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Osav6hMEMWhDUyaFfXoK3MRxn1EtYJVcLWVwcp15lM0=;
        b=Pejv7ibvZyZSKyTtIDwYgkAucOw8OqFGu9Tq6bv+WNTonyrVS3CyHsqqrN48LT27oG
         /m8/RmHZ8a3bDnf38qS8DFe6hgoMghUW9prL84J75iRS89TNWcxiAJfnFYILzZc/x+aq
         PGWWGLlYTZo5xayOF2zE/iv2FzQCMj73PtXZokZxvzWwUyoTY9Fk/yfBnEm49G6yhNDg
         CpJPpxCW6SXEHWkIw1TqY3wtXk2FabhGCSFFUHdJNNW92i/qbEwn1Mk045sojkgocJUd
         lFrwcBS2FFqxAArImKjzNZtKEaFk+5P1wShfz4mgZ73cMUorTCOvXbq+6nTrICDH5ZTy
         JJeg==
X-Gm-Message-State: AKGB3mJgE5k7J6GCiFSa/o3j3pSgV/JrNkgdSmEFGI6syWy+vurnd65S
        7e+QK5HycF0DNEBJSxOVY74=
X-Google-Smtp-Source: ACJfBot7RemYvgpdIS1AVr/GjHtuwek7HFcFoCvGX4+RyVPqzNgWYPdLKeJgiaHWi3vyTTfgJeYG1A==
X-Received: by 10.28.174.20 with SMTP id x20mr2566177wme.27.1515017802794;
        Wed, 03 Jan 2018 14:16:42 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id h76sm3029039wmd.2.2018.01.03.14.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jan 2018 14:16:41 -0800 (PST)
Date:   Wed, 3 Jan 2018 22:18:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 2/3] prune: fix pruning with multiple worktrees and
 split index
Message-ID: <20180103221849.GC2641@hank>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
 <20171217225122.28941-3-t.gummerer@gmail.com>
 <20171218181913.GB147973@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218181913.GB147973@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[sorry for the late reply.  I was on Christmas holidays until today
and am still catching up on the mailing list.  It will probably take
me untill the weekend to send a re-roll]

On 12/18, Brandon Williams wrote:
> On 12/17, Thomas Gummerer wrote:
> > be489d02d2 ("revision.c: --indexed-objects add objects from all
> > worktrees", 2017-08-23) made sure that pruning takes objects from all
> > worktrees into account.
> > 
> > It did that by reading the index of every worktree and adding the
> > necessary index objects to the set of pending objects.  The index is
> > read by read_index_from.  As mentioned in the previous commit,
> > read_index_from depends on the CWD for the location of the split index,
> 
> As I mentioned before this doesn't actually depend on the CWD but
> rather the per-worktree gitdir.

Right, will fix.

> > and add_index_objects_to_pending doesn't set that before using
> > read_index_from.
> > 
> > Instead of using read_index_from, use repo_read_index, which is aware of
> > the proper paths for the worktree.
> > 
> > This fixes t5304-prune when ran with GIT_TEST_SPLIT_INDEX set.
> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  repository.c | 11 +++++++++++
> >  repository.h |  2 ++
> >  revision.c   | 14 +++++++++-----
> >  3 files changed, 22 insertions(+), 5 deletions(-)
> > 
> > diff --git a/repository.c b/repository.c
> > index 928b1f553d..3c9bfbd1b8 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -2,6 +2,7 @@
> >  #include "repository.h"
> >  #include "config.h"
> >  #include "submodule-config.h"
> > +#include "worktree.h"
> >  
> >  /* The main repository */
> >  static struct repository the_repo = {
> > @@ -146,6 +147,16 @@ int repo_init(struct repository *repo, const char *gitdir, const char *worktree)
> >  	return -1;
> >  }
> >  
> > +/*
> > + * Initialize 'repo' based on the provided worktree
> > + * Return 0 upon success and a non-zero value upon failure.
> > + */
> > +int repo_worktree_init(struct repository *repo, struct worktree *worktree)
> > +{
> > +	return repo_init(repo, get_worktree_git_dir(worktree),
> > +			 worktree->path);
> 
> I still feel very unsettled about this and don't think its a good idea.
> get_worktree_git_dir depends implicitly on the global the_repository
> object and I would like to avoid relying on it for an initialization
> function like this.
> 
> > +}
> > +
> >  /*
> >   * Initialize 'submodule' as the submodule given by 'path' in parent repository
> >   * 'superproject'.
> > diff --git a/repository.h b/repository.h
> > index 7f5e24a0a2..2adeb05bf4 100644
> > --- a/repository.h
> > +++ b/repository.h
> > @@ -4,6 +4,7 @@
> >  struct config_set;
> >  struct index_state;
> >  struct submodule_cache;
> > +struct worktree;
> >  
> >  struct repository {
> >  	/* Environment */
> > @@ -87,6 +88,7 @@ extern struct repository *the_repository;
> >  extern void repo_set_gitdir(struct repository *repo, const char *path);
> >  extern void repo_set_worktree(struct repository *repo, const char *path);
> >  extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
> > +extern int repo_worktree_init(struct repository *repo, struct worktree *worktree);
> >  extern int repo_submodule_init(struct repository *submodule,
> >  			       struct repository *superproject,
> >  			       const char *path);
> > diff --git a/revision.c b/revision.c
> > index e2e691dd5a..34e1e4b799 100644
> > --- a/revision.c
> > +++ b/revision.c
> > @@ -22,6 +22,7 @@
> >  #include "packfile.h"
> >  #include "worktree.h"
> >  #include "argv-array.h"
> > +#include "repository.h"
> >  
> >  volatile show_early_output_fn_t show_early_output;
> >  
> > @@ -1346,15 +1347,18 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
> >  	worktrees = get_worktrees(0);
> >  	for (p = worktrees; *p; p++) {
> >  		struct worktree *wt = *p;
> > -		struct index_state istate = { NULL };
> > +		struct repository *repo;
> >  
> > +		repo = xmalloc(sizeof(struct repository));
> >  		if (wt->is_current)
> >  			continue; /* current index already taken care of */
> > +		if (repo_worktree_init(repo, wt))
> > +			BUG("couldn't initialize repository object from worktree");
> >  
> > -		if (read_index_from(&istate,
> > -				    worktree_git_path(wt, "index")) > 0)
> 
> Ok, after thinking this through a bit more I think a better approach may
> be to restructure the call to read_index_from to take in both an index
> file as well as the explicit gitdir to use when constructing a path to
> the sharedindex file.  That way you can fix this for worktrees and
> submodules without having to pass in a repository object to the logic
> which is reading an index file as well as avoiding needing to init a
> repository object for every worktree.

I still think with eventually we probably only want to read the index
through a repository object instead of reading it to a separate struct
index_state.

But we can probably defer that for now, as this series really just
wants to fix the regressions, and we can think a bit more about how
the repository struct interacts with worktrees.

> So you could rework the first patch to do something like:

Thanks for the below, I'll try the below and see how much churn it
causes adjusting all the callsites, and send a re-roll later this
week.

> diff --git a/read-cache.c b/read-cache.c
> index 2eb81a66b..3a04b5567 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1863,20 +1863,19 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>   * This way, shared index can be removed if they have not been used
>   * for some time.
>   */
> -static void freshen_shared_index(char *base_sha1_hex, int warn)
> +static void freshen_shared_index(const char *shared_index, int warn)
>  {
> -	char *shared_index = git_pathdup("sharedindex.%s", base_sha1_hex);
>  	if (!check_and_freshen_file(shared_index, 1) && warn)
>  		warning("could not freshen shared index '%s'", shared_index);
> -	free(shared_index);
>  }
>  
> -int read_index_from(struct index_state *istate, const char *path)
> +int read_index_from(struct index_state *istate, const char *path,
> +		    const char *gitdir)
>  {
>  	struct split_index *split_index;
>  	int ret;
>  	char *base_sha1_hex;
> -	const char *base_path;
> +	char *base_path;
>  
>  	/* istate->initialized covers both .git/index and .git/sharedindex.xxx */
>  	if (istate->initialized)
> @@ -1896,14 +1895,14 @@ int read_index_from(struct index_state *istate, const char *path)
>  		split_index->base = xcalloc(1, sizeof(*split_index->base));
>  
>  	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> -	base_path = git_path("sharedindex.%s", base_sha1_hex);
> +	base_path = xstrfmt("%s/sharedindex.%s", gitdir, base_sha1_hex);
>  	ret = do_read_index(split_index->base, base_path, 1);
>  	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
>  		die("broken index, expect %s in %s, got %s",
>  		    base_sha1_hex, base_path,
>  		    sha1_to_hex(split_index->base->sha1));
>  
> -	freshen_shared_index(base_sha1_hex, 0);
> +	freshen_shared_index(base_path, 0);
>  	merge_base_index(istate);
>  	post_read_index_from(istate);
> + free(base_path);
>  	return ret;
> 
> 
> -- 
> Brandon Williams
