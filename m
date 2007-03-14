From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow git-diff exit with codes similar to diff(1)
Date: Wed, 14 Mar 2007 02:38:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703140237270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0703131717k7106ee1cg964628f0bda2c83e@mail.gmail.com>
 <Pine.LNX.4.64.0703131757080.9690@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703140216480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 14 02:38:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRIRx-0001Zy-AL
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 02:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933387AbXCNBim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 21:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933651AbXCNBim
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 21:38:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:44113 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933387AbXCNBim (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 21:38:42 -0400
Received: (qmail invoked by alias); 14 Mar 2007 01:38:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 14 Mar 2007 02:38:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Q0Dchf7jQ2Bfg4L/fZbgfViBWkTpGHW1k3Co5fJ
	Z3lGvJVujYzOj2
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703131831390.9690@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42170>

Hi,

On Tue, 13 Mar 2007, Linus Torvalds wrote:

> On Wed, 14 Mar 2007, Johannes Schindelin wrote:
> > 
> > So, big master to hom everybody bows, how to return the correct value 
> > when executing a pager? Because this _has_ to be done if we go that 
> > way.
> 
> Why? If you execute the pager, nobody cares about the error value 
> anyway.
> 
> I don't see why you would mix in a pager here. If you do
> 
> 	diff -u file1 file2 | less -S
> 
> the return value of the pipe will not only generally be totally 
> uninteresting and never used, but it will be the return value of "less" 
> anyway. Which is what we'd get quite naturally.

The thing is, most people do not realize that

	git diff file1 file2

_will_ execute a pager. As foreground process. And the return value is 
that of the pager.

Ciao,
Dscho
