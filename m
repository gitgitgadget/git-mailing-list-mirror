Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8752A20802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752714AbdFVUfP (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:35:15 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33200 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdFVUfO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:35:14 -0400
Received: by mail-pg0-f48.google.com with SMTP id f127so12453609pgc.0
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MHGwKOs7GCWiZIj5gVRsgHo++syfjkBJSlIjngo/Lkc=;
        b=LP9fOJ9Zn5ocz0u1vN40NYxdu8VEBAsEN3c4n/ziLwqVvwFIB8pBvslbIOKcONIN4j
         eoJC0lEV0pmqaS5+NlCoGYMA+fys7pNOcBygQVUwKnmF9kj8Xtlt0miwL1vREPhVRh73
         wm3mOKITMX3aXFqGyaSv8YwnIxNuVoh8+Lom2/rKv50B5vsADyydWBUmcYZNJDmP7CSr
         5yNDHDF8r665iA1kyZqksfs9yj40F6NQ9gE4AmHaHwOIzGarP77zsZv2oUtMJlmuNIqd
         0DQ1cQ5AFa0sq64FYVFTGR9z6OtGw+rWfTG9W7aha9zSJjA1mv3tSx27qBltOX6m38H5
         uIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MHGwKOs7GCWiZIj5gVRsgHo++syfjkBJSlIjngo/Lkc=;
        b=HbK8CHWkBK7Okg92p9pPJab6kumHX2TS7GMCB59tR/ucbZvbFMLCCNIGwBsIbCGV6i
         ng2pCQeo1GP1/E1BegQmo6lVJpxVowB1fFy9hKlll1p9K/4GveuQXZRV/YD0zRdpkmSa
         y7B5hVd3BJM15cCyj0UgHOxkJR/yewi2+eswHyIdlrMXLXhxDGPLo03xneNiMwVm9+j/
         PX9WEVw4lwwqzTaDBnJ3tAnBxQvzjhnMtPmaQK5idvt71dl/fNh2RjygFAcVq/Jhb+kC
         auw3QrUIh9LvU3wyrC48tRbqrC7lQnWXrUHQslJg2Ak6bQs2LBeuIsTDwOfJgDHzzJKV
         ZyZQ==
X-Gm-Message-State: AKS2vOzMDc9ZRUjQzK2zx1fUQ5FjNE/GdDzn94XnaQ6FVnKMAYNqaXrL
        7+HokXWStPZgjp+z
X-Received: by 10.84.132.2 with SMTP id 2mr4859983ple.46.1498163714053;
        Thu, 22 Jun 2017 13:35:14 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9474:9438:25ba:a969])
        by smtp.gmail.com with ESMTPSA id 63sm6194195pgd.57.2017.06.22.13.35.12
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 13:35:13 -0700 (PDT)
Date:   Thu, 22 Jun 2017 13:35:11 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, peff@peff.net, git@jeffhostetler.com,
        avarab@gmail.com, jonathantanmy@google.com
Subject: Re: [PATCH v4 15/20] repository: add index_state to struct repo
Message-ID: <20170622203511.GB124061@google.com>
References: <20170620191951.84791-1-bmwill@google.com>
 <20170622184348.56497-1-bmwill@google.com>
 <20170622184348.56497-16-bmwill@google.com>
 <xmqqshirixrt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqshirixrt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >  struct repository {
> >  	/* Environment */
> > @@ -49,6 +50,12 @@ struct repository {
> >  	 */
> >  	struct config_set *config;
> >  
> > +	/*
> > +	 * Repository's in-memory index.
> > +	 * 'repo_read_index()' can be used to populate 'index'.
> > +	 */
> > +	struct index_state *index;
> > +
> >  	/* Configurations */
> >  	/*
> >  	 * Bit used during initialization to indicate if repository state (like
> > @@ -71,4 +78,6 @@ extern void repo_set_worktree(struct repository *repo, const char *path);
> >  extern int repo_init(struct repository *repo, const char *gitdir, const char *worktree);
> >  extern void repo_clear(struct repository *repo);
> >  
> > +extern int repo_read_index(struct repository *repo);
> > +
> >  #endif /* REPOSITORY_H */
> 
> While you are working on a simple read-only operation like
> "ls-files", you can get away with just a singleton (the equivalent
> to "the_index" in the repository object world) in-core index
> instance, and having a way to tell the system to read things into
> the default thing without having to name what that default thing is
> is a very useful thing to have.  It is a good thing that this only
> needs "struct repository *" and no "struct index_state *" parameter.
> 
> But you will need a way to read, update, write it out as a tree,
> etc. to a non-default in-core index, once you start doing more
> complex things.  The function signature of the lowest level
> primitive helper for them will be:
> 
>     extern int (*)(struct repository *, struct index_state *);
> 
> And you would want to reserve "index" suffix for such a function,
> following the "if you use the default in-core thing, you do not have
> to pass it as a parameter---just call _cache() convenience macro;
> but you can explicitly pass it to the underlying _index() function"
> convention we established long time ago.
> 
> So I'd suggest renaming the above one that uses the default in-core
> index instance to
> 
> 	extern int repo_read_cache(struct repository *);
> 
> or you will regret later.
> 

That makes sense.  While at it, would it make sense to ensure that the
'struct index_state *' which is stored in 'the_repository.index' be
'&the_index'?

-- 
Brandon Williams
