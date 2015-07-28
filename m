From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/6] minor documentation improvements
Date: Tue, 28 Jul 2015 16:06:09 -0400
Message-ID: <1438113975-4915-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 28 22:07:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKB9Y-0001iR-Se
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 22:07:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbG1UGp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 16:06:45 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:32905 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbbG1UGo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 16:06:44 -0400
Received: by igbpg9 with SMTP id pg9so152720226igb.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=YJMBVeZAxOKs+Fug7TSx/xv2/3EiSy9onA8NrnkqeE4=;
        b=cNHXEej6VnhTc22vuj9dODQgn+Bi65Uv41aZIISWBWtVuvsNGdLjB03kQC5LEeVMNS
         6KiNLNXsmDPNx3OHbZ53Guw8keAlxF0P5Bx9XPPDfcJ4nodRXfMv/jW4sTsz0twc21BW
         dj/bYxTsDiCmuYm6oqdrBvXy6Hr1QS7HCBlFi1oqUuAiu1QTDKM+K1/m+aEOVhx5nV+e
         IGEDWl7PxWkiiU6d+vGLLHFOzSJQMSfJznOkYYkP8W3OGAi6yifU05YbsoVz3a5pgF2Q
         FyEZ925Y2oTQzbp4cDAl4SjzCBeC4uwe2Irznz/tOgi93fJslujOTVFuRPUbOTjaxhDA
         sN7A==
X-Received: by 10.107.137.87 with SMTP id l84mr58075819iod.119.1438114003233;
        Tue, 28 Jul 2015 13:06:43 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id r16sm15195896ioe.19.2015.07.28.13.06.41
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jul 2015 13:06:42 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc3.490.g8c70279
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274834>

This is a re-roll of [1] which makes minor improvements to documentation
based upon observations of Michael Haggerty, Junio, and myself. This
version addresses review comments by Michael[2] and includes follow-on
patch 7/6 which arose[3] from my observation that it may be time to
retire the manually-maintained list of 3rd party tools altogether. This
version also drops v1 patch 1/6 since that patch[4] has already migrated
to 'next'[5].

This is built atop [5] in 'next'. A v1 to v2 interdiff is included
below.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/274537
[2]: http://article.gmane.org/gmane.comp.version-control.git/274647
[3]: http://article.gmane.org/gmane.comp.version-control.git/274602
[4]: http://article.gmane.org/gmane.comp.version-control.git/274541
[5]: 5f5f553 (Documentation/git-worktree: fix broken 'linkgit' invocation, 2015-07-24)

Eric Sunshine (6):
  Documentation/config: mention "now" and "never" for 'expire' settings
  Documentation/git: drop outdated Cogito reference
  Documentation/git-tools: improve discoverability of Git wiki
  Documentation/git-tools: fix item text formatting
  Documentation/git-tools: drop references to defunct tools
  Documentation/git-tools: retire manually-maintained list

 Documentation/config.txt    |  16 ++++--
 Documentation/git-tools.txt | 124 +++-----------------------------------------
 Documentation/git.txt       |   2 +-
 3 files changed, 20 insertions(+), 122 deletions(-)

-- 
2.5.0.rc3.490.g8c70279


--- 8< ---
diff --git a/Documentation/config.txt b/Documentation/config.txt
index ba37a36..e09ee02 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1227,21 +1227,23 @@ gc.pruneexpire::
 	When 'git gc' is run, it will call 'prune --expire 2.weeks.ago'.
 	Override the grace period with this config variable.  The value
 	"now" may be used to disable this grace period and always prune
-	unreachable objects immediately; or "never" to suppress pruning.
+	unreachable objects immediately, or "never" may be used to
+	suppress pruning.
 
 gc.worktreePruneExpire::
 	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
 	This config variable can be used to set a different grace
 	period. The value "now" may be used to disable the grace
-	period and prune $GIT_DIR/worktrees immediately; or "never" to
-	suppress pruning.
+	period and prune $GIT_DIR/worktrees immediately, or "never"
+	may be used to suppress pruning.
 
 gc.reflogexpire::
 gc.<pattern>.reflogexpire::
 	'git reflog expire' removes reflog entries older than
