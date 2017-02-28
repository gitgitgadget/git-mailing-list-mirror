Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8763A201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbdB1PKc (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 10:10:32 -0500
Received: from mout.gmx.net ([212.227.15.18]:59395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751666AbdB1PK3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 10:10:29 -0500
Received: from virtualbox ([37.201.192.48]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvV1X-1cIZf81TEJ-010epG; Tue, 28
 Feb 2017 16:01:37 +0100
Date:   Tue, 28 Feb 2017 16:01:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Use time_t
In-Reply-To: <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1702281600330.3767@virtualbox>
References: <cover.1488231002.git.johannes.schindelin@gmx.de> <20170228142802.hu5esthnqdsgc2po@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:waGDAgaNaN/UHmsgktQ0aMCeqvq+yD4Be1ToOyk2eTnytOr/u04
 oQBSDX36Q3pD3ybIVVB1WIQSNBGAnBMcDEAnMG+Xaga1KXDhRpM0IfTHHB1ABkoPLB/vlnM
 LazfoXpMKNC+EMxzuYNcPRtlaH6HC8fQzJNNfxkOLYDSD5xU1JWahFx8hZfbXKGeDulbYIq
 FHnkfn+67ZZd4rkXOTF1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xjn7P0gsEKQ=:Ib4ivUXFO8sHnxMHL37QYa
 E622q3QyK/rztURuvKP7QWOzJSkhd2REfu/ugUgeB7pwFJZ0Oo+BrwXP11VdgSDCgriV/L/we
 ceMNeJhKoTmKbvWZOEinZo5ALafBM1zledK71tBuF6ldNXg+BQ+Js6zifo7eNEfhoXMNfH0SE
 mQpwM2w25+BS2QE3fqbxNUxg584VCNeuAqgucb6sy8ZWxBa/bauYBxWZ4vCV99JVtxUtdutsN
 XvCFUi7bNn4mxlWP/wwP0nuu4QeWnDf3wWG79fqOagN260Im5EJ8gGO5S5K0Coq719P+J+Qd/
 JXjZZqs2P5iw/Yn8CihEgnUtbwePfgHR4tJkkR5eZmZ2t7GapMLlA18pPZjwE4oJLhp70MKVH
 TlkHACyFZcwTNyg2r3wlOdk//P+8wLRKm1A/byL+PNt6Ht4WzkqYWeXvlco5sXsJ2TT6Kk45j
 bJvxyR7x07AUk/fOh3+qJRo/2RTbQ/EK83i1EQpKXufsgUpF6lwUr47emqMShuvw4ZL7lpwMA
 wYOi/Xl/mObR5sJL5QN4Doh8IGmIm3w6RFUzTRyC6PvXjDt8Rxhn+DhELA/pGZuIniORLPUKO
 ZWBvL+nlUoHNS3eDKk5kVw9OjbHwMueP0SKD8pfdJyegbCIFoTnu9rTTQxjh6LI9ps4Zd2CY4
 sBYM/ENppQ1aaivqpDBRYm3ic16qN1pKhR7pcJyjZ/Id/WUjYYi7XICwJwLoW3GoJumORriDb
 ZON2PToVxV2fGzr/pRlmyS6zDoc77fS6X+t1ZbGZvbIPGkhlCVhlCt/e+6NMfGrWS5dMo027f
 iiO2/Gw/0RS/5+MQ7e52hdnDsqMlQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 28 Feb 2017, Jeff King wrote:

> On Mon, Feb 27, 2017 at 10:30:20PM +0100, Johannes Schindelin wrote:
> 
> > One notable fallout of this patch series is that on 64-bit Linux (and
> > other platforms where `unsigned long` is 64-bit), we now limit the
> > range of dates to LONG_MAX (i.e. the *signed* maximum value). This
> > needs to be done as `time_t` can be signed (and indeed is at least on
> > my Ubuntu setup).
> > 
> > Obviously, I think that we can live with that, and I hope that all
> > interested parties agree.
> 
> I do not just agree, but I think the move to a signed timestamp is a big
> improvement. Git's object format is happy to represent times before
> 1970, but the code is not. I know this has been a pain for people who
> import ancient histories into Git.
> 
> It looks from the discussion like the sanest path forward is our own
> signed-64bit timestamp_t. That's unfortunate compared to using the
> standard time_t, but hopefully it would reduce the number of knobs (like
> TIME_T_IS_INT64) in the long run.

Boy am I happy that I did not go ahead and changed the code to use
uint64_t yet...

I'll let the dust settle a bit and then make further changes and send out
v2.

Ciao,
Dscho
