Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 973A82022A
	for <e@80x24.org>; Sat,  5 Nov 2016 04:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbcKEElb (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Nov 2016 00:41:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:39000 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbcKEEla (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2016 00:41:30 -0400
Received: (qmail 8985 invoked by uid 109); 5 Nov 2016 04:41:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Nov 2016 04:41:30 +0000
Received: (qmail 29122 invoked by uid 111); 5 Nov 2016 04:41:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Nov 2016 00:41:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Nov 2016 00:41:27 -0400
Date:   Sat, 5 Nov 2016 00:41:27 -0400
From:   Jeff King <peff@peff.net>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Regarding "git log" on "git series" metadata
Message-ID: <20161105044127.tm7tmpcgnw7eeian@sigill.intra.peff.net>
References: <xmqqa8dfdt6y.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xq0LLFBJRNNvCMQ4QR7XBg9H7NSsifiqOYqr+PUBqYRGQ@mail.gmail.com>
 <20161104194907.3yxu2rkayfyic4dr@sigill.intra.peff.net>
 <CA+P7+xpwUZscpgzLJYf5vkKKsT6SFkC3TrsyBJXJjGo9cF94nQ@mail.gmail.com>
 <20161105014817.vm4ush2wfbblzsc7@sigill.intra.peff.net>
 <A269CCA2-5F8C-4AF0-820E-2EA26FEF03D5@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A269CCA2-5F8C-4AF0-820E-2EA26FEF03D5@joshtriplett.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 04, 2016 at 09:55:23PM -0600, Josh Triplett wrote:

> >> Is it possible currently for a protocol extension to result in "oh
> >the
> >> server doesn't support this so I'm going to stop pushing"?
> >
> >Yes, it would be easy for the client to abort if the server fails to
> >advertise a particular extension.
> 
> And the reverse (old client, new server) should work as well?

Yes. The server says "I know about gitrefs" and if the client does not
respond with "I also know about gitrefs", then the server can act
appropriately (e.g., for a fetch, bail if the fetched content includes
gitrefs).

-Peff
