X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 14:50:14 -0800
Message-ID: <7virhhy76h.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org>
	<7vr6w5y7to.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 22:50:27 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 14 Nov 2006 14:36:19 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31389>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk76j-0003Ha-Lq for gcvg-git@gmane.org; Tue, 14 Nov
 2006 23:50:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966426AbWKNWuS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 17:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966427AbWKNWuR
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 17:50:17 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:65213 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S966426AbWKNWuQ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 17:50:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061114225015.QAYO9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Tue, 14
 Nov 2006 17:50:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id mmqM1V00L1kojtg0000000; Tue, 14 Nov 2006
 17:50:21 -0500
To: git@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Nicolas Pitre
 <nico@cam.org>, Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>  - I think it would be sensible to make remote tracking branches
>    less visible.  For example:
>...
>  - "git merge" to merge another branch into the current would
>    make sense.  "git pull . remotes/origin/next" is showing too
>    much implementation detail.  It should just be:
>
> 	git merge origin#next

This and other examples in "making remote tracking branches less
visible" are hard to read because I used the word "origin" in
two different sense.  So here is a needed clarification.

If you have remotes/upstream that says:

	URL: git://git.xz/repo.git
        Pull: refs/heads/master:remotes/origin/master
        Pull: refs/heads/next:remotes/origin/next

Then, currently the users need to say:

	git diff remotes/origin/master
        git merge remotes/origin/next

By "making tracking branches less visible", what I mean is to
let the users say this instead:

	git diff upstream
        git merge upstream#next



