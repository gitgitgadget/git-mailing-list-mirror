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
	by dcvr.yhbt.net (Postfix) with ESMTP id C22911F462
	for <e@80x24.org>; Fri,  7 Jun 2019 05:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfFGFck (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 01:32:40 -0400
Received: from mout.gmx.net ([212.227.17.22]:59685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbfFGFck (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 01:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559885546;
        bh=XJQmG279cHlz52vm12HZ63flksAQu0rfyk6+2u+nBLs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cqxT1DH9KUPg7kEHmqrQj8AbpR46ZL9Ek1VM1pPYkQ38bQzB8/dQML79Jylq/WN3j
         nXDOVNItnN2oHVLTU9At3cQcMU1vcINTdXkgTdvH/k1s3U26hv12k78Hy7lKXP3b6N
         +vqDoInxOPo7shrJwNja1SEtNKYAKKKs6ecR2CYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LwJko-1gUJkK1n14-01840H; Fri, 07
 Jun 2019 07:32:26 +0200
Date:   Fri, 7 Jun 2019 07:32:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@DESKTOP-QUA364F.localdomain
To:     Junio C Hamano <gitster@pobox.com>
cc:     Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: CI builds on GitGitGadget, was Re: [RFC/PATCH 0/5] Fix fetch regression
 with transport helpers
In-Reply-To: <xmqqr286r8ts.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906070722300.789@QRFXGBC-DHN364S.ybpnyqbznva>
References: <20190604021330.16130-1-felipe.contreras@gmail.com> <nycvar.QRO.7.76.6.1906051005060.1775@tvgsbejvaqbjf.bet> <20190605112713.GA14027@sigill.intra.peff.net> <CACsJy8DKWoerME5BykVmihyX2eX10YTO0BNyVc7MGjwp_Shg2Q@mail.gmail.com>
 <nycvar.QRO.7.76.6.1906061505310.42@tvgsbejvaqbjf.bet> <xmqqr286r8ts.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LX69B91eK2W1ZLyZ+jDSOAguuobRxwZK3+rF3iEv/GQqsyHE3lk
 q9ATpvc1blZfCabCu/9ZN4K8CPhCeGw4pODuV3mAYqYgBRnYtbQ/KcFXfXFQx31815PI0bB
 oE7aZmi3O/P/CnJQbz0quRSKVC4LiJ5RS7j6i+5UHY0QfXKQkFIjbu7uCH5jVZNQGlUpiMV
 LobtfgiMcp3+EaJ4P2WAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gD1+Q+zlobg=:2KWLBvW00sqT4rCUwDIVIn
 L4jsdkJkhzXD+dUzC0R85Yt60FB3EFMQIO324/muZVrWJ/e3qTZxfATRIHU2a4dTfr7C/lrkV
 dERzOWmoy7m0rTUuEsPGqEDvnzrjWNZKi+0F/c6tG+dZPt8ow0ESOjUjqzAnnmGx7sEoFtyEZ
 ZZhLIvAl5CBRTPjB0uH/nz6+t39XyN/qtgCfMOVjxIo9H1Nf7jbisA1cu+BV1lCk6EhdnMnZ8
 jh39YraPU/Vq4oThUABNJD2Meok/9ZytWfP0s0FxoDLgJ5/zBC/AhXGPtacIVHoOBE2BAwz/b
 9Jc1Rt1MuvvE+PORgkuMThln/aNju3HyE3hfUN707zSktpzXmHqIX2qz1t8Bgqbcv99BZ3pEU
 y4RjyNtyOcpg6OnmSXsR3r01H62i0AOGnEaHq9BYYIEXvxi0DDiOXjNUwW5w/+ugcSSfRq50I
 j9oCApWHPm39lvdTwIpoTFbvXYcGrInXrvFd3zvA1nIAddop0POgeR5YrlW7OUFCX6duRDnrE
 RzOzVLqYJfykmH5lS5Yj/lC+C3BtTnM7fW6PwvAqKKhv3HqjUdHXKwoHQpSaRfaTplIHTbk4T
 wstWg6akIxa90qoPbQSMQYany8o4p/fkxat/UyHkm0CO6cLBdv6ZbMRipQgn2sidaF4/AfE6C
 BCUDX6FW/tU8Tlx7ZTXGYXEw2FlAi5sAcEfzlwcDckDM9LoGVQHZL3FSGFdbzhf24ujYiC7Uq
 rdBCbks58tI5skxLnPNvIwPq3sjHJ1UUjQOoQ9+XGPrAc8vgLCjTgSBTcfJOaDy3ACgUqWMl6
 4uHrTuxg4/0Tngd3WbOIC2XWrHsVgeWz3tqB5yJcdSWyVgCJqmupkcA4PTkibgZgFe84AHpcq
 d/ADgfuBlg+JHgp1jgfUXmln+UCdoAT51EXnh58FQkOp4TMuj1KJdHmnejOA7PyEGpiaVJOTx
 qh5HcCzA0weev2hyrpiMKsFBrCtdo8nkR2m+YjwhdPAA3aSxsqdzl
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 6 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I vaguely recall seeing just one 'x' once. I think last time I had a
> >> problem with truncating st_ino, but that should be fixed in e66ceca94=
b
> >> (clone: fix colliding file detection on APFS, 2018-11-20). So no idea
> >> how this happens again.
> >
> > Good catch. I think the reason it happens again is simply that Junio
> > picked a base commit that is older than the commit you referenced.
>
> Yeah, that is because the patch specifically targetted a single
> commit as culprit, so naturally the topic that introduced that
> commit was the place to be "fixed" ;-)

Yes, that matches my impression.

I should maybe describe a bit better what *is* tested on GitGitGadget when
it runs the build & test suite for the individual branches (as opposed to
the integration branches maint, master, next & pu): the Azure Pipeline
obviously *cannot* be defined in `azure-pipelines.yml`, as many of those
branches do not even have that file.

One of the features I like most about Azure Pipelines (yes, I really like
Pipelines, they save me from so much work by enabling me to automate a
*lot* in Git for Windows' maintenance, such as building and packaging
quite a few of the components such as OpenSSH, cURL, etc... but I digress)
is that it offers *both* to define the builds via a file that is committed
*and also* in a definition that is maintained outside of the source code.

So what I did was to port azure-pipelines.yml from the former to the
latter, and *that* is run on those individual branches.

As we noticed here, this opens the door for running into regressions that
have been long fixed, just not in the tested branch.

Side note: many projects that want to rely on the confidence instilled by
automated testing therefore change their workflow to a more "topic
branches are based on master, or on the release branches' tips" one. I am
not saying that you, Junio, should switch to such a workflow because you
are clearly comfortable with the current one. I mention this mainly for
the benefit of readers who might wonder what options they have in their
own projects to deal with this.

What I usually do is a hack: this "manual" job definition tries to
cherry-pick all kinds of known fixes to known regressions, and this
APFS-name-collision one is just not one of them. When I find the time
(hopefully next week, probably not), I shall try to take care of that.

> I was wondering if the base commit _before_ the fixes, i.e. e198b3a7
> ("fetch: replace string-list used as a look-up table with a
> hashmap", 2018-09-25), failed the same test you saw problems with.
> It does predate e66ceca9 ("clone: fix colliding file detection on
> APFS", 2018-11-20), so my current theory is that it was broken
> already adn these patches that fixed a breakge had nothing to do
> with the t5601 tests failing.

Yes, I agree.

One might ask why I even bother with testing the individual branches. The
reason is that bisecting breakages in `pu` is a *nightmare*. Most of those
breakages are present already in the individual branches, though, so if I
can catch the breakages there, I have a much easier time keeping the CI
builds green.

Ciao,
Dscho
