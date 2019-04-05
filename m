Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E34620248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbfDESqc (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:46:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:48888 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731183AbfDESqc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:46:32 -0400
Received: (qmail 12509 invoked by uid 109); 5 Apr 2019 18:46:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:46:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28720 invoked by uid 111); 5 Apr 2019 18:46:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:46:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:46:30 -0400
Date:   Fri, 5 Apr 2019 14:46:30 -0400
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] asciidoctor-extensions: provide `<refmiscinfo/>`
Message-ID: <20190405184629.GF2284@sigill.intra.peff.net>
References: <20190323192756.GK4047@pobox.com>
 <20190324121619.GD312@sigill.intra.peff.net>
 <20190324162131.GL4047@pobox.com>
 <20190325150633.GC19929@sigill.intra.peff.net>
 <20190325190041.GM4047@pobox.com>
 <20190327010603.GR4047@pobox.com>
 <20190328000612.GA12419@genre.crustytoothpaste.net>
 <20190330180014.GB4047@pobox.com>
 <20190330210457.GC12419@genre.crustytoothpaste.net>
 <20190405021721.GS4047@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405021721.GS4047@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 04, 2019 at 10:17:21PM -0400, Todd Zullinger wrote:

> Elsewhere in this thread, Jeff made the very valid point
> that we're probably wise to keep using the docbook/xmlto
> chain as long as we're supporting both asciidoc and
> asciidoctor.  Unless it turns out that it's more work to
> coax asciidoctor (and the various 1.5 and 2.0 releases in
> common use) to work with that same docbook/xmlto chain than
> it is to do it directly, that is.

One of my secret (maybe not so secret?) implications there was that it
might be worth dropping asciidoc support sooner rather than later. I.e.,
if it is a burden to make it work with both old and new systems, then
let's make the jump to having it work with the new system.

IMHO we can be a bit more cavalier with saying "you must have a
recent-ish asciidoctor to build the docs", because it's so easy for us
to provide a binary distribution of the built HTML and manpages (in
fact, we already do so for the install-man-quick target).

So it doesn't really leave any platforms out in the cold; it just means
they have to tweak their build procedure.

-Peff
