From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsexportcommit: add some examples to the documentation
Date: Mon, 30 Jan 2006 19:29:01 +1300
Message-ID: <1138602541556-git-send-email-martin@catalyst.net.nz>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Mon Jan 30 07:29:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3SXF-0002g9-2a
	for gcvg-git@gmane.org; Mon, 30 Jan 2006 07:29:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWA3G3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jan 2006 01:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbWA3G3F
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jan 2006 01:29:05 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:48057 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751254AbWA3G3E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2006 01:29:04 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=aporo.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with smtp (Exim 4.50)
	id 1F3SX7-0006yZ-9p; Mon, 30 Jan 2006 19:29:02 +1300
To: git@vger.kernel.org
In-Reply-To: 
X-Mailer: git-send-email
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15262>

Updated with Randall Schwartz's suggestion

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 Documentation/git-cvsexportcommit.txt |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

69c980351a6d74d033a8d70fb37970c71ff8e855
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 13cbf3b..e2540fb 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -17,6 +17,7 @@ Exports a commit from GIT to a CVS check
 to merge patches from a git repository into a CVS repository. 
 
 Execute it from the root of the CVS working copy. GIT_DIR must be defined. 
+See examples below.
 
 It does its best to do the safe thing, it will check that the files are 
 unchanged and up to date in the CVS checkout, and it will not autocommit 
@@ -41,6 +42,26 @@ OPTIONS
 -v::
 	Verbose.
 
+EXAMPLES
+--------
+
+Merge one patch into CVS::
++
+------------
+$ export GIT_DIR=~/project/.git
+$ cd ~/project_cvs_checkout
+$ git-cvsexportcommit -v <commit-sha1>
+$ cvs commit -F .mgs <files> 
+------------
+
+Merge pending patches into CVS automatically -- only if you really know what you are doing ::
++
+------------
+$ export GIT_DIR=~/project/.git
+$ cd ~/project_cvs_checkout
+$ git-cherry cvshead myhead | sed 's/^+ //p' | xargs -l1 git-cvsexportcommit -c -p -v
+------------
+
 Author
 ------
 Written by Martin Langhoff <martin@catalyst.net.nz>
-- 
1.1.6.g170f-dirty
