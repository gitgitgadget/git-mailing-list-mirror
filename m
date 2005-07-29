From: Junio C Hamano <junkio@cox.net>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Fri, 29 Jul 2005 00:48:57 -0700
Message-ID: <7vmzo6jbme.fsf@assigned-by-dhcp.cox.net>
References: <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net>
	<200507271458.43063.Josef.Weidendorfer@gmx.de>
	<20050728120806.GA2391@pasky.ji.cz>
	<Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728153506.GL14229@pasky.ji.cz>
	<Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
	<20050728161815.GC17952@pasky.ji.cz>
	<7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
	<20050728183904.GA24948@pasky.ji.cz>
	<7v4qaeqrh3.fsf@assigned-by-dhcp.cox.net>
	<20050729070628.GA24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:54:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPh7-0006H8-E4
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVG2HvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVG2HtM
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:49:12 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:32192 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262499AbVG2HtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 03:49:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729074853.SKUS19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 03:48:53 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729070628.GA24895@pasky.ji.cz> (Petr Baudis's message of "Fri, 29 Jul 2005 09:06:29 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Aha, so it seems our problem is hopefully only in terminology, great.
>
> So, what do you mean by "clone" here? And what command should I use for
> pushing then?

Notice I never used the word "clone" in what I said.

What I mean by "a semantically equivalent two repositories,
potentially one being a strict subset of the other" is you can
pull head A from one or head A from the other and can get the
same result (although one may and the other may not have head
B).  And naturally you use send-pack for pushing.

If I "clone" from repository A to create a repository B, I would
never "push back" from B to A.  Instead I would ask a person who
owns A to "pull from B".  My impression is the patch flow in the
kernel circle works like that (although I have never been in
that circle).

Now, A may happen to be on my home machine and B may happen be
on my notebook, meaning the owner of A and B are both myself.
But even in that case I would still work by "pulling from A"
when I am on B, and "pulling from B" when I am on A.  In other
words, "pulling" is the only patch flow mechanism I would use.
Pushing is only for publication and I treat it as just a
GIT-aware rsync/mirror, nothing more.  I have a feeling that
your workflow is different and you plan to use both push and
pull for normal patch flows.  This distinction is probably where
the disagreement comes from.

And I strongly suspect that the primary reason that I "simply do
not get it" after reading your messages is because my mental
model is strongly molded into what Linus taught us.  I have to
unlearn things...
