Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 099BD20987
	for <e@80x24.org>; Sat,  1 Oct 2016 09:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750868AbcJAJSc (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Oct 2016 05:18:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:50805 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750818AbcJAJSb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2016 05:18:31 -0400
Received: (qmail 17651 invoked by uid 109); 1 Oct 2016 09:18:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Oct 2016 09:18:30 +0000
Received: (qmail 17013 invoked by uid 111); 1 Oct 2016 09:18:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 01 Oct 2016 05:18:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Oct 2016 05:18:28 -0400
Date:   Sat, 1 Oct 2016 05:18:28 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "Kyle J. McKay" <mackyle@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] pretty: allow formatting DATE_SHORT
Message-ID: <20161001091828.k4odmjv73haa5vyl@sigill.intra.peff.net>
References: <CA+P7+xoxTpqn=jkuHYp5pKCCWfKLP5OKCTBYkcTVw_RhEw0KVw@mail.gmail.com>
 <20160930105639.15589-1-szeder@ira.uka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160930105639.15589-1-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 30, 2016 at 12:56:39PM +0200, SZEDER Gábor wrote:

> > Nice. I use date=short in some of my aliases and switching to this is
> > nicer. I assume this turns into "%(as)"?
> > 
> > What about documenting this in  pretty-formats.txt?
> 
> Here you go :)
> 
>   http://public-inbox.org/git/1444235305-8718-1-git-send-email-szeder@ira.uka.de/

The review on that thread is basically "do we want to add every
abbreviation under the sun, or do we want to come up with a better
placeholder scheme?". And that has come up several other times (e.g.,
Ted's recent %gt placeholder).

I _do_ think that's the right way forward, but as nobody has been
pushing it that way, and these things come up from time to time, maybe
we should just accept it and add the ones people want in the interim.
It's not like it makes the situation significantly worse, or harder to
migrate to %(authordate:short).

-Peff
