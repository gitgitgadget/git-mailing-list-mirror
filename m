Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77D091F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 19:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754254AbcJETGe (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 15:06:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:53019 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754069AbcJETGd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 15:06:33 -0400
Received: (qmail 8359 invoked by uid 109); 5 Oct 2016 19:06:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 19:06:32 +0000
Received: (qmail 20960 invoked by uid 111); 5 Oct 2016 19:06:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Oct 2016 15:06:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Oct 2016 15:06:30 -0400
Date:   Wed, 5 Oct 2016 15:06:30 -0400
From:   Jeff King <peff@peff.net>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH v2 1/5] check_connected: accept an env argument
Message-ID: <20161005190630.igp4bhdmpp2porc6@sigill.intra.peff.net>
References: <20161003204851.klwspo6agykx6s3q@sigill.intra.peff.net>
 <20161003204908.3nlg6xq2whg2senj@sigill.intra.peff.net>
 <6ed4670d-6835-a45e-2842-cfe65b0e2981@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ed4670d-6835-a45e-2842-cfe65b0e2981@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 05, 2016 at 09:01:57PM +0200, Jakub Narębski wrote:

> > diff --git a/connected.h b/connected.h
> > index afa48cc..4ca325f 100644
> > --- a/connected.h
> > +++ b/connected.h
> > @@ -33,6 +33,11 @@ struct check_connected_options {
> >  
> >  	/* If non-zero, show progress as we traverse the objects. */
> >  	int progress;
> > +
> > +	/*
> > +	 * Insert these variables into the environment of the child process.
> > +	 */
> > +	const char **env;
> >  };
> 
> Just a nitpick, but I wonder why one comment is in single-line form,
> and the other uses block-form with a single line.

I think I wrote something longer originally, and then shortened it
before sending.

I don't generally think it matters much for a case like this (if it were
in the middle of code, I think the shorter form is worth doing, but here
it's basically a header for this variable).

-Peff
