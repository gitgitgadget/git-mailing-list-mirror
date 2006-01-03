From: exon@op5.se (Andreas Ericsson)
Subject: [PATCH] git potty: grok 'help' to mean '--help'.
Date: Tue,  3 Jan 2006 10:53:54 +0100 (CET)
Message-ID: <20060103095354.25A1C5BA16@nox.op5.se>
X-From: git-owner@vger.kernel.org Tue Jan 03 10:54:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Etirf-0003t7-EX
	for gcvg-git@gmane.org; Tue, 03 Jan 2006 10:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWACJxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jan 2006 04:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbWACJxz
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jan 2006 04:53:55 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59601 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750862AbWACJxz
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 Jan 2006 04:53:55 -0500
Received: from nox.op5.se (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 4D3076BD02
	for <git@vger.kernel.org>; Tue,  3 Jan 2006 10:53:54 +0100 (CET)
Received: by nox.op5.se (Postfix, from userid 500)
	id 25A1C5BA16; Tue,  3 Jan 2006 10:53:54 +0100 (CET)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14145>


Most other scm's understand it, most users expect it and it's an easy fix.

Signed-off-by: Andreas Ericsson <ae@op5.se>

---

 git.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

bd2573445899c427adac66f2b0fe4643461ab280
diff --git a/git.c b/git.c
index e795ddb..5e7da74 100644
--- a/git.c
+++ b/git.c
@@ -244,6 +244,11 @@ int main(int argc, char **argv, char **e
 	for (i = 1; i < argc; i++) {
 		char *arg = argv[i];
 
+		if (!strcmp(arg, "help")) {
+			show_help = 1;
+			continue;
+		}
+
 		if (strncmp(arg, "--", 2))
 			break;
 
-- 
1.0.6-g58e3
