From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: don't check for migrations/upgrades on commit-diff
Date: Sat, 15 Jul 2006 07:10:56 -0700
Message-ID: <11529726563833-git-send-email-normalperson@yhbt.net>
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jul 15 16:11:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1krI-0006Tj-NK
	for gcvg-git@gmane.org; Sat, 15 Jul 2006 16:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946049AbWGOOLA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Jul 2006 10:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946052AbWGOOLA
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Jul 2006 10:11:00 -0400
Received: from hand.yhbt.net ([66.150.188.102]:40084 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1946049AbWGOOK7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jul 2006 10:10:59 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6CE157DC022;
	Sat, 15 Jul 2006 07:10:56 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 15 Jul 2006 07:10:56 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.gb805
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23935>

Unlike other git-svn commands, commit-diff is intended to
operate without needing any additional metadata inside .git

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 4530ffe..89ad840 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -147,7 +147,7 @@ init_vars();
 load_authors() if $_authors;
 load_all_refs() if $_branch_all_refs;
 svn_compat_check() unless $_use_lib;
-migration_check() unless $cmd =~ /^(?:init|rebuild|multi-init)$/;
+migration_check() unless $cmd =~ /^(?:init|rebuild|multi-init|commit-diff)$/;
 $cmd{$cmd}->[0]->(@ARGV);
 exit 0;
 
-- 
1.4.1.gb805
