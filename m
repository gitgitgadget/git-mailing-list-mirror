From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 4/4] Rename daemon.c's lognotice() to loginfo()
Date: Sat, 24 Sep 2005 16:13:03 +0200
Message-ID: <20050924141303.8423.54292.stgit@machine.or.cz>
References: <20050924141254.8423.80265.stgit@machine.or.cz>
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 24 16:15:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJAmM-0002Hw-1D
	for gcvg-git@gmane.org; Sat, 24 Sep 2005 16:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbVIXONH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Sep 2005 10:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVIXONG
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Sep 2005 10:13:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:5572 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932182AbVIXONF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2005 10:13:05 -0400
Received: (qmail 8524 invoked from network); 24 Sep 2005 16:13:03 +0200
Received: from localhost (HELO machine.or.cz) (127.0.0.1)
  by localhost with SMTP; 24 Sep 2005 16:13:03 +0200
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <20050924141254.8423.80265.stgit@machine.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9236>

The syslog code logs with severity LOG_INFO in the loginfo() function, so make
things less confusing.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 daemon.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/daemon.c b/daemon.c
--- a/daemon.c
+++ b/daemon.c
@@ -59,7 +59,7 @@ void logerror(const char *err, ...)
 	va_end(params);
 }
 
-void lognotice(const char *err, ...)
+void loginfo(const char *err, ...)
 {
 	va_list params;
 	if (!verbose)
@@ -72,7 +72,7 @@ void lognotice(const char *err, ...)
 
 static int upload(char *dir, int dirlen)
 {
-	lognotice("Request for '%s'", dir);
+	loginfo("Request for '%s'", dir);
 	if (chdir(dir) < 0) {
 		logerror("Cannot chdir('%s'): %s", dir, strerror(errno));
 		return -1;
@@ -284,7 +284,7 @@ static void handle(int incoming, struct 
 
 		port = sin6_addr->sin6_port;
 	}
-	lognotice("Connection from %s:%d", addrbuf, port);
+	loginfo("Connection from %s:%d", addrbuf, port);
 
 	exit(execute());
 }
