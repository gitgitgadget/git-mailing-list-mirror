From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 16:51:29 -0400
Message-ID: <20080508205129.GA32762@sigill.intra.peff.net>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de> <20080508183926.GA30613@sigill.intra.peff.net> <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu May 08 22:53:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuD6U-0007QT-DR
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 22:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbYEHUvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 16:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764300AbYEHUvb
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 16:51:31 -0400
Received: from peff.net ([208.65.91.99]:3705 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762266AbYEHUv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 16:51:27 -0400
Received: (qmail 22302 invoked by uid 111); 8 May 2008 20:51:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 16:51:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 16:51:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.10.0805082051210.10981@bianca.dialin.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81561>

On Thu, May 08, 2008 at 08:55:50PM +0200, Guido Ostkamp wrote:

> Jeff, I tried it, but it has no effect (see below). There is only the  
> master branch left, and only one commit therein, still it uses the space  
> former occupied by the branch. I'm using git version 1.5.5.1.147.g867f.

It worked fine for me; it's possible, as Brandon mentioned, that it is
in a pack already, and only a "repack -a" would get rid of it. FWIW, my
steps were:

  # ...same as you for repo and branch creation
  git branch -D test
  git config gc.reflogexpire 0
  git config gc.reflogexpireunreachable 0
  git config gc.pruneexpire now
  git gc
  du -s .git ;# shows 10396

-Peff
