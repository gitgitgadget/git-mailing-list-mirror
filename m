From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Thu, 28 Sep 2006 23:37:58 -0700
Message-ID: <7vy7s3npo9.fsf@assigned-by-dhcp.cox.net>
References: <20060922223506.3377.34859.stgit@lathund.dewire.com>
	<7vvenfw727.fsf@assigned-by-dhcp.cox.net>
	<200609290128.56217.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 08:38:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTC0b-0000tb-SB
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161446AbWI2GiA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbWI2GiA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:38:00 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:4863 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932544AbWI2Gh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 02:37:59 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929063759.BAT12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 02:37:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id U6du1V00b1kojtg0000000
	Fri, 29 Sep 2006 02:37:55 -0400
To: Robin Rosenberg <robin.rosenberg@dewire.com>
In-Reply-To: <200609290128.56217.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Fri, 29 Sep 2006 01:28:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28095>

Please do not do more than one patch per e-mail; I'll have to
save the attachment in separate files and manually make commits,
which is more work.

The build procedure for the release to build rpms runs testsuite
as part of it, so I need to think a bit how to proceed with this
patch.  Leaving the test failing on FC5 means I won't be able to
cut binary releases.  Checking early in the test script to see
if "patch" can grok a diff for a file with whitespaces, and
skipping the whitespace test if we have a bad "patch", seems to
the best workaround.

BTW, the addition of TAB to the patch tail is done by "git diff"  
automatically for files with whitespace in them in the proposed
updates version in "pu" (and it is done conditionally only for
files whose names have whitespace), so I think your fix will
become redundant when it graduates to "master".
