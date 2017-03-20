Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A11C20323
	for <e@80x24.org>; Mon, 20 Mar 2017 04:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdCTEcc (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 00:32:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:47392 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751485AbdCTEcc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 00:32:32 -0400
Received: (qmail 25723 invoked by uid 109); 20 Mar 2017 04:32:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 04:32:24 +0000
Received: (qmail 29485 invoked by uid 111); 20 Mar 2017 04:32:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 20 Mar 2017 00:32:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Mar 2017 00:32:20 -0400
Date:   Mon, 20 Mar 2017 00:32:20 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCHv2 2/2] tests: make the 'test_pause' helper work in
 non-verbose mode
Message-ID: <20170320043219.3y4ksmttvcchfpis@sigill.intra.peff.net>
References: <CAM0VKj=k8kygEPpfX+-n0ODd70A8PEYAviKosvc0D34jT02N5w@mail.gmail.com>
 <20170318161400.19753-1-szeder.dev@gmail.com>
 <20170318161400.19753-2-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170318161400.19753-2-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2017 at 05:14:00PM +0100, SZEDER Gábor wrote:

> When the 'test_pause' helper function invokes the shell mid-test, it
> explicitly redirects the shell's stdout and stderr to file descriptors
> 3 and 4, which are the stdout and stderr of the tests (i.e. where they
> would be connected anyway without those redirections).  These file
> descriptors are only attached to the terminal in verbose mode, hence
> the restriction of 'test_pause' to work only with '-v'.
> 
> Redirect the shell's stdout and stderr to the test environment's
> original stdout and stderr, allowing it to work properly even in
> non-verbose mode, and the restriction can be lifted.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
> ---
>  t/test-lib-functions.sh | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)

This makes sense, too. Thanks.

-Peff
