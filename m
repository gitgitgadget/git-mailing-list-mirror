From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] More permissive "git-rm --cached" behavior without -f.
Date: Fri, 13 Jul 2007 23:42:21 -0400
Message-ID: <20070714034221.GA23328@coredump.intra.peff.net>
References: <vpq8x9k9peu.fsf@bauges.imag.fr> <11843484982037-git-send-email-Matthieu.Moy@imag.fr> <20070713175737.GA20416@coredump.intra.peff.net> <vpq8x9kp231.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 05:42:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9YWj-0000Tt-Ls
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 05:42:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756947AbXGNDmY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jul 2007 23:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbXGNDmY
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jul 2007 23:42:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4088 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756433AbXGNDmX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2007 23:42:23 -0400
Received: (qmail 23314 invoked from network); 14 Jul 2007 03:42:48 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jul 2007 03:42:48 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2007 23:42:21 -0400
Content-Disposition: inline
In-Reply-To: <vpq8x9kp231.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52436>

On Fri, Jul 13, 2007 at 08:53:38PM +0200, Matthieu Moy wrote:

> do.". The behavior without --cached is not modified, except for the
> error message, and the previous was to require -f whenever the index
> doesn't match the head, *or* doesn't match the file. So, without
> --cached, you need to have file=index=HEAD to be able to git-rm.
> 
> If I missunderstand you, please, provide a senario where my patch
> doesn't do the expected.

Right, my point was that there is a case where running without --cached
could lose content: when there is no working tree file. However,
thinking about it more, I recall that Junio made the point that allowing
that behavior means the CVS idiom of "rm file; git-rm file" will just
work.

Not that that was a problem you introduced; I merely wanted to push for
total consistency rather than just handling --cached. But I think the
non --cached behavior is actually right now, so let me retract my
complaint.

And assuming the "git-rm when no working tree file" current behavior is
OK, then I think your patch removes the last consistency problem that I
mentioned in my state table here:

  http://article.gmane.org/gmane.comp.version-control.git/51449

So in a round-about way, I totally approve of your patch. Sorry for the
confusion.

-Peff
