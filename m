From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Documentation: describe git extended diff headers.
Date: Sun, 05 Jun 2005 14:39:49 -0700
Message-ID: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 23:37:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df2nJ-0005CM-My
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 23:36:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVFEVj7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVFEVj7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 17:39:59 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25082 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261606AbVFEVjv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2005 17:39:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050605213951.JOUB7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Jun 2005 17:39:51 -0400
To: torvalds@osdl.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The documentation failed to describe "diff --git" extended diff
headers, so add some.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Documentation/diff-format.txt |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -52,7 +52,7 @@ Generating patches with -p
 --------------------------
 
 When "git-diff-cache", "git-diff-tree", or "git-diff-files" are run
-with a '-p' option, they do not produce the output described above
+with a '-p' option, they do not produce the output described above;
 instead they produce a patch file.
 
 The patch generation can be customized at two levels.  This
@@ -98,3 +98,37 @@ temporary file --- it is removed when 'G
 
 For a path that is unmerged, 'GIT_EXTERNAL_DIFF' is called with 1
 parameter, <path>.
+
+
+Git specific extention to diff format
+-------------------------------------
+
+What -p option produces is slightly different from the
+traditional diff format.
+
+ (1) It is preceeded with a "git diff" header, that looks like
+     this:
+
+     diff --git a/file1 b/file2
+
+     The a/ and b/ filenames are the same unless rename/copy is
+     involved.  Especially, even for a creation or a deletion,
+     /dev/null is _not_ used in place of a/ or b/ filename.
+
+     When rename/copy is involved, file1 and file2 shows the
+     name of the source file of the rename/copy and the name of
+     the file that rename/copy produces, respectively.
+
+ (2) It is followed by extended header lines that are one or
+     more of:
+
+       old mode <mode>
+       new mode <mode>
+       deleted file mode <mode>
+       new file mode <mode>
+       copy from <path>
+       copy to <path>
+       rename from <path>
+       rename to <path>
+       similarity index <number>
+       dissimilarity index <number>
------------

