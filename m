Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02741F453
	for <e@80x24.org>; Fri, 19 Oct 2018 19:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeJTDQU (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 23:16:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:46854 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727526AbeJTDQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 23:16:20 -0400
Received: (qmail 31399 invoked by uid 109); 19 Oct 2018 19:08:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Oct 2018 19:08:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14494 invoked by uid 111); 19 Oct 2018 19:08:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Oct 2018 15:08:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2018 15:08:56 -0400
Date:   Fri, 19 Oct 2018 15:08:56 -0400
From:   Jeff King <peff@peff.net>
To:     Ben Peart <peartben@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [PATCH v2 2/3] reset: add new reset.quiet config setting
Message-ID: <20181019190856.GC24418@sigill.intra.peff.net>
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181019161228.17196-1-peartben@gmail.com>
 <20181019161228.17196-3-peartben@gmail.com>
 <CAPig+cSL9=mmvdq9J9VXF67=010E1eZBjrYYaYQDN1z1OEf0CA@mail.gmail.com>
 <20181019164631.GB24740@sigill.intra.peff.net>
 <CAPig+cR7=OpNsuZu+ppdyDvt5HAHMdDj4cBVg2U34B_j2zZ03g@mail.gmail.com>
 <20181019171130.GA20834@sigill.intra.peff.net>
 <38b9f813-0463-3d15-ad9d-86f64c140043@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <38b9f813-0463-3d15-ad9d-86f64c140043@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 19, 2018 at 01:23:06PM -0400, Ben Peart wrote:

> > > Okay. In any case, --no-quiet probably ought to be mentioned alongside
> > > the "reset.quiet" option (and perhaps in git-reset.txt to as a way to
> > > reverse "reset.quiet").
> [...]
> Makes sense.  I'll update the docs to say:
> 
> -q::
> --quiet::
> --no-quiet::
> 	Be quiet, only report errors.
> +
> With --no-quiet report errors and unstaged changes after reset.

I think we should be explicit that "--no-quiet" is already the default,
which makes it easy to mention the config option. Something like:

  -q::
  --quiet::
  --no-quiet::
	Be quiet, only report errors. The default behavior respects the
	`reset.quiet` config option, or `--no-quiet` if that is not set.

I don't know if we need to mention the "unstaged changes" thing. We may
grow other non-error messages (or may even have some now, I didn't
check). But I'm OK including it, too.

-Peff
