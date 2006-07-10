From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix linking for not-so-clever linkers.
Date: Tue, 11 Jul 2006 01:01:07 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607110059020.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607101340080.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64i5b1am.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 01:01:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G04kd-0004cT-Ay
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 01:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422786AbWGJXBL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 19:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422787AbWGJXBL
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 19:01:11 -0400
Received: from mail.gmx.net ([213.165.64.21]:25819 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422786AbWGJXBJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 19:01:09 -0400
Received: (qmail invoked by alias); 10 Jul 2006 23:01:07 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 11 Jul 2006 01:01:07 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64i5b1am.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23664>

Hi,

On Mon, 10 Jul 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On one of my systems, the linker is not intelligent enough to link with
> > pager.o (in libgit.a) when only the variable pager_in_use is needed. The
> > consequence is that the linker complains about an undefined
> > variable.
> 
> I do not understand this quite yet -- which executable is your
> linker building when it does this?

The problem arises for the first time with git-blame. (Have not checked 
which other executables might be affected.)

> Maybe we need ranlib?

Does not help. pager.o is in libgit.a. Still, Darwin's linker does not 
want to link to pager.o (probably because no function from pager.o is 
called, so this is a real bug in the Darwin linker -- but being easy to 
fix, I think it is worthwhile to fix it).

Ciao,
Dscho
