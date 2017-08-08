Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C55B1F991
	for <e@80x24.org>; Tue,  8 Aug 2017 11:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752443AbdHHLi7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 07:38:59 -0400
Received: from mout.gmx.net ([212.227.17.22]:60070 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbdHHLi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 07:38:58 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MdFwl-1dwzCb0dJD-00IQJ2; Tue, 08
 Aug 2017 13:38:42 +0200
Date:   Tue, 8 Aug 2017 13:38:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Martin Koegler <martin.koegler@chello.at>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fix delta integer overflows
In-Reply-To: <20170808062047.GA4091@mail.zuhause>
Message-ID: <alpine.DEB.2.21.1.1708081336410.4271@virtualbox>
References: <1502129437-31226-1-git-send-email-martin@mail.zuhause> <xmqq1sonql76.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.21.1.1708072136290.4271@virtualbox> <20170808062047.GA4091@mail.zuhause>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4q6+JgpdwFted96+nm8AGihzTTHj9NtL3w02C7zJExseZIysxEm
 MyYUNhAEOIo9PVX+sPa/ArTFDCsTCwmUaivCNfXQIPhwKs/IgQ64J4Zafgb0xMWnS99raZY
 xviVRsGRqrG73apTE2W0bPq6+m1TWBcP+Ko1AAoPwvzEmAL2dzwlZFV9kGFdKU4mHhrTu45
 vH4NS+CbBmJ1VYf3X69+A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/+H+HXt+dnQ=:z0bZAnfNGT0FbPV9wqVqfX
 1Xy5Kk6Tk9VNKqs3B4TfYpGlfhASqr4e9XP6bymqFPnYnwF1KkoNheG7urSj5nVa/6NEd3jR3
 L6m7E8FCNDnkYqBHEK+mAJWTR7CuaVXGpZtkFJtNQhkEnve3qIZSXyBFF9reBEsx7PdSDnRja
 +9DxBwN7Hwcj1z/geLDBNh/nfYhwf5dprg2p5m0kgsmNd7xIncNAhD6Uj3t3hN3bhLAuUVKTK
 BAKWqbB3tfA9kKQdHo6ujte8bXPklHVLK0Iik6L2ViKr9U6WDbiD1ulr8Xqr9p5VvnXxjA6NU
 sFLfVWioKBweFkp2NK6epNKh+wEQie/d5yu2TTmahS4u2wFpDzJ9YPlj774xbmjz+hM4rb6lv
 XuAysLFieYf8abDio1cXI3CSdSqgX8QugVLPDIbgQOGrFEA4BPPS2MQz2qcH86NLqk6K+tUU8
 lKMipAkb4TT9nIIXA7O0vGrwCSypQKYQLuzVBpmOPGsNUUcw9yrTzAFP+j6U7zxRMtX/jJ4hX
 Q8BO3fLXyblDRyMyBxAcs6wnB6tS/wHMivpxILgdX5c35sFaYmP99M0feCnI4MYNQlVw9+r0T
 cBHj6FjNZShB1XxxW7+FFvFW6Bw9FS3Kzihj3quKnalml5+qj9O62CsIfwP9sTfe3cg4MLS0V
 hswK+SQIlPgjC3iPeHBIJUoZCCsujEPlFePmTWZp6wFqD1l295iX+g9Y7qPBlBfDd7UnpH+1Q
 PFQDC8W/nE8XEWhTWNEhRbixEcW/LAoR9DKi7M1bV/laE46o4srkBdEjMmoQ8d/xBYluh0mx4
 HMwDrJmFfHOi1PqZH42p4VjXzCPlwyReTjJrKEZAukV0TmNxPM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

On Tue, 8 Aug 2017, Martin Koegler wrote:

> On Mon, Aug 07, 2017 at 09:39:12PM +0200, Johannes Schindelin wrote:
> > If you want to work on data in memory, then size_t is the appropriate data
> > type. We already use it elsewhere. Let's use it here, too, without the
> > intermediate bump from the incorrect `int` to the equally incorrect
> > `long`.
> 
> I disagree with "We already use it elsewhere.".

By "it" I meant "size_t".

> The whole delta code uses "unsigned long" - look at delta.h. Look at
> unpack-objects.c. Or cache.h. Or pack-objects.c. Or index-pack.c.

I know that. It is a major bug in the source code.

> Other possible cases:
> git grep "unsigned long" |grep size

Yes, even more bugs.

> So the codebase still suggests, that "unsigned long" is the data type
> for storing object sizes.

And it would be wrong, and we know it already. Most importantly, Junio
knows it already.

> I would be fine with resubmitting a patch using size_t/off_t for the
> touched parts - changing the whole core code is a too invasive change
> for a bug fix.

Sorry, my mistake: I never meant to burden you with the invasive change.
I only wanted you to change the `int` to `size_t` right away.

Thanks,
Johannes
