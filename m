From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH] documentation about exclude/ignore files
Date: Wed, 12 Jul 2006 21:54:51 +0200
Message-ID: <E1G0knL-0007PL-86@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Jul 12 21:55:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0knd-0007Ox-GZ
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 21:55:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWGLTyz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 15:54:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbWGLTyy
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 15:54:54 -0400
Received: from moooo.ath.cx ([85.116.203.178]:41395 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S932099AbWGLTyy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Jul 2006 15:54:54 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23797>

---
Use .git/info/exclude in the example in git-ls-files.txt as .gitignore
is used there and update the list of commands looking at
.git/info/exclude in repository-layout.txt.

---
 Documentation/git-ls-files.txt      |    4 ++--
 Documentation/repository-layout.txt |    8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 4d8a2ad..8520b97 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -207,7 +207,7 @@ An exclude pattern is of the following f
 An example:
 
 --------------------------------------------------------------
-    $ cat .git/ignore
+    $ cat .git/info/exclude
     # ignore objects and archives, anywhere in the tree.
     *.[oa]
     $ cat Documentation/.gitignore
@@ -217,7 +217,7 @@ An example:
     !foo.html
     $ git-ls-files --ignored \
         --exclude='Documentation/*.[0-9]' \
-        --exclude-from=.git/ignore \
+        --exclude-from=.git/info/exclude \
         --exclude-per-directory=.gitignore
 --------------------------------------------------------------
 
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index b52dfdc..275d18b 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -120,9 +120,11 @@ info/grafts::
 
 info/exclude::
 	This file, by convention among Porcelains, stores the
-	exclude pattern list.  `git status` looks at it, but
-	otherwise it is not looked at by any of the core git
-	commands.
+	exclude pattern list. `.gitignore` is the per-directory
+	ignore file.  `git status`, `git add`, `git rm` and `git
+	clean` look at it but the core git commands do not look
+	at it.  See also: gitlink:git-ls-files[1] `--exclude-from`
+	and `--exclude-per-directory`.
 
 remotes::
 	Stores shorthands to be used to give URL and default
-- 
1.4.1.gb16f
