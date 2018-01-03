Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC651F406
	for <e@80x24.org>; Wed,  3 Jan 2018 22:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751432AbeACW2Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 17:28:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:52648 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751029AbeACW2X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 17:28:23 -0500
Received: (qmail 18526 invoked by uid 109); 3 Jan 2018 22:28:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Jan 2018 22:28:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32601 invoked by uid 111); 3 Jan 2018 22:28:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 03 Jan 2018 17:28:54 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jan 2018 17:28:21 -0500
Date:   Wed, 3 Jan 2018 17:28:21 -0500
From:   Jeff King <peff@peff.net>
To:     Isaac Shabtay <isaac@shabtay.com>
Cc:     git@vger.kernel.org
Subject: Re: Bug report: git clone with dest
Message-ID: <20180103222821.GA32287@sigill.intra.peff.net>
References: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK2k7nSsygwRj_Hhrz7-qXZ8UBB=O+deOeC2FFTkrGmWSUpKqA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 03, 2018 at 12:59:48PM -0800, Isaac Shabtay wrote:

> Target directory is deleted on clone failures.
> 
> Steps to reproduce, for example on Windows:
> 
> cd /d %TEMP%
> mkdir dest
> git clone https://some-fake-url/whatever-makes-git-clone-fail dest
> 
> Of course, the clone will fail as it should. But looks like the Git
> client also ends up deleting the "dest" directory.

Interesting. AFAICT Git has behaved this way for almost 9 years, and now
we have two reports in two days. Serendipity, or did something else
change? :)

Anyway, you might be interested in the patch series I posted yesterday:

  https://public-inbox.org/git/20180102210753.GA10430@sigill.intra.peff.net/

-Peff
