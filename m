Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CB7209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 18:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751499AbdFFSKd (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 14:10:33 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36420 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbdFFSKc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 14:10:32 -0400
Received: by mail-pf0-f175.google.com with SMTP id x63so2485509pff.3
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 11:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WMAHL40Q1jNK4RmAypx3PWexwcuvrpjXF5jlzWJ30/E=;
        b=hePqfKyhTJxBOS0xTeyd+WKa2/iaTLiUvFVWBqQDL150xrhDz/+2iVysqF4MHssDr0
         CLPcmDVOnTa56tvKSfJ+HbgkDwTrSYuced7dusQOvymHzMktxswK+aJ0832qzZ/fsbPM
         ysuQMMxivjKZfa1k36XO5LDneYrvnoUIZOOqAi5vozQiIddlDErddHVahMEpq64qqcVP
         Cn58mLMMb2JyRFKHVtEKpytxKdTTC2YVARN9+H9cSa0M9gPvwGY9YKh+uZFyENyFH5aG
         JS+ym/PG72ZaeUv1Q8DmBEF0VRqX2bQzwg9bH88opdxgcNtbCBuhunilzBvoSWXSBxOn
         +MBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WMAHL40Q1jNK4RmAypx3PWexwcuvrpjXF5jlzWJ30/E=;
        b=M/7ckdTZioLYOP4XywOIKrbSzeoV1rPSFwNHD4W25FOV3oMuqmQUHtqu1vL49egRQ1
         NrJkbnRQ6LD7f/KKOsEsXBxGalVMWeIosyw0ZQjva+mBQI+H/FTd5ZeeA668116aDbWl
         qjtetyHFkRo9EjR3v2oLuQKQrkniySvrydDIcJLXE0GFmhdicsH9SXtrZkuW3ThvJFdH
         oVwPZNqVU9wFpPbQJvpO6nh3wOaY4LVKIgbMuTr9R6eRiuYhxwF3QVdVA9Brkh333Xdj
         eBO6vEP5TudxweGoHHqU8u9lxwB/VdtCJEmBwZ8TrrFaJLur1jTl73/0uNiEP68B7iRm
         Gxvg==
X-Gm-Message-State: AODbwcAgrGPvyVQwdHv2PhJLucjweH4z5417GWx37T+jXO2RiL4RwOZK
        loCH4hvyjx0uSkhx1KTqBw==
X-Received: by 10.99.114.11 with SMTP id n11mr27915936pgc.4.1496772626882;
        Tue, 06 Jun 2017 11:10:26 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:49a3:5a61:7d4:67b5])
        by smtp.gmail.com with ESMTPSA id m81sm7239805pfj.121.2017.06.06.11.10.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 11:10:25 -0700 (PDT)
Date:   Tue, 6 Jun 2017 11:10:24 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG?] gitlink without .gitmodules no longer fails recursive
 clone
Message-ID: <20170606181024.GA189073@google.com>
References: <20170606035650.oykbz2uc4xkr3cr2@sigill.intra.peff.net>
 <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kY-uzardfOvrJufatYgU9bqx4XZMU_GFq5zwc-vtzM-3Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/06, Stefan Beller wrote:
> On Mon, Jun 5, 2017 at 8:56 PM, Jeff King <peff@peff.net> wrote:
> > While running some regression tests with v2.13, I noticed an odd
> > behavior. If I create a repository where there's a gitlink with no
> > matching .gitmodules entry:
> >
> >   git init repo
> >   cd repo
> >   n10=1234abcdef
> >   n40=$n10$n10$n10$n10
> >   git update-index --add --cacheinfo 160000 $n40 foo
> >   git commit -m "gitlink without .gitmodule entry"
> >
> > and then I clone it recursively with v2.12, it fails:
> >
> >   $ git.v2.12.3 clone --recurse-submodules . dst; echo exit=$?
> >   Cloning into 'dst'...
> >   done.
> >   fatal: No url found for submodule path 'foo' in .gitmodules
> >   exit=128
> >
> > But with v2.13, it silently ignores the submodule:
> >
> >   $ git.v2.13.1 clone --recurse-submodules . dst; echo exit=$?
> >   Cloning into 'dst'...
> >   done.
> >   exit=0
> >
> > This bisects to your bb62e0a99 (clone: teach --recurse-submodules to
> > optionally take a pathspec, 2017-03-17). That patch just sets
> > submodule.active by default, so I think the real issue is probably in
> > a086f921a (submodule: decouple url and submodule interest, 2017-03-17).
> 
> It's a feature, not a bug, IMO.
> 
> When starting out the journey to improve submodules, one of the major
> principle was to not interfere with gitlinks too much, as they are used in
> ways git cannot fathom (cf git-series storing patches in gitlink form).
> 
> And building on that: You asked for recursing into *submodules*, not
> into *gitlinks*. And submodules in the new Git have stronger requirements
> w.r.t. the gitmodules file. (You have to tell us exactly how you want your
> submodule to be treated, and we do not want to half-ass guess around
> the shortcomings of a user not telling us about the submodule)

Just for some background on the new behavior and how this functionality
changed: My series changed how 'submodule init' behaved if you have
'submodule.active' set.  Once set (like how clone --recurse does now)
when not provided any path to a submodule, a list of 'active' submodules
matching the 'submodule.active' pathspec will be initialized.  One of
the requirements to be 'active' is to have an entry in the .gitmodules
file so gitlinks without an entry in the .gitmodules file will simply be
ignored now.

> 
> > I also wasn't sure if this might be intentional. I.e., that we'd just
> > consider gitlink entries which aren't even configured as not-submodules
> > and ignore them.
> 
> I think this is what we want to do, and we should do it consistently.
> The only downside for this is that more unintentional gitlinks may be
> added to repositories as Git will be very good at ignoring them.
> 
> > I couldn't certainly see an argument for moving in that
> > direction, but it is different than what we used to do. But I couldn't
> > find anything in any of the commit messages that mentioned this either
> > way, so I figured I'd punt and ask. :)
> 
> Yeah, yesterday we had a big discussion if we want to publish our
> roadmap and long term vision (as a team, as a company, or as a
> community?) This would help newcomers and outsiders to see where
> e.g. submodules are headed and people could speak up early if we miss
> their use case.
> 
> Thanks for asking,
> Stefan
> 
> >
> > -Peff

-- 
Brandon Williams
