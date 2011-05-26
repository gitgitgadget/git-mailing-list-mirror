From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] format-patch: preserve subject newlines with -k
Date: Thu, 26 May 2011 17:19:52 -0400
Message-ID: <20110526211952.GA32097@sigill.intra.peff.net>
References: <20110526203625.GA31018@sigill.intra.peff.net>
 <20110526205504.GC31340@sigill.intra.peff.net>
 <7vboypw47q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:20:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhyK-00032X-B8
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:20:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758483Ab1EZVTz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:19:55 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56733
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758350Ab1EZVTz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:19:55 -0400
Received: (qmail 17982 invoked by uid 107); 26 May 2011 21:19:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 17:19:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 17:19:52 -0400
Content-Disposition: inline
In-Reply-To: <7vboypw47q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174574>

On Thu, May 26, 2011 at 02:18:33PM -0700, Junio C Hamano wrote:

> > diff --git a/builtin/log.c b/builtin/log.c
> > index d8c6c28..3fdf488 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -768,7 +768,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
> >  	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
> >  		     encoding);
> >  	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
> > -		      encoding, need_8bit_cte);
> > +		      encoding, need_8bit_cte, 0);
> 
> I do not appreciate a single-bit tweak as separate parameter to a
> function.  Back when pp_title_line() had only "do we need 8-bit cte", it
> was Ok, but now that you are adding another bit, could we make it an
> "unsigned flag"?

Actually, I wonder if we can refactor to just pass the pretty_context to
pp_title_line. Let me see what I can do.

-Peff
