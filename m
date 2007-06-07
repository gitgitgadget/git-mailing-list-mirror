From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: error: char103: premature end of data
Date: Fri, 8 Jun 2007 00:28:14 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080023450.4046@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <200706080105.28102.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRR3-00075z-Qk
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbXFGXa1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764995AbXFGXa1
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:30:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:44264 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932237AbXFGXa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:30:26 -0400
Received: (qmail invoked by alias); 07 Jun 2007 23:30:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 08 Jun 2007 01:30:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189MSolL0w9BS0Syp2LJnBNWE2gliq4SVfblcUjWV
	8/AAc1xsSYkl8N
X-X-Sender: gene099@racer.site
In-Reply-To: <200706080105.28102.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49410>

Hi,

On Fri, 8 Jun 2007, Johan Herland wrote:

> On Friday 08 June 2007, Johannes Schindelin wrote:
>
> > I just tried to fetch from one of my repos which was perfectly usable 
> > (and fetchable) before, and got this error message:
> > 
> > 	error: char103: premature end of data
> 
> Sorry about that. Do you have an idea of which tag object caused the 
> failure? If so, could you send the output of "git-cat-file tag <name>" 
> on it?

Yes, I know what causes it. A tag with an empty message.

And I even know why it does that. It's easy. Look into git-tag.sh, and you 
will find that it does a git-stripspace on the final message. If that was 
empty, then the tag will just be the tag header.

> git-fsck on the repo should report the same error. If you run with -v 
> (verbose) you should also get some hints as to which tag object causes 
> this.

Yes, it finds the error. And crashes. And costs me time.

Why do we have to parse _everything_ in the tag to begin with? It's not 
like I will show the information of the darn thing when I just fetch it 
from repo A into repo B.

Ciao,
Dscho
