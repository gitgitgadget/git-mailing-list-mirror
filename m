X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 13:52:47 -0800
Message-ID: <7vac2sjs28.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<200611151858.51833.andyparkins@gmail.com>
	<Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
	<f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
	<Pine.LNX.4.64.0611151203450.3349@woody.osdl.org>
	<Pine.LNX.4.64.0611151516360.2591@xanadu.home>
	<Pine.LNX.4.64.0611151226590.3349@woody.osdl.org>
	<87velgs9hx.wl%cworth@cworth.org>
	<7virhgjt25.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611151638550.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 21:53:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611151638550.2591@xanadu.home> (Nicolas Pitre's
	message of "Wed, 15 Nov 2006 16:40:03 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31509>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSgv-0000o6-US for gcvg-git@gmane.org; Wed, 15 Nov
 2006 22:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161774AbWKOVxG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 16:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161775AbWKOVxG
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 16:53:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:49050 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S1161774AbWKOVxD
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 16:53:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061115215302.NYZK18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 15
 Nov 2006 16:53:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id n9t81V00g1kojtg0000000; Wed, 15 Nov 2006
 16:53:09 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 15 Nov 2006, Junio C Hamano wrote:
>
>> I am wondering if that could be "git merge <committish>..."
>> instead.  I do not care too much about the ... part (i.e. an
>> Octopus), but I often find myself doing:
>> 
>> 	git checkout next
>>         git merge "Merge early part of branch 'foo'" HEAD foo~3
>> 
>> when earlier part of "foo" topic are worthy to be in 'next' but
>> not the later ones.
>
> Indeed !

Indeed, what?

That means that updated "git merge" (not the current one) would
not be able to assume it's parameter is a branch name, and still
has to come up with the merge message "Merge <branch>".

Merging only within the local branch namespace already has the
problem you need to solve to come up with a nicely formatted
"Merge <branch> of <remote repository>" some way.  I am not
saying that this is unsolvable (you can look at remotes/ files
to see what remote tracking branch the branch is about), but
something you need to keep in mind when implementing the
improved "git merge".
