From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Mon, 31 Aug 2015 18:05:09 -0400
Message-ID: <20150831220508.GA31973@sigill.intra.peff.net>
References: <20150831204444.GA4385@sigill.intra.peff.net>
 <20150831204831.GB10338@sigill.intra.peff.net>
 <20150831212754.GD30659@serenity.lan>
 <20150831213336.GA11720@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Sep 01 00:05:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWXCY-0001IZ-NP
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 00:05:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752871AbbHaWFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 18:05:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:52734 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752266AbbHaWFL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 18:05:11 -0400
Received: (qmail 4545 invoked by uid 102); 31 Aug 2015 22:05:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 17:05:11 -0500
Received: (qmail 27989 invoked by uid 107); 31 Aug 2015 22:05:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 18:05:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 18:05:09 -0400
Content-Disposition: inline
In-Reply-To: <20150831213336.GA11720@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276949>

On Mon, Aug 31, 2015 at 05:33:37PM -0400, Jeff King wrote:

> > diff --git a/date.c b/date.c
> > index aa57cad..3aa8002 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -817,9 +817,7 @@ void parse_date_format(const char *format, struct date_mode *mode)
> >  		if (!skip_prefix(p, ":", &p))
> >  			die("date format missing colon separator: %s", format);
> >  		mode->strftime_fmt = xstrdup(p);
> > -	}
> > -
> > -	if (*p)
> > +	} else if (*p)
> >  		die("unknown date-mode modifier: %s", p);
> 
> Yeah, that works. We could also advance "p" in the DATE_STRFTIME
> conditional, but I think your solution is less ugly.
> 
> Thanks for debugging my mess.

By the way, I was imagining you would pick these up and add to them with
more tests and documentation. If that's the case, please feel free to
squash that in and keep my signoff. If not, then I can post a re-roll
after waiting for other comments.

-Peff
