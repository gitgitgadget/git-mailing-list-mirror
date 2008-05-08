From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 16:56:53 -0400
Message-ID: <20080508205652.GB32762@sigill.intra.peff.net>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de> <48235D99.2040407@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu May 08 22:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuDBN-000133-1v
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbYEHU4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbYEHU4w
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:56:52 -0400
Received: from peff.net ([208.65.91.99]:3974 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450AbYEHU4u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 16:56:50 -0400
Received: (qmail 22692 invoked by uid 111); 8 May 2008 20:56:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 16:56:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 16:56:53 -0400
Content-Disposition: inline
In-Reply-To: <48235D99.2040407@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81563>

On Thu, May 08, 2008 at 03:07:53PM -0500, Brandon Casey wrote:

> btw, this is _really_ a non-issue. It seems to keep coming up on the list.
> 
> Just know that each one of the config options that you set to zero, including
> the one Jeff suggested setting to "now", is a safety mechanism that is there
> to ensure that you never ever lose data and that mistakes are recoverable.

Yes, I want to chime in since I have been giving advice in such threads:
Please don't construe my help as any sort of endorsement of this
behavior. Git tries hard not to lose your data, and it is almost always
a bad idea to try to override these safety checks unless you really know
what you are doing.

And even then, try to consider balancing a bit of freed disk space (and
generally _no_ performance gain, because git is very good about not
looking at objects that aren't necessary to the current operation)
versus thinking "oops, I wish I still had that data" in a few days.

I can think offhand of only one time when it was truly useful for me to
prune aggressively, and it was a very special case: a pathologically
large repo for which I was doing a one-shot conversion from another
format (and I wanted to prune failed attempts).

-Peff
