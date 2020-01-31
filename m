Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7044CC33CB2
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE37206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="H/cf+hme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgAaJ5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:57:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:39127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgAaJ5w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580464665;
        bh=TLEOPp/f7qHUnkZ1m185gBVA+1X6x4iKSao9brbJtWA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=H/cf+hmecOdXbZywisfzN09pBQ0x5pPsFvi64GbBE08jn48azBxjGSsOihtyyTQ3o
         I29y1nM207PkF2ZBgRPy/8cLTW6cKqSjKnJgmD4Gryb39uQkUa9hR0+ynwR8oIGiaP
         NCx4OxoMGxIbJ/ccP9NuO+1VmSusz1dDyAdLXOhY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1j0UOS2DOP-003fzH; Fri, 31
 Jan 2020 10:57:45 +0100
Date:   Fri, 31 Jan 2020 10:57:43 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jakub Narebski <jnareb@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com
Subject: Re: Converting scripted commands to built-ins, was Re: [GSoC]
 Exploring Previous year Projects
In-Reply-To: <nycvar.QRO.7.76.6.2001311007590.46@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2001311055280.46@tvgsbejvaqbjf.bet>
References: <20200129171248.6217-1-shouryashukla.oo@gmail.com> <86k15ars55.fsf@gmail.com> <nycvar.QRO.7.76.6.2001301154170.46@tvgsbejvaqbjf.bet> <39a8c249-f0bc-fb0f-2ed5-5ecceb6d4789@gmail.com> <nycvar.QRO.7.76.6.2001311007590.46@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lKEpFt3HVlMy5/IlAtdvgEULokasTEmgNaEsi9iQ0fPed7sfSs5
 1G5Sj18xFtOBF9yOP2ePwzcVrcMChUUcWofOuVaMtAGFIdWThw/cH/I8dz1e+/yPUpT7iIp
 v4XUXv/zoVGv8k8Eh64TbmgQB9UMBzjHa2DADohGMGf0ZGC6utqsjlviSsKMjT60zZR3R/C
 6hNN70FdIIb4NpMTPKT/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tnaYRlIxygY=:ftbA1H5ZwPZkbvjd7yUxyO
 AmtFIxgmIHyu/lFjUYrThb9ojLcl0gkEDV1UoMtSaabX88oqbsXmZGj1fHVY7HeytlnzPKMzb
 D5CXVJClEQ9A0VxBTZZnqc00ZSDzBAOztcpxUMnbVhzumVywLjsznRLJmDGWlhGgW+ZwKN68u
 0mwWEY1fxEpQDPyf3Eo/kD8mLlh2rlYuMm9rZVrDB1URQoDMSInsO05MC2o4KHRCQH9FHyjtC
 ToznGF1v8uNGFAXHnPgdoYC7qJMSsLLcJf8FUTfQqUYfGxL7/Uocec7vr7MYnRKHBC00y83y5
 YNFRJm5ehIsWMBcwzqapHI3xmWRgQe+CR9+4krm5/GO3kVqtgipFQ8qixgBYLI8MmXqn4W2VH
 awuXcdKM3cK5Ge/cXx7LZ/kVMs6Lgx2iMu2qTK84wgJ/3nXEqgWMZLhhKI0fSi8W3THOrmERB
 3OzRh2nCwnD+sxoazWqebZqWLMZI02inq7Ift2/buFAvVROMWmtXm9SecstGU7qeytv2vlXED
 uADJTYc4ssnG3jq9pazshTI4xZajD8rbHve4ThYFFXcklaP2FBTRx5QgecQSL+JwTiPe3XhLK
 S+jWO2XiMkkhiW3UAN+thqlavqCLaa1C1/lRwzifJxUvx88b/nn+7GmBvDvgTMzAND5rfObKD
 Bh77tZ4ZKBgU2gQbStIl8ME7VOBwx/zDc4CQn7k7laPSDR176ukZJmZdmkSfjVwPxJKXLd8pk
 +goKCeYSFhX8j6QpmL58hXdv9xjznSwlra463ljr7cS0HCFNJBWnZ+wWJ7tlrbxhIGNvPKUuj
 gJJcjPtKwF75zli6RGipFOK+nFk4+rVBwEDXJQqKj3Alx38PC0EDZ5Z6gwEFl9nlNJqXobmwp
 JHLFUPBWhaO/SLe2Z1/FEX6RccNbfqTbGCEnG25MSAWdfuxFOO2jFa9CuvWASs63MvVF4tEg7
 WFVaxymdOagiQccjK9T3iykipDXGa61p3fHcOZXnNwQu4zXouorYpA32W5beLPXHMdkKF1QOX
 vGtsPfyvbfsUNX9ZXkjhbvCfxPwPncmyS0cL+7Rt+UmiBtQ82NHBZWsMpQNOkkWCv5Juq6Oww
 BTsbPhNdEoXM8Whc72XOI03k9et1WDEDfaFMS/Hw1PyPGt5FOjKodtYhkTy88kKYxHRIRdsoV
 6hmTixnksCnWqiM2PH17pjWyDKAo2H5AwUxuSWNhpQfcBqOLWeN2XL4LJGQPL5K4/MRI3mZUh
 uiiTa7KvSmG2+jDrP
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi again,

On Fri, 31 Jan 2020, Johannes Schindelin wrote:

> On Thu, 30 Jan 2020, Derrick Stolee wrote:
>
> > On 1/30/2020 6:10 AM, Johannes Schindelin wrote:
> > > Large parts of `git submodule` are already implemented in `git
> > > submodule--helper`, so that's a head start (thanks Stephan Beller!).
> > >
> > > [...]
> > >
> > > Realistically, I think that it would be possible for a GSoC student
> > > who is already very familiar with the code base and with submodules =
to
> > > finish the conversion of `git submodule` in one season.
> >
> > Even assuming the most generous definition of "very familiar" I'm not =
sure
> > this is the case. But I also don't meet the bar of "very familiar" whe=
n it
> > comes to the submodule code.
>
> Hmm. I guess you're right, and it actually matches my earlier assessment=
:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1904031957480.41@tvgsbejva=
qbjf.bet/

I vaguely remembered that I had described this project in a lot more
detail in a Git for Windows ticket, and I just spent a couple of minutes
to coagulate it into a more concrete proposal here:
https://github.com/gitgitgadget/git/issues/541

Ciao,
Dscho
