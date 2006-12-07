X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 07 Dec 2006 14:36:40 -0800
Message-ID: <7vmz5zqqo7.fsf@assigned-by-dhcp.cox.net>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
	<81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
	<86ejrbihnr.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 22:37:06 +0000 (UTC)
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <86ejrbihnr.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "07 Dec 2006 12:18:32 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33642>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsRrQ-0008Su-97 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 23:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163546AbWLGWgn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163548AbWLGWgn
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 17:36:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:60412 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163546AbWLGWgm (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 17:36:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061207223642.IQPI9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Thu, 7
 Dec 2006 17:36:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vycr1V00p1kojtg0000000; Thu, 07 Dec 2006
 17:36:52 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
Sender: git-owner@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:
>
> Alex> Strange. You seem to have the old, generated Makefile you perl/
> Alex> directory. Haven't your pull failed? If so, I suspect that
>
> Alex>  rm perl/Makefile
> Alex>  git reset --hard
> Alex>  git pull git...
>
> I ended up having to do another reset afterward.
>
> Definitely something went weird when Makefile was removed
> from .gitignore.

Yes, perl/Makefile is getting overwritten by what Makefile.PL
generates.  I thought the point of Alex's patch was to have it
muck with perl.mak and leave the tracked Makefile alone?

