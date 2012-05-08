From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout: squelch "'mode' may be used uninitialized in
 this function" warning
Date: Tue, 8 May 2012 16:26:49 -0400
Message-ID: <20120508202649.GA15502@sigill.intra.peff.net>
References: <1335825567-7831-1-git-send-email-dsp@php.net>
 <slrnjq4p8c.i00.dsp@experimentalworks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Soria Parra <dsp@php.net>
X-From: git-owner@vger.kernel.org Tue May 08 22:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRqzo-0003pS-OT
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 22:26:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049Ab2EHU0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 16:26:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34385
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757027Ab2EHU0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 16:26:51 -0400
Received: (qmail 8022 invoked by uid 107); 8 May 2012 20:27:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 16:27:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 16:26:49 -0400
Content-Disposition: inline
In-Reply-To: <slrnjq4p8c.i00.dsp@experimentalworks.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197421>

On Thu, May 03, 2012 at 10:59:24AM +0000, David Soria Parra wrote:

> Any update on this patch? Is it going to maint?

I doubt it:

> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index 84d3eb3..6b8bf31 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -157,7 +157,7 @@ static int checkout_merged(int pos, struct checkout *state)
> >  	unsigned char sha1[20];
> >  	mmbuffer_t result_buf;
> >  	unsigned char threeway[3][20];
> > -	unsigned mode;
> > +	unsigned mode = mode;

What is this based on? This has been fixed since 335c6e4
(checkout_merged(): squelch false warning from some gcc, 2011-12-15),
which was in v1.7.8.2.

-Peff
