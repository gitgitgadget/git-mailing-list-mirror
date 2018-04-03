Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E746D1F42D
	for <e@80x24.org>; Tue,  3 Apr 2018 15:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbeDCPsB (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 11:48:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:57967 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751283AbeDCPsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 11:48:00 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfVzj-1eresD2Uax-00P8dO; Tue, 03 Apr 2018 17:47:46 +0200
Date:   Tue, 3 Apr 2018 17:47:44 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Duy Nguyen <pclouds@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
In-Reply-To: <CACsJy8Bt3AEZmjudL+scXqOC_oW1WtU0_QZVD9PM+drGbEBeVw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804031744220.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87in9dwsxl.fsf@evledraar.gmail.com> <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet> <xmqqfu4h2xsl.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1804031127400.5026@qfpub.tvgsbejvaqbjf.bet> <CACsJy8Bt3AEZmjudL+scXqOC_oW1WtU0_QZVD9PM+drGbEBeVw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:2q3/0O0bAOO+4RddEq7fNeRxzVkM+CN6E4eeiR+c14OIo4EA5X+
 Jkxgr3ljYVD/I4iVzcvffZmxa/QBWybqyB7aHLtMnitvSnzprY0xluwUHQ2mpmrpobh7ktc
 9GU2aUx09I/nkYM53NdB4mSsPDZUyhTIpfRJodM/1f6XX4eEbkl3A/2C3O1O4FupXU+z+DE
 lfhqvkuhmnvxr/Ux+P3fQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:seZzx+onABo=:054ojcMu18CalX1Hr5njWH
 zRJH3C12kaGeBKjnpxh/hxKnQmUao5zF18wevMmY2pDNhiLRcKOCCW174KQhRivpfpG9je71G
 eJculHDRva9vS9tfRzs4xSJfKPvoCT1DgRRk/F8zFWyUVwEN5cEN6K6CJeFYxulL2ofT42iVk
 zxcg2eVK8u4ZRLb02rEh0xj6AnK6GeuDW8dMDPJ8s8Fui2sP1RFFWzpCCYKi7aMF/cZNjRj/B
 f8utK68upXhsQxmtu3XAOooAo0oBxG1JxRFIpxgFgZfj2KfO93rn1xcmYxwoJSdSTp41LpN/Q
 PGRP/ZIIk6dDCrSkiPzum8XfJKK4rhNwK8FxhDlfKfENRQrYV2aJbxIbhyTj2ppJWofwpeweF
 VblXRrAUwyRKJW1YFCz0eJn6h/f3KoB4BHDfih8Qt1rX2pga6kllfkgsSM6rR51tBIRcGjVt4
 Plq0Sg/2NBcQ4Il7H+PHETzApcrTo+DbAWYXjvDoIdkLYZ+MG83yxMWo9JasWoNKJD+ajv2z6
 O6U546mMy4VNPNizCc5SX3ldx179H7RikSdAqBgM0ivig0sjgltz18TXd9VIIQNpcBpv6YmIz
 SMx9MhF4iD5N1cTI76YgZB0VjIiF63JAZ/o2FaSEciluPTxtv7Z/28fJftSE87dvPhcH5HOVP
 Rjgq4JnSmLp+/fWO1c78kf3DYQGrgAHv8dvBkyAEMLEw4uT3Zh3nlTrzRPsRhUJxtGpYkL/Lp
 WgRMBakcl5kZaFts+TJYO+Hhk8X2OHf78XHmzUIF+u8P1lr3JELAXu24rtQQmvEr0MMSTTEUr
 6Lu6UtYTSM197qzrGAUruRVNZ/u8rbg0LP5i30EpLqob+UGsD+hLhg3A66yu7k7DMAUFmMJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On Tue, 3 Apr 2018, Duy Nguyen wrote:

> On Tue, Apr 3, 2018 at 11:31 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > It is very frustrating to spend that much time with only little gains
> > here and there (and BusyBox-w32 is simply not robust enough yet, apart
> > from also not showing a significant improvement in performance).
> 
> You still use busybox-w32?

Yes.

> It's amazing that people still use it after the linux subsystem comes.

I use WSL myself. But you need to realize that WSL is only available on
Windows 10 (many users still use Windows 7), and it is a little tricky to
get to work in Docker containers, I heard, so I did not even try.

Also, many Windows users are unfamiliar with Linux, and forcing them to
learn and install a Linux distribution on their machine when all they want
is to use Git is a bit... much.

> busybox has a lot of commands built in (i.e. no new processes) and
> unless rmyorston did something more, the "fork" in ash shell should be
> as cheap as it could be: it simply serializes data and sends to the new
> process.

Yes, I had the pleasure of reading that code.

It might surprise you, but I had to come up with quite a bit of patches to
make the test suite pass. And it does not really pass, as I randomly get
hangs...

> If performance does not improve, I guess the process creation cost
> dominates. There's not much we could do except moving away from the
> zillion processes test framework: either something C-based or another
> scripting language (ok I don't want to bring this up again)

There is no need to guess. I now have .pdb files, and once I have a good
example of a shell script construct that is particularly slow, and once I
find some time to work on it, I will dig into the bottlenecks.

Ciao,
Dscho
