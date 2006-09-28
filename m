From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH/RFC] daemon: default to 256 for HOST_NAME_MAX if it is not
 defined
Date: Thu, 28 Sep 2006 12:00:35 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609281200200.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Sep 28 12:01:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSshe-0003bQ-R9
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 12:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965295AbWI1KAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 06:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965296AbWI1KAi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 06:00:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:47535 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965295AbWI1KAi (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Sep 2006 06:00:38 -0400
Received: (qmail invoked by alias); 28 Sep 2006 10:00:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp037) with SMTP; 28 Sep 2006 12:00:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27998>


Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
	... or should we make it wider available, by putting it into
	cache.h?

 daemon.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/daemon.c b/daemon.c
index 5335d21..fc3951c 100644
--- a/daemon.c
+++ b/daemon.c
@@ -15,6 +15,10 @@ #include "cache.h"
 #include "exec_cmd.h"
 #include "interpolate.h"
 
+#ifndef HOST_NAME_MAX
+#define HOST_NAME_MAX 256
+#endif
+
 static int log_syslog;
 static int verbose;
 static int reuseaddr;
-- 
1.4.2.1.g430572-dirty
