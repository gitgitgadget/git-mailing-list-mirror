Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37AEC2D0DB
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF50E206F0
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 15:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ONCv7vTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgA3PMY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:12:24 -0500
Received: from mout.gmx.net ([212.227.17.22]:32985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA3PMY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jan 2020 10:12:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580397142;
        bh=5A5EbvUNLA1YExAUPjyPMN9JnzrckDg2BgeX24nFTQw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ONCv7vTLscdqI5XgxkDa2UYG2q75gsqURJXMVpLLCsXEnexmL5gL5VScDBu70NEOj
         qpGPAi/OeFuoO4MXJzM61/rwIxVTzzlzanZNMeon23rQPwZBw1CNT/jpfmvt5S/q4D
         b2MkL3j63HHyZm/HDs4ahgC3MPV+vFVD5wcsJTCQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fii-1jh9Li1aci-011zup; Thu, 30
 Jan 2020 16:12:22 +0100
Date:   Thu, 30 Jan 2020 16:12:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [Outreachy][PATCH 00/29] Finish converting git bisect to C part
 1
In-Reply-To: <CAP8UFD0W=kBs1zne56OjPbFzeX7BtEazPh2MW1My3qAsByS=nA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001301605110.46@tvgsbejvaqbjf.bet>
References: <20200120143800.900-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet> <CAP8UFD0W=kBs1zne56OjPbFzeX7BtEazPh2MW1My3qAsByS=nA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Ldt+WsjV/tdmvvqIVpNy00KGBz9Kb7b6PpdkGUBfbRDI78RmRnp
 OTc5UqX0cIMDO4oD9c0haj74DeHa6PHWZn+51fjMfIy1nATlfNCYWamQ7OPlJ7UZUljQQ9W
 EOnPNXtKYYrOHm9nLe44YW55aRrCc5cxnMEs0cNphMels9YVjP17qkq2SGFAHswDTVPhF5Q
 0TVQo3x9Bv83leosVv38g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XDYY4PizLMA=:Ssx4ai1GaeUuAq+MnKmqOA
 KYEegCQJ/hOubGRx3r+4Ygfcf/fE+6xF8T7ecPE4iv5hNCca1BbqqkUOAQ6/5spXZi0E5PRpw
 fZSOBkJf+JnA3MafqCb8Xg+oT82XhgkhXQym/v3/QCj5OMPmxG2lCI+/ZlbKhwP9xguN/9dz/
 fojfyzLESzJu0PoJnz7P+xBQu6xsTfVWPEHTDVfItHmxbQEld2S9Fv5O+ZYoU0q0EulaEyBO6
 TsQy1dxjhswyyWbwn4dR3vib8T+8hfYzzPPScW66TnEFKDaoe1L6+XId+eL3/o8JyJh0ghBM5
 j9tDTR+cOhWjv9zqXH+EientCxwan2ZT0ktqCziZy6zQMVRDZy1up0BSQVpnG64nUyUZQ0VUz
 fAhzFuplREEofC/V0K0lztPfKnFq2Coz/r9c9EJe0dRcAZsBUx2oXqdnZVmRhriG5k13QV0y0
 Xhwb5SEfNBPIyOekPV7QQoO3fTfExr4nIDSeXJ5Car5bzi6ALlxaEsqo4G5wLZqQFC2AqzmxZ
 JtZI6n7X0MbToKWmo+UFtMla+3oQfpRp2fGU65WjkyW8UZ0zUB1tK1DVQDdm7uKpokZoza4kX
 e3Y/YNt7pcf5d+rfm6nE9S3TlUKmyi7QhS6Z22U6w4Rk2Bm8iWoEIAni+XA2pXQcA8OxQXvZ2
 G7AwR7zf85NsZBqZJNZZ0YhyzBmf0yTe/YS8/ETiYnwPtnBQzBYYzukjBGvLygCw3/HS8jCBW
 CWOO/ACZQ+ZmiJ2/Qs1F0dFHwmmBLWSOU2FG+lZ42fq4ba9ssJAHgWbFAEzZ7lWdznlyfKA/2
 c8tXnmVSaNA2uaY4Uuf3vJU9VmzvmfAUK+g5r8W3x5fk4eOAfY1d7A2ZCD4bxgbYpu050r7gI
 p6OpKYWVaA8/0cZqnutj6M0txlTFXIAtkYNTeCGJwBlBeDJo9mwkd9OX/CpfIv68u38LMENFh
 ygAY3LW3kZJ58WQnYf58E1/I4OXHtlcgXIN7pofa2zt+W5Gps+HaIccXEUEmTZIHEQrd3Tu74
 FT38lGQYkl0yK4vrOr9piLkDCBzJ4Ta93Z6tmBjvcS9WyLc0V3aTVd/JzIi+T+ImZV1nzDS6A
 j8rcuxj04NQjVsWDbDOKRkw8rgw6IZq4v1dVHTJ35T4b5AzolgKOp98OluIPaIbft7Wqhb2mq
 DDmQQ2A3TadyxVR9D8Emhjd27+/F6FRaRekhLAqLOGjRMLICaiY32OrEhCaWZA89n5olaFbVB
 aeeJZWsGs10p3gIEw
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Tue, 21 Jan 2020, Christian Couder wrote:

> On Mon, Jan 20, 2020 at 10:43 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > > [1/29] bisect--helper: convert `vocab_*` char pointers to char array=
s
> > >
> > > * New patch to convert `vocab_bad` and `vocab_good` char pointers
> > > to char arrays
> >
> > 29 patches is _a lot_ to review. I would have preferred a series of
> > smaller patch series.
>
> Yeah, it's possible to split it into smaller patch series. There are a
> many similar patches in the series so it was easier to work on
> everything together to make similar and consistent changes to all the
> patches at once.
>
> > For example, the first three patches would have made for a fine "some
> > cleanups" patch series, from my point of view.
>
> Yeah, but this might then be rejected by Junio as it would be only "code
> churn".

I don't think so. We have ample "prior art" where a patch series came with
a wonderful cover letter that explained why such a cleanup prepares for a
later patch series rather than being code churn.

In general, it appears to me that cleanups are much appreciated over here
rather than discouraged.

I also have to admit that I can justify _a lot better_ to set aside time
for reviewing a tiny patch series consisting of three or so pure cleanups
on one day, and then a now-smaller patch series to libify `bisect.c` on
another day. Much easier to justify than trying to find the time to read
through one honking 29-strong patch series, where realistically I have to
re-read all of the patches upon the next iteration because I filled my
brain with so many other things in the meantime.

I think that it would be good mentor advice to pass along: not only the
commits are ideally so small as to be _trivial_ to review, also the patch
series should be structured in such a way. The scarce resource is the
reviewer time, after all.

> > Also, as the mail's subject says "part 1", it would be good to have an
> > overview how this part fits into the overall story of converting `git
> > bisect` into a built-in.
>
> We don't know how the rest will be split yet. Hopefully there will be
> only one other smaller patch series after this one.

That is a wonderful contradiction: first you say that you cannot know, and
then you state that there will be only one patch series after this ;-)

Seriously again, nobody will hold you to a statement like "this is the
first of three patch series" when you later explain "originally, I
intended this patch series to be the final one, but decided to split it
even further, to make it easier on reviewers" or some such.

But done is done, v2 was a nice read.

Ciao,
Dscho
