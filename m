Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCC431F406
	for <e@80x24.org>; Tue, 26 Dec 2017 01:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750815AbdLZBQp (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Dec 2017 20:16:45 -0500
Received: from mail-it0-f45.google.com ([209.85.214.45]:42900 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbdLZBQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Dec 2017 20:16:44 -0500
Received: by mail-it0-f45.google.com with SMTP id p139so21171311itb.1
        for <git@vger.kernel.org>; Mon, 25 Dec 2017 17:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ecbaldwin.net; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fw6IAzhao3ghizyAG+cWkYqjlmvDK5d0LtEddbdQDPE=;
        b=LU60m9RUH0dYajvfwoIEYMk+VSX7YRR2/t99jlhFXDm49gfTWk3XXr/kt3+xZAjQPK
         yEls7uEHi4+Ncj7VRam0ffU5ZILoSeLTKredNPTggODie4BmESMCEa3kWOw487u4ZxfU
         hYIfiD673mJAUqxq9u5IwWqR/7b11QfNqu3Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fw6IAzhao3ghizyAG+cWkYqjlmvDK5d0LtEddbdQDPE=;
        b=C8ELmQwxORL1bo+V6oBBvD/IAgLDl30jci6RuhN+YsXUY07IcztT2iuCZOmScY1m9h
         vF88py/sJInQbT4bQ6yVevt5e+aJuXER1yn7mkpaN33blkGGdbL0ck2KyT3ANFZgZ7HD
         HG+Dy7Sw4yFkQhg5Vr0OkVdSsqMsEtTJn7lsNELyAAULAXYkn4PNBb2XAsu3+u3xxmP+
         zRLCnOcoC29NSX2AO0qi7b35ukzgZIk+B9/Mf/SvY8GQbsrqvFaYHoilK2OzBNfSkFH8
         VFZlHN88ZZFu6eByrIrnV8Er6pHF9cVlAJwolD2RultgesErzG+sPkpIeS3KD570ufTF
         HIOw==
X-Gm-Message-State: AKGB3mLLAWfCeIaU/Hthdav5n1zdyIqn3xeMX9eiyufHaTSW/WZnEYjD
        QoPYnJjbTZjWO2AocEqyYGcsew==
X-Google-Smtp-Source: ACJfBovNSaHFMsrhWJsEasttYoW+CGs7ZvAAQUhhY86GoP/3K+z0OXXBsGXgDLJVEBQQvsFKFnh6Ww==
X-Received: by 10.36.221.147 with SMTP id t141mr30578588itf.140.1514251003262;
        Mon, 25 Dec 2017 17:16:43 -0800 (PST)
Received: from Carl-MBP.ecbaldwin.net ([2601:282:8001:ffba:86f:967d:39c5:9c84])
        by smtp.gmail.com with ESMTPSA id c8sm8626902itg.15.2017.12.25.17.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Dec 2017 17:16:42 -0800 (PST)
Date:   Mon, 25 Dec 2017 18:16:40 -0700
From:   Carl Baldwin <carl@ecbaldwin.net>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Bring together merge and rebase
Message-ID: <20171226011638.GA16552@Carl-MBP.ecbaldwin.net>
References: <CALiLy7pBvyqA+NjTZHOK9t0AFGYbwqwRVD3sZjUg0ZLx5y1h3A@mail.gmail.com>
 <20171225035215.GC1257@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171225035215.GC1257@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 24, 2017 at 10:52:15PM -0500, Theodore Ts'o wrote:
> As a suggestion, before diving into the technical details of your
> proposal, it might be useful consider the usage scenario you are
> targetting.  Things like "git rebase" and "git merge" and your
> proposed "git replace/replay" are *mechanisms*.
> 
> But how they fit into a particular workflow is much more important
> from a design perspective, and given that there are many different git
> workflows which are used by different projects, and by different
> developers within a particular project.
> 
> For example, rebase gets used in many different ways, and many of the
> debates when people talk about "git rebase" being evil generally
> presuppose a particular workflow that that the advocate has in mind.
> If someone is using git rebase or git commit --amend before git
> commits have ever been pushed out to a public repository, or to anyone
> else, that's a very different case where it has been visible
> elsewhere.  Even the the most strident, "you must never rewrite a
> commit and all history must be preserved" generally don't insist that
> every single edit must be preserved on the theory that "all history is
> valuable".
> 
> > The git history now has two dimensions. The first shows a cleaned up
> > history where fix ups and code review feedback have been rolled into
> > the original changes and changes can possibly be ordered in a nice
> > linear progression that is much easier to understand. The second
> > drills into the history of a change. There is no loss and you don't
> > change history in a way that will cause problems for others who have
> > the older commits.
> 
> If your goal is to preserve the history of the change, one of the
> problems with any git-centric solution is that you generally lose the
> code review feedback and the discussions that are involved with a
> commit.  Just simply preserving the different versions of the commits
> is going to lose a huge amount of the context that makes the history
> valuable.
> 
> So for example, I would claim that if *that* is your goal, a better
> solution is to use Gerrit, so that all of the different versions of
> the commits are preserved along with the line-by-line comments and
> discussions that were part of the code review.  In that model, each
> commit has something like this in the commit trailer:
> 
> Change-Id: I8d89b33683274451bcd6bfbaf75bce98

Thank you for your reply. I agree that discussing the workflows is very
valuable and I certainly haven't done that justice yet.

Gerrit is the tool that got me thinking about my proposal in the first
place. I spent a few years developing and doing a significant number of
code reviews using it. I've since changed to an environment where I no
longer have it. It turns out that "a better solution is to use Gerrit"
is not helpful to me now because it isn't up to me. Gerrit is not nearly
as ubiquitous as git itself.

In my opinion, Gerrit has shown us the power of the "change". As you
point out, it introduced the change-id embedded into the commit message
and uses it to track a change's progress as a "review." I think these
are powerful concepts and Gerrit did a nice job with them. I guess one
of my goals with my proposal here is to formalize the "change" idea so
that any git-based tool understands it and can interoperate. This is why
I want it in the core git commit object and I want push, pull, gc, and
other commands to understand it.

At this point, you might wonder why I'm not proposing to simply add a
"change-id" to the commit object. The short answer is that the
"change-id" Gerrit uses in the commit messages cannot stand on its own.
It depends on data stored on the server which maintains a relationship
of commits to a review number and a linear ordering of commits within
the review (hopefully I'm not over simplifying this). The "replaces"
reference is an attempt to make something which can stand on its own. I
don't think we need to solve the problem of where to keep comments at
this point.

An unbroken chain of "replaces" references obviates the need for the
change id in the commit message. From any given commit in the chain, we
can follow the references to the first commit which started the review.
However, the chain is even more useful because it is not limited to a
linear progression of revisions. Let me try to explain how this can
solve some of the most common issues I ran into with the rebase type
workflow.

Look at what happens in a rebase type workflow in any of the following
scenarios. All of these came up regularly in my time with Gerrit.

    1. Make a quick edit through the web UI then later work on the
       change again in your local clone. It is easy to forget to pull
       down the change made through the UI before starting to work on it
       again. If that happens, the change made through the UI will
       almost certainly be clobbered.

    2. You or someone else creates a second change that is dependent on
       yours and works on it while yours is still evolving. If the
       second change gets rebased with an older copy of the base change
       and then posted back up for review, newer work in the base change
       has just been clobbered.

    3. As a reviewer, you decide the best way to explain how you'd like
       to see something done differently is to make the quick change
       yourself and push it up. If the author fails to fetch what you
       pushed before continuing onto something else, it gets clobbered.

    4. You want to collaborate on a single change with someone else in
       any way and for whatever reason. As soon as that change starts
       hitting multiple work spaces, there are synchronization issues
       that currently take careful manual intervention.

These kinds of scenarios usually end up being used as arguments against
a rebased based workflow. On the other hand, with a chain of "replaces"
references, these scenarios end up branching the change. This is where
it will be useful for my local git command to be able to pull down the
upstream state, understand what branched, help me merge, and then push
the result upstream. I really think this brings the power and benefits
of branching and merging to the rebase workflow.

Anyway, now I am compelled to use github which is also a fine tool and I
appreciate all of the work that has gone into it. About 80% of the time,
I rebase and force push to my branch to update a pull request. I've come
to like the end product of the rebase workflow. However, github doesn't
excel at this approach. For one, it doesn't preserve older revisions
which were already reviewed which makes it is difficult for reviewers to
pick up where they left off the last time. If it preserved them, as
gerrit does, the reviewer can compare a new revision with the most
recent older revision they reviewed to see just what has been addressed
since then.

I think it would be great if git standardized the way that revisions of
"changes" are preserved in the repository as commits. Preserving the
comments attached to each commit could be left up to each of the tools,
in my opinion. Or, at least left to a later discussion.

The other 20% of the time, I revert to branching and merging only. This
helps reviewers with the problem of picking up where they left off. It
is also an absolute necessity if another developer is going to be
collaborating with me on the pr or basing a dependent pr on it. However,
it leaves the history in a more complex state in the end. Github offers
"squash merge" and "rebase merge" to help out with this but these don't
give me the control I want over what goes into each change when I want
to end up with more than one. They also cause problems if there is a
dependent pr.

After a pull request in github has progressed, it can be difficult for a
new reviewer to jump on. They may want to review a large pr commit by
commit from the bottom up instead of trying to tackle the entire thing
at once. However, if fixups have been made in later commits, they will
be looking at the old stuff first, seeing all the bugs and issues that
have already been addressed.

> You can then cut and paste the Change-Id into the Gerrit user
> interface, and see the different commits, more important, the
> discussion surrounding each change.
> 
> 
> If the complaint about Gerrit is that it's not a core part of Git, the
> challenge is (a) how to carry the code review comments in the git
> repository, and (b) do so in a while that it doesn't bloat the core
> repository, since most of the time, you *don't* want or need to keep a
> local copy of all of the code review comments going back since the
> beginning of the project.
> 
> -------------

I need to give your kernel patching use cases some thought. I once
designed a process to do similar patching against a different project so
I think I know what you're getting at. I just need a little more time to
think about it. Hopefully, I'll have a little more time to post another
reply.

Carl
