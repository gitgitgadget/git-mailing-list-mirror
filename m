From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/3] git-merge-base/git-show-branch: Cleanup documentation and usage
Date: Wed,  5 Aug 2009 09:59:19 +0200
Message-ID: <1249459160-3931-3-git-send-email-git@drmicha.warpmail.net>
References: <1249459160-3931-1-git-send-email-git@drmicha.warpmail.net>
 <1249459160-3931-2-git-send-email-git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 05 09:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYbPX-00031z-Ls
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 09:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933739AbZHEH7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 03:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933737AbZHEH7k
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 03:59:40 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:55554 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933736AbZHEH7j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 03:59:39 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E65693BC9C8;
	Wed,  5 Aug 2009 03:59:39 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 05 Aug 2009 03:59:39 -0400
X-Sasl-enc: 1f1vJnyt2J+exKKDpzizaR0vgCtf28JeF+niMwmHbejT 1249459179
Received: from localhost (vpn-136-027.rz.uni-augsburg.de [137.250.136.27])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 141842B6A;
	Wed,  5 Aug 2009 03:59:38 -0400 (EDT)
X-Mailer: git-send-email 1.6.4.70.g9c084
In-Reply-To: <1249459160-3931-2-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124873>

Make sure that usage strings and documentation coincide with each other
and with the actual code.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Also does one 's/git-/git /'.

 Documentation/git-merge-base.txt  |    5 +++--
 Documentation/git-show-branch.txt |    5 +++--
 builtin-merge-base.c              |    2 +-
 builtin-show-branch.c             |    4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 767486c..00e4003 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -8,12 +8,12 @@ git-merge-base - Find as good common ancestors as possible for a merge
 
 SYNOPSIS
 --------
-'git merge-base' [--all] <commit> <commit>...
+'git merge-base' [-a|--all] <commit> <commit>...
 
 DESCRIPTION
 -----------
 
-'git-merge-base' finds best common ancestor(s) between two commits to use
+'git merge-base' finds best common ancestor(s) between two commits to use
 in a three-way merge.  One common ancestor is 'better' than another common
 ancestor if the latter is an ancestor of the former.  A common ancestor
 that does not have any better common ancestor is a 'best common
@@ -29,6 +29,7 @@ the given two commits.
 
 OPTIONS
 -------
+-a::
 --all::
 	Output all merge bases for the commits, instead of just one.
 
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 89ec536..2c78c25 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,11 +8,12 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git show-branch' [--all] [--remotes] [--topo-order | --date-order]
-		[--current] [--color | --no-color]
+'git show-branch' [-a|--all] [-r|--remotes] [--topo-order | --date-order]
+		[--current] [--color | --no-color] [--sparse]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
 		[<rev> | <glob>]...
+
 'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
 DESCRIPTION
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index a6ec2f7..54e7ec2 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -23,7 +23,7 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 }
 
 static const char * const merge_base_usage[] = {
-	"git merge-base [--all] <commit-id> <commit-id>...",
+	"git merge-base [-a|--all] <commit> <commit>...",
 	NULL
 };
 
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 01bea3b..03bdea6 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -6,8 +6,8 @@
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
-    "git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base] [--topics] [--color] [<refs>...]",
-    "--reflog[=n[,b]] [--list] [--color] <branch>",
+    "git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [<rev> | <glob>]...",
+    "git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]",
     NULL
 };
 
-- 
1.6.4.70.g9c084
