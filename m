From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/5] git-diff.txt: group the [--] and [<path>...] templates
Date: Wed, 24 Apr 2013 22:03:34 +0530
Message-ID: <1366821216-20868-4-git-send-email-artagnon@gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2dk-0007d0-CN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756877Ab3DXQdp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:33:45 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:57316 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756234Ab3DXQdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:33:44 -0400
Received: by mail-pa0-f47.google.com with SMTP id bj1so1292420pad.6
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=LJ8rFyOE/4sFTtEO8irqb6e6ngeEmc42KMNxjB4fwAA=;
        b=Maqyt1XbWGQodRAT7lAKg3QrWxvyCP8xsHkBA4p9Lt+S3OCfiXU/G/kDLLyRvGHQP4
         ixPSNGG29ZuU25qhS7TZ9VEqJDAa0VcJ019mqXW0x1/GuzJYetGeHY3hi6kr20AR0D+q
         nvtSU4X1UsHFxqmEOn5LUUnPBafG1Hbr8ia6+Ww7Jy1c+dZcivVeg0IIGqVpoLddY5U3
         NeCkDUbBt4+yrDfHc+5eDZ/n9YXqVSj0FVfVX7TFiOhTlVj6OGlJMGDwzZ5dJv7nb1yI
         2uCRozRVLmJ0O+FfTTmgiUgML3qtgCJCX+V78lmJeXRYCfLfOj5OkMPkSq86Ur4rPO+9
         uGvA==
X-Received: by 10.66.81.2 with SMTP id v2mr23845695pax.204.1366821223475;
        Wed, 24 Apr 2013 09:33:43 -0700 (PDT)
Received: from localhost.localdomain ([122.164.164.124])
        by mx.google.com with ESMTPSA id dr4sm3646798pbb.19.2013.04.24.09.33.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 24 Apr 2013 09:33:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.502.g2d60b5c
In-Reply-To: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222263>

Clarify that "--" is meant to disambiguate paths from the other
options.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/git-diff.txt | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 47aa3fc..a0fdfc2 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -9,11 +9,11 @@ git-diff - Show changes between commits, commit and working tree, etc
 SYNOPSIS
 --------
 [verse]
-'git diff' [options] [<commit>] [--] [<path>...]
-'git diff' [options] --cached [<commit>] [--] [<path>...]
+'git diff' [options] [<commit>] [[--] [<path>...]]
+'git diff' [options] --cached [<commit>] [[--] [<path>...]]
 'git diff' [options] <blob> <blob>
-'git diff' [options] <commit> <commit> [--] [<path>...]
-'git diff' [options] [--no-index] [--] <path> <path>
+'git diff' [options] <commit> <commit> [[--] [<path>...]]
+'git diff' [options] [--no-index] [[--] <path> <path>]
 
 DESCRIPTION
 -----------
@@ -21,7 +21,7 @@ Show changes between the working tree and the index or a tree, changes
 between the index and a tree, changes between two trees, or changes
 between two files on disk.
 
-'git diff' [options] [--] [<path>...]::
+'git diff' [options] [[--] [<path>...]]::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -33,7 +33,7 @@ If exactly two paths are given and at least one points outside
 the current repository, 'git diff' will compare the two files /
 directories. This behavior can be forced by --no-index.
 
-'git diff' [options] --cached [<commit>] [--] [<path>...]::
+'git diff' [options] --cached [<commit>] [[--] [<path>...]]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -43,7 +43,7 @@ directories. This behavior can be forced by --no-index.
 	<commit> is not given, it shows all staged changes.
 	--staged is a synonym of --cached.
 
-'git diff' [options] <commit> [--] [<path>...]::
+'git diff' [options] <commit> [[--] [<path>...]]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -56,18 +56,18 @@ directories. This behavior can be forced by --no-index.
 	This form is to view the differences between the raw
 	contents of two blob objects.
 
-'git diff' [options] <commit> <commit> [--] [<path>...]::
+'git diff' [options] <commit> <commit> [[--] [<path>...]]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
 
-'git diff' [options] <commit>..<commit> [--] [<path>...]::
+'git diff' [options] <commit>..<commit> [[--] [<path>...]]::
 
 	This is synonymous to the previous form.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using HEAD instead.
 
-'git diff' [options] <commit>\...<commit> [--] [<path>...]::
+'git diff' [options] <commit>\...<commit> [[--] [<path>...]]::
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
-- 
1.8.2.1.502.g2d60b5c
