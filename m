From: pbaker <pbaker@retrodict.com>
Subject: [PATCH 1/2] Clarify the gitmodules and submodules docs
Date: Wed,  8 Apr 2009 11:33:52 -0400
Message-ID: <1239204833-39795-1-git-send-email-pbaker@retrodict.com>
Cc: pbaker <pbaker@retrodict.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 17:43:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrZvz-0007yR-MC
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 17:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760832AbZDHPlZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 11:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752939AbZDHPlY
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 11:41:24 -0400
Received: from hnt021.wlan.wharton.upenn.edu ([128.91.126.22]:54844 "EHLO
	hnt021.wlan.wharton.upenn.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757026AbZDHPlX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Apr 2009 11:41:23 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Apr 2009 11:41:23 EDT
Received: by hnt021.wlan.wharton.upenn.edu (Postfix, from userid 501)
	id 7182A3A9C2A; Wed,  8 Apr 2009 11:34:01 -0400 (EDT)
X-Mailer: git-send-email 1.6.2.1.316.gedbc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116086>

Added some explanation to the docs to clear up some confusing parts of git-submodules that appeared frequently on the mailing list.

Signed-off-by: pbaker <pbaker@retrodict.com>
---

As I dug into the reasoning and structure of git-submodule as part of GSoC preparation, I also ran across frequently asked questions on the mailing list. From this background, I added some explanation to the docs to  clear up some confusing parts of git-submodules.

- pbaker

Documentation/git-submodule.txt |    9 ++++++---
 Documentation/gitmodules.txt    |    8 +++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 3b8df44..1ca8184 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -50,9 +50,12 @@ This command will manage the tree entries and contents of the
 gitmodules file for you, as well as inspect the status of your
 submodules and update them.
 When adding a new submodule to the tree, the 'add' subcommand
-is to be used.  However, when pulling a tree containing submodules,
-these will not be checked out by default;
-the 'init' and 'update' subcommands will maintain submodules
+is to be used. This creates a record in the gitmodules file for each
+submodule. When the file is committed and pulled by others it serves as an
+in-tree reference for where to obtain the submodule.
+
+When pulling a tree containing submodules, these will not be checked out by
+default; the 'init' and 'update' subcommands will maintain submodules
 checked out and at appropriate revision in your working tree.
 You can briefly inspect the up-to-date status of your submodules
 using the 'status' subcommand and get a detailed overview of the
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index d1a17e2..8f03310 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -15,7 +15,13 @@ DESCRIPTION
 
 The `.gitmodules` file, located in the top-level directory of a git
 working tree, is a text file with a syntax matching the requirements
-of linkgit:git-config[1].
+of linkgit:git-config[1]. As this file is managed by Git, it tracks the
+records of a project's submodules. Information stored in this file is used
+as a hint to prime the authoritative version of the record stored in the
+project configuration file. User specific record changes (e.g. to account
+for differences in submodule URLs due to networking situations) should be
+made to the configuration file, while record changes to be propagated (e.g.
+due to a relocation of the submodule source) should be made to this file.
 
 The file contains one subsection per submodule, and the subsection value
 is the name of the submodule. Each submodule section also contains the
-- 
1.6.2.1.316.gedbc2
