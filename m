Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A58761FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 13:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754980AbcLSNlw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 08:41:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:58405 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754764AbcLSNlv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 08:41:51 -0500
Received: (qmail 3626 invoked by uid 109); 19 Dec 2016 13:41:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 13:41:50 +0000
Received: (qmail 29567 invoked by uid 111); 19 Dec 2016 13:42:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 08:42:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2016 08:41:48 -0500
Date:   Mon, 19 Dec 2016 08:41:48 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
Message-ID: <20161219134148.vxa4fz3jw2i23lfm@sigill.intra.peff.net>
References: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
 <20161219120719.GF24125@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161219120719.GF24125@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 07:07:19PM +0700, Duy Nguyen wrote:

> On Wed, Dec 14, 2016 at 10:10:10AM -0500, Jeff King wrote:
> > diff --git a/parse-options.c b/parse-options.c
> > index 312a85dbd..4fbe924a5 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -661,7 +661,7 @@ void NORETURN usage_msg_opt(const char *msg,
> >  		   const char * const *usagestr,
> >  		   const struct option *options)
> >  {
> > -	fprintf(stderr, "%s\n\n", msg);
> > +	fprintf(stderr, "fatal: %s\n\n", msg);
> 
> Your commit message does not make clear if you want this "fatal" to be
> grep-able (by scripts) or not. If not, please _() the string.  Maybe
> this to reduce work for translators
> 
> 	/* TRANSLATORS: this is the prefix before usage error */
> 	fprintf(stderr, "%s %s\n\n", _("fatal:"), msg);

I don't think we translate any of our "fatal:", "error:", etc, do we?
It certainly doesn't look like it in usage.c.

-Peff
