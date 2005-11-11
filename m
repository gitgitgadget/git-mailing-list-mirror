From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge-base: fully contaminate the well.
Date: Thu, 10 Nov 2005 22:04:13 -0800
Message-ID: <7viruzu3du.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
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
	<7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net>
	<7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511090800330.3247@g5.osdl.org>
	<7virv1efzv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511091348530.4627@g5.osdl.org>
	<7virv1a0ro.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511091518370.4627@g5.os
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 07:04:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaS1K-0000uo-NH
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 07:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVKKGEQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 01:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVKKGEP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 01:04:15 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58864 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751252AbVKKGEP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 01:04:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111060415.LTFT9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 01:04:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511102125510.4627@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 10 Nov 2005 21:36:03 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11563>

Linus Torvalds <torvalds@osdl.org> writes:

> So the cheap test is to just say
>
> 	/* Do we have multiple results? */
> 	if (result->next)
> 		contaminate_well(result);
>
> no?

Correct.  And this is only for really artificial corner case so
we should try to avoid for normal cases as much as possible,
cheaply.

> Btw, I don't think your contamination logic is necessarily complete. We 
> may not even have parsed some of the commits that end up being on that 
> strange corner case.

I haven't tried walking any other test cases, but wouldn't that
be arguing that the our assumption that the current merge-base
is at least complete if not optimum?
