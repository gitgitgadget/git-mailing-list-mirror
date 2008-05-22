From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: two git-cherry-pick enhancements
Date: Thu, 22 May 2008 10:29:09 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805221026140.30431@racer>
References: <20080521163817.GA13124@denkbrett.schottelius.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nico -telmich- Schottelius <nico-git-20080521@schottelius.org>
X-From: git-owner@vger.kernel.org Thu May 22 11:30:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jz77h-0004bO-4x
	for gcvg-git-2@gmane.org; Thu, 22 May 2008 11:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933216AbYEVJ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 05:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933111AbYEVJ3G
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 05:29:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:54931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762185AbYEVJ3C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 05:29:02 -0400
Received: (qmail invoked by alias); 22 May 2008 09:28:59 -0000
Received: from R5e98.r.pppool.de (EHLO racer.local) [89.54.94.152]
  by mail.gmx.net (mp042) with SMTP; 22 May 2008 11:28:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IjHM5tgJIBP9H98xDF2bH0e6xqr9BR9ftDDUris
	bbnujyuZdYldXv
X-X-Sender: gene099@racer
In-Reply-To: <20080521163817.GA13124@denkbrett.schottelius.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82607>

Hi,

On Wed, 21 May 2008, Nico -telmich- Schottelius wrote:

> When using git-cherry-pick there are two things missing for me and just 
> wondered how you see it (or maybe have a good solution):
> 
> - Apply only parts of the patch which applies to <file ...>:
>    I sometimes want to apply patches only to some, but not all
>    files the patch introduces
> 
> - Interactively selecting which parts to apply:
>    I want only 7 out of 10 changes the patch introduces.
>    It would help alot, if I could choose which parts I want
>    to apply for every part of the patch.
> 
> Anything planned like that or did I oversee the right way?

Conceptually, this is really not cherry-picking _commits_.  For example, 
the commit message will typically be all wrong if you pick only one 
change.  Also, if I were the author of the original patch, I would not be 
happy for you to label me author of the cut-down (and possibly invalid) 
commit.

Therefore I suggest (just like on IRC the other day):

	git show <commit> -- <file(s)> | git apply

possibly followed by

	git add -i

or

	git add -p <file>

Hth,
Dscho
