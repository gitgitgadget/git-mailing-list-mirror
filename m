From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 1 Oct 2006 22:11:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610012208410.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
 <Pine.LNX.4.63.0610012052520.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0610011256580.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 22:11:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU7ec-0001EE-AB
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 22:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWJAULL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 16:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932297AbWJAULL
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 16:11:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:33152 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932293AbWJAULK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 16:11:10 -0400
Received: (qmail invoked by alias); 01 Oct 2006 20:11:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 01 Oct 2006 22:11:08 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610011256580.3952@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28199>

Hi,

On Sun, 1 Oct 2006, Linus Torvalds wrote:

> On Sun, 1 Oct 2006, Johannes Schindelin wrote:
> > 
> > Just rm perl/{Git.{bs,c},Makefile} and remake.
> 
> Now this works.
> 
> So somebody tell me why we even invoke that Makefile that shouldn't be 
> there?

The problem is that the Makefile does not realize that Git.xs no longer is 
there. Neither does the code which recreates the Makefile.

You will notice that there is a new generated perl/Makefile, which no 
longer tries to compile Git.xs, Git.bs or Git.c

When there is a Git.c, "perl Makefile.PL" will do the wrong thing, namely 
it expects that you created Git.c by hand, and wants to compile it. If 
there is a Git.bs, it thinks you want Git.c created.

Sort of automake for Perl.

Ciao,
Dscho
