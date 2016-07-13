Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7C5E2018F
	for <e@80x24.org>; Wed, 13 Jul 2016 19:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbcGMTAv (ORCPT <rfc822;e@80x24.org>);
	Wed, 13 Jul 2016 15:00:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:49731 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751304AbcGMTAt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2016 15:00:49 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LgZRV-1b0Ucf1N1Z-00nwuK; Wed, 13 Jul 2016 21:00:00
 +0200
Date:	Wed, 13 Jul 2016 20:59:59 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
In-Reply-To: <CACsJy8BXOrGobyLGAKf=5Dv_4h_Keon9ktZ3B8Vr85qHOY0+mA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1607132055090.6426@virtualbox>
References: <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x> <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com> <alpine.DEB.2.20.1607101255300.6426@virtualbox> <CACsJy8BWKrXqXnbEgSKJ9gKcAyvdZhExfgh5zBRisX8R3BkBLw@mail.gmail.com>
 <alpine.DEB.2.20.1607101602320.6426@virtualbox> <xmqqinwc9fe2.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1607121243470.6426@virtualbox> <20160712152646.GF613@sigill.intra.peff.net> <CACsJy8C+NEP1HJq8w1frOy=UOv5-SA+b7MkbX8DE_vU-zjX0XQ@mail.gmail.com>
 <20160712155141.GA5967@sigill.intra.peff.net> <CACsJy8BfXSvKM3=rRCDYzR=rpLRi+FBYs4r1WGXFisq0Esk00w@mail.gmail.com> <alpine.DEB.2.20.1607131004410.6426@virtualbox> <CACsJy8BXOrGobyLGAKf=5Dv_4h_Keon9ktZ3B8Vr85qHOY0+mA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xVp2UinPWI1ptW9oIUsXRXP5QyvdaiI8jdtae4v3xacop6HkDGA
 98VJoasPGqvx1p7Y2nDkFvip82fzlDgsRElNAvIjZedSIVmJehRNuGiazK/qdpIv9t+CT5e
 iQ9/IkVdRXqnGEzULdb1znVl7mFQLZ5fl7ShL5qKw6EOlTdlqCH5JoWHTTLKY4wIx9rB37N
 m2autsXtKlpQn1WG0LAhA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:nXkbqhil0tE=:QrywXf+zYEi426Qfudf2Zn
 goidBMVfnPFsTEwNp9vadfGEjIIthFsMgXIl2YQjHrIGA+czsJcoGQ+lEKDp3hOpAtY6RObJ7
 1I7zFLApZ/XKMJG1jEbCNRI7uOXLk685zPvj9vCFrNTTmHKtmo7k63yloSWmpn0Nb2Yg+rjtj
 Ij48V6KTJ/Ym2gb6Hj2maZg+bpkttNAjgfeNxFMXguuAqFFzgy12NP7wC4XxCHHMBm6Dvvbk2
 wHVyph9dkoKc3X/mey8YUiJIPrxzEYzKW6bwEDdwIYNJDW/wu3dxc50zvYLLzrepTzTAgoCyO
 OnHsuYwl5kgsT3Bhy3wNz//YSJsv3y2ZYgJt6YhsH6lOolOT9trzZ09r5Ijn2iUNFGV7/0PGg
 I9iGJ8KilDSJIzcoKAiG9zcQDUHH0n0a3dfKn2f+oF/eRgREA5iqW0qDCOzyU4o4CcjrP9FiX
 feT4VZamMuXkwPY3KnD89+7kM1NHupkxLZ13j3wP1L7J88+I1y4covi7lsqA7SMQrYt5QnN3+
 c0qh30B2SXpsqZjHXuMhmsOhzPz9MT15kFak/8toRKFxTF5PEwsEmP0S+mQAOsthP4qTZz84o
 iWxEUYYc/uAXsRNDBX5zO07NeJOwBmw9HbYqBCjNxRkm9zk7U4yIUdotirzlLgECliWu31SCh
 mJNVN5PLsv3KnCIDJto0gKBvzu8fFhJvNwFDyKcywXORteapWwhQqqVC/6aH7l/sxPhdgyDrf
 es7GFpc2rL6cF6lE2jK46VFdK5nSncl6bpWuHt2+RYs5srRL70de2QReW4RcHnQhBUmhW7YTh
 BXQFYeS
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Wed, 13 Jul 2016, Duy Nguyen wrote:

> On Wed, Jul 13, 2016 at 10:20 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 12 Jul 2016, Duy Nguyen wrote:
> >
> >> On Tue, Jul 12, 2016 at 5:51 PM, Jeff King <peff@peff.net> wrote:
> >> > On Tue, Jul 12, 2016 at 05:46:12PM +0200, Duy Nguyen wrote:
> >> >
> >> >> I'm not opposed to letting one worktree see everything, but this move
> >> >> makes it harder to write new scripts (or new builtin commands, even)
> >> >> that works with both single and multiple worktrees because you refer
> >> >> to one ref (in current worktree perspective) differently. If we kill
> >> >> of the main worktree (i.e. git init always creates a linked worktree)
> >> >> then it's less of a problem, but still a nuisance to write
> >> >> refs/worktree/$CURRENT/<something> everywhere.
> >> >
> >> > True. I gave a suggestion for the reading side, but the writing side
> >> > would still remain tedious.
> >> >
> >> > I wonder if, in a worktree, we could simply convert requests to read or
> >> > write names that do not begin with "refs/" as "refs/worktree/$CURRENT/"?
> >> > That makes it a read/write-time alias conversion, but the actual storage
> >> > is just vanilla (so the ref storage doesn't need to care, and
> >> > reachability just works).
> >>
> >> A conversion like that is already happening, but it works at
> >> git_path() level instead and maps anything outside refs/ to
> >> worktrees/$CURRENT.
> >
> > Wouldn't you agree that the entire discussion goes into a direction that
> > reveals that it might simply be a better idea to require commands that want
> > to have per-worktree refs to do that explicitly?
> 
> No.

Oh? So you do not see that we are already heading into serious trouble
ourselves?

> I prefer we have a single interface for dealing with _any_ worktree.

I agree. So far, I did not see an interface, though, but the idea that we
should somehow fake things so that there does not *have* to be an
interface.

> > The same holds true for the config, BTW. I really have no love for the
> > idea to make the config per-worktree. It just holds too many nasty
> > opportunities for violate the Law of Least Surprises.
> >
> > Just to name one: imagine you check out a different branch in worktree A,
> > then switch worktree B to the branch that A had, and all of a sudden you
> > may end up with a different upstream!
> 
> Everything in moderation. You wouldn't want to enable sparse checkout
> on one worktree and it suddenly affects all worktrees because
> core.sparsecheckout is shared. And submodules are known not to work
> when core.worktree is still shared.

We have precendence for config variables that are global but also allow
per-<something> overrides. Think e.g. the http.* variables.

The point is: this solution still uses *one* config per repo.

> I will not enforce any rule (unless it's very obvious that the other
> way is wrong, like core.worktree). I will give you a rifle and you can
> either hunt for food or shoot your foot. In other words, you should be
> able to share everything if you like it that way while someone else
> can share just some config vars, or even nothing in config file.

You gave me a rifle alright, and I shot into my foot (by losing objects to
auto-gc). I just did not expect it to be a rifle.

To keep with the analogy: let's not build arms, but a kick-ass tool. And I
seriously disagree that per-worktree refs, reflogs or config are part of
said tool.

Ciao,
Dscho
