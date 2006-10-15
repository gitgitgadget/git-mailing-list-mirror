From: Junio C Hamano <junkio@cox.net>
Subject: I've tagged 1.4.3-rc3 but there is a last-minute monkey wrench...
Date: Sun, 15 Oct 2006 01:04:28 -0700
Message-ID: <7vvemmypgz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Oct 15 10:04:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZ0zH-0004kH-Ri
	for gcvg-git@gmane.org; Sun, 15 Oct 2006 10:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422871AbWJOIEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 04:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422872AbWJOIEd
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 04:04:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:31431 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1422871AbWJOIE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 04:04:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061015080428.URRF3939.fed1rmmtao12.cox.net@fed1rmimpo01.cox.net>;
          Sun, 15 Oct 2006 04:04:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id aY4G1V0091kojtg0000000
	Sun, 15 Oct 2006 04:04:16 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28908>

Changes since -rc2 are mostly fixes:

 - Christian Couder fixed the tracing facility so that
   "GIT_TRACE= git-foo" and "unset GIT_TRACE; git-foo" to
   behave the same;

 - Assorted git-svn fixes from Eric Wong;

 - Johannes fixed "diff -w -b";

 - Also Johannes has two fixes to cvsserver;

 - http-fetch transport does not use webdav to discover remote
   refs anymore;

 - breakage in generating RPM (perl-Git) has been fixed;

 - "git-apply --numstat -z" did not terminate line with NUL -- fixed;

 - Martin Waitz made "git diff" to run pager by default;

 - Nicolas Pitre made sideband remote messages to be written out
   with single write(2) to prevent them from being broken up;

 - Rene Scharfe has a good API clean-up:  hash_sha1_file();

 - Yasushi SHOJI noticed and fixed that "git-clone" did not
   correctly handle the origin repository specified as a
   relative directory; it treated it relative to the new
   repository not the directory the command was started from.

But there is already one commit that is rather important on the
"master" branch after -rc3.  It is needed so that we do not
break git older than v1.2.0 (Feb 12, 2006).

I am still hoping we can declare v1.4.3 on coming Wednesday,
unless it is eaten by my day job (which is unfortunately not so
unusual for me these days), in which case we would have to defer
it until next weekend.
