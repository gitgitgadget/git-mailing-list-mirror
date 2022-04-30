Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4D7C433EF
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 15:51:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiD3PwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 11:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiD3PwC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 11:52:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B3ABD3
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 08:48:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id b24so12171086edu.10
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 08:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWeu4Yr64JrrCn0zU5g0+lFabJaB2mkFdkqQlHc5N7k=;
        b=EcU8FTo7MOSJ2/DReleT6w2zrQ2Bmm9ndJsRiFVsxa43Ay1UmWIlsSlK/SA0T/9C/+
         brBLGVR+U4mltXCaoKlV2XVKm6yw8QaDlcsVOj6lUPq258DJmgGp8KUeguF33JXFpr2k
         TEMNsGtaU6MzENptUqzgW67WaeRVH7bj2O/aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWeu4Yr64JrrCn0zU5g0+lFabJaB2mkFdkqQlHc5N7k=;
        b=dvxSQYWZsidqXS9wzntb87hHhQ/uMudYF+rLDK7u5D82WmQsrm8jg3nYd/EaaneXXJ
         2cuoKSWKr31s/rFWuQQUrBG/dU15mIO3TbyTRdJqCJigx2BlmJFLhwxf/Sk9uvDcqgMP
         CgVQo3LNME6LAFDzPD0/QHqkj7eHNBHsLX0lEtq05JUwKeLZjttuLAeopB6ZlU7FC7nX
         z5fPxC1H3WV3vALDNLVwS1kw3m8uox4FGdooxzRLMPNiNOPyiOsWe7CoXChMWG7dzUDe
         Op8QTv6cvmsrxukGFw+o8IkcvA8y9vtGAN5xEJFXa02GNLV7nFLi9S5Vw7+WGFUtIpzM
         NXYQ==
X-Gm-Message-State: AOAM530aDbDGwvQMuopYg9erbBd3YPqgn0xPGrS8lW+5VSg2WJEn4FAF
        OOLU+FKdjNrBcPGfKEDUzTVuBaednx1YUCPbdvcP6A==
X-Google-Smtp-Source: ABdhPJzovFlPRstIn5dmsmYQreRqdqk0JKEEu4oUp+ujJpQL9oj/A+Lnu8iicxX9bkkXtiFZ0b8mH9oWNnqfrR4qUXA=
X-Received: by 2002:aa7:cd7c:0:b0:425:e59d:7353 with SMTP id
 ca28-20020aa7cd7c000000b00425e59d7353mr4876845edb.365.1651333718340; Sat, 30
 Apr 2022 08:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1161.v4.git.1647843442911.gitgitgadget@gmail.com>
 <pull.1161.v5.git.1651226206.gitgitgadget@gmail.com> <xmqqk0b7bu77.fsf@gitster.g>
In-Reply-To: <xmqqk0b7bu77.fsf@gitster.g>
From:   Tao Klerks <tao@klerks.biz>
Date:   Sat, 30 Apr 2022 17:48:26 +0200
Message-ID: <CAPMMpog9msh-KgXybYXUCunbkzBRyfWKjbSG+L0AHRHGyJZk5A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] New options to support "simple" centralized workflow
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 29, 2022 at 8:50 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> I still do not know offhand if the 'simple' thing makes
> sense without thinking it through,

At the risk of insisting too much, I'd like to break this down into 3 parts:

1) To what extent does a "there is one remote, and local and remote
branches have the same name unless I explicitly choose to do something
different" perspective make sense to a given population of users, and
how large is that population of users?

2) For those users, can and should we have a better UX?

3) To what extent does it make sense to call this mode of working
"simple", what are the best UX changes to make, what should any new
options be called, and how should discoverability be implemented?


1. Audience:

I understand that git was designed as a distributed VCS, and that's a
completely fundamental aspect of its power and success... but the
reality (or "my claim"?) is that the vast majority of users end up
using git with a single remote per repo. I don't know how to
categorically confirm this - I suspect the github/microsoft, google
and other sponsor-type folks here will have more access to research on
the topic. I don't want to imply that git should do less, but just
that the idea of "multiple remotes" is alien to almost every git user
I've ever interacted with. Obviously as I work in a corporate
environment I have a particular perspective... but I find this to be
true of github users also.

Within the context of such "single remote per repo" users, I've spoken
with a dozen users of varying git experience levels to try to
understand whether *any* of them intentionally end up with an
"upstream tracking branch different from the local branch name"
scenario, and what they use it for. I found two users who had ever
done this intentionally: One who had done it once, when faced with a
project with crazy machine-generated branch names, and another who
does it routinely to have nice short local branch names (very much an
advanced user and enthusiast). To the majority it's only ever happened
by accident, and they didn't even understand what was going on. It was
just a weird message they got and eventually worked around.

