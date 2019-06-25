Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9DD81F461
	for <e@80x24.org>; Tue, 25 Jun 2019 08:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbfFYIzu (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 04:55:50 -0400
Received: from mout.gmx.net ([212.227.15.18]:50521 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730923AbfFYIzu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 04:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561452946;
        bh=tU5H7pSWnSEDhuWyz/Qa2tS2/JJUWUFBUZniVQYK3N4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fhaw+Mst5CW9El7Aey+XsJGgneSlv3I5WeuzNjXo7EzehJDkmPm+DQB9kOeS/bq47
         4uzEQadpC2acDSDP8rxTrdJOR5iOVnugQKxpu6iRF8ul2mojHtpClVQDqjYPeTCfST
         sQjYsuifa99Q4dUdtWh6M8WliisgyUTNFHkD8vU8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M9b03-1hs3Be3JCJ-00Cy4v; Tue, 25
 Jun 2019 10:55:45 +0200
Date:   Tue, 25 Jun 2019 10:56:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
In-Reply-To: <nycvar.QRO.7.76.6.1906142051300.44@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1906251053160.44@tvgsbejvaqbjf.bet>
References: <pull.266.git.gitgitgadget@gmail.com> <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com> <20190613153354.GC31952@szeder.dev> <xmqqv9x9wkba.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906131844440.44@tvgsbejvaqbjf.bet>
 <20190613174329.GE31952@szeder.dev> <nycvar.QRO.7.76.6.1906142051300.44@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-544234220-1561452966=:44"
X-Provags-ID: V03:K1:BKt6yZ9yxym6TnfR20Rzc3DaGfVk/RtqKItr+byiENBHeSvxB/j
 t4aBaXbYTpHDgAAygx6jOllkZl9N/QVf3yMO1dp9IXsone/mDpQnl6mfT2HuLGG7GU9Bh4S
 eDlfCGoyW2kXYEQBIWCqfHVXbYPo+ULQ9hNVLy41NeMi/5Q3dg+ic9jJ+oPZNYqxN6G1Iyk
 y3QMuP6IcolGHy5a590Hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mWVuXVwgIaY=:zyKWFiZPnURgBoju8WAxTx
 p/Z/36XE2IGVpTM5IvNXoVTQpXNbitmGKjop7EosFF4detWfCAOao1X6+c2BA/fmC9PzJTaL3
 9Kgq23ZGhAQh7U9tCucuvItDpsI1NEpPHMctS7FYysnGRgXznrkVRudxYiQ2Q1hfbD/mMyUZs
 OYwysvUyK9IH1Cbii46tPV1HOzYwhUfW8IawS6PJkWD998mU9UOZrOs2frX3UF5gXDtGh0M4r
 pVDsxdzf1mgone5vcaLORVbf9nI2JrqDCiWP54NSvzG+wvKkkcgI3v0bO5MtQ047jPglTNSiA
 xr3HDZMP1d/FIJxgWU85QYOID6x9TflmmbPtpYEuT5YFZjkXWQUY3lYvNnKq5gbAllrlhj/ij
 28U2fTroWoIsPFSma1c/kmf34GndGuVd2ihGpPWdSkLGNVPaoQczqmt1QIaeTpOKHcBaIxca4
 MRU83d8VyGPur0wzfURqFuyPXIdP/OhySpEkf9BqsvQMMvu06WZ8r1ikeSArdXP3l/Tij9XKO
 xAjYNuHI59VpeSGKD39Iss7yRpzsUz24ZACuR1BJqiXC8fRN5+3runnvr1/gFsm9536ZXW1kb
 TK9m3mV1VjMgI4oYkzasqydZGDOjsEf+MCii9zZcdLpBJOMsfavdUKdq5q41b8KxxM6O+OGd9
 HWdrxu4/wcDXrE5AONlKpeLx/mk/QjPLB/C3BMAvjDYAQqqcV3TbPrMFhF6RiBxNJOZQHAK3J
 QCeDBW+fTG5ynUWm/ZiAfaaKNA0zHmNzyrhBIr3o0R/iTYtjtmkSuF71/uZT65cqMxCaGHklZ
 a9hxlBp9U2vtt65vmPAGEvkX46YS5bt/l2eX7lDAnQTkPR6tURfNyCWagJyJ3rJC6hCqcmP8h
 0LVhkaODLaNLDiijq8SJspQnKNHosw1uan/rBRG377EOOGolvFIE5+pwjDnLfrComZhJ0+tn7
 fUNQOl6nFda0SxJYhoS34kzw/crdX0bxMzstf6LDW4KChR7u41IipfqNZHA8mtJv8OWQmLBf5
 KUU10DUN8xmzvA5nfv6Toyus1nOuERkc2VfUU24LpgOrDiEfRcMmNd/wo+JI986QijmadZTZQ
 VWVkyWwxRDZ6yL/WulC1WqRYoxmoMxn/qkZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-544234220-1561452966=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Fri, 14 Jun 2019, Johannes Schindelin wrote:

> On Thu, 13 Jun 2019, SZEDER G=C3=A1bor wrote:
>
> > On Thu, Jun 13, 2019 at 06:51:04PM +0200, Johannes Schindelin wrote:
> >
> > > On Thu, 13 Jun 2019, Junio C Hamano wrote:
> > >
> > > > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> > > >
> > > > > On Thu, Jun 13, 2019 at 05:53:51AM -0700, Johannes Schindelin vi=
a
> > > > > GitGitGadget wrote:
> > > > >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > > >>
> > > > >> This job was abused to not only run the test suite in a regular
> > > > >> way but also with all kinds of `GIT_TEST_*` options set to
> > > > >> non-default values.
> > > > >>
> > > > >> Let's split this into two
> > > > >
> > > > > Why...?
> > > > >
> > > > >> with the `linux-gcc` job running the default test suite, and
> > > > >> the newly-introduced `linux-gcc-extra` job running the test
> > > > >> suite in the "special" ways.
> > > > >>
> > > > >> Technically, we would have to build Git only once, but it would
> > > > >> not be obvious how to teach Travis to transport build
> > > > >> artifacts, so we keep it simple and just build Git in both
> > > > >> jobs.
> > > >
> > > > I had the same reaction.
> > >
> > > So basically you are saying that the cover letter was the wrong
> > > location for this:
> > >
> > > 	For people like me, who often look at our CI builds, it is hard to
> > > 	tell whether test suite failures in the linux-gcc job stem from
> > > 	the first make test run, or from the second one, after setting all
> > > 	kinds of GIT_TEST_* variables to non-default values.
> >
> > Is this really an issue in practice?
>
> I don't think that this is the right question.

I still think that this is the wrong question.

To put more water down the drain, I would like to challenge you to look at
this build and tell me as fast as you can what half of the linux-gcc job
fails, and whether the other half of the job fails, too, or whether the
test cases succeed there, and if so, why:

https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D11410&view=
=3Dms.vss-test-web.build-test-results-tab

We really need to split linux-gcc. It's not right that it throws two
completely separate concerns into the same bucket.

Ciao,
Dscho

--8323328-544234220-1561452966=:44--
