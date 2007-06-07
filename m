From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck: do not crash on tag objects which do not contain
 an empty line
Date: Fri, 8 Jun 2007 00:13:55 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706080011430.4046@racer.site>
References: <Pine.LNX.4.64.0706072338260.4046@racer.site>
 <200706080108.50042.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:16:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwRDE-0004m7-4N
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 01:16:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764610AbXFGXQI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 19:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbXFGXQI
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 19:16:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:56832 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1764610AbXFGXQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 19:16:07 -0400
Received: (qmail invoked by alias); 07 Jun 2007 23:16:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 08 Jun 2007 01:16:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Vw5te2BhV38X2sMmsW68cQ13Ze+5UtcqJtIuQl9
	T/4E3Qk9gWjmk4
X-X-Sender: gene099@racer.site
In-Reply-To: <200706080108.50042.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49408>

Hi,

On Fri, 8 Jun 2007, Johan Herland wrote:

> On Friday 08 June 2007, Johannes Schindelin wrote:
> > 
> > The first empty line in a tag object separates the header from the 
> > message. If the tag object has no empty line, do not crash, but 
> > complain loudly instead.
> 
> Aren't tag objects _required_ to have an empty line separating the 
> headers from the body? At least I wrote the new tag code with that 
> assumption in mind.

Yes, evidently you did.

But even then, isn't it always better to not rely on such assumptions, but 
fail gracefully? The rest of Git's source code seems to be nicer to 
failures as this one, IMHO.

> Could this be related to the "error: char103: premature end of data" 
> you're seeing?

Definitely. It breaks even _fetching_.

Ciao,
Dscho
