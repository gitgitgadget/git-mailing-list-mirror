From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Tue, 08 Nov 2005 17:42:26 -0800
Message-ID: <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051108210211.GA23265@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
	<20051108223609.GA4805@c165.ib.student.liu.se>
	<Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
	<20051109003236.GA30496@pasky.or.cz>
	<Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
	<7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:44:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZf04-0000sT-24
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 02:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431AbVKIBm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 20:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbVKIBm2
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 20:42:28 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:39631 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932431AbVKIBm2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 20:42:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051109014136.OWCI776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 8 Nov 2005 20:41:36 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 8 Nov 2005 17:22:15 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11383>

Linus Torvalds <torvalds@osdl.org> writes:

> It does:
>
> 	struct commit *commit = pop_one_commit(list_p);
> 	int still_interesting = !!interesting(*list_p);
>
> in that order: it looks whether there are any interesting commits left 
> _after_ it has popped the top-of-stack.

Ahhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh.  You are right.

The problem is most of the time hidden, because we usually do
one extra round (extra usually starts from 0 and we break out
after we say "not interesting anymore" and extra < 0).

Obviously, I was not thinking clearly.
