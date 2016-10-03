Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF30207EC
	for <e@80x24.org>; Mon,  3 Oct 2016 21:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbcJCV6p (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 17:58:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:51569 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751657AbcJCV6o (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 17:58:44 -0400
Received: (qmail 23200 invoked by uid 109); 3 Oct 2016 21:58:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 21:58:43 +0000
Received: (qmail 30809 invoked by uid 111); 3 Oct 2016 21:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 17:58:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 17:58:40 -0400
Date:   Mon, 3 Oct 2016 17:58:40 -0400
From:   Jeff King <peff@peff.net>
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] http: http.emptyauth should allow empty (not just NULL)
 usernames
Message-ID: <20161003215840.6ihqjtplkcsporiw@sigill.intra.peff.net>
References: <1475515168-29679-1-git-send-email-dturner@twosigma.com>
 <20161003210100.t5nqknwfotag3lmj@sigill.intra.peff.net>
 <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <335996ca2642478386e94d9f3dc43223@exmbdft7.ad.twosigma.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 03, 2016 at 09:54:19PM +0000, David Turner wrote:

> > I dunno. The code path you are changing _only_ affects anything if the
> > http.emptyauth config is set. But I guess I just don't understand why you
> > would say "http://@gitserver" in the first place. Is that a common thing?
> 
> I have no idea if it is common.  I know that we do it.

I guess my question is: _why_ do you do it? Or more specifically, does
http://gitserver.example.com" with http.emptyauth not work, and why?

From your response, I _think_ the answer is "no, it doesn't, and I have
no clue why".

So I dunno. It is annoying not to know what is actually going on, but
I'm OK with it if we don't think there's a high chance of regressing any
other workflows (which I guess not, because http.emptyauth seems to be a
Kerberos-specific hack in the first place).

-Peff
