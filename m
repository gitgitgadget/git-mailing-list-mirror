X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
Subject: [PATCH] Use git-rev-parse --git-dir to determine GIT_DIR
Date: Thu, 30 Nov 2006 17:45:43 +0100
Message-ID: <20061130164543.GA11073@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 30 Nov 2006 16:47:13 +0000 (UTC)
Cc: Paul Mackerras <paulus@samba.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32775>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gpp3e-0006qX-Sj for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759270AbWK3Qqo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759271AbWK3Qqo
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:46:44 -0500
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:38542
 "HELO mail.hofmann.stw.uni-erlangen.de") by vger.kernel.org with SMTP id
 S1759270AbWK3Qqn (ORCPT <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006
 11:46:43 -0500
Received: (qmail 8114 invoked by uid 0); 30 Nov 2006 16:46:40 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost)
 (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135) by
 mail.hofmann.stw.uni-erlangen.de with SMTP; 30 Nov 2006 16:46:40 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Signed-off-by: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
---
 gitk |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index ab383b3..60f8212 100755
--- a/gitk
+++ b/gitk
@@ -8,12 +8,7 @@ exec wish "$0" -- "$@"
 # either version 2, or (at your option) any later version.
 
 proc gitdir {} {
-    global env
-    if {[info exists env(GIT_DIR)]} {
-	return $env(GIT_DIR)
-    } else {
-	return ".git"
-    }
+    return [exec git rev-parse --git-dir]
 }
 
 proc start_rev_list {view} {
-- 
1.4.3.3
