From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: Please undo "Use git-merge instead of git-resolve in
Date: Thu, 22 Sep 2005 18:54:34 -0400 (EDT)
Message-ID: <BAYC1-PASMTP0529AB50E9E3F8BACFE1EFAE970@CEZ.ICE>
References: <E1EIVsD-0001Hu-9m@jdl.com> <20050922191058.GM21019@pasky.or.cz>
    <BAYC1-PASMTP0510EEC44C7F787F27215AAE970@CEZ.ICE>
    <7vk6h8lp3k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 01:20:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIaLD-0003Uk-7O
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 01:18:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbVIVXSq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 19:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbVIVXSq
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 19:18:46 -0400
Received: from bayc1-pasmtp05.bayc1.hotmail.com ([65.54.191.165]:62895 "EHLO
	BAYC1-PASMTP05.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751060AbVIVXSq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 19:18:46 -0400
X-Originating-IP: [64.231.205.75]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([64.231.205.75]) by BAYC1-PASMTP05.bayc1.hotmail.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 22 Sep 2005 16:18:12 -0700
Received: by linux1.attic.local (Postfix, from userid 48)
	id B8D43644C0E; Thu, 22 Sep 2005 18:54:34 -0400 (EDT)
Received: from 10.10.10.28
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Thu, 22 Sep 2005 18:54:34 -0400 (EDT)
Message-ID: <55917.10.10.10.28.1127429674.squirrel@linux1>
In-Reply-To: <7vk6h8lp3k.fsf@assigned-by-dhcp.cox.net>
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 22 Sep 2005 23:18:13.0069 (UTC) FILETIME=[E75AEFD0:01C5BFCB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, September 22, 2005 6:22 pm, Junio C Hamano said:
> "Sean" <seanlkml@sympatico.ca> writes:
>
>> Why doesn't cogito just use the git fetch/pull commands?   Why does it
>> need anything special?   It seems like cogito is doing more than just
>> being an ease-of-use layer above git.
>
> The way this question is posed is quite unfair to Pasky -- it
> makes him look needlessly bad.

Will try to pose it differently then, because it was not meant to make him
"look bad".  In a different email Pasky seemed to be musing that cogito
might do away with fast forward merges.  This too seemed like a decision
best left to the plumbing, so i have been wondering how Pasky views
cogito's relationship to git.

But the immediate question really was, wouldn't it be better if cogito
used the same code paths that git uses for push/pull/fetch?  Is there a
reason that this isn't possible?

> The simple reason is because Cogito had its own richer
> fetch/pull first.  The development of git aware pack transfer
> protocols by Linus and the list discussion for multi-head pushes
> and pulls came much later, which resulted in the current 'git
> fetch/pull' interface.

Yes, cogito had it first but once this functionality gets pushed down into
git (where it's been for a while now) it makes a lot of sense for the
procelain layers to use it.   That way the functionality only has to be
maintained in one place and nobody has to guess what transports work with
cogito or git etc.  But perhaps there are reasons that this just isn't
possible with the cogito code, i dunno.

Sean
