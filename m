From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] dir.c(common_prefix): Fix two bugs
Date: Mon, 23 Apr 2007 11:12:26 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231108230.8822@racer.site>
References: <Pine.LNX.4.64.0704231020070.8822@racer.site>
 <7vzm4zh3z7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 23 11:13:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfubR-0007fz-8o
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 11:12:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753507AbXDWJMx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 05:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754037AbXDWJMx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 05:12:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:56369 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753507AbXDWJMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 05:12:53 -0400
Received: (qmail invoked by alias); 23 Apr 2007 09:12:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 23 Apr 2007 11:12:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/InO4lzlvITMIB3Ha78E9ueErU/amB5EgHT7wJf4
	9VyM1Nxa313mfi
X-X-Sender: gene099@racer.site
In-Reply-To: <7vzm4zh3z7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45306>

Hi,

On Mon, 23 Apr 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	If you're up for a very surprising error message, run the test 
> > 	without compiling git-add first...
> 
> $ PATH=/usr/bin:/bin sh t3700-add.sh -i -v
> * expecting success: touch foo && git-add foo
> ./test-lib.sh: line 136: git-add: command not found
> * FAIL 1: Test of git-add
>         touch foo && git-add foo
> $ echo $?
> 1

;-)

I did not say you should "make clean" first... For the record: this is 
what the surprising error looks like on my machine:

	* expecting success:
        	git add 1/2/a 1/3/b 1/2/c
	
	The following paths are ignored by one of your .gitignore files:
	1/3/b
	Use -f if you really want to add them.
	* FAIL 15: check correct prefix detection

The surprising factor is, of course, that there is no .gitignore file.

Ciao,
Dscho
