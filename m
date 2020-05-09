Return-Path: <SRS0=Fs4s=6X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519D4C47254
	for <git@archiver.kernel.org>; Sat,  9 May 2020 11:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EF922072F
	for <git@archiver.kernel.org>; Sat,  9 May 2020 11:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VPPwA/4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEILfh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 May 2020 07:35:37 -0400
Received: from mout.gmx.net ([212.227.17.20]:43333 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgEILfg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 May 2020 07:35:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589024130;
        bh=XmasUiuDzq+bTIDehfzWA8niBSNabemATrCLNq+rV7k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VPPwA/4hiB0PvpH3Si5SbjYj6t0jFVQRt2qdKO7bNVMic9v+HjNT1v7ek5Z1+T46r
         LFvNdida4HoYJeI1p3Xbh41a+0op7KSs8nrlSWoSb7S/R6kGagYcWHiaxGz8Zn/wqB
         IkCJqX1l4WazU7B+iaeWYIs2Xtskgpt+728bhHCo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([213.196.212.13]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1iryg33DpW-00fVdy; Sat, 09
 May 2020 13:35:29 +0200
Date:   Sat, 9 May 2020 09:16:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: invalid tree and commit object
In-Reply-To: <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
Message-ID: <nycvar.QRO.7.76.6.2005090915020.56@tvgsbejvaqbjf.bet>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com> <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-213114347-1589008561=:56"
X-Provags-ID: V03:K1:D4qKXhGI5ipN90O9LajKsQPjyTDpoll7cyk8FTGtExTvulH6iL0
 gs/M/Vx1knOFOi1aU4TAnpnu3WQRbkrY4w0hfOV98+JMaX+uE58cY6Q1fLe7EkJkQIEOjS0
 o4g2qTIMKiLIQVz0DuXW8e4gTD9IHwMPeF8oKO4sZwhM93SXKxTYa9L/QjcI9sgOcLBBkbR
 e3gKBpeC6kCaEiAKUfBRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KzHMMGk2Mjo=:0+NBCzv6oDu4dZnRuxAEJB
 7Hc1S4aBbqwCRm5Hu+SMVeldb6QikBliNnFrMZUEh+FQ0D0jpuPWqvydnWSE8t7RdpqtvdNn6
 Zm4Knak6IOybJoIUfyw98eMLTYKfNaeo8J3OOiWH/6xQRhVto4y3isL2xWA9Homzt+kHFedtS
 cyTp6Hl2bgp2+MHvUvpa5SJSTZYz6g+k8gIRGkSRp/4fBq6WXhZ4QfkCeQTHASdW99G++g7A+
 yjz0h69TCrkX6o+Osg/eTrC8oL0JqQBrNOdK5OZHoE3xDcA8I6WlzyJv/xr25PSeMBiiZLWgc
 zIYDbJbIce4dWceC8o2tm5zemlCQq42MmDINC74KXtrgMwlEIdpW3GgA1U9mzblg/l5iK1EIS
 A13ZYnvq8oYodVM3eX+5LOoSTl/MiN7Grr4nN4mvcU56F/JWElnSxL4Etr8ina8Jop2eGYKH1
 Z6URaQTb15xJUDM+ZPCNjSQYAW2xrh+OdgrjXL6MWApCc09MNH7WuPsXs2aB1pbJT6/OFnRg0
 dmnj1Oie8gZp29kzc5h2YkT5lHP8H5B2x15E8ebmKZbZJYPelZXHUHTd1WuFD1y8nBfQPWqkX
 r16XMFcfK6fVYZHRthdZU9EdkflWkwstBHx+dyYTo+Foh1oUTC/aF3/mDADDvW0n2r653YbzI
 +gTdGnHelvfsUod5SmARQwHVDuTuWznPwPtysS5jmpZk97l5RDgZggEigtNK9fjeVUMBeQCbi
 zOmkkWfXU5Vz/5cxkqSS9kZqahp2Uf3PgAU9xVraAq8mRhCKQTqI/Y7RNPDNWfNRlbqdlGYBR
 5fg0YEIwxxn8ftwboNQ/T0nW0I0ZCKaRKnF9WVCtOneXLW3yARfwxhQONw+f3Ek2X4rYBR7xQ
 d8o5Ub+bcJB7i9JhGK+Iuww4KYtAN29FV6n3eDH0j0ctn6Nlq3OdZNFmHM1EMCvzMM0PeZYtr
 tD6yGuvsxZEgtzrVIh1zNl4/NzM6eQf5aw5CwEmVVd31O1QDHzio1196uakZLE4pEZgOeb7sx
 uFAW6UQJuBghRGIY8NOz2xDaK3Sn5pXvqIN9kJxyv2jmrHa8uZcOD5dX2hYLLdCRNvWbDv9t8
 /TPJfn2ez4pbivz3JwSsG7eLQ+eFTtpWG7RKd67h5XjqPyzRrxYEjWy7h0/RiafabbSoZhJT+
 Db0GcDS2errD93vIligntbx5/w1N5nhg4kL8mBlNjeQWvCSKIaBJepbifUOiz6TnFSMtxN+/z
 CqHE2+/ddL7PHQs6x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-213114347-1589008561=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, 9 May 2020, Ren=C3=A9 Scharfe wrote:

> Am 09.05.20 um 08:19 schrieb Brandon Williams:
> > Here's the setup:
> >     tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
> >     tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6
> >     blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689
> >
> >     $ git ls-tree c63d067eaeed0cbc68b7e4fdf40d267c6b152fe8
> >     100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello
> >     100644 blob 5e1c309dae7f45e0f39b1bf3ac3cd9db12e7d689    hello.c
> >     040000 tree 6241ab2a5314798183b5c4ee8a7b0ccd12c651e6    hello
>
> > Am I correct in assuming that this object is indeed invalid and should=
 be
> > rejected by fsck?
>
> I'd say yes twice -- what good is a tree that you can't check out becaus=
e
> it contains a d/f conflict?
>
> So I got curious if such trees might be in popular repos, wrote the patc=
h
> below and checked around a bit, but couldn't find any.
>
> Is there a smarter way to check for duplicates?  One that doesn't need
> allocations?  Perhaps by having a version of tree_entry_extract() that
> seeks backwards somehow?

Maybe we should verify that the entries are sorted? That would not need
any allocation, and it could even use the return value of the same
comparison we already perform to check for duplicates.

Ciao,
Dscho

--8323328-213114347-1589008561=:56--
