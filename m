Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C923CC433E0
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802AC239FE
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 15:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbhAHPWn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 10:22:43 -0500
Received: from mout.gmx.net ([212.227.17.20]:36081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbhAHPWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 10:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610119266;
        bh=IfZatBVAzUB1HIv8mIBCW2hDDErX+GSmRBZ98ZP7E3w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dBSFu2pdzuUhRvFnTvClK39NxN3RHMfxfeVPFYPFOhQ+6NoFdfm2Ys9/Dv0Ew5uvi
         coc0trOnxI3+GtwjU4mQJXELLafIBtqZbrc+kyacKJiQY2kphUmB3dkG2Zi0qJxp+X
         K+huU2uKvnkKULuuEjMtpseo+vx1Q16oe3TsQhNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MZCfJ-1kTFjM40ll-00VCFb; Fri, 08
 Jan 2021 16:21:06 +0100
Date:   Fri, 8 Jan 2021 16:21:05 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jon Sagotsky <sagotsky@gmail.com>, git@vger.kernel.org
Subject: Re: Feature request - git add --patch should have an option to
 discard or drop a hunk Inbox
In-Reply-To: <X/ghgg+IdZYri1KV@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2101081614440.2213@tvgsbejvaqbjf.bet>
References: <CAJamm=+Z=88G6cH3DRkttGQkrf9tng310+p=4cKiy-GvdCG3zg@mail.gmail.com> <X/ghgg+IdZYri1KV@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SrLvabICpDSQzsyvlH7zy/gFBSUacauWcHLlTmOuX+uPLNE8vAa
 JMvG427jT2u+jReklsJVVk6jFNs6iAhCzoGGu9ZS3fWRYByXIzDp+tebF419N5MLOWIyCIN
 /WcYZg4cWA0ci3dV/xmRR4MaE7YHBuQhSmiVO6l0fs/OYhVoTlDycY5h0v8IzG7WEsF0pz6
 Px4csLU04yqqE65PzgQrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gSJIrHrcwpc=:ykuDO5QnBAb4smejK5W6gl
 YefNR8ob7Yx9GesvkWAuFotFbgF+nJkEar8FDpdpyPlXAOof9Y3DzRjsEJfT1obB4QLxKdt2C
 wuhki/8f7rEA0UXhc4l0rbhyXasqymmZ3txQ9D/CTvMMtGHuTf9oaic3DlQSpwnWVpBdRu47h
 xhQglt6IKZFoxDfQIrBDJlp1G5+85ndG8mcuQ3dVs+o6Bz5WcneKPDybrWHgo5oYksreZzfC0
 QXXo5ZV7Y0yKWygP2wV/alf3gjObNm1eTQFiIrPHYTBMiHQTRgtOqvbCKBmZhkDUmEeELE5he
 bjbA5OqrQk0COE/HmChzILPJhXJqcOSLDn6U50WyxmUIsUFgAdaeCRKoIkJzMDe4xgF1MJ+V7
 4xvCeuFMMbr0V36liDds/A8tVvsWNb8KfKa0QYTMvdiSDVk9AX6iyWIH7FBPpKG78ZioC95tH
 z5hAFRayOHTxYD+wxH3NuWtcySL+nzAGTjB8/T8LB5PXOWgwdjuNoyiCERbq9X3+HoEUV7cSy
 jDe6SwPx8CkAKYDbk/akuUoZSxJHrtilhkBX5cT7iD4RpxyPiFS8/ax1ZbR5FY9zVh9AXF8xx
 Itu0/u+tkjDhVtFeEP8JQ4Jm1qXp5kg7iiMcdmnSq0NABy8F+Dw3UCOXSmFPOpUD1qgUsGgeV
 l1UJdD6spVQqkuDWaCtJb3YKB7wFMIViJ476iYkLVeFhHD9jiMFSftckbGoTFXZyteb4LfGCW
 bY7S7uv3d/Tz2ksoo8AczrPOeKmYn9Hik4rAHAUS2rzoDmg9QexXtsJeqUtoy3mA+ZUw7ssT1
 Uq0RUnkqfLuJ+XxQiG1L6Ec2b0w7vLhX8o5eM9EBjsREmSGjPscRXFmL10sJGotM1YYA/lE9h
 DJ1OATYAZz0oHW0PI5xQ0PVbvckyFY2uGiQNWnDdw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 8 Jan 2021, Jeff King wrote:

> On Thu, Jan 07, 2021 at 11:43:45AM -0500, Jon Sagotsky wrote:
>
> > I frequently make changes to a number of files.  I use `git add -p` to
> > select a number of changes and wrap them up in a commit.  Then I run
> > it again to build another commit.  Wash, rinse, repeat.
> >
> > Sometimes I make a change I don't intend to keep.  Maybe it's a typo,
> > or some debug code, or my linter does something naughty.  As
> > described, I have to skip that hunk once per commit I'm building.
> > Usually this is merely inconvenient, but each pass through `git add
> > -p` runs the risk of me mistakenly adding unintended changes to my
> > commit.
>
> I do something similar and have run into the same problem. There's an
> old discussion here going into some ideas:
>
>   https://lore.kernel.org/git/EE89F0A1-1C07-4597-B654-035F657AD09F@me.co=
m/
>
> The interesting bits are I think:
>
>   - some tools let you do this already (magit was mentioned there, and
>     I'd expect vim plugins like fugitive can probably do the same; tig
>     can also do so from its "stage" interface)
>
>   - it probably wouldn't be _too_ hard to implement, because we already
>     drive those actions from the same code that is invoked by "add -p"
>     and "git checkout -p"; the difference is just which program we feed
>     the hunks to.
>
>   - in the most general form of the tool, it would let you take a pass
>     through the hunks and annotating them. The simple common form is two
>     annotations: stage these ones, discard those ones. There may be room
>     for a more generalized tool, or it may just be over-complicating
>     things.
>
>     The generalized form probably shouldn't be "add -p". The simplified
>     one (just adding "discard this hunk from the worktree") could
>     perhaps be, though it does feel a little weird for "git add" to
>     modify working tree files.

We do have `git stash -p`, which I used sometimes to discard such unwanted
pieces. However, `git stash -p` suffers from a couple implementation
details (see e.g.
https://lore.kernel.org/git/20200731165140.29197-1-alban.gruin@gmail.com/)

More often than not, I am actually using `git add -p` to commit those
changes instead, using the commit message `TO-DROP` and later using
`rebase -i` to actually drop them.

I could imagine that it should not be _too_ hard to implement an action in
`git add -p` to allow stashing a given hunk. The biggest challenge there
would be to make sure that potentially edited, to-be-stashed changes won't
interfere with staging what was intended (because `git add -p` batches the
changing per-file, and if the index changes while picking what to stage,
things might conflict).

Maybe an Outreachy project?

Ciao,
Dscho
