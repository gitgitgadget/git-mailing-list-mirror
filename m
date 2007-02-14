From: Junio C Hamano <junkio@cox.net>
Subject: What's cooking in git.git (topics)
Date: Wed, 14 Feb 2007 15:59:28 -0800
Message-ID: <7vhctojnof.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 15 00:59:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHU28-0005A5-LN
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 00:59:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXBNX7a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbXBNX7a
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 18:59:30 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:60006 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXBNX73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 18:59:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214235930.SMTG1349.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 18:59:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PbzV1W0041kojtg0000000; Wed, 14 Feb 2007 18:59:29 -0500
X-master-at: 78e90f89e39b112af2670516f80586163dcd56ca
X-next-at: 452012544786863a65a9772ed2d5ee380aae607c
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39776>

Here are the topics that have been cooking.  Commits prefixed
with '-' are only in 'pu' while commits prefixed with '+' are
in 'next'.  The topics list the commits in reverse chronological
order.

* lt/crlf (Wed Feb 14 14:54:00 2007 -0800) 3 commits
 + t0020: add test for auto-crlf
 + Make AutoCRLF ternary variable.
 + Lazy man's auto-CRLF

I suspect this has quite a long way to go, since the code to do
stacked .gitignore is tightly coupled with the directory walking
code, and the proposed .gitattribute needs to redo that logic;
which hopefully would result in nicer code that can then be used
for handing .gitignore -- so we'll all win.  I think git-apply
codepath needs to be fixed independently from what Linus already
did, but I haven't looked into it deeply yet.

* ap/cvsserver (Tue Feb 13 15:12:45 2007 +0000) 1 commit
 + Have git-cvsserver call hooks/update before really altering the
   ref

This I think is Ok.  Just waiting for Acks from third-party
git-cvsserver users.

* jc/fetch (Tue Feb 13 01:21:41 2007 +0000) 8 commits
 - Use stdin reflist passing in git-fetch.sh
 - Use stdin reflist passing in parse-remote
 - Allow fetch--tool to read from stdin
 - git-fetch: rewrite expand_ref_wildcard in C
 - git-fetch: rewrite another shell loop in C
 - git-fetch: move more code into C.
 - git-fetch--tool: start rewriting parts of git-fetch in C.
 - git-fetch: split fetch_main into fetch_dumb and fetch_native

Stalled.  I think the subroutines in git-fetch--tool are
reusable for rewriting git-fetch entirely in C, but I estimate
I've covered only 30% or so of what is necessary.

* jc/diff (Mon Dec 25 01:08:50 2006 -0800) 2 commits
 - test-para: combined diff between HEAD, index and working tree.
 - para-walk: walk n trees, index and working tree in parallel

Stalled.
