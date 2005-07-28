From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 09:14:17 -0700
Message-ID: <7vwtnadi1y.fsf@assigned-by-dhcp.cox.net>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
	<7vll3rlnqm.fsf@assigned-by-dhcp.cox.net>
	<200507271458.43063.Josef.Weidendorfer@gmx.de>
	<20050728120806.GA2391@pasky.ji.cz>
	<Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728153506.GL14229@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 18:19:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyB52-00070W-T5
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:17:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVG1QRA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1QOf
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 12:14:35 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:42140 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261573AbVG1QOW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 12:14:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050728161414.UWEV1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 28 Jul 2005 12:14:14 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050728153506.GL14229@pasky.ji.cz> (Petr Baudis's message of "Thu, 28 Jul 2005 17:35:06 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Thu, Jul 28, 2005 at 03:07:01PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
>> IMHO this opens the door for shooting in your own foot. Isn't it much too
>> easy to make a mistake with that syntax?
>
> What mistake?
>
>> What is so wrong with git-clone not allowing you to name the HEAD
>> differently?
>
> Did you read the preceding discussion? When you are pushing from your
> master branch to a remote branch, it may well be called different over
> there.

The real question is why you would even want to do that.

Managing multiple heads and making sure which one is which even
on a single repository is a mental burden, at least to me.  When
you can name local and remote differently, the name mappings
also need to be managed in addition to that.  Yes, the mappings
can be automated by Porcelains, but that means we need to have
another configuration item around (which needs to be compatible
across Porcelains) to achieve that flexibility, but what does
that flexibility really buys you?

My gut feeling is that Johannes is right here, at least about
the send-pack side.  Storing "master" pulled from a remote under
a name different from the remote is a different story.  I do not
have much problem with that.
