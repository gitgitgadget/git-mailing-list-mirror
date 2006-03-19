From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-reset and clones
Date: Sun, 19 Mar 2006 22:40:38 +0100
Message-ID: <20060319214038.GF18185@pasky.or.cz>
References: <Pine.LNX.4.64.0603161424310.5276@sheen.jakma.org> <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paul@hibernia.jakma.org, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 19 22:40:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FL5dU-0003Lj-OX
	for gcvg-git@gmane.org; Sun, 19 Mar 2006 22:40:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751094AbWCSVkZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Mar 2006 16:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWCSVkZ
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Mar 2006 16:40:25 -0500
Received: from w241.dkm.cz ([62.24.88.241]:19094 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751094AbWCSVkZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Mar 2006 16:40:25 -0500
Received: (qmail 6776 invoked by uid 2001); 19 Mar 2006 22:40:38 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4q1x95yo.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17725>

Dear diary, on Fri, Mar 17, 2006 at 03:10:23AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> You used to have something like this:
> 
> 
>                  o---o---o---A
>                 /            ^ your HEAD used to point at here
>     ---o---o---o
> 
> and you forgot other people already have the commit chain up to
> commit A.   But you rewound and did cleanups:
> 
>                  o---o---o---A
>                 /
>     ---o---o---o---o---o---B
>                            ^ your HEAD now points at here
> 
> People who track your HEAD have A and your updated head B does
> not fast forward.  Oops.

Just for the sake of completeness, this is a GIT-only doctrine; Cogito
is more confiding and has less strict requirements.

First, when fetching, it does not care at all whether the new head is a
fast-forward of the original one or not.

Second, when the people who are tracking you had A as their current
master head _and_ also the origin remote head (or whichever their
respective branch names are), their current master head will be updated
to B when cg-updating, as Cogito pretends it to be a fast-forward even
though it is not.

So, in the simple tracking cases, Cogito will do the right thing, if you
use cg-update.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Right now I am having amnesia and deja-vu at the same time.  I think
I have forgotten this before.
