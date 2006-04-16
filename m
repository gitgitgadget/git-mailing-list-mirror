From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: path limiting broken
Date: Sun, 16 Apr 2006 18:45:29 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604161835410.17985@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0604161411120.15345@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 16 18:45:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVANq-0001nD-2G
	for gcvg-git@gmane.org; Sun, 16 Apr 2006 18:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWDPQpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 16 Apr 2006 12:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbWDPQpl
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Apr 2006 12:45:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:58532 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750748AbWDPQpk (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Apr 2006 12:45:40 -0400
Received: (qmail invoked by alias); 16 Apr 2006 16:45:39 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp029) with SMTP; 16 Apr 2006 18:45:39 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604160850230.3701@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18791>

Hi,

On Sun, 16 Apr 2006, Linus Torvalds wrote:

> On Sun, 16 Apr 2006, Johannes Schindelin wrote:
> > 
> > I am not intelligent enough to find out why there are three revisions 
> > which get culled.
> 
> Path limiting by default looks at all parents of a merge, and if any of 
> them is identical to the child (within the path limiter), it will pick 
> _that_ parent, and that parent only, and drop all other parents.

That's okay.

But you missed my point. The file log-tree.c had some opt handling. I 
changed it (as can be seen in my patch for combined diffstat), so the 
merge did not go well with next, which removed that code.

So I tried to be clever and find the (non-merge) commit where this 
happened. With what you describe, I should have hit *exactly one* commit 
removing the code.

But I hit *exactly none* with "git log --cc master log-tree.c".

Ciao,
Dscho
