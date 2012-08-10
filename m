From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 13:46:05 -0400
Message-ID: <20120810174605.GA29113@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 19:46:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SztHw-0000TJ-3U
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 19:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758046Ab2HJRqP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 13:46:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:33831 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757545Ab2HJRqO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 13:46:14 -0400
Received: (qmail 32605 invoked by uid 107); 10 Aug 2012 17:46:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 13:46:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 13:46:05 -0400
Content-Disposition: inline
In-Reply-To: <7vfw7ulq0a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203239>

On Fri, Aug 10, 2012 at 08:34:45AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Ugh, the jk/version-string topic breaks fetching from Google Code. With
> > my patch, the client unconditionally sends an "agent=foo" capability,
> > but the server does not like seeing the unknown capability and ends the
> > connection (I'm guessing with some kind of internal exception, since it
> > spews "Internal server error" over the protocol channel).
> 
> The fix looks sane and the right thing to do.
> 
> I've been using 'next' and started seeing this breakage when pushing
> to code.google.com only a few days ago.  My reflog tells that
> ff5effd (include agent identifier in capability string, 2012-08-03)
> was merged to my everyday-work branch on this Monday, which is more
> or less consistent with what I am observing.

Thanks for confirming the push side. I have been running with the patch
for months, but only recently happened to try cloning something from
code.google.com. I assumed the push side had the same problem, but did
not want to make a new project just to test (and it seemed fairly
obvious that it would have the same issue).

It was pure coincidence that it happened at the same time you were
graduating the topic to next. But I'm glad I was able to catch it before
anybody started complaining. :)

-Peff
