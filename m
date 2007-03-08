From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] shortlog: prompt when reading from terminal by mistake
Date: Thu, 8 Mar 2007 14:04:04 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703081344140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 08 14:04:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPII0-0002zk-Nc
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 14:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbXCHNEI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 08:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751752AbXCHNEI
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 08:04:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:44077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751726AbXCHNEH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 08:04:07 -0500
Received: (qmail invoked by alias); 08 Mar 2007 13:04:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp052) with SMTP; 08 Mar 2007 14:04:04 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+a3Ww8c/+aJRbVan4R2zxkJ1ecn3dzaRico1I8pl
	N+Aui9KWBrYwGv
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41740>

Hi,

On Thu, 8 Mar 2007, Junio C Hamano wrote:

> I was trying to see who have been active recently to find GSoC
> mentor candidates by running:
> 
> 	$ git shortlog -s -n --since=4.months | head -n 20
> 
> After waiting for about 20 seconds, I started getting worried,
> thinking that the recent revision traversal updates might have
> had an unintended side effect.
> 
> Not so.  "git shortlog" acts as a filter when no revs are given,
> unlike "git log" which defaults to HEAD.  It was reading from
> its standard input.
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

>    Arguably because --since=4.months clearly states I am
>    expecting it to start digging from somewhere, it would be
>    more sensible to default to HEAD in this case.  I suspect it
>    might be as simple as checking argc before we call
>    setup_revisions() and pass "HEAD" as the default parameter to
>    it, but it is getting late here.

Hm. Better check argc _afterwards_, and if it changed, but no pending 
object was there, add "HEAD".

Ciao,
Dscho
