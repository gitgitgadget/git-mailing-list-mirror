X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 6/5] git-rerere: document the 'clear' and 'diff' commands
Date: Fri, 8 Dec 2006 12:04:27 -0800
Message-ID: <20061208200427.GA17602@soma>
References: <20061205092126.GE27236@soma> <11655749724034-git-send-email-normalperson@yhbt.net> <7vbqmei3nx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 20:04:51 +0000 (UTC)
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vbqmei3nx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33734>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GslxV-00058D-8a for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:04:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1426251AbWLHUEb (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1426288AbWLHUEb
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:04:31 -0500
Received: from hand.yhbt.net ([66.150.188.102]:48007 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1426287AbWLHUE3
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 15:04:29 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 53B722DC034; Fri,  8 Dec 2006 12:04:27 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 12:04:27 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/git-rerere.txt |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 8b6b651..de65cce 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -7,8 +7,7 @@ git-rerere - Reuse recorded resolve
 
 SYNOPSIS
 --------
-'git-rerere'
-
+'git-rerere' [clear|diff]
 
 DESCRIPTION
 -----------
@@ -167,6 +166,25 @@ would conflict the same way the test merge you resolved earlier.
 `git-rerere` is run by `git rebase` to help you resolve this
 conflict.
 
+COMMANDS
+--------
+
+Normally, git-rerere is run without arguments or user-intervention.
+However, it has several commands that allow it to interact with
+its working state.
+
+'clear'::
+
+This resets the metadata used by rerere if a merge resolution is to be
+is aborted.  Calling gitlink:git-am[1] --skip or gitlink:git-rebase[1]
+[--skip|--abort] will automatcally invoke this command.
+
+'diff'::
+
+This displays diffs for the current state of the resolution.  It is
+useful for tracking what has changed while the user is resolving
+conflicts.  Additional arguments are passed directly to the system
+diff(1) command installed in PATH.
 
 Author
 ------
-- 
1.4.4.2.g860f4
