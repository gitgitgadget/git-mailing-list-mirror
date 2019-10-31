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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E60D1F4C0
	for <e@80x24.org>; Thu, 31 Oct 2019 08:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfJaI3M (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 04:29:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:41027 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfJaI3M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 04:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572510547;
        bh=BYvf1TXDGJguSGILCBzt/xx5vuC0qWEJKw8fvsAr1mY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=K5beXpgZLXx3A5iplXvUAD8fX0jYCVvyD4BVLM/YTDpyExhn3N5hQGpyXJdlUGjPR
         twKJzcuLpMaqNJsQL4u7iVqhaIoP5k9cjYDagj3hoDuj6NpF/41TLqZaIUTlmSZQY+
         0J+MDkFTOMT/HqA79VMuOAHbGXLTKWpKAJf3Us3g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1hqTpI1aOh-00aHkJ; Thu, 31
 Oct 2019 09:29:07 +0100
Date:   Thu, 31 Oct 2019 09:28:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into
 the root directory
In-Reply-To: <CABPp-BG1ir2kXkxMmNQ2btDKvpSWg9QwcUnoy_5teuNO=JhAFA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1910310927540.46@tvgsbejvaqbjf.bet>
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com> <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet> <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet> <xmqqpnig8i0h.fsf@gitster-ct.c.googlers.com> <CABPp-BHPRrbCs2qM8-zBaiL5pO3+9k5cbjtk3YVhy9_k1d7t+w@mail.gmail.com> <nycvar.QRO.7.76.6.1910302315000.46@tvgsbejvaqbjf.bet>
 <CABPp-BG1ir2kXkxMmNQ2btDKvpSWg9QwcUnoy_5teuNO=JhAFA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Px1u8hSUnLLscGK5997bR9X9ZMLwJNnrP6HBfnW3hEDJ5P8s5hK
 LDzPyLUIZMaUWzML6ttyAU09UHEDmz5E84XHgl1aGFAtqQPSQBvs2/PupMZyE42P4chOgb1
 4RmhXIuJwjQwKVjRS5+vqYTcuDvPW2rBp81GBA/RUSP9OmxPTBThi8P9Q8HmMKJ1QLA0vGI
 pPOTbabediBBOTz1hSv/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TE/nWeiisbM=:dzuiYfzkd6yfTmzOGGIrLb
 KiF8J2b62zoqxnyPXEdMBYDDWlsdqQpGYHgRB5RFKFc+9po7ckbMiNzu3s7S2+5ykXni0N0D3
 URkyMTTibui33g3UycsVeoOC1qZk6KyD/6lDs/jrUnpAfhGGWeP5yv3jzZsn1jWabO7nSPKEE
 kI2Gd0iUL2x6xaR60uZCqQxRbYrzyHAcsP5cznlSsa7ki8PoJILV5moJzLtZef5brTtgpfrS2
 +MBLEoosKJmciZtb0PwEEAUaZS8vHUq3EnS5qjRoL/IDKReg4WibO/T0y1DqBitgsvXrIAYju
 HhwdRkf/3Sl6ZMZGkjd2tWRzK0Yn0hPUbaENYzHTYSzXNnZt3gs768AXRxog5EFqx1Rde/KZa
 3tZzfX4Eth5IMl3wxh6XztMuy9d5jNBEZyc1vIjJoEuyB7IHNG8TaHxO51b6B3kx3cx4n3g+L
 QYPt9SRrRFJnCzUmSCpfKZz4n9paAmLQILkBZuUh+fJva3U9lL8yivkqSkpui6jJHzYtDhPm7
 n5DSj0e6fYF3GzGoIArt2YUmewx9UPhWonQqcdIMQsZTTP3ErwDADRhNyUt+ZFVZJM5EHHDPG
 9cL4a38i83nbkSPuoa7xAwhKHBI4K3MKiGs/S9dY8xEkmKQyeBbydMfK5ie9Z0tsKqPR7j4GW
 RzuWiEdXCfIylwHSG6Fe1QmYgfMZI04zD0Ubi3r4tK2NTcaLSqs8+d/0xEmQfmXY8e4Q9Ai+i
 npS9soKlBXnG+QsF5S+SF32we/wl2rA38Ko+BemlS1FmHC+GT45OfYed4S+BQ2oLhcYbHrFao
 Aja5QrS2BjuT2RojT9xSzmW/PPFXVg2dwYOsXuVrdghJ/AGEHq6Ss0kIWMEe6DrZUq0PPv9Oe
 CXf2kGS50jzpfPT0YFa1WqSMr7+d1gReQuotWIATf+GtYhqyuNuJWoON8FcBBingYEwtlg1Y1
 1XIw5nNCSgBSgwX6Jg66TbN7TkhlzU2isLHuaFadckokIxxEIp6XV2V/MKlG2iR1JtDigqiFC
 zC7fE8ewe6HVmXkInduQ2cnK4zF7F6epXDvFn6Pf+aqKvQuVMVnwv9imHY1HqGwaCEDNoTcl/
 e68paCWQeJheyo0aF23BzCi+TmSNeVkgpkUMBhG2O/VS/3jFYOUnmzYg+kKGdoD49r/ss9JcG
 8t4k5yaVBION62ZXePO3+bZNRhgZlkhDCc7DQYIE45cnTj/tEa6y+VutFLPli5CGQipfV33Wj
 zdwwGM2o8Igws4n4Tmtz3g0LFQjKoFkiDnoePLS8XvQT0nHqSqQ7fzGiM0kk=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 30 Oct 2019, Elijah Newren wrote:

> On Wed, Oct 30, 2019 at 3:17 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Wed, 30 Oct 2019, Elijah Newren wrote:
> >
> > > On Mon, Oct 28, 2019 at 6:20 PM Junio C Hamano <gitster@pobox.com> w=
rote:
> > > >
> > > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > >
> > > > >> Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 =
for
> > > > >> sanity in the face of refactoring and rewriting -- and as menti=
oned
> > > > >> before they have caught refactoring bugs in those areas that ap=
pear at
> > > > >> first blush as "overzealous", ...
> > > > >
> > > > > One idea would be to try to guard those extra careful tests behi=
nd the
> > > > > `EXPENSIVE` prereq.
> > > >
> > > > Yeah, I like that---I think it is perfectly in line with the spiri=
t
> > > > of EXPENSIVE, too.
> > >
> > > Or perhaps EXPENSIVE_ON_WINDOWS, since it's actually pretty cheap on
> > > linux and not that bad on Mac
> >
> > Why the complexity? If you separate out the expensive tests (even if
> > they are only expensive in terms of run time on Windows), it will make
> > the regression tests so much more readable to the occasional reader
> > (making them less expensive in terms of reading time...).
>
> The "extra careful" things you were complaining about with the new
> test I was adding to t6043 was true of every single test in that
> file...and likely much of t6036, t6042, and perhaps even t6046 (though
> those have fewer tests than t6043).  I have no clue where I'd even
> begin to draw the line between them.  If it's possible, it sounds
> extremely complex.  Just using the EXPENSIVE_ON_WINDOWS prereq that
> already exists would be easy and simple.
>
> Or did you mean you wanted me to duplicate every single test and
> attempt to trim down the duplicates somehow?  That'd be a rather large
> undertaking that sounds rather unappealing on a few fronts, but maybe
> that's what you had in mind?

My suggestion was in reply to your question, and not intended for
already-existing tests. That would indeed require a lot of work, and I
am not sure that it would be worth it.

The suggestion was intended for future patches.

Ciao,
Dscho
