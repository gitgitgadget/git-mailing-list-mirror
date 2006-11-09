X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-svn: fix dcommit losing changes when out-of-date from svn
Date: Thu, 09 Nov 2006 02:00:18 -0800
Message-ID: <7vfyctkki5.fsf@assigned-by-dhcp.cox.net>
References: <455277A6.2000404@midwinter.com>
	<20061109091937.GA22853@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 9 Nov 2006 10:00:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061109091937.GA22853@localdomain> (Eric Wong's message of
	"Thu, 9 Nov 2006 01:19:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31189>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6hs-0007L8-1f for gcvg-git@gmane.org; Thu, 09 Nov
 2006 11:00:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754774AbWKIKAU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006
 05:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754777AbWKIKAU
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 05:00:20 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:14811 "EHLO
 fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP id S1754774AbWKIKAT
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 05:00:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao07.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061109100018.YUDD27894.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>; Thu, 9
 Nov 2006 05:00:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ka0P1V00N1kojtg0000000; Thu, 09 Nov 2006
 05:00:24 -0500
To: Eric Wong <normalperson@yhbt.net>, Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> There was a bug in dcommit (and commit-diff) which caused deltas
> to be generated against the latest version of the changed file
> in a repository, and not the revision we are diffing (the tree)
> against locally.
>
> This bug can cause recent changes to the svn repository to be
> silently clobbered by git-svn if our repository is out-of-date.
>
> Thanks to Steven Grimm for noticing the bug.
>
> The (few) people using the commit-diff command are now required
> to use the -r/--revision argument.  dcommit usage is unchanged.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>

Thanks both for your clear problem report and quick resolution
of the issue.

Steven, I do not interact with real svn repository myself so I
can only judge from the test in this patch and Steven's test
case, so it would be more assuring for me if you can confirm it
fixes the issue for you.
