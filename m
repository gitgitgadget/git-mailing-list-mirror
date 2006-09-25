From: Shawn Pearce <spearce@spearce.org>
Subject: [PATCH] Clarified documentation of --exclude-per-directory.
Date: Mon, 25 Sep 2006 11:58:21 -0400
Message-ID: <20060925155821.GC26844@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 25 18:00:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRsql-0001kq-5Q
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 17:58:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWIYP61 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 11:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbWIYP60
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 11:58:26 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8345 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751051AbWIYP60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 11:58:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GRsqX-0007XN-S1
	for git@vger.kernel.org; Mon, 25 Sep 2006 11:58:17 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1029820FB28; Mon, 25 Sep 2006 11:58:22 -0400 (EDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27739>

Tommi Virtanen noted on #git today that

  git ls-files --exclude-per-directory

doesn't appear to work as advertised by the documentation unless
--others is also used.  According to the current source code this
is the case as the --exclude-per-directory file isn't read unless
we are iterating over the working directory, which only happens
with --others.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-ls-files.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index 8520b97..2a0b9f8 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -75,7 +75,8 @@ OPTIONS
 
 --exclude-per-directory=<file>::
 	read additional exclude patterns that apply only to the
-	directory and its subdirectories in <file>.
+	directory and its subdirectories in <file>.  This option
+	only takes effect if -o or --others is also used.
 
 --error-unmatch::
 	If any <file> does not appear in the index, treat this as an
@@ -167,7 +168,7 @@ time.  They are built and ordered in the
  * lines read from --exclude-from=<file>; patterns are ordered
    in the same order as they appear in the file.
 
- * When --exclude-per-directory=<name> is specified, upon
+ * When --exclude-per-directory=<name> and --others is specified, upon
    entering a directory that has such a file, its contents are
    appended at the end of the current "list of patterns".  They
    are popped off when leaving the directory.
-- 
1.4.2.1.g7a39b
