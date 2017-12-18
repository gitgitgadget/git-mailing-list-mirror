Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F2A1F424
	for <e@80x24.org>; Mon, 18 Dec 2017 23:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935310AbdLRXDZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 18:03:25 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41907 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934862AbdLRXDY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 18:03:24 -0500
Received: by mail-wr0-f195.google.com with SMTP id p69so7176795wrb.8
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 15:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NrGEaEyKBAoYooFD59hzXDLssqmhNRWRjAZAoSHNUTo=;
        b=Vai1qC97JJyhSMrcKecH++eO47fahNNzzk/A0Kw1cSG4dEwXakYTnTQMHOo+QurkuP
         Y1TwQnB/IcYZ9WBGNqmKeh5NP3g8Rwckme01uYzZJSXTwLdyFLzjGnIvGCWz6eKfRduP
         VV7f0LSoEGRScRr5ckaieytRicnG9OB2xiw0P4+tCIZhELjJlaD9srPDP/jvIBpx1ZiL
         iCgVg1lJsxPDMyT3p8QuxNzMid6aUdDBht4+m3MFYelle66XQeBi17qrbMyl5WGD0m/S
         VNDyovOR9O1arB76vyqFbapghuV32kbEC+xJXlrXmpHB0C8AYLnwe6QO6Emjmsow6K0P
         m+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NrGEaEyKBAoYooFD59hzXDLssqmhNRWRjAZAoSHNUTo=;
        b=q5+U+iQLh3+f8mhCu7bRmS5/Nogb1DJjX+mSXiuJ6qQ/iNbQqjYgMb4je1p5Hpnm7Y
         /snFvO9zZpbAaDdA/B5cbKRznUJetYj5YNyvJOQ4UzQZetzjn9MBPTJcCFGgFbzCDfqu
         2TUFC96aYsSNa4Jd3VKiBdw3IEOvMmYcSNwQ5giHGFFWmrzd1yUJMZk1mhNAVpwhXEUJ
         P4F0ISHJab93hp5EbGkhSXo0srMcbf3Nlo7cKlIzPmZ876xDzFX8+roAGoHA6kaybpd9
         nzaFTLnTcxPynBrIAQh92yScTryDO60v0Pz2/ZLL0jPIQeBGcdP64gfu/OmdZ6jb9e+m
         dU6w==
X-Gm-Message-State: AKGB3mKv7Y1ZBneObcflI86bCSZlrdfKsmRuLDNmRMaMO6JFwxGmbpQt
        bKnn7EFr7bh9gYGj2BDTsHg=
X-Google-Smtp-Source: ACJfBouyTYi6cssGm/7LxPmfpu0Z3QNgdvUVsKGuwWiw15Jt9wUES2YEzK95/HD24w9pLKwcu+oMPQ==
X-Received: by 10.223.160.233 with SMTP id n38mr1999925wrn.45.1513638202639;
        Mon, 18 Dec 2017 15:03:22 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id i65sm629042wme.20.2017.12.18.15.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Dec 2017 15:03:21 -0800 (PST)
Date:   Mon, 18 Dec 2017 23:05:11 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2 1/3] repository: fix repo_read_index with submodules
Message-ID: <20171218230511.GB2641@hank>
References: <20171210212202.28231-1-t.gummerer@gmail.com>
 <20171217225122.28941-1-t.gummerer@gmail.com>
 <20171217225122.28941-2-t.gummerer@gmail.com>
 <20171218180126.GA147973@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171218180126.GA147973@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/18, Brandon Williams wrote:
> On 12/17, Thomas Gummerer wrote:
> > repo_read_index calls read_index_from, which takes an path argument for
> > the location of the index file.  For the split index however it relies
> 
> > on the current working directory to construct the path using git_path.
> 
> This line isn't actually true and should probably be fixed.  git_path
> doesn't rely on the CWD but rather it relies on the gitdir of the main
> repository (the_repository).

Right, let me fix that.  Thanks!

