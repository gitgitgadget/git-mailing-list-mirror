From: Michael Smith <msmith@cbnco.com>
Subject: [PATCH] user-manual: Explain what submodules are good for.
Date: Sun, 23 Sep 2007 23:14:09 -0400
Message-ID: <11906036491118-git-send-email-msmith@cbnco.com>
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Michael Smith <msmith@cbnco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 24 05:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZeVG-0007xC-70
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 05:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276AbXIXDUv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 23:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbXIXDUv
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 23:20:51 -0400
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:45561 "HELO
	smtp107.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754115AbXIXDUu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Sep 2007 23:20:50 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2007 23:20:50 EDT
Received: (qmail 17114 invoked from network); 24 Sep 2007 03:14:10 -0000
Received: from unknown (HELO pentagram.it.hurts.ca) (mtsmith@rogers.com@74.122.211.221 with login)
  by smtp107.rog.mail.re2.yahoo.com with SMTP; 24 Sep 2007 03:14:10 -0000
X-YMail-OSG: wk0VtsgVM1mFzsXhVKP3g2TP7BYSUIPQXmrSVZBODNZ2GwzxI2eqwPavoaGILGgnXg--
Received: from localhost.localdomain (thrush.it.hurts.ca [10.42.42.42])
	by pentagram.it.hurts.ca (Postfix) with ESMTP id 832121AE02D;
	Sun, 23 Sep 2007 23:14:09 -0400 (EDT)
X-Mailer: git-send-email 1.5.3
In-Reply-To: 20070923172702.GA5916@fieldses.org
References: 20070923172702.GA5916@fieldses.org
In-Reply-To: <20070923172702.GA5916@fieldses.org>
References: <20070923172702.GA5916@fieldses.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59016>

Rework the introduction to the Submodules section to explain why
someone would use them, and fix up submodule references from the
tree-object and todo sections.

Signed-off-by: Michael Smith <msmith@cbnco.com>
---
 Documentation/user-manual.txt |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index a085ca1..bd77e62 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2856,8 +2856,7 @@ between two related tree objects, since it can ignore any entries with
 identical object names.
 
 (Note: in the presence of submodules, trees may also have commits as
-entries.   See gitlink:git-submodule[1] and gitlink:gitmodules.txt[1]
-for partial documentation.)
+entries.  See <<submodules>> for documentation.)
 
 Note that the files all have mode 644 or 755: git actually only pays
 attention to the executable bit.
@@ -3163,12 +3162,18 @@ information as long as you have the name of the tree that it described.
 Submodules
 ==========
 
-This tutorial explains how to create and publish a repository with submodules
-using the gitlink:git-submodule[1] command.
+Some large projects are composed of smaller, self-contained parts.  For
+example, an embedded Linux distribution's source tree would include every
+piece of software in the distribution; a movie player might need to build
+against a specific, known-working version of a decompression library;
+several independent programs might all share the same build scripts.
 
-Submodules maintain their own identity; the submodule support just stores the
-submodule repository location and commit ID, so other developers who clone the
-superproject can easily clone all the submodules at the same revision.
+Git's submodule support allows a repository to contain, as a subdirectory, a
+checkout of an external project.  Submodules maintain their own identity;
+the submodule support just stores the submodule repository location and
+commit ID, so other developers who clone the superproject can easily clone
+all the submodules at the same revision.  The gitlink:git-submodule[1]
+command manages submodules.
 
 To see how submodule support works, create (for example) four example
 repositories that can be used later as a submodule:
@@ -3213,8 +3218,8 @@ The `git submodule add` command does a couple of things:
 
 - It clones the submodule under the current directory and by default checks out
   the master branch.
-- It adds the submodule's clone path to the `.gitmodules` file and adds this
-  file to the index, ready to be committed.
+- It adds the submodule's clone path to the gitlink:gitmodules[5] file and
+  adds this file to the index, ready to be committed.
 - It adds the submodule's current commit ID to the index, ready to be
   committed.
 
@@ -4277,5 +4282,3 @@ Write a chapter on using plumbing and writing scripts.
 Alternates, clone -reference, etc.
 
 git unpack-objects -r for recovery
-
-submodules
-- 
1.5.3
