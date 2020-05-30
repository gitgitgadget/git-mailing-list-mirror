Return-Path: <SRS0=yrqn=7N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA113C433DF
	for <git@archiver.kernel.org>; Sun, 31 May 2020 21:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C0C2067B
	for <git@archiver.kernel.org>; Sun, 31 May 2020 21:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E0/VMx/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgEaVSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 17:18:24 -0400
Received: from mout.gmx.net ([212.227.15.15]:56875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgEaVSX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 17:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590959897;
        bh=x5Ig5u+CKkwefZOJFGxBi4x45PVhaoCMe9NX5tTZzys=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E0/VMx/aZwT6b617+UIHggupu/eCr1A27gFWOy0IV9mg2/75gyO/ccePE+ATxiw/i
         lYKzuUw87YEtJjHW/VHgaFdZ9bjw9I3x4QvcvSPf/lWJS1wJfCpf9pj3RLH7g2nW5j
         dp25WuqiIGrQtCUePWIQDIf6/7zEXMCzz5WhuBl8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.84]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7QxL-1iuh1Q2445-017i9G; Sun, 31
 May 2020 23:18:17 +0200
Date:   Sat, 30 May 2020 10:00:54 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3 1/8] Introduce CMake support for configuring Git
In-Reply-To: <xmqqpnakw02x.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2005300957140.56@tvgsbejvaqbjf.bet>
References: <pull.614.v2.git.1589302254.gitgitgadget@gmail.com> <pull.614.v3.git.1590759624.gitgitgadget@gmail.com> <09c972de52b35b14a4c6f44b10c3dfc1732b2c7a.1590759624.git.gitgitgadget@gmail.com> <xmqqy2pay216.fsf@gitster.c.googlers.com>
 <CAKiG+9WWqHJNz_fEaQ+Rw3sRJSFOutCt772v1mbZeOS2rWpDOA@mail.gmail.com> <xmqqpnakw02x.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DULQ9fzonc0POhCjBscefh8+8Cdmkc2Il5oEYOX/eV3lOTTszrz
 ANgrb1HfbK5kHY04/ymHyooGyVfBXchFCxSJE48lBe7xiWVHq85grxOEbq+hqMKFbKxaxfy
 KqKLRRyIKX1EOisyPIFfULJgtcF/STDte9cfO4Qkm0xzIyZLzCEtiLezJpklOEjS6tamXVX
 Lc1qDII9YUTMfQ5RY0Cog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iz8i8LagSec=:i+ZepRvQNrRQpBNHRbVqOa
 ikgUJPJmT0sa+1wPniMY5GXDE+srtrV1YFVhQ3Nh4Nxbc431mAldYMy5NlY5g7zF1JF7iUIb3
 FyRRwInEy/TyZA75abxynrWIEt6j8wW6KsR+s55mGQTbg/CSF/Ghs03YOhgoHgkqhAufcBQEt
 OvmynlOHdxCmb7kahQYGFy41v8ydbzzpTtz79ZLTP9n+aHg+9y5KFnct5L4+zMuZ+qdsuaMhu
 DtsenAXFbcKr+QId8B4cMmGS6uXk5qRgKNLD2uTEQTENi19Rf7YY7ESBC4gIxLpCcIY6QgGjI
 ApbecMNXCk5OhPUzXZclV9e4q7bYTX5xNkIUucQb4hNcr8JpDzeqV70hcXMPYGssWWx0/lv/F
 JJdZDU1z9y51LDIebrTqRv2lH1HpsyHk+afeTHsRattMR/5TRPbAERJVSSwwGlOO7aHwzkh8d
 VCXiv6RfjubyXc0soSJq8HZK3FtBQYE2Gh86PVX8oxKbXDeLYEFIeQjsCsHzhxE7UoAX/WEK6
 /GCRDtP/WtmlgIGPNu+hd7GPGikmHnCRNxTqFKzzzyhiRYhmDglqygTeq9oPKDLY2QfxLrqnX
 uTsBMSjwABHSpopl9AzScdMICcneA1V4Kcp7p61Guf+8cFKkuSDXH1aGfYb8siBw9jh67OP+2
 qtNc1LdtISahmtntp7ANESvtE1fdMcpBaqLof1eTIK4q/MacUimgsucC57H6kwAPBTH+P2cwS
 mjY+KBsDkvIM9VCKkUF3xdwJWeKE+6YgJpTUN60l3JJ2JsrPBGIDWGUc6DKWQAQZj4IY+LRoq
 VF+vA4FWKyGZO7m6zz/8uaUrtXyFZQg6v6l0QM/K1DL04T+spGLgrcZOF4IPM/Mu6mGX0YePI
 rZYMHQRkwFaL22HXYE7OxBYxQvEBvvoZdfZReC+NVv2pdbfpHe2ZW2qD2f+vH+rbTI7n1ROY3
 9psGwiIiSmDzBdschFuN7zze+FTDw7FqcmAelf56fYs+ZXrIUDNIJeui3drLj4klWBZ9yDJzn
 t9CuvqbZNcQewWB7gXDYPR00GSbbQTkDWeHxfTWRxFhOYd4FJYozpaeWA39K7ybbgjWRBtyOL
 jpo27JyrsqcDIOa2SBpHkrpPJkJKxypDUYTzIpqbcoi2midfNKLwLxh2KIPX9Iw7HbNP0eSd0
 tlIaNUx3vnC2ZPORlzNVzHaq1iYatHYqdqXZY3AB+gZsuLK1pJLap+j449rP9AF3e6kgpnOPN
 apUWwOuU2HlFe2ndM
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, 31 May 2020, Junio C Hamano wrote:

> Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
>
> > On Sat, May 30, 2020 at 12:57 AM Junio C Hamano <gitster@pobox.com> wr=
ote:
> >> ...
> >> Everything after the "Changes" line does not belong to the commit
> >> log, as it is no use for those who read "git log" output and
> >> encounter the "first" attempt to add CMake support there.  There is
> >> no need to tell them that you did things differently from this
> >> version in the past, as they simply do not know what you did in the
> >> previous iterations, nor particularly care about them.
> >>
> >> These *do* help reviewers who saw previous iterations, and the space
> >> after the three-dash line below is the right/recommended place for
> >> them.
> >>
> >> The above applies to other patches in this series.
> >
> > Do you mean this line '---' below?
>
> Yes.
>
> > If so how do I place the changelog below them?
> > I just do `/submit` at gigitgadet/git.
>
> Sorry, I don't use GGG, so the question needs to be redirected to
> those who do and enhance (Dscho cc'ed).

There is currently no support for that in GitGitGadget.

The idea was to put such commentary into the cover letter, usually by
editing the first PR comment and appending the additional information
before `/submit`ing.

IIRC some support was added to `format-patch` to potentially pick up
comments via notes to be added after the `---` line. So it should not be
all too hard, I simply cannot afford the time for that right now (but I'd
of course be glad to review/accept PRs at
https://github.com/gitgitgadget/gitgitgadget).

Ciao,
Dscho

> >> > Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> >> > ---
>
> Here is what I meant, but another place that is suitable to describe
> differences from previous rounds is the cover letter.  If the split
> of tasks between steps in a multi-patch series hasn't changed from
> the previous round, it makes it easier to review if the changes
> since the last round for each individual step is described in the
> message itself, like you did.  It just needs to be done outside the
> log message.
>
> Thanks.
>
