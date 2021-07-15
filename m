Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453C6C1B08C
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27332613BB
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 13:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhGONDJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 09:03:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:33605 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229679AbhGONDJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 09:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626354009;
        bh=kThTT2TKaKObbbHKZcK/Sg64d3nmopuGTnuC66oFeVI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WwwMA/es6kDr28T8jASeSGs8z6CmJ0/FK94pa9VYS9GYpFvwNgxBI4YYu7nROwTnv
         pwj6Zho+t3ZctyPvcPXALzBPMquE44oXXLND0eKluHi47w7M1PwrarKonaLceYkkcg
         ya2Zxhh4vrh4cd89cOCfSuFqkOPeP6bIehp9Lk5s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.111.2] ([89.1.214.95]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Ml6qC-1lPQxx2x3M-00lUxv; Thu, 15
 Jul 2021 15:00:09 +0200
Date:   Thu, 15 Jul 2021 15:00:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Taylor Blau <me@ttaylorr.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Chris. Webster" <chris@webstech.net>
Subject: Re: [PATCH 2/2] ci(check-whitespace): restrict to the intended
 commits
In-Reply-To: <YO9lWk4NVfe/yK8Y@nand.local>
Message-ID: <nycvar.QRO.7.76.6.2107151500000.59@tvgsbejvaqbjf.bet>
References: <pull.995.git.1626300577.gitgitgadget@gmail.com> <b63a5bbc63ba17449a91913ab28c268db5fa3650.1626300577.git.gitgitgadget@gmail.com> <xmqqwnpsttx0.fsf@gitster.g> <YO9lWk4NVfe/yK8Y@nand.local>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:yHhwE/Qcw+T9sP7NDum02oWh/SUfq9MSgJxbxZ8RN0BMB8XW147
 9+dxIKpjsLKxcdZTur+vNFQEy4+AD/dfaNkA43NHeKhREp+uizZOeGbMNhiWoTYhv+binqP
 LIC4UBj8xmpiH9IpR8+XHwbL/VO0NPneOjE9VGBYzTrg/zAI3ye/6eJOt2imMmPJbyGNDOy
 9SXnARKq9I0+dmNFy5mcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k8nx7v2Fc0c=:MxgPcP9HRIzWIOUa9/dXP/
 BWz2M6v9ApCg+8dwh7dzhqBPXkXmxiQpGTYRrrqoDWRWLinponkjsWPqt56KUS7w9A9QlmKW/
 hq9Je1DNWilABSh3Ko/+TuGVzQYnazQvf8AbiAjTqpod+vg6WY8pGBtgT/EIlnYl5GcAdgLPE
 Qj1R9wDSh5S0SbfH6FjvcWnSpzUNtJaVk1n0KOYOHG/ZPi/OBoycvOKD6X1eytAQaa8HzY0/Y
 ZKrpZFrwoJScYx/aoeIqPReX3KByFyLFyrKa0ji2p6jJWqQvQOb4qF0Z9m8BOlxx6Dsp+WcD6
 pDI4rf7ZaLypUJJt8Sv2KDCs05S7wEtNiMbL/VJyoyoXobfDfpYMnvc+MEJG7etNH4T3K0Sj8
 apsEBrtzVMeNTdZmma4nOVkgouTEHTNA4T+zdUcQR6f4fezpWXTyjUhhqadEag7FmOMTJia88
 JAs5mijMcYAateB1KMyt0chgKpNH/JR0qzZrsn5ZPoR1reQ9swB4MXkmiQbxI4kA7jwmnGiD8
 R3vJY+vNh78asGyR0SWmDvLemPlPJbYboIKETVAZhJJYS7h4GuyWk2iOaPauTRqtJuxepQbel
 FFwb+4nIgmmVELle8C0NYdhEvWaEQWXCQlhlh0Uhb1ZF9Lvl57/HcFeJ1brecv/+84gANE+uy
 FPqJeicxn8RAlNAmGKik44Mzcv9ysWnB0vbdDxo+R454KomAemakOs2IzxgY0aVLokqXZdSGK
 0gbJ3DuwokKPKUeeCRXTY+vjZe7OQ4IUvQphP+xo8kv7xEyRXFupOlKY8CEF/7dX8Wes8py6o
 gOcFX9vteSyxO7NTcgUQujcxH1IfUqLHYfTJ58DmzGFgi/j7zNamRH4ayVKq0uDqjJyqrSUjm
 KWFohjrtR30uYVuVaXYl0LiXmp7i2BkdpkacQ3XL/fXZxIsjiEK6cAZQFOg3oiNob2EuPYIsx
 U4d04fjL4YJ4Jr70Jdp8wdOJ6zF5DKfkBK2GgvU55GonIGNwWiQ/+bo7R33YI+eV+2hQnZsS9
 JkuJOSOyLJfER39/6Avd63ToERFolEd9qhdDSdfih9PqjE9vQD/EpCRlhn7vGjzJSHLh2Jsel
 EjH3sgmwxCJixXURAyRknrZDKknF5ovjpSi844AfYfzNiU3Q+Vw173sXQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Wed, 14 Jul 2021, Taylor Blau wrote:

> On Wed, Jul 14, 2021 at 03:25:15PM -0700, Junio C Hamano wrote:
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> > > Unfortunately, this means that we no longer can rely on a shallow cl=
one:
> > > There is no way of knowing just how many commits the upstream branch
> > > advanced after the commit from which the PR branch branched off. So
> > > let's just go with a full clone instead, and be safe rather than sor=
ry
> > > (if we have "too shallow" a situation, a commit range `@{u}..` may v=
ery
> > > well include a shallow commit itself, and the output of `git show
> > > --check <shallow>` is _not_ pretty).
> >
> > Makes sense.
> >
> > As long as you have pull-request base, I suspect that you could
> > shallow clone the base and incrementally fetch the rest to update,
> > perhaps?  But I do not know if it is worth doing so for a small
> > project like ours.
>
> Agreed, and...
>
> > >      - uses: actions/checkout@v2
> > >        with:
> > > -        fetch-depth: ${{ env.COMMIT_DEPTH }}
> > > +        fetch-depth: 0
>
> ...I wondered whether "fetch-depth: 0" was the default and whether or
> not this hunk could have just removed "fetch-depth" entirely. But the
> default is "1", and "0" means "fetch everything". So we really do need
> it.

Indeed. One of the things that makes `action/checkout@v2` so much faster
than `@v1` is that it fetches shallow by default. But we can't have that
here.

Ciao,
Dscho
