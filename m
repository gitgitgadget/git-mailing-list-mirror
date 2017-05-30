Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9E32027C
	for <e@80x24.org>; Tue, 30 May 2017 15:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbdE3PAB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 11:00:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:52710 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdE3O7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 10:59:54 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MPZuP-1dJrTy07nN-004gE1; Tue, 30
 May 2017 16:59:43 +0200
Date:   Tue, 30 May 2017 16:59:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 02/10] rebase -i: generate the script via
 rebase--helper
In-Reply-To: <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1705301659150.3610@virtualbox>
References: <cover.1493207864.git.johannes.schindelin@gmx.de>        <cover.1493414945.git.johannes.schindelin@gmx.de>        <e173445d9a6321f80053967e50375400c0a61764.1493414945.git.johannes.schindelin@gmx.de>        <xmqq60gk8ad5.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1705291252080.3610@virtualbox> <xmqqfufnc56q.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:C9twbCppQfYQiMzyeO7YUqoY7t2C/XptQqXrsjz2W3TcPGRWdfR
 gcolub7cu+1wItvfMq/TC8XTXqLe+M6Ccq6u7FmF4k8XPsV7asmOCmbYsNcCRjPCPFcg0YS
 9WNVeIV447qK0EDQyGrTt5821ciVdK+0/v+NSFlWWZItkGfNWPq0C3ubDJHU3pYakK8I7gg
 fLnVDNXBJxsS9PoW+K6cQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LorEm1zHA/Y=:DsI+ga/v4+nc5Uz548MNF1
 I8fYVIqXqOSf1oE0ypa4BScGXkwnQRriuVQrfU314uS9YQzZT1Qzj9MgVjbeh0W8SlstkqmkW
 c3d5lGSlD1P6r9srdtvBUwCYAr7MLCIK63vTD46sUIVloUbYHYu1FU6q0M+zhNq5ii429RRjn
 313YI2GOE+QvSln0C/Tdt8fKUnP3KUGQQg26rXidBBer4lATCvqyjVKgRy4WCA/oQBZqA2Mop
 U0BDS8RTULn9c5hsleBdLJy9vs0OxAFSUPmwY0Rm7ihKKxRhEoOg1j0d9okv5L9uYZqSX8Vkw
 bHELjhXaqbpdkZASZ9Tzck1/nslylJTWDS0c3yY6OzXOjNJGyhnPURX0T1JYdKnal9t0GDLP1
 dnHNc8mrj1kQJLQ3A1jben02MBEinDxv3hWidnShtljiOeOp50CUv4lRCmzVZB4oT6SDVpUKF
 o/Uxe9p0qMEvwcLPdtRW2kqBS65e//TQBY47SOmxEIYFAac4xe55A5sTxCeDm8Z63gPRyzZL9
 uBzjM+vwIkMRszVfNR2YF+KZFDeNuXhHNGu5AyHq93Bilms5i5MePRIOJvSzGWDB48rMnJOM2
 LJRwq9Le1Gv3o/nrzfS7Lj6EjoT8QkPl+s8vlGepAhxOH24cJT4ZbafQlhjYi2DwhMu3UmEAf
 f9n7whkrKMYbBAjhfHIDlVYiJal1hRNdpyGduxzn/Sez7SuwknuItgnFDvH/gPCcGkB0jXnT6
 tW+z3U4XBETP/0pYJogjoQjdIQaZlgBlZ8vmSl6VAxc97u7tRQJkU0fW5ACAeJOz3QhkQywhD
 YrpmmQx
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 30 May 2017, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > You still ask me to pass options in plain text that has to be parsed at
> > run-time, rather than compile-time-verifiable flags.
> 
> Absolutely.  

In other words, you want me to put my name to sloppy code.

Sorry, not interested,
Dscho
