X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] git-clone: Rename --use-immingled-remote option to --no-separate-remote
Date: Mon, 27 Nov 2006 00:22:29 +0100
Message-ID: <11645833492897-git-send-email-jnareb@gmail.com>
NNTP-Posting-Date: Sun, 26 Nov 2006 23:20:56 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:x-mailer;
        b=DQA7DQKBzEBOaCXek+BXxWZAIoaaBr5RmFRbc0UXqEoVcIEhXJpHsKOZhO1Q2lkWHGmTNdBvubyj+Gn7vc5L6tgqRtdCUl6QvHsNXW+j7RHHoCFk3CZRYQ98fTL4acBBPMe1sfvy7KZaVf05XMVfixnzJ8g6oMZfFtveoX8Qu9k=
X-Mailer: git-send-email 1.4.4.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32370>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoTIp-0006OX-TK for gcvg-git@gmane.org; Mon, 27 Nov
 2006 00:20:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754709AbWKZXUt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 18:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755102AbWKZXUt
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 18:20:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:2606 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755122AbWKZXUs
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 18:20:48 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1004198uga for
 <git@vger.kernel.org>; Sun, 26 Nov 2006 15:20:46 -0800 (PST)
Received: by 10.67.22.14 with SMTP id z14mr11221923ugi.1164583246470; Sun, 26
 Nov 2006 15:20:46 -0800 (PST)
Received: from roke.D-201 ( [81.190.24.209]) by mx.google.com with ESMTP id
 54sm17987288ugp.2006.11.26.15.20.45; Sun, 26 Nov 2006 15:20:45 -0800 (PST)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1]) by roke.D-201
 (8.13.4/8.13.4) with ESMTP id kAQNMVWi018169; Mon, 27 Nov 2006 00:22:31 +0100
Received: (from jnareb@localhost) by roke.D-201 (8.13.4/8.13.4/Submit) id
 kAQNMTxU018168; Mon, 27 Nov 2006 00:22:29 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-clone.txt |    4 ++--
 git-clone.sh                |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4cb4223..d5efa00 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--use-separate-remote | --use-immingled-remote] <repository>
+	  [--use-separate-remote | --no-separate-remote] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -105,7 +105,7 @@ OPTIONS
 	of `$GIT_DIR/refs/heads/`.  Only the local master branch is
 	saved in the latter. This is the default.
 
---use-immingled-remote::
+--no-separate-remote::
 	Save remotes heads in the same namespace as the local
 	heads, `$GIT_DIR/refs/heads/'.  In regular repositories,
 	this is a legacy setup git-clone created by default in
diff --git a/git-clone.sh b/git-clone.sh
index d4ee93f..8964039 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--use-immingled-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--no-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -140,7 +140,7 @@ while
 	*,--use-separate-remote)
 		# default
 		use_separate_remote=t ;;
-	*,--use-immingled-remote)
+	*,--no-separate-remote)
 		use_separate_remote= ;;
 	1,--reference) usage ;;
 	*,--reference)
@@ -176,7 +176,7 @@ repo="$1"
 test -n "$repo" ||
     die 'you must specify a repository to clone.'
 
-# --bare implies --no-checkout and --use-immingled-remote
+# --bare implies --no-checkout and --no-separate-remote
 if test yes = "$bare"
 then
 	if test yes = "$origin_override"
-- 
1.4.4.1
