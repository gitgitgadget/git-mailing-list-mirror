Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 821381F463
	for <e@80x24.org>; Mon, 23 Sep 2019 18:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440439AbfIWSTw (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 14:19:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:57378 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2438362AbfIWSTw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 14:19:52 -0400
Received: (qmail 29050 invoked by uid 109); 23 Sep 2019 18:19:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 23 Sep 2019 18:19:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27662 invoked by uid 111); 23 Sep 2019 18:22:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Sep 2019 14:22:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 23 Sep 2019 14:19:51 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
Message-ID: <20190923181950.GB21344@sigill.intra.peff.net>
References: <20190827051756.GA12795@sigill.intra.peff.net>
 <20190913200317.68440-1-jonathantanmy@google.com>
 <20190913205148.GA8799@sigill.intra.peff.net>
 <20190916184208.GB17913@google.com>
 <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev>
 <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 23, 2019 at 02:47:23PM +0200, Johannes Schindelin wrote:

> The evaluation of the lazy prereq is indeed not different between Bash
> or dash. It is nevertheless quite disruptive in the trace of a test
> script, especially when it is evaluated for a test case that is skipped
> explicitly via the `--run` option.

That sounds like a bug: if we know we are not going to run the test
anyway due to --run or GIT_TEST_SKIP, we should probably avoid checking
the prereq at all.

-Peff
