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
	by dcvr.yhbt.net (Postfix) with ESMTP id A9F901F461
	for <e@80x24.org>; Sat, 18 May 2019 12:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbfERMBq (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 May 2019 08:01:46 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:45140 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbfERMBq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 May 2019 08:01:46 -0400
Received: by mail-wr1-f50.google.com with SMTP id b18so9652793wrq.12
        for <git@vger.kernel.org>; Sat, 18 May 2019 05:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=VRQAoQ49LCx9mjXjzOiaANLgrN9u1e3SB0y7ob6uqfw=;
        b=ZzrZCI91gu8Qjb/q1Jd79ad08h7oLOXviAdRAefdj9355LAsdG9tKJiwhIiGKj65qp
         SFbTkq8XcqUY9t/kkE+19TUXywVH31MwB2J/7daTxmVDYLpVm4aFLVj4f/IljZWaTVPa
         MTfuBTLI75ZB1m+tgCkQN7GNwPoTyDnmbcsDS+r64GEc6ZCvRGxLJKJA3GYOoB5n0F3N
         twOErHi497qiSfnnGa8QAz3OEmnhJxhmGI3Rp0S8UeAeJqUwWUNrXVa/kQ8ah1IqHaSD
         JpyEAkF9YGYcCVxj5ouhJ14qjmh1cuyA4wq6NazKQzIr718q1ZD4HmgVLh9vTmgEkDWD
         0KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=VRQAoQ49LCx9mjXjzOiaANLgrN9u1e3SB0y7ob6uqfw=;
        b=tpQHenCYmEbIpdY5eBP9EOZz1vwMqSPofOX1TnNxZ3aJhQ+BD+MRDBteBFsVVFYOxs
         eB+KB1vyJLqae7CS/4HfGS/b2ISyRKm9i9IY87EXhdrGU0EFIsTxMg/lnt2EfK5azPGV
         WzrwNKfYFdhkfUaxNL15LjlurgSwxfZSKFrR+z9mpSUvTsSohkQVPvJmx301iA3BkavQ
         jfQ8VvWa7IuWtbZ6JDdayaYwyJ8doTTD6yQDPUpcYK063mH13CI0ANBBR4OzeSZ0MDbW
         xNBbb8mNmthP5DkW3+1YeKaxbDBQtqqz4laWG+37Qx16GMmY+ld8Sl7/IypzKnltvyFx
         wnsg==
X-Gm-Message-State: APjAAAU5HDAOWlpONOOQj1F0BS/9HedRLGsGymO2YxANiLfE0UEeTL5O
        I3lgZm7NdDEpOY0r762r4ycJCd6F
X-Google-Smtp-Source: APXvYqyvSp9k1/H+eWa6I4fLd5I0TNwN7cYVInqcKukv7J3ngsGYj0EtaGXaVLXybhxHRs+1Z0wujA==
X-Received: by 2002:adf:e850:: with SMTP id d16mr23688347wrn.269.1558180903556;
        Sat, 18 May 2019 05:01:43 -0700 (PDT)
Received: from szeder.dev (x4db5503e.dyn.telefonica.de. [77.181.80.62])
        by smtp.gmail.com with ESMTPSA id i185sm20990315wmg.32.2019.05.18.05.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 05:01:42 -0700 (PDT)
Date:   Sat, 18 May 2019 14:01:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, Kacper Kornet <draenog@pld-linux.org>
Subject: Re: Revision walking, commit dates, slop
Message-ID: <20190518120140.GB951@szeder.dev>
References: <20190518005412.n45pj5p2rrtm2bfj@glandium.org>
 <20190518015005.GA951@szeder.dev>
 <20190518035828.pjaqfrkkvldhri6v@glandium.org>
 <20190518041706.ct6ie5trvxgdhjar@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190518041706.ct6ie5trvxgdhjar@glandium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 18, 2019 at 01:17:06PM +0900, Mike Hommey wrote:
> On Sat, May 18, 2019 at 12:58:28PM +0900, Mike Hommey wrote:
> > On Sat, May 18, 2019 at 03:50:05AM +0200, SZEDER Gábor wrote:
> > > On Sat, May 18, 2019 at 09:54:12AM +0900, Mike Hommey wrote:
> > > > There are established corner cases, where in a repo where commit dates
> > > > are not monotonically increasing, revision walking can go horribly
> > > > wrong. This was discussed in the past in e.g.
> > > > https://public-inbox.org/git/20150521061553.GA29269@glandium.org/
> > > > 
> > > > The only (simple) workable way, given the current algorithm, to get an
> > > > accurate view off rev-list is to essentially make slop infinite. This
> > > > works fine, at the expense of runtime.
> > > > 
> > > > Now, ignoring any modification for the above, I'm hitting another corner
> > > > case in some other "weird" history, where I have 500k commits all with
> > > > the same date. With such a commit dag, something as trivial as
> > > > `git rev-list HEAD~..HEAD` goes through all commits from the root commit
> > > > to HEAD, which takes multiple seconds, when the (obvious) output is one
> > > > commit.
> > > > 
> > > > It looks like the only way revision walking stops going through all the
> > > > ancestry is through slop, and slop is essentially made infinite by the
> > > > fact all commits have the same date (because of the date check in
> > > > still_interesting(). By extension, this means the workaound for the
> > > > first corner case above, which is to make slop infinite, essentially
> > > > makes all rev walking go through the entire ancestry of the commits
> > > > given on the command line.
> > > > 
> > > > It feels like some cases of everybody_uninteresting should shorcut slop
> > > > entirely, but considering the only way for slop to decrease at all is
> > > > when everybody_uninteresting returns true, that would seem like a wrong
> > > > assumption. But I'm also not sure what slop helps with in the first
> > > > place (but I don't have a clear view of the broader picture of how the
> > > > entire revision walking works).
> > > > 
> > > > Anyways, a rather easy way to witness this happening is to create a
> > > > dummy repo like:
> > > >   git init foo
> > > >   cd foo
> > > >   for i in $(seq 1 50); do
> > > >     echo $i > a;
> > > >     git add a;
> > > >     git commit -a -m $i;
> > > >   done
> > > > 
> > > > The something as simple as `git rev-list HEAD~..HEAD` will go through
> > > > all 50 commits (assuming the script above created commits in the same
> > > > second, which it did on my machine)
> > > > 
> > > > By the time both HEAD~ and HEAD have been processed, the revision
> > > > walking should have enough information to determine that it doesn't need
> > > > to go further, but still does. Even with something like HEAD~2..HEAD,
> > > > after the first round of processing parents it should be able to see
> > > > there's not going to be any more interesting commits.
> > > > 
> > > > I'm willing to dig into this, but if someone familiar with the
> > > > algorithm could give me some hints as to what I might be missing in the
> > > > big picture, that would be helpful.
> > > 
> > > All the above is without commit-graph, I presume?  If so, then you
> > > should give it a try, as it might bring immediate help in your
> > > pathological repo.  With 5k commit in the same second (enforced via
> > > 'export GIT_COMMITTER_DATE=$(date); for i in {1..5000} ...') I get:
> > > 
> > >   $ best-of-five -q git rev-list HEAD~..HEAD
> > >   0.069
> > >   $ git commit-graph write --reachableComputing commit graph generation
> > >   numbers: 100% (5000/5000), done.
> > >   $ best-of-five -q git rev-list HEAD~..HEAD
> > >   0.004
> > 
> > I'm not observing any difference from using commit-graph, whether in
> > time or in the number of commits that are looked at in limit_list().
> 
> -c core.commitGraph=true does make a difference in time, but not in the
> number of commits looked at in limit_list(). So it's only faster because
> each iteration of the loop is faster. It means it's still dependent on
> the depth of the dag, and the larger the repo will grow, the slower it
> will get.

Oh, indeed.  Well, at least you'll waste about an order of magnitude
less processor time until you figure out how to fix it :)

Btw, once upon a time this was fast, but it became slow with commit
c19d1b4e84 (Fix revision walk for commits with the same dates,
2013-03-22).


