From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:33:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200927260.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <7vhcz2jzfd.fsf@assigned-by-dhcp.cox.net> <20060920161825.GR8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:35:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ52F-0007fn-OO
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbWITQeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751828AbWITQet
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:34:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751827AbWITQet (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:34:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KGXhnW021966
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 09:33:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KGXgDF003293;
	Wed, 20 Sep 2006 09:33:43 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060920161825.GR8259@pasky.or.cz>
X-Spam-Status: No, hits=-0.505 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27371>



On Wed, 20 Sep 2006, Petr Baudis wrote:
>
>   I argue that this safety valve is useless for most people (and
> actually I have hard time imagining a plausible scenario in which it
> actually _is_ useful).

It is only useless for people who use git ass a read-only "anonymous CVS" 
kind of thing.

And yes, that may be "most people", but dammit, it's not the group git has 
been designed for. 

I would be ok with a "anonymous read-only" approach IF GIT ACTUALLY 
ENFORCED IT. In other words, we could easily have a read-only clone that 
added the "+" to all branches, but then we should also make sure that 
nobody ever commits _anything_ in such a repo.

No merges (because you can not rely on the merge result being meaningful: 
the sources of the merge may be "ephemeral"), no local commits (because 
you can never "pull" any more after that, since that now becomes a merge 
with something you can't trust any more).

In other words, if you default to the "+" behaviour, you basically can do 
_nothing_ in that repository except just track the other end.

Is that useful? Potentially. But it's so clearly inferior to what we have 
now that you should definitely realize that we're not talking about a full 
git repository any more, we're really talking about just a "git tracker".

		Linus
