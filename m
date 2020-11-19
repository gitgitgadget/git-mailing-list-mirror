Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9981DC2D0E4
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21396246B2
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 11:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Xuw99AGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgKSLTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 06:19:32 -0500
Received: from mout.gmx.net ([212.227.17.20]:36795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgKSLTb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 06:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605784750;
        bh=fXKfVOKXTRPc7jMxQTvTm02yL7y2kTSBUTKdhFMyGI0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Xuw99AGOiXzfNdntkE8I67t2tLshBhNuwJJb6Bk1OnKUlQ5BC/BIC/SHl3cuOgrPh
         pS35aPgTKErmuZn4GS/XWc+x2En27C6cMraoRPNcip2my/z/6D4zz67HbFCVfGD8HG
         kBDw/dkllYEg+onH3NcJ+XxLB4wqI+6dkIug+0Zs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWRRT-1klzdd2anT-00XwS4; Thu, 19
 Nov 2020 12:19:10 +0100
Date:   Thu, 19 Nov 2020 12:19:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5310-pack-bitmaps: skip JGit tests with SHA256
In-Reply-To: <20201118184543.GA3016@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2011191215140.56@tvgsbejvaqbjf.bet>
References: <20201113215307.20855-1-szeder.dev@gmail.com> <nycvar.QRO.7.76.6.2011152252520.18437@tvgsbejvaqbjf.bet> <20201118183022.GA8396@szeder.dev> <20201118184543.GA3016@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1627240258-1605784752=:56"
X-Provags-ID: V03:K1:lYyF0N25HppPf402b0bz2K4qytm5M/pcarOQxH9Bst2lLLli/iD
 rfVymBi4dvvwdyvTCzZSFFCJLXP32zPawsoKEVgecQp5NDvuIVxV48uSxcpCA964XJA2d4p
 Fxxtj1v2NRhHe9HtKL5PuEgNb8xJ7G49dWCy1cjNQdexY+ulEBnRsdJdtppnt27K9B/p/tr
 vdaP/IafeEAi5zSPR5/+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HMzgmmQOmmc=:1qCoYj6Pbwon7WBbFdgk3L
 ehT1n/Km1zmKqHmPPuZfR55BYZsZVr5OMqI83oa590FTWpuZIm+52O8eUdySdNb8gRtSMn7Ez
 CTm3TjIJxfOaqa4yA3xp6/ZnhFQcKSkdsK+h04GF4bmkGCzq0RmfkhzF93gLUbtU1sada4ewZ
 mEdZPakD6hWOr1Kg/1/uqXFSk4bFfdKlYE94C2JvuJSauxRV3bSIpWTlE+4yDnDF13YbFUvb+
 syRnSG6LMXg1UdMnnUf+pQt33PVbClMiDaMAZ2jupMnyzgcpMRaBhJYefKvXrg8ly+O5Qgwjm
 APtKBxKqoIYnu+1PwNEzCH6DuohZ0KnGJyMRiRawu8Um2LS3MvTkxsYLrNQKWU7PIsxAUvx4l
 RTsYs2Xux7hk6PxhVcYHjIKO9utsd1GWsE1M1qVCYmbl5kW3xXuDC4txlOGbjtYYWg00k/8cf
 sjkeTFf+7HcxC8B1z/Bn1RzFtfsKTKYwqHvs4poKZ/kq5OQkxMZeroGI06VwK6VZBCSAXhGAd
 kQ2nFcjEdUZaDJsEKkidABKGQSCYPF+NaBwTA1lyz3q03WdI69tDLFA2eewTGIL7wFzFr+qDc
 0AeCX0w6oYJxlkwE03CcbgSp1Use76Gkq9ga8eApxO0TZqMwwx9+Wv8uQtkcIASzPUG1jNxZt
 GMoJtIVcSGhLesLvYKCl9R71smPGvfzjpXv3ncdD8XmZy2rKX4Jnffa+TCvY+R7bnP5n9QQZH
 yV/5T2LdJELjcApIr8EC8ESiFa4/HyVGRb2xkV/7ugYkZKEI/lfLKafdX0WBfwmdDQnOM6emX
 FD7jobEiG+OAW+hT/MZ07hFYrQmv+5cFp9prDNt7soK0B7cDSqjYKD10HefJU3YJY6i3sCoK7
 3B69BPTCorWi/ijRkaZfbee4c2l2UwmJzp+8WLwlg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1627240258-1605784752=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Wed, 18 Nov 2020, Jeff King wrote:

> On Wed, Nov 18, 2020 at 07:30:22PM +0100, SZEDER G=C3=A1bor wrote:
>
> > > I wonder whether there is a way to change the `JGIT` prereq in a way
> > > that automagically will recognize a (future) SHA256-enabled JGit?
> > > Something like
> > >
> > > test_lazy_prereq JGIT '
> > > 	jgit --version &&
> > >         test_have_prereq !SHA1 ||
> > > 	test "$(git rev-list -n 1 HEAD)" =3D "$(jgit rev-list -n 1 HEAD)"
> > > '
> > >
> > > What do you think?
> >
> > I'm not sure.  It is surely a substantial effort to fully support
> > SHA256, and I suppose there will be JGit versions with only partial
> > support.  I'm worried that there will be versions that can already
> > read SHA256 objects, but can't read/write SHA256 pack bitmaps, or
> > can't transfer/negotiate SHA256 objects yet (for t5512), so even
> > though they could fulfill such a prereq test above, the test would
> > still fail.
>
> Yeah, it's likely we'll need to just match the output of "jgit
> --version". Since their support is hypothetical at this point, I think
> it makes sense to go with your original patch. It does mean we'll later
> have to remove the SHA1 prereq from those tests, but that's OK. It's not
> very many tests, and your commit message clearly explains what is going
> on.

It's not just removing the SHA-1 prereq, but testing for a new-enough
version.

This most likely entails adding a new test helper to `t/helper/` that
allows using `versioncmp()` via the command-line, with some clever way to
indicate the different outcomes, and then using that in a new prereq.

You know, if it was me, I would opt for the simpler (and future-proof)
solution I presented above. But hey, if that complex solution using
`versioncmp()` floats your boat, who am I to stop you.

Ciao,
Dscho

--8323328-1627240258-1605784752=:56--
