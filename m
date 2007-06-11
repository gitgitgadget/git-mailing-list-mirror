From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 5/5] Add gitmodules(5)
Date: Mon, 11 Jun 2007 21:12:25 +0200
Message-ID: <11815891463922-git-send-email-hjemli@gmail.com>
References: <11815891453464-git-send-email-hjemli@gmail.com>
 <11815891451258-git-send-email-hjemli@gmail.com>
 <1181589146478-git-send-email-hjemli@gmail.com>
 <1181589146685-git-send-email-hjemli@gmail.com>
 <1181589146188-git-send-email-hjemli@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 21:10:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxpHo-0007lx-OK
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 21:10:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbXFKTKZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 15:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbXFKTKZ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 15:10:25 -0400
Received: from mail49.e.nsc.no ([193.213.115.49]:41059 "EHLO mail49.e.nsc.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbXFKTKY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 15:10:24 -0400
Received: from localhost.localdomain (ti231210a341-2365.bb.online.no [85.166.53.63])
	by mail49.nsc.no (8.13.8/8.13.5) with ESMTP id l5BJ9pBU025419;
	Mon, 11 Jun 2007 21:09:52 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.1.914.gbd3a7
In-Reply-To: <1181589146188-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49874>

This adds documentation for the .gitmodules file.

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/Makefile       |    2 +-
 Documentation/gitmodules.txt |   62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/gitmodules.txt

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 9cef480..2ad18e0 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -2,7 +2,7 @@ MAN1_TXT= \
 	$(filter-out $(addsuffix .txt, $(ARTICLES) $(SP_ARTICLES)), \
 		$(wildcard git-*.txt)) \
 	gitk.txt
-MAN5_TXT=gitattributes.txt gitignore.txt
+MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt
 MAN7_TXT=git.txt
 
 DOC_HTML=$(patsubst %.txt,%.html,$(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT))
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
new file mode 100644
index 0000000..6c7d9bf
--- /dev/null
+++ b/Documentation/gitmodules.txt
@@ -0,0 +1,62 @@
+gitmodules(5)
+=============
+
+NAME
+----
+gitmodules - defining submodule properties
+
+SYNOPSIS
+--------
+.gitmodules
+
+
+DESCRIPTION
+-----------
+
+The `.gitmodules` file, located in the top-level directory of a git
+working tree, is a text file with a syntax matching the requirements
+of gitlink:git-config[1].
+
+The file contains one subsection per submodule, and the subsection value
+is the name of the submodule. Each submodule section also contains the
+following required keys:
+
+submodule.<name>.path::
+	Defines the path, relative to the top-level directory of the git
+	working tree, where the submodule is expected to be checked out.
+	The path name must not end with a `/`. All submodule paths must
+	be unique within the .gitmodules file.
+
+submodule.<name>.url::
+	Defines an url from where the submodule repository can be cloned.
+
+
+EXAMPLES
+--------
+
+Consider the following .gitmodules file:
+
+	[submodule 'libfoo']
+		path = include/foo
+		url = git://foo.com/git/lib.git
+
+	[submodule 'libbar']
+		path = include/bar
+		url = git://bar.com/git/lib.git
+
+
+This defines two submodules, `libfoo` and `libbar`. These are expected to
+be checked out in the paths 'include/foo' and 'include/bar', and for both
+submodules an url is specified which can be used for cloning the submodules.
+
+SEE ALSO
+--------
+gitlink:git-submodule[1] gitlink:git-config[1]
+
+DOCUMENTATION
+-------------
+Documentation by Lars Hjemli <hjemli@gmail.com>
+
+GIT
+---
+Part of the gitlink:git[7] suite
-- 
1.5.2.1.914.gbd3a7
