X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 10:53:51 -0800
Message-ID: <7vzmaaozi8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
	<7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net>
	<87bqmswm1e.wl%cworth@cworth.org>
	<7vodqse90q.fsf@assigned-by-dhcp.cox.net>
	<87ac2cwha4.wl%cworth@cworth.org>
	<7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net>
	<878xhwwdyj.wl%cworth@cworth.org>
	<7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
	<7vd5786opj.fsf@assigned-by-dhcp.cox.net>
	<871wnnwi3k.wl%cworth@cworth.org>
	<7virgzuf38.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611282322320.9647@xanadu.home>
	<7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611291234350.9647@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 29 Nov 2006 18:56:13 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611291234350.9647@xanadu.home> (Nicolas Pitre's
	message of "Wed, 29 Nov 2006 13:08:52 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32656>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpUay-0004Ad-5i for gcvg-git@gmane.org; Wed, 29 Nov
 2006 19:55:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967545AbWK2SzW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 13:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967547AbWK2SzW
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 13:55:22 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:15579 "EHLO
 fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP id S967546AbWK2SzU
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 13:55:20 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao09.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061129185351.KGVU18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>; Wed, 29
 Nov 2006 13:53:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id siu01V00L1kojtg0000000; Wed, 29 Nov 2006
 13:54:00 -0500
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> writes:

> Of course amongst those newbies that didn't went away at this point 
> there will be those who decide to study further and come to the index 
> concept.  And I hope that we all agree that the index is a powerful but 
> still advanced concept that should not be presented up front.

I do not necessarily agree with the last sentence.

> But my point is: why not making a very little change to the default 
> commit behavior. Really little change involving -a being the default.  

While I understand that is what you are suggesting, my point is
that it will not stop at "commit -a".  I already gave an example
that "diff" needs to behave differently, if you want to match
the behaviour of git consistently with "newbie" expectations.

If you go down that path, you would end up with two systems
named git, that base their operations on two quite different
mental models and behave differently.  You do not want to go
there; well at least I don't.

> The impact on newbies will be significant as they won't have to grok 
> everything at once to make sense of this -a we are telling them to use 
> blindly.

So don't tell them to use "-a" blindly.  Teach them what it
means using the terms they understand; we assume they haven't
learned the "index" yet, so we would explain that "it is a way
to commit all changes in the working tree".  It is a short-hand
so that they do not have to list all modified paths (or their
git is recent enough, ".").

After they learn what it means and get used to using it, they
will start wondering why we do not default to "-a".  By that
time, they would already have learned the config (because the
first thing the tutorial teaches is user.name/user.email), and
can use the alias mechanismk there to alias -a away.
