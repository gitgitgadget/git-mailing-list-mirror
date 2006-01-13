From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] stgit: make tutorial a valid asciidoc article
Date: Fri, 13 Jan 2006 03:54:46 -0500
Message-ID: <1137142486.20073.77.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 13 09:54:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExKhx-0001B7-US
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 09:54:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWAMIyv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 03:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWAMIyv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 03:54:51 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:11691 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1030299AbWAMIyu
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 03:54:50 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1ExKfY-0000Az-1X
	for git@vger.kernel.org; Fri, 13 Jan 2006 03:52:24 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1ExKhq-00014k-H8; Fri, 13 Jan 2006 03:54:46 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>,
	git <git@vger.kernel.org>
X-Mailer: Evolution 2.5.4 (2.5.4-2) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14620>

There should be only one level 0 title in an article, so lower ranks of
all headers by one.  Make capitalization uniform in the headers - level
1 is capitalized, but level 2 is not.  Create a new level 1 part
"Technical Information".

Make ".git/ Directory Structure" a level 2 header and rephrase.
asciidoc doesn't like headers starting with a dot.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 doc/tutorial.txt |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/doc/tutorial.txt b/doc/tutorial.txt
index 7183e41..eae26f4 100644
--- a/doc/tutorial.txt
+++ b/doc/tutorial.txt
@@ -16,10 +16,10 @@ information on GIT, see the GIT_tutorial
 
 
 Basic Operation
-===============
+---------------
 
 Help
-----
+~~~~
 
 For a full list of StGIT commands:
 
@@ -31,7 +31,7 @@ For help on individual subcommands:
 
 
 Repository initialisation
--------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~
 
 In stand-alone mode, StGIT is used in conjunction with a GIT repository
 that is already initialised (using 'git-init-db'). StGIT cannot be used
@@ -59,7 +59,7 @@ will automatically prepare them for use 
 
 
 Working with remote repositories
---------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 With a single command, StGIT can create and initialize a GIT repository
 which mirrors a remote GIT repository. This is known as cloning. All GIT
@@ -97,7 +97,7 @@ separated into its own branch to make it
 just your patches.
 
 Getting started: creating a patch
----------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Changes to your working directory are saved in a patch. An StGIT patch
 is simply a saved set of modifications to your working directory, plus a
@@ -140,7 +140,7 @@ commands:
 
 
 Stack manipulation: managing multiple patches
----------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 StGIT can manage more than one patch at a time. A series of StGIT
 patches in a GIT branch are known collectively as a stack. The new patch
@@ -200,7 +200,7 @@ you want to permanently store the applie
 them with StGIT.
 
 Converting between StGIT patches and text diffs
------------------------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 As mentioned in the introduction, StGIT stores modifications to your
 working tree in the form of GIT commits. This means if you want to apply
@@ -270,10 +270,10 @@ the bottom of the topmost one and perfor
 
 
 Advanced Usage
-==============
+--------------
 
 Handling merge conflicts
-------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~
 
 Pushing a patch on the stack can fail if the patch cannot be applied
 cleanly. This usually happens if there are overlapping changes in the
@@ -293,7 +293,7 @@ resolve the conflict.
 
 
 Configuration file
-------------------
+~~~~~~~~~~~~~~~~~~
 
 StGIT tries to read the configuration options from the following files:
 /etc/stgitrc, ~/.stgitrc and .git/stgitrc. The latter overrides the
@@ -307,7 +307,7 @@ specify a smarter tool to be used.
 
 
 Templates
----------
+~~~~~~~~~
 
 The 'export' and 'mail' commands use templates for generating the patch
 files or e-mails. The default templates are installed under <prefix>/
@@ -324,7 +324,7 @@ lines.
 
 
 Merging two patches into one
-----------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 There is no command to do this directly at the moment but one can export
 the patch to be merged and use the 'stg fold' command on the generated
@@ -334,8 +334,11 @@ result in an empty patch (StGIT notifyin
 deleted.
 
 
-A Bit of StGIT Patch Theory
-===========================
+Technical Information
+---------------------
+
+A bit of StGIT patch theory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 We assume that a patch is a diff between two nodes - bottom and top. A
 node is a commit SHA1 id or tree SHA1 id in the GIT terminology:
@@ -374,8 +377,9 @@ The above operation allows easy patch re
 Removing (popping) a patch from the stack is done by simply setting the
 Nst to Nb.
 
-.git/ Directory Structure
 
+Layout of the .git directory
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
   HEAD			-> refs/heads/<something>
   objects/


-- 
Regards,
Pavel Roskin
