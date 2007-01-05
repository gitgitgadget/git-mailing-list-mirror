From: Michael Loeffler <zvpunry@zvpunry.de>
Subject: [PATCH] wt-status: remove use_add_msg in wt_status_print
Date: Fri, 05 Jan 2007 22:30:21 +0100
Message-ID: <1168032621.11130.36.camel@ibook.zvpunry.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jan 05 22:30:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2we2-00015N-Va
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 22:30:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbXAEVac (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 16:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbXAEVab
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 16:30:31 -0500
Received: from mx01.ap-wdsl.de ([88.198.184.82]:50503 "EHLO mx01.ap-wdsl.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbXAEVab (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 16:30:31 -0500
X-Greylist: delayed 2721 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 16:30:31 EST
To: git@vger.kernel.org
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36025>

If there is nothing to commit there is no need to say something about
adding files.

If there is something to commit or untracked or modified files, git
status will give this hint. In this case it is also redundant to say it
again.

Signed-off-by: Michael Loeffler <zvpunry@zvpunry.de>
---
 wt-status.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index db42738..019ec46 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -292,9 +292,7 @@ void wt_status_print(struct wt_status *s)
 	if (s->verbose && !s->is_initial)
 		wt_status_print_verbose(s);
 	if (!s->commitable)
-		printf("%s (%s)\n",
-			s->amend ? "# No changes" : "nothing to commit",
-			use_add_msg);
+		printf("%s\n", s->amend ? "# No changes" : "nothing to commit");
 }
 
 int git_status_config(const char *k, const char *v)
-- 
1.5.0.rc0.g1fa2
