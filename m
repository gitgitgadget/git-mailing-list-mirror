From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH] symlinks.c: small style cleanup
Date: Sun, 07 Jun 2009 13:33:05 +0200
Message-ID: <1244374385-5253-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 07 13:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDGdv-0002y4-0x
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 13:34:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbZFGLeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 07:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbZFGLeO
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 07:34:14 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:55298 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbZFGLeO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 07:34:14 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KKV000Q19H3LOA0@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 07 Jun 2009 13:34:15 +0200 (CEST)
Received: from localhost.localdomain ([80.202.166.56])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KKV009P39H2EJ30@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 07 Jun 2009 13:34:15 +0200 (CEST)
X-Mailer: git-send-email 1.6.3.2.277.gd10543
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120966>

Add {}-braces around an else-part, where the if-part already has
{}-braces.

And, also remove some unnecessary "return;"-statements at the end of
"void foo()"-functions.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 symlinks.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/symlinks.c b/symlinks.c
index 1d6b35b..8dcd632 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -196,8 +196,9 @@ void invalidate_lstat_cache(const char *name, int len)
 			cache.path[previous_slash] = '\0';
 			cache.len = previous_slash;
 			cache.flags = FL_DIR;
-		} else
+		} else {
 			reset_lstat_cache();
+		}
 	}
 }
 
@@ -263,7 +264,6 @@ static void do_remove_scheduled_dirs(int new_len)
 			 removal.path[removal.len] != '/');
 	}
 	removal.len = new_len;
-	return;
 }
 
 void schedule_dir_for_removal(const char *name, int len)
@@ -296,11 +296,9 @@ void schedule_dir_for_removal(const char *name, int len)
 		       last_slash - match_len);
 		removal.len = last_slash;
 	}
-	return;
 }
 
 void remove_scheduled_dirs(void)
 {
 	do_remove_scheduled_dirs(0);
-	return;
 }
-- 
1.6.3.2.277.gd10543
