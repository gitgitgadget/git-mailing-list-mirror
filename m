From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git init: activate rerere by default
Date: Thu, 5 Jul 2007 13:16:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707051312260.9789@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jul 05 14:16:22 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6QFu-0000X3-Qb
	for gcvg-git@gmane.org; Thu, 05 Jul 2007 14:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759282AbXGEMQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 08:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759228AbXGEMQQ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 08:16:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:38221 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757857AbXGEMQO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 08:16:14 -0400
Received: (qmail invoked by alias); 05 Jul 2007 12:16:13 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 05 Jul 2007 14:16:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX189Ab05ENI9YXhOlMQCgpsfwennoRrXP+POoUk5ng
	hdWPxJquScZMt1
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51672>


We have a working implementation of rerere since long ago, and we even
make sure that it works as expected in a test case.  It is also a very
useful feature, so why not turn it on for the benefit of users who are
not even aware of it? This patch does that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Maybe it is too late for 1.5.3? But maybe this is nice enough to 
	have in 1.5.3?

	BTW I shamelessly put in a comment to boost my comment ration on 
	ohloh.net...

 builtin-init-db.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 66ddaeb..aa3a01e 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -293,6 +293,9 @@ static int create_default_files(const char *git_dir, const char *git_work_tree,
 		if (git_work_tree)
 			git_config_set("core.worktree", git_work_tree);
 	}
+	/* activate rerere */
+	strcpy(path + len, "rr-cache");
+	safe_create_dir(path, 1);
 	return reinit;
 }
 
-- 
1.5.3.rc0.2689.g99ca2-dirty
