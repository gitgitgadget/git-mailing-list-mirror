From: Keshav Kini <keshav.kini@gmail.com>
Subject: [PATCH v2 3/4] git-svn.txt: replace .git with $GIT_DIR
Date: Sun, 29 Sep 2013 18:45:59 -0500
Message-ID: <1380498360-18387-4-git-send-email-keshav.kini@gmail.com>
References: <1379971145-8971-1-git-send-email-keshav.kini@gmail.com>
 <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Cc: Eric Wong <normalperson@yhbt.net>,
	Keshav Kini <keshav.kini@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 30 01:46:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQQhI-0000Ss-IR
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 01:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab3I2Xqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Sep 2013 19:46:40 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:62924 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab3I2Xqj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Sep 2013 19:46:39 -0400
Received: by mail-ob0-f181.google.com with SMTP id gq1so4517634obb.40
        for <git@vger.kernel.org>; Sun, 29 Sep 2013 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FAuBN7jM8q7x7hRxj8dSPSKxS2izV7aQELmLgo/k7Z0=;
        b=kABgua+vo9zc0LzrnYtnphf8VRtcOnJ3Mifn+CMiZHrIo2y+RkR5aVodAS4vjO4f6P
         CwpJqvjoDb55waq61fRVEpimcQK+FutMokIDeLbgMSsIfWFfmOtGCKf9CE31OxDyeBvK
         DMe8GaxuAs4ajglS0Mjwkxr+6V4h2x2rSavEYgo7zoBg2598m9flPaDYnI//f+jPGQ20
         FmJ0im5lEg7loTNlm/ePVRATb1RMdaBjsWO6jHCKixsdxr+LtgCYQH10dpnwuAOF6mwz
         FSvgUHnHFqfTX2nUSV8Wa2KDUH7ZfP/gFW6VMSA3tUcAb0wxpuEB2b4QVIsL6l6MsYqz
         rXPA==
X-Received: by 10.182.60.194 with SMTP id j2mr16948280obr.2.1380498398178;
        Sun, 29 Sep 2013 16:46:38 -0700 (PDT)
Received: from localhost (cpe-72-179-6-119.austin.res.rr.com. [72.179.6.119])
        by mx.google.com with ESMTPSA id rl1sm33229262oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 29 Sep 2013 16:46:37 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
In-Reply-To: <1380498360-18387-1-git-send-email-keshav.kini@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235611>

As $GIT_DIR may not equal '.git', it's usually more generally correct to
refer to files in $GIT_DIR rather than in .git .

This will also allow me to link some of the occurrences of '.git' in
git-svn.txt to a new reference target inside this file in an upcoming
commit, because in AsciiDoc definitions apparently can't start with
a '.' character.

Signed-off-by: Keshav Kini <keshav.kini@gmail.com>
---
 Documentation/git-svn.txt | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 62ec727..3ddf545 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -104,8 +104,8 @@ COMMANDS
 'fetch'::
 	Fetch unfetched revisions from the Subversion remote we are
 	tracking.  The name of the [svn-remote "..."] section in the
-	.git/config file may be specified as an optional command-line
-	argument.
+	$GIT_DIR/config file may be specified as an optional
+	command-line argument.
 
 --localtime;;
 	Store Git commit times in the local timezone instead of UTC.  This
@@ -684,7 +684,7 @@ svn-remote.<name>.noMetadata::
 +
 This option can only be used for one-shot imports as 'git svn'
 will not be able to fetch again without metadata. Additionally,
-if you lose your .git/svn/\*\*/.rev_map.* files, 'git svn' will not
+if you lose your $GIT_DIR/svn/\*\*/.rev_map.* files, 'git svn' will not
 be able to rebuild them.
 +
 The 'git svn log' command will not work on repositories using
@@ -977,8 +977,8 @@ When using multiple --branches or --tags, 'git svn' does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
 use 'init' to set up your Git repository then, before your first 'fetch', edit
-the .git/config file so that the branches and tags are associated with
-different name spaces.  For example:
+the $GIT_DIR/config file so that the branches and tags are associated
+with different name spaces.  For example:
 
 	branches = stable/*:refs/remotes/svn/stable/*
 	branches = debug/*:refs/remotes/svn/debug/*
@@ -1006,7 +1006,7 @@ CONFIGURATION
 -------------
 
 'git svn' stores [svn-remote] configuration information in the
-repository .git/config file.  It is similar the core Git
+repository $GIT_DIR/config file.  It is similar the core Git
 [remote] sections except 'fetch' keys do not accept glob
 arguments; but they are instead handled by the 'branches'
 and 'tags' keys.  Since some SVN repositories are oddly
@@ -1060,8 +1060,8 @@ $ git svn branch -d branches/server release-2-3-0
 
 Note that git-svn keeps track of the highest revision in which a branch
 or tag has appeared. If the subset of branches or tags is changed after
-fetching, then .git/svn/.metadata must be manually edited to remove (or
-reset) branches-maxRev and/or tags-maxRev as appropriate.
+fetching, then $GIT_DIR/svn/.metadata must be manually edited to remove
+(or reset) branches-maxRev and/or tags-maxRev as appropriate.
 
 SEE ALSO
 --------
-- 
1.8.3.2
