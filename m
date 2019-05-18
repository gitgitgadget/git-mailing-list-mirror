Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECD131F461
	for <e@80x24.org>; Sat, 18 May 2019 01:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfERBuO (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 21:50:14 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]:55297 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfERBuO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 21:50:14 -0400
Received: by mail-wm1-f45.google.com with SMTP id x64so8438761wmb.5
        for <git@vger.kernel.org>; Fri, 17 May 2019 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8YN3ZI7EFzcEgGgxSrEEiQ2WVWGVCrbZREf1lA2FgWM=;
        b=bZOU5qOwDuBuJQDqVFY2Fhqsgkcfr7YTyU51NKDTUrwpotNzOPCZH8KpY9UzotUupC
         /37Qf8TOZOe7RyZqk5YUJ2xyDP7BXWLStbYX3gJ1dG4NS/R04N0Skcf1A+8qq/qL+ZdH
         LOi6cWTN8PCDU3pq4JYxJt8a34y8kSOBrNWvendaPSF8/6fjnpLDGyl0shFYtqTI+n14
         1vQ1SOV2V0YMI5fpOGtoXqcH9hMkOgw5YdLEyU+YRB4rTs5wh3CN2wWD7H5tQerA9O6O
         QRbIk9hOWl1BRPzZrYAg3AA5di1uS77kbxwLUB0AxLfvSNBLT49ovA/OxDw8B4J3eIOn
         yQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8YN3ZI7EFzcEgGgxSrEEiQ2WVWGVCrbZREf1lA2FgWM=;
        b=cgVNa22fBy85hAJbQj0kZN5l/vDdjw8aI9U1Mdu5xh0uj1RvJUA68gPpY9dyTI8uct
         3r3xUp8E5GC81Kvoi4GT8lNuzzlO+fo3tXk7nUx2iFmcihwjqG+VKbwsnqSYoMTRLTm/
         D9Plv2Q0E61bc3sWN8w/tVey31d5/OcAbrf7285t2f31KZKBdL/hg1ucwSSmV/TtK1ka
         whNDW29OLszcDXgrir7FerE2CGAFdDl3FPPfOI9svqUni/gtVmTa+JzMtJ1Vt0omEzy0
         tVW6/0BwTcGSphupMel4TOnihHkAI93IVmragKqXLf+mbj8rYnvA+22yuiBG5hqoSPU2
         oJWg==
X-Gm-Message-State: APjAAAUfNpBwKj07Anm1/nS/yZKp3pdKFC/MhXKkp2KBsNnfmkNItbrs
        GSoTcRSYeMEzdKd4Fl3MPHcw4+nQ
X-Google-Smtp-Source: APXvYqwG2nZ0mtTA19xKXKvaN/zWTOkilGzKvfXFO7uySi1tA1Th0B6Suu+G4PnZK1TM8vCzBF4iPw==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr7778401wmi.53.1558144211870;
        Fri, 17 May 2019 18:50:11 -0700 (PDT)
Received: from szeder.dev (x4d0c2288.dyn.telefonica.de. [77.12.34.136])
        by smtp.gmail.com with ESMTPSA id d17sm4279208wrw.18.2019.05.17.18.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 18:50:11 -0700 (PDT)
Date:   Sat, 18 May 2019 03:50:05 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org
Subject: Re: Revision walking, commit dates, slop
Message-ID: <20190518015005.GA951@szeder.dev>
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 18, 2019 at 09:54:12AM +0900, Mike Hommey wrote:
> There are established corner cases, where in a repo where commit dates
> are not monotonically increasing, revision walking can go horribly
> wrong. This was discussed in the past in e.g.
> https://public-inbox.org/git/20150521061553.GA29269@glandium.org/
> 
> The only (simple) workable way, given the current algorithm, to get an
> accurate view off rev-list is to essentially make slop infinite. This
> works fine, at the expense of runtime.
> 
> Now, ignoring any modification for the above, I'm hitting another corner
> case in some other "weird" history, where I have 500k commits all with
> the same date. With such a commit dag, something as trivial as
> `git rev-list HEAD~..HEAD` goes through all commits from the root commit
> to HEAD, which takes multiple seconds, when the (obvious) output is one
> commit.
> 
> It looks like the only way revision walking stops going through all the
> ancestry is through slop, and slop is essentially made infinite by the
> fact all commits have the same date (because of the date check in
> still_interesting(). By extension, this means the workaound for the
> first corner case above, which is to make slop infinite, essentially
> makes all rev walking go through the entire ancestry of the commits
> given on the command line.
> 
> It feels like some cases of everybody_uninteresting should shorcut slop
> entirely, but considering the only way for slop to decrease at all is
> when everybody_uninteresting returns true, that would seem like a wrong
> assumption. But I'm also not sure what slop helps with in the first
> place (but I don't have a clear view of the broader picture of how the
> entire revision walking works).
> 
> Anyways, a rather easy way to witness this happening is to create a
> dummy repo like:
>   git init foo
>   cd foo
>   for i in $(seq 1 50); do
>     echo $i > a;
>     git add a;
>     git commit -a -m $i;
>   done
> 
> The something as simple as `git rev-list HEAD~..HEAD` will go through
> all 50 commits (assuming the script above created commits in the same
> second, which it did on my machine)
> 
> By the time both HEAD~ and HEAD have been processed, the revision
> walking should have enough information to determine that it doesn't need
> to go further, but still does. Even with something like HEAD~2..HEAD,
> after the first round of processing parents it should be able to see
> there's not going to be any more interesting commits.
> 
> I'm willing to dig into this, but if someone familiar with the
> algorithm could give me some hints as to what I might be missing in the
> big picture, that would be helpful.

All the above is without commit-graph, I presume?  If so, then you
should give it a try, as it might bring immediate help in your
pathological repo.  With 5k commit in the same second (enforced via
'export GIT_COMMITTER_DATE=$(date); for i in {1..5000} ...') I get:

  $ best-of-five -q git rev-list HEAD~..HEAD
  0.069
  $ git commit-graph write --reachableComputing commit graph generation
  numbers: 100% (5000/5000), done.
  $ best-of-five -q git rev-list HEAD~..HEAD
  0.004


