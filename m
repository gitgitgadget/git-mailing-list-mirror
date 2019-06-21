Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F6841F461
	for <e@80x24.org>; Fri, 21 Jun 2019 20:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfFUUwl (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 16:52:41 -0400
Received: from cloud.peff.net ([104.130.231.41]:47290 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725985AbfFUUwl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 16:52:41 -0400
Received: (qmail 18287 invoked by uid 109); 21 Jun 2019 20:52:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Jun 2019 20:52:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26294 invoked by uid 111); 21 Jun 2019 20:53:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 21 Jun 2019 16:53:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Jun 2019 16:52:39 -0400
Date:   Fri, 21 Jun 2019 16:52:39 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] Add 'ls-files --json' to dump the index in json
Message-ID: <20190621205238.GD25874@sigill.intra.peff.net>
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619191709.GF28145@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1906211515160.44@tvgsbejvaqbjf.bet>
 <CACsJy8A=Vhwgv8cvs8s2f_aJ5W335s8CdqRQCDSFrdJu2j9fjw@mail.gmail.com>
 <xmqqd0j7km7x.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0j7km7x.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 21, 2019 at 08:10:58AM -0700, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Considering the amount of code to output these, supporting multiple
> > formats would be a nightmare. I may be ok with versioning the output
> > so the tool know what format they need to deal with, but I'd rather
> > support just one version. For third parties wanting to dig deep, I
> > think libgit2 would be a much better fit.
> 
> Yeah, I think starting with --debug=json (or --debug-json) until we
> see some stability in the output and got comfortable to the idea of
> "version X" to mean what we output at that point, and then renaming
> it to "--json" with "version: 1" in the output stream so that third
> party can use it (and interpret it according to version 1 rules) is
> the way to go.  Third-party tools are welcome to read --debug-json
> output as an early-adoption practice waiting for the real thing, but
> we do not want to be locked into a schema too eary before we are
> ready.

I should have read the whole thread before responding. I made a similar
comment to Dscho, so I guess that is now two of us. :)

-Peff
