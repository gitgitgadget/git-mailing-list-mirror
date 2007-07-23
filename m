From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: when git-rebase -i fails to cherry-pick
Date: Tue, 24 Jul 2007 00:08:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707240005240.14781@racer.site>
References: <20070723225402.GB22513@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:09:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID71x-0007Mc-E3
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763830AbXGWXJG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933750AbXGWXJF
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:09:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:45056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759080AbXGWXJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:09:03 -0400
Received: (qmail invoked by alias); 23 Jul 2007 23:09:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp049) with SMTP; 24 Jul 2007 01:09:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18hCP94EDYhVBlp3sDTu9mlyUdaG/aG8VybnzYt6q
	D+vl0iBhftxA9O
X-X-Sender: gene099@racer.site
In-Reply-To: <20070723225402.GB22513@informatik.uni-freiburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53500>

Hi,

On Tue, 24 Jul 2007, Uwe Kleine-K?nig wrote:

> even though git-rebase -i is still young, I'm already a big fan of it.

Nice!

> I just want to suggest two minor things:
> 
> - If a cherry-pick fails, it tells me to resolve my conflicts, 'git add
>   <paths>' and to do 'git commit -c $sha1id'.
> 
>   But it doesn't tell me, how I continue to rebase after that.
> 
>   'git rebase -i --continue' works.

Actually, even "git rebase --continue" works.  And you do not really have 
to commit, either, just updating your index is fine.  In fact, if you say 
"git reset --hard", it will skip the commit.

> - If a cherry-pick of a commit to be squashed fails, the instruction to
>   do 'git commit -c $sha1id' is wrong, because then I don't get both
>   message to squash.

Yes, it is a leftover from the bad old days, when this script was called 
edit-patch-series, and I was a rebase hater.

In the meantime, somebody on IRC explained to me how rebase works, and 
that rebase lovers were quite annoyed not to be able to just resolve the 
conflicts and "git rebase --continue".

I'd appreciate if you prepared a patch with better explanations, and also 
reviewed the man page, if it is in good shape (and does not lie about the 
current behaviour).

Thanks,
Dscho
