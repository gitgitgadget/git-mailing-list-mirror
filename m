From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH 1/9] git-compat-util.h: Add missing semicolon after struct itimerval
Date: Fri, 29 Aug 2014 09:42:33 -0700
Message-ID: <1409330561-11806-1-git-send-email-jacob.e.keller@intel.com>
Cc: Jonas 'Sortie' Termansen <sortie@maxsi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 29 18:43:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNPH2-0007qr-Q4
	for gcvg-git-2@plane.gmane.org; Fri, 29 Aug 2014 18:43:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbaH2QnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2014 12:43:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:57264 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753159AbaH2QnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2014 12:43:22 -0400
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP; 29 Aug 2014 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,862,1389772800"; 
   d="scan'208";a="378757878"
Received: from jekeller-desk1.jf.intel.com (HELO jekeller-desk1.amr.corp.intel.com) ([134.134.173.156])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Aug 2014 09:38:37 -0700
X-Mailer: git-send-email 2.0.1.475.g9b8d714
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256155>

From: Jonas 'Sortie' Termansen <sortie@maxsi.org>

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
index f587749b7cf6..f7fae2060771 100644
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
2.0.1.475.g9b8d714
