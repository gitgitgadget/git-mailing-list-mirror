Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5875DC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F9C208D5
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 10:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="dcIpI73B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgJLKCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 06:02:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:50037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLKCE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 06:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602496914;
        bh=fLaCzqTlZbbrkFvhXlxkqkFjRK8jDMyIuczgHpcS5MI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dcIpI73BLpRAIAqiwAqS7gdDC39SParhE1SSGeurNl8ngBCVd5Ap/00HJOepGEhwG
         4d2Emm9PaDP7VYr3Bj4Wp3Bp7Jj0CQoSi4z/YM/qCkqow/xJiM3Fqz2faOjSliq2ne
         Uo5ZvvhC1rkfQBESA6/cQDjS5N3auxA4LJI66nb0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95e9-1kNQrV1VMl-016AyK; Mon, 12
 Oct 2020 12:01:54 +0200
Date:   Sun, 11 Oct 2020 12:52:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Han-Wen Nienhuys <hanwen@google.com>
cc:     Jonathan Tan <jonathantanmy@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010111247450.50@tvgsbejvaqbjf.bet>
References: <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201008014855.1416580-1-jonathantanmy@google.com> <CAFQ2z_MRzz41x0Osvf6unvQ4Bk-RsA9NxbWZWpfwwJ2D=4Pv7A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:zdKkuRsi+bxhPC1fben1JOQzxzmEzCftm2Al4mEP9vEbA1EEHIM
 ND9AZcg2mwHr95xYNFYcSm8o8bjxVzUvH8qSs4hTjb75cCw+qhdM2itfwkAWI5TRV45oVZB
 pzfj0tiiUBGv+bAmI7lribKyDbxO6tqDiQ9/eiMoDTPTsrUzNcHQJXctwmnl3lr/KU16+i7
 AKMThqU7vrhaeaKEBoTgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TYiNf/3T0Lo=:qEmvNj15sS5Vf+jF8b5XMA
 Fh4eKOahn0XRfqjVVo9R7q4XxHo2JOumMRcPmqgPG01Xx61dDcfR2P8rfKath4r+bxti2uRHC
 gwb68d/krtr+89rXlrKK/sKAOqx1lnmPqrAfe2GYuiq6g4hsaoagg/nr78eEkPVN9YD/y+/qa
 Zh2F4p8diciKHP3S0vLOX4G7NDlUuMK5w9t6Tvoe9w+TW5iy+u9jdUm9PUn3THYbmybD0qKXY
 JqliIyBAS9peyoH1lmKB3t6HUhzMfKeCLUeJvGW2SFIVgXhV8QXoJS6WYlllBmwlP/1B3HmJD
 usQchMx4R0+VA/bE6FQ7T5gn+92F/M30DqdZbeTGulUKQMJ8rhK8rka1EfJC/KcMcfHJB9wqJ
 jk9SQKVCwUmhPFkGAGCWdelj0DcCH3RJ6zEBJmuhvR+17HOGm1TT+UpJugEl6yvyEdKe8BDKQ
 1hJ04+kX6IXy3zDn7N/TVYlwg7LMa8UE/cqrsbD7iUQUziDasb87rfoUWgPoO3GOmEn1bdG70
 DwaBwG09A4t2eOzj7Qr3Sv2IFjPk87h8d8YscfIZGDY/7AhcUxG7HGu6m6UaqR2gnbqV+J4T9
 Uzvk6aymfEzXFRp+SCdxGd57RtL74Yo3rlE2X9febJbLrtRQCluTurxv+zMJKYOEhh7neJWT9
 9sh7rs57OnnQyw52rSvOwn3oQdU6MCrRr6TTq7/dCCpUj95HXpPfKkaIrEcCOUadtqvtAfexE
 mmbYiLlLdKQ8sqUYMR56ccIk6S26e8fJMUwVjHDgJOyH80jZlOYkt1t+YYcNYUucgIgYgPTWD
 x8FSF4z3so6RVVJzC/UMIn/X/pexHz/8cH7Hqdc5HHI29EDTfyJU4M6iH5vrkyUQysWnA5smh
 Ig8Dmbv88UcXy+vvL3IROFc4TRm4YPYulZSfww4dOPFMrmkR6ox3g/vslx5aoowICJ4rOkZRI
 Ywyat8o+vmOORnuOcx1FnFLWybQXjFophPKIMpZc1CP5hrMil0mKosUV/07JQHBUi/a6iF1tg
 Dz3LJUXUWaveKDP+jtLFA1ypbBMf5Z4UAsMc/ZW4YO1KqEstZVEwN74rTLfeiIYtm3sf5mZ9h
 lvM+0pvGCo1XgAgSdbN6Zji3cmG0Wo/QtwONT76gcl8eM4DFnwQNbqQP43/siWwJU5LAgzeGA
 ueKid0KzYWWrllSrA2y7AIGX4+1bp5F8NyZseRUqcTA3Ct8V6wknuEVyeJQI2EGkRh1qC4yof
 UYZcceA9+t481JjLF0lGRzmHT1BuowPkkZJLqpw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Han-Wen,

On Sat, 10 Oct 2020, Han-Wen Nienhuys wrote:

> On Thu, Oct 8, 2020 at 3:48 AM Jonathan Tan <jonathantanmy@google.com> w=
rote:
> >
> > > From: Han-Wen Nienhuys <hanwen@google.com>
> > >
> > > This commit provides basic utility classes for the reftable library.
> > >
> > > Since the reftable library must compile standalone, there may be som=
e overlap
> > > with git-core utility functions.
>
> > I think duplicating things like strbuf is an unnecessary burden if Git
> > is to maintain this library. Something like "reftable will only import
> > git-compat-util.h and strbuf.h, and any project that wants to use
> > reftable must make sure that these functions and data structures are
> > available" would be more plausible.
>
> Sure, but how do we ensure that the directory won't take on
> dependencies beyond these headers? I am worried that I will be
> involved in a tedious back & forth process to keep updates going into
> libgit2 and/or also have to keep maintaining
> github.com/google/reftable.
>
> FWIW, the duplication is really tiny: according to
>
>  $ wc $(grep -l REFTABLE_STANDALONE *[ch])
>
> it's just 431 lines of code.

The `merge_bases_many()` function has only 33 lines of code, partially
duplicating `get_reachable_subset()`. Yet, it had a bug in it for two
years that was not found.

How much worse will the situation be with your 431 lines of code.

Even more so when you consider the fact that you intend to shove the same
duplication down libgit2's throat. It's "triplicating" code.

So I find the argument you made above quite unconvincing.

Ciao,
Dscho
