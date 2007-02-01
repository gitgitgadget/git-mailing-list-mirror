From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fixes to doc strings.
Date: Thu, 01 Feb 2007 23:28:28 +0100
Message-ID: <20070201222752.29383.56882.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkQq-0004JB-Iw
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbXBAW3Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbXBAW3Z
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:29:25 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:43782 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932578AbXBAW3Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:29:24 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 3F99354FE;
	Thu,  1 Feb 2007 23:29:23 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id BABA71F07F;
	Thu,  1 Feb 2007 23:28:28 +0100 (CET)
User-Agent: StGIT/0.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38419>


At least the docstring for "branch" is still very confusing, but
that's hard to fix.  We'll likely have to wait for the post-1.0
command-line redesign.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/commands/float.py    |    2 +-
 stgit/commands/init.py     |   11 ++++-------
 stgit/commands/uncommit.py |    2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 4da5f59..0e32f6b 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -24,7 +24,7 @@ from stgit.utils import *
 from stgit import stack, git
 
 help = 'push patches to the top, even if applied'
-usage = """%prog [options] [<patches> | <series>]
+usage = """%prog [<patches> | -s [<series>] ]
 
 Push a patch or a range of patches to the top even if applied. The
 necessary pop and push operations will be performed to accomplish
diff --git a/stgit/commands/init.py b/stgit/commands/init.py
index 0326f9a..df2235f 100644
--- a/stgit/commands/init.py
+++ b/stgit/commands/init.py
@@ -24,15 +24,12 @@ from stgit.utils import *
 from stgit import stack, git
 
 
-help = 'initialise the tree for use with StGIT'
+help = 'initialise the current branch for use with StGIT'
 usage = """%prog [options]
 
-Initialise a GIT repository to be used with StGIT. Note that the
-repository must be already initialised with git-init-db and the
-.git/HEAD link must point to a valid file in refs/heads/. For people
-switching between multiple branches in the same repository, the 'init'
-command has to be run on all the individual branches intended to be
-used with StGIT."""
+Initialise the current GIT branch to be used as an StGIT stack. Note
+that the you must already be in a GIT repository and .git/HEAD must
+point to a valid file in refs/heads/."""
 
 options = []
 
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 9798f19..0ee1585 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -25,7 +25,7 @@ from stgit.utils import *
 from stgit import stack, git
 
 help = 'turn regular GIT commits into StGIT patches'
-usage = """%prog [options] [<patchname1> [<patchname2> ... ]]
+usage = """%prog [<patchname1> [<patchname2> ... ] | -n [<prefix>]]
 
 Take one or more git commits at the base of the current stack and turn
 them into StGIT patches. The new patches are created as applied patches
