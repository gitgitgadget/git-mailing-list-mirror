From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] Fix tracing when GIT_TRACE is set to an empty string.
Date: Sat, 14 Oct 2006 16:05:25 +0200
Message-ID: <20061014160525.c013e6d2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 15:58:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYk2E-00065u-7h
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 15:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422640AbWJNN6j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 09:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422642AbWJNN6j
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 09:58:39 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51427 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1422640AbWJNN6i (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 09:58:38 -0400
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g19.free.fr (Postfix) with SMTP id DEB6C47E59;
	Sat, 14 Oct 2006 15:58:36 +0200 (CEST)
To: Junio Hamano <junkio@cox.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.20; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28879>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 trace.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/trace.c b/trace.c
index f9efc91..495e5ed 100644
--- a/trace.c
+++ b/trace.c
@@ -55,7 +55,8 @@ static int get_trace_fd(int *need_close)
 {
 	char *trace = getenv("GIT_TRACE");
 
-	if (!trace || !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+	if (!trace || !strcmp(trace, "") ||
+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
 		return 0;
 	if (!strcmp(trace, "1") || !strcasecmp(trace, "true"))
 		return STDERR_FILENO;
-- 
1.4.3.rc2.gadba
