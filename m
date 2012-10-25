From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Thu, 25 Oct 2012 06:08:54 -0400
Message-ID: <20121025100854.GN8390@sigill.intra.peff.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
 <20121024192530.GA26477@sigill.intra.peff.net>
 <20121024210826.GA23562@shrek.podlesie.net>
 <20121025090149.GC8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 12:09:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRKNC-0002It-45
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 12:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935184Ab2JYKI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 06:08:57 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:56083 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935025Ab2JYKI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 06:08:56 -0400
Received: (qmail 7362 invoked by uid 107); 25 Oct 2012 10:09:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 06:09:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 06:08:54 -0400
Content-Disposition: inline
In-Reply-To: <20121025090149.GC8390@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208381>

On Thu, Oct 25, 2012 at 05:01:49AM -0400, Jeff King wrote:

> > -	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject) &&
> > -			($subject =~ /[^[:ascii:]]/)) {
> > -		$subject = quote_rfc2047($subject, $auto_8bit_encoding);
> > +	if ($broken_encoding{$t} && !is_rfc2047_quoted($subject)) {
> > +		$subject = quote_subject($subject, $auto_8bit_encoding);
> >  	}
> 
> Hmm. What is this patch on top of? It looks like it is on top of your
> original patch, but when I tried it on top of that, it does not apply
> either, and the index lines in the patch do not mention a sha1 that I do
> not have.
>
> Do you mind re-rolling a final 2-patch series with:

Ah, never mind. I missed your earlier "use compose-encoding for
Subject". I've queued it and all of the follow-ons onto the
km/send-email-compose-encoding topic.

Thanks.

-Peff
