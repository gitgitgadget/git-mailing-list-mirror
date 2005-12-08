From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: [PATCH 9/17] Add documentation for git-revert and git-cherry-pick.
Date: Fri, 9 Dec 2005 00:28:05 +0100
Message-ID: <11340844853882-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
References: <11340844851758-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
Reply-To: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nikolai Weibull <nikolai@bitwi.se>
X-From: git-owner@vger.kernel.org Fri Dec 09 00:30:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkVCM-0004lM-Q1
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 00:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932727AbVLHX2e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 18:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbVLHX2d
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 18:28:33 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:26574 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932727AbVLHX2a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2005 18:28:30 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051208232816.VWZA17186.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Fri, 9 Dec 2005 00:28:16 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 09 Dec 2005 00:28:33 +0100
X-BrightmailFiltered: true
X-IronPort-AV: i="3.99,232,1131318000"; 
   d="scan'208"; a="16674756:sNHT144252810"
Received: from puritan (localhost [127.0.0.1])
	by puritan.petwork (Postfix) with SMTP id 90AF8ADFF1;
	Fri,  9 Dec 2005 00:28:05 +0100 (CET)
In-Reply-To: <11340844851758-git-send-email-mailing-lists.git@rawuncut.elitemail.org>
X-Mailer: git-send-email
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13395>

* Added the -e option to the documentation of git-cherry-pick.
* Added the -e and --no-commit option to git-revert.
* Removed redundant case expression for -n as --no-edit (already taken by
  --no-commit).

Signed-off-by: Nikolai Weibull <nikolai@bitwi.se>

---

 Documentation/git-cherry-pick.txt |    2 +-
 Documentation/git-revert.txt      |    4 ++--
 git-revert.sh                     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

d4736aca7d9e34a56c0c32130af057bc2b9f0dfa
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 744f2c9..4f323fa 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -20,7 +20,7 @@ OPTIONS
 <commit>::
 	Commit to cherry-pick.
 
---edit::
+-e|--edit::
 	With this option, `git-cherry-pick` will let you edit the commit
 	message prior committing.
 
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index f471037..e27c680 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -20,7 +20,7 @@ OPTIONS
 <commit>::
 	Commit to revert.
 
---edit::
+-e|--edit::
 	With this option, `git-revert` will let you edit the commit
 	message prior committing the revert. This is the default if
 	you run the command from a terminal.
@@ -29,7 +29,7 @@ OPTIONS
 	With this option, `git-revert` will not start the commit
 	message editor.
 
--n::
+-n|--no-commit::
 	Usually the command automatically creates a commit with
 	a commit log message stating which commit was reverted.
 	This flag applies the change necessary to revert the
diff --git a/git-revert.sh b/git-revert.sh
index 5cb02b1..9d499c4 100755
--- a/git-revert.sh
+++ b/git-revert.sh
@@ -38,7 +38,7 @@ do
 	-e|--e|--ed|--edi|--edit)
 		edit=-e
 		;;
-	-n|--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
+	--n|--no|--no-|--no-e|--no-ed|--no-edi|--no-edit)
 		edit=
 		;;
 	-r|--r|--re|--rep|--repl|--repla|--replay)
-- 
0.99.9l
