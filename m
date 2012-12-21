From: Greg Troxel <gdt@ir.bbn.com>
Subject: [PATCH] Documentation/git-update-index: caution about tree objects
Date: Thu, 20 Dec 2012 20:35:38 -0500
Message-ID: <1356053738-14926-1-git-send-email-gdt@ir.bbn.com>
Cc: Greg Troxel <gdt@ir.bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 02:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlrWt-0003u3-Qz
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 02:36:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741Ab2LUBfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 20:35:46 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:53806 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751634Ab2LUBfp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 20:35:45 -0500
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 8F75BBCF7; Thu, 20 Dec 2012 20:35:44 -0500 (EST)
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211939>

While one can add tree objects to the index, this is not currently
useful.  Therefore, use "git ls-tree -r" as the example to be fed to
--index-info.  Add a section explaining about expected index contents.
(Thanks to Junio for explaining this to me in August of 2011.)

Signed-off-by: Greg Troxel <gdt@ir.bbn.com>
---
 Documentation/git-update-index.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 9d0b151..6ce65fa 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -29,6 +29,11 @@ Modifies the index or directory cache. Each file mentioned is updated
 into the index and any 'unmerged' or 'needs updating' state is
 cleared.
 
+Note that update-index does not check that the modifications preserve
+the expected invariants.  In particular, an index normally holds
+regular blobs, executable blobs, symlink blobs, and gitlinks.
+Therefore, adding a tree object is not likely useful.
+
 See also linkgit:git-add[1] for a more user-friendly way to do some of
 the most common operations on the index.
 
@@ -210,7 +215,7 @@ back on 3-way merge.
 
     . mode SP type SP sha1          TAB path
 +
-The second format is to stuff 'git ls-tree' output
+The second format is to stuff 'git ls-tree -r' output
 into the index file.
 
     . mode         SP sha1 SP stage TAB path
-- 
1.8.0.1
