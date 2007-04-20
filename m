From: Junio C Hamano <junkio@cox.net>
Subject: Re: cherry-pick --since ?
Date: Fri, 20 Apr 2007 16:05:08 -0700
Message-ID: <7v647qy7dn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704201100050.4667@torch.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Apr 21 01:05:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf2AG-0005P2-4D
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 01:05:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767314AbXDTXFL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 19:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767317AbXDTXFL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 19:05:11 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:34955 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767314AbXDTXFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 19:05:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070420230510.LDPM1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Apr 2007 19:05:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id pb581W00Z1kojtg0000000; Fri, 20 Apr 2007 19:05:09 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45135>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Is there functionality to allow something akin to
> a
>    git cherry-pick --since <commit>
>
> or maybe syntax similar to git cherry where the upstream, head,
> and limit can be specified. Or the .. syntax would work.
>
>
> Here's my use case:
>
> Two branches, 'A' and 'B'.
> 'A' is the master branch.
> 'B' was forked some time ago and is in bug fix only mode.
> Much of 'A' and 'B' are still the same, but there have been
>   some intrusive changes made to 'A' that should not go into 'B'.

You forgot to say "My objective is to make sure all the good
fixes in B are forward ported to A" but I am assuming that is
the case.

>   This is also why I can't just pull from 'B'. rebase may work,
>   but then of course all of the commit id's change.

I do not understand why you cannot merge 'B' into 'A'.  From the
commit ancestry perspective, merging is exactly the right thing
to do if your goal is to forward port all fixes in B to A.
