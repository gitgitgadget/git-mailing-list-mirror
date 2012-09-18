From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCHv2 1/8] Doc: Bundle file usage
Date: Wed, 19 Sep 2012 00:25:27 +0100
Message-ID: <1348010734-664-2-git-send-email-philipoakley@iee.org>
To: gitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7A2-0005Bj-T5
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:24:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289Ab2IRXYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:24:47 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:37430 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751833Ab2IRXYp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Sep 2012 19:24:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgUFAMwBWVBZ8rU+/2dsb2JhbABFhSC3IYEJgn07gQIkE4gEmQmhTpILA6YEgmc
X-IronPort-AV: E=Sophos;i="4.80,445,1344207600"; 
   d="scan'208";a="403726895"
Received: from host-89-242-181-62.as13285.net (HELO localhost) ([89.242.181.62])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 19 Sep 2012 00:24:44 +0100
X-Mailer: git-send-email 1.7.8.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205887>

Git URLs can accept bundle files for fetch, pull and clone, include
in that section. Include git clone in the bundle usage description.
Correct the quoting of <git-rev-list-args>.
Detail the <git-rev-list-args> '--all' option for cloning.

Signed-off-by: Philip Oakley <philipoakley@iee.org>

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 16a6b0a..be6a5f1 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -21,12 +21,12 @@ Some workflows require that one or more branches of development on one
 machine be replicated on another machine, but the two machines cannot
 be directly connected, and therefore the interactive git protocols (git,
 ssh, rsync, http) cannot be used.  This command provides support for
-'git fetch' and 'git pull' to operate by packaging objects and references
-in an archive at the originating machine, then importing those into
-another repository using 'git fetch' and 'git pull'
-after moving the archive by some means (e.g., by sneakernet).  As no
-direct connection between the repositories exists, the user must specify a
-basis for the bundle that is held by the destination repository: the
+'git fetch', 'git pull' and 'git clone', to operate by packaging
+objects and references in an archive at the originating machine, then
+importing those into another repository using 'git fetch', 'git pull',
+or 'git clone', after moving the archive by some means (e.g., by sneakernet).
+As no direct connection between the repositories exists, the user must
+specify a basis for the bundle that is held by the destination repository: the
 bundle assumes that all objects in the basis are already in the
 destination repository.
 
@@ -35,7 +35,7 @@ OPTIONS
 
 create <file>::
 	Used to create a bundle named 'file'.  This requires the
-	'git-rev-list-args' arguments to define the bundle contents.
+	<git-rev-list-args> arguments to define the bundle contents.
 
 verify <file>::
 	Used to check that a bundle file is valid and will apply
@@ -92,6 +92,8 @@ It is okay to err on the side of caution, causing the bundle file
 to contain objects already in the destination, as these are ignored
 when unpacking at the destination.
 
+To create a bundle for 'git clone', use `--all` for the <git-rev-list-args>.
+
 EXAMPLE
 -------
 
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 2890194..2d75cce 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -42,6 +42,9 @@ These two syntaxes are mostly equivalent, except the former implies
 --local option.
 endif::git-clone[]
 
+'git clone', 'git fetch' and 'git pull', but not 'git push', will also
+accept a suitable bundle file. See linkgit:git-bundle[1].
+
 When git doesn't know how to handle a certain transport protocol, it
 attempts to use the 'remote-<transport>' remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
-- 
1.7.8.msysgit.0
