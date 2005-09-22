From: Greg KH <greg@kroah.com>
Subject: Re: [Core GIT] Long-term cherrypicking
Date: Thu, 22 Sep 2005 01:31:42 -0700
Message-ID: <20050922083142.GA6866@kroah.com>
References: <20050921164015.GC21971@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, kkeil@suse.de
X-From: git-owner@vger.kernel.org Thu Sep 22 10:37:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIMYB-0001Hk-Ah
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 10:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbVIVIfK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 04:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVIVIfK
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 04:35:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:38595 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751449AbVIVIfI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Sep 2005 04:35:08 -0400
Received: from [192.168.228.164] ([194.228.206.13])
	(authenticated)
	by perch.kroah.org (8.11.6/8.11.6) with ESMTP id j8M8W0w26854;
	Thu, 22 Sep 2005 01:32:00 -0700
Received: from greg by echidna.kroah.org with local (masqmail 0.2.19)
 id 1EIMUZ-1oS-00; Thu, 22 Sep 2005 01:31:43 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20050921164015.GC21971@pasky.or.cz>
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9095>

On Wed, Sep 21, 2005 at 06:40:15PM +0200, Petr Baudis wrote:
>   Hello,
> 
>   I've been working out some workflow possibilities with Karsten Keil at
> the SuSE Labs conference, and I'd like to see your opinions. His
> position does not seem unique at all, so I'm a bit surprised that noone
> solved this before, or at least I didn't find any documentation about
> this in the tutorial and howtos (or perhaps I missed it?).
> 
>   His situation is that he has some patches in the ISDN subsystem, a
> public repository, but sends the patches over e-mail to Linus. So he is
> something between the subsystem maintainer and individual developer in
> the categories listed out in the tutorial. What should be his merging
> strategy?

Not to use git for this.

Seriously, that's what I have switched to doing, and it's so much
easier.  I use quilt to manage patches from the community, and Andrew
pulls them into to the -mm releases, and all users can test them.  I
keep them up to date with the git snapshots, which handles the different
merge and fuzz issues very well.

Then, when it's time to merge with Linus, I pick and choose the patches
that I want to send off, create a git tree, add them to the tree, and
send them off.

It's ended up saving me a lot of time (I used to do what Karsten is
trying to do with bitkeeper, and it had the same issues that he is
running into) and would recommend this situation for anyone who wants to
keep patches from being merged immediatly (like he is trying to do.)

thanks,

greg k-h
