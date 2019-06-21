Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D737C1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFUUsR (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:48:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:47268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726080AbfFUUsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:48:16 -0400
Received: (qmail 18250 invoked by uid 109); 21 Jun 2019 20:48:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Jun 2019 20:48:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26256 invoked by uid 111); 21 Jun 2019 20:49:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Jun 2019 16:49:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2019 16:48:14 -0400
Date:   Fri, 21 Jun 2019 16:48:14 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
Message-ID: <20190621204814.GB25874@sigill.intra.peff.net>
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619191709.GF28145@sigill.intra.peff.net>
 <CACsJy8AYw1QLjWALUNr7hSZemWyTSG0U8Fc_TH=9HNR-LcygTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8AYw1QLjWALUNr7hSZemWyTSG0U8Fc_TH=9HNR-LcygTg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 03:37:45PM +0700, Duy Nguyen wrote:

> On Thu, Jun 20, 2019 at 2:17 AM Jeff King <peff@peff.net> wrote:
> > I think your warning in the manpage that this is for debugging is fine,
> > as it does not put us on the hook for maintaining the feature nor its
> > format forever. We might want to call it "--debug=json" or something,
> 
> Hmm.. does it mean we make --debug PARSE_OPT_OPTARG? In other words,
> "--debug" still means "text", --debug=json is obvious, but "--debug
> json" means "text" debug with  pathspec "json". Which is really
> horrible in my opinion.

Yeah, that's the nature of OPTARG. ;)

> Or is it ok to just make the argument mandatory? That would be a
> behavior change, but I suppose --debug is a thing only we use and
> could still be a safe thing to do...

Yeah, I think that would be perfectly fine (or you could just call it
--debug-json as a new option, if you didn't want to make people do
--debug=text for the existing behavior).

-Peff
