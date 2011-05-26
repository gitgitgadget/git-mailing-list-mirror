From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] format-patch: preserve subject newlines with -k
Date: Thu, 26 May 2011 18:24:50 -0400
Message-ID: <20110526222450.GA20077@sigill.intra.peff.net>
References: <20110526203625.GA31018@sigill.intra.peff.net>
 <20110526205504.GC31340@sigill.intra.peff.net>
 <7vboypw47q.fsf@alter.siamese.dyndns.org>
 <20110526211952.GA32097@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 27 00:24:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPizC-0006P2-D3
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758570Ab1EZWYx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 18:24:53 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33253
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450Ab1EZWYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:24:53 -0400
Received: (qmail 18552 invoked by uid 107); 26 May 2011 22:24:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 18:24:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 18:24:50 -0400
Content-Disposition: inline
In-Reply-To: <20110526211952.GA32097@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174585>

On Thu, May 26, 2011 at 05:19:52PM -0400, Jeff King wrote:

> > >  	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
> > > -		      encoding, need_8bit_cte);
> > > +		      encoding, need_8bit_cte, 0);
> > 
> > I do not appreciate a single-bit tweak as separate parameter to a
> > function.  Back when pp_title_line() had only "do we need 8-bit cte", it
> > was Ok, but now that you are adding another bit, could we make it an
> > "unsigned flag"?
> 
> Actually, I wonder if we can refactor to just pass the pretty_context to
> pp_title_line. Let me see what I can do.

It ends up being a lot of lines changed, but I think the result is more
readable. Replace my 3/3 with (1/5 and 2/5 are the same as before):

  [3/5]: pretty: add pp_commit_easy function for simple callers
  [4/5]: clean up calling conventions for pretty.c functions
  [5/5]: format-patch: preserve subject newlines with -k

-Peff
