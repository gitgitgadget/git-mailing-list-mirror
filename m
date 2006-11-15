X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 10:16:02 -0800
Message-ID: <7vbqn8o9st.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
	<7virhhy76h.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142048350.2591@xanadu.home>
	<7vu011qnl6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611151454250.13772@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0611151000460.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 18:16:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611151000460.2591@xanadu.home> (Nicolas Pitre's
	message of "Wed, 15 Nov 2006 10:10:50 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31458>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkPIw-00031L-HR for gcvg-git@gmane.org; Wed, 15 Nov
 2006 19:16:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030802AbWKOSQG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 13:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030804AbWKOSQG
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 13:16:06 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53210 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S1030802AbWKOSQD
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 13:16:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115181602.PGKS9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 13:16:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n6G81V00v1kojtg0000000; Wed, 15 Nov 2006
 13:16:09 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

>> Why not do something like "get/put" instead? It is
>> 
>> - easier to remember
>> - not bogus (AFAICT the meaning is not used in diametrical senses)
>> - shorter to type than download/upload
>
> Well, of all compromizes this is probably the best one so far.  I would 
> have prefered to bite the bullet and fix "pull" instead of adding yet 
> more commands.  But if the consensus is that there is no way on earth 
> that "pull" can be salvaged then get/put is probably more enjoyable than 
> download/upload.  This way pull/fetch/push could still be available 
> (albeit burried somewhere out of sight).

I still think in the long run you would be better off giving
separate names to Porcelains because I am sure you are going to
find the next command to "fix", you cannot suddenly change the
semantics of the command, and you soon run out of alternative
ways to name the action and you in addition have to explain the
differences between fetch and get to new users.  At least, with
"ig pull", you can dismiss all the broken git-x Porcelain-ish by
saying "Oh, git-x user-level commands had inconsistent semantics
and broken UI so do not use them anymore -- they are still there
only to help old timers transition.  The user level commands are
now called ig-x and ig stands for improved git".

But that's a very minor detail and can be fixed when we hit the
wall, so let's wait and see what happens.  Please consider my
gh/gu/cg/whatever dropped.

I think get/put is much better than suddenly changing what pull
means and is shorter to type than x-load; I am Ok with them.
Although I think these words are tainted by SCCS, I do not think
anybody cares.
