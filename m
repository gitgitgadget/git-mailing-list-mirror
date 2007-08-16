From: Brian Downing <bdowning@lavos.net>
Subject: [PATCH] Clarify actual behavior of 'git add' and ignored files
Date: Thu, 16 Aug 2007 17:56:08 -0500
Message-ID: <11873049683651-git-send-email-bdowning@lavos.net>
Cc: git@vger.kernel.org, Brian Downing <bdowning@lavos.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 00:56:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILoG8-0000Ly-PS
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 00:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760665AbXHPW4F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 18:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759602AbXHPW4D
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 18:56:03 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:30427 "EHLO
	asav00.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755580AbXHPW4B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 18:56:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AglXAKRyxEZKhvbzRmdsb2JhbACBVIUmhxgBAQE1AZMa
X-IronPort-AV: E=Sophos;i="4.19,273,1183348800"; 
   d="scan'208";a="67157531"
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav00.insightbb.com with ESMTP; 16 Aug 2007 18:55:59 -0400
Received: from silvara (silvara.lavos.net [10.4.0.20])
	by mail.lavos.net (Postfix) with ESMTP id 1104D309F30;
	Thu, 16 Aug 2007 17:55:50 -0500 (CDT)
Received: by silvara (Postfix, from userid 1000)
	id B828D5012D; Thu, 16 Aug 2007 17:56:08 -0500 (CDT)
X-Mailer: git-send-email 1.5.3.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56034>

Signed-off-by: Brian Downing <bdowning@lavos.net>
---
 Documentation/git-add.txt |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index dee38f8..3383aca 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -28,10 +28,12 @@ you must run 'git add' again to add the new content to the index.
 The 'git status' command can be used to obtain a summary of which
 files have changes that are staged for the next commit.
 
-The 'add' command can be used to add ignored files with `-f` (force)
-option, but they have to be explicitly and exactly specified from the
-command line.  File globbing and recursive behaviour do not add ignored
-files.
+The 'git add' command will not add ignored files by default.  If any
+ignored files were explicitly specified on the command line, 'git add'
+will fail with a list of ignored files.  Ignored files reached by
+directory recursion or filename globbing will be silently ignored.
+The 'add' command can be used to add ignored files with the `-f`
+(force) option.
 
 Please see gitlink:git-commit[1] for alternative ways to add content to a
 commit.
-- 
1.5.3.GIT
