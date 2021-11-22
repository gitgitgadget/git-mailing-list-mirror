Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C2FC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhKVM1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:27:37 -0500
Received: from mout.gmx.net ([212.227.15.18]:51425 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhKVM1g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637583720;
        bh=kSbMzagLRPWJixvMW1CbtLC29nrjBNp+8X96qP9xk2s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z4PAJnKdq1H0hXG1DlJhykYbntr3QXOLH20p3aBHWbBmKTOlB8L2RCX3inDZHE18X
         odYU4OLFOqgLQxk/FTkOu+9SAdL0IlM/423ktlIj07YP1n2EyfI6rLPld1EXdQALY4
         RMDNZJ2X2HQvnAN1xLPr2W3h0MwFDgTSoTQgTrY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbirE-1mE8t41Pby-00dIFO; Mon, 22
 Nov 2021 13:22:00 +0100
Date:   Mon, 22 Nov 2021 13:21:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>
Subject: Re: [PATCH v8 00/17] Upstreaming the Scalar command
In-Reply-To: <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111221317390.63@tvgsbejvaqbjf.bet>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com> <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com> <CABPp-BG=fcKq2Ng2gan3HbBGcT7WCMhtZCP6m2xjA5BSuTekOg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ksWB+b1sKXlwF7OjxkgxG0SBx9076eiAjDM9qxBmPxH1rbiKKm3
 ooE8NMs+0CREcqeqF2UtnK7OtfpY+ctxY8eKnzScegcJfqZI0+/obk/K/hJLSme+7LkSfl9
 D5zebHPMmPDJk3D7qwgSu1VkXXPujr8HX+6ry+CrXG5oEXB0DrEWsvsG042OfffyNONjW9d
 kWWwdJVOzJ6Lz4EPvEQPg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4yZf1r5FNR4=:rC7m6LvFLK71FqZ0SfZBkZ
 RX9/hs0kCQMAavJyuW4RaMPQ6f0x1ciOvVgc7Kqo3Bheaz3AlNnF0vd+4nzfnRRoFcImuBQvt
 mfFubfJptA4DWJ7OAwS3M5DR62im8Q51Kb1HppBFKSbyBWIM6qMJlsXfElwwWM0azL9h+MXzC
 Nmj507XYv2SM1I1/Pu1s18NHyqEpBBZ1MYbFscAS6rdtAhrRxTsFMnhS56R0x7UcyEAtOwvxc
 ke1EylhDxPdqpR0Q94mqJEAXaapPwHbaWhsY9y6sLYNvZRW/1+1ah0ryrob8kxUxlBh0F8CuX
 CEM5hCoAeEMFWYY81+YefE8drTzXQ/jC8PYM2A99U2I0/yiBLVdTHTB/S0g/Zt2zG4hpvPuIH
 RKq8++DWf4ZdA8VPnFKY/FtpJS8MWk7aA3VRksPCTrn1qAUMDignAYPvVYPG3ZsAxW6pkn4km
 YwFOPU70cvsDN7GM9hitxj9V/N7svrr2edj/3qk9lSin81Wg7qK/cK7tP82Z4wyxxaJzVNJaq
 qw9KC5AMImRm30fSkHMoF61mJZWaSdxEol0pYYUScuGDchwdW5JH6BSC35ITpRaNOgygM5KIh
 Fk7SGkIKxegDHN1zJVTFvYve9teyl1N2EJpCx7kNef6MflZeQ0hLNVTLpWMegk+e8kHxfCzXT
 aLBRjL/F89YQ5y4ruOx31jzY4tYyhvmclyJ6Gw1fRVD+8NrzRr/eGYWGyjex9WBVTxlHK5K47
 oCL4Nbdc5JPbSkfdevPffrO/DP7fqsM/KnVuPoKppROPU2dlqTShZb/6tXLmgJEBOSmtfXTm5
 aw2dR0sAOUkWOGed5ZOxxdbUzL286kMEKBbLx/u3SME3oWRsvfrnkmnwvaWG3w/dsV+IWuxEX
 ABJJY+Qn4FonMedW6EMsPQOjcQl+lpZ+H47v6LipSm/SxlVBXnfuf7BHSfuKBYHJOkAh9I3sp
 Wwg1NhhBIjBEc1lx4fpRZvigM/ss7+swUMi2PfpXqnsYRdX9ZhwsXvBw9iu219mEWmS2YpNwg
 uj53I+mBkBTesfWju9DoopfUAt+GoD3u69FNFBRRXHPoK2MfIC/9oWaOdhPK6TYr/LKraJaVM
 x0tYecL7eAGwug=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 20 Nov 2021, Elijah Newren wrote:

> On Fri, Nov 19, 2021 at 3:03 PM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > tl;dr: This series contributes the core part of the Scalar command to
> > the Git project. This command provides an opinionated way to create
> > and configure Git repositories with a focus on very large
> > repositories.
>
> I thought after
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110062241150.395@tvgsbejv=
aqbjf.bet/
> that you'd update merge.renames to true on what is now patch 7.  Did
> you end up changing your mind, or was this overlooked?

Oops! Thank you so much for the reminder.

Will fix. I do not plan on sending out a new iteration for a few more days
because I do not want to send lots of patches to the list right now,
reviewer bandwidth seems to be stretched quite a bit already.

> Other than that, this round looks good to me.  (I have no opinion on
> the build system integration, other than that I like it being optional
> and not installed by default.)

Yes, I very much wanted to keep this optional and as well-encapsulated as
possible for the moment. (Hence the way it integrates with Git's build
process.)

Thank you for chiming in!

Ciao,
Dscho
