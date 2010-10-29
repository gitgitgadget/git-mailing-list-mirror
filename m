From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 2/2] Documentation: suggest "reset --keep" more often
Date: Fri, 29 Oct 2010 03:39:30 -0500
Message-ID: <20101029083930.GC26290@burratino>
References: <20101029083516.GA26290@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bebarino@gmail.com, srabbelier@gmail.com,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 29 10:39:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBkUy-0000tq-Ne
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 10:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760815Ab0J2Ijk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Oct 2010 04:39:40 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49490 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007Ab0J2Iji (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 04:39:38 -0400
Received: by iwn10 with SMTP id 10so3431398iwn.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 01:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=MVGa9FOSkJW5Wbr0lS2Bbn2aRiKCNzyFZM1mBI1jTAU=;
        b=PH0UyV11Xm6rB+G4GjbPd+zsXO4YIoIN7rFFR0FQeyLLnK0KLGZ5dd6aLRS9jJTn1/
         lzgc0sw4Vv/RQmaLY1OZY0SDnYOkNE4QpDRwXKK95+zrvHyAc4fX+a5Ql4luCsRefdR6
         CO/CmVBLgHv9zWVS0rfFjcWSOiALZ9p5N9+AE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=pThnujmc9Yaiu2OH07jEOQ84XDAhcup/y7GlB1RuYXBV2PTxLinI4Au8TKDYtzZRqw
         aD8pZvfibQ53UB9SeZ11NJxntwXOMeIZCFpy8mMnwyyv3oE7c0c23qBWsrWvc4blc39A
         us/qHCFOu8xoCz3w6kZUYNvbYIZUU+ATgWU+8=
Received: by 10.231.157.145 with SMTP id b17mr11014436ibx.78.1288341577632;
        Fri, 29 Oct 2010 01:39:37 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u6sm3424090ibd.0.2010.10.29.01.39.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 01:39:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101029083516.GA26290@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160321>

Practically speaking, a "reset --hard" fulfills two purposes:

 1. erase uncommitted changes (in the index and worktree)
 2. checkout a different commit without changing which branch
    HEAD is attached to

The relatively new "git reset --keep" command does (2) without
(1), which makes it simpler to use for use cases that amount to
"rewind HEAD".

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/git-bisect-lk2009.txt               |    2 +-
 Documentation/git-bisect.txt                      |    2 +-
 Documentation/git-checkout.txt                    |    2 +-
 Documentation/git-rerere.txt                      |    2 +-
 Documentation/git-reset.txt                       |    4 ++--
 Documentation/gitcore-tutorial.txt                |    6 +++---
 Documentation/gitworkflows.txt                    |    2 +-
 Documentation/howto/maintain-git.txt              |    4 ++--
 Documentation/howto/separating-topic-branches.txt |    2 +-
 Documentation/user-manual.txt                     |   13 +++++++------
 10 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 8a2ba37..b581da8 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1188,7 +1188,7 @@ should not forget to remove the patch once the testing is done before
 exiting from the script.
 
 (Note that instead of a patch you can use "git cherry-pick BFC" to
-apply the fix, and in this case you should use "git reset --hard
+apply the fix, and in this case you should use "git reset --keep
 HEAD^" to revert the cherry-pick after testing and before returning
 from the script.)
 
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index c39d957..43582a8 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -158,7 +158,7 @@ For example:
 $ git bisect good/bad			# previous round was good or bad.
 Bisecting: 337 revisions left to test after this
 $ git bisect visualize			# oops, that is uninteresting.
-$ git reset --hard HEAD~3		# try 3 revisions before what
+$ git reset --keep HEAD~3		# try 3 revisions before what
 					# was suggested
 ------------
 
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 22d3611..f92fe3f 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -223,7 +223,7 @@ current branch and directly points at the commit named by the tag
 (`v2.6.18` in the example above).
 
 You can use all git commands while in this state.  You can use
-`git reset --hard $othercommit` to further move around, for
+`git reset --keep $othercommit` to further move around, for
 example.  You can make changes and create a new commit on top of
 a detached HEAD.  You can even create a merge by using `git
 merge $othercommit`.
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index db99d47..4ed4262 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -132,7 +132,7 @@ top of the tip before the test merge:
 ------------
 	$ git checkout topic
 	$ git merge master
-	$ git reset --hard HEAD^ ;# rewind the test merge
+	$ git reset --keep HEAD^ ;# rewind the test merge
 	$ ... work on both topic and master branches
 	$ git checkout master
 	$ git merge topic
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 1d0d9e6..301419c 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -148,7 +148,7 @@ Undo a commit, making it a topic branch::
 +
 ------------
 $ git branch topic/wip     <1>
-$ git reset --hard HEAD~3  <2>
+$ git reset --keep HEAD~3  <2>
 $ git checkout topic/wip   <3>
 ------------
 +
@@ -163,7 +163,7 @@ Undo commits permanently::
 +
 ------------
 $ git commit ...
-$ git reset --hard HEAD~3   <1>
+$ git reset --keep HEAD~3   <1>
 ------------
 +
 <1> The last three commits (HEAD, HEAD^, and HEAD~2) were bad
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index c27d086..14bdceb 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1182,9 +1182,9 @@ work." commit.
 
 ------------
 $ git checkout mybranch
-$ git reset --hard master^2
+$ git reset --keep master^2
 $ git checkout master
-$ git reset --hard master^
+$ git reset --keep master^
 ------------
 
 After rewinding, the commit structure should look like this:
@@ -1660,7 +1660,7 @@ we just did and start over.  We would want to get the master
 branch before these two merges by resetting it to 'master~2':
 
 ------------
-$ git reset --hard master~2
+$ git reset --keep master~2
 ------------
 
 You can make sure `git show-branch` matches the state before
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 1ef55ff..4a35a92 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -301,7 +301,7 @@ topics on 'next':
 [caption="Recipe: "]
 =====================================
 * `git checkout next`
-* `git reset --hard master`
+* `git reset --keep master`
 * `git merge ai/topic_in_next1`
 * `git merge ai/topic_in_next2`
 * ...
diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index d527b30..f0c9e1b 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -166,7 +166,7 @@ by doing the following:
 
    then replace some parts with the new patch, and reapplying:
 
-     $ git reset --hard ai/topic~$n
+     $ git reset --keep ai/topic~$n
      $ git am -3 -s 000*.txt
 
    The full test suite is always run for 'maint' and 'master'
@@ -212,7 +212,7 @@ by doing the following:
  - Rebuild "pu" to merge the tips of topics not in 'next'.
 
      $ git checkout pu
-     $ git reset --hard next
+     $ git reset --keep next
      $ git merge ai/topic     ;# repeat for all remaining topics
      $ make test
 
diff --git a/Documentation/howto/separating-topic-branches.txt b/Documentation/howto/separating-topic-branches.txt
index 6d3eb8e..b54826f 100644
--- a/Documentation/howto/separating-topic-branches.txt
+++ b/Documentation/howto/separating-topic-branches.txt
@@ -80,7 +80,7 @@ The last diff better not to show anything other than cleanups
 for crufts.  Then I can finally clean things up:
 
         $ git branch -D topic
-        $ git reset --hard HEAD^ ;# nuke pretend merge
+        $ git reset --keep HEAD^ ;# nuke pretend merge
 
                                 "topicB"
                o---o---o---o---o
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 9120ad5..427717d 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -143,7 +143,7 @@ If you decide that you'd rather see version 2.6.17, you can modify
 the current branch to point at v2.6.17 instead, with
 
 ------------------------------------------------
-$ git reset --hard v2.6.17
+$ git reset --keep v2.6.17
 ------------------------------------------------
 
 Note that if the current branch head was your only reference to a
@@ -531,13 +531,13 @@ says "bisect".  Choose a safe-looking commit nearby, note its commit
 id, and check it out with:
 
 -------------------------------------------------
-$ git reset --hard fb47ddb2db...
+$ git reset --keep fb47ddb2db...
 -------------------------------------------------
 
 then test, run "bisect good" or "bisect bad" as appropriate, and
 continue.
 
-Instead of "git bisect visualize" and then "git reset --hard
+Instead of "git bisect visualize" and then "git reset --keep
 fb47ddb2db...", you might just want to tell git that you want to skip
 the current commit:
 
@@ -1388,7 +1388,7 @@ $ git reset --merge HEAD
 Or, if you've already committed the merge that you want to throw away,
 
 -------------------------------------------------
-$ git reset --hard ORIG_HEAD
+$ git reset --keep ORIG_HEAD
 -------------------------------------------------
 
 However, this last command can be dangerous in some cases--never
@@ -2011,7 +2011,8 @@ error: failed to push to 'ssh://yourserver.com/~you/proj.git'
 
 This can happen, for example, if you:
 
-	- use `git reset --hard` to remove already-published commits, or
+	- use `git reset --hard` or `git reset --keep` to remove
+	  already-published commits, or
 	- use `git commit --amend` to replace already-published commits
 	  (as in <<fixing-a-mistake-by-rewriting-history>>), or
 	- use `git rebase` to rebase any already-published commits (as
@@ -2585,7 +2586,7 @@ patches, then reset the state to before the patches:
 
 -------------------------------------------------
 $ git format-patch origin
-$ git reset --hard origin
+$ git reset --keep origin
 -------------------------------------------------
 
 Then modify, reorder, or eliminate patches as preferred before applying
-- 
1.7.2.3.557.gab647.dirty
