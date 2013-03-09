From: Paul Campbell <pcampbell@kemitix.net>
Subject: [PATCH 08/19] fixing typo
Date: Sat, 9 Mar 2013 19:26:13 +0000
Message-ID: <CALeLG_kcJy4ksL5YVRpUoOvCTkS9J2WvDeT64fnb668H+X6pAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Michael Barr <b@rr-dav.id.au>, Kindjal <kindjal@gmail.com>,
	bibendi <bibendi@bk.ru>, Herman van Rink <rink@initfour.nl>,
	mhoffman <matt.hoffman@quantumretail.com>,
	Nate Jones <nate@endot.org>
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 09 20:26:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEPPk-0001hO-BN
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 20:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229Ab3CIT0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 14:26:14 -0500
Received: from mail-ob0-f181.google.com ([209.85.214.181]:61264 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab3CIT0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 14:26:13 -0500
Received: by mail-ob0-f181.google.com with SMTP id ni5so2215635obc.26
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 11:26:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:date:message-id:subject
         :from:to:cc:content-type:x-gm-message-state;
        bh=Yp91sD49PJBpO+YpzXAluRHBA24Qu/aWU/0bKLw0Nx8=;
        b=kmkwNCxEx8T52SIcRbsBKp00KZ+CLIXDI3143Va+9lNpy5D4do+oaXcjPL7Sb+8i5t
         eXzFD+VMdH9PjH0zUk98fw3a0T9M4NIHtvt/qQoWEPFQmLxJz4yzLrSHFi7InGDPTPwj
         5MeXF27VWuugMXXyLTdrAEC7LG5ebF9CfBuCmVGw8htlmrwkK1a6GtEaErC5LrhpDMeU
         rRJchjxN7IkJzVVoK8ChjX6+XoywuqUxLxrHNEaEeobdWUm/JpVaAQ2Nx5DeRtKe/+02
         bRkrwZvKENXH2xHrcSw6yTOB+X/k00Ci4JkmprUFmynxrZf86Ywv90+oD7X/4DN5PJkG
         ET5Q==
X-Received: by 10.60.10.34 with SMTP id f2mr5001499oeb.104.1362857173427; Sat,
 09 Mar 2013 11:26:13 -0800 (PST)
Received: by 10.76.122.109 with HTTP; Sat, 9 Mar 2013 11:26:13 -0800 (PST)
X-Originating-IP: [2.102.85.67]
X-Gm-Message-State: ALoCoQlNjZ+P1aeSceZBT8ya7DJzZKntqxttMwaKJq7Uj6hqHrkw2vYEPxc/uPymmhsFj2fMOPu5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217745>

>From 8f6eb2ddfcaef888dc3d3ea4d089aa2e9cad5d0f Mon Sep 17 00:00:00 2001
From: Paul Campbell <pcampbell@kemitix.net>
Date: Sat, 9 Mar 2013 18:32:53 +0000
Subject: [PATCH 08/19] fixing typo

Conflicts:
	git-subtree.sh

Add diff command

Original-Author: mhoffman <matt.hoffman@quantumretail.com>
Conflicts-resolved-by: Paul Campbell <pcampbell@kemitix.net>
---
 contrib/subtree/git-subtree.sh | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index ae9f87f..4c3f3c0 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -16,6 +16,7 @@ git subtree pull-all
 git subtree push-all
 git subtree push  --prefix=<prefix> <repository> <refspec...>
 git subtree split --prefix=<prefix> <commit...>
+git subtree diff  --prefix=<prefix> [<repository> [<refspec>...]]
 git subtree from-submodule --prefix=<prefix>
 --
 h,help        show the help
@@ -105,8 +106,8 @@ command="$1"
 shift
 case "$command" in
 	add|merge|pull|from-submodule|pull-all|push-all) default= ;;
-	split|push) default="--default HEAD" ;;
 	*) die "Unknown command '$command'" ;;
+    split|push|diff) default="--default HEAD" ;;
 esac

 if [ -z "$prefix" -a "$command" != "pull-all" -a "$command" !=
"push-all" ]; then
@@ -737,6 +738,37 @@ cmd_pull()
 	fi
 }

+cmd_diff()
+{
+    if [ -e "$dir" ]; then
+        if [ $# -eq 1 ]; then
+            repository=$(git config -f .gittrees subtree.$prefix.url)
+            refspec=$1
+        elif [ $# -eq 2 ]; then
+            repository=$1
+            refspec=$2
+        else
+            repository=$(git config -f .gittrees subtree.$prefix.url)
+            refspec=$(git config -f .gittrees subtree.$prefix.branch)
+        fi
+        # this is ugly, but I don't know of a better way to do it. My
git-fu is weak.
+        # git diff-tree expects a treeish, but I have only a
repository and branch name.
+        # I don't know how to turn that into a treeish without
creating a remote.
+        # Please change this if you know a better way!
+        tmp_remote=__diff-tmp
+        git remote rm $tmp_remote > /dev/null 2>&1
+        git remote add -t $refspec $tmp_remote $repository > /dev/null
+        # we fetch as a separate step so we can pass -q (quiet),
which isn't an option for "git remote"
+        # could this instead be "git fetch -q $repository $refspec"
and leave aside creating the remote?
+        # Still need a treeish for the diff-tree command...
+        git fetch -q $tmp_remote
+        git diff-tree -p refs/remotes/$tmp_remote/$refspec
+        git remote rm $tmp_remote > /dev/null 2>&1
+    else
+        die "Cannot resolve directory '$dir'. Please point to an
existing subtree directory to diff. Try 'git subtree add' to add a
subtree."
+    fi
+}
+
 cmd_push()
 {
 	if [ $# -gt 2 ]; then
-- 
1.8.2.rc1


-- 
Paul [W] Campbell
