Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFD7220441
	for <e@80x24.org>; Mon, 16 Jan 2017 13:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751276AbdAPNOw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 08:14:52 -0500
Received: from mout.gmx.net ([212.227.17.20]:58748 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751166AbdAPNOu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 08:14:50 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LcmN9-1ct7vd0k7z-00k70R; Mon, 16
 Jan 2017 14:14:38 +0100
Date:   Mon, 16 Jan 2017 14:14:36 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        kes-kes@yandex.ru
Subject: Re: [RFC] stash: support filename argument
In-Reply-To: <alpine.DEB.2.20.1701161150320.3469@virtualbox>
Message-ID: <alpine.DEB.2.20.1701161413400.3469@virtualbox>
References: <20170115142542.11999-1-t.gummerer@gmail.com> <xmqqvatfc0rt.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1701161150320.3469@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:x5Ml6Krd+B1HShBw6h4fQnfSpyxrvU4pr1uobRQiFz9R6QFS0BV
 xoZJ61Um4149/7Q7i0BovMWVH4/v6Y7mOniZeOIwbB9fYSkZzv/tNkbkrgf/Yb0aHWcohh/
 pa2oJL1pXkS5ouVUTwYCaDB6ZEaL/eK6rva+7lz2jFa+Q88OH2cA5uk6jKlK6FTE2jJU3kK
 16NUaiNnPc9j2Dirs78oA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ajGJcvGl+SA=:L3p/JUjflabtTJtaL1EvTY
 Zo4yT7CbiqGpBQmrIWJNyKgjWlt9AKFPLuTlIboAoBRI+GzjtRiZYVxxlWMarm4qTEImDSRIh
 emSEmj+VrGPXWVRYbWvdTzNAeUMD6oBOw92iiVwykWHY6n8gIhrSLfxlT5A3eFJ30Z97ZmwiQ
 etDm19T6V3Mzbq6Fi9+qJIMxb07p/Tr1inZRuVGjht0nCc3XnbySMnfS2uCoIBGzBN++lPd7l
 rv6H1PjiK2tEDylBDMEOPKd8LMmLcklRF00bshuBrmhiozk6l9BL5zMLB4XCVCHNNXrv4/rpj
 /ilViQYDKqjwb2fa0fiP+vNy9Yv1SorA9XfCz3fKQshV7M5LdC8SuO6AAojBeq5n/RHZle3XV
 35lfSLBw+FV2JQwjLwZhNQW7jxtxQkYy1CEO63p5fDj0Q3nTic1ioSuhd74EPogUz7Wk3cSC4
 Rtm1+rvWcvjExY9Ex8BeEji15uz9EYGKqspeP9J4etxnZf0U1bNOcrUMH4b4O2qbmlLnqgz4H
 qQE5J0FWvHO/UW4KIQwz7QPaBDZm6cXn7xWTCMnSFmt0VyRQjJYr4CzYoGjpEVGYrIatdNGKF
 qHUYvfBC05hwHMwRylLdtgHu6QV4XBo9iBXKPLnVsQfg+uJdIeHAvQjyVwt0oo+fdnxdqw1ng
 heWDc3AXsNui5vEwa5mxhjNR/SVcRKUxPzHV3TPrsoJvW9ugUzAVMmmS4EEkTqDnuETS4aRHs
 XlnEkkAWcMa75YY40LbISTSBlsS74C3dX/YvryrAqRf/Np9sqXVYdXkBmYmCcamuliAuw0Itj
 aLPfSKe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 16 Jan 2017, Johannes Schindelin wrote:

> On Sun, 15 Jan 2017, Junio C Hamano wrote:
> 
> > I haven't spent enough time to think if it even makes sense to
> > "stash" partially, leaving the working tree still dirty.
> 
> Think no more! We already support that with --keep-index, and it is a very
> useful feature.

And of course there is `git stash -p`, which is also very useful,
*because* it leaves the working tree still dirty, in the desired way.

Ciao,
Johannes
