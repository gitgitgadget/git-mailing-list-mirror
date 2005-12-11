From: Junio C Hamano <junkio@cox.net>
Subject: What's in master tonight...
Date: Sun, 11 Dec 2005 00:06:16 -0800
Message-ID: <7vacf8oy6f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 09:06:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElMDv-0004wI-D6
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 09:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVLKIGT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 03:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVLKIGT
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 03:06:19 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:40164 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751325AbVLKIGS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 03:06:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211080428.LFKR20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 03:04:28 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13487>

For the past couple of days, many of the changes merged into
"master" branch have been documentation updates and general
cleanups, except these notable fixes and improvements:

 - Hooks are run with stdin/stdout thrown into /dev/null (Daniel
   Barkalow).

 - Updates to gitk to work around Tcl/Tk's i18n, which does not
   understand MIME charset names IANA recommends (Paul
   Mackerras).

 - Portability enhancements for AIX and Solaris (Jason Riedy).

 - Fixes to archimport (Eric Wong and Martin Langhoff)

 - Fixes related to various C std issues (Morten Welinder and me)

 - Catch common mistakes such as not having "merge" installed,
   to reduce false bug reports on the mailing list.

 - Safety fix for git-prune.

 - Remove useless computation from server-info.

 - Fix git-http-fetch so that it does not fail creating a ref in
   a subdirectory.

 - Leave paths that failed to automerge unmerged in the index
   when merge-one-file returns.

 - Same for merge-recursive rename/merge case (this is waiting
   in "pu" tonight, waiting for comments from the original
   author).

With these changes, we are really in good shape for 1.0.  I'll
do another test script or two for the renaming recursive merge
to make sure I did not break things, and am hoping to tag 1.0rc5
by early next week.  If things go well as planned that would
become the final 1.0.

I have not merged the 20+ help text series by Fredrik yet, but
most of them are low impact and expect most of them will be in
1.0, in one shape or another if not verbatim.
