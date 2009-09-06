From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] githooks.txt: put hooks into subsections
Date: Sun,  6 Sep 2009 12:22:58 +0200
Message-ID: <6bd645c76041635d77e5ecc626e4386bd97715b4.1252168850.git.bert.wesarg@googlemail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 06 12:23:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkEtz-0005ti-Ox
	for gcvg-git-2@lo.gmane.org; Sun, 06 Sep 2009 12:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbZIFKXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Sep 2009 06:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754753AbZIFKXJ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Sep 2009 06:23:09 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:56149 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbZIFKXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Sep 2009 06:23:07 -0400
Received: by fxm17 with SMTP id 17so1471132fxm.37
        for <git@vger.kernel.org>; Sun, 06 Sep 2009 03:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=B77Bd0ohMBft2AMa5ncF6NQQAbdQNfsiO/8iJvYtV6s=;
        b=PtZsaHwukAv26pfJYgSU5fKphf0m9aR7e98f2rNsKGLfbXGoPya89F45yuFYwG0tl+
         2bucMkgJLrbVDB8iBH0f7Y1uub1mbj679Fbsee2SMH0Z2I0Vyy3riaY+uBt5iWayf9sn
         FDq3XSlCKNI3TBBIXbS+neBf/5A8LftW4KgUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MqLbsMoJDYBIOMsM0v/2vG8wy083Cx94RXULKt/ZC6wD52G0LzBFqJUBIt6k8CBxIP
         uTAOcDMNDSIku/EnJzzVRlrcLF5RaUNiqkBciudFFuLPr1pcfygritGefjvEcyw72NL0
         gsg4h5JaK7+RIKfHGt8V1vMY9nHgGt8ZI/lbM=
Received: by 10.86.231.19 with SMTP id d19mr6771193fgh.48.1252232589281;
        Sun, 06 Sep 2009 03:23:09 -0700 (PDT)
Received: from localhost ([188.46.111.40])
        by mx.google.com with ESMTPS id 12sm6691931fgg.27.2009.09.06.03.23.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Sep 2009 03:23:08 -0700 (PDT)
X-Mailer: git-send-email 1.6.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127849>

All hooks are currently in its own section. Which may confuse users,
because the section name serves as the hook file name and sections are
all caps for man pages. Putting them into a new HOOKS section and each
hook into a subsection keeps the case to lower case.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 Documentation/githooks.txt |   33 ++++++++++++++++++---------------
 1 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1c73673..acc408d 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -26,8 +26,11 @@ executable by default.
 
 This document describes the currently defined hooks.
 
+HOOKS
+-----
+
 applypatch-msg
---------------
+~~~~~~~~~~~~~~
 
 This hook is invoked by 'git-am' script.  It takes a single
 parameter, the name of the file that holds the proposed commit
@@ -43,7 +46,7 @@ The default 'applypatch-msg' hook, when enabled, runs the
 'commit-msg' hook, if the latter is enabled.
 
 pre-applypatch
---------------
+~~~~~~~~~~~~~~
 
 This hook is invoked by 'git-am'.  It takes no parameter, and is
 invoked after the patch is applied, but before a commit is made.
@@ -58,7 +61,7 @@ The default 'pre-applypatch' hook, when enabled, runs the
 'pre-commit' hook, if the latter is enabled.
 
 post-applypatch
----------------
+~~~~~~~~~~~~~~~
 
 This hook is invoked by 'git-am'.  It takes no parameter,
 and is invoked after the patch is applied and a commit is made.
@@ -67,7 +70,7 @@ This hook is meant primarily for notification, and cannot affect
 the outcome of 'git-am'.
 
 pre-commit
-----------
+~~~~~~~~~~
 
 This hook is invoked by 'git-commit', and can be bypassed
 with `\--no-verify` option.  It takes no parameter, and is
@@ -84,7 +87,7 @@ variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
 prepare-commit-msg
-------------------
+~~~~~~~~~~~~~~~~~~
 
 This hook is invoked by 'git-commit' right after preparing the
 default log message, and before the editor is started.
@@ -109,7 +112,7 @@ The sample `prepare-commit-msg` hook that comes with git comments
 out the `Conflicts:` part of a merge's commit message.
 
 commit-msg
-----------
+~~~~~~~~~~
 
 This hook is invoked by 'git-commit', and can be bypassed
 with `\--no-verify` option.  It takes a single parameter, the
@@ -126,7 +129,7 @@ The default 'commit-msg' hook, when enabled, detects duplicate
 "Signed-off-by" lines, and aborts the commit if one is found.
 
 post-commit
------------
+~~~~~~~~~~~
 
 This hook is invoked by 'git-commit'.  It takes no
 parameter, and is invoked after a commit is made.
@@ -135,14 +138,14 @@ This hook is meant primarily for notification, and cannot affect
 the outcome of 'git-commit'.
 
 pre-rebase
-----------
+~~~~~~~~~~
 
 This hook is called by 'git-rebase' and can be used to prevent a branch
 from getting rebased.
 
 
 post-checkout
------------
+~~~~~~~~~~~~~
 
 This hook is invoked when a 'git-checkout' is run after having updated the
 worktree.  The hook is given three parameters: the ref of the previous HEAD,
@@ -160,7 +163,7 @@ differences from the previous HEAD if different, or set working dir metadata
 properties.
 
 post-merge
------------
+~~~~~~~~~~
 
 This hook is invoked by 'git-merge', which happens when a 'git-pull'
 is done on a local repository.  The hook takes a single parameter, a status
@@ -175,7 +178,7 @@ for an example of how to do this.
 
 [[pre-receive]]
 pre-receive
------------
+~~~~~~~~~~~
 
 This hook is invoked by 'git-receive-pack' on the remote repository,
 which happens when a 'git-push' is done on a local repository.
@@ -204,7 +207,7 @@ for the user.
 
 [[update]]
 update
-------
+~~~~~~
 
 This hook is invoked by 'git-receive-pack' on the remote repository,
 which happens when a 'git-push' is done on a local repository.
@@ -247,7 +250,7 @@ unannotated tags to be pushed.
 
 [[post-receive]]
 post-receive
-------------
+~~~~~~~~~~~~
 
 This hook is invoked by 'git-receive-pack' on the remote repository,
 which happens when a 'git-push' is done on a local repository.
@@ -277,7 +280,7 @@ emails.
 
 [[post-update]]
 post-update
------------
+~~~~~~~~~~~
 
 This hook is invoked by 'git-receive-pack' on the remote repository,
 which happens when a 'git-push' is done on a local repository.
@@ -308,7 +311,7 @@ Both standard output and standard error output are forwarded to
 for the user.
 
 pre-auto-gc
------------
+~~~~~~~~~~~
 
 This hook is invoked by 'git-gc --auto'. It takes no parameter, and
 exiting with non-zero status from this script causes the 'git-gc --auto'
-- 
1.6.4.GIT
