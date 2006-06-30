From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Thu, 29 Jun 2006 21:13:09 -0700
Message-ID: <7v7j2zmgbu.fsf@assigned-by-dhcp.cox.net>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
	<20060625184757.f8273820.tihirvon@gmail.com>
	<E1FuX8l-0001H5-2z@moooo.ath.cx>
	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
	<7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
	<E1Fw8hS-00023y-FY@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 06:13:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwANi-0004U7-0F
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 06:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbWF3ENM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 00:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWF3ENM
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 00:13:12 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2815 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750891AbWF3ENL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 00:13:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060630041310.SDET554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 00:13:10 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1Fw8hS-00023y-FY@moooo.ath.cx> (Matthias Lederhofer's message
	of "Fri, 30 Jun 2006 04:25:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22952>

Matthias Lederhofer <matled@gmx.net> writes:

> OR and AND have precedence, so there are two possibilities, I'd take
> the first one.
> 1. OR, AND:
>     This will make it easier to read because OR can be skipped:
>       pat1 pat2 AND pat3 pat4
>     = pat1 OR pat2 AND pat3 OR pat4
>     = (pat1 OR pat2) AND (pat3 OR pat4)
> 2. AND, OR:
>     This is a bit more logic if you think of AND as * and OR as +.

> ... FOO should not be named --and imo but I don't have any idea
> for a good name atm.

I personally feel FOO should not even exist.  An option that
covers the entire expression to make operator precedence in it
sounds quite evil.  

I would say make --and bind tighter than --or and use
parentheses as needed.  Making --or optional sounds fine as that
would make the default "multiple -e" case similar to what GNU
grep does without any --and nor --or.
