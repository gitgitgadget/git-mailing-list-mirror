From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 5/7] glossary: more precise definition of tree-ish (a.k.a. treeish)
Date: Wed,  4 Sep 2013 15:04:32 -0400
Message-ID: <1378321474-7125-6-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIOL-0002Qc-El
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673Ab3IDTFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:05:19 -0400
Received: from smtp.bbn.com ([128.33.1.81]:36596 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932654Ab3IDTFR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:05:17 -0400
Received: from socket.bbn.com ([192.1.120.102]:59580)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHINz-00033n-RB; Wed, 04 Sep 2013 15:05:04 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id A760C4004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233862>

A tree-ish isn't a ref.  Also, mention dereferencing, and that a
commit dereferences to a tree, to support gitrevisions(7) and
rev-parse's error messages.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/glossary-content.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 47e901e..3466ce9 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -499,9 +499,18 @@ should not be combined with other pathspec.
 	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
 
 [[def_tree-ish]]tree-ish (also treeish)::
-	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
-	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
-	object>> pointing to a tag or commit or tree object.
+	A <<def_tree_object,tree object>> or an <<def_object,object>>
+	that can be recursively dereferenced to a tree object.
+	Dereferencing a <<def_commit_object,commit object>> yields the
+	tree object corresponding to the <<def_revision,revision>>'s
+	top <<def_directory,directory>>.
+	The following are all tree-ishes:
+	a <<def_commit-ish,commit-ish>>,
+	a tree object,
+	a <<def_tag_object,tag object>> that points to a tree object,
+	a tag object that points to a tag object that points to a tree
+	object,
+	etc.
 
 [[def_unmerged_index]]unmerged index::
 	An <<def_index,index>> which contains unmerged
-- 
1.8.4
