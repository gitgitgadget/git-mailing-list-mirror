Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FAC1F428
	for <e@80x24.org>; Thu, 30 Aug 2018 03:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbeH3HaD (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 03:30:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:33434 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727195AbeH3HaD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 03:30:03 -0400
Received: (qmail 2480 invoked by uid 109); 30 Aug 2018 03:30:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 30 Aug 2018 03:30:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22089 invoked by uid 111); 30 Aug 2018 03:30:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 23:30:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 23:30:00 -0400
Date:   Wed, 29 Aug 2018 23:30:00 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: Thank you for public-inbox!
Message-ID: <20180830033000.GD665@sigill.intra.peff.net>
References: <nycvar.QRO.7.76.6.1808271552580.73@tvgsbejvaqbjf.bet>
 <20180829050745.GD15274@sigill.intra.peff.net>
 <20180829100243.GA28180@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829100243.GA28180@dcvr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 10:02:43AM +0000, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
> > I've thought about mirroring it to a public server as well, just for
> > redundancy. But without the same domain, I'm not sure it would be all
> > that useful as a community resource.
> 
> I wouldn't get too attached to the domain, "public-inbox.org" is
> too long for my tastes anyways.  "peff.net/git/$MESSAGE_ID"
> would actually be more user-friendly :>
> 
> A generic Message-ID redirection/finding service would be good,
> (maybe some DHT thing, but... has that taken off for git blobs, yet?)

Yes, and I agree that the URL portability is one of the things I really
love about public-inbox (after all, I do have my own archive and now I
can follow people's public-inbox links into my very-fast local copy).

I guess I just wonder if I set up a mirror on another domain, would
anybody actually _use_ it? I'd think most people would just go to
public-inbox.org as the de facto URL.

> Anyways I hope to teach public-inbox to auto-linkify Message-ID-looking
> strings "<XXXXXXXXXXX@XXXXXXXX>" into URLs for domain-portability,
> (but it's ambiguous with email addresses).  But yeah, I don't
> like things being tied to domain names.

That would be neat, but I think it actually makes references less useful
in a lot of cases. URLs are universally understood, which means:

 - people who don't know about public-inbox can just follow the link
   (and in fact, that's how they learn how useful it is!)

 - even for people who do know about it, they are likely to read mails
   in their MUA. And most MUAs have some mechanism for easily following
   a URL, but won't know how to auto-linkify a message-id.

So I too dream of a world where I can say "give me more information on
this identifier" and my tools search a peer to peer distributed hash
table for it. But I don't think we live in that world yet.

At the very least, I think if we plan to reference without an http URL
that we would use something like URI-ish, like <mid:ABC@XYZ>. That gives
tools a better chance to say "OK, I know how to find message-ids"
(though I still think that it's much less helpful out of the box
compared to an http URL).

-Peff
