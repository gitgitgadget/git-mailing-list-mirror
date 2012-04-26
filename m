From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] config: allow ~/ and ~user/ in include.path value
Date: Thu, 26 Apr 2012 02:19:23 -0400
Message-ID: <20120426061923.GA22819@sigill.intra.peff.net>
References: <1335265689-2270-1-git-send-email-Matthieu.Moy@imag.fr>
 <1335292396-8502-1-git-send-email-Matthieu.Moy@imag.fr>
 <20120425120036.GB21579@sigill.intra.peff.net>
 <xmqqwr53bmc7.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 08:19:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNI3T-0000y1-M0
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 08:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab2DZGTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 02:19:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45013
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740Ab2DZGTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2012 02:19:45 -0400
Received: (qmail 11108 invoked by uid 107); 26 Apr 2012 06:19:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 Apr 2012 02:19:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Apr 2012 02:19:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqqwr53bmc7.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196354>

On Wed, Apr 25, 2012 at 01:14:32PM -0700, Junio C Hamano wrote:

> > +found. The value of `include.path` is subject to tilde expansion: `~/`
> > +is expanded to the value of `$HOME`, and `~user/` to the specified
> > +user's home directory. See below for examples.
> >  
> >  Example
> >  ~~~~~~~
> > @@ -122,6 +124,7 @@ Example
> >  	[include]
> >  		path = /path/to/foo.inc ; include by absolute path
> >  		path = foo ; expand "foo" relative to the current file
> > +		path = ~/foo ; expand "foo" in your $HOME directory
> 
> Modulo s/~/{tilde}/ in the body text (but not in the displayed example),
> looked good to me, so I queued with two amends.

Thanks, I forgot about that.

I'd like to eventually stop building the documentation with
no-inline-literal. It was an asciidoc7 compatibility thing, but we can
probably drop that now. However, I suspect that would require us to
simultaneously convert all of the `{tilde}` uses back into `~`.

-Peff
