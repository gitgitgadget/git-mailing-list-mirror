X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 4/5] am: run git rerere to record resolution on successful --resolved
Date: Fri,  8 Dec 2006 02:49:29 -0800
Message-ID: <11655749761154-git-send-email-normalperson@yhbt.net>
References: <20061205092126.GE27236@soma>
NNTP-Posting-Date: Fri, 8 Dec 2006 10:49:57 +0000 (UTC)
Cc: Eric Wong <normalperson@yhbt.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: git-send-email 1.4.4.2.g860f4
In-Reply-To: <20061205092126.GE27236@soma>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33685>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsdIe-0003Cg-Jq for gcvg-git@gmane.org; Fri, 08 Dec
 2006 11:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1425352AbWLHKtl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 05:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425350AbWLHKtl
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 05:49:41 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47168 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1425354AbWLHKth
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 05:49:37 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 228E82DC08A; Fri,  8 Dec 2006 02:49:36 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri,  8 Dec 2006
 02:49:36 -0800
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-am.sh |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 179b967..d0714c6 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -414,6 +414,10 @@ do
 			stop_here_user_resolve $this
 		fi
 		apply_status=0
+		if test -d "$GIT_DIR/rr-cache"
+		then
+			git rerere
+		fi
 		;;
 	esac
 
-- 
1.4.4.2.g860f4
