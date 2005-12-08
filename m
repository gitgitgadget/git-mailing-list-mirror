From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 10/17] Add documentation for the --topo-order option to git-show-branch.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844852416-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844853882-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCL-0004lM-4a
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbVLHX21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVLHX20
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:26 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:31182 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932738AbVLHX2T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:19 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232818.VWZH17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:18 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674757:sNHT366246864"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id A12FEADFF5;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844853882-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13391>

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-show-branch.txt |    8 +++++++-
 show-branch.c                     |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

1458ff5267fcaa7b2178e53865cd5056e3776d8d
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 304101d..ffe64d8 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -7,7 +7,7 @@ git-show-branch - Show branches and thei
 
 SYNOPSIS
 --------
-'git-show-branch [--all] [--heads] [--tags] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [<rev> | <glob>]...'
+'git-show-branch [--all] [--heads] [--tags] [--topo-order] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [<rev> | <glob>]...'
 
 DESCRIPTION
 -----------
@@ -35,6 +35,12 @@ OPTIONS
 	Show all refs under $GIT_DIR/refs, $GIT_DIR/refs/heads,
 	and $GIT_DIR/refs/tags, respectively.
 
+--topo-order::
+        By default, the branches and their commits are shown in
+        reverse chronological order.  This option makes them
+        appear in topological order (i.e., descendant commits
+        are shown before their parents).
+
 --more=<n>::
 	Usually the command stops output upon showing the commit
 	that is the common ancestor of all the branches.  This
diff --git a/show-branch.c b/show-branch.c
index bff690d..64a55dc 100644
--- a/show-branch.c
+++ b/show-branch.c
@@ -5,7 +5,7 @@
 #include "refs.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--all] [--heads] [--tags] [--more=count | --list | --independent | --merge-base ] [<refs>...]";
+"git-show-branch [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [<refs>...]";
 
 #define UNINTERESTING	01
 
-- 
0.99.9l
