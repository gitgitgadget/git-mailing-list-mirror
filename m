From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 3/3] Some clarifications to the main doc.
Date: Sat, 10 Mar 2007 00:18:48 +0100
Message-ID: <20070309231848.30705.65625.stgit@gandelf.nowhere.earth>
References: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 10 00:19:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPoMs-0008M9-5H
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 00:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767638AbXCIXTS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 18:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767641AbXCIXTR
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 18:19:17 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:44254 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767638AbXCIXTO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 18:19:14 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 087353927;
	Sat, 10 Mar 2007 00:19:13 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 7064C1F095;
	Sat, 10 Mar 2007 00:18:48 +0100 (CET)
In-Reply-To: <20070309231444.30705.72292.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41820>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/stg.txt |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 60a6f9c..7d92356 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -21,19 +21,33 @@ GIT. These operations are performed using GIT commands and the patches
 are stored as GIT commit objects, allowing easy merging of the StGIT
 patches into other repositories using standard GIT functionality.
 
+An StGIT stack is a GIT branch with additional information to help
+making changes to individual patches you already committed, rather
+than making changes by adding new commits.  It is thus a
+non-forwarding, or rewinding branch: the old head of the branch is
+often not reachable as one of the new head's ancestors.
+
 Typical uses of StGIT include:
 
 Tracking branch::
-	Maintaining modifications against a remote branch, possibly
-	with the intent of sending some patches upstream.  StGIT
-	assists in preparing and cleaning up patches until they are
-	acceptable upstream, as well as maintaining local patches not
-	meant to be sent upstream.
+	Tracking changes from a remote branch, while maintaining local
+	modifications against that branch, possibly with the intent of
+	sending some patches upstream.  StGIT assists in preparing and
+	cleaning up patches until they are acceptable upstream, as
+	well as maintaining local patches not meant to be sent
+	upstream.
++
+In such a setup, typically all commits on your branch are StGIT
+patches; the stack base is the branch point where your changes "fork"
+off their parent branch.
 
 Development branch::
 	Preparing and testing your commits before publishing them,
 	separating your features from unrelated bugfixes collected
 	while developping.
++
+In such a setup, not all commits on your branch need to be StGIT
+patches; there may be regular GIT commits below your stack base.
 
 OPTIONS
 -------
