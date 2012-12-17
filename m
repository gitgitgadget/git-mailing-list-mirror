From: Chris Rorvick <chris@rorvick.com>
Subject: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Mon, 17 Dec 2012 00:45:01 -0600
Message-ID: <1355726702-27974-2-git-send-email-chris@rorvick.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
Cc: Chris Rorvick <chris@rorvick.com>,
	Andrew Ardill <andrew.ardill@gmail.com>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 17 07:46:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkUTO-0003Kl-Lf
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 07:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832Ab2LQGq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 01:46:29 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:32986 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2LQGq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 01:46:28 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5175615iay.19
        for <git@vger.kernel.org>; Sun, 16 Dec 2012 22:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=E80CuYlnPCK1ZE3s+wjOM8W30mAJr/yecpkLFwgFfjI=;
        b=dYFhuRfhpFbOp0JI/WF0cRejb2qmrO66dBnocYaEtMVEkG2j11lijf8YWmbupHYCNu
         xW7gJ8xuqW8dY/zQEoIUjo8WeeW0HNyx8qnGao0RL4A2Ho6Xin1PBJaUIQM/e/rR+aPU
         WDdKckP7M4g2BAqhL+g4IKYc5WaE6iZZD0EX0Aa+qjaumEszQ+GljF7Y0jY1UOkOvzPr
         iLbPOm4r12ne/CNRL0YbhRUybdSBgsrrhPyhCuf/aWKSI7y5KhRnkn18K6dtvQYaFj+e
         6jHCDObyK4LyITjKewdPfYMD8VgQFLmGlbwyBW5wzWN5l3QQFf84FCSsxKZzWZn2Hu7M
         tCRA==
Received: by 10.50.197.169 with SMTP id iv9mr8286753igc.32.1355726788469;
        Sun, 16 Dec 2012 22:46:28 -0800 (PST)
Received: from marlin.localdomain (adsl-70-131-98-170.dsl.emhril.sbcglobal.net. [70.131.98.170])
        by mx.google.com with ESMTPS id aa6sm5087935igc.14.2012.12.16.22.46.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 16 Dec 2012 22:46:27 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc1.203.g1ddc124
In-Reply-To: <1355726702-27974-1-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211638>

The forms of checkout that do not take a path are lumped together in the
DESCRIPTION section, but the description for this group is dominated by
explanation of the -b|-B form.  Split these apart for more clarity.

Signed-off-by: Chris Rorvick <chris@rorvick.com>
---
 Documentation/git-checkout.txt | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 7958a47..a47555c 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -22,17 +22,18 @@ also update `HEAD` to set the specified branch as the current
 branch.
 
 'git checkout' [<branch>]::
+
+	Update the index, working tree, and HEAD to reflect the
+	specified branch.
+
 'git checkout' -b|-B <new_branch> [<start point>]::
-'git checkout' [--detach] [<commit>]::
 
-	This form switches branches by updating the index, working
-	tree, and HEAD to reflect the specified branch or commit.
-+
-If `-b` is given, a new branch is created as if linkgit:git-branch[1]
-were called and then checked out; in this case you can
-use the `--track` or `--no-track` options, which will be passed to
-'git branch'.  As a convenience, `--track` without `-b` implies branch
-creation; see the description of `--track` below.
+	Specifying `-b` causes a new branch to be created as if
+	linkgit:git-branch[1] were called and then checked out.  In
+	this case you can use the `--track` or `--no-track` options,
+	which will be passed to 'git branch'.  As a convenience,
+	`--track` without `-b` implies branch creation; see the
+	description of `--track` below.
 +
 If `-B` is given, <new_branch> is created if it doesn't exist; otherwise, it
 is reset. This is the transactional equivalent of
@@ -45,6 +46,13 @@ $ git checkout <branch>
 that is to say, the branch is not reset/created unless "git checkout" is
 successful.
 
+'git checkout' [--detach] [<commit>]::
+
+	Update the index and working tree to reflect the specified
+	commit and set HEAD to point directly to <commit> (see
+	"DETACHED HEAD" section.)  Passing `--detach` forces this
+	behavior even if <commit> is a branch.
+
 'git checkout' [-p|--patch] [<tree-ish>] [--] <pathspec>...::
 
 	When <paths> or `--patch` are given, 'git checkout' does *not*
-- 
1.8.1.rc1.203.g1ddc124
