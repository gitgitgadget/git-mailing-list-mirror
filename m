From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Document the default source of template files.
Date: Fri, 17 Mar 2006 18:24:49 -0600
Message-ID: <E1FKPFR-00061z-Jh@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 18 01:25:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKPFs-0006gf-Sk
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 01:25:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWCRAZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 19:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbWCRAZK
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 19:25:10 -0500
Received: from www.jdl.com ([66.118.10.122]:15757 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S932167AbWCRAZI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Mar 2006 19:25:08 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FKPFR-00061z-Jh
	for git@vger.kernel.org; Fri, 17 Mar 2006 18:24:50 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17676>


Also explain a bit more about how the template option works.

Signed-off-by: Jon Loeliger <jdl@jdl.com>


---

 Documentation/git-init-db.txt |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

d86b69902d855748ff636d2debbf9524c6f09c04
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index ea4d849..aeb1115 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 OPTIONS
 -------
 --template=<template_directory>::
-	Provide the directory in from which templates will be used.
+	Provide the directory from which templates will be used.
+	The default template directory is `/usr/share/git-core/templates`.
 
 --shared::
 	Specify that the git repository is to be shared amongst several users.
@@ -22,9 +23,17 @@ OPTIONS
 
 DESCRIPTION
 -----------
-This simply creates an empty git repository - basically a `.git` directory
-and `.git/object/??/`, `.git/refs/heads` and `.git/refs/tags` directories,
-and links `.git/HEAD` symbolically to `.git/refs/heads/master`.
+This command creates an empty git repository - basically a `.git` directory
+with subdirectories for `objects`, `refs/heads`, `refs/tags`, and
+templated files.
+An initial `HEAD` file that references the HEAD of the master branch
+is also created.
+
+If `--template=<template_directory>` is specified, `<template_directory>`
+is used as the source of the template files rather than the default.
+The template files include some directory structure, some suggested
+"exclude patterns", and copies of non-executing "hook" files.  The
+suggested patterns and hook files are all modifiable and extensible.
 
 If the `$GIT_DIR` environment variable is set then it specifies a path
 to use instead of `./.git` for the base of the repository.
@@ -38,7 +47,6 @@ repository. When specifying `--shared` t
 is set to 'true' so that directories under `$GIT_DIR` are made group writable
 (and g+sx, since the git group may be not the primary group of all users).
 
-
 Running `git-init-db` in an existing repository is safe. It will not overwrite
 things that are already there. The primary reason for rerunning `git-init-db`
 is to pick up newly added templates.
-- 
1.2.4.gdd7be
