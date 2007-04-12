From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/6] Teach "fsck" not to follow subproject links
Date: Wed, 11 Apr 2007 19:30:11 -0700
Message-ID: <7vbqhul3yk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pi
	ne.LNX.4.64.0704092115020.6730@woody.linux-foundation.org>
	<461D6432.90205@v ilain.net>
	<Pine.LNX.4.64.0704111545040.6730@woody.linux-foundation.org>
	<461D6858.4090 007@vilain.net>
	<Pine.LNX.4.64.0704111605210.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63 .0704111600390.28394@qynat.qvtvafvgr.pbz>
	<Pine.LNX.4.64.0704111646000.6730@woody.linux-foundation.org>
	<Pine.LNX.4.63.0704111628240.28394@qynat.qvtvafvgr.pbz>
	<Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Lang <david.lang@digitalinsight.com>,
	Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 04:30:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbp4l-0003Ry-CS
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 04:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161480AbXDLCaP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 22:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161483AbXDLCaP
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 22:30:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:61756 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161480AbXDLCaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 22:30:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412023012.NERW1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 11 Apr 2007 22:30:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id m2WB1W00l1kojtg0000000; Wed, 11 Apr 2007 22:30:12 -0400
In-Reply-To: <Pine.LNX.4.64.0704111903060.4061@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 11 Apr 2007 19:14:31 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44314>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> But for git projects, even alternates isn't safe, in case somebody bases 
> their own work on a version of "pu" that eventually goes away (even with 
> reflogs, pruning *eventually* takes place).
>
> So I tend to think that alternates and shared object directories are 
> really for "temporary" stuff, or for *managed* repositories that are at 
> git *hosting* sites (eg repo.or.cz), and where there is some other safety 
> involved, ie users don't actually access the object directories directly 
> in any way.

Actually that is not even true for repo.or.cz -- the site lets
people to create *forks* of the main project, and I recall it is
implemented in terms of alternates.

That's one of the reasons I never asked to take over git.git
repository there.  I have alt-git.git instead, which does not
allow forks.