Amusingly, one was an old hand, and still avoided the default "git
push" because he remembered a time when that pushed all branches, and
did not realize the default behavior had changed to "current branch,
as long as remote tracking name matches" (aka push.default=simple) 8
years ago.

All these users are aware that there are options that change git's
behavior, but the only one who ever took the time to understand and
consider changing the defaults was the expert user enthusiast.

I realize all this is anecdotal, I'm a hobbyist and a novice in this
community, and the deployment I support only has a few hundred users
at the moment - but surely there must be a way to confirm whether it's
true that git's primary value to millions of users in the world is in
a context where there is a single remote, and branches normally and
intentionally have exactly the same name locally and on that single
remote?

2. Current Experience

Taking the user model/workflow above and its statistical significance
as a given, what's the "problem"?

A) a user can accidentally end up in an unexpected state, and not
easily understand why or what's going on, if they do "git checkout -b
mybranch origin/whatever" - that is, if they choose to branch from a
known remote state, rather than creating a local branch for that
remote branch first. In this unexpected state their "git pull" is not
doing what they expect (it's bringing in changes from a *different*
branch), and their "git push" is not working.

Furthermore, the error message for "git push" is not actually giving
them the right option to solve their problem - it suggests they push
to the same-name remote branch, but does not propose the "-u" option,
because git can't be sure the mismatching branch name isn't
intentional and "-u" would be a kind of destructive change! So they
will remain in this weird/unexpected state unless/until they figure
out for themselves to specify -u or otherwise change the tracking
upstream. I've seen people delete the local branch, and recreate it,
just to sort out the remote tracking, because it's just not obvious to
them what is going on!

Other flows don't have this issue, eg if they first "git checkout
master" (potentially creating a new master branch with tracking from
remote) and then "git checkout -b mybranch".

That inconsistency is part of the problem - it forces affected users
to think about remote tracking branches in a way they shouldn't need
to, in a way that is basically alien to their day-to-day experience
and expectations of the relationship between local and remote.

B) When a user creates a new branch and they want to push it, they get
an error that spits out a magical incantation hint, they repeat the
magical incantation, and then things are working as expected. This is
a lot better than lacking the hint, of course, but is a completely
unnecessary interruption in their workflow, *given the assumption that
remote branches for these users always have the same name as local
branches anyway*. The intention of a default "git push", in this (in
my opinion vast-majority) situation, is simply to make this branch
work with its remote equivalent.

3) Naming & changes to git behaviors

One way to approach the desired flow above would be to do away with or
ignore the concept of upstream tracking branches altogether, and have
a git behavior mode in which "git pull", "git push", and "git status"
all work automatically and consistently with the same-name remote
branch.

I think there are a few problems with that approach:
 - It would not be an on-ramp to slightly different behaviors / modes
of functioning
 - We'd have to figure out what to do with any then-ignored upstream
tracking entries for existing branches
 - It would involve a lot of code changes
 - It would be hard to explain in relation to all the rest of the doc/behaviors
 - A user interested in working with just a single
locally-differently-named branch (eg because they're working on a
server with remote branch names that they can't change and are
inconveniently long, or have complex prexif/namespacing requirements)
would not be able to make use of such a mode - they'd have to switch
to the "full/normal" mode.

Therefore, it makes more sense to figure out the smallest changes in
behavior that lead to meeting the expectations/conveniences above, and
don't prevent still keeping branches that have a different name to the
remote, when that is very explicitly desired & specified.

Hence the proposals in this patch series. I do truly believe that the
two small changes (new "don't auto-track differently-named upstream
branches" option, and new "automatically add remote tracking for
same-name branch if missing" option) are the right thing. What I don't
know, is whether they are *named* in the best possible way, and
whether the text of the proposed "hints" is the best way to help the
(in my opinion) majority of users who will probably benefit from
setting things up this way.


> but I think that the 'missing
> origin is fine and we can use the unique remote if exists' is a
> really good idea,

Cool, that's an easy one, and a separate commit if you want to split
it off. It's a prerequisite for the "push.autoSetupRemote" to work
well (in repos that have a single remote not called "origin"), but it
does not depend on the other proposed changes.

> especially if some push strategies already do so
> and some don't, which seems to be the case.

Not exactly - there are other *commands* that do this kind of "the
single remote" defaulting, but not other push strategies. The reason I
called out only two default push strategies explicitly, is that they
are the ones that can work without a remote tracking branch being
configured at all (as long as there is a remote called origin); the
other strategies depend on a remote being explicitly configured as
push default, or as branch remote, or as branch push remote.

>
> Will queue.

Great thx.
