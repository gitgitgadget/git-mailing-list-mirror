From: Matthias Lederhofer <matled@gmx.net>
Subject: [PATCH 2/2] make init-db use GIT_TEMPLATE_DIR if --template option is not specified
Date: Sat, 27 May 2006 12:25:39 +0200
Message-ID: <46880.7145757184$1148725551@news.gmane.org>
References: <11487255393905-git-send-email-1>
Reply-To: Matthias Lederhofer <matled@gmx.net>
Cc: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Sat May 27 12:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjvzQ-0006XK-GG
	for gcvg-git@gmane.org; Sat, 27 May 2006 12:25:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbWE0KZm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 06:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbWE0KZm
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 06:25:42 -0400
Received: from moooo.ath.cx ([85.116.203.178]:20164 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751458AbWE0KZl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 06:25:41 -0400
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g40505
In-Reply-To: <11487255393905-git-send-email-1>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20845>

---

f61e19360f9b5965dda1ae762ffdab8ede860430
 builtin-init-db.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

f61e19360f9b5965dda1ae762ffdab8ede860430
diff --git a/builtin-init-db.c b/builtin-init-db.c
index 2a1384c..cf5bd39 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -253,6 +253,9 @@ int cmd_init_db(int argc, const char **a
 			die(init_db_usage);
 	}
 
+	if (!template_dir)
+		template_dir = getenv("GIT_TEMPLATE_DIR");
+
 	/*
 	 * Set up the default .git directory contents
 	 */
-- 
1.3.3.g40505
