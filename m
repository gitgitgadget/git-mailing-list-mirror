From: Steven Drake <sdrake@xnet.co.nz>
Subject: [PATCH 2/2] Add a "TEMPLATE DIRECTORY" section to git-init[1].
Date: Wed, 13 Jan 2010 17:19:45 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1001131719390.22639@vqena.qenxr.bet.am>
References: <04b754c8823368ec1459c16f4aa8890cc0de0204.1263356312.git.sdrake@xnet.co.nz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 13 05:28:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUuqS-0006K2-IH
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 05:28:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273Ab0AME0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 23:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243Ab0AME0M
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 23:26:12 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:34519 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751560Ab0AME0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 23:26:10 -0500
Received: from idran.drake.org.nz (ip-118-90-54-75.xdsl.xnet.co.nz [118.90.54.75])
	by ananke.wxnz.net (Postfix) with ESMTP id 6356D170FDE
	for <git@vger.kernel.org>; Wed, 13 Jan 2010 17:26:06 +1300 (NZDT)
In-Reply-To: <04b754c8823368ec1459c16f4aa8890cc0de0204.1263356312.git.sdrake@xnet.co.nz>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136767>

Add references to it in config.txt and git-clone[1].

Signed-off-by: Steven Drake <sdrake@xnet.co.nz>
---
 Documentation/config.txt    |    4 ++++
 Documentation/git-clone.txt |    3 +--
 Documentation/git-init.txt  |   29 +++++++++++++++++++++--------
 3 files changed, 26 insertions(+), 10 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index dd261cf..b0369c4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1178,6 +1178,10 @@ imap::
 	The configuration variables in the 'imap' section are described
 	in linkgit:git-imap-send[1].
 
+init-db.templatedir::
+	Specify the directory from which templates will be copied.
+	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+
 instaweb.browser::
 	Specify the program that will be used to browse your working
 	repository in gitweb. See linkgit:git-instaweb[1].
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 7ccd742..731b57e 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -143,8 +143,7 @@ objects from the source repository into a pack in the cloned repository.
 
 --template=<template_directory>::
 	Specify the directory from which templates will be used;
-	if unset the templates are taken from the installation
-	defined default, typically `/usr/share/git-core/templates`.
+	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
 
 --depth <depth>::
 	Create a 'shallow' clone with a history truncated to the
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index f081b24..86b5766 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -28,14 +28,8 @@ current working directory.
 
 --template=<template_directory>::
 
-Provide the directory from which templates will be used.  The default template
-directory is `/usr/share/git-core/templates`.
-
-When specified, `<template_directory>` is used as the source of the template
-files rather than the default.  The template files include some directory
-structure, some suggested "exclude patterns", and copies of non-executing
-"hook" files.  The suggested patterns and hook files are all modifiable and
-extensible.
+Specify the directory from which templates will be used.  (See the "TEMPLATE
+DIRECTORY" section below.)
 
 --shared[={false|true|umask|group|all|world|everybody|0xxx}]::
 
@@ -106,6 +100,25 @@ of the repository, such as installing the default hooks and
 setting the configuration variables.  The old name is retained
 for backward compatibility reasons.
 
+TEMPLATE DIRECTORY
+------------------
+
+The template directory contains files and directories that will be copied to
+the `$GIT_DIR` after it is created.
+
+The template directory used will (in order of preference):
+
+ - The argument given with the `--template` option.
+
+ - The contents of the `$GIT_TEMPLATE_DIR` environment variable.
+
+ - The `init-db.templatedir` configuration variable.
+
+ - The default template directory: `/usr/share/git-core/templates`.
+
+The default template directory includes some directory structure, some
+suggested "exclude patterns", and copies of non-executing "hook" files.
+The suggested patterns and hook files are all modifiable and extensible.
 
 EXAMPLES
 --------
-- 
1.6.4
