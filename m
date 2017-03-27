Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128A71FCA0
	for <e@80x24.org>; Mon, 27 Mar 2017 15:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752895AbdC0PkC (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Mar 2017 11:40:02 -0400
Received: from mout.gmx.net ([212.227.15.15]:51240 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752748AbdC0PkA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2017 11:40:00 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4nt7-1bw9wD0UE1-00z0zC; Mon, 27
 Mar 2017 17:39:44 +0200
Date:   Mon, 27 Mar 2017 17:39:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH] sha1dc: safeguard against outside definitions of
 BIGENDIAN
In-Reply-To: <xmqqwpbd46gd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1703271739210.14958@virtualbox>
References: <856355e49e7a6016f5d1ef5f9785d94a455b5755.1490395862.git.johannes.schindelin@gmx.de> <xmqqr31l6ggf.fsf@gitster.mtv.corp.google.com> <xmqqwpbd46gd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AJ9QT2elEJ3UYR524FaeP8WkGgG7QjghUV4hC1B5Q+o+RulhwrO
 /Yr2sjqy6Djks/deVmzVSklCXv6Za9OuJmZ/MRuF9WHlr4BJF5PrbBIWF5KwIW1iOB7A3CP
 RYYe8PZl4NCNFW1yljgRFln/aP/7GJ0MV99TDyVYll6AOUFA0CTQgUKLCWDEnqAdj6uIL2A
 ueY5A8nyQbEMAvtNKffGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Se9GS0Q02zo=:bG0zT9L+zGvovyRDRws4nd
 3hVdhFRnn0lVlhhkuC+4QV9UXjIn11byKHnkvN+oQgybkCjFODPUDvJsxyKDS13gruicrUIH3
 tqPx6AuSyq1Ky5d//whlHxcfs0H2NnqAW7bBdvHzZ/O1o7O2vOWo/eKuBYP9xChQbYdtBIE7G
 qL/sAyH/8Qrylmo7UO3cp5YTUb88uKxou30wP3UbFMYNJ4NMByG7fwspAthIlLtHzEM/GDeUX
 TKizAHKHK/1WR2GY5QNb5iZYUq7vM9/fNSrfhrLX2cK3pr6JKHpYgsp0gKEBsfo8HVX9wF8xa
 CkhoYeUHypXDPckrpZv0NSn/Legl7d+dzeAyx0KhkAeKPN9dxnHkvrtXJw11o2NzcFoizBYMn
 LbmPZbjfjtr0v+vbS5qpFimk3TyA8VweeDdak84Rp8EwZV+W7u2OZOc8uEbULepq612KWbZEE
 M0k96eJgkrahEPSq1dZDnNzxTWk4dlW60CoPWHlf7cK66ED11YMqBza5EGVuM1oQuKjNX+dzr
 qAtbncOc1l7m8oCOEBTppPs1HmqazJQ3d83D43X2kTUfDmufS+Oj5KeZ3d4ndSuQO8oCUR52C
 oTBB6gbDtrq9I+Cxc71toISZwsqSZr07iBTn6S6B+R1KkBrtd7HBNcvMg7DHI/7dorRQkmcwV
 kbKoXYUavwr65szsz353giZYBUU53hibijKfFNnvx1S33T1hxg9zO1tA/xdsr6sC8aYkxwMm8
 AfDriH90coaCh+Qm9tRVLidNEPst1U+WiTucuDz1rrfkrbBrX5d9uCwTcCGlu5fF99eulGCmG
 wraGv/V
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, 25 Mar 2017, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Which leads me to wonder if a more robust solution that is in line
> > with the original design of sha1dc/sha1.c code may be to do an
> > unconditional "#undef BIGENDIAN" before the above block, so that no
> > matter what the calling environment sets BIGENDIAN to (including
> > "0"), it gets ignored and we always use the auto-selection.
> 
> So here is what I came up with as a replacement (this time as a
> proper patch not a comment on a patch).
> 
> Dscho, could you see if this fixes your build?

The Continuous Testing is back to normal, thanks.

Ciao,
Johannes
