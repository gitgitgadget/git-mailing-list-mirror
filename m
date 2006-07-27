From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/6] merge-recur: Fix compiler warning with -pedantic
Date: Thu, 27 Jul 2006 19:13:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271913140.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Jul 27 19:13:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G69QP-0002OT-G0
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 19:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWG0RN0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 13:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbWG0RN0
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 13:13:26 -0400
Received: from mail.gmx.de ([213.165.64.21]:6306 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751796AbWG0RNZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 13:13:25 -0400
Received: (qmail invoked by alias); 27 Jul 2006 17:13:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 27 Jul 2006 19:13:24 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24311>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 9a86cdb..645ef8c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -642,7 +642,7 @@ static struct merge_file_info merge_file
 			char src2[PATH_MAX];
 			const char *argv[] = {
 				"merge", "-L", NULL, "-L", NULL, "-L", NULL,
-				src1, orig, src2,
+				NULL, NULL, NULL,
 				NULL
 			};
 			char *la, *lb, *lo;
@@ -654,6 +654,9 @@ static struct merge_file_info merge_file
 			argv[2] = la = strdup(mkpath("%s/%s", branch1Name, a->path));
 			argv[6] = lb = strdup(mkpath("%s/%s", branch2Name, b->path));
 			argv[4] = lo = strdup(mkpath("orig/%s", o->path));
+			argv[7] = src1;
+			argv[8] = orig;
+			argv[9] = src2,
 
 			code = run_command_v(10, argv);
 
-- 
1.4.2.rc2.g6a4e
