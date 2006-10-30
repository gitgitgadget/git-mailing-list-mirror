X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git push: add verbose flag and allow overriding of default target repository
Date: Mon, 30 Oct 2006 15:02:07 -0800
Message-ID: <7vy7qxtnkg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
	<Pine.LNX.4.64.0610300825470.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 23:02:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0610300825470.25218@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 30 Oct 2006 08:28:59 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30549>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geg90-0000aE-2v for gcvg-git@gmane.org; Tue, 31 Oct
 2006 00:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161535AbWJ3XCK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 18:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161536AbWJ3XCK
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 18:02:10 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:19662 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1161535AbWJ3XCJ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 18:02:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030230208.RKGF18180.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 18:02:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gn1o1V00T1kojtg0000000 Mon, 30 Oct 2006
 18:01:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> This adds a command line flag "-v" to enable a more verbose mode, and 
> "--repo=" to override the default target repository for "git push" (which 
> otherwise always defaults to "origin").
>
> This, together with the patch to allow dashes in config variable names, 
> allows me to do
>
> 	[alias]
> 		push-all = push -v --repo=all
>
> in my user-global config file, and then I can (for any project I maintain) 
> add to the project-local config file
>
> 	[remote "all"]
> 		url=one.target.repo:/directory
> 		url=another.target:/pub/somewhere/else
>
> and now "git push-all" just updates all the target repositories, and shows 
> me what it does - regardless of which repo I am in.
>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> ---
>
> Maybe this is just useful to me?  I dunno.

I would say if something is useful to you it is useful to your
subsystem people and anybody who has a public tree and more than
one machines to verify the tips of his branches on, including
me.

