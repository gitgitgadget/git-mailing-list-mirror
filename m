From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] Documentation: read-tree --prefix works with existing
 subtrees
Date: Sat, 31 Dec 2011 12:50:56 +0100
Message-ID: <20111231115056.GA11628@ecki.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 31 13:19:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rgxuc-0006uW-DP
	for gcvg-git-2@lo.gmane.org; Sat, 31 Dec 2011 13:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947Ab1LaMTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Dec 2011 07:19:41 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:27119 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752938Ab1LaMTj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Dec 2011 07:19:39 -0500
X-Greylist: delayed 1229 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Dec 2011 07:19:39 EST
Received: from bsmtp.bon.at (unknown [192.168.181.107])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 5295ACE2CE
	for <git@vger.kernel.org>; Sat, 31 Dec 2011 13:00:18 +0100 (CET)
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 62C4A130045;
	Sat, 31 Dec 2011 12:57:46 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187812>


Since 34110cd4 (Make 'unpack_trees()' have a separate source and
destination index) it is no longer true that a subdirectory with
the same prefix must not exist.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 Documentation/git-read-tree.txt |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 5375549..a43e874 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -83,11 +83,10 @@ OPTIONS
 
 --prefix=<prefix>/::
 	Keep the current index contents, and read the contents
-	of the named tree-ish under the directory at `<prefix>`. The
-	original index file cannot have anything at the path
-	`<prefix>` itself, nor anything in the `<prefix>/`
-	directory.  Note that the `<prefix>/` value must end
-	with a slash.
+	of the named tree-ish under the directory at `<prefix>`.
+	The command will refuse to overwrite entries that already
+	existed in the original index file. Note that the `<prefix>/`
+	value must end with a slash.
 
 --exclude-per-directory=<gitignore>::
 	When running the command with `-u` and `-m` options, the
-- 
1.7.8
