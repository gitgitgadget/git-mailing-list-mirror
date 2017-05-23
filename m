Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11A7E20281
	for <e@80x24.org>; Tue, 23 May 2017 17:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966152AbdEWR3N (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 13:29:13 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36755 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966099AbdEWR3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 13:29:12 -0400
Received: by mail-pf0-f171.google.com with SMTP id m17so121034582pfg.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jWbxL2U10eSJSM8diNuvmgEAGNcI5B71q5/apG75jgo=;
        b=PX0A2tYw9Ofzitd1U9viChGo8TCTXatuIqg6yC/C/yayxU2PGuJk6YlIa/wEtp2PMZ
         ATQXu2jRZlJPoI02abdy0T+J+bcB65GoKihE9if86jrKBY/fM72Lob5eN8c7tKGKbkF9
         ZJKeZt4gKkX3AGsfJ4tcOZjn9fx8kA07dhXP3dfm5dd3m0HkIkUQoUPAWKZE+Ijud7QH
         ieRE0Na+mD3LPcHP1RY8GAS0UDyF7Axm4jJuDz+iCxFCQCrDK45qmVetqblKnUsN1t1Y
         cCmoAu2UFd4ylGkaVKpnd8LpWeAERM9Pdm+qUtUhz/gChJcogchsvM/ak18M3Bl5RAbp
         v22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jWbxL2U10eSJSM8diNuvmgEAGNcI5B71q5/apG75jgo=;
        b=H/A+euqfy/RflUf4f8Xj6JTnqmoMxMtWku+G+KiL1ZjmZAY1M2KrbA/RDyWK0qbpFw
         4ViqC4o9ch47RjeZiiIZvlI6MpI6hjGbEyRWxuuPy8p4mO+16xrg/08rkoqgDnEZORJT
         yj4y0E7kQCWZf9ZeIEn0UyaV+MaCmXTqx+vDUkCrJETxmOcwpqgymOylzTBbenMxztQ+
         wdquqKQ0ISbGKJG0vFLldIjTxNZNKVTSFYa+j+UWUpC1KvXqJ8S3dO05bxDMNJln+wn2
         l7EiNJ8KP2+1os7V01o+pIoN8JHnyXMqPkVliNhmyiYJaWY7DuZ1152cIWjUNziO1J3Y
         aNPw==
X-Gm-Message-State: AODbwcB3b1xDhVjJNuyj6IHKhuSOcfaJgdBN2by/Kjw76sO6sdEWVl1A
        uiJxHFr3S8YCh+Az
X-Received: by 10.99.114.94 with SMTP id c30mr33283231pgn.6.1495560550942;
        Tue, 23 May 2017 10:29:10 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6539:887d:745f:6fdf])
        by smtp.gmail.com with ESMTPSA id 134sm2999766pgh.43.2017.05.23.10.29.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 10:29:09 -0700 (PDT)
Date:   Tue, 23 May 2017 10:29:08 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, jrnieder@gmail.com,
        pclouds@gmail.com
Subject: Re: [WIP/RFC 00/23] repository object
Message-ID: <20170523172908.GB115919@google.com>
References: <20170518232134.163059-1-bmwill@google.com>
 <82cb1f56-4a26-4b27-3c8a-506821847c0e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82cb1f56-4a26-4b27-3c8a-506821847c0e@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/19, Ben Peart wrote:
> Glad to see you tackling this.  This is definitely a step in the
> right direction.
> 
> I realize that it will take a lot of work and that intermediate
> steps may just be pushing it the global state one level higher but
> eventually it would be great to see an entire code path global state
> free!
> 
> I'm personally interested because reducing the reliance on global
> state also helps us in our performance work as it makes it more
> possible to use threading to scale up the performance.

I'm glad that more people than just me are interesting in moving in this
direction.  It's definitely going to take some work and hopefully I can
convince some more people to help achieve this goal :D

