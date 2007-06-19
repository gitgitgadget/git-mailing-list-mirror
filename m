From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Suggestions for documentation
Date: Tue, 19 Jun 2007 10:47:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706191043170.4059@racer.site>
References: <467786B1.5000009@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Claudio Scordino <cloud.of.andor@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 19 11:48:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0aJi-0003cC-4a
	for gcvg-git@gmane.org; Tue, 19 Jun 2007 11:48:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755255AbXFSJsD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jun 2007 05:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754936AbXFSJsC
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jun 2007 05:48:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:40815 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754397AbXFSJsA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2007 05:48:00 -0400
Received: (qmail invoked by alias); 19 Jun 2007 09:47:59 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 19 Jun 2007 11:47:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19R4INbusFRDFltBwijfqxCRE6I6H3H8bjeh500xf
	3z7SS32ZFKiXXM
X-X-Sender: gene099@racer.site
In-Reply-To: <467786B1.5000009@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50463>

Hi,

On Tue, 19 Jun 2007, Claudio Scordino wrote:

> 1) As my previous question shown, how to clone from a specified port is not
> currently documented. You should just add a sentence saying that the command
> is
> 
> git clone git://server:port/path/

I thought this was quite standard with other protocol? I.e. 
http://host:port/path is what I do all the time.

Having said that, this should be relatively easy? Want to give it a try?

> 2) Maybe it is better to highlight that after a push on a remote 
> repository, the user has to do a checkout on that repository (people 
> from the CVS and SVN worlds get easily confused, otherwise).

That has been discussed on and off, and I think that you are not using a 
valid workflow here. If you are pushing into another repo, _by definition_ 
you do not have a work tree to resolve conflicts with.

Thus, you should rather do something like "push upstream 
master:refs/heads/push" on the pushing side, and "merge push" on the other 
side.

It is a common behaviour by former CVS users (I did the same!), but it is 
fixable.

> Moreover (and I did not fully understood why) if I just use "git 
> checkout" without the -f option, I cannot see the changes that have been 
> pushed from the cloned repository.

Same reason. This is not a valid workflow. You kind of changed the tip of 
the branch in the pushed-to repo behind its back. The only way to make 
this work that I am aware of is "git read-tree -m -u HEAD", but as I 
stated before, you probably want to change the way you're working.

Hth,
Dscho
