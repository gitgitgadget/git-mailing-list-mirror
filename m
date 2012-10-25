From: Jeff King <peff@peff.net>
Subject: Re: t9401 fails with OS X sed
Date: Thu, 25 Oct 2012 04:41:34 -0400
Message-ID: <20121025084132.GB8390@sigill.intra.peff.net>
References: <609AC6E7-45CD-4472-B1DC-FBB785D6B815@gernhardtsoftware.com>
 <F721B376-F4E6-4274-9A6E-BD1CFCBDA39F@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 10:42:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJ0t-0000Ft-9g
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 10:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934904Ab2JYIlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 04:41:50 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55943 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933317Ab2JYIlr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 04:41:47 -0400
Received: (qmail 6255 invoked by uid 107); 25 Oct 2012 08:42:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 25 Oct 2012 04:42:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Oct 2012 04:41:34 -0400
Content-Disposition: inline
In-Reply-To: <F721B376-F4E6-4274-9A6E-BD1CFCBDA39F@adacore.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208366>

On Thu, Oct 25, 2012 at 01:04:11AM -0400, Geert Bosch wrote:

> On Oct 24, 2012, at 23:54, Brian Gernhardt <brian@gernhardtsoftware.com> wrote:
> 
> > It works if I change \s to [[:space:]], but I don't know how portable that is.
> 
> As \s is shorthand for the POSIX character class [:space:], I'd say the latter
> should be more portable: anything accepting the shorthand should also accept
> the full character class. If not, you probably only care about horizontal tab
> and space, for which you could just use a simple regular expression. Just a
> literal space and tab character between square brackets is probably going to be
> most portable, though not most readable.

I agree that the POSIX character class would be more portable than "\s",
but we do not have any existing uses of them, and I would worry a little
about older systems like Solaris. If we can simply use a literal space
and tab, that seems like the safest.

Brian, can you work up a patch?

-Peff
