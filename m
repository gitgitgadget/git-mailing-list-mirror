Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E5AC1F744
	for <e@80x24.org>; Wed, 13 Jul 2016 08:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752714AbcGMIVX (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 04:21:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:52574 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbcGMIVM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 04:21:12 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MLfLH-1bNWWf1ngR-000qdJ; Wed, 13 Jul 2016 10:20:50
 +0200
Date:	Wed, 13 Jul 2016 10:20:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <CACsJy8BfXSvKM3=rRCDYzR=rpLRi+FBYs4r1WGXFisq0Esk00w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607131004410.6426@virtualbox>
References: <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x> <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com> <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox> <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607121243470.6426@virtualbox> <20160712152646.GF613@sigill.intra.peff.net> <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
 <20160712155141.GA5967@sigill.intra.peff.net> <CACsJy8BfXSvKM3=rRCDYzR=rpLRi+FBYs4r1WGXFisq0Esk00w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uqHcn5NqE+8FTojokn72OyFt5MrmREVQ/aSJhSHLWe+pSNATu3i
 +z4iXijvxTzY/XBzU/YoJBwR2LYKJAxgmCcinqDj9J8CxK2k06TVEawrCwJMkG26TI68BV+
 rQC/OEYKpBpPtC1eYUkKh6L6SB3xXWGBpJJtKc1CAAPNaeCJzWrfzQhJbSQcj3bfNFayFSK
 XAqZXROx75srOUOPW3J2g==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:rd/UGh19nnE=:xbb4j/VBqOvOvjm4VreDUR
 u8p2Q4pdnuDl2A/r/lJRyKu8J7OpDL1ugAWsH1Oq7jzcNOt/cKPLzXBpR5+XahBBTOvhYT2xW
 GLRmvBevSexd4+7S+PG+I7t+/X/DU0o5rqNUP7DW7XyzO+h4JX9XavzNzvXtZUhSlibCcRm+v
 IeoSUgjiLxC7bxSCphGScahOUtS3jwVUGerPbFTCgk0sp1ambvHgUYyne+LEycNZB8l7FZUjq
 RArO3uXyRmm6Kkpz7mUs0kC7aG+T8mKsOOsX+IzvbmIsP/kjkCa+vIe6yLPzpO+r4m5omNwgC
 qw9JTphQLopwNFBa8EhCumesXQZIOSgPmtO7uIsDTtKxTti2Tu8uiPkJdACtdtGP0jXgqIWzh
 ic9bLSB78Nv4IEi6krAEuSRBHTEjs4dzqncCjmW9ztDRuxg2c6C0reKbG4TdTugO8p3jBjN8S
 HilQNA8VdmbYXEty8fAOGOiNrqq1E9YRmgVG5EBpBooGcTT0DkwZVYaeDJzwpU7FfN9TYfmWD
 ExEUAZ23LjYgxHLfg02OEFRtxXdDECEC6wuhPnwFJE4FbGUMR+D6LvmVbekk3W0a4wx1GkD2W
 c0ypsSadQgI+CVfcfqykbpD2NtLysvrmzm6VQCLUdeXzglFLxmkILtYtCSv72uOJixPpfwoAv
 WYr0fAVyoQtnzeoe/zHhJj62QBJRcoX2cWjmEavp2vQEJLzZqWrb+guPIvwjUrCKJ7i8FSfB0
 lnJJ2w/jS9+Uqo4SeUIwaYTuskWYONjvgFKi4Ptew+Gdfv1zkB6JlncPyIfxyidWjl27k92zD
 lkgo7R7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Tue, 12 Jul 2016, Duy Nguyen wrote:

> On Tue, Jul 12, 2016 at 5:51 PM, Jeff King <peff@peff.net> wrote:
> > On Tue, Jul 12, 2016 at 05:46:12PM +0200, Duy Nguyen wrote:
> >
> >> I'm not opposed to letting one worktree see everything, but this move
> >> makes it harder to write new scripts (or new builtin commands, even)
> >> that works with both single and multiple worktrees because you refer
> >> to one ref (in current worktree perspective) differently. If we kill
> >> of the main worktree (i.e. git init always creates a linked worktree)
> >> then it's less of a problem, but still a nuisance to write
> >> refs/worktree/$CURRENT/<something> everywhere.
> >
> > True. I gave a suggestion for the reading side, but the writing side
> > would still remain tedious.
> >
> > I wonder if, in a worktree, we could simply convert requests to read or
> > write names that do not begin with "refs/" as "refs/worktree/$CURRENT/"?
> > That makes it a read/write-time alias conversion, but the actual storage
> > is just vanilla (so the ref storage doesn't need to care, and
> > reachability just works).
> 
> A conversion like that is already happening, but it works at
> git_path() level instead and maps anything outside refs/ to
> worktrees/$CURRENT.

Wouldn't you agree that the entire discussion goes into a direction that
reveals that it might simply be a better idea to require commands that want
to have per-worktree refs to do that explicitly?

I mean, it looks to me that the harder we try to avoid that, the more
problems crop up, some of that as serious as my reported data loss.

I do not see any indication that trying even harder to "protect" commands
from knowing that they are running in one of many worktrees is making
things easier. To the contrary, I expect that direction to hold many more
awful surprises for us.

The same holds true for the config, BTW. I really have no love for the
idea to make the config per-worktree. It just holds too many nasty
opportunities for violate the Law of Least Surprises.

Just to name one: imagine you check out a different branch in worktree A,
then switch worktree B to the branch that A had, and all of a sudden you
may end up with a different upstream!

Ciao,
Dscho
