From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Avoid ugly linewrap in git help
Date: Sun, 11 Feb 2007 14:29:58 +0100
Message-ID: <45CF1A56.1060809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 11 14:30:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGEmf-0007xU-MJ
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 14:30:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbXBKNaN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 08:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbXBKNaN
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 08:30:13 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:36645
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932821AbXBKNaM (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Feb 2007 08:30:12 -0500
Received: from [10.0.1.20] (p508E59D9.dip.t-dialin.net [80.142.89.217])
	by neapel230.server4you.de (Postfix) with ESMTP id 212C97035;
	Sun, 11 Feb 2007 14:30:11 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39280>

Some of the short help texts that are shown e.g. when running 'git'
without any parameters wrap on a 80-column terminal.  They are just
one character over the line.  This patch avoids it by decreasing the
number of spaces around the preceding command name from four to
three (on both sides for symmetry).

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

 help.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/help.c b/help.c
index 341b9e3..b667463 100644
--- a/help.c
+++ b/help.c
@@ -168,8 +168,8 @@ static void list_common_cmds_help(void)
 
 	puts("The most commonly used git commands are:");
 	for (i = 0; i < ARRAY_SIZE(common_cmds); i++) {
-		printf("    %s", common_cmds[i].name);
-		mput_char(' ', longest - strlen(common_cmds[i].name) + 4);
+		printf("   %s   ", common_cmds[i].name);
+		mput_char(' ', longest - strlen(common_cmds[i].name));
 		puts(common_cmds[i].help);
 	}
 	puts("(use 'git help -a' to get a list of all installed git commands)");
