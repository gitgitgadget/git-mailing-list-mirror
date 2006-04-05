From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: [PATCH] git-commit: document --amend
Date: Wed, 5 Apr 2006 22:28:28 +0200
Message-ID: <20060405202828.GA21037@fiberbit.xs4all.nl>
References: <20060405191608.GA20572@fiberbit.xs4all.nl> <7vfykr24wi.fsf@assigned-by-dhcp.cox.net> <20060405194607.GB20854@fiberbit.xs4all.nl> <7vacaz23wr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Marco Roeland <marco.roeland@xs4all.nl>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 22:28:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FREcG-0005cb-BA
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 22:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWDEU2d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 16:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWDEU2d
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 16:28:33 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:33687 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S1751156AbWDEU2d
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Apr 2006 16:28:33 -0400
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.54)
	id 1FREc8-0005Vj-Mx; Wed, 05 Apr 2006 22:28:28 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vacaz23wr.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18453>

The "--amend" option is used to amend the tip of the current branch. This
documentation text was copied straight from the commit that implemented it.

Some minor format tweaks for asciidoc were taken from work by Francis Daly
in commit b0d08a5.. It looks good now also in the html page.

Signed-off-by: Marco Roeland <marco.roeland@xs4all.nl>

---

 Documentation/git-commit.txt |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

293dccf6f8c47294a42376ad96d8c1130b06c9b9
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index d04b342..ec8b562 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -9,7 +9,8 @@ SYNOPSIS
 --------
 [verse]
 'git-commit' [-a] [-s] [-v] [(-c | -C) <commit> | -F <file> | -m <msg>]
-	   [-e] [--author <author>] [--] [[-i | -o ]<file>...]
+	   [--no-verify] [--amend] [-e] [--author <author>]
+	   [--] [[-i | -o ]<file>...]
 
 DESCRIPTION
 -----------
@@ -70,6 +71,27 @@ OPTIONS
 	`-m`, and from file with `-C` are usually used as the
 	commit log message unmodified.  This option lets you
 	further edit the message taken from these sources.
+
+--amend::
+
+	Used to amend the tip of the current branch. Prepare the tree
+	object you would want to replace the latest commit as usual
+	(this includes the usual -i/-o and explicit paths), and the
+	commit log editor is seeded with the commit message from the
+	tip of the current branch. The commit you create replaces the
+	current tip -- if it was a merge, it will have the parents of
+	the current tip as parents -- so the current top commit is
+	discarded.
++
+It is a rough equivalent for:
++
+$ git reset --soft HEAD^
++
+$ ... do something else to come up with the right tree ...
++
+$ git commit -c ORIG_HEAD
++
+but can be used to amend a merge commit.
 
 -i|--include::
 	Instead of committing only the files specified on the
-- 
1.3.0.rc2.gca38
