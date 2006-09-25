From: fork0@t-online.de (Alex Riesen)
Subject: [PATCH] Use const for interpolate arguments
Date: Mon, 25 Sep 2006 23:19:00 +0200
Message-ID: <20060925211900.GB6125@steel.home>
References: <E1GPqwJ-0002xt-Bt@jdl.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Loeliger <jdl@jdl.com>
X-From: git-owner@vger.kernel.org Mon Sep 25 23:19:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRxrH-0007Z3-El
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 23:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWIYVTV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 17:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWIYVTV
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 17:19:21 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:14981 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751006AbWIYVTU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 17:19:20 -0400
Received: from fwd33.aul.t-online.de 
	by mailout02.sul.t-online.com with smtp 
	id 1GRxr8-0000FB-02; Mon, 25 Sep 2006 23:19:14 +0200
Received: from tigra.home (SmJQbsZ6reH-Rw0Up1TLhn7DuXLP39m9kt0VkV-FtyQVbKkckLX7cF@[84.160.85.62]) by fwd33.sul.t-online.de
	with esmtp id 1GRxqu-1KVDm40; Mon, 25 Sep 2006 23:19:00 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 39F76277AF;
	Mon, 25 Sep 2006 23:19:00 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GRxqu-00076D-4C; Mon, 25 Sep 2006 23:19:00 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <E1GPqwJ-0002xt-Bt@jdl.com>
User-Agent: Mutt/1.5.11
X-ID: SmJQbsZ6reH-Rw0Up1TLhn7DuXLP39m9kt0VkV-FtyQVbKkckLX7cF
X-TOI-MSGID: fb627653-c1c9-42bc-af50-0ed07e233786
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27755>

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>

---

Resending. jdl.com blacklisted my IP, for whatever it has done to him.

 interpolate.c |    6 +++---
 interpolate.h |    9 +++++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/interpolate.c b/interpolate.c
index d82f1b5..4570c12 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -25,10 +25,10 @@ #include "interpolate.h"
  */
 
 int interpolate(char *result, int reslen,
-		char *orig,
-		struct interp *interps, int ninterps)
+		const char *orig,
+		const struct interp *interps, int ninterps)
 {
-	char *src = orig;
+	const char *src = orig;
 	char *dest = result;
 	int newlen = 0;
 	char *name, *value;
diff --git a/interpolate.h b/interpolate.h
index 00c63a5..d16f924 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -5,6 +5,11 @@
 #ifndef INTERPOLATE_H
 #define INTERPOLATE_H
 
+/*
+ * Convert a NUL-terminated string in buffer orig,
+ * performing substitutions on %-named sub-strings from
+ * the interpretation table.
+ */
 
 struct interp {
 	char *name;
@@ -12,7 +17,7 @@ struct interp {
 };
 
 extern int interpolate(char *result, int reslen,
-		       char *orig,
-		       struct interp *interps, int ninterps);
+		       const char *orig,
+		       const struct interp *interps, int ninterps);
 
 #endif /* INTERPOLATE_H */
-- 
1.4.2.1.g6b47-dirty
