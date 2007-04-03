From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Documentation: A few minor fixes to Git User's Manual
Date: Tue,  3 Apr 2007 18:27:28 +0200
Message-ID: <11756176481314-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 03 18:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYlo1-0008J2-4d
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 18:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932787AbXDCQYW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 12:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbXDCQYW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 12:24:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:61194 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932787AbXDCQYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 12:24:21 -0400
Received: by ug-out-1314.google.com with SMTP id 44so341933uga
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 09:24:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        b=AqU+pDBOwAFMAcxRncFXIOQJxqD4OUjS3Bch6BgVwXp+NEMU2GgKVx4rVHrCm7TjuNiFPVD/A5OVvsku4VtIwLGCqhHhNSndKu0Xr5daJwq+7q4vEXUDJAlRHpkQnePy/nEpP7kghz1qbBfV5ypf8Eh02W2uURftNAtkLFOK2F0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=ABtpOmi1+GAyS4RYr0KABBLnrDjVScC7i/hUjzofKiiipt8d9K+CBxYgzjCT12SUvO+cjYsMf+9V6vlNj6/egmIQ+KEQa68vZiBCAoqMaaMo3dQggsamXmgrGXqX2kL7idHDyNKTpgD36oZcsm6VKYGoAmjYnoUQoUHQ3j7wu8w=
Received: by 10.78.205.7 with SMTP id c7mr1776242hug.1175617452718;
        Tue, 03 Apr 2007 09:24:12 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id e8sm7752415muf.2007.04.03.09.24.10;
        Tue, 03 Apr 2007 09:24:11 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l33GRTum010774;
	Tue, 3 Apr 2007 18:27:30 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l33GRSTN010773;
	Tue, 3 Apr 2007 18:27:28 +0200
X-Mailer: git-send-email 1.5.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43627>

Mainly consistent usage of "git command" and not "git-command" syntax

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
A few [shorthand] comments about Git User's Manual:

* no "detached head" feature (since 1.5.0.5 at least)
* git branch --track as shorthand (for 1.5.1)
* uses ssh://host/path syntax instead of scp-like host:path
  (which one is preferred? documentation has URL-like first)
* no mention of receive.denyNonFastForwards (in about push)
* inconsistent use of header levels
        Level 0 (top level):     ======================                              
        Level 1:                 ----------------------                              
        Level 2:                 ~~~~~~~~~~~~~~~~~~~~~~                              
        Level 3:                 ^^^^^^^^^^^^^^^^^^^^^^                              
        Level 4 (bottom level):  ++++++++++++++++++++++
* no git rebase --skip (e.g. if patch was applied, but
  duplication was not detected, or patch is no longer needed)
* no git rebase --merge (e.g. renames)
* git cherry-pick --no-commit + git commit, instead of
  git cherry-pick + git commit --amend
* legitimate use of multiple root commits: joining projects
  (e.g. git = git-core + git-tools (mail) + gitk + gitweb + git-gui)
* note that description of git internals would use plumbing
  commands (e.g. git-update-index instead of git-add / git-rm)
* blob object: git-add and git-show instead of git-update-index
  and git-cat-file? (plumbing vs porcelain)
* tree object: user usually do not use git-write-tree (plumbing) (?)
* commit object: "read SCM's", "idiotic file manager" -- git has
  now enough porcelain to be considered full fledged SCM (in "Note
  on commits"). needs rewording?
* tag object: porcelain to create tag is git-tag, and you can use
  git tag -v to verify a tag (plumbing vs porcelain)
* interchanging old name "directory cache" with new name "index"
* git update-index --force-remove to make file untracked
* very useful git-cat-file -p
* git-rev-parse <commitname>^{tree} instead of 
  git-cat-file commit <commitname> | head -1
* git-cat-file blob :1:hello.c >hello.c~1, git-merge-file
  (and git-mergetool if discussion was not so plumbing-ish)

 Documentation/user-manual.txt |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 1c49e69..574e9c0 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -84,7 +84,7 @@ $ git branch -r		# list
   origin/master
   origin/next
   ...
-$ git branch checkout -b masterwork origin/master
+$ git checkout -b masterwork origin/master
 -----------------------------------------------
 
 Fetch a branch from a different repository, and give it a new
@@ -155,8 +155,8 @@ Make sure git knows who to blame:
 ------------------------------------------------
 $ cat >~/.gitconfig <<\EOF
 [user]
-name = Your Name Comes Here
-email = you@yourdomain.example.com
+	name = Your Name Comes Here
+	email = you@yourdomain.example.com
 EOF
 ------------------------------------------------
 
@@ -195,7 +195,7 @@ Importing or exporting patches:
 -----------------------------------------------
 $ git format-patch origin..HEAD # format a patch for each commit
 				# in HEAD but not in origin
-$ git-am mbox # import patches from the mailbox "mbox"
+$ git am mbox # import patches from the mailbox "mbox"
 -----------------------------------------------
 
 Fetch a branch in a different git repository, then merge into the
@@ -579,7 +579,7 @@ cloned from, using gitlink:git-remote[1]:
 
 -------------------------------------------------
 $ git remote add linux-nfs git://linux-nfs.org/pub/nfs-2.6.git
-$ git fetch
+$ git fetch linux-nfs
 * refs/remotes/linux-nfs/master: storing branch 'master' ...
   commit: bf81b46
 -------------------------------------------------
@@ -680,7 +680,7 @@ occasionally you may land on a commit that broke something unrelated;
 run
 
 -------------------------------------------------
-$ git bisect-visualize
+$ git bisect visualize
 -------------------------------------------------
 
 which will run gitk and label the commit it chose with a marker that
@@ -765,7 +765,7 @@ We can also create a tag to refer to a particular commit; after
 running
 
 -------------------------------------------------
-$ git-tag stable-1 1b2e1d63ff
+$ git tag stable-1 1b2e1d63ff
 -------------------------------------------------
 
 You can use stable-1 to refer to the commit 1b2e1d63ff.
@@ -909,7 +909,7 @@ name based on any tag it finds pointing to one of the commit's
 descendants:
 
 -------------------------------------------------
-$ git name-rev e05db0fd
+$ git name-rev --tags e05db0fd
 e05db0fd tags/v1.5.0-rc1^0~23
 -------------------------------------------------
 
@@ -918,7 +918,7 @@ revision using a tag on which the given commit is based:
 
 -------------------------------------------------
 $ git describe e05db0fd
-v1.5.0-rc0-ge05db0f
+v1.5.0-rc0-260-ge05db0f
 -------------------------------------------------
 
 but that may sometimes help you guess which tags might come after the
@@ -1861,7 +1861,7 @@ Allow web browsing of a repository
 
 The gitweb cgi script provides users an easy way to browse your
 project's files and history without having to install git; see the file
-gitweb/README in the git source tree for instructions on setting it up.
+gitweb/INSTALL in the git source tree for instructions on setting it up.
 
 Examples
 --------
-- 
1.5.0.5
