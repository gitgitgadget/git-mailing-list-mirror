X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision: introduce ref@{N..M} syntax.
Date: Sun, 17 Dec 2006 11:38:56 -0800
Message-ID: <7vy7p65n3j.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com>
	<7vbqm36mv6.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0612171009550.3479@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 17 Dec 2006 19:39:04 +0000 (UTC)
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612171009550.3479@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 17 Dec 2006 10:14:12 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34701>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw1qf-00072T-P8 for gcvg-git@gmane.org; Sun, 17 Dec
 2006 20:39:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1750956AbWLQTi7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 14:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750949AbWLQTi7
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 14:38:59 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52419 "EHLO
 fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1750956AbWLQTi6 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006
 14:38:58 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061217193857.JXAA97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sun, 17
 Dec 2006 14:38:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id zvf91V00l1kojtg0000000; Sun, 17 Dec 2006
 14:39:09 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Well, logically, if you do that, then you should also allow
>
> 	git log master@{one.week.ago..yesterday}
>
> as a reflog expression.
> ...
> PS. Yeah, I'm only half serious. I like our revision parsing, and the 
> above _would_ actually be consistent with the "master@{1..3}" kind of 
> specification, but at the same time, it's also obviously more complex, and 
> maybe it's not THAT usable.
>
> But I think the "master@{date..date}" syntax would actually fall out 
> automatically if you did the {x..y} parsing at a higher level and didn't 
> force "x" and "y" to be digits only.

Syntax, yes, usage of it in "git show" yes,

But giving it to "git log" would not work as a naive user would
expect, which your example suggested ;-).

