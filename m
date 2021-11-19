Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D405C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AA35611C7
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbhKSQe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 11:34:29 -0500
Received: from mout.gmx.net ([212.227.15.19]:32831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232663AbhKSQe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 11:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637339485;
        bh=eHcPbDj81PbM7u3v7qj2hekTlQQujsI9ZMABkRWGNCc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QnYBO4cGOCzQEOPG99ZRZLvgXBzIwthrs2kg33V/GSD7kq3vYAsTt7MTgQEMhbvHl
         LmFnbnlV3VpJGIXA1PS0GfUj1QPATXcBVkT50nblDHtQbpR340SZi4oSujHB4MdNjX
         7WS+TYxpOiutzmTO5B6zZqwh1eNnMZ/24lj53yw4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([213.196.212.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1mRbvZ44SP-00vcMA; Fri, 19
 Nov 2021 17:31:25 +0100
Date:   Fri, 19 Nov 2021 17:31:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Chris Torek <chris.torek@gmail.com>
cc:     Jan Kara <jack@suse.cz>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 01/27] bisect: Fixup test rev-list-bisect/02
In-Reply-To: <CAPx1GvdKuBmxN0XM3PKJO+0V=P3OoyB4VDzmqshv7N+3vFF8gw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111191653390.63@tvgsbejvaqbjf.bet>
References: <20211118164940.8818-1-jack@suse.cz> <20211118164940.8818-2-jack@suse.cz> <CAPx1GvdKuBmxN0XM3PKJO+0V=P3OoyB4VDzmqshv7N+3vFF8gw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Mp/faHIPm/2MHkJP0m2p4D9EnvKiI8UjGka92prxfb4W3xsF0jj
 4j/xmsVd2TS030Rz/e4W0Mp6V02uL/405EyTFR6H2L7/mcsP5jXQp3kLJu5X3UOogNQGZFp
 xABVyIbpYzZwK2bkYV0hCnMizgUfpNCFmQ3AJ/59A4df9ZNM87qsNAeDsntMx+UTA24AA3V
 dI3a5HcdtFQdee7MpgaNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+iL85bt/h30=:TVpzyczJ5szdMErqIv5Acu
 o3SeYHITQLFxd+wFSpSNefSdd7H9qdEO2mNnaUaPc3A75Vwa3f5nuRInFCHST8GNE+7twmdLR
 nvQ9hnVuOm6dBvLd9e+VbiQfMzlSrbTS6HRiL8GUtD52Ja9iqGBqrnki5wDzSzbnXU5rxfZcQ
 GSUkJRNxPNjvZZr66teRQExU2+aLIxvm/fOGol+cXqnxzqcqmJ5Xwn9QhXD87dGYDQAZPcRSW
 rMDmKcDDM6DHyRhYG6JTUOyQgRzsj4/Ate/G2JdMZfp0Q6cJyXUhfkkFGOAsLx2OQGMGAOid1
 36SendpJ+yRhTbYWCs7f1YbmKptw1ZYyHm67TR/Mw4HP7XtBts4wiM+KUGTEj9+8KiPHPIyc/
 BIXqMNOnCHuJjIX5G05zroUsAuIeS4udKS49cNIut2F1U03Nf6eJrGHCAgg/L0R8f530U66sy
 2PmfIOTOMCY3wY/eCF8Zxx9I10x4uFXHgWww/hDHXEohtlbTL4aNsLiD4ZBivIYx/6WBPMgJm
 mV+xtIDR9q0Nw1QZhOPJM8RybojCdSjkY5z1QszWDeqqCltedr1fdSp9rr496V6W8kMdaRBDQ
 EB48YPgU/mQba1A/g12gSVh53PtX+ylvE3MSDZ3WpJJB3uyiFvoBB6EIeHKmoQNCi2995HxJn
 zu+nK/Uhn5ny5DFK2NMhbVgIGmJm/W8kncsmwpbhrqa0s8s6aFq9lzxg+Q3+GSB8NwXb6AySM
 pHl35FYaouHK65743VZDTt5556MUTzNSSK7ZCrti4ecwvmMWsZ5NBoYtjVTlYCPZY2b7I6BAS
 oMyayLltRTYgER6IrpeyBoptKrAQWXt2u6udu8Haar8gYDFtTzYsHSolyw9fAo2iR7hKJQu6F
 BIfyeAr1bQmzKk2X5hScNdUzPxuJrXL9dLAXsJgAQIjmkInHHaffOhCYn0Yj+YA6J7XzpUMsG
 bAZGV+W6L3Qwpt2f72zJkR/lg1+NvM0B/lBDF4/aJr1egRLPQWVr6wRiK8nyKXFWcSiQF/ai1
 mYkM6j+k7JUIEx3Zpj8xAUhcO3Ecd2h2lQvgfKU7a6DXUmMjkR/y7ShDfi9/N/SWalyq3bRMD
 ydbGy/OCaghRoM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Nov 2021, Chris Torek wrote:

> On Thu, Nov 18, 2021 at 10:38 AM Jan Kara <jack@suse.cz> wrote:
> > diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> > index b95a0212adff..48db52447fd3 100755
> > --- a/t/t6002-rev-list-bisect.sh
> > +++ b/t/t6002-rev-list-bisect.sh
> > @@ -247,8 +247,9 @@ test_expect_success 'set up fake --bisect refs' '
> >  test_expect_success 'rev-list --bisect can default to good/bad refs' =
'
> >         # the only thing between c3 and c1 is c2
> >         git rev-parse c2 >expect &&
> > -       git rev-list --bisect >actual &&
> > -       test_cmp expect actual
> > +       git rev-parse b2 >>expect &&
> > +       actual=3D$(git rev-list --bisect) &&
> > +       grep &>/dev/null $actual expect
>
> `&>` is a bashism; you need `>/dev/null 2>&1` here for general portabili=
ty.

More importantly, why do you suppress the output in the first place? This
will make debugging breakages harder.

Let's just not redirect the output?

I do see a more structural problem here, though. Throughout the test
suite, it is our custom to generate files called `expect` with what we
consider the expected output, and then generate `actual` with the actual
output. We then compare the results and complain if they are not
identical.

With this patch, we break that paradigm. All of a sudden, `expect` is not
at all the expected output anymore, but a haystack in which we want to
find one thing.

And even after reading the commit message twice, I am unconvinced that b2
(whatever that is) might be an equally good choice. I become even more
doubtful about that statement when I look at the code comment at the
beginning of the test case:

	# the only thing between c3 and c1 is c2

So either this code comment is wrong, or the patch. And if the code
comment is wrong, I would like to know when it became wrong, and how, and
why it slipped through our review.

Ciao,
Dscho
