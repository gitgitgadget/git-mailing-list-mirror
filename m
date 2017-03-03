Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69AAA20133
	for <e@80x24.org>; Fri,  3 Mar 2017 22:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbdCCW3A (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 17:29:00 -0500
Received: from cloud.peff.net ([104.130.231.41]:38375 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752056AbdCCW3A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 17:29:00 -0500
Received: (qmail 14589 invoked by uid 109); 3 Mar 2017 22:22:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 22:22:18 +0000
Received: (qmail 989 invoked by uid 111); 3 Mar 2017 22:22:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 17:22:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 17:22:15 -0500
Date:   Fri, 3 Mar 2017 17:22:15 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org, sschuberth@gmail.com,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
Message-ID: <20170303222215.vwulypicszoh2hds@sigill.intra.peff.net>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
 <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
 <xmqqlgsm9q2i.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgsm9q2i.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 03, 2017 at 10:24:05AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > For those following on the mailing list, there is some discussion at:
> >
> >   https://github.com/git/git/commit/484f78e46d00c6d35f20058671a8c76bb924fb33
> >
> > I think that is mostly focused around another failing in the
> > error-handling of the config code, and that does not need to be
> > addressed by this series (though of course I'd welcome any fixes).
> 
> Thanks.  Without a message like this, the list may have never known
> about the discussion taken elsewhere.  I'd appreciate such a report
> to appear on list the next time much earlier ;-)
> 
> When built with FREAD_READS_DIRECTORIES=Yes on Linux, the error in
> the test can easily reproduce.

Heh. I had no idea we had FREAD_READS_DIRECTORIES. I think Duy and I
reinvented it in another thread. ;)

I agree that may be worth setting on Linux (though note that we _do_
ignore other stdio read errors in the rest of the code path, which may
be something we want to address).

-Peff
