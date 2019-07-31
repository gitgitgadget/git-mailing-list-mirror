Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E98331F732
	for <e@80x24.org>; Wed, 31 Jul 2019 19:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfGaTmQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 15:42:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:42183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727276AbfGaTmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 15:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564602128;
        bh=dHlV7dnKJ6o1ChF2fAjvvCZD5oJJ9DTUP0hej/EM60Q=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZeuUykKRU1OOKkBEOFAtgErU8VBL54fmPXcX4M/I1orE7xlGz3naWXNp0wsvmEBg9
         467Jiscn3iPjS2XhPShPK4UWrJ14tpzGvcxcoQ9sLHabdXejI+oOtitDeAWoiY4qkS
         3CyTww1nHaBI4J2l2yZsW1RQ6hRSwbu8zrGaus6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7iCg-1iO28A3Br8-014lVT; Wed, 31
 Jul 2019 21:42:08 +0200
Date:   Wed, 31 Jul 2019 21:42:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratyush Yadav <me@yadavpratyush.com>
cc:     Mark Levedahl <mlevedahl@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] git-gui: Perform rescan on window focus-in
In-Reply-To: <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
Message-ID: <nycvar.QRO.7.76.6.1907312132190.21907@tvgsbejvaqbjf.bet>
References: <20190728151726.9188-1-me@yadavpratyush.com> <20190728213634.GB162590@genre.crustytoothpaste.net> <e3f296a6-f33b-7b52-c4cb-9acf65145e64@yadavpratyush.com> <20190728224943.GC162590@genre.crustytoothpaste.net> <724fb243-c660-ae04-1b2f-caf34794b799@gmail.com>
 <005d7946-3fbf-9c06-21fb-51f10d06f33e@yadavpratyush.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:kyWKJhLkecOkjzFl2CtKhsKpAMrp3D+URaXL/NGbB/vk817xsWz
 LJ3uF+nr2n32c6w6wMh3Y+JYjZuwK9OCpEhSh8By7KzRoNflPsQ5vEcc7ubxWKGCt8bK234
 QMnvwVpK0ESVcCYVxoxkwp1rHWUWt2EU/tmpUjpEpswHPq9gE8ucdq8ICNGxNS/sz4ZZV1C
 TyQp++G749QjqXcG3a4ZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AeZ9SEggACM=:JxzQQlAxVgSlsyJv3N/smj
 ninh8tD5gpUYVemuzug24o/tD6cAGkrcMdV4lx2L//8Nahc18VZLaw5BrgcslckXPyKYCGBoz
 68ziKzUIBx7EnYV485KzYCs5e+cqihbfB3QRMvPlWgGEmfmhUgpyaJTBoMVrogPVzNVTMhvpT
 G7SainQwTaCKjP2LkqvrDcE7oYi3m0qhbkn3s4gUzpF5Mzaa7pIfDIV5nsL2KrZBK9KjJ4YJe
 QRJGH6SPlWzH0Jizla32pcpbU0qaiWbS4Hhym9MnNQaP8Zg7L+3Zo7vwrmmS/vSQpFTeANV0K
 e0hMRxZRfyupR9/z8h1CLYDr6ZvXhw/TdXvsPXbiQ4Ovl7XjqEheaEiRAzgbamAJ0D5bMTEKe
 k1I9w7iXZzKheHdkJIYKu7lzpRgnBD4GiZnHLuwQnQ2Z87Vp3qH8vQSZtfwMVAg7c1PBEYRb/
 c8eIumb988HDsDEf1/L0D71WEVFDpnVLKJSjWsFF7QlClN7T2Wv+kkdDkjyMmhCom9f+ikQUE
 mSIcA0FS5Irx+rtO0RVOMMG3YOHMbZyrA5YcJUZXX9TYjK2W+vtkKCESWnMkB/a20PZ4a88er
 XduDuOROgT/7SQlXuIiKHQX51pgAPbO7M0cYriWtza6oaRxIDfxcZznfCtRhNB2Ltg+EOBum+
 yl/OKQ9VSf7vpDTPWBunqFBA/UX0tXQQ4meS13j5Oyzu6eCrmT7REJYaXwe5Xqg80x+Cnv05x
 LG2zwYCrLxelajK8+eikXmXbgdUl0JaKcUCHUuWo0GXpDcAO165spL7Ruwt+bcOqL247RAYKN
 NbY5aZp/7lL61nQppSidJoeNERsCqESynqK9vZ6INnAqtNhE/eUPg8Uq+cJCHjL26nsEzU9kX
 NrOoQdIjAk/+r1w/EDDnybOXUGmgJBj5/oIeHL0HIgaJ6D1MNE4GRDTKokIKmEIKt+MbNAXLb
 Dq0CBleWagHuNgH1dd80BCo16I1hnTDDxItHIvrlYzpl56SkzcilP810TsgjIvnlfxKF0qPz0
 KvT8AFvddfk7hLs8jWVGoSUweX0Vqv4xlUsaFvlyb5ubjgYI0ZMqsti/bU/5gSJgvHhTkDpg0
 8eprBmQYlbQnltUACO9RtLOvlSZdXNi2tVX
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 29 Jul 2019, Pratyush Yadav wrote:

> On 29/07/19 7:58 AM, Mark Levedahl wrote:
> > On 7/28/19 6:49 PM, brian m. carlson wrote:> On 2019-07-28 at
> > 22:10:29, Pratyush Yadav wrote:
> > > > The function is not documented, and I only started spelunking
> > > > the code a couple days back, so I'll try to answer with what I
> > > > know. It might not be the full picture.
> > > >
> > > > Running git-gui --trace, these commands are executed during a resc=
an:
> > > >
> > > > /usr/lib/git-core/git-rev-parse --verify HEAD
> > > > /usr/lib/git-core/git-update-index -q --unmerged --ignore-missing =
--refresh
> > > >
> > >
> > > Great. This sounds like a well-reasoned change. I'll let other folks=
 who
> > > use git-gui more chime in to see what they think as well.
> > >
> >
> > I'm assuming this does what is currently done by F5.
> > A simple rescan from git-gui in the git repository takes about 8 secon=
ds on
> > my corporate laptop running Windows, making this happen on change of w=
indow
> > focus is definitely not a friendly change from my view point.
> >
>
> This is a Windows problem maybe? On my Linux machine with an almost dead=
 hard
> drive, it takes under 10ms to do a refresh on the git repository (which =
has
> about 56,000 commits).

I would be _extremely_ cautious to base an argument on one particular
setup, using on particular hardware with one particular OS and one
particular repository.

When it comes to repositories that are worked on actively, git.git is
not actually a representative example, it is way smaller than what users
deal with.

You might be one of those developers privileged enough to have a fast
computer. Trying to extrapolate from such a vantage point does the rest
of us Git users a big disservice.

At this point, I am gently inclined against the presented approach, in
particular given that even context menus reportedly trigger the re-scan
(which I suspect might actually be a Linux-only issue, as context menus
are top-level windows on X11, at least if I remember correctly, and I
also seem to remember that they are dependent windows on Aqua and Win32,
just to add yet another argument against overfitting considerations onto
a single, specific setup).

Ciao,
Johannes
