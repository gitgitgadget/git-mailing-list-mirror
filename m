Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF7B81F462
	for <e@80x24.org>; Thu,  6 Jun 2019 13:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbfFFNHM (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 09:07:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:43357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfFFNHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 09:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559826422;
        bh=IEv5Q4ojFmZ4T6JtBDFOqgAfBL/73ubS3jbZHLX0ODE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=he3ZXnWhiL75HAdcUvIc1u9vTifkvX2ehlAnvlBCc+jWi520TFiJAOirqgTYsHSq2
         Og7++xExBTOXxJtOxnFM/lEtjtCt0HEqxjI35yadvvsvwV7MgKFcznhOckg72fDB1W
         XyrOEGyetYuH7Vie/CIiVFWwYsPqE5xJx5+KID74=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVeI2-1h9fhx3oJQ-00RZSb; Thu, 06
 Jun 2019 15:07:02 +0200
Date:   Thu, 6 Jun 2019 15:07:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/5] Fix fetch regression with transport helpers
In-Reply-To: <CACsJy8DKWoerME5BykVmihyX2eX10YTO0BNyVc7MGjwp_Shg2Q@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1906061505310.42@tvgsbejvaqbjf.bet>
References: <20190604021330.16130-1-felipe.contreras@gmail.com> <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet> <20190605112713.GA14027@sigill.intra.peff.net> <CACsJy8DKWoerME5BykVmihyX2eX10YTO0BNyVc7MGjwp_Shg2Q@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:3726Ok6cqZD6ryw4AiKQplnAUs6iq9McitlcHzzbeujHVKPj/0g
 R2BGrl41JAcZWi8A9FY3iR4FO8w7rggOfUEB2FvbyY329EsqF7XUozpWaUJ2FZdxCU3khT3
 Ne3DkchnQSqk+sLbydUimFMBPr0UW/JWnRntgkWoQy1hi8b15hx+1w7IMEVcXTkPg0WS23i
 7CEQEqsjxcDAVjP2XzkKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qhuT6yncDac=:VbH4SPEzALUYB3mL9lc5mI
 aXrbZVWk1UXkUgXwHxOjXpKR141dMYlYpAA1QJJwzc9NuFB8kEZpEqioKrhQ/ilNioXctWdIo
 csNnyY2l6nWZxyOhlBJoUhXY4EmV7DVE2CuedPIJI/kbr/aLcAkypBTf5aBWIh8z3Hqijq9Dt
 eG7jgo29LRdaYoEXi5cUiuQbVHQTLwTeRAgaC7kJtoyldw7rFUo07CIa20/dClbz3aBb+r6/Y
 REgQ02+XKoj4g37hxcZe870UpJcPkUl0wL4NW+CggbEceF9AHsdsQ3PlbycVVYPQKwKCFehCR
 tXoAHSpfSi65H+/49rmUH5KKHyi4sz6n0t4l6PWvUaVQDh8TNAlozP9r1/w2ewhy0C6rQ5yBo
 H24O0oBNdBFA5ODT46/yOEjUuirWJStVZDDJO7s0+uEntifhfC0ttzIKEnDJVuXl8xZDV2Dct
 8hmNyYPXK0rTLk5+gqvHRdOQaU0gw1S0Tfo/KzS2AFYxR2TRZmQ69Zc5IJmEtyWySBOqIryhI
 ShrEy+xUeLBV2k9rEIIRs+skOW5Ifq4kmGE3DSIo+VuYLJ83gSgqflmlFPI9jYwXG/JFmRgoh
 7yz3CrqzvB9Ieutk4AyH4CzBWBZqE39+9hQp5YgspexjMkFD5I/fw2N+6TSXEvxJ3W6o6LF62
 Tj84mlfKPAtZe8MvZa4/sEUxMgQCZvGSxAyJtsqFRZDttjIIVaA0GCpxjneG0E9a6cJY8aVeb
 0h6tiSaqWeGm0PgTRAHWY6H0W7kY6zZStsMnxC+Riv3jwFqL8FUIg4zyC0bn2e0RP3Zv4UAI/
 sPBxG8NiM0D4ALbYrzThG4nmmvWRkMY+X3RCVw3YqQEyk12qy+3lx8mBOIHfbu8zlBvoN5dJC
 eerqJbfezitpGR5Jrr2XaBhSoph0fgv1iMu0I6sK3MiaEsPZetcE5Ksb8BxawH7bgAnF12r+D
 zFaAIfLqUhrloSeCDEOpcXKXhXovbXGd8JZkIROLVpBl18EoD2d+S
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Wed, 5 Jun 2019, Duy Nguyen wrote:

> On Wed, Jun 5, 2019 at 6:27 PM Jeff King <peff@peff.net> wrote:
> >
> > On Wed, Jun 05, 2019 at 10:12:12AM +0200, Johannes Schindelin wrote:
> >
> > > This fails on macOS, in t5601, both in our osx-clang and osx-gcc job=
s, as
> > > well as in the StaticAnalysis job. For details, see
> > > https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D1020=
6
> >
> > Hmm. I'm having a hard time seeing why (and I can't seem to reproduce =
it
> > locally on a case-insensitive HFS+ filesystem under Linux).
> >
> > In particular, if the problem is here:
> >
> > > expecting success:
> > >       grep X icasefs/warning &&
> > >       grep x icasefs/warning &&
> > >       test_i18ngrep "the following paths have collided" icasefs/warn=
ing
> > >
> > > ++ grep X icasefs/warning
> > > error: last command exited with $?=3D1
> > > not ok 99 - colliding file detection
> >
> > then that implies it has to do with the checkout phase, which Felipe's
> > patch doesn't touch. Later in the log we see the actual file contents
> > (I'm confused as to how this gets here; it looks like debugging bits
> > that were added after the main script?):
> >
> >   2019-06-05T07:58:37.7961890Z Cloning into 'bogus'...
> >   2019-06-05T07:58:37.7962430Z done.
> >   2019-06-05T07:58:37.7963360Z warning: the following paths have colli=
ded (e.g. case-sensitive paths
> >   2019-06-05T07:58:37.7964300Z on a case-insensitive filesystem) and o=
nly one from the same
> >   2019-06-05T07:58:37.7964880Z colliding group is in the working tree:
> >   2019-06-05T07:58:37.7965290Z
> >   2019-06-05T07:58:37.7966250Z   'x'
> >
> > whereas a succeeding test expects us to mention both 'x' and 'X'.
> >
> > So we _did_ find the collision, but somehow 'X' was not reported.
> > Looking at the code, I'm not even sure how that could happen. Given th=
at
> > this process does involve looking at stat data, it makes me wonder if
>
> It does use stat data in mark_colliding_entries() if core.checkStat is
> false. I think on MacOS it's actually true.
>
> I vaguely recall seeing just one 'x' once. I think last time I had a
> problem with truncating st_ino, but that should be fixed in e66ceca94b
> (clone: fix colliding file detection on APFS, 2018-11-20). So no idea
> how this happens again.

Good catch. I think the reason it happens again is simply that Junio
picked a base commit that is older than the commit you referenced.

Point in favor: Junio merged these here patches into `pu` and those
test failures (as well as the StaticAnalysis issues) are gone.

Thanks,
Johannes

>
> > there could be some raciness involved. But again, I'm scratching my he=
ad
> > as to how exactly, and I couldn't reproduce it under load or with some
> > carefully inserted sleep() calls.
> --
> Duy
>
