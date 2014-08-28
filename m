From: Jonas 'Sortie' Termansen <sortie@maxsi.org>
Subject: [PATCH 1/9] git-compat-util.h: Add missing semicolon after struct itimerval
Date: Thu, 28 Aug 2014 03:04:14 +0200
Message-ID: <1409187862-21257-2-git-send-email-sortie@maxsi.org>
References: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 28 03:11:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMoFd-00025w-HX
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 03:11:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbaH1BLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 21:11:31 -0400
Received: from csmtp7.one.com ([195.47.247.107]:59568 "EHLO csmtp7.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbaH1BL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 21:11:26 -0400
Received: from localhost.localdomain (0133301021.0.fullrate.dk [95.166.189.26])
	by csmtp7.one.com (Postfix) with ESMTPA id 3F8B840001D64;
	Thu, 28 Aug 2014 01:06:13 +0000 (UTC)
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1409187862-21257-1-git-send-email-sortie@maxsi.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256062>

This hasn't been a problem in practice as almost all systems have the
setitimer() API (or it is provided by git in the case of mingw). This code
wasn't used in any default circumstances, as the build system never sets
NO_STRUCT_ITIMERVAL - this breakage only occured if the user asked for it.

We repair this case so we can rely on it in the following commits.

Signed-off-by: Jonas 'Sortie' Termansen <sortie@maxsi.org>
---
 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index f587749..f7fae20 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -191,7 +191,7 @@ extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 struct itimerval {
 	struct timeval it_interval;
 	struct timeval it_value;
-}
+};
 #endif
 
 #ifdef NO_SETITIMER
-- 
2.1.0
