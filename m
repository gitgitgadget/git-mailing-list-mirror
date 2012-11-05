From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: [PATCH] Clarify how content states are to be built as the
 fast-import stream is interpreted.
Date: Sun, 4 Nov 2012 23:31:01 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121105043101.GA24687@thyrsus.com>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 05:33:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVENX-0004Q6-U2
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 05:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677Ab2KEEbR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 23:31:17 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:49269
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab2KEEbR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 23:31:17 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id DD7394065B; Sun,  4 Nov 2012 23:31:01 -0500 (EST)
Content-Disposition: inline
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209051>


---
 Documentation/git-fast-import.txt |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 6603a7a..959e4d3 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -442,7 +442,9 @@ their syntax.
 ^^^^^^
 The `from` command is used to specify the commit to initialize
 this branch from.  This revision will be the first ancestor of the
-new commit.
+new commit.  The state of the tree built at this commit will begin
+with the state at the `from` commit, and be altered by the content
+modifications in this commit.
 
 Omitting the `from` command in the first commit of a new branch
 will cause fast-import to create that commit with no ancestor. This
@@ -492,7 +494,9 @@ existing value of the branch.
 
 `merge`
 ^^^^^^^
-Includes one additional ancestor commit.  If the `from` command is
+Includes one additional ancestor commit.  The additional ancestry
+link does not change the way the tree state is built at this commit.
+If the `from` command is
 omitted when creating a new branch, the first `merge` commit will be
 the first ancestor of the current commit, and the branch will start
 out with no files.  An unlimited number of `merge` commands per
-- 
1.7.9.5


-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
