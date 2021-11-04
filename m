Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F5EC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 08:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C779960F45
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 08:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhKDIvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 04:51:24 -0400
Received: from mout.gmx.net ([212.227.17.21]:49195 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhKDIvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 04:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636015717;
        bh=cRdu3YUbYAKAaAFG+DWynkM0bE2u9HCakt3T/ENmhl8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ATk8BAdBqzkRTW6a0oNdJyoNtM6v3UuCt6afKZ7MnmWvPhov7gdwjkYbxnO9Yn6J7
         8gvIkRdEAC9vbWeHLqZNR36uEYmUfllljeeE3/7imKzU322IWLOW8Ym/KV56nPJz91
         /FaVew060u/bGhkeLijN0QLLog8Pxb+wTMOBk/Oo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([89.1.212.10]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvsEx-1mR9lK16e7-00ssBg; Thu, 04
 Nov 2021 09:48:37 +0100
Date:   Thu, 4 Nov 2021 09:48:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Alejandro Sanchez <asanchez1987@gmail.com>
Subject: Re: [PATCH 2/2] prompt.c: add and use a
 GIT_TEST_TERMINAL_PROMPT=true
In-Reply-To: <xmqqo8716sqx.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2111040945280.56@tvgsbejvaqbjf.bet>
References: <20190524062724.GC25694@sigill.intra.peff.net> <cover-0.2-00000000000-20211102T155046Z-avarab@gmail.com> <patch-2.2-964e7f4531f-20211102T155046Z-avarab@gmail.com> <YYJ5IpvGRoDvp8V6@coredump.intra.peff.net> <xmqqo8716sqx.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Jein6ZMtJtKt/8wBnqFPPloLiH1a4N4OBeRxl5+ASvnC4NASzUH
 dHQnu3NR7xsGWAaJSEdtc7rWsCgaFnDBTT0QB/JketmE66TSg/BJtuJxoJC+yYsE10cUbXN
 uZStQJut6m0qY0Pz4CiEiMG9GU8po5JaNNwop1zyXypLQUWg078EbJLFUk7Hw0e9jI3Ona9
 EgB5BsT0ImG/x4fNaWZCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OBvlaGkGrzQ=:f8/gFjjH61PbeuC+ddeJvZ
 /lU6/DjQQFZ+wGHtw8INgEtUrVkWSD5ljLr74e55v0bEsG/d/fPbAjLyp9aDO8wTezxrOm0Rb
 iVr4Pq2nrmIJ0Iy3f3+/Pz6jgvu9EaaJ40RQzb/0+JK2Yr2RIvCSvxbZr/XyqeEhgUH/EOtcl
 M1ircWHPHR8HDCADAxqGC8nPH/2Yw6U0FmFv7gLgCeTRnNirfM5yLo4BAr0EHqzzCMrwnmYd+
 wFEK+NIe43NNjZ+kdSk7kxRs/dXdqH4oIHKOld8FBEPRZk17rwzUXHKmzJ8uMEP04tuQG9K9i
 R9Cu7p+qtzmaq+zcVK5f+8NTx9IbuY5TMho9sdR+1HwADqahg8bmJpPvfod7KC71bqCgejr8I
 QxSSeicAtmswqE7h578BAQA0pDJVST+uWuQCBFaGI1cMWB7qjWIgjg4QGZ20MOP3nP22D9vw0
 vrdoe1+ZWCKe0TFzjazmWrhfQ/AfQaASJO7Kq0LJ9YRHlQu7546mR4Qbe7ZFmVn2EKJRinonS
 5MbjyyXTDYS1V6jxGMvBZhQQMb9deOAhdoB6cXr0b2DPsAhz3yl39zOrHKlT7EzSaaJTR7Ksn
 LZGGzuYF643CauIMzB4OOZJYIw5prryz6XeYGsuviNnO5i2lkn2zsx1t7aoP2PB/061RPTpFl
 ZnIXDh1Qg+F0DXigLhkPM6DlESklup0vbjI84a4XsdCJZEe0RKHCRRlyFY+R1mkuF3LCf7CgF
 Iwk7xDaZZtdz8sqtPGsakxZweAkrFUi5rMayfGb4eTxHdGdYufuCPujdN77I28FZqlM1svY+R
 SyxFqH4gPZBooT7kiJMQV/hT+I3RT29ehm8DSobevO7xx6gJFlJmQBse9fYEtxee/WdRHagH5
 jd1mS2p5XAKuAs4V9wHKY5hQko1lZ2IzLMylqhwDmI1Lh4msfB/4zNP64C8j4uWHQczEmfWHG
 FjFM+pbJ0phefRsikqw2GCN5hysgU96zQiEO6tPzwkzW1DtVeIOgzQIOAoUgOJa3BU0apXoDx
 Gh7ls813jZhzi4mBJzHqW5ybO3JvMP9+NQTgoBmb4cHZWMyboXxI2ZyLchJFcJmErDUQAToon
 UXojCHuo9bF4As=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Peff,

On Wed, 3 Nov 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > Basically, I think I just disagree with this paragraph entirely.
> > Moving to stdin in the commits you referenced was done to help
> > testing, but I also think it's just a more flexible direction overall.
>
> It is OK, and it is more convenient for writing test scripts, to take
> interactive input from the standard input stream, if the command does
> not use the standard input for other purposes.

I think I remember when we talked about this, it was in the context of
`git add -p` becoming a built-in, and we all agreed that it is actually a
very nice side effect that you can feed commands to `git add -p` in
scripts via stdin, not only for testing.

It might have been in the context of another command, but even then it is
a fact that this is a very nice side effect.

Ciao,
Dscho
