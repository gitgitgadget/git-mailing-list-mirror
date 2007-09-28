From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: backup or mirror a repository
Date: Fri, 28 Sep 2007 02:56:49 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709280253150.28395@racer.site>
References: <1190921742.2263.17.camel@Tenacity>  <Pine.LNX.4.64.0709272255360.28395@racer.site>
 <1190940704.2263.32.camel@Tenacity>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dan Farina <drfarina@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 03:58:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib57G-0006eX-O4
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 03:58:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbXI1B56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 21:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751638AbXI1B56
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 21:57:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:44282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751908AbXI1B55 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 21:57:57 -0400
Received: (qmail invoked by alias); 28 Sep 2007 01:57:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 28 Sep 2007 03:57:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GNKgaHnpGYE62Wc2mQ2764O6XxU2DQml3rTFSLa
	4ZEfrtV8dYf15a
X-X-Sender: gene099@racer.site
In-Reply-To: <1190940704.2263.32.camel@Tenacity>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59350>

Hi,

On Thu, 27 Sep 2007, Dan Farina wrote:

> On Thu, 2007-09-27 at 22:56 +0100, Johannes Schindelin wrote:
> > I guess you're looking for "git remote add --mirror origin <url>".  
> > AFAIK this is not in any released version yet, though.
> 
> I just tried a bleeding edge git with --mirror.
> 
> It's close, except (unless there is some other provision to take care of 
> this) remote branch deletes. (Which, after more gmane trolling, seemed 
> to be "git remote rm", which doesn't seem present just yet).

git remote rm is about removing the remote nick, not a remote branch.

> Of course, it is completely possible I'm using it incorrectly. In brief, 
> I did "git init" "git remote add --mirror backup <url>" "git pull"

"git pull" without further parameters accesses the remote "origin", not 
"backup", and it merges _one_ branch into the current branch.

What you should have done is "git fetch backup".

Or use "origin" instead of "backup" right from the start, and then use 
"git fetch".

But no pull.

> (perhaps I should have used "git remote update"?) And the behavior of 
> this is more or less what I wanted, as far as sending branches. 
> Convenient removal of branches and propagating that removal still stumps 
> me. Is there a preferred way to do this yet?

You want to remove branches from the local repo which are no longer there 
on the remote side?

Then "git remote prune" is for you.  For details, please see the man page.

Ciao,
Dscho
