From: Jeff King <peff@peff.net>
Subject: Re: git version statistics
Date: Sat, 2 Jun 2012 12:32:48 -0400
Message-ID: <20120602163248.GD15017@sigill.intra.peff.net>
References: <20120531114801.GA21367@sigill.intra.peff.net>
 <20120531120018.GA24986@sigill.intra.peff.net>
 <7v396g6t53.fsf@alter.siamese.dyndns.org>
 <20120601090337.GC32340@sigill.intra.peff.net>
 <7vzk8n3x5e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 18:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SarGe-0005LR-2i
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 18:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759419Ab2FBQcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 12:32:51 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:41149
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758345Ab2FBQcu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 12:32:50 -0400
Received: (qmail 13966 invoked by uid 107); 2 Jun 2012 16:32:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 02 Jun 2012 12:32:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2012 12:32:48 -0400
Content-Disposition: inline
In-Reply-To: <7vzk8n3x5e.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199048>

On Fri, Jun 01, 2012 at 07:49:17AM -0700, Junio C Hamano wrote:

> My initial reaction to the patch was a bit of trouble with the word
> "agent", as we do not call Git acting on behalf of the end user "an
> agent" in general.

Yeah, I don't especially like the term "agent". I had initially called
it "version", but rejected that for two reasons:

  1. It is not just a version, but also telling what software is in use
     (so I would expect git to write git/v1.7.10, and other
     implementations to write write dulwich/1.2.3 or whatever).

  2. I didn't want it to be confused as a protocol version.

But maybe those are non-issues. It should be fairly obvious what it is
when you see even one example of the value.

> > Some traditional security advice I have heard is that servers should not
> > advertise their versions, as it makes it more obvious what holes they
> > have. Personally, I find that argument to be mostly security through
> > obscurity.
> 
> I do, too, but shipping with a configuration knob to optionally turn
> it off would be sufficient.

I think the most sensible thing is to just add a Makefile variable
that defaults to $(GIT_VERSION), and let people override it if they want
privacy. The http user-agent variable actually respects an environment
variable, but I don't see much point in going that far.

I'll cook up a new version of the patch.

-Peff
