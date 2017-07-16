Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D16520357
	for <e@80x24.org>; Sun, 16 Jul 2017 10:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751247AbdGPKrV (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 06:47:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:41994 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751048AbdGPKrV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 06:47:21 -0400
Received: (qmail 25264 invoked by uid 109); 16 Jul 2017 10:47:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 10:47:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24836 invoked by uid 111); 16 Jul 2017 10:47:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Jul 2017 06:47:34 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Jul 2017 06:47:19 -0400
Date:   Sun, 16 Jul 2017 06:47:19 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] t: handle EOF in test_copy_bytes()
Message-ID: <20170716104718.i4nyphyzqh2mzhxt@sigill.intra.peff.net>
References: <20170716104532.zyni62mvzz6rglu6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170716104532.zyni62mvzz6rglu6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 16, 2017 at 06:45:32AM -0400, Jeff King wrote:

> I was playing with SANITIZE=undefined after René's patches to see how
> far we had left to go. I forgot to turn off sha1dc, which causes most
> programs to die due to the unaligned loads. That means git-archive in
> t5000 generates no output, triggering the bug. :)

And I was pleased to see that after setting OPENSSL_SHA1, the answer to
"how far" is "we are there". Yay.

-Peff
