Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B841F404
	for <e@80x24.org>; Mon, 11 Dec 2017 21:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751663AbdLKViG (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 16:38:06 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34781 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbdLKViF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 16:38:05 -0500
Received: by mail-wr0-f193.google.com with SMTP id y21so19116511wrc.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 13:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Ox+LSvjBMN6jAroZ4zVgwuMkPRVACCHJRNxs2I5+kc=;
        b=VIij/hlwcucEvwqBR/1jrs66UBegHKOuq8eoCR3ApTGTQFHJr/sg0pWr6PFf9pmrSs
         ulH5QU/N/368Xc4jfSrzGSNUX+zfweiM9UoyGRB6ho8H02JyFo3mS+viy28IuAj+IcrF
         Y0e706RioUpPLyQY83uUUde+6BG9/YxH78vh9CIoPIynBOP+f27qd7UZ4xYzQ/F1oxW+
         Ih1sCQ1trygZ53Htf+h2gJCTzmN2TXO/f/kWVY5yL/PBA+gEEe3e+ftOIbsej84EnRI8
         gQmvsezg8qQmin0/n4umHF3yBN2uwEexfUyiTRhBmC6i8INNoITnnhgbR6MWovi+id0x
         7Swg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Ox+LSvjBMN6jAroZ4zVgwuMkPRVACCHJRNxs2I5+kc=;
        b=tjdx8Ky1LEuvr3v+5AfMRucN7stHbXAgLiWZo/X6tnFMMQb3xZDzg0VRoHMtSnFehk
         HuXIva0jr9D58Dz9XAMu0MGMt5u49LWyfqohsgQ5AIoo8NzFF3Bx660o8hRIEi+MeOcR
         EvQKdxHzzZTpzc6h3JeshENBUhWgnQGXm4V+cjF/PTxaQqVQmAGdEG4Yh3rP9LHNUPpQ
         cA4BLxrR8oTB9ICii+O8eXErnI573xSBQUqghSklnC69vXZlt6/WWG9ifHwv4dA/ZTXf
         otNW6emoE4gbgna01SZUe6uWaZpOaUORc4vTyoHxptfUw27/czm+YoIt8zt0GDRIgyVq
         QC8w==
X-Gm-Message-State: AKGB3mLZ2ZEcPYojRDEIV4Y168Y1azKyyfA97c7E5GJx7vNN6WQKUtcZ
        Qh9BfBVJYsTPm+7c5BC49vULn8bQ
X-Google-Smtp-Source: ACJfBosCa304EIBLr3I9IwRuPvjXbwBHPj0NU8GKIM0Sxy5r2019Y0SNzjdcmqGEh1D7746E0hrgHw==
X-Received: by 10.223.191.13 with SMTP id p13mr1769135wrh.69.1513028284364;
        Mon, 11 Dec 2017 13:38:04 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id w142sm557763wme.3.2017.12.11.13.38.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 13:38:03 -0800 (PST)
Date:   Mon, 11 Dec 2017 21:39:48 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] prune: fix pruning with multiple worktrees and split
 index
Message-ID: <20171211213948.GC25616@hank>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171210212202.28231-3-t.gummerer@gmail.com>
 <20171211190946.GB177995@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171211190946.GB177995@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/11, Brandon Williams wrote:
> On 12/10, Thomas Gummerer wrote:
> > be489d02d2 ("revision.c: --indexed-objects add objects from all
> > worktrees", 2017-08-23) made sure that pruning takes objects from all
> > worktrees into account.
> > 
> > It did that by reading the index of every worktree and adding the
> > necessary index objects to the set of pending objects.  The index is
> > read by read_index_from.  As mentioned in the previous commit,
> > read_index_from depends on the CWD for the location of the split index,
> > and add_index_objects_to_pending doesn't set that before using
> > read_index_from.
> > 
> > Instead of using read_index_from, use repo_read_index, which is aware of
> > the proper paths for the worktree.
> > 
> > This fixes t5304-prune when ran with GIT_TEST_SPLIT_INDEX set.
> > 
> 
> I'm on the fence about this change.  I understand that this will ensure
> that the proper objects aren't pruned when using a split index in the
> presence of worktrees but I think the solution needs to be thought
> through a bit more.
> 
> My big concern right now is the interaction of 'struct worktree's and
> 'struct repository'.  I'll try to highlight my concerns below.

Thanks for the review!  My thoughts on the concerns are below.

> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> > 
> > This also fixes t7009 when ran with GIT_TEST_SPLIT_INDEX.  I'm not
> > quite sure why it is fixed by this.  Either way I tracked the failure
> > down to f767178a5a ("Merge branch 'jk/no-null-sha1-in-cache-tree'",
> > 2017-05-16).  Maybe Peff has an idea why this fixes that test?
> > 
> >  repository.c | 11 +++++++++++
> >  repository.h |  2 ++
> >  revision.c   | 13 ++++++++-----
> >  3 files changed, 21 insertions(+), 5 deletions(-)
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
> > +}
> 
> My first concern is the use of 'get_worktree_git_dir()'.  Under the hood
> it calls 'get_git_dir()', 'get_git_common_dir()', and
> 'git_common_path()' which rely on global state as stored in
> 'the_repository'.  So how does one initialize a repository struct (using
> this initializer) using a worktree from a repository other than the
> global 'the_repository' struct?  I'm not sure I have an answer right
> now, but its an issue that needs to be thought through before we head
> down this road.

