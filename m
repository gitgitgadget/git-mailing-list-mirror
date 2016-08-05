Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A27A2018E
	for <e@80x24.org>; Fri,  5 Aug 2016 08:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934727AbcHEIBP (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 04:01:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:55154 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758500AbcHEIAU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 04:00:20 -0400
Received: (qmail 10480 invoked by uid 102); 5 Aug 2016 08:00:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 04:00:22 -0400
Received: (qmail 24077 invoked by uid 107); 5 Aug 2016 08:00:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Aug 2016 04:00:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Aug 2016 04:00:17 -0400
Date:	Fri, 5 Aug 2016 04:00:17 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 4/7] trace: cosmetic fixes for error messages
Message-ID: <20160805080016.tne7lvvvaw3viot2@sigill.intra.peff.net>
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
 <20160803230022.drw4kcwgheeqn3xr@sigill.intra.peff.net>
 <xmqqfuqk1d23.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuqk1d23.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 04, 2016 at 01:42:12PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it would be nicer to still to print:
> >
> >  warning: first line
> >  warning: second line
> >
> > etc. We do that for "advice:", but not the rest of the vreportf
> > functions. It might be nice to do that, but we'd have to go back to
> > printing into a buffer (since we can't break up the incoming format
> > string that we feed to fprintf).
> 
> Yes, yes.

Actually, I guess in this case we could easily do:

   warning("something");
   warning("something else");

etc (the lines are fairly stand-alone, so I don't think it runs afoul of
the usual translator-lego problem; not to mention that these aren't
actually translated). I don't really care that much between that and the
indented output, but if there's a preference, I'm happy to re-roll with
that.

-Peff
