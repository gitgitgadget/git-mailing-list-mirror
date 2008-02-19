From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH 2/2] doc: documentation update for the branch track changes
Date: Tue, 19 Feb 2008 11:24:38 -0500
Message-ID: <1203438278-73786-2-git-send-email-jaysoffian@gmail.com>
References: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 19 17:25:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRVHX-0008KA-1F
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 17:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752899AbYBSQYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 11:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752861AbYBSQYu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 11:24:50 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:21210 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYBSQYr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 11:24:47 -0500
Received: by an-out-0708.google.com with SMTP id d31so512904and.103
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=67q6hHdpsUh2iZB4aVOTVaR7lC6PQlboSSbJws0VPvI=;
        b=lCwZoQaJpXqj94sTQJ6PkyfHGUQqtPZQCJTL9diCF/5lnvudndnHp+NI1zPSXLFDfO57qjrDkmtAykfWgufzBaZL5QR92926BioW6F4AZZiP0rFaalKStf0Y+dV22aS1EFp6iEDnsAlmYPIhdVRgemZE6eDYcGHs8O2oFb8uzDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=GGIJvuLaOU40Pb7GhA87n4vBPpNQgrnmR+ZuY0RZEHLMrqOg5A2NXTJtZY+UKVyy1zm3iv5njDhrA60Iskdcvl9HdLXfGdJpexK7sGEcOPQ6ZR1itKe3wXZ+9p5b8ompfUIHxvXVMBCG6QgjkC2LT2XQvjOl2FaxsZAqX/5ETp4=
Received: by 10.100.124.6 with SMTP id w6mr14523772anc.94.1203438286122;
        Tue, 19 Feb 2008 08:24:46 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id b7sm13518190ana.5.2008.02.19.08.24.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Feb 2008 08:24:45 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.203.g1b97.dirty
In-Reply-To: <1203438278-73786-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74424>

Documents the branch.autosetupmerge=always setting and usage of --track
when branching from a local branch.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I was trying to change too much at once. This is the bare minimum to
document the functionality changes.

 Documentation/config.txt       |   10 +++++++---
 Documentation/git-branch.txt   |   32 +++++++++++++++-----------------
 Documentation/git-checkout.txt |   24 +++++++++++-------------
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index fb6dae0..45bf8cd 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -379,10 +379,14 @@ apply.whitespace::
 
 branch.autosetupmerge::
 	Tells `git-branch` and `git-checkout` to setup new branches
-	so that linkgit:git-pull[1] will appropriately merge from that
-	remote branch.  Note that even if this option is not set,
+	so that linkgit:git-pull[1] will appropriately merge from the
+	starting point branch. Note that even if this option is not set,
 	this behavior can be chosen per-branch using the `--track`
-	and `--no-track` options.  This option defaults to true.
+	and `--no-track` options. The valid settings are: `false` -- no
+	automatic setup is done; `true` -- automatic setup is done when the
+	starting point is a remote branch; `always` -- automatic setup is
+	done when the starting point is either a local branch or remote
+	branch. This option defaults to true.
 
 branch.<name>.remote::
 	When in branch <name>, it tells `git fetch` which remote to fetch.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 7e8874a..c5426a5 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -35,11 +35,10 @@ working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
 
 When a local branch is started off a remote branch, git sets up the
-branch so that linkgit:git-pull[1] will appropriately merge from that
-remote branch.  If this behavior is not desired, it is possible to
-disable it using the global `branch.autosetupmerge` configuration
-flag.  That setting can be overridden by using the `--track`
-and `--no-track` options.
+branch so that linkgit:git-pull[1] will appropriately merge from
+the remote branch. This behavior may be changed via the global
+`branch.autosetupmerge` configuration flag. That setting can be
+overridden by using the `--track` and `--no-track` options.
 
 With a '-m' or '-M' option, <oldbranch> will be renamed to <newbranch>.
 If <oldbranch> had a corresponding reflog, it is renamed to match
@@ -105,20 +104,19 @@ OPTIONS
 	Display the full sha1s in output listing rather than abbreviating them.
 
 --track::
-	Set up configuration so that git-pull will automatically
-	retrieve data from the remote branch.  Use this if you always
-	pull from the same remote branch into the new branch, or if you
-	don't want to use "git pull <repository> <refspec>" explicitly.
-	This behavior is the default.  Set the
-	branch.autosetupmerge configuration variable to false if you
-	want git-checkout and git-branch to always behave as if
-	'--no-track' were given.
+	When creating a new branch, set up configuration so that git-pull
+	will automatically retrieve data from the start point, which must be
+	a branch. Use this if you always pull from the same upstream branch
+	into the new branch, or if you don't want to use "git pull
+	<repository> <refspec>" explicitly. This behavior is the default
+	when the start point is a remote branch. Set the
+	branch.autosetupmerge configuration variable to `false` if you want
+	git-checkout and git-branch to always behave as if '--no-track' were
+	given. Set it to `always` if you want this behavior when the
+	start-point is either a local or remote branch.
 
 --no-track::
-	When a branch is created off a remote branch,
-	set up configuration so that git-pull will not retrieve data
-	from the remote branch, ignoring the branch.autosetupmerge
-	configuration variable.
+	Ignore the branch.autosetupmerge configuration variable.
 
 <branchname>::
 	The name of the branch to create or delete.
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index b4cfa04..7c7cfb1 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -48,21 +48,19 @@ OPTIONS
 	may restrict the characters allowed in a branch name.
 
 --track::
-	When -b is given and a branch is created off a remote branch,
-	set up configuration so that git-pull will automatically
-	retrieve data from the remote branch.  Use this if you always
-	pull from the same remote branch into the new branch, or if you
-	don't want to use "git pull <repository> <refspec>" explicitly.
-	This behavior is the default.  Set the
-	branch.autosetupmerge configuration variable to false if you
-	want git-checkout and git-branch to always behave as if
-	'--no-track' were given.
+	When creating a new branch, set up configuration so that git-pull
+	will automatically retrieve data from the start point, which must be
+	a branch. Use this if you always pull from the same upstream branch
+	into the new branch, or if you don't want to use "git pull
+	<repository> <refspec>" explicitly. This behavior is the default
+	when the start point is a remote branch. Set the
+	branch.autosetupmerge configuration variable to `false` if you want
+	git-checkout and git-branch to always behave as if '--no-track' were
+	given. Set it to `always` if you want this behavior when the
+	start-point is either a local or remote branch.
 
 --no-track::
-	When -b is given and a branch is created off a remote branch,
-	set up configuration so that git-pull will not retrieve data
-	from the remote branch, ignoring the branch.autosetupmerge
-	configuration variable.
+	Ignore the branch.autosetupmerge configuration variable.
 
 -l::
 	Create the new branch's reflog.  This activates recording of
-- 
1.5.4.2.203.g1b97.dirty
