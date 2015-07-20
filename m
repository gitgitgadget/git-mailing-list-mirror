From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 4/5] Documentation/git-worktree: wordsmith worktree-related manpages
Date: Mon, 20 Jul 2015 01:29:21 -0400
Message-ID: <1437370162-8031-5-git-send-email-sunshine@sunshineco.com>
References: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 07:29:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZH3eI-0008Ex-OG
	for gcvg-git-2@plane.gmane.org; Mon, 20 Jul 2015 07:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbbGTF3x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 01:29:53 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34969 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbbGTF3t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 01:29:49 -0400
Received: by iecri3 with SMTP id ri3so15481483iec.2
        for <git@vger.kernel.org>; Sun, 19 Jul 2015 22:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kR3k0n3oT5fN6+L0coq692udAnJEtTu2mm304GAuIU8=;
        b=XUs+7LZQTameL//zF8IunUki++LKS6+vBscXqI2yEWhGwUKXu8QG+JPb8r+AMpm/gu
         eEmN0dCMQrwmleyTNdI5ii1T509axMNulUbLaC5B8LzHEkslCO6R50iJ8MpjeZR5TOCz
         vXaRdAthjGwiks5Bu3zmg0sq14hHBd55XtEit+KPfG0fpCMnWzeJkR1qkbOKX+xnDRXq
         tak27J6lsDj9o3cNsqPst3SR2LS9REUUMwEl/CqoqDqf+QkkNA25CEg+WTDWFd+godEx
         l9ZRjtQMpRDRtTXX1H1cN4Dhosl6L9pda/OuxxCBjT+Fs/XIHOcGt71C6w8haY6no5BI
         LFWw==
X-Received: by 10.107.128.214 with SMTP id k83mr34996068ioi.7.1437370188794;
        Sun, 19 Jul 2015 22:29:48 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by smtp.gmail.com with ESMTPSA id j83sm13104584iod.25.2015.07.19.22.29.47
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2015 22:29:48 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.rc2.386.g87d813d
In-Reply-To: <1437370162-8031-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274310>

From: Michael Haggerty <mhagger@alum.mit.edu>

[es: reword .git/worktrees and .git/worktrees/<id>/locked descriptions]

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/config.txt               |  8 ++++----
 Documentation/gitrepository-layout.txt | 16 ++++++++--------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 7f65dbb..10bc351 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1292,11 +1292,11 @@ gc.pruneExpire::
 	unreachable objects immediately.
 
 gc.pruneWorktreesExpire::
-	When 'git gc' is run, it will call
+	When 'git gc' is run, it calls
 	'git worktree prune --expire 3.months.ago'.
-	Override the grace period with this config variable. The value
-	"now" may be used to disable the grace period and prune
-	$GIT_DIR/worktrees immediately.
+	This config variable can be used to set a different grace
+	period. The value "now" may be used to disable the grace
+	period and prune $GIT_DIR/worktrees immediately.
 
 gc.reflogExpire::
 gc.<pattern>.reflogExpire::
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index b53979c..577ee84 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -251,25 +251,25 @@ modules::
 	Contains the git-repositories of the submodules.
 
 worktrees::
-	Contains working tree specific information of linked
+	Contains administrative data for linked
 	working trees. Each subdirectory contains the working tree-related
 	part of a linked working tree. This directory is ignored if
-	$GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/worktrees" will be
-	used instead.
+	$GIT_COMMON_DIR is set, in which case
+	"$GIT_COMMON_DIR/worktrees" will be used instead.
 
 worktrees/<id>/gitdir::
 	A text file containing the absolute path back to the .git file
 	that points to here. This is used to check if the linked
 	repository has been manually removed and there is no need to
-	keep this directory any more. mtime of this file should be
+	keep this directory any more. The mtime of this file should be
 	updated every time the linked repository is accessed.
 
 worktrees/<id>/locked::
 	If this file exists, the linked working tree may be on a
-	portable device and not available. It does not mean that the
-	linked working tree is gone and `worktrees/<id>` could be
-	removed. The file's content contains a reason string on why
-	the repository is locked.
+	portable device and not available. The presence of this file
+	prevents `worktrees/<id>` from being pruned either automatically
+	or manually by `git worktree prune`. The file may contain a string
+	explaining why the repository is locked.
 
 worktrees/<id>/link::
 	If this file exists, it is a hard link to the linked .git
-- 
2.5.0.rc2.386.g87d813d
