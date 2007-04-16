From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 6/7] user-manual: start revising "internals" chapter
Date: Mon, 16 Apr 2007 00:37:15 -0400
Message-ID: <31842.9091749296$1176698263@news.gmane.org>
References: <11766982362087-git-send-email->
 <11766982361830-git-send-email->
 <1176698236722-git-send-email->
 <11766982363767-git-send-email->
 <11766982363276-git-send-email->
 <11766982362066-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy4-0008Sb-VE
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487AbXDPEh3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754488AbXDPEh3
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:29 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36502 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754487AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxo-0005Yb-W7; Mon, 16 Apr 2007 00:37:17 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11766982362066-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44577>

From: J. Bruce Fields <bfields@citi.umich.edu>

Minor revisions, cross-references.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   38 ++++++++++++++++++++------------------
 1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index bff072f..c32aaef 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2315,8 +2315,8 @@ options mentioned above.
 Git internals
 =============
 
-There are two object abstractions: the "object database", and the
-"current directory cache" aka "index".
+Git depends on two fundamental abstractions: the "object database", and
+the "current directory cache" aka "index".
 
 The Object Database
 -------------------
@@ -2331,22 +2331,23 @@ All objects have a statically determined "type" aka "tag", which is
 determined at object creation time, and which identifies the format of
 the object (i.e. how it is used, and how it can refer to other
 objects).  There are currently four different object types: "blob",
-"tree", "commit" and "tag".
+"tree", "commit", and "tag".
 
-A "blob" object cannot refer to any other object, and is, like the type
-implies, a pure storage object containing some user data.  It is used to
-actually store the file data, i.e. a blob object is associated with some
-particular version of some file. 
+A <<def_blob_object,"blob" object>> cannot refer to any other object,
+and is, as the name implies, a pure storage object containing some
+user data.  It is used to actually store the file data, i.e. a blob
+object is associated with some particular version of some file. 
 
-A "tree" object is an object that ties one or more "blob" objects into a
-directory structure. In addition, a tree object can refer to other tree
-objects, thus creating a directory hierarchy. 
+A <<def_tree_object,"tree" object>> is an object that ties one or more
+"blob" objects into a directory structure. In addition, a tree object
+can refer to other tree objects, thus creating a directory hierarchy. 
 
-A "commit" object ties such directory hierarchies together into
-a DAG of revisions - each "commit" is associated with exactly one tree
-(the directory hierarchy at the time of the commit). In addition, a
-"commit" refers to one or more "parent" commit objects that describe the
-history of how we arrived at that directory hierarchy.
+A <<def_commit_object,"commit" object>> ties such directory hierarchies
+together into a <<def_DAG,directed acyclic graph>> of revisions - each
+"commit" is associated with exactly one tree (the directory hierarchy at
+the time of the commit). In addition, a "commit" refers to one or more
+"parent" commit objects that describe the history of how we arrived at
+that directory hierarchy.
 
 As a special case, a commit object with no parents is called the "root"
 object, and is the point of an initial project commit.  Each project
@@ -2356,9 +2357,10 @@ has two or more separate roots as its ultimate parents, that's probably
 just going to confuse people.  So aim for the notion of "one root object
 per project", even if git itself does not enforce that. 
 
-A "tag" object symbolically identifies and can be used to sign other
-objects. It contains the identifier and type of another object, a
-symbolic name (of course!) and, optionally, a signature.
+A <<def_tag_object,"tag" object>> symbolically identifies and can be
+used to sign other objects. It contains the identifier and type of
+another object, a symbolic name (of course!) and, optionally, a
+signature.
 
 Regardless of object type, all objects share the following
 characteristics: they are all deflated with zlib, and have a header
-- 
1.5.1.1.98.gedb4f
