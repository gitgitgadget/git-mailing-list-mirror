From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Support custom build options in config.mak
Date: Tue, 11 Oct 2005 09:49:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510110948170.19774@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Oct 11 09:51:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPEtT-0000cg-N2
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 09:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVJKHto (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 03:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVJKHto
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 03:49:44 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:60103 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751406AbVJKHto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 03:49:44 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3847A13EFF3; Tue, 11 Oct 2005 09:49:43 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2160D9E490; Tue, 11 Oct 2005 09:49:43 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0777C9E48D; Tue, 11 Oct 2005 09:49:43 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B569913EFF3; Tue, 11 Oct 2005 09:49:42 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9960>

With this patch, it is possible to store configuration options like
NO_CURL=YesPlease or NO_OPENSSL=YesPlease into a file named
config.mak, which will be included in the Makefile.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Makefile |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

applies-to: 1abfad3540e705eb33e589a8e8cf2be781c89030
94ca33678ce4f582d9bcbaa7baf9223e026c0b13
diff --git a/Makefile b/Makefile
index ea4332b..4e2fa7e 100644
--- a/Makefile
+++ b/Makefile
@@ -213,6 +213,10 @@ ifneq (,$(findstring arm,$(uname_M)))
 	ARM_SHA1 = YesPlease
 endif
 
+ifneq (,$(wildcard config.mak))
+include config.mak
+endif
+
 ifndef NO_CURL
 	ifdef CURLDIR
 		# This is still problematic -- gcc does not want -R.
---
0.99.8.GIT
