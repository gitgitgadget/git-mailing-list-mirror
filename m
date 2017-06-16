Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 131A21FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 20:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751789AbdFPUmL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 16:42:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:41755 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750903AbdFPUmL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 16:42:11 -0400
Received: (qmail 15593 invoked by uid 109); 16 Jun 2017 20:42:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 20:42:10 +0000
Received: (qmail 8595 invoked by uid 111); 16 Jun 2017 20:42:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Jun 2017 16:42:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Jun 2017 16:42:08 -0400
Date:   Fri, 16 Jun 2017 16:42:08 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Langley <agl@google.com>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170616204208.ak5twydrloxefm42@sigill.intra.peff.net>
References: <20170615110518.ordr43idf2jluips@glandium.org>
 <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com>
 <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
 <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
 <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
 <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
 <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
 <87y3ss8n4h.fsf@gmail.com>
 <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2017 at 03:24:19PM +0200, Johannes Schindelin wrote:

> I have no doubt that Visual Studio Team Services, GitHub and Atlassian
> will eventually end up with FPGAs for hash computation. So that's that.

I actually doubt this from the GitHub side. Hash performance is not even
on our radar as a bottleneck. In most cases the problem is touching
uncompressed data _at all_, not computing the hash over it (so things
like reusing on-disk deltas are really important).

-Peff
