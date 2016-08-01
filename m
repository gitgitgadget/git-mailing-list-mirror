Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6679A1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754340AbcHARyW (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:54:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:52627 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754274AbcHARyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:54:20 -0400
Received: (qmail 8516 invoked by uid 102); 1 Aug 2016 17:47:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:47:27 -0400
Received: (qmail 15202 invoked by uid 107); 1 Aug 2016 17:47:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 13:47:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 13:47:24 -0400
Date:	Mon, 1 Aug 2016 13:47:24 -0400
From:	Jeff King <peff@peff.net>
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] format-patch: Transition the default to --from to
 avoid spoofed mails
Message-ID: <20160801174724.m4ags4ag4ftwoafj@sigill.intra.peff.net>
References: <20160730181246.4aifnvqfeenddzdl@x>
 <20160730191104.2ps5k7eji7aqgufg@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160730191104.2ps5k7eji7aqgufg@x>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 12:11:05PM -0700, Josh Triplett wrote:

> Josh Triplett (2):
>   format-patch: Add a config option format.from to set the default for --from
>   format-patch: Default to --from

By the way, I notice that the threading between your patches and cover
letter are broken. Since I see you are also working on a tool for
handling such things, I'd suspect the tool (or your workflow) has a bug.
:)

The message-id of this message is:

  <20160730191104.2ps5k7eji7aqgufg@x>

but the patches have both "References" and "In-Reply-To" set to:

  <cover.4d006cadf197f80d899ad7d7d56d8ba41f574adf.1469905775.git-series.josh@joshtriplett.org>

I also see your MUA is mutt, and I think I saw you mention using "mutt
-H" elsewhere. IIRC, when I started using a similar workflow years ago,
I tried the same thing and had the same problem: "-H" treats the input
file as a template, not a message, and thus generates a new message-id.

I switched to using mutt's internal "resend-message" function, which
does a more literal re-send. I don't think I ever found a way to
convince mutt to do a resend from the command line.

-Peff
