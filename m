From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-filter-branch
Date: Mon, 4 Jun 2007 17:11:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706041711500.4046@racer.site>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 18:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvFC5-0003ts-PP
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 18:14:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755833AbXFDQOH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 12:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755845AbXFDQOH
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 12:14:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:59777 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755833AbXFDQOE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 12:14:04 -0400
Received: (qmail invoked by alias); 04 Jun 2007 16:14:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 04 Jun 2007 18:14:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/RcLMaMbbRfIB7YlQQJdJyz8Auzd/pLF5KDZuzUU
	x/QNNIphzBvvnv
X-X-Sender: gene099@racer.site
In-Reply-To: <4663BCDA.F1BADDD8@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49112>

Hi,

On Mon, 4 Jun 2007, Johannes Sixt wrote:

> [...] any simple command like 
> 
>   git filter-branch -k orgin/master origin/next new-next
> 
> of your git.git clone will fail with the "assertion failed". (I haven't
> tried your script, yet, but cg-admin-rewritehist fails.)

As you mentioned yourself, you should say "-s origin/next". 
cg-admin-rewritehist will only rewrite the current branch (since cogito 
started out as one-branch-per-repo).

> I propose that you just get rid of the "seed" stance and don't fail if a
> commit cannot be mapped - just use it unchanged (don't forget to adjust
> the map() function, too).

It is as much for debug reasons as for consistency, so I'd rather keep it. 
One more safety valve for catching bugs.

> Then you can get rid of -r and use -k to specify everything you want 
> under "--not" in the rev-list.

Actually, -r is quite useful. It means "start rewriting with this commit", 
and saying "--not <commit>^" is _not_ the same when <commit> is a merge.

Ciao,
Dscho
