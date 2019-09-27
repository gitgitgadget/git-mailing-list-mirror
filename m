Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494801F463
	for <e@80x24.org>; Fri, 27 Sep 2019 22:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbfI0WS7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 18:18:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:34162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725306AbfI0WS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 18:18:59 -0400
Received: (qmail 12374 invoked by uid 109); 27 Sep 2019 22:18:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 27 Sep 2019 22:18:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14569 invoked by uid 111); 27 Sep 2019 22:21:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Sep 2019 18:21:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 27 Sep 2019 18:18:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190927221857.GB31237@sigill.intra.peff.net>
References: <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
 <20190923165828.GA27068@szeder.dev>
 <nycvar.QRO.7.76.6.1909261257160.15067@tvgsbejvaqbjf.bet>
 <20190926132852.GF2637@szeder.dev>
 <nycvar.QRO.7.76.6.1909262138450.15067@tvgsbejvaqbjf.bet>
 <20190926214448.GI2637@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190926214448.GI2637@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 26, 2019 at 11:44:48PM +0200, SZEDER Gábor wrote:

> All that was over a year and a half ago, and these limitations weren't
> a maintenance burden at all so far, and nobody needed that escape
> hatch.
> 
> Well, nobody except me, that is :)  When I saw back then that t1510
> saves the stderr of nested function calls with 7 parameters, I
> shrugged in disgust, admitted defeat, and simply reached for that
> escape hatch: partly because I couldn't be bothered to figure out how
> that test script works, but more importantly because I didn't want to
> risk that any cleanup inadvertently hides a bug in the future.
> 
> So that's the only user that piece of code ever had, and I certainly
> hope that no other test script will ever grow so complicated that it
> will need this escape hatch.  I would actually prefer to remove it,
> but t1510 must be cleaned up first...  so I'm afraid it will be with
> us for a while.

I'm actually surprised we haven't run into it more. We have some custom
test scripts in our fork of Git at GitHub. We usually just use
TEST_SHELL_PATH=bash, but curious, I tried running with dash and "-x",
and three of them failed.

Probably they'd be easy enough to fix (and they're out of tree anyway),
so I'm not really arguing against the escape hatch exactly. Mostly I'm
just surprised that if I introduced 3 cases (out of probably a dozen
scripts), I'm surprised that more contributors aren't accidentally doing
so upstream.

-Peff
