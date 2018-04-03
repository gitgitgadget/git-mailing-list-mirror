Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84B5D1F42D
	for <e@80x24.org>; Tue,  3 Apr 2018 09:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755210AbeDCJbw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 05:31:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:52649 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755134AbeDCJbv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 05:31:51 -0400
Received: from MININT-AIVCFQ2.fareast.corp.microsoft.com ([37.201.195.115]) by
 mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0LnlmV-1eb7bW0zqJ-00hsKe; Tue, 03 Apr 2018 11:31:33 +0200
Date:   Tue, 3 Apr 2018 11:31:30 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@dscho.gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>, Phil Haack <haacked@gmail.com>,
        Jason Frey <jfrey@redhat.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH 1/9] git_config_set: fix off-by-two
In-Reply-To: <xmqqfu4h2xsl.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1804031127400.5026@qfpub.tvgsbejvaqbjf.bet>
References: <cover.1522336130.git.johannes.schindelin@gmx.de> <899ea23951627426ccd0aac79f824af386c5590c.1522336130.git.johannes.schindelin@gmx.de> <CAGZ79kapTWGsYznt7rr0QTNX+uH85TPY8AOA1jtDJ6_q8edX1Q@mail.gmail.com> <20180329194159.GB2939@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1803301415240.5026@qfpub.tvgsbejvaqbjf.bet> <87in9dwsxl.fsf@evledraar.gmail.com> <xmqqefk14jlb.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1803302042570.5026@qfpub.tvgsbejvaqbjf.bet> <xmqqfu4h2xsl.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:JcM4ROdiMIxWzmQPN8jxAAo9udjURCBML58wvTkZw97emVvot+x
 OL+8vVKZ1dEq1ttI0i5cKvtObVWEOuKgySFGCsOs4QYF25nRgqkwMseV1aR/MxDZMo+yJdG
 TU/ylM0TN9Vvl16ne5ykanOhVFYXzigPnHnn1J49ldZBGRQCbvHDsWCOC4tPZ0Cklks+u1V
 ZqYnOeLHE710mggrDzvYQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Pj5cDrp49VM=:qKp/ApbVq/R11m4L1LISQP
 r3WQkUXhOqQr5W7Dk7FaW14NiV3kwE9AZZeLr5ZD6l+swOzdPMv4sdHwkfqwjZhXxoeQ0MJjD
 jo3dkrZJQuyXFiR47JVPa0dkszS+4V0wkTlVvBzXCRLVhMod8VIsRYR3Vn5c5sBuoS6jsKhWK
 wKWAev0qaYo21y2TRPakHUNjhFWxiRTJD4Mwr2TQPeeURfaV/XCDSlgTSCRh2gNg79pIdWqEY
 VJ6EuNLrssBQUF2hOgL5CP0NMD8XUu/Z0LQSsgIjO/vbYuo24zPIms5HxW4dFWLbVT6Honp56
 1PXF4UQF1RWgn98R0CFNYk5EGtMlHP7S71U8baPixs5QI0/29djgx2+zV01/fjszC5WVb3I3c
 emwpXQLa6/X3inE23Fsm0rMiFN2jaLv6m3G3gXdE+7Q6DDWobd7NPSILezWh4N+N2O624oDEW
 MxN86V47ZjDM/WvaODwnTL/H1XevKFXpTJk65wR3Bv8QZg2s4wzFDokabTcb8wh3GOAmEWRxA
 k1t03rRybP48OisrDFvS9mIC6LPTPe9WyvjNJUrRpMqPyIK8ffch0PkhRFOLYYl7ZxkFrnCO0
 xwon1nIEGo3bUSk5AByI1MQuH4cL+YuzHDZJPYUggqueNFXIuJFJ2g28BvRY8dFi4siHsWb/i
 m628ewscys4qWdmJgeZGLBCzzpMul1itVPcZY1cyI+zCtdNXaQv2mFQtLcBgm++c5grmHEvOR
 +J5YE5Lwze5FzSLeSFsduWfZa2KvKthOx426AuEdX/ErAojH0IWXav5GoqSqi8F4ZDJhsSl1I
 0T69lWzq8Ykp7JvwtYx0KyXHkeqfjzWEKy5gldWFh4xCttZxX8NK5+GLrYVdlYendelD5k5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 30 Mar 2018, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > What would be a *really* good strategy is: "Oh, there is a problem! Let's
> > acknowledge it and try to come up with a solution rather than a
> > work-around".
> >
> > EXPENSIVE_ON_WINDOWS is a symptom. Not a solution.
> 
> Yes, it is a workaround.  Making shell faster on windows would of
> course be one possible solution to make t/t*.sh scripts go faster
> ;-)  Or update parts of t/t*.sh so that the equivalent test coverage
> can be kept while running making them go faster on Windows.

What makes you think that I did not try my hardest for around 812 hours in
total so far to make the shell faster?

Ciao,
Dscho

P.S.: I do not have the actual number of hours I spent on both MSYS2's
runtime and BusyBox and Git to find *some* way to make it faster, as my
time-keeping is organized in a different way that makes it hard to query
the overall number. But I can state with confidence that it is easily in
the 200-300 hour range, if not beyond that.

It is very frustrating to spend that much time with only little gains here
and there (and BusyBox-w32 is simply not robust enough yet, apart from
also not showing a significant improvement in performance). Please do not
make this experience even more frustrating. Thanks.
