Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8C71F4F8
	for <e@80x24.org>; Thu, 13 Oct 2016 10:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754120AbcJMK6A (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Oct 2016 06:58:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:55313 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754107AbcJMK5w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2016 06:57:52 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MQ2zr-1bpQXr3epn-005ETM; Thu, 13 Oct 2016 12:51:13
 +0200
Date:   Thu, 13 Oct 2016 12:51:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: Re* [PATCH v3 05/25] sequencer: eventually release memory
 allocated for the option values
In-Reply-To: <xmqqk2dd4efs.fsf_-_@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1610131251000.197091@virtualbox>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de> <a67af02ef363311b526bddba864c7f1ca9087b43.1476120229.git.johannes.schindelin@gmx.de> <xmqqzimbc0gw.fsf@gitster.mtv.corp.google.com>
 <xmqq4m4ic0gw.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1610121405410.3492@virtualbox> <xmqqk2dd4efs.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:0UPWq21iMA98BJwCL7vGxWUixpn2pscdfqLzk4FzdgbUDwOEAD0
 8Jt6xj3dlmA0+AoHzE4/KJA9kUngg5Z1BPsvb7J7Dt8sY/uARHVaJO5FA+xuv73L8TZQ/3Q
 twfL22/nm3XhrNWq9/qvPpc6z4pRzLToaslJXVhEdyWJdRm+71GRt7qXRDS71CW/pi3qkWy
 Ods2PXloRzKmVHpwC1KiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vRuLXVVcDXk=:Uek8TS37QUGleRIUCDb/2f
 RwiBp+Y4ZF8mCUw7B5OnZ6F2bsb3WOi072LnHfs9Z702jSX5zT83s0CVIzvgmgbsGXGKrevyu
 hR6I0BzzS3q6oIq1ecKmBjrqVsydH2rdaCz8AUk+uCLEngY2f3BCr6uws29DmOXdPtjTxrdGZ
 Jtyux3k4c2OLeazWCldZNNVvammdZNMFh0KsqILE2J9QPfmgMEJDvHXxntmJ3H74LuMNR460w
 rh/gD7Hsl4SWTyJJBguZQR6FdBztMwKo/spE/UK2VYC/VpDkjkey+hx8y9MRKOC5BnjIa9Pb3
 r3a0X3/AF4Yihr7L2mO8ZRlVP3VIiFxI6UOLtoWFatubRoxDhf6B5aysPX9qm8JoGsih3wegj
 2Tcfcr43iIt15NAkJRZj9BwDnX8kA5MQWbBZDpIS+FJmwjItJ0HXK3PzvpfBYzl854/T/6Fsv
 J3qMG9fGYCuUVaj7h6o4Y/eh4EVBL3iAA1pr1L8crDpgITlNwUJfGLaWq6t+0ZEk91JDDxYNk
 rnEA5dPRVespfNzDQ7S7Tx1bnsdDI1a0xL09Y+ml+j4YXuxtm3L15ar+ToUUJhe6sBQRn+HwP
 rQF5Q/6aB71NUFeayUzD7TbjAvvediyC9U0widr0iaQ694E7R9lYmBkBGNB9vZat3iw8vj5Lj
 6OOQXKObLR4bxmBmbuOK1YRo7tHJGRZjIpTecm1GctfxFvG0vED4vBMcpXTd+jU3+ePmUVomJ
 sbanxrLFF2wsELWnocewxCEyOvSwl/nI1+flVrLoAcAD5G76OuoyM/uDZsTYpOf+ErhdQJiJZ
 ukUioba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 12 Oct 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 11 Oct 2016, Junio C Hamano wrote:
> >
> >> The only reason why the OPT_STRDUP appeared convenient was because
> >> options[] element happened to use a field in the structure directly.
> >> The patch under discussion does an equivalent of
> >> 
> >>     app.x_field = xstrdup_or_null(opt_x);
> >
> > Oh, that xstrdup_or_null() function slipped by me. My local patches use it
> > now.
> 
> It has slipped many people ;-)

Thanks, I feel better now ;-)

Ciao,
Dscho