> 
> Ben
> 
> On 5/18/2017 7:21 PM, Brandon Williams wrote:
> >When I first started working on the git project I found it very difficult to
> >understand parts of the code base because of the inherently global nature of
> >our code.  It also made working on submodules very difficult.  Since we can
> >only open up a single repository per process, you need to launch a child
> >process in order to process a submodule.  But you also need to be able to
> >communicate other stateful information to the children processes so that the
> >submodules know how best to format their output or match against a
> >pathspec...it ends up feeling like layering on hack after hack.  What I would
> >really like to do, is to have the ability to have a repository object so that I
> >can open a submodule in-process.
> >
> >Before this becomes a reality for all commands, much of the library code would
> >need to be refactored in order to work purely on handles instead of global
> >state.  As it turned out, ls-files is a pretty simple command and doesn't have
> >*too* many dependencies.  The biggest thing that needed to be changed was
> >piping through an index into a couple library routines so that they don't
> >inherently rely on 'the_index'.  A few of these changes I've sent out and can
> >be found at 'origin/bw/pathspec-sans-the-index' and
> >'origin/bw/dir-c-stops-relying-on-the-index' which this series is based on.
> >
> >Patches 1-16 are refactorings to prepare either library code or ls-files itself
> >to be ready to handle passing around an index struct.  Patches 17-22 introduce
> >a repository struct and change a couple of things about how submodule caches
> >work (getting submodule information from .gitmodules).  And Patch 23 converts
> >ls-files to use a repository struct.
> >
> >The most interesting part of the series is from 17-23.  And 1-16 could be taken
> >as is without the rest of the series.
> >
> >This is still very much in a WIP state, though it does pass all tests.  What
> >I'm hoping for here is to get a discussion started about the feasibility of a
> >change like this and hopefully to get the ball rolling.  Is this a direction we
> >want to move in?  Is it worth the pain?
> >
> >Thanks for taking the time to look at this and entertain my insane ideas :)
> >
> >Brandon Williams (23):
> >  convert: convert get_cached_convert_stats_ascii to take an index
> >  convert: convert crlf_to_git to take an index
> >  convert: convert convert_to_git_filter_fd to take an index
> >  convert: convert convert_to_git to take an index
> >  convert: convert renormalize_buffer to take an index
> >  tree: convert read_tree to take an index parameter
> >  ls-files: convert overlay_tree_on_cache to take an index
> >  ls-files: convert write_eolinfo to take an index
> >  ls-files: convert show_killed_files to take an index
> >  ls-files: convert show_other_files to take an index
> >  ls-files: convert show_ru_info to take an index
> >  ls-files: convert ce_excluded to take an index
> >  ls-files: convert prune_cache to take an index
> >  ls-files: convert show_files to take an index
> >  ls-files: factor out debug info into a function
> >  ls-files: factor out tag calculation
> >  repo: introduce new repository object
> >  repo: add index_state to struct repo
> >  repo: add per repo config
> >  submodule-config: refactor to allow for multiple submodule_cache's
> >  repo: add repo_read_gitmodules
> >  submodule: add is_submodule_active
> >  ls-files: use repository object
> >
> > Makefile                               |   1 +
> > apply.c                                |   2 +-
> > builtin/blame.c                        |   2 +-
> > builtin/commit.c                       |   3 +-
> > builtin/ls-files.c                     | 348 ++++++++++++++++-----------------
> > cache.h                                |   4 +-
> > combine-diff.c                         |   2 +-
> > config.c                               |   2 +-
> > convert.c                              |  31 +--
> > convert.h                              |  19 +-
> > diff.c                                 |   6 +-
> > dir.c                                  |   2 +-
> > git.c                                  |   2 +-
> > ll-merge.c                             |   2 +-
> > merge-recursive.c                      |   4 +-
> > repo.c                                 | 112 +++++++++++
> > repo.h                                 |  22 +++
> > sha1_file.c                            |   6 +-
> > submodule-config.c                     |  40 +++-
> > submodule-config.h                     |  10 +
> > submodule.c                            |  51 +++++
> > submodule.h                            |   2 +
> > t/t3007-ls-files-recurse-submodules.sh |  39 ++++
> > tree.c                                 |  28 ++-
> > tree.h                                 |   3 +-
> > 25 files changed, 513 insertions(+), 230 deletions(-)
> > create mode 100644 repo.c
> > create mode 100644 repo.h
> >

-- 
Brandon Williams
