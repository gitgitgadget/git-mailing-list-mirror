From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Fri, 29 Jul 2005 01:24:54 -0700
Message-ID: <7vd5p2hve1.fsf@assigned-by-dhcp.cox.net>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca>
	<7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com>
	<20050722192424.GB8556@mars.ravnborg.org>
	<7vy87yr2xh.fsf@assigned-by-dhcp.cox.net>
	<20050722205948.GE11916@pasky.ji.cz>
	<7vd5p73jlu.fsf@assigned-by-dhcp.cox.net>
	<20050728155210.GA17952@pasky.ji.cz>
	<7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
	<20050729073644.GE24895@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 10:25:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyQAw-0000QX-Ul
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 10:25:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVG2IY5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 04:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262518AbVG2IY5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 04:24:57 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:8343 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262516AbVG2IY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2005 04:24:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050729082445.YMPA8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 29 Jul 2005 04:24:45 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050729073644.GE24895@pasky.ji.cz> (Petr Baudis's message of "Fri, 29 Jul 2005 09:36:44 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Hmm. What about just excluding the files according to the order of
> parameters on the command line?
>
> Here, the question is whether the GIT Core tools should provide full
> flexibility and friendness to custom use, or rather serve as tighter
> unifying layer for the porcelains, enforcing certain conventions.

While I would in principle prefer to offer more freedom to shoot
yourselves in the foot ;-), the pragmatic side of me says too
much flexibility is just asking for trouble with not much
additional gain.  For example, your "generic first, and then
list exceptions" argument convinced me to shelve the "first
match wins" rule, but I _could_ have added an extra option to
allow other Porcelain writers who want to have "most number of
match wins" rule while at it.  I didn't.  Let's wait and see if
somebody else comes up with a different use scenario that would
be useful in real life.

In the meantime, the current one is clearly broken as you
pointed out, so let's replace it with the updated "generic rule
with the following exceptions" one.
