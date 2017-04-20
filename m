Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 94171207BD
	for <e@80x24.org>; Thu, 20 Apr 2017 22:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S947939AbdDTWZQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 18:25:16 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:32995 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S946276AbdDTWZO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 18:25:14 -0400
Received: by mail-io0-f171.google.com with SMTP id k87so89992333ioi.0
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 15:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aNm07ww3slfaQ6+9B5i1iwPqj9Hydq76zDN7MO+37Fk=;
        b=cuISH3F83agFGtEnyvRk5BWGdgwwt7mTH1wU0XXdnTd1QkGyI2LfdbtCqLnNOaENWc
         saTOlutY3bgW45MKpN63pSvhACWtKFfiZQpNc3yKVgfBS6RF83pxJJGdR9P/8mbJ4u5B
         fWgHdtX8271m52HsnvsaK40xoQ5SFBXX46N8hecrSgAT6lkC4KBX/7jP9+3RQ+aCz8X+
         Xv4EWtTc2agdxX2V1D9uuh89WgOIRse6HjB6I373Xssr9SS8Wyi1lUP/rEg3NJUY/6OX
         tqcjPxv4vumWDTIt657oOWhRyC2NofHhFzWi/bF45tUkuhOC8K2A+u89JibchZR3gqat
         9aBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aNm07ww3slfaQ6+9B5i1iwPqj9Hydq76zDN7MO+37Fk=;
        b=ssAyaTKlG/t6TfMPJ9K4mwNdsYVEcGvHGm/IoUzZsXxZMt47tX4t6XRPlpjxu/a/hX
         ra7VqI2dqqstqBMFFlFpKqubysDjD2v6f5PzgVYwgVD4XOMbyfOSF6nBaj5H7BXCM0ld
         +jcm8sZBrS6l7jCfZjKD9G4LyP/UCgmsN8/Ur5nekRZ3VEHT2fJvs+ISgc6EIGUJjFfg
         p3i+cQb3T/EKIqCqstQ8YxEVGKrmt+eATWiR0ZGIVER/f4k7n6cD7RJAY4X8wdjFVJz2
         Mf+RHZkI2AnDAKIFxT8qTq4ZgkSOfq4IQ8VXgI+UoDuVML5i0PqRRLjOI0LV4YndrsBL
         URbQ==
X-Gm-Message-State: AN3rC/4M41+U7kv0eKcMhHlR5d1zXVhMfKYhPlxRKuz8jPnSEMab2rn+
        3U6j3g4rBQGnqIqr
X-Received: by 10.99.125.82 with SMTP id m18mr9402416pgn.79.1492727112283;
        Thu, 20 Apr 2017 15:25:12 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6c7e:3273:2d37:5651])
        by smtp.gmail.com with ESMTPSA id r18sm12194694pfk.109.2017.04.20.15.25.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Apr 2017 15:25:11 -0700 (PDT)
Date:   Thu, 20 Apr 2017 15:25:10 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Maxime Viargues <maxime.viargues@serato.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] submodule.c: add has_submodules to check if we have
 any submodules
Message-ID: <20170420222510.GL142567@google.com>
References: <20170411194616.4963-1-sbeller@google.com>
 <20170411194616.4963-2-sbeller@google.com>
 <20170420220736.GH142567@google.com>
 <CAGZ79kZeJp3nvjSJGy7P_dojjNbFtx3N11AOkGc-fdKkBOPFUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZeJp3nvjSJGy7P_dojjNbFtx3N11AOkGc-fdKkBOPFUg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/20, Stefan Beller wrote:
> On Thu, Apr 20, 2017 at 3:07 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 04/11, Stefan Beller wrote:
> >> +int has_submodules(unsigned what_to_check)
> >> +{
> >> +     if (what_to_check & SUBMODULE_CHECK_ANY_CONFIG) {
> >> +             if (submodule_config_reading == SUBMODULE_CONFIG_NOT_READ)
> >> +                     load_submodule_config();
> >> +             if (submodule_config_reading == SUBMODULE_CONFIG_EXISTS)
> >> +                     return 1;
> >> +     }
> >> +
> >> +     if ((what_to_check & SUBMODULE_CHECK_ABSORBED_GIT_DIRS) &&
> >> +         file_exists(git_path("modules")))
> >> +             return 1;
> >> +
> >> +     if ((what_to_check & SUBMODULE_CHECK_GITMODULES_IN_WT) &&
> >> +         (!is_bare_repository() && file_exists(".gitmodules")))
> >> +             return 1;
> >> +
> >> +     if (what_to_check & SUBMODULE_CHECK_GITLINKS_IN_TREE) {
> >> +             int i;
> >> +
> >> +             if (read_cache() < 0)
> >> +                     die(_("index file corrupt"));
> >> +
> >> +             for (i = 0; i < active_nr; i++)
> >> +                     if (S_ISGITLINK(active_cache[i]->ce_mode))
> >> +                             return 1;
> >> +     }
> >> +
> >> +     return 0;
> >> +}
> >
> > It may be a good idea to rearrange these by order to correctness.
> 
> I arranged by estimated speed, i.e. from fastest to slowest:
> * The first check just returns a value from memory in the standard case
>   Though the first one may take a hit in performance for the very first time
>   as it may need to load the config.
> * The next two are an actual stat system call, each having a different
>   'defect'. (We may have non-absorbed submodules or non-bare repos)
>   -> We could have a check for in-tree as well, not sure if that is desired.

Fair enough, I'm fine with the ordering then.

> 
> > Correctness may not be the best way to describe it, but which is the
> > strongest indicator that there is a submodule or that a repo 'has a
> > submodule'.
> 
> These indicators differ in strength for different scenarios IMO.
> (Just after clone: check for a .gitmodules file instead of a config;
> later: rather check for a config as it is fastest and actually catches
> active submodules; maybe we do not care about inactive submodules)

This is why I went back on my thinking :)  I realized that it really
depends on the scenario you are in.

> 
> >  That way in the future we could have a #define that is
> > SUBMODULE_CHECK_ANY or ALL or something....Now that I'm thinking harder
> > about that we may not want that, and just require explicitly stating
> > which check you want done.
> >
> > Anyways good looking patch, and I like the idea of consolidating the
> > checks into a single function.
> 
> Thanks,
> Stefan

-- 
Brandon Williams
