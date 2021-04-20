Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF308C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784346135F
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhDTQhs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 12:37:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55075 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232174AbhDTQhr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 12:37:47 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13KGb4UI010381
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 12:37:05 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 839DF15C3B0D; Tue, 20 Apr 2021 12:37:04 -0400 (EDT)
Date:   Tue, 20 Apr 2021 12:37:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sebastian Schuberth <sschuberth@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        patchwork@lists.ozlabs.org
Subject: Re: Pain points in Git's patch flow
Message-ID: <YH8DMB7C0WCn6Rff@mit.edu>
References: <YHaIBvl6Mf7ztJB3@google.com>
 <22a0a383-0ae1-c7d1-75f7-7dfdfe5fb504@gmail.com>
 <87fszn48lh.fsf@evledraar.gmail.com>
 <CAHGBnuOVmzzhgW6GanHBXNb22UW3P1m3i6PJnOUEhYPO76hH4g@mail.gmail.com>
 <87czuq4r4l.fsf@evledraar.gmail.com>
 <CAHGBnuMedez4SE-4-JwCcR8k=_FRtjgBdBSEJqshQnVceCvGug@mail.gmail.com>
 <YH4FaQRB/vWOI9aI@mit.edu>
 <CAHGBnuNrXrHUz9f8nWEdB0PoO0FeLsNpNOGgdiYmsmAD5LjTmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHGBnuNrXrHUz9f8nWEdB0PoO0FeLsNpNOGgdiYmsmAD5LjTmg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 08:30:57AM +0200, Sebastian Schuberth wrote:
> 
> I'm reading a lot about "maintainers" and "kernel developers" here.
> But what I believe is important to accept is that Git is not only
> about kernel development anymore. While I'm well aware of Git's
> history, there are by far more people using Git than there are kernel
> developers, and also by lines of code (or whatever "stupid" metric you
> want to choose) the kernel is not the biggest project maintained in
> Git. Maybe not even the most important one, but that's highly
> subjective anyway. So asked in a heretic way, why should the opinion
> of a kernel developer count more than the opinion of, say, an Eclipse
> Foundation developer when it comes to Git workflow questions?

I think it should be up to each development community to decide what
workflows makes sense for that community.

The kernel community has been taking requirements for what works well
for *that* community, and we've found companies who are willing to
fund improvements in the tools that we use (which include git,
public-inbox, patchwork, etc.) so that it can meet our needs.

Our approach is that we don't want to *force* everyone to switch to
some web interface.  Instead, instead of either-or, we're looking for
some kind both/and, so we don't have to insult people who are
*extremely* productive with an e-mail workflow by calling them
dinosaurs, and force them to use a web interface which would make them
much less productive, on the hope that maybe we would get some more
new contributors.  (And at least for the kernel, we're blessed by the
fact that there is no shortage of new contributors; so our goals are
to make *everyone* more productive, and not have an attitude of "you
shall use gerrit/github and everyone else can go suck wind".)

Git is going to have to decide what development workflows will work
well for its development community.  Historically, since git was
originally authored by Linus Torvalds, it's not surprising that there
is a bias towards an e-mail workflow.  Indeed, git commands like "git
send-email" and "git apply-mbox" are there from the very beginning
because it was *designed* to work well with the kernel workflow.

> To me, that means if you want to make contributions to Git more
> attractive to the Git community beyond the kernel, you need to stop
> making incremental improvements to existing tools and start thinking
> out of the box by looking at the tools that are most popular in that
> "other side" of the community.

I'm not sure that's what was meant by the question of pain points in
Git's patch flow.  Your perspective is certainly a valid one, and it's
certainly easier to choose sides and make an opinioned decision which
disenfranches "one side" of the community in favor of the "other side"
of the community.

It's not the approach that was adopted by the folks who are working on
improving the Kernel development workflows.  The git development
community will need what approach makes sense for it.

Cheers,

						- Ted
