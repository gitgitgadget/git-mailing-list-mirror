From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 3/7] use 'tree-ish' instead of 'treeish'
Date: Wed,  4 Sep 2013 15:04:30 -0400
Message-ID: <1378321474-7125-4-git-send-email-rhansen@bbn.com>
References: <xmqq1u55plqe.fsf@gitster.dls.corp.google.com>
 <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Cc: Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 04 21:05:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHIO4-0002I5-0e
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 21:05:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932641Ab3IDTE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 15:04:57 -0400
Received: from smtp.bbn.com ([128.33.0.80]:45786 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759718Ab3IDTE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 15:04:56 -0400
Received: from socket.bbn.com ([192.1.120.102]:55420)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VHINs-0008ac-44; Wed, 04 Sep 2013 15:04:56 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id DDFD14004A
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1378321474-7125-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233858>

Replace 'treeish' in documentation and comments with 'tree-ish' to
match gitglossary(7).

The only remaining instances of 'treeish' are:
  * variable, function, and macro names
  * "(also treeish)" in the definition of tree-ish in gitglossary(7)

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 Documentation/RelNotes/1.7.11.2.txt | 2 +-
 Documentation/git-cat-file.txt      | 2 +-
 Documentation/git-merge-tree.txt    | 2 +-
 fast-import.c                       | 4 ++--
 git-cvsserver.perl                  | 2 +-
 test-match-trees.c                  | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/RelNotes/1.7.11.2.txt b/Documentation/RelNotes/1.7.11.2.txt
index a0d24d1..f0cfd02 100644
--- a/Documentation/RelNotes/1.7.11.2.txt
+++ b/Documentation/RelNotes/1.7.11.2.txt
@@ -31,7 +31,7 @@ Fixes since v1.7.11.1
  * "git diff --no-index" did not work with pagers correctly.
 
  * "git diff COPYING HEAD:COPYING" gave a nonsense error message that
-   claimed that the treeish HEAD did not have COPYING in it.
+   claimed that the tree-ish HEAD did not have COPYING in it.
 
  * When "git log" gets "--simplify-merges/by-decoration" together with
    "--first-parent", the combination of these options makes the
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 10fbc6a..e468ceb 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -54,7 +54,7 @@ OPTIONS
 
 --textconv::
 	Show the content as transformed by a textconv filter. In this case,
-	<object> has be of the form <treeish>:<path>, or :<path> in order
+	<object> has be of the form <tree-ish>:<path>, or :<path> in order
 	to apply the filter to the content recorded in the index at <path>.
 
 --batch::
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index c5f84b6..58731c1 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Reads three treeish, and output trivial merge results and
+Reads three tree-ish, and output trivial merge results and
 conflicting stages to the standard output.  This is similar to
 what three-way 'git read-tree -m' does, but instead of storing the
 results in the index, the command outputs the entries to the
diff --git a/fast-import.c b/fast-import.c
index 23f625f..019be11 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2957,7 +2957,7 @@ static struct object_entry *dereference(struct object_entry *oe,
 	case OBJ_TAG:
 		break;
 	default:
-		die("Not a treeish: %s", command_buf.buf);
+		die("Not a tree-ish: %s", command_buf.buf);
 	}
 
 	if (oe->pack_id != MAX_PACK_ID) {	/* in a pack being written */
@@ -3041,7 +3041,7 @@ static void parse_ls(struct branch *b)
 	struct tree_entry *root = NULL;
 	struct tree_entry leaf = {NULL};
 
-	/* ls SP (<treeish> SP)? <path> */
+	/* ls SP (<tree-ish> SP)? <path> */
 	p = command_buf.buf + strlen("ls ");
 	if (*p == '"') {
 		if (!b)
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index a0d796e..a9f6f8e 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -4338,7 +4338,7 @@ sub getAnyHead
 =head2 getRevisionDirMap
 
 A "revision dir map" contains all the plain-file filenames associated
-with a particular revision (treeish), organized by directory:
+with a particular revision (tree-ish), organized by directory:
 
   $type = $out->{$dir}{$fullName}
 
diff --git a/test-match-trees.c b/test-match-trees.c
index a3c4688..2ef725e 100644
--- a/test-match-trees.c
+++ b/test-match-trees.c
@@ -12,10 +12,10 @@ int main(int ac, char **av)
 		die("cannot parse %s as an object name", av[2]);
 	one = parse_tree_indirect(hash1);
 	if (!one)
-		die("not a treeish %s", av[1]);
+		die("not a tree-ish %s", av[1]);
 	two = parse_tree_indirect(hash2);
 	if (!two)
-		die("not a treeish %s", av[2]);
+		die("not a tree-ish %s", av[2]);
 
 	shift_tree(one->object.sha1, two->object.sha1, shifted, -1);
 	printf("shifted: %s\n", sha1_to_hex(shifted));
-- 
1.8.4
