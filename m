Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B9F1F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 22:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJ3WRJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 18:17:09 -0400
Received: from mout.gmx.net ([212.227.15.19]:51135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbfJ3WRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 18:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572473821;
        bh=RhbDptg28xBBmEHdob90soe3WWE3HqQFJUkjyVl7IK4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W3Jubb+HK54cuG5/YpsXN65JWGAwYYwsYue3gplAFKdzo01tqtStVuyacgCHeoWGN
         Cfb+0bkP0iUrdv6BKQU4cI72+rwKd/z0KeDBSihLGzf30PiEaNPRqKpt3PDTtLze75
         EfVZAwunC9oST8KDbrq3dZnSXfsnvCZy3bnHb1lQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MysVs-1i3bvb2KN0-00vwPK; Wed, 30
 Oct 2019 23:17:01 +0100
Date:   Wed, 30 Oct 2019 23:16:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into
 the root directory
In-Reply-To: <CABPp-BHPRrbCs2qM8-zBaiL5pO3+9k5cbjtk3YVhy9_k1d7t+w@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910302315000.46@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com> <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet> <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet> <xmqqpnig8i0h.fsf@gitster-ct.c.googlers.com> <CABPp-BHPRrbCs2qM8-zBaiL5pO3+9k5cbjtk3YVhy9_k1d7t+w@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YeRvRZ1EdSYAN7RXX118wexFgIxlj5GLJJZZAgnrOF56anwszrA
 frap+TziKobrXOJ8FJmnNIYWfL/aweH7gRiTJK9B6gaiUxo2xTEG1S0nKzCFk5lh6XqwpYv
 XyzaWlbNTINhp9EpSe1JB2cncvHsO/hJwCVFbUWGmec3pvvrH4tCEVvf430g6hCVKsg/3+z
 jVixBYwb2eul/6J36pVsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4l6DNBGeBVM=:bWRu9/vw4Y+gF3dnWsHKaR
 8bxhTFAhEj5uVRiX5a4SnnoyaI3pbSbzxgp30F0LV5ACMC9rANneRiOdvyOKJ+8rGI0ss3a2r
 JFw17EsQXDgbWmEXz745WDRaFuggLshe8b5ecBXqEkjTaXeabebIVxc6Ir0x/qaB2b9GUbGRK
 8vH8ac1+2UOCFdTv7GeBwiwajKmlbTnFfVC4hJZgH1eCVuee87aJX5rXJVXhQVtX9n1o9mraT
 G/7LqMLmWJlboHknVMFVlrSinRQZVNljn7/pGe/XVDrJZQLrq1iltuI9VddkL9S4/EjnaHVio
 GKHP92y+din0YVyY3yVzAFR+73kUtgIQXkkc0XhBAmXZonpVOHXYb/rXLwuSImDU4kNyBSAjS
 j+3mj3jjXrUzudigX2XlWG82NfOfGc/UzPGzU1qH5+rafUKySh9tDSZhlXTNd1X2ZujqjD6FR
 1pw2cezAL4EKi0ZFLgXJfYPo17NJJbvOcKJRo6cwqet/KpLUIKEiGVNs2iHh9IthsOjltL/wM
 zpMHQuDa4FjL+d6oJX67tIuIsSA9FgJ67B/4o6vqP6p5NHdekaZC56M//vxNBD4fhPqh004on
 VpFtHzbrMVC8M5xBKRme1UXLnKNO1hjOwhyqGCgTvJDjwawNV2watXlPmoLZ4G9x1fbS8m6wY
 5WLuug8YJ7/nB0NhVHzYJdfGxPhe6n/C8t0yVZd8KaDqVDNt1oUhc+J1JplyjmkhWo8ScbbeT
 /tYnFHo7W1EFWAY/eIrU5/JLVIVWPYx5+M9JKdNTg7iRt4lR4LB6TOB317U8YzCWJxni6u9Eb
 BXRshvOmawAzn18hPfXbWajZYvXZiwSuBqBNRfB0/J19MHAVH725RGdOx+1o/9JORLd++zZAE
 O9ByX7HeEdwmoVBXFXqp7E1nPeYpAAaxVaUfSs9ydAs4Oyof6J6uErOqKvokwiCDW3ltuwJ+/
 Tl7HBGQC+kY3fsJ1/a/2RvelGVwHC9dDFcq8bZA3ef0tj8pZZFAA14XD3LSzg0khI0FN6XaiW
 ClWXRHNlJwFro5Rk+oUN6WbjvUgUMUxai6ONhFGKpjeVNbqNny5CRQkAFAqj/23OCSe4O1jnB
 +Xj4JxkuVb3iSHAhtbNTE4JSPDdX/llrPWzOzOEvSr8yZBsZyUbQE1Em88d0T4yZpw6LROZt6
 0Aj0JmoNCPcLHaeeivLZYDvGLaDXVLYcXBSKCv/ws8VJBK5zKJ0BamzRAtVb+YsSqvly4YS1J
 QvoJWJFXBaBsJV4R3Hd9Wm85HtQi5OHCWz67LxghU8JZCj8xh51ioshxu39g=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 30 Oct 2019, Elijah Newren wrote:

> On Mon, Oct 28, 2019 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> >
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > >> Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 for
> > >> sanity in the face of refactoring and rewriting -- and as mentioned
> > >> before they have caught refactoring bugs in those areas that appear=
 at
> > >> first blush as "overzealous", ...
> > >
> > > One idea would be to try to guard those extra careful tests behind t=
he
> > > `EXPENSIVE` prereq.
> >
> > Yeah, I like that---I think it is perfectly in line with the spirit
> > of EXPENSIVE, too.
>
> Or perhaps EXPENSIVE_ON_WINDOWS, since it's actually pretty cheap on
> linux and not that bad on Mac

Why the complexity? If you separate out the expensive tests (even if
they are only expensive in terms of run time on Windows), it will make
the regression tests so much more readable to the occasional reader
(making them less expensive in terms of reading time...).

> However, if we're going down that route, perhaps t9001-send-email.sh
> could be wrapped in an EXPENSIVE prerequisite?  That single test file
> takes an inordinate percentage of overall runtime.  One one box with a
> few extra cpus, that test both starts first and finishes last...and
> it's not far from that on even normal boxes.

I would be okay with that.

No, let me try that again. I would be _totally_ okay with that.

Ciao,
Dscho
