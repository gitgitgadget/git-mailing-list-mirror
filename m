From: Steven Grimm <koreth@midwinter.com>
Subject: [PATCH] Describe git-clone's actual behavior in the summary
Date: Fri, 05 Jan 2007 17:52:20 -0800
Message-ID: <459F00D4.3040203@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jan 06 02:52:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H30j2-0000cW-Bs
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 02:52:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbXAFBv4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 20:51:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751077AbXAFBv4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 20:51:56 -0500
Received: from tater.midwinter.com ([216.32.86.90]:57695 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751071AbXAFBvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 20:51:55 -0500
Received: (qmail 2634 invoked from network); 6 Jan 2007 01:51:55 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=oGGYPlIk9C8UfJvpJcq1oxXzDgGeTZKtXOReBcV4Cu6tkZLVsWSMYK/lyhAlUw0B  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 6 Jan 2007 01:51:55 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36068>

If a branch other than "master" is checked out in the origin repository,
git-clone makes a local copy of that branch rather than the origin's 
"master"
branch. This patch describes the actual behavior.

Signed-off-by: Steven Grimm <koreth@midwinter.com>
---
 Documentation/git-clone.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index e7085fd..a782074 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -18,13 +18,13 @@ DESCRIPTION
 
 Clones a repository into a newly created directory, creates
 remote-tracking branches for each branch in the cloned repository
-(visible using `git branch -r`), and creates and checks out a master
-branch equal to the cloned repository's master branch.
+(visible using `git branch -r`), and creates and checks out an initial
+branch equal to the cloned repository's currently active branch.
 
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
 arguments will in addition merge the remote master branch into the
-current branch.
+current master branch, if any.
 
 This default configuration is achieved by creating references to
 the remote branch heads under `$GIT_DIR/refs/remotes/origin` and
-- 
1.5.0.rc0.g244a7
