From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/9] http: update base URLs when we see redirects
Date: Fri, 18 Oct 2013 14:42:50 -0400
Message-ID: <20131018184250.GA11040@sigill.intra.peff.net>
References: <20130928082956.GA22610@sigill.intra.peff.net>
 <20130928083405.GA2782@sigill.intra.peff.net>
 <xmqqk3hawi5y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Kyle J. McKay" <mackyle@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 18 20:42:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VXF0j-00046s-DI
	for gcvg-git-2@plane.gmane.org; Fri, 18 Oct 2013 20:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab3JRSmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Oct 2013 14:42:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:51666 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756920Ab3JRSmx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Oct 2013 14:42:53 -0400
Received: (qmail 22217 invoked by uid 102); 18 Oct 2013 18:42:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Oct 2013 13:42:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Oct 2013 14:42:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqk3hawi5y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236362>

On Fri, Oct 18, 2013 at 11:25:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > + * Our basic strategy is to compare "base" and "asked" to find the bits
> > + * specific to our request. We then strip those bits off of "got" to yield the
> > + * new base. So for example, if our base is "http://example.com/foo.git",
> > + * and we ask for "http://example.com/foo.git/info/refs", we might end up
> > + * with "https://other.example.com/foo.git/info/refs". We would want the
> > + * new URL to become "https://other.example.com/foo.git".
> 
> Not "https://other.example.com/foo.git/info/refs"?

I think my use of "the new URL" is ambiguous. I meant "the new base",
from which one could then construct the new refs URL as you suggest.

-Peff
