From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Different behaviour of rebase -i
Date: Fri, 10 Oct 2008 13:40:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0810101319150.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <6beb92080810091204n6df4338fs3b182194a8d6454e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Leonardo Sobral Cunha <sobral@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 13:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoGHK-00069p-6l
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 13:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbYJJLeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 07:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbYJJLeQ
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 07:34:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:56567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753327AbYJJLeP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 07:34:15 -0400
Received: (qmail invoked by alias); 10 Oct 2008 11:34:13 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 10 Oct 2008 13:34:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/clo4a2LTcil41l9CikPn86kl/uODlpP1HtoJHH2
	W3AMFvz/rhMPjo
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <6beb92080810091204n6df4338fs3b182194a8d6454e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97927>

Hi,

On Thu, 9 Oct 2008, Leonardo Sobral Cunha wrote:

> While doing a git rebase with my upstream branch ahead of my local 
> branch, first git rewinds my local branch to point to the upstream and 
> then prints "Nothing to do". As expected, my local branch ends pointing 
> to the upstream head.
> 
> But when I use the same command with the same branches using git rebase 
> -i, nothing happens and my local branch does not point to upstream (the 
> behaviour is different).
> 
> Is this different behaviour of rebase -i expected or is this a bug? This 
> is still happening in git version 1.6.0.2.443.g52e83

This is by design.  You need to have a way to stop rebasing in the editor.  
For example when you realize that you passed the wrong upstream or 
something.

The most intuitive way (I thought) is to behave the same as "git commit": 
if you do not want to continue, just delete everything.

Now, I can see that it is unconvenient.

A workaround would be to add a line "bla" and when rebase complains about 
the unknown command, continue with "git rebase --skip".

Maybe we should add a new command "noop" which is automatically inserted 
when there is no other command?

Ciao,
Dscho
