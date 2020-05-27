Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A27C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB4DC2078C
	for <git@archiver.kernel.org>; Wed, 27 May 2020 21:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fgzYnhNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgE0VWa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 17:22:30 -0400
Received: from mout.gmx.net ([212.227.15.19]:46475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728475AbgE0VWa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 17:22:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590614532;
        bh=LbnLro2zAtOnLWbW3pRTuAsIg18qjqUsPyf++S5ow5Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fgzYnhNNp2ev9SLaBBN0l+uPgOed8WvEhA5o4VDENKkpK7RO9z8rKy+Tq0cUZZRnf
         /IVrOxacZqqvn1LtSdOvlFnYywd2hMTWPyo5GQXQXi/2vLFq9QajTaw0SDvVYhYPFJ
         LicV3fs959Z7LKZVqAXrrdkgHa8BdZbyauE5HPok=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([89.1.214.52]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4QwW-1iuEuw0Td0-011PWU; Wed, 27
 May 2020 23:22:12 +0200
Date:   Wed, 27 May 2020 06:48:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Merlin_B=C3=BCge?= <toni@bluenox07.de>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Question about behaviour of git-checkout --patch option
In-Reply-To: <20200527123234.737efc3f.toni@bluenox07.de>
Message-ID: <nycvar.QRO.7.76.6.2005270646550.56@tvgsbejvaqbjf.bet>
References: <20200525221100.31d36d4d.toni@bluenox07.de>        <20200527075648.GA4006373@coredump.intra.peff.net>        <20200527080009.GB4006373@coredump.intra.peff.net> <20200527123234.737efc3f.toni@bluenox07.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-970195157-1590554910=:56"
X-Provags-ID: V03:K1:/8XUf97jqLudwDp5wXrJkYDd8QxHKT790CV3mxJMCXPmWsPO65O
 zk2eVnDEMG0csV9UNd5VQ2AqPouhSdqxzXAnnC67VLEoctdhfI8uopTtl9PRnKUMI0WtEvp
 erH6Q1wEgdqcAA8U6OgVo7+6tWlLXHKcKEM70h2fkxeWPjiZjYc4abeMt4Ii6A8dTO8x9px
 Kf2usr3CfHtQNwGSSJYEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:A53unIhMQYQ=:FDXN1wJnKq7igflIe90SAs
 jG/CuoBd1Ac5ILAQZxHxpLlmmOVS7NPiN/gwSTwBwlJHschhYQU4GJZeKbcLu2dBI5b8etkT5
 Fvkl9J1n8uMIk1uOBwmIx76lJPedonTxeuGNaBHMFFO4WmWclHAizCEeIgev94KYduBjbANIU
 FCdln0iqgOsyFapyxhiRzl5NBqw/8RYWQFiNZ5zwaEZkzPf57Oql88DalC55OYNxf+AueL3BA
 M/ZSj04xCeBUyxRdgssRbr167wzlaKqk2DKl10w8t5zvdIq3N2t3aG66pI36V90X/uXNCl9Pe
 prpzuzlRnu5od2Wq+Ywz5TZHuK4uAFN7cu9XyvObKRU31QouM+kPvNypte91ZK6SQPD6gjdkH
 iUB7Kvd5QKU9S3GMWl5QtftHeCg3geD9/RNJRvbfb2RuEiVrf3WQWakuh7lYMxB8D4Bwo7w7n
 IVOMg4OHXIuF9bDYa+NDG3c1FIXcMlyjxHAH5H3do16jBryewyLrYrATwQ03vlKTerO/Dz5ss
 9hFmwjo0z5MQclSef7tmkYRWw7M52x9VUnwGRLuAmq45dTQ3Z7f6bPLpah+YqYYoUVWazcI28
 rDtpZYHg8Wve+6p5ss8Q61T/XPNrdTAWCLvZZFRPBkY/mBcMeeS/kLuaHTEF0C/JHdu+swtYS
 7Pz0C3S93dFTMS082DCAQ+9eXq8zgfYrKIoHytAEC9vo2pa5swpdOgwj2pb29xhZo/EgzdB8p
 WwKU6ftChtR8kP3zo0FW2kosUyC++gcCnOj3bOuQx9fZXlNaJ8QsWeXYcVLLJz8jxKyTXccys
 XZOwmgD74wbzV5iXotyz/0llMEcj0v6ei11hzdmkIjfVNtGPMHtnTSRiPzSzq0BXaRJll7/il
 mezMDoV0bJU1xzd00rMUei/1UMqkjgDAK4TdqsuWksyWn4cPK7zw/vj3jLIvAhgnBYN498WeR
 pDon0JQIZyFsSV5jQgo1BW931XQo3CWhjmc5ohTmQzlICN9f4Nwcc77si1zR4fQ6gPx8vDXpl
 KZnkMM4ie3m0MT8PKlFLkFZ3Aa/SUO5pQYsNQG7sKfBgNZjPxkLyeDnLtXT51lF5CjhsqMzWU
 SEeFR4YY7mJiZFzhzcIbKhMaDpY8mOT3IfGinE6XqspMkq4L9pywEqDEmxQP0z0ZnXk+npDLK
 AlUsLkVTBaTB5X8wwkV/wwzc9jO0odsfEX9tR7C059a+PTEC1E53D/tfn3QvE+LBppQq5u4a6
 H8qBsuBkZh4t4ATYt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-970195157-1590554910=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Merlin,

On Wed, 27 May 2020, Merlin B=C3=BCge wrote:

> On Wed, 27 May 2020 04:00:09 -0400
> Jeff King <peff@peff.net> wrote:
>
> > Trying your case with:
> >
> >   git -c add.interactive.usebuiltin=3Dtrue checkout -p master .
> >
> > shows that it does not list the added file at all. I suspect the form =
of
> > the fix will be similar, but it may have to plumb through the file
> > addition from the diff layer, as well.
>
> Thanks a lot for your explanation! Good to know what's going on there.
>
> Out of curiosity: How does the git community keep track of open bugs?
> On https://git-scm.com/ I read that bug reports should be just send to
> the mailing list. But if they are not fixed within a few days, wouldn't
> they just get lost...?

There is not really any centralized way to keep track of open bugs.

And yes, sometimes they get lost after a few days.

In your case, however, there is now
https://lore.kernel.org/git/pull.646.git.1590613746507.gitgitgadget@gmail.=
com/T/#u
which is better than just a ticket: it is already a patch.

Ciao,
Johannes

--8323328-970195157-1590554910=:56--
