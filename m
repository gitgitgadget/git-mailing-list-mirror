From: Jeff King <peff@peff.net>
Subject: [PATCH] git-push: allow pushing from subdirectories
Date: Tue, 8 Aug 2006 16:01:32 -0400
Message-ID: <20060808200132.GA26751@sigio.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 08 22:02:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAXlj-0003sF-UL
	for gcvg-git@gmane.org; Tue, 08 Aug 2006 22:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWHHUBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Aug 2006 16:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030282AbWHHUBg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Aug 2006 16:01:36 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:35791 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030283AbWHHUBf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Aug 2006 16:01:35 -0400
Received: (qmail 31284 invoked from network); 8 Aug 2006 16:01:00 -0400
Received: from unknown (HELO sigio.intra.peff.net) (10.0.0.10)
  by segfault.intra.peff.net with SMTP; 8 Aug 2006 16:01:00 -0400
Received: by sigio.intra.peff.net (sSMTP sendmail emulation); Tue,  8 Aug 2006 16:01:33 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25084>

The semantics are equivalent to pushing from the root; we just try harder to
find the .git directory.

Signed-off-by: Jeff King <peff@peff.net>
---
 git.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 6e72a89..18ba14a 100644
--- a/git.c
+++ b/git.c
@@ -229,7 +229,7 @@ static void handle_internal_command(int 
 		{ "log", cmd_log, NEEDS_PREFIX | USE_PAGER },
 		{ "whatchanged", cmd_whatchanged, NEEDS_PREFIX | USE_PAGER },
 		{ "show", cmd_show, NEEDS_PREFIX | USE_PAGER },
-		{ "push", cmd_push },
+		{ "push", cmd_push, NEEDS_PREFIX },
 		{ "format-patch", cmd_format_patch, NEEDS_PREFIX },
 		{ "count-objects", cmd_count_objects },
 		{ "diff", cmd_diff, NEEDS_PREFIX },
-- 
1.4.2.rc3.g07ef-dirty
