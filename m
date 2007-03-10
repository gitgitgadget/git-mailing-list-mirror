From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/3] git-bundle: die if a given ref is not included in
 bundle
Date: Sat, 10 Mar 2007 17:53:30 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703101749270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0703090348300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F0D1B3.9020204@gmail.com> <7vejny7umx.fsf@assigned-by-dhcp.cox.net>
 <45F17EF0.5060008@gmail.com> <7v1wjy56qf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703101637300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45F2D955.8050800@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 17:53:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQ4pA-0000J0-37
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 17:53:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767882AbXCJQxd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 11:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933498AbXCJQxd
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 11:53:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:54574 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933490AbXCJQxc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 11:53:32 -0500
Received: (qmail invoked by alias); 10 Mar 2007 16:53:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp024) with SMTP; 10 Mar 2007 17:53:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/74yo/Jmj7lxDKbpPdJM9r2vZ7u94dIYPNx61P0Q
	7p8McN/N9aP7J3
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45F2D955.8050800@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41868>

Hi,

On Sat, 10 Mar 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
>
> > IMHO saying "master ^master" should blow into the user's face. If she 
> > says "I want it" _and_ "I don't want it", she should sorta expect it 
> > not to work.
>
> [...]
>
> As long as the lists are syntactically acceptable (all exist), we should 
> just create the bundle with the given refs and prerequisites.

So, what do you do if some of your users do, and some others do not, have 
the "blue-sky" branch? If you say "git bundle create new.bundle --all 
-10", your bundle will list "blue-sky" as a prerequisite.

Boom.

Some of your users -- those without "blue-sky" -- will _not_ be able 
to fetch _anything_ from the bundle. They are lacking the prerequisites.

The semantics of git-bundle used to be so clear and sensible, since they 
exactly reflected what git-pack-objects would do.

Now they are no longer?

Ciao,
Dscho
