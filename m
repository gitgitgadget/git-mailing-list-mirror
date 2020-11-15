Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66347C844E8
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC2622265
	for <git@archiver.kernel.org>; Mon, 16 Nov 2020 12:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JaZA19Qz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729898AbgKPMHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 07:07:54 -0500
Received: from mout.gmx.net ([212.227.15.19]:53115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729143AbgKPMHx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 07:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605528465;
        bh=NCUO0RjUZzUdDmzgUAl1mWRCe7x+tHzpykI6RvHu+pM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JaZA19QzbcaYvhXdLxPA8kiNUO+roq/bx2+J9SuGhuZWrXrih+zIRFO8SWjKCb5p4
         1F/2vUg5BX4UCMHpoL9p5c/skeenqfnWI+F3EWpEw0fmOgZ047fj5OJY/e9oCD5QKq
         mfO0uvby9z/QKbrBL1fTnFnSSEckyvIDdYY7tDjw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([213.196.212.61]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MhU9Z-1k0uYc1qeR-00eZqu; Mon, 16
 Nov 2020 13:07:45 +0100
Date:   Mon, 16 Nov 2020 00:51:10 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 09/11] add -i (Perl version): include indentation in
 the colored header
In-Reply-To: <041e9ff3-2447-e55d-f40d-079a84f0ad44@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011160050300.18437@tvgsbejvaqbjf.bet>
References: <pull.785.git.1605051739.gitgitgadget@gmail.com> <pull.785.v2.git.1605097704.gitgitgadget@gmail.com> <304614751ea1b1db80fbbbdc909b3d198c20313e.1605097704.git.gitgitgadget@gmail.com> <70fae5a9-354d-978b-c560-d7fcabb25c76@gmail.com>
 <nycvar.QRO.7.76.6.2011131457420.18437@tvgsbejvaqbjf.bet> <041e9ff3-2447-e55d-f40d-079a84f0ad44@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RQhcYU/mGZwLhyVXKqCrWwl5pSiY0z2kCzaH/x1mg518lwyH4iD
 mTO9EtJzeL6UNvyr9O74K71YLUko7BD6TlAq3ldfBBQ/+HXWfuc5EcD1/b9DdP/hxK7YsOx
 B/UXAXXS0UPrnSm421tMwgHDJbfFZRSPty/JDT3ycU+1ZJAGRIxXL5rd3RQbx7/02Pnhb29
 NlMVHEsl4ahd0/1Xj+PNQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n/VTlxZxBJw=:Q/Eped6yKQUPUeF6saBusG
 ZPa9mfDHogoEJxnER1EHDt74FB8exyh0z8pS7gvgiTVuWak9/XiNVinBb7p+SlK0AJsKiESOR
 qMKbvmmBmndyNnNb0/prP1Hf5Kr6CUt2vXzvtfSZw9lQe6kk5LZeRyOWka5FQxH5imeiqTBkP
 4GxikDV1NdGf39KTeRYVGHzE0yI2bKt9yWNy+u0AJZuoEGgiJ39quZbXhRW/gy6AJGJJrOoSb
 6ZBGhrkdm1PYQ5dEazIzv79U7yqjqw6NJO0SO62k52dAPErk/Mh2249jLXONITuWkJAwSfLwG
 e6h9reUBz6UtuxPZLQ6eMbbTVs4kawvwMBpKaoiaeSAtNrD00aVTtQZy6vBdB0xW3dO6OGy73
 xREuA0aLQAiGg05VQxdp99ih8Uyab07l9PcjqAD/oJRQ6KYhOLqkYLUInjXPnX14WNqd2MvsV
 WngqECCT9PcXl/xtdsPsbNhR4atTssjyNaAZLF6nLnteklMAymlymKDDcIGu8DlS5qLRFFUeV
 c7MzhZocj/A+459OAdmxj+r3gdwE6g5/LcR1/hjnHfRN+DCD4Jnw3nVZpYDvYKyVJecBVr5ip
 R+b/blDCj3DShgSXABiFwDS39Xx3PEoburOP8Q/fu1kIQN+p92N30Sr6tI83IxS2HaLVK8BdH
 7O9o5ueAgoBGAzAfGrao4OLU+LYw3POEdFp/0hVwPAvKKbxHRKvrrRqNCjkzmyXWLtz545v/3
 PvErZDgIubOi8zB7nOvwXz/+xMpTK+PUi5PEqxJqBBhN4sKrBO4L/IHBX9Ju8tsRURcdPanXF
 Gy7D5g3s3jRFIx7cp3xrSpkVjGhzwTge9Qtp/5wS6m1s/lZ1yhJsZSabWXiOlOvwga11+puwd
 7/DjjGqI2Tmu1XIKeEGG/r5yBCczv+IRXX7JRdcIk=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Fri, 13 Nov 2020, Phillip Wood wrote:

> On 13/11/2020 13:58, Johannes Schindelin wrote:
>
> > On Fri, 13 Nov 2020, Phillip Wood wrote:
> >
> > > On 11/11/2020 12:28, Johannes Schindelin via GitGitGadget wrote:
> > > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >
> > > > The header is formatted by padding each column heading with spaces
> > > > up to the length of 12 characters. These padding spaces are
> > > > naturally included when coloring the entire header.
> > > >
> > > > However, the preceding five spaces indentation for non-flat lists
> > > > were _not_ included in the Perl version, but _were_ included in
> > > > the built-in version. Let's adjust the former to align with the
> > > > latter's behavior.
> > >
> > > I had trouble understanding this. I think my confusion is that the
> > > padding was printed when the header was colored, but it was not
> > > inside the colored part whereas the subject lead be to think there
> > > was no indentation printed when the header was colored.
> >
> > Right, this is ambiguous, but I thought it was clear from the first
> > paragraph that "included" means "when coloring".
> >
> > I'm not a native speaker, though, so I welcome suggestions to improve
> > this.
>
> Maybe something along the lines of
>
> add -i (Perl version): color header to match the C version
>
> Both versions of `add -i` indent non-flat lists by five spaces. However =
when
> using color the C version prints these spaces after the ANSI color codes
> whereas the Perl version prints them before the color codes. Change the =
Perl
> version to match the C version to make testing easier.

I wrapped it, and modified it slightly:

    add -i (Perl version): color header to match the C version

    Both versions of `add -i` indent non-flat lists by five spaces. Howeve=
r
    when using color the C version prints these spaces after the ANSI colo=
r
    codes whereas the Perl version prints them before the color codes.
    Change the Perl version to match the C version to allow for introducin=
g
    a test that verifies that both versions produce the exact same output.

Thanks,
Dscho
