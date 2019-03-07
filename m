Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFDD120248
	for <e@80x24.org>; Thu,  7 Mar 2019 05:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfCGF7d (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 00:59:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:42016 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725446AbfCGF7d (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 00:59:33 -0500
Received: (qmail 14132 invoked by uid 109); 7 Mar 2019 05:59:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 Mar 2019 05:59:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21680 invoked by uid 111); 7 Mar 2019 05:59:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 07 Mar 2019 00:59:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2019 00:59:31 -0500
Date:   Thu, 7 Mar 2019 00:59:31 -0500
From:   Jeff King <peff@peff.net>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How to see raw output from 'make test'?
Message-ID: <20190307055931.GA20646@sigill.intra.peff.net>
References: <CAH8yC8nP+bDQZXHbn+GdVsEEMRYzC45pViYOcB2_FpbYK4nmqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH8yC8nP+bDQZXHbn+GdVsEEMRYzC45pViYOcB2_FpbYK4nmqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 07, 2019 at 12:35:58AM -0500, Jeffrey Walton wrote:

> I built Git 2.2.0 from sources. I added CFLAGS="-DNDEBUG -g2 -O1
> -fsantize=undefined'. Then, a 'make test V=1'. The tests don't produce
> output. For example:
> 
> *** t0021-conversion.sh ***
> ok 1 - setup
> [...]

Try:

  make test GIT_TEST_OPTS=-v

Or if you have a specific test that's failing, you can just do:

  make
  cd t
  ./t0021-conversion.sh -v -i

(the "-i" will stop at the failing test).

-Peff
