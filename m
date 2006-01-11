From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] (Updated) Exec git programs without using PATH.
Date: Wed, 11 Jan 2006 13:32:00 -0800
Message-ID: <7vk6d6qwmn.fsf@assigned-by-dhcp.cox.net>
References: <1136849678.11717.514.camel@brick.watson.ibm.com>
	<1136849810.11717.518.camel@brick.watson.ibm.com>
	<7vwth8bxqd.fsf@assigned-by-dhcp.cox.net>
	<1136900174.11717.537.camel@brick.watson.ibm.com>
	<43C3CC4A.4030805@op5.se>
	<1136910406.11717.579.camel@brick.watson.ibm.com>
	<43C4075E.4070407@op5.se> <7vu0cb6f1n.fsf@assigned-by-dhcp.cox.net>
	<1136924980.11717.603.camel@brick.watson.ibm.com>
	<7vd5iz4mt7.fsf@assigned-by-dhcp.cox.net>
	<1136945538.11717.643.camel@brick.watson.ibm.com>
	<7v4q4bwavi.fsf@assigned-by-dhcp.cox.net>
	<1136999157.11717.658.camel@brick.watson.ibm.com>
	<7vek3esdw0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601111238550.5073@g5.osdl.org>
	<1137014812.11717.669.camel@brick.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 22:32:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwnZp-0007ER-L2
	for gcvg-git@gmane.org; Wed, 11 Jan 2006 22:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWAKVcF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jan 2006 16:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbWAKVcF
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jan 2006 16:32:05 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:35499 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750806AbWAKVcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2006 16:32:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060111213053.XOQQ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 11 Jan 2006 16:30:53 -0500
To: Michal Ostrowski <mostrows@watson.ibm.com>
In-Reply-To: <1137014812.11717.669.camel@brick.watson.ibm.com> (Michal
	Ostrowski's message of "Wed, 11 Jan 2006 16:26:52 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14518>

Michal Ostrowski <mostrows@watson.ibm.com> writes:

> I briefly tried to consider if I could hide the various fork()+exec()
> sequences behind something like the run_command*() interfaces (which
> would move us down the direction of something "spawn()"-like).  I found
> that there's a lot of variation between the various paths in terms of
> what happens between fork() and exec() on the various paths that does
> not lend itself to such consolidation.
>
> I'd love to be convinced otherwise.

Unfortunately I am with Michal on this one (both "eh, I do not
think that is feasible" and "I'd love to be...").

The run_command*() interfaces and its users were the best I
could come up with as far as such consolidations could go when I
did it.
