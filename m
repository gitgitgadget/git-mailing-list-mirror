Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EEB51F87F
	for <e@80x24.org>; Sat, 17 Nov 2018 23:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbeKRKCm (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Nov 2018 05:02:42 -0500
Received: from mail-lf1-f52.google.com ([209.85.167.52]:32808 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeKRKCm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Nov 2018 05:02:42 -0500
Received: by mail-lf1-f52.google.com with SMTP id i26so18913852lfc.0
        for <git@vger.kernel.org>; Sat, 17 Nov 2018 15:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sv5g1a5Ita3Jy/XcnpZR8mQgiqhC7K2jbaRsDxovgts=;
        b=FWdOgzFAwAqc2RYVv5B/Si0xfyU76d68ONbkhoeibf05uHzl6k3DXnXf422YbT+6sA
         8oZ0U4BSgoH1cV2h1FeCJykCcFcGko2ZzTiSOVQFPob8Lgv4tuZeGyHNjdUdmtglIfWs
         qAAJgT2I4R7CAK+MZdglkJb3m4wDKRqO6Zm68hNsmwEeEfg4Vc+/Pdrs0JGryWdbGXXo
         js26KTI7lR4cBWPrw68Jih3+irldBLRXco60Ru+HLwOrsn9c5hkyFNVH0rFrv57X6o5e
         QkwTACB2VYeSIPgnH99bAaCBmkJnXpGVENcV6tRTV+qmnNgYkOLGLpe3a10ZglJq/NOv
         18oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sv5g1a5Ita3Jy/XcnpZR8mQgiqhC7K2jbaRsDxovgts=;
        b=mDbGZGPRR9Uixvoex5sauVKnrvhawe/WtlWJbQ6ZVvHNRychXDDy6AO7Q9SNq3ys+r
         8mYY1U804ahMTrCKGzf46kjbesDg2sQoZhyuNPrufriXjQwoyIKtV7zNOmDZeRilzq7l
         bYxe+L07zIi6fu6nxE5KRK032fqrsWBtxqYa4EFhE1uCsGctGqAHwMFcjH2SbeLbj/bb
         XGVEol4K91Ab1uJNcpkI528QeaxFXRg52Ee5c3SSdPbauUoX536+59qzhfyFW2vZfsFu
         FC3tmJAWl1g7synMPaP2reG8yGZaDtt1NHn0F72Unrko+f5FqDr96s5WUKV+EgprLh4L
         a2eQ==
X-Gm-Message-State: AGRZ1gKRoH4VDObnVYoHzS8dPh18QfOl7AeOMLSHDl7UYaBjwQc8QkIu
        nzi/6zFKT6ngPVzHNLFjLqlNCkmGtJ0W0dNkWgj8ig==
X-Google-Smtp-Source: AJdET5f/zJ/xWkJ78zEgh78ooOT8zz9WFDLzgPqHq4R8SBErMcGnCLhnxIL2mtCX+kghh3b44AklJ1/IhLD2icmOHr0=
X-Received: by 2002:a19:9904:: with SMTP id b4mr7787204lfe.95.1542498255606;
 Sat, 17 Nov 2018 15:44:15 -0800 (PST)
MIME-Version: 1.0
References: <20181115005546.212538-1-sxenos@google.com> <09ae3330-b6ba-3c42-7183-a40fe7aaf816@gmail.com>
In-Reply-To: <09ae3330-b6ba-3c42-7183-a40fe7aaf816@gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Sat, 17 Nov 2018 15:44:04 -0800
Message-ID: <CAPL8ZisATLjfYjjaJFkbSKLYwLQYpzmoVxVbEMaBPS0hn2=tAA@mail.gmail.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Resending this without HTML enabled... sorry if you receive it twice.

> The file name and the title are in a mismatch.

Good point. However, the focus of this proposal really is supposed to
be on the underlying data structure, not just the evolve command
(which is the driving use-case for the graph but not the only
important one). I think I'll fix the mismatch by renaming both the
title and document to "change graph" if that seems acceptable. I'll
also expand the "objective" paragraph to mention the evolve command.

> Perhaps"three sequential patches"?

I've added a quick informal definition of the word "change", along
with a cross-reference to the precise definition later in the
document.

> These two paragraphs could be moved lower, under a "Semi-Related Work"

Good point. I'll keep the patch queue managers here since they really
can be used to solve the same problem that evolve addresses, but I'll
move replacements paragraph down to a new section on semi-related
work. There was also a request to discuss git-imerge which I'll insert
there.

> Instead, I would try to use the term "patch" to describe a change to the codebase

I know you didn't finish the document but later on I define the term
"change" to have essentially this meaning. I've moved the definition
earlier in the document to make the earlier sections easier to
understand. Given the choice of the word "patch" or "change" for this
definition, I prefer to use "change" since gerrit already defines it
in this way and the word "patch" already has a meaning in git (a file
containing a diff).

> Making a note so I come back to this. I hope to learn what you mean by this "more specific merge base".)

Lets say we have commits:

P <- C

Then two people amend C in different ways producing:

P <- C
P <- C1
P <- C2

...then we try to resolve the divergence by merging C1 and C2. Without
the change graph, the closest merge-base (ancestor) would be P. With
the change graph, the closest merge base would be C.

> If we GC'd commit A but still have the newer A', I can either thinkthat

I'm not sure I followed that. Are you suggesting a change to the
proposal or asking for a clarification?

On Fri, Nov 16, 2018 at 1:36 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 11/14/2018 7:55 PM, sxenos@google.com wrote:
> > From: Stefan Xenos <sxenos@google.com>
> >
> > This document describes what an obsolescence graph for
> > git would look like, the behavior of the evolve command,
> > and the changes planned for other commands.
>
> Thanks for putting this together!
>
> > diff --git a/Documentation/technical/evolve.txt b/Documentation/technical/evolve.txt
> ...
> > +Git Obsolescence Graph
> > +======================
> > +
> > +Objective
> > +---------
> > +Track the edits to a commit over time in an obsolescence graph.
>
> The file name and the title are in a mismatch.
>
> I'd prefer if the title was "Git Evolve Design Document" and this
> opening paragraph
> was about the reasons we want a 'git evolve' command. Here is my attempt:
>
>    The proposed 'git evolve' command will help users craft a
> high-quality commit
>    history in their topic branches. By working to improve commits one at
> a time,
>    then running 'git evolve', users can rewrite recent history with more
> options
>    than interactive rebase. The core benefit is that users can pause
> their progress
>    and move to other branches before returning to where they left off.
> Users can
>    also share progress with others using standard 'push', 'fetch', and
> 'format-patch'
>    commands.
>
> > +Background
> > +----------
>
> Perhaps you can call this "Example"?
>
> > +Imagine you have three dependent changes up for review and you receive feedback
> > +that requires editing all three changes. While you're editing one, more feedback
> > +arrives on one of the others. What do you do?
>
> "three dependent changes" sounds a bit vague enough to me to possibly
> confuse readers. Perhaps
> "three sequential patches"?
>
> > +- Users can view the history of a commit directly (the sequence of amends and
> > +  rebases it has undergone, orthogonal to the history of the branch it is on).
>
> "the history of a commit" doesn't semantically work, as a commit is an
> immutable Git object.
>
> Instead, I would try to use the term "patch" to describe a change to the
> codebase, and that
> takes the form as a list of commits that are improving on each other
> (but don't actually
> have each other in their commit history). This means that the lifetime
> of a patch is described
> by the commits that are amended or rebased.
>
> > +- By pushing and pulling the obsolescence graph, users can collaborate more
> > +  easily on changes-in-progress. This is better than pushing and pulling the
> > +  changes themselves since the obsolescence graph can be used to locate a more
> > +  specific merge base, allowing for better merges between different versions of
> > +  the same change.
>
> (Making a note so I come back to this. I hope to learn what you mean by
> this "more specific
> merge base".)
>
> > +
> > +Similar technologies
> > +--------------------
> > ... It can't handle the case where you have
> > +multiple changes sharing the same parent when that parent needs to be rebased
>
> Perhaps this could be made more concrete by describing commit history
> and a specific workflow
> change using 'git evolve'.
>
> Suppose we have two topic branches, topic1 and topic2, that point to
> commits A and B,
> respectively.Suppose further that A and B have a common parent C with
> parent D. If we rebase
> topic1 relativeto D, then we create new commits C' and A' that are newer
> versions of commits
> C and A. It would benice to easily update topic2 to be on a new commit
> B' with parent C'.
> Currently, a user needs to knowthat C updated to C', and use 'git rebase
> --onto C' C topic2'.
> Instead, if we have a marker showing thatC' is an updated version of C,
> 'git log topic2'
> would show that topic2 can be updated, and the 'gitevolve' command would
> perform the correct
> action to make B' with parent C'.
>
> (This paragraph above is an example of "what can happen now is
> complicated and demands that
> the user keep some information in their memory" and "the new workflow is
> simpler and helps
> users make the right decision". I think we could use more of these at
> the start to sell the
> idea.)
>
>
> > +and won't let you collaborate with others on resolving a complicated interactive
> > +rebase.
>
> In the same sentence, we have an even more complicated workflow
> mentioned as an aside. This
> could be fleshed out more concretely. It could help describing that the
> current model is for
> usersto share "!fixup" commits and then one performs an interactive
> rebase to apply those
> fixups inthe correct order. If a user instead shares an amended commit,
> then we are in a
> difficult state toapply those changes. The new workflow would be to
> share amended commits
> and 'git evolve'inserts the correct amended commits in the right order.
>
> I'm a big proponent of the teaching philosophy of "examples first". It's
> easier to talk
> abstractlyafter going through some concrete examples.
>
> >   You can think of rebase -i as a top-down approach and the evolve command
> > +as the bottom-up approach to the same problem.
>
> This comparison is important. Perhaps it is more specific to say
> "interactive rebase splits
> a plan torewrite history into independent units of work, while evolve
> collects independent
> units of workinto a plan to rewrite history."
>
> > +
> > +Several patch queue managers have been built on top of git...
> > +
> > +Replacements (refs/replace) are superficially...
>
> These two paragraphs could be moved lower, under a "Semi-Related Work"
> section,
> because they describe things that are a bit similar, but are unable to
> help us solve the
> problem at hand.
>
> > +
> > +Goals
> > +-----
> > +Legend: Goals marked with P0 are required. Goals marked with Pn should be
> > +attempted unless they interfere with goals marked with Pn-1.
>
> I like the prioritization here.
>
> > +P0. Any commit that may be involved in a future evolve command should not be
> > +    garbage collected.
>
> I wonder about the priority here. If we GC'd commit A but still have the
> newer A', I can
> either thinkthat
>
> 1. We will no longer need to run 'git evolve', or
> 2. We run 'git evolve' on something that can reach A', but A' already
> contains all the
>     informationwe need to produce a "final" commit A''.
>
> I apologize that I'm not able to read the whole thing right now, and I
> will pick up reading
> from here again soon. Hopefully the feedback above is constructive in
> the mean time.
>
> Thanks,
> -Stolee