> > 
> > repo_read_index calls read_index_from with the full path for the index
> > file, however it doesn't change the cwd, so when split index mode is
> > turned on, read_index_from can't find the file for the split index.
> > 
> > For example t3007-ls-files-recurse-submodules.sh was broken with
> > GIT_TEST_SPLIT_INDEX set in 188dce131f ("ls-files: use repository
> > object", 2017-06-22), and t7814-grep-recurse-submodules.sh was also
> > broken in a similar manner, probably by introducing struct repository
> > there, although I didn't track down the exact commit for that.
> > 
> > Fix this by introducing a new read_index_for_repo function, which knows
> > about the correct paths for the submodules.
> > 
> > The alternative would have been to make the callers pass in the base
> > path for the split index, however that ended up being more complicated,
> > and I think we want to converge towards using struct repository for
> > things like these anyway.
> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  cache.h      |  1 +
> >  read-cache.c | 16 ++++++++++++++--
> >  repository.c |  2 +-
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/cache.h b/cache.h
> > index cb5db7bf83..d42bea1ef7 100644
> > --- a/cache.h
> > +++ b/cache.h
> > @@ -614,6 +614,7 @@ extern int read_index_preload(struct index_state *, const struct pathspec *paths
> >  extern int do_read_index(struct index_state *istate, const char *path,
> >  			 int must_exist); /* for testting only! */
> >  extern int read_index_from(struct index_state *, const char *path);
> > +extern int read_index_for_repo(const struct repository *);
> >  extern int is_index_unborn(struct index_state *);
> >  extern int read_index_unmerged(struct index_state *);
> >  
> > diff --git a/read-cache.c b/read-cache.c
> > index 2eb81a66b9..70357febdc 100644
> > --- a/read-cache.c
> > +++ b/read-cache.c
> > @@ -20,6 +20,7 @@
> >  #include "split-index.h"
> >  #include "utf8.h"
> >  #include "fsmonitor.h"
> > +#include "repository.h"
> >  
> >  /* Mask for the name length in ce_flags in the on-disk index */
> >  
> > @@ -1871,7 +1872,8 @@ static void freshen_shared_index(char *base_sha1_hex, int warn)
> >  	free(shared_index);
> >  }
> >  
> > -int read_index_from(struct index_state *istate, const char *path)
> > +static int do_read_index_from(struct index_state *istate, const char *path,
> > +			      const struct repository *repo)
> >  {
> >  	struct split_index *split_index;
> >  	int ret;
> > @@ -1896,7 +1898,7 @@ int read_index_from(struct index_state *istate, const char *path)
> >  		split_index->base = xcalloc(1, sizeof(*split_index->base));
> >  
> >  	base_sha1_hex = sha1_to_hex(split_index->base_sha1);
> > -	base_path = git_path("sharedindex.%s", base_sha1_hex);
> > +	base_path = repo_git_path(repo, "sharedindex.%s", base_sha1_hex);
> >  	ret = do_read_index(split_index->base, base_path, 1);
> >  	if (hashcmp(split_index->base_sha1, split_index->base->sha1))
> >  		die("broken index, expect %s in %s, got %s",
> > @@ -1909,6 +1911,16 @@ int read_index_from(struct index_state *istate, const char *path)
> >  	return ret;
> >  }
> >  
> > +int read_index_for_repo(const struct repository *repo)
> > +{
> > +	return do_read_index_from(repo->index, repo->index_file, repo);
> > +}
> 
> > +
> > +int read_index_from(struct index_state *istate, const char *path)
> > +{
> > +	return do_read_index_from(istate, path, the_repository);
> > +}
> 
> This looks fine, though I wonder what the point of passing in the index
> file even was since we end just ended up reading the 'sharedindex' file based
> on the git path. I'm just curious about how this function evolved.

There are some callsites that are using an index different form
$gitdir/index, or even GIT_INDEX_FILE.  e.g. see builtin/am.c [*1*],
which uses it's own 'patch-merge-index' in the am state directory for
its internal operations.

The split index mode was later bolted on, and the sharedindex.xxxx
would always go in $gitdir for the repository.  Others probably know
quite a bit more about this, while I'm always interested in index
related things as that's how I got started with the git project, I
couldn't follow all the conversations that were going on there.

*1*: https://github.com/gitster/git/blob/52015aaf9d19c97b52c47c7046058e6d029ff856/builtin/am.c#L1844

> > +
> >  int is_index_unborn(struct index_state *istate)
> >  {
> >  	return (!istate->cache_nr && !istate->timestamp.sec);
> > diff --git a/repository.c b/repository.c
> > index bb2fae5446..928b1f553d 100644
> > --- a/repository.c
> > +++ b/repository.c
> > @@ -229,5 +229,5 @@ int repo_read_index(struct repository *repo)
> >  	if (!repo->index)
> >  		repo->index = xcalloc(1, sizeof(*repo->index));
> >  
> > -	return read_index_from(repo->index, repo->index_file);
> > +	return read_index_for_repo(repo);
> >  }
> > -- 
> > 2.15.1.620.gb9897f4670
> > 
> 
> -- 
> Brandon Williams
