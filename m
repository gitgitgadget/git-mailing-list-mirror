From: Lars Vogel <lars.vogel@vogella.com>
Subject: [PATCH] Documentation: read-tree consistent usage of working tree
Date: Mon, 17 Aug 2015 22:06:19 +0200
Message-ID: <1439841979-27110-1-git-send-email-Lars.Vogel@vogella.com>
Cc: Lars Vogel <Lars.Vogel@vogella.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 17 22:06:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQfy-00062F-7H
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 22:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbbHQUG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 16:06:29 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35001 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbHQUG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 16:06:29 -0400
Received: by wicne3 with SMTP id ne3so79051976wic.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 13:06:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3WnrFxPDXE2cICKCQNmh71XaEV7SSds64hMjocEcuEk=;
        b=GQNdgtIxvjAsYraIixMVvCcoNA7/U0wfHMQaUilY3dQWP705lcdtZpuDwAizu7nASy
         RDc3e7JTwRuoCJzArSeYCR7sT+xVH+D3DTnK9+OMYuuqMcaCKvwDKEgJlDbaX5O4MSAw
         VKQWOBxREYXjWHzJbfi1waaf+RsBZCmaEIpJsT9ExSfEj/HOj5+g8XKR0nvxPQOP5lqS
         mHa3+Yu4CMHpE7w4MxysFjXvptUoNLghuU9jkUdzbaliHrSfi1v/HwVdnX0/v5QQVMTE
         UcvCjxjVKf9IXb8Q3BVxvGtb1KUITFLhAUe3dK33AA06IeJb4GzjtWS2VH4cvdVpACnB
         OqXA==
X-Gm-Message-State: ALoCoQn8H+6yROH5OyRcnTNxrhYhCGqOsVtxDtyrbhglDaddfzY9hVc9yk3AZEuK8acByb8mVBoi
X-Received: by 10.180.198.48 with SMTP id iz16mr36726021wic.91.1439841988008;
        Mon, 17 Aug 2015 13:06:28 -0700 (PDT)
Received: from BigMachine.fritz.box (p5DC86C17.dip0.t-ipconnect.de. [93.200.108.23])
        by smtp.gmail.com with ESMTPSA id s7sm18128375wix.23.2015.08.17.13.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 17 Aug 2015 13:06:27 -0700 (PDT)
X-Google-Original-From: Lars Vogel <Lars.Vogel@vogella.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276089>

http://git-scm.com/docs/git-clone speaks only about working tree, the
usage of "working directory" for working tree is confusing. Working
directory describes the current directory while working tree describes
all files and sub directories.

Signed-off-by: Lars Vogel <Lars.Vogel@vogella.com>
---
 Documentation/git-read-tree.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index fa1d557..21daee9 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -378,15 +378,15 @@ have finished your work-in-progress), attempt the merge again.
 Sparse checkout
 ---------------
 
-"Sparse checkout" allows populating the working directory sparsely.
+"Sparse checkout" allows populating the working tree sparsely.
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
-Git whether a file in the working directory is worth looking at.
+Git whether a file in the working tree is worth looking at.
 
 'git read-tree' and other merge-based commands ('git merge', 'git
 checkout'...) can help maintaining the skip-worktree bitmap and working
 directory update. `$GIT_DIR/info/sparse-checkout` is used to
 define the skip-worktree reference bitmap. When 'git read-tree' needs
-to update the working directory, it resets the skip-worktree bit in the index
+to update the working tree, it resets the skip-worktree bit in the index
 based on this file, which uses the same syntax as .gitignore files.
 If an entry matches a pattern in this file, skip-worktree will not be
 set on that entry. Otherwise, skip-worktree will be set.
@@ -404,7 +404,7 @@ negate patterns. For example, to remove the file `unwanted`:
 !unwanted
 ----------------
 
-Another tricky thing is fully repopulating the working directory when you
+Another tricky thing is fully repopulating the working tree when you
 no longer want sparse checkout. You cannot just disable "sparse
 checkout" because skip-worktree bits are still in the index and your working
 directory is still sparsely populated. You should re-populate the working
-- 
2.5.0
