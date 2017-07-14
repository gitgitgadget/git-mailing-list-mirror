Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9605F202DD
	for <e@80x24.org>; Fri, 14 Jul 2017 11:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753577AbdGNLuw (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 07:50:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:40528 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753486AbdGNLuv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 07:50:51 -0400
Received: (qmail 15151 invoked by uid 109); 14 Jul 2017 11:50:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 11:50:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10329 invoked by uid 111); 14 Jul 2017 11:50:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 07:50:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 07:50:43 -0400
Date:   Fri, 14 Jul 2017 07:50:43 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 03/15] t: use test_decode_color rather than literal ANSI
 codes
Message-ID: <20170714115043.5sqytmol4hwehfwv@sigill.intra.peff.net>
References: <20170713145553.3epnsw23zajwg3ee@sigill.intra.peff.net>
 <20170713145841.4win5tbx4efwjsa2@sigill.intra.peff.net>
 <CAGZ79kaE7wjFR-=DiPU5xwknS1nxDHR5+S6+UGPFTF0uNBA3dQ@mail.gmail.com>
 <20170713184541.ferc3eif7j4mazpg@sigill.intra.peff.net>
 <xmqqeftkw30y.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeftkw30y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 12:27:41PM -0700, Junio C Hamano wrote:

> > I agree it's a bit gross. Possibly:
> >
> >   git log --format='%C(auto)%d %s'
> >
> > would be easier for the test to parse (I'm pretty sure that didn't exist
> > back when this test was written).
> 
> Yeah, that may make the test easier to read, too.

I started on that, but the test is actually checking the coloring of the
commit message, too. So switching to a custom format would lose that
part of the test.

-Peff
