Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 963B41F453
	for <e@80x24.org>; Tue,  2 Oct 2018 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbeJBIhI (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 04:37:08 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41022 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeJBIhI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 04:37:08 -0400
Received: by mail-io1-f65.google.com with SMTP id q4-v6so445437iob.8
        for <git@vger.kernel.org>; Mon, 01 Oct 2018 18:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Jugo3sbTug0lnmA+AHygA6pBHd4J4BbXGWBfb3TeeU=;
        b=yRAFQaQxV5E9JwUR5RNzfMgM8fidW98zrtrs6DETdatQyI7CVTq+BOSh6HxyhXcjly
         br3yd8zxVSMPbqKWzNi1CXDVOHgFqAEuLdgw3WoVkJQU06HhLggqT8UbMeZMMRFCTMNp
         EhEHMoVPNf0pAN9g7EOk7rXSA6+lWQ3goo2CUTo+RnjOtaiAj1Y5sp9r6oARhI/WoREY
         R4PJBTd60Pr5WQQPGQMzpvYc1P3VxHYSpRiozL4It7Z8V0aCoHRhXr1ptJNQRLGXfK0w
         rNYxQml6+IYR8+4cVlXZMZmyVOfJph8aslnmZ8YZCnzi35H59kqVmz/Ts9FraAtHPSZd
         grig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Jugo3sbTug0lnmA+AHygA6pBHd4J4BbXGWBfb3TeeU=;
        b=XGhU86Rg3ypvGsofK048kR5s99MauiAl5ghE5jAVhAPQoPq3W1NbEgjB/WJw2YtHEM
         KtQ+s+6cMsE2sf8S4KMOmubJjcvlhoiv0UmgVYcCa9XJEjT8D2bv8Dm5EUMvFyG6f3an
         e3D8Mhy+Wm6pw3KgWHHctxhsjoT4gsR/EmOuUxq1ORGuXEfxrXFPkk9NqbkfklUZ8LSm
         V0jxsNZlbHwkKttv2rQgWsGZjO+mMo3m1bGQmYRrOWd/BEBx4Z8ZHn1JgfJLGLU5/9d5
         wOP76eVCxpAux+sMJftNODgYvngAUr7xTFpU+2W7Z1iUCMzoALG9cAR+DBbdbVIbPwE0
         OeXA==
X-Gm-Message-State: ABuFfohfhgLFfhQ5LfndkXH0WY3JfOG6nlpBbfyaoH0f7yt1cItwU/w8
        FNZPRLpeLsa1d0W2b/Oay+yviQVAjbTykw==
X-Google-Smtp-Source: ACcGV61LxgsNdt4jgB1+vlktWrzeYDdd9u395i+k/DqYFttyPps+sh6vm+AcmhTIVH/frNH35R6nag==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr14437275plb.297.1538445381164;
        Mon, 01 Oct 2018 18:56:21 -0700 (PDT)
Received: from localhost ([2601:602:9200:32b0:e958:2ad1:68d0:890f])
        by smtp.gmail.com with ESMTPSA id k185-v6sm23832002pfc.160.2018.10.01.18.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 18:56:19 -0700 (PDT)
Date:   Mon, 1 Oct 2018 18:56:19 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        gitster@pobox.com, sunshine@sunshineco.com, sbeller@google.com
Subject: Re: [PATCH v3 3/4] transport.c: introduce core.alternateRefsCommand
Message-ID: <20181002015619.GE96979@syl>
References: <cover.1537466087.git.me@ttaylorr.com>
 <cover.1538108385.git.me@ttaylorr.com>
 <2dbcd5419073f06def007be3746ce90fffaf6a6d.1538108385.git.me@ttaylorr.com>
 <20180928052613.GC25850@sigill.intra.peff.net>
 <20180928220410.GA45367@syl>
 <20180929073138.GB2174@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929073138.GB2174@sigill.intra.peff.net>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 29, 2018 at 03:31:38AM -0400, Jeff King wrote:
> On Fri, Sep 28, 2018 at 03:04:10PM -0700, Taylor Blau wrote:
>
> > > Well, you also need to pass the path so it knows which repo to look at.
> > > Which I think is the primary reason we do it, but behaving differently
> > > for each alternate is another option.
> >
> > Yeah. I think that the clearer argument is yours, so I'll amend my copy.
> > I am thinking of:
> >
> >   To find the alternate, pass its absolute path as the first argument.
> >
> > How does that sound?
>
> Sounds good.
>
> > > > +heads, configure `core.alternateRefsCommand` to the path of a script which runs
> > > > +`git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads`.
> > >
> > > Does that script actually work? Because of the way we invoke shell
> > > commands with arguments, I think we'd end up with:
> > >
> > >   git --git-dir="$1" for-each-ref --format='%(objectname)' refs/heads "$@"
> > [...]
> > ...but this was what I was trying to get across with saying "...to the
> > path of a script which runs...", such that we would get the implicit
> > scoping that you make explicit in your example with "f() { ... }; f".
> >
> > Does that seem OK as-is after the additional context? I think that after
> > reading your response, it seems to be confusing, so perhaps it should be
> > changed...
>
> Ah, OK. I totally missed that "path of a script" part. What you have is
> correct, then, but I do wonder if we could make it less subtle.
>
> Maybe something like:
>
>   For example, if `/path/to/script` runs `git --git-dir="$1"
>   for-each-ref --format='%(objectname)' refs/heads/`, then putting
>   `/path/to/script` in `core.alternateRefsCommand` will show only the
>   branch heads from the alternate.
>
> I dunno. It's certainly clunkier. I wonder if we would be less awkward
> to show the sample script in a fenced block, with the `#!/bin/sh` and
> everything.
>
> Or maybe just keep the text you have and add a note at the end like:
>
>   Note that writing that `for-each-ref` command directly in the config
>   option doesn't quite work, as it has to handle the path argument
>   specially.
>
> I don't think we need to hand-hold a user through the f() shell-snippet
> trickery. I just don't want somebody thinking they can blindly paste
> that into their config.

Yeah, I agree with your later suggestion, and I'm glad that we're on the
same page. I certianly don't think that we need to do an extra amount of
hand holding through the 'f() { ... }; f' pattern, but I added an extra
bit to say that 'git for-each-ref' by itself doesn't work, since you
have to handle the path argument.

> > > The other alternative is to pass $GIT_DIR in the environment on behalf
> > > of the program. Then writing:
> > >
> > >   git for-each-ref --format='%(objectname)' refs/heads
> > >
> > > would Just Work. But it's a bit subtle, since it is not immediately
> > > obvious that the command is meant to run in a different repository.
> >
> > I think that we discussed this approach a bit off-list, and I had the
> > idea that it was too fragile to work in practice, and that it would be
> > too surprising for callers to suddenly be in a different world.
> >
> > I say this not because it wouldn't make this particular scenario more
> > convenient, which it uncountably would, but because it would make other
> > scenarios _more_ complicated.
> >
> > For example, if a caller uses an alternate reference backed, perhaps,
> > MySQL (or anything that _isn't_ Git), they're not going to want to have
> > these GIT_ environment variable set.
>
> If they're not using Git under the hood, then GIT_* probably isn't
> hurting anything. But it is still pretty subtle. Let's forget I
> mentioned it.  Just chaining for-each-ref with a prefix is pretty
> awkward, but that's why we have the next patch with
> alternateRefsPrefixes.
>
> Your response did make me think of one other thing, though. The
> alternate file points to a directory with objects, and the
> for_each_alternate_ref() code checks to see if that looks vaguely like
> the objects/ directory of a git repo. But would anybody want to run
> something like alternateRefsCommand on _just_ the object directory?
> I.e., you don't have a real git repo there, but your script can
> "somehow" come up with a list of valid tips.
>
> That isn't inconceivable to me for the kind of multi-fork storage we do
> at GitHub. E.g., imagine a shared object directory with no refs, and
> then a script that goes out to the other related forks to look at their
> ref tips. I don't think we have any immediate plans for it, though (and
> there are a lot of subtle bits that I won't go into here that make it
> non-trivial). So I'm OK to punt on it for now. I also think in a pinch
> that you could easily fool the alternates code by just having a dummy
> "refs/" directory.

I'm not opposed to the idea in general, and I think that it's a good
one, but I am opposed to it in this series. I think that the series
as-is is concise, and unlocks a path towards implementing this feature
at GitHub, and for other users, too.

Certainly we can invent more complicated examples, and I think that many
of them (yours included) are worth building the extra support for. But
in this initial version, I think that we'd be fine to leave it off.

> > > > diff --git a/t/t5410-receive-pack.sh b/t/t5410-receive-pack.sh
> > [...]
> > > > +test_description='git receive-pack test'
> > >
> > > The name of this test file and the description are pretty vague. Can we
> > > say something like "test handling of receive-pack with alternate-refs
> > > config"?
> >
> > I left it intentionally vague, since I'd like for it to contain more
> > tests about 'git receive-pack'-specific things in the future.
> >
> > I'm happy to change the name, though I wonder if we should change the
> > filename accordingly, and if so, to what.
>
> I think we'd want to have a separate script for other receive-pack tests
> that aren't related to alternates. There's some startup overhead to each
> script so we don't want to make them _too_ small, but there are benefits
> to having small test scripts:
>
>  - they're our unit of parallelism, so we want to be able to keep a
>    reasonable number of processors full
>
>  - each test script starts with a clean slate, so there's less chance
>    for unexpected interactions between individual tests (e.g., when
>    modifying or adding a test in the middle of the script)
>
>  - it's less annoying when you're debugging a failing test near the end
>    of a script ;)

All good points, so I'm convinced ;-).

> I actually think we'd benefit from splitting up a few of the longer
> scripts. On my quad-core laptop, running the tests in slow-to-fast order
> keeps the processors pretty busy, and the slowest test takes less time
> than the whole suite. But I've also tried running on a 40-core box. It
> burns through the short tests quickly, but you can never get faster than
> the slowest single test, which takes something like 35 seconds. So
> instead of being 10 times faster, it's more like two times faster, as
> most of the processors idle waiting for that one script to finish.
>
> But that's all pretty tangential here. My point is just that this
> probably ought to be remain its own script. :)
>
> I'd probably name it "t5410-receive-pack-alternates" or similar.

Sounds good, I'll do that and update the name of the test to be
'receive-pack with alternate ref filtering'.

> > I'll wait until Monday to re-roll, just to make sure that there isn't
> > any new feedback between now and then.
>
> Sounds good. Thanks for working on this.

It's been my pleasure. Thanks for all of your help.

Thanks,
Taylor
