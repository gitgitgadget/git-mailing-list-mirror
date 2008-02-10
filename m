From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: All I wanted was git-fast-export
Date: Sun, 10 Feb 2008 00:58:07 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100054490.11591@racer.site>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site> <47AE2CDF.4090208@glidos.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Sun Feb 10 01:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO0X8-00049C-7E
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 01:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755320AbYBJA6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 19:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbYBJA6J
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 19:58:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:46469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752727AbYBJA6F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 19:58:05 -0500
Received: (qmail invoked by alias); 10 Feb 2008 00:58:03 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp019) with SMTP; 10 Feb 2008 01:58:03 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S3owE9spS/nfaXhuq0kqOd4Eh4xVJWjK31+RM3R
	zn7UuFtjFXJ+rT
X-X-Sender: gene099@racer.site
In-Reply-To: <47AE2CDF.4090208@glidos.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73279>

Hi,

On Sat, 9 Feb 2008, Paul Gardiner wrote:

> Johannes Schindelin wrote:
> 
> > On Sat, 9 Feb 2008, Paul Gardiner wrote:
> > 
> > > With your kind help, I've been able to convert a cvs repository to 
> > > git, but the last several years commits start with a line saying 
> > > "Summary;" :-( I thought it might not be hard to put a filter 
> > > between git-fast-export and git-fast-import to sort it out.
> > 
> > The better tool for this should be filter-branch.
> 
> filter-branch does look to be brilliant for this sort of thing,
> but I don't think I can use it in my case.

I beg to differ.  filter-branch does exactly the same as the fast-export | 
filter | fast-import you prosed does: it rewrites history.

The thing is, filter-branch was _written for this purpose_.  So if you 
know what commit you rewrote last, you can make the process faster/safer 
by issuing

	$ git filter-branch --msg-filter="<blabla>" <old-commit>..master

There's also a further upside to filter-branch: at least until recently, 
it did not use any special features of newer git, but could be extracted 
(e.g. via gitweb) and used with older git (any git >= 1.5.3 should do, 
maybe even older ones).

Hth,
Dscho

P.S.: but you seem to be dead-set to upgrade.  No problem for me: just go 
ahead and do what you must.
