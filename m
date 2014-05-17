From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 10/10] Documentation: replace: describe new --edit option
Date: Sat, 17 May 2014 14:16:39 +0200
Message-ID: <20140517121640.27582.23357.chriscool@tuxfamily.org>
References: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 17 17:57:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wlgzi-0001TK-88
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 17:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbaEQP5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 11:57:46 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:54523 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932424AbaEQP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2014 11:57:41 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 5F8D554;
	Sat, 17 May 2014 17:57:40 +0200 (CEST)
X-git-sha1: 8cef441c7bfeb37665460deeb3fa1f35ec2759b6 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140517120649.27582.58609.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249476>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-replace.txt | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index 0a02f70..61461b9 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git replace' [-f] <object> <replacement>
+'git replace' [-f] --edit <object>
 'git replace' -d <object>...
 'git replace' [--format=<format>] [-l [<pattern>]]
 
@@ -63,6 +64,15 @@ OPTIONS
 --delete::
 	Delete existing replace refs for the given objects.
 
+--edit <object>::
+	Edit an object's content interactively. The existing content
+	for <object> is pretty-printed into a temporary file, an
+	editor is launched on the file, and the result is parsed to
+	create a new object of the same type as <object>. A
+	replacement ref is then created to replace <object> with the
+	newly created object. See linkgit:git-var[1] for details about
+	how the editor will be chosen.
+
 -l <pattern>::
 --list <pattern>::
 	List replace refs for objects that match the given pattern (or
@@ -92,7 +102,9 @@ CREATING REPLACEMENT OBJECTS
 
 linkgit:git-filter-branch[1], linkgit:git-hash-object[1] and
 linkgit:git-rebase[1], among other git commands, can be used to create
-replacement objects from existing objects.
+replacement objects from existing objects. The `--edit` option can
+also be used with 'git replace' to create a replacement object by
+editing an existing object.
 
 If you want to replace many blobs, trees or commits that are part of a
 string of commits, you may just want to create a replacement string of
@@ -117,6 +129,8 @@ linkgit:git-filter-branch[1]
 linkgit:git-rebase[1]
 linkgit:git-tag[1]
 linkgit:git-branch[1]
+linkgit:git-commit[1]
+linkgit:git-var[1]
 linkgit:git[1]
 
 GIT
-- 
1.9.rc0.17.g651113e
