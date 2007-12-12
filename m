From: Jeff King <peff@peff.net>
Subject: Re: git-cvsexportcommit fails for huge commits
Date: Wed, 12 Dec 2007 11:17:01 -0500
Message-ID: <20071212161701.GA18930@sigill.intra.peff.net>
References: <20071211200418.GA13815@mkl-desktop> <20071212083154.GB7676@coredump.intra.peff.net> <alpine.LFD.0.9999.0712120753120.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Klinik <markus.klinik@gmx.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:17:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UH3-0007wq-3N
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890AbXLLQRG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:17:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbXLLQRF
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:17:05 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4878 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbXLLQRE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 11:17:04 -0500
Received: (qmail 3248 invoked by uid 111); 12 Dec 2007 16:17:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 12 Dec 2007 11:17:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Dec 2007 11:17:01 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0712120753120.25032@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68063>

On Wed, Dec 12, 2007 at 08:02:35AM -0800, Linus Torvalds wrote:

> On Wed, 12 Dec 2007, Jeff King wrote:
> >  
> > +sub xargs_safe_pipe_capture {
> > +	my $MAX_ARG_LENGTH = 1024;
> 
> Well, that's a bit extreme. Make it 16kB or something. Anything should be 
> able to handle that.

Obviously it should be tweaked, and I just chose an absurdly low value.
However, "xargs --show-limit" claims that the POSIX minimum is 2048,
less the size of the environment. I have no idea what the original
problem reporter's platform is, or what sort of environment size is sane
there.

-Peff
