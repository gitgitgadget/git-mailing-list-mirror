From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 3/4] glossary: more precise definition of tree-ish (a.k.a. treeish)
Date: Tue, 18 Jun 2013 22:09:39 -0400
Message-ID: <1371607780-2966-4-git-send-email-rhansen@bbn.com>
References: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jun 19 04:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Up8Mu-0006fc-22
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 04:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934099Ab3FSCnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 22:43:24 -0400
Received: from smtp.bbn.com ([128.33.1.81]:36920 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933836Ab3FSCnX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 22:43:23 -0400
Received: from socket.bbn.com ([192.1.120.102]:39095)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Up7qT-000I84-6h; Tue, 18 Jun 2013 22:10:01 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id D69624090B
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1371607780-2966-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228328>

Mention dereferencing, and that a commit dereferences to a tree, to
support gitrevisions(7) and rev-parse's error messages.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index a3cc003..9a50fe1 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -498,9 +498,19 @@ should not be combined with other pathspec.
 	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
 
 [[def_tree-ish]]tree-ish (also treeish)::
-	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
-	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
-	object>> pointing to a tag or commit or tree object.
+	A <<def_ref,ref>> pointing to an <<def_object,object>> that
+	can be recursively dereferenced to a
+	<<def_tree_object,tree object>>.
+	Dereferencing a <<def_commit_object,commit object>> yields the
+	tree object corresponding to the <<def_revision,revision>>'s
+	top <<def_directory,directory>>.
+	The following are all tree-ishes:
+	a <<def_committish,committish>>,
+	a ref pointing to a tree object,
+	a ref pointing to a <<def_tag_object,tag object>> that points
+	to a tree object,
+	a ref pointing to a tag object that points to a tag object
+	that points to a tree object, etc.
 
 [[def_unmerged_index]]unmerged index::
 	An <<def_index,index>> which contains unmerged
-- 
1.8.3.1
