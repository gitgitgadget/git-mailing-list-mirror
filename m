Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E50C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 10:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3BD21582
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 10:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bLnumt9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgAPKZB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:25:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:33901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbgAPKZB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 05:25:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579170294;
        bh=LWv0RPF/m9RXixPWwzQ1F0jNHfCSy1JU4W4iqqkUcFo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bLnumt9EEda8F2fwiwqTsSVH2oEpZ+OZG9/XKRnwsaaCI+BIyIJ42LXOuHpl4KKmi
         nJ+rHvLVJQO4dmayida9CAT7FZ80d8oqbNH/fTmwUC7wtpQwNnLecyFYaWSPI0fovE
         OvigSR5pjw+jmhbrKwHZXQX1lDj/DdnOjRZOo9KQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MpUUw-1jQDPe1OI8-00ptGb; Thu, 16
 Jan 2020 11:24:54 +0100
Date:   Thu, 16 Jan 2020 11:24:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] msvc: accommodate for vcpkg's upgrade to OpenSSL
 v1.1.x
In-Reply-To: <xmqqmuaoia15.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2001161107050.46@tvgsbejvaqbjf.bet>
References: <pull.527.git.1579129054234.gitgitgadget@gmail.com> <xmqqmuaoia15.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4VDpRdJTDQTjOzy+xh+97IbPITLQIDAPvGGsXfi9uuWrUmNwi3+
 BMuBaNuaumhgB0jbBA0wZSL0Ikh/7ijEjwoSoc0r9Wgf+gx4XvJHa6CccfJ/9rZvZNQmKmv
 1DFENS2gxe/tj1gUpr5mftZYxz+F1iHTIGuxv1I8V0Ety/Vj4R5PoOoEpWCUqnV2Qokx8DJ
 SzDrzJ5FQwCOlfPgy8Lqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:L8oYHosdq0w=:riiph7aiqCGtcr4QRnuT7Q
 8HEuuZAX/hYzuBRNNqGoL36a4afghzou1DJgyuff0tqaO9ScADEsbecWGON+xhXC8IvtA9Jdd
 r7goZ28Ic2Ha8SpTLHuK0K+x4GcagukSZIBEBzItQmohbU+2CpCDRu8mbhV3EBIjLTFNb6AfW
 QW2M7V91nfX6Mz4Y6zkV9XbdnadS6ecpPkGg6N7USHN0H6Pgd4xHH1Mfs3cgvgEeueVh0LzE2
 6OgP1MaxEZLmBe9qizFaG+sS2spZ0Y/dvq1AWbb6AjOt3HyAi5IKD9uRUSjHeUqlyQcgsjBTb
 9leGXNpPEcc76/uC84Z75JGjpUYb2Bk9Uy+DpsG9h7XYChdjIqeo9svEcrljdms6Wr0yDBeeN
 9IC1zd7JRDuB575l2C7kFBRDdQV6EYIAA2HTbIt2pmt1/If2bgQYGfT7DTsm9wybqMVHEhFFa
 e7EI6sL2qqurTW6gOGR3Q56BMFla5cqA09/FXDJTEZfqxA0BpoQjpHqwOZZyGFmXOh4ayic4z
 4U+HoKBYRslC3w6qH57tlMljDOK5cZSjFJHA4GYOg4ddcGd1B5n0xFLb90LYqPlLg8rheT622
 3SBY/2pyt4Ne0AQR0oByDX8PHTK/+IIq765OP34fz5eK2rltBaeOD5m4evB+5HeoVATC5D8lA
 wtcm1FqOb5QtDXWUEgDN9JhzTTEh6rofQHO1/NttN7uiaTetXhHD6notHgcXfEnvLDBsrSBKY
 AjdiWjtg3P+Bc78NdI1TQ1zePw+MQhwvQMqWKX7wlP6uYvkP5JdliEous/MlUePSvAfGPqMBc
 NLFoJpkaCFy2XF56i7ar0Rre2qBTM6o7AE2njxlY6IVn4fT0HEGCmvH+Q0AB7kZz/xCRrUDFK
 X06d193iHEdB8P4e8DwO/A6mcE3hSOamI9dfonmRLeu7ZW+tMuByMjuQ21odBbpodlsSBV6aN
 71YGa1FohB2bgk/xjX6HaawmzuC7zmEGOTnb5GPvT+Ob4OoU6tCmTdeCfd6nhDpC36+GOg/jc
 n/9HQsGxp4R8w/j9hoJMHDAqGfYGb1oKlsHX2ojLlV+2lJ2iZy3SHfrBcML+7heoTTuyKojZ9
 drz5ysPlT6K5HwCNQEKda8PDEWrdWJvPGErcac2naLwOr6ybCZZeSwQoaTRvLIbHQYoZ1IIlX
 HrEN7byT93som6Z/TMmGqe/7zC289ea2O6fDq3PpsM0IbPnub4PtSvoZSr92F08O1IdMcPOZv
 3f08D58gKdAxP4DvYOdPCfQNQhb+PkQuxjMq7vuuqgmOwMnuO5xWD2aDojQ4=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 Jan 2020, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > With the upgrade, the library names changed from libeay32/ssleay32 to
> > libcrypto/libssl.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >     msvc: accommodate for vcpkg's upgrade to OpenSSL v1.1.x
> >
> >     It was reported [https://github.com/git-for-windows/git/issues/247=
4]
> >     that the vcpkg project (which we use for MSVC/Visual Studio builds=
 of
> >     Git) upgraded [https://github.com/microsoft/vcpkg/pull/8566] OpenS=
SL
> >     from v1.0.x to v1.1.x, including the change of the library names. =
We
> >     need to adjust for that.
>
> The patch text makes me wonder if there needs to be a way to use
> either version that happens to be available, so that the version of
> Git with this change can work with older vcpkg and vice versa, but
> what would I know ;-)

I considered this. There are actually _two_ places where this would need
to be implemented: compat/vcbuild/scripts/clink.pl and
contrib/buildsystems/engine.pl

The former is at the wrong layer, though: it is called for every single
C file that needs to be compiled to an object file. Therefore it would
need some major surgery to handle OpenSSL v1.0.x and v1.1.x gracefully.

For the latter, it is even worse: the code cannot determine whether
OpenSSL v1.0.x or v1.1.x is present because it is part of the Pipeline
that generates the `vs/master` branch that is intended to be checked out
by Visual Studio users and to work out of the box.

Meaning: to make this work, we would _also_ have to patch
contrib/buildsystems/Generators/Vcxproj.pm to add some conditional
configuration depending which OpenSSL `.dll` file is present.

Of course, this is doable, but at what cost, and at what benefit?

> Should this patch directly go to 'master' (or even 'maint' for v2.25
> maintenance track)?  I do not see much point in cooking it in 'next'
> for an extended period of time.

That would be nice. As long as this patch is not merged, we will be stuck
with failing Azure Pipelines.

It is far from ideal a situation, I grant you that: whenever anything
breaks in the Azure Pipeline due to changes outside of our control, the
builds fail.

As far as the Visual Studio build goes, I fear at some stage we will need
to implement some sort of tighter integration with `vcpkg` so that we can
inherit the linker settings from _them_. That should make things more
robust in the future. But then, I am not aware that anybody plans on
repeating the DLL renaming stunt, not after OpenSSL demonstrated so well
how that goes. So maybe that effort would be spent in vain, dunno.

Ciao,
Dscho
