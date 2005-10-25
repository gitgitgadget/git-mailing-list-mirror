From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/4] git-init-db should error out with a message
Date: Wed, 26 Oct 2005 01:39:24 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510260139000.30576@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Oct 26 01:40:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUYO9-0004aV-DI
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 01:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVJYXj0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 19:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbVJYXj0
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 19:39:26 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:10643 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932481AbVJYXjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 19:39:25 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C37C613F1A1; Wed, 26 Oct 2005 01:39:24 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A76829ABB1; Wed, 26 Oct 2005 01:39:24 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 929699AB5F; Wed, 26 Oct 2005 01:39:24 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7BE9E13F1A1; Wed, 26 Oct 2005 01:39:24 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10633>

When the HEAD symref could not be created, it is helpful for the user to 
know that.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 init-db.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

applies-to: 51f96562f1ef47cd9a09731e3f27445efaddbbe7
159c632ef3cc7371aaa495c41afd5fd41e2d3f3f
diff --git a/init-db.c b/init-db.c
index aabc09f..2c27e18 100644
--- a/init-db.c
+++ b/init-db.c
@@ -192,7 +192,7 @@ static void create_default_files(const c
 	strcpy(path + len, "HEAD");
 	if (read_ref(path, sha1) < 0) {
 		if (create_symref(path, "refs/heads/master") < 0)
-			exit(1);
+			die("Could not create HEAD symref!");
 	}
 	path[len] = 0;
 	copy_templates(path, len, template_path);
---
0.99.8.GIT
