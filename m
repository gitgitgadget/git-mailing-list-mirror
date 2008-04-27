From: Jeff King <peff@peff.net>
Subject: Re: Use of tac in git-rebase--interactive
Date: Sun, 27 Apr 2008 02:42:51 -0400
Message-ID: <20080427064250.GA5455@sigill.intra.peff.net>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Apr 27 08:43:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq0c3-0007SB-0d
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 08:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbYD0Gmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 02:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752268AbYD0Gmu
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 02:42:50 -0400
Received: from peff.net ([208.65.91.99]:1744 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYD0Gmu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 02:42:50 -0400
Received: (qmail 6567 invoked by uid 111); 27 Apr 2008 06:42:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 27 Apr 2008 02:42:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 27 Apr 2008 02:42:51 -0400
Content-Disposition: inline
In-Reply-To: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80422>

On Sun, Apr 27, 2008 at 02:24:18AM -0400, Brian Gernhardt wrote:

> The problem is that tac doesn't exist on my OS X system.  I do appear to 
> have a rev command which does the same thing.  Simply posting a patch that 
> does 472s/tac/rev/ would fix the problem on my system, but the fact that 
> this is an issue raises the question of the relative portability of the 
> two commands.  I don't think we have a declared dependancy on GNU's 
> coreutils, which is where Debian lists tac as coming from.

I know the list will be shocked to hear that Solaris has neither.

An easy perl replacement is:

  perl -e 'print reverse <>'

which should work fine for small-ish input (since it puts the whole
thing in memory).

-Peff
