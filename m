Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77130C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5110220842
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 07:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgA0HCk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:02:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:45268 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725840AbgA0HCj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 02:02:39 -0500
Received: (qmail 31779 invoked by uid 109); 27 Jan 2020 07:02:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 07:02:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29251 invoked by uid 111); 27 Jan 2020 07:10:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 02:10:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 02:02:38 -0500
From:   Jeff King <peff@peff.net>
To:     Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: clarify "explicitly given" in push.default
Message-ID: <20200127070238.GA32427@coredump.intra.peff.net>
References: <ed9a0485-1e6c-79ae-6a59-655105203728@googlemail.com>
 <20200125003836.GA568952@coredump.intra.peff.net>
 <b4c31e50-6da5-7699-1069-d94091f768bd@googlemail.com>
 <20200125200554.GC5519@coredump.intra.peff.net>
 <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d8007df9-002b-6db1-4769-d6bf8c338cdf@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 27, 2020 at 08:00:22AM +0100, Bert Wesarg wrote:

> > diff --git a/Documentation/config/push.txt b/Documentation/config/push.txt
> > index 0a0e000569..554ab44b4c 100644
> > --- a/Documentation/config/push.txt
> > +++ b/Documentation/config/push.txt
> > @@ -1,6 +1,7 @@
> >   push.default::
> >   	Defines the action `git push` should take if no refspec is
> > -	explicitly given.  Different values are well-suited for
> > +	explicitly given (either on the command-line or via a
> > +	`remote.*.push` config option). Different values are well-suited for
> >   	specific workflows; for instance, in a purely central workflow
> >   	`upstream` is probably what you want.  Possible values are:
> > 
> 
> I would rather talk about 'implicitly given', if it is via a `remote.*.push` config option:
> 
>  	Defines the action `git push` should take if no refspec is
> -	explicitly given.  Different values are well-suited for
> -	specific workflows; for instance, in a purely central workflow
> -	(i.e. the fetch source is equal to the push destination),
> -	`upstream` is probably what you want.  Possible values are:
> +	neither explicitly (on the command-line) nor implicitly (via a
> +	`remote.*.push` config option) given. Different values are
> +	well-suited for specific workflows; for instance, in a purely
> +	central workflow (i.e. the fetch source is equal to the push
> +	destination), `upstream` is probably what you want.  Possible
> +	values are:

Yeah, that sounds fine. Want to wrap it up with as a patch with a commit
message?

-Peff
