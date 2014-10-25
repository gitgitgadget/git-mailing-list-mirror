From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove unnecessary DESTROY override
Date: Sat, 25 Oct 2014 08:01:34 +0000
Message-ID: <1414224094-32499-1-git-send-email-normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 20:41:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xi6Go-0005Io-TQ
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 20:40:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbaJYSky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2014 14:40:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:47560 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbaJYSkx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2014 14:40:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3583D1F665;
	Sat, 25 Oct 2014 08:01:48 +0000 (UTC)
X-Mailer: git-send-email 2.1.2.564.gaee7d04
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This override was probably never necessary, but most likely a no-op
as it does not appear to do anything in SVN::Ra itself.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 perl/Git/SVN/Ra.pm | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 1828519..e326849 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -177,10 +177,6 @@ sub get_dir {
 	wantarray ? (\%dirents, $r, $props) : \%dirents;
 }
 
-sub DESTROY {
-	# do not call the real DESTROY since we store ourselves in $RA
-}
-
 # get_log(paths, start, end, limit,
 #         discover_changed_paths, strict_node_history, receiver)
 sub get_log {
-- 
EW
