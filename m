From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 1/2] help.c: use 'git_config_string' to get
 'help_default_format'.
Date: Sun, 17 Feb 2008 20:52:50 +0100
Message-ID: <20080217205250.a2b4c3c2.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio Hamano <junkio@cox.net>, Pascal Obry <pascal@obry.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 20:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQpUC-0001FK-7H
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 20:47:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYBQTrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 14:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752345AbYBQTrF
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 14:47:05 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:57959 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751653AbYBQTrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 14:47:03 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id A13F01AB2F7;
	Sun, 17 Feb 2008 20:47:00 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with SMTP id 581FE1AB2C5;
	Sun, 17 Feb 2008 20:47:00 +0100 (CET)
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.5; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74176>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/help.c b/help.c
index 6e28ad9..8143dcd 100644
--- a/help.c
+++ b/help.c
@@ -39,12 +39,8 @@ static void parse_help_format(const char *format)
 
 static int git_help_config(const char *var, const char *value)
 {
-	if (!strcmp(var, "help.format")) {
-		if (!value)
-			return config_error_nonbool(var);
-		help_default_format = xstrdup(value);
-		return 0;
-	}
+	if (!strcmp(var, "help.format"))
+		return git_config_string(&help_default_format, var, value);
 	return git_default_config(var, value);
 }
 
-- 
1.5.4.1.1384.gdeff
