From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix git-rev-parse breakage
Date: Tue, 23 Aug 2005 20:22:20 -0700
Message-ID: <7vy86skoib.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 24 05:23:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7lqO-0006H2-Ug
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 05:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbVHXDWX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 23:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbVHXDWX
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 23:22:23 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:17633 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750943AbVHXDWW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 23:22:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824032221.HNOD8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 23:22:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508231908170.3317@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 23 Aug 2005 19:17:37 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7701>

Linus Torvalds <torvalds@osdl.org> writes:

> This makes "--revs-only" imply "--no-flags".
>
> [ Side note: we might want to get rid of these confusing two-way flags, 
>   where some flags say "only print xxx", and others say "don't print yyy". 
>   We'd be better off with just three flags that say "print zzz", where zzz
>   is one of "flags, revs, norevs" ]

I suspect that would not fly too well.

Being able to say "give me all flags meant for rev-list", "give
me all what are meant for rev-list", and "give me all non-flags
that are meant for rev-list" are very handy, so I'd rather want
to see --revs-only to mean "meant for rev-list", --no-revs to
mean "not meant for rev-list", --flags to mean "only ones that
start with a '-'", and --no-flags to mean "only ones that do not
start with a '-'".  And that would give me (rev/no-rev/lack
thereof) x (flag/no-flag/lack thereof) = 9 combinations.
