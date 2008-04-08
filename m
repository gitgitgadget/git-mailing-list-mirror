From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] builtin-apply.c: use git_config_string() to get
	apply_default_whitespace
Date: Tue, 8 Apr 2008 10:42:33 +0200
Message-ID: <20080408084233.GA7785@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 08 10:43:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jj9QZ-0006if-Lk
	for gcvg-git-2@gmane.org; Tue, 08 Apr 2008 10:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbYDHImz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Apr 2008 04:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751691AbYDHImz
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Apr 2008 04:42:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:53432 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751290AbYDHImy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Apr 2008 04:42:54 -0400
Received: (qmail invoked by alias); 08 Apr 2008 08:42:52 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp033) with SMTP; 08 Apr 2008 10:42:52 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1/BiPE9W/DBeAgDusy/53Iqgd2Jy8HwtEVPzO93nU
	kFi9s3gXqaL92t
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1Jj9PV-0005XN-U1
	for git@vger.kernel.org; Tue, 08 Apr 2008 10:42:33 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78994>

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Hi,

a simple `Janitor patch'.

Regards,
 Stephan.

 builtin-apply.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index b5f78ac..ce0a0c3 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2978,12 +2978,8 @@ static int apply_patch(int fd, const char *filename, int inaccurate_eof)
 
 static int git_apply_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "apply.whitespace")) {
-		if (!value)
-			return config_error_nonbool(var);
-		apply_default_whitespace = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "apply.whitespace"))
+		return git_config_string(&apply_default_whitespace, var, value);
 	return git_default_config(var, value);
 }
 
-- 
1.5.5.rc3.8.g78d1a
