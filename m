Return-Path: <SRS0=/23Z=ZO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA63C432C0
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C8B20715
	for <git@archiver.kernel.org>; Fri, 22 Nov 2019 14:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gdsu1sDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfKVOnw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Nov 2019 09:43:52 -0500
Received: from mout.gmx.net ([212.227.15.18]:54271 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVOnw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Nov 2019 09:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574433826;
        bh=pJ2e4ZXZmgIgoSTi5gVSjjy7WKsGLXRe4UlRdidoql0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gdsu1sDo/hId9e8MB0qxjDwHg1+7xABuHOb23nfjxDvRLbxgJKcOFLwlNaDN2qbkU
         hLSSJjif5qMuu/HgW17TDFCZf6ojJZlyy6AUQL6juYqrQB1jioY9RhxhU1oK4g5has
         ckBacBtG6O9+Ra2gmMnwDcGWLy8MosH+z1DWEXQM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2O2W-1iYiey2fpW-003xpP; Fri, 22
 Nov 2019 15:43:46 +0100
Date:   Fri, 22 Nov 2019 15:43:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: GitGitGadget on git/git, was Re: Should we auto-close PRs on
 git/git?
In-Reply-To: <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1911221542511.31080@tvgsbejvaqbjf.bet>
References: <20191109020037.GB60198@google.com> <nycvar.QRO.7.76.6.1911121946480.46@tvgsbejvaqbjf.bet> <20191113011020.GB20431@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911131234380.46@tvgsbejvaqbjf.bet> <20191114074117.GB17186@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1911142354290.46@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.1911181930290.46@tvgsbejvaqbjf.bet> <20191121105414.GA16238@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1911221430510.31080@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wBqbmtjgH7qXiKijCxWS50y1RkeQPMz0yLxUlrcyrK8ZT7cZIb1
 L53OQsBalJv2ZUwi1j9CrVpOTfa5RMkBXfRAtAbNe3TfrqOp8VZ0qK8hvbzQej6hj2eO3bf
 Kuqdehuep+SYr1s7flnaHVAE36L4SHOAowmOc1B46ECr5cnvbAzDPEUYnpuF6ozuU5UfYNM
 GpuH3+DhA99uhyud/bUsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pCeu/Vlsme4=:wI+B6JeMiLflEw3NY9RRIz
 3Kr1JKPK18mx+d1L444JOLknVVl8s3m9wjby35Y/dxdWRDo4oqKe3wFo2T6CfuVaNAn3qciw2
 18hdHgvJjdxBVwAAeS8xYJvKZMqhwdykGrjINXM7eVLiymGN3kdBhzZPyNhbd0ce05twkRoSm
 bDe7eD1nno7qp4iIebVSVrgOcsYs2ZgWYyxmtiXvvS/n97pHdn/Bq39DO49NuzQNdHxXQuomD
 zKLs+TBtj+rYb8JeuzDNhZijVCLt+TcrYTUEXscTcLAymEjDNJitprgKRZA1UYMCu0F+36qe4
 PHZQ+JBYXQmckQBnIcVWWP9L1HhQuT21K0KKKdUS1citaTwABE/ri9BImlM5NhdQ315UdvXqf
 aQk12GvJ9+WCzXYBojRce7RO4VHYf9lQGsmdOYKcqeXEEHeUFIleWDikiu1pTAgoMq5eV4iOB
 v4Taqw717jhfkQ9uE6gOCjV9SEs0+HuHUUYekiFPc7f1HcHsW1ZEaolWF4qOaCD/iusnZ9YdA
 L4dM9wnjO6pw/zByxALxl9mPIVpxWt2gI8Jlip0j6YVyrughz8W3seeqN+Zwxzpxj67OAI9In
 HzOZt/HMM6fr8SHSjyYeqXilijJbjBKfIpAbctlKu2a833B4nhgyWy9fuJtMwUgwhqBpVXJee
 PhKn/Al5/LZA+Qm3mtmO8HgQuYUMke9WZJk7RYgLdissWUMWxkHsOYDpXP1xuR6HonGElF/e8
 d0p7159+FHIwc1ZOktJIIUggGEUZglL87OTpqjT113h7DxANRYguIdnY96nXLFYYsHvWOWOJ4
 nuy1AAtyIKoOrrI9pwvUrDLIDQJ72K4VtobagbcLhKPlAOBGuHGmBTW2MQccIb4EtbNYFZMeV
 OI222nkqR9IvzY/+db9lAayBvsZJSGaYWuC0wWWF7qgKqV3VFSlAtE0r5iGZpQJYS9nE+YBBD
 IeyMN/OysyfXoauutV00XAVKUwNsNWt8xxi1pGom1xV/YOnBr7usYV84r1fEJrbEc9FI6jSNp
 9Mptfsie280RUH6HerUeCG+BLvFDbXKf2JTzNttUh/aBecfvIdkwikub9fjcbCNtFwH7yvWPI
 XPjyCUva2iB0oNk/9LAc3SZBN9A4vhlVz3X7o5oU84DRhoSMbpyq/4fC5w2ARUsCy7aPM/lUF
 YMkYj+7OQvPr5vqUrZdMn+kZLySd/XbyaXOFreKyvDPWsW6Cgj//iKs0HyfrU0EinlmvaXx3Q
 /FkaYh9YXgNUxbeu3zgyjH7m/NpcrNM0YA37XtoaOcJ1ZfxiXXJ5vVtB8tYc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Fri, 22 Nov 2019, Johannes Schindelin wrote:

> On Thu, 21 Nov 2019, Jeff King wrote:
>
> > On Mon, Nov 18, 2019 at 07:37:57PM +0100, Johannes Schindelin wrote:
> >
> > > To build some confidence in my patches (as you probably know, I do
> > > not trust reviews as much as I trust real-life testing, although I
> > > do prefer to have both) I "kind of" activated it on my fork, limited
> > > to act only on comments _I_ made on PRs (and sending only to me
> > > instead of the list), and it seems to work all right, so far. I
> > > cannot say for sure whether it handles the PR labels correctly, but
> > > I guess time will tell, and I will fix bugs as quickly as I can.
> >
> > Yeah, that makes sense to me. Going from one repo to three is not much
> > worse than going to two, so it's good to have a testing area, too.
> >
> > Do you want any third-party testing there (e.g., a user who isn't you
> > making a PR against dscho/git)?
>
> While that would be nice, my fork is a mess and not really set up to
> provide any useful target branch...
>
> The real proof of the concept will come when the first git/git PR will
> be submitted.

Seems to have worked:
https://public-inbox.org/git/pull.670.git.git.1574433665.gitgitgadget@gmai=
l.com/

Ciao,
Dscho
