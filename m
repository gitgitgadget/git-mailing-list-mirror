Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC0C43460
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77F0361369
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 19:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbhDSTga (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 15:36:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:41284 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239557AbhDSTga (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 15:36:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 5294C1F4B4;
        Mon, 19 Apr 2021 19:36:00 +0000 (UTC)
Date:   Mon, 19 Apr 2021 19:36:00 +0000
From:   Eric Wong <e@80x24.org>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <20210419193600.GA19186@dcvr>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Schuberth <sschuberth@gmail.com> wrote:
> On Sun, Apr 18, 2021 at 10:54 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
> 
> > And thank you for participating in the discussion. I think it's
> > especially valuable to get a viewpoint like yours, i.e. someone who (per
> > this E-Mail below) gave up in frustration with the current development
> > flow.
> 
> To be fair, Git's contribution flow isn't the only reason why I chose
> to stop contributing. Another reason is the very lengthy and tedious
> discussions that too often spark from rather small changes.
> 
> Also, I wouldn't say I "gave up in frustration". It was a mostly
> unemotional decision on which of the many OSS projects I contribute to
> my rare spare time is spent best.

I guess some things aren't for everybody.  When I started
git-svn, I never expected git to be the right tool for others.
I figured most folks could just continue using SVN since they
seem to like centralized things or at least have some sort of
"authority" to look to.

I'm largely uninvolved with git nowadays since I'm reasonably
satisfied with how it works; that and I prefer scripting
languages rather than ahead-of-time languages.

> > Rather it's that it's a volunteer project and people work on what
> > they're interested in.
> 
> Exactly. That's why I believe tooling should allow people to subscribe
> to changes in code areas they're interested in, rather than a
> contributor having to know which subsystem maintainer to put in CC
> (e.g. for gitk changes). At least at the time when I contributed it
> was sometimes hard to move things forward if you didn't reach out to
> the right people.

Fwiw, any public-inbox endpoint with Xapian search enabled lets
you request an Atom feed via "x=A" query parameter.

To watch a particular filename, the "dfn:" prefix may be used.
The prefixes supported for a particular instance are documented in
<https://public-inbox.org/git/_/text/help/>, and you
can watch multiple files by combining with "OR".

https://public-inbox.org/git/?q=dfn:cache.h+OR+dfn:git-send-email.perl&x=A

You can also POST to get a gzipped mboxrd file:

curl -d '' \
  'https://public-inbox.org/git/?q=dfn:cache.h+OR+dfn:git-send-email.perl&x=m'

> > of these proposed alternatives involve moving away from something that's
> > a distributed system today (E-Mail infrastructure, local clients), to
> > what's essentially some website run by a centralized entity, in some
> > cases proprietary.
> 
> That's a good point, I admit I haven't thought of that. Probably
> because I also don't care much. So *does* it really matter? What
> exactly concerns you about a "centralized entity"? Is it the technical
> aspect of a single point of failure, or the political / social aspect
> of being dependent on someone you do not want to get influenced by? I
> guess it's a bit of both.

Yes, both for me.  The political/social aspect is the main
reason I'm involved with DVCS (and a large part of why I'm
involved with free software in general).

> While these concerns could probably be addressed somewhat e.g. by
> multiple independently operated Gerrit servers that are kept in sync,
> I was curious and quickly search for more fitting "truly
> decentralized" solutions, and came across radicle [1]. Just FYI.

I don't think any sort of radicle "flag day" or tool mandate is
going to fly.  I seem to recall at least one prominent Linux
kernel hacker doesn't even use git; though I'm not sure if
that's still the case.

Despite being a DVCS user even pre-git, I'm actually
pessimistic about decentralization protocols that either:

1) rely on planet-destroying proof-of-work schemes

2) will need to reinvent the spam filtering techniques
   of email once they hit critical mass

Email is already well-established with a good amount of small
players, and plain-text is relatively inexpensive.  So it seems
best to build off the only halfway-decentralized thing we have
in wide use, rather than trying to start from scratch.
