From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Howto request: going home in the middle of something?
Date: Mon, 22 Oct 2007 12:32:43 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710221230130.25221@racer.site>
References: <200710181144.22655.wielemak@science.uva.nl>
 <20071018112758.GN18279@machine.or.cz> <200710221044.24191.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Mon Oct 22 13:33:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjvX5-0000Ku-Ny
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 13:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbXJVLdI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 07:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbXJVLdG
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 07:33:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:37669 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751668AbXJVLdF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 07:33:05 -0400
Received: (qmail invoked by alias); 22 Oct 2007 11:33:04 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 22 Oct 2007 13:33:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+M4FI/D0mMfGhqp/feMjpJ0XU1gvaF/Q1Ld8vpsp
	N+Hgh1Gq/0QqfA
X-X-Sender: gene099@racer.site
In-Reply-To: <200710221044.24191.wielemak@science.uva.nl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61991>

Hi,

On Mon, 22 Oct 2007, Jan Wielemaker wrote:

> Thanks for the replies.	 I think I can live with something like this
> 
> 	<work, in the middle of something>
> 	$ git checkout -b home
> 	$ git commit
> 	$ git checkout master
> 	<arriving at home>
> 	$ git jan@work:repo fetch home:home	(using ssh)

You probably meant "git fetch jan@work:repo home:home".

> 	$ git checkout home
> 	<continue editing>
> 	$ git commit --amend
> 	$ git checkout master
> 	$ git merge home
> 	$ git -d home
> 	$ git commit
> 	$ git push
> 	<arriving at work>
> 	$ git -d home
> 	$ git pull
> 
> Its still a bit many commands and you have to be aware what you are
> doing for quite a while, but it does provide one single clean commit
> message, doesn't change the shared repo until all is finished and allows
> to abandon all work without leaving traces.
> 
> Personally I'd be more happy with
> 
> 	<work, in the middle of something>
> 	$ git stash
> 	<arriving at home>
> 	$ git stash fetch jan@work{0}	(well, some sensible syntax)
> 	$ git stash apply
> 	<continue editing>
> 	$ git commit
> 	$ git push
> 	<arriving at work>
> 	$ git pull

Happily, that is already possible:  However, instead of

	git stash fetch jan@work{0}

you should say

	git fetch jan@work stash:stash

This will only fetch the last stash, but that is what you wanted anyway, 
right?

Ciao,
Dscho

P.S.: Since you top-posted, I just ignored the mail you quoted, assuming 
that it was not relevant to your mail.
