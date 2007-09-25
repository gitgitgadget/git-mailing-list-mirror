From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Missing strptime
Date: Tue, 25 Sep 2007 01:30:30 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709250127170.28395@racer.site>
References: <OF8EBEA0A7.5425E9EA-ON88257360.00812AEA-88257360.00819919@beckman.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: mkraai@beckman.com
X-From: git-owner@vger.kernel.org Tue Sep 25 02:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZyKz-0004PV-W7
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 02:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800AbXIYAbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 20:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbXIYAbf
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 20:31:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:39261 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752785AbXIYAbe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 20:31:34 -0400
Received: (qmail invoked by alias); 25 Sep 2007 00:31:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 25 Sep 2007 02:31:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+9EeEoEwe9oRm882h0J9uQGTcuddM9iWrzBFC1cG
	ob86PKFUU7pQSR
X-X-Sender: gene099@racer.site
In-Reply-To: <OF8EBEA0A7.5425E9EA-ON88257360.00812AEA-88257360.00819919@beckman.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59082>

Hi,

On Mon, 24 Sep 2007, mkraai@beckman.com wrote:

> I'm porting Git to QNX.

That's nice!

> Its C library doesn't provide strptime, so I'd was planning to use the 
> Gnulib implementation.  Is that OK?  If so, should I try to leave it as 
> close to upstream's version as possible or should I remove all of the 
> unneeded cruft?  If not, is there an alternative implementation I should 
> use?

The only user for strptime is convert-objects, a program that should 
probably move to contrib/ anyway.  It was used once, a long time ago, to 
convert from the old format, which hashed the compressed contents, to the 
current format, which hashes the contents _before_ compression.

AFAIAC if a similar need should arise, the better alternative would be to 
write git-fast-export, a tool which dumps the contents of a repository 
suitable to pipe into git-fast-import.

FWIW in mingw.git, we disabled convert-objects already a long time ago.

Ciao,
Dscho
