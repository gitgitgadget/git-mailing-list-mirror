From: Sergei Organov <osv@javad.com>
Subject: [PATCH] core-tutorial.txt: Fix git-show-branch example and its description
Date: Thu, 08 Nov 2007 18:10:28 +0300
Message-ID: <877iks93iz.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 16:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq920-0005zk-Fm
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758609AbXKHPKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759031AbXKHPKj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:10:39 -0500
Received: from javad.com ([216.122.176.236]:2911 "EHLO javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758440AbXKHPKi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:10:38 -0500
Received: from osv ([87.236.81.130])
	by javad.com (8.11.6/8.11.0) with ESMTP id lA8FAZ027169;
	Thu, 8 Nov 2007 15:10:35 GMT
	(envelope-from s.organov@javad.com)
Received: from osv by osv with local (Exim 4.63)
	(envelope-from <s.organov@javad.com>)
	id 1Iq91Y-0001Eq-3l; Thu, 08 Nov 2007 18:10:28 +0300
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64037>



Signed-off-by: Sergei Organov <osv@javad.com>
---

 The example and its description didn't match each other. In addition,
 I've added explanatory notes that hopefully will decrease the chances
 of confusion I've personally ran into after reading this part of the
 tutorial.

 Documentation/core-tutorial.txt |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
index 99817c5..ebd2492 100644
--- a/Documentation/core-tutorial.txt
+++ b/Documentation/core-tutorial.txt
@@ -931,12 +931,13 @@ Another useful tool, especially if you do not always work in X-Window
 environment, is `git show-branch`.
 
 ------------------------------------------------
-$ git show-branch --topo-order master mybranch
+$ git-show-branch --topo-order --more=1 master mybranch
 * [master] Merge work in mybranch
  ! [mybranch] Some work.
 --
 -  [master] Merge work in mybranch
 *+ [mybranch] Some work.
+*  [master^] Some fun.
 ------------------------------------------------
 
 The first two lines indicate that it is showing the two branches
@@ -954,10 +955,22 @@ because `mybranch` has not been merged to incorporate these
 commits from the master branch.  The string inside brackets
 before the commit log message is a short name you can use to
 name the commit.  In the above example, 'master' and 'mybranch'
-are branch heads.  'master~1' is the first parent of 'master'
+are branch heads.  'master^' is the first parent of 'master'
 branch head.  Please see 'git-rev-parse' documentation if you
 see more complex cases.
 
+[NOTE]
+Without the '--more=1' option, 'git-show-branch' would not output the
+'[master^]' commit, as '[mybranch]' commit is a common ancestor of
+both 'master' and 'mybranch' tips.  Please see 'git-show-branch'
+documentation for details.
+
+[NOTE]
+If there were more commits on the 'master' branch after the merge, the
+merge commit itself would not be shown by 'git-show-branch' by
+default.  You would need to provide '--sparse' option to make the
+merge commit visible in this case.
+
 Now, let's pretend you are the one who did all the work in
 `mybranch`, and the fruit of your hard work has finally been merged
 to the `master` branch. Let's go back to `mybranch`, and run
-- 
1.5.3.5.529.ge3d6d
