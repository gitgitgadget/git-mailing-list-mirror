Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194501FD99
	for <e@80x24.org>; Wed, 10 Aug 2016 19:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S940585AbcHJTGu (ORCPT <rfc822;e@80x24.org>);
	Wed, 10 Aug 2016 15:06:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:53076 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932994AbcHJTGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2016 15:06:48 -0400
Received: (qmail 27536 invoked by uid 109); 10 Aug 2016 13:40:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 13:40:06 +0000
Received: (qmail 32507 invoked by uid 111); 10 Aug 2016 13:40:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Aug 2016 09:40:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Aug 2016 09:40:04 -0400
Date:	Wed, 10 Aug 2016 09:40:04 -0400
From:	Jeff King <peff@peff.net>
To:	Lars Schneider <larsxschneider@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org, Johannes.Schindelin@gmx.de,
	ben@wijen.net
Subject: Re: [PATCH v5 04/15] pkt-line: add packet_write_gently()
Message-ID: <20160810134003.q6mzgkcrwmkxv5fw@sigill.intra.peff.net>
References: <20160803164225.46355-1-larsxschneider@gmail.com/>
 <20160810130411.12419-1-larsxschneider@gmail.com>
 <20160810130411.12419-5-larsxschneider@gmail.com>
 <20160810132814.gqnipsdwyzjmuqjy@sigill.intra.peff.net>
 <434CB5D7-3FC0-4398-9028-135701121E55@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <434CB5D7-3FC0-4398-9028-135701121E55@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 03:36:45PM +0200, Lars Schneider wrote:

> > So now we have packet_write() and packet_write_gently(), but they differ
> > in more than just whether they are gentle. That seems like a weird
> > interface.
> > 
> > Should we either be picking a new name (e.g., packet_write_mem() or
> > something), or migrating packet_write() to packet_write_fmt()?
> 
> Done in "[PATCH v5 08/15] pkt-line: rename packet_write() to packet_write_fmt()"

Ah, OK. Generally I'd suggest to reorder things so that each patch looks
like a step forward (and so the early patches become preparatory steps,
and the justification in them is something like "we're going to add more
write functions, so let's give this a more descriptive name").

> I agree. In a later patch I am using PKTLINE_DATA_MAXLEN inside pkt-line.c,
> too. I will change it to your suggestion.
> 
> For now I would remove PKTLINE_DATA_MAXLEN because it should be an implementation
> detail of pkt-line.c (plus it is not used by anyone).

Sounds reasonable.

-Peff