The main reason for just using 'get_worktree_git_dir()' was because it
exists and it does exactly what I needed.  If we ever have the need to
initialize a repository struct for a worktree from another repository
struct, I would imagine we introduce a new function
'repo_get_worktree_git_dir()', which takes a struct repository as
input and returns the worktree git dir based on that.

And then we'd have to add a different initializer
'repo_worktree_init_from_repo()' or something like that, where we
could initialize a worktree from a repository struct different from
'the_repository'.  But maybe there are some complications there that I
didn't think about?

> Just thinking to myself, Does it make sense to have worktree's as a
> separate struct or to have them stored in 'struct repository' in some
> way?

I'm not sure I have a good answer for this.  Looking at the libgit2
source, which has a repository struct for (I assume at least, I'm not
very familiar with the libgit2 source :)), they have a repository
struct for each worktree, with a flag specifying whether the struct is
for a worktree, or a "normal" git repository/the main worktree.

Obviously that doesn't mean we should do it the same way, but it
probably also doesn't hurt to look at prior art.

> Shouldn't a repository struct have a way to interact with all of
> its worktrees?

It could go either way I guess depending on how we want to design it.
If we want the repository struct to interact with all worktrees, it
seems to me like we would almost need some kind of 'struct
super_repository', which then contains a list of 'struct repository's
representing each worktree, probably including the main worktree.

But then again in normal operation we probably only want the
repository struct for the current repository we're working with, not
all of the worktrees.  I suspect it's only in some special cases where
we want to have all worktrees in memory at once (such as in the prune
case).

Or how would you haven envisioned this?

> How would initializing a repository struct for every
> worktree work once we migrate the object store to be stored in 'struct
> repoisotry'?  Shouldn't every worktree share the same object store
> in-memory like they do on-disk?

I haven't thought this far.  They probably want to share the same
object store, if they all want the object store to be loaded.  But
we can do that either way, whether we have one 'struct repository'
that has links to the worktrees, or we have multiple 'struct
repository's, which each have a ref-counted pointer to the object
store or something like that.

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
> > index e2e691dd5a..9d8d9b96d1 100644
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
> > @@ -1346,15 +1347,17 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
> >  	worktrees = get_worktrees(0);
> >  	for (p = worktrees; *p; p++) {
> >  		struct worktree *wt = *p;
> > -		struct index_state istate = { NULL };
> > +		struct repository *repo;
> >  
> > +		repo = xmalloc(sizeof(struct repository));
> 
> This was allocated but never freed, was that intentional?

No, that was an oversight, will fix, thanks!

> >  		if (wt->is_current)
> >  			continue; /* current index already taken care of */
> > +		if (repo_worktree_init(repo, wt))
> > +			BUG("couldn't initialize repository object from worktree");
> >  
> > -		if (read_index_from(&istate,
> > -				    worktree_git_path(wt, "index")) > 0)
> > -			do_add_index_objects_to_pending(revs, &istate);
> > -		discard_index(&istate);
> > +		if (repo_read_index(repo) > 0)
> > +			do_add_index_objects_to_pending(revs, repo->index);
> > +		discard_index(repo->index);
> 
> One we have separate object stores per-repository how would we handle
> this since this pruning should only work on a single repository's object
> store?

That depends a lot on how we design the object store and how it's held
by the repository struct.  If we only have one in-memory
representation of it, the answer is obvious.  If we have multiple
in-memory representations of it at the same time, things will get a
bit more hairy.  But until we have at least a design of how that would
look like it's quite hard to tell I'd say.

> >  	}
> >  	free_worktrees(worktrees);
> >  }
> > -- 
> > 2.15.1.504.g5279b80103
> > 
> 
> -- 
> Brandon Williams
