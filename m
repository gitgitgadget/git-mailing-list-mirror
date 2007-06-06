From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Wed, 6 Jun 2007 18:59:06 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706061854330.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
    <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com>
   <Pine.LNX.4.64.0706041850350.4046@racer.site> <46650A58.4934C07C@eudaptics.com>
  <Pine.LNX.4.64.0706051537360.4046@racer.site> <466665AD.CF5B85DF@eudaptics.com>
 <Pine.LNX.4.64.0706061600060.4046@racer.site> <4666D143.32BC9693@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 20:28:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw0Eq-0003Kx-5Y
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 20:28:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757632AbXFFS15 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 14:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759672AbXFFS15
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 14:27:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:36298 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757632AbXFFS14 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 14:27:56 -0400
Received: (qmail invoked by alias); 06 Jun 2007 18:01:15 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp027) with SMTP; 06 Jun 2007 20:01:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FJdgqhvUF3Xv7VJU3gQqp59xt6S6JIlVCBLuVkB
	KmKH/EUubAbsd1
X-X-Sender: gene099@racer.site
In-Reply-To: <4666D143.32BC9693@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49303>

Hi,

On Wed, 6 Jun 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > Of course, it would be even more so if the target branch name was
> > "filtered", overrideable by "--target <name>".
> 
> My plan for this is:
> 
> 1. run the rev-list args ("$@") through rev-parse
> 2. pick only the positive ones (/^[a-z0-9]{40}$/)
> 3. filter show-ref against the result of 2.
> 4. foreach ref in the result of 3. install a refs/rewritten/$ref
>    with the mapped id if and only if the mapped id is different
>    from the original id of $ref.
> 
> Then you can, for example, 'git filter-branch --all' to rewrite all
> branches.

That sounds really sensible. For (2), I suggest "git-rev-parse 
--symbolic", though. And maybe you want to make sure that there were no 
invalid branch names, i.e. "git-filter-branch next~2". (Otherwise, you 
would try to create refs/filtered/next~2 after filtering all commits.)

Ciao,
Dscho