-	this time; defaults to 90 days. The value "all" expires all
-	entries; and "false" disables expiration. With "<pattern>" (e.g.
+	this time; defaults to 90 days. The value "now" expires all
+	entries immediately, and "never" suppresses expiration
+	altogether. With "<pattern>" (e.g.
 	"refs/stash") in the middle the setting applies only to
 	the refs that match the <pattern>.
 
@@ -1249,8 +1251,9 @@ gc.reflogexpireunreachable::
 gc.<ref>.reflogexpireunreachable::
 	'git reflog expire' removes reflog entries older than
 	this time and are not reachable from the current tip;
-	defaults to 30 days. The value "all" expires all entries; and
-	"false" disables expiration. With "<pattern>" (e.g. "refs/stash")
+	defaults to 30 days. The value "now" expires all entries
+	immediately, and "never" suppresses expiration altogether.
+	With "<pattern>" (e.g. "refs/stash")
 	in the middle, the setting applies only to the refs that
 	match the <pattern>.
 
diff --git a/Documentation/git-tools.txt b/Documentation/git-tools.txt
index 48a3595..2f4ff50 100644
--- a/Documentation/git-tools.txt
+++ b/Documentation/git-tools.txt
@@ -1,84 +1,10 @@
-A short Git tools survey
-========================
+Git Tools
+=========
 
+When Git was young, people looking for third-party Git-related tools came
+to the Git project itself to find them, thus a list of such tools was
+maintained here. These days, however, search engines fill that role much
+more efficiently, so this manually-maintained list has been retired.
 
-Introduction
-------------
-
-Apart from Git contrib/ area there are some others third-party tools
-you may want to look at.
-This document presents a brief summary of each tool and the corresponding
-link.
-For a more comprehensive list, see:
+See also the `contrib/` area, and the Git wiki:
 http://git.or.cz/gitwiki/InterfacesFrontendsAndTools
-
-
-Alternative/Augmentative Porcelains
------------------------------------
-
-- *StGit* (http://www.procode.org/stgit/)
-+
-Stacked Git provides a quilt-like patch management functionality in the
-Git environment. You can easily manage your patches in the scope of Git
-until they get merged upstream.
-
-
-History Viewers
----------------
-
-- *gitk* (shipped with git-core)
-+
-gitk is a simple Tk GUI for browsing history of Git repositories easily.
-
-
-- *gitview*  (contrib/)
-+
-gitview is a GTK based repository browser for Git
-
-
-- *gitweb* (shipped with git-core)
-+
-Gitweb provides full-fledged web interface for Git repositories.
-
-
-- *qgit* (http://digilander.libero.it/mcostalba/)
-+
-QGit is a git/StGit GUI viewer built on Qt/C++. QGit could be used
-to browse history and directory tree, view annotated files, commit
-changes cherry picking single files or applying patches.
-Currently it is the fastest and most feature rich among the Git
-viewers and commit tools.
-
-- *tig* (http://jonas.nitro.dk/tig/)
-+
-tig by Jonas Fonseca is a simple Git repository browser
-written using ncurses. Basically, it just acts as a front-end
-for git-log and git-show/git-diff. Additionally, you can also
-use it as a pager for Git commands.
-
-
-Foreign SCM interface
----------------------
-
-- *git-svn* (shipped with git-core)
-+
-git-svn is a simple conduit for changesets between a single Subversion
-branch and Git.
-
-
-- *hg-to-git* (contrib/)
-+
-hg-to-git converts a Mercurial repository into a Git one, and
-preserves the full branch history in the process. hg-to-git can
-also be used in an incremental way to keep the Git repository
-in sync with the master Mercurial repository.
-
-
-Others
-------
-
-- *git.el* (contrib/)
-+
-This is an Emacs interface for Git. The user interface is modelled on
-pcl-cvs. It has been developed on Emacs 21 and will probably need some
-tweaking to work on XEmacs.
--- 8< ---
