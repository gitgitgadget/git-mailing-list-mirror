X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Show the branch type after the branch name for remotes
Date: Fri, 03 Nov 2006 12:08:33 -0800
Message-ID: <7vmz785m4e.fsf@assigned-by-dhcp.cox.net>
References: <bec6ab7849e3fcacac23cca44a0ba93282af5fca.1162465753.git.andyparkins@gmail.com>
	<200611021111.32759.andyparkins@gmail.com>
	<7vy7qtl0bk.fsf@assigned-by-dhcp.cox.net>
	<200611030833.42596.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 3 Nov 2006 20:08:55 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611030833.42596.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 3 Nov 2006 09:33:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30880>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg5LC-0006p5-As for gcvg-git@gmane.org; Fri, 03 Nov
 2006 21:08:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932075AbWKCUIf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 15:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932082AbWKCUIe
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 15:08:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:15765 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S932075AbWKCUIe
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 15:08:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061103200833.TRQE13632.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 15:08:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iL8C1V0091kojtg0000000 Fri, 03 Nov 2006
 15:08:12 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> For me personally, I find my git-branch output more useful because in it's 
> unswitched form it shows me all branches.  However, I can easily put this 
> behaviour under a switch or, and this would get my vote, put the original 
> behaviour (i.e. show local branches only) under a switch.
>
> Which would you like?  If any.

I am a wrong person to ask, since I do not usually work in
repositories with refs/remotes/ myself and the choice would not
affect me either way.

For people who work with multiple remotes (e.g. following both
Linus and Jeff) and work on many separate topic branches of
their own, I would suspect that showing only local branches by
default, with an option to show remote branches from only named
remotes would make things less cluttered, and we can always have
"-a" to mean everything under the sun.

This kind of limiting can be done more flexibly with globbing
than just fixed set of flags.

We could have:

	git branch --list 'heads/'
        git branch --list 'remotes/jgarzik/'
        git branch --list 'heads/??/*'

and that command, crazily enough, would let you do:

        git branch --list 'tags/v2.6.19-rc*'

Hmm?
