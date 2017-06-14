Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0785420401
	for <e@80x24.org>; Wed, 14 Jun 2017 10:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbdFNKYz (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Jun 2017 06:24:55 -0400
Received: from mout.gmx.net ([212.227.15.19]:63991 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751820AbdFNKYy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2017 06:24:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4WuC-1dkaz40U9s-00ygaz; Wed, 14
 Jun 2017 12:24:38 +0200
Date:   Wed, 14 Jun 2017 12:24:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Use the early config machinery to expand
 aliases
In-Reply-To: <20170614055824.p2ueyiyfsdf6inve@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.21.1.1706141223021.171564@virtualbox>
References: <cover.1497355444.git.johannes.schindelin@gmx.de> <822765b002488f03523bf440097492be3c14931a.1497355444.git.johannes.schindelin@gmx.de> <20170613182606.GO154599@google.com> <20170614055824.p2ueyiyfsdf6inve@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xdoe5vnrEWfuZPjAy1u9JpnQiROYqTQoXmpIpEAph1A9S+6zagr
 b1a6sjp+q+ENqq+O4BHeHw9QgVAjxKyp4qiDv6RsYwSjRcF62tmtQwozIh5PSaO5MOQOsPc
 3jBRljYX7L9W5+YK3/Fg65zmCy+qZpl6Q6PXLwCLTs3InO1NWn3hMGGdWn8F8mqKEhPnMa3
 dfKwKcM3/YWf3hxkoBIVw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Z0iG0mmiYX4=:d2JxxSCYD95vaOxNwNIgs5
 3J7In8eaIAlIQMu3ASLpZ1K/UL3e81LEvw0iHvCtd44dndieW5QwKd6lploeHKEcOm/uN84lj
 zDHJIJ5xKUcwqGwi5hl/9Leepn+gOXcrQ1ChDxNB+o/06wrb0wrESTDjLaszwleJ6SgAxnT8G
 51bm7tknX4QHidRM1YDHoKz5AkVVtf46vnJBommNu/FPiaICJYqon4OVpmVmZ2t+z1Ceah70Y
 9BBvGkacQ3jnzzUB9/X1Vz5pEbASnqwqTUogEANRKorX0ES0l0vGEljfYHN7acwlQAcwqw4zn
 ejUSdwHVP5hGXJm/aA6R2+i1xMaFNYUc8A8XDpnZj88xqzaRiDfStHcaUbT+9qly6qRFNPV7L
 4gTaOSBEH4/x8a5z9PQvhhUW4FJCN5Z+LQ6AEWn3lHhApWlHVpTBbEx/u3q7QnDeI6r2E9vt/
 pzRF/75J0ymxJDQGfH9MdbX/CALHUC2+SWABxOcuruuOlS2R1f/2LckH/zcIzHpC07Qi4Ur5I
 y/TGMZEUiQkPsJ/eHjulpwTlYODmZramVmHdr1h8/UfK7gwNNZEUxUCV3V30lje4kjrRt5gdi
 yC2IBh/YCnPEttVjrLkanLLCpXw2fR0vU01W+oRnu90u36IgRHY3TQF0I/ajvfBSlNOmnoNKx
 SRXZTSurKxaRw1yf4ut+IYmTtQtKHNDv3kSs6hSc9Ik9H5Dv5FSuLCgU6jeBaoSetE1YOrkkj
 geOXbzGpfsTQZNZ5/RUIwiwmPeDemjB1Vr48ajDpazP5IJuZB1pJekcltm1ql5o4L3DsYeG+e
 C7sJH5h
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff & Brandon,

On Wed, 14 Jun 2017, Jeff King wrote:

> On Tue, Jun 13, 2017 at 11:26:06AM -0700, Brandon Williams wrote:
> 
> > So because I've been looking at the config machinery lately, I've
> > noticed a lot of issues with how things are handled with respect to
> > gitdir vs commondir.  Essentially the config resides at commondir/config
> > always, and only at gitdir/config when not working with a worktree.
> > Because of this, your patches point out a bug in how early config is
> > handled.  I'll illustrate this using aliases.
> > 
> > Before this series (because aliases are read using the standard config
> > machinery):
> > 
> >   > git init main
> >   > git -C main config alias.test '!echo hello'
> >   > git -C main test
> >     hello
> >   > git -C main worktree add ../worktree
> >   > git -C worktree test
> >     hello
> > 
> > After this series (using read_early_config()):
> > 
> >   > git init main
> >   > git -C main config alias.test '!echo hello'
> >   > git -C main test
> >     hello
> >   > git -C main worktree add ../worktree
> >   > git -C worktree test
> >     git: 'test' is not a git command. See 'git --help'.
> > 
> > The issue is that read_early_config passes the gitdir and not the
> > commondir when reading the config.
> 
> Good catch.

Oh wow.

> > The solution would be to add a 'commondir' field to the config_options
> > struct and populate that before reading the config.  I'm planning on
> > fixing this in v2 of my config cleanup series which I'll hopefully have
> > finished by the end of the day.
> 
> I think that read_early_config() really meant to set the commondir, as
> it was always about actual config-file lookup. So it was sort-of buggy
> already, though I suspect it was pretty hard to trigger.
> 
> But I agree that since include_by_gitdir now reads the same struct
> field, swapping it out fixes the config-reading at the cost of breaking
> that function. And we really need to pass both in.
> 
> I'm not sure whether we should care about this for Dscho's series or
> not. I think his series _does_ make the problem easier to trigger. But
> it's a minor enough bug that I think I'd be OK with letting your
> solution proceed independently.

Brandon, how hard would it be to build on top of my series? I ask because
I have to take care of some other things and would not have the time to
adjust my patch series on top of yours anytime soon.

Ciao,
Dscho
