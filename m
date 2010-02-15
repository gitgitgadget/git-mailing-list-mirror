From: Pete Harlan <pgit@pcharlan.com>
Subject: [PATCH] Remove hyphen from "git-command" in two error messages
Date: Mon, 15 Feb 2010 15:25:38 -0800
Message-ID: <4B79D7F2.80207@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 00:25:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhAK0-0004t6-CY
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 00:25:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756687Ab0BOXZj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 18:25:39 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:39073 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756565Ab0BOXZj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 18:25:39 -0500
Received: from [192.168.0.119] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 5B3168F229
	for <git@vger.kernel.org>; Mon, 15 Feb 2010 15:25:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140043>

Signed-off-by: Pete Harlan <pgit@pcharlan.com>
---
The hyphen in

  git: 'foo' is not a git-command. See 'git --help'.

looks like an anachronism.  Patch generated against "next".

 git.c  |    2 +-
 help.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git.c b/git.c
index b3e23f1..90c6daf 100644
--- a/git.c
+++ b/git.c
@@ -527,7 +527,7 @@ int main(int argc, const char **argv)
 			break;
 		if (was_alias) {
 			fprintf(stderr, "Expansion of alias '%s' failed; "
-				"'%s' is not a git-command\n",
+				"'%s' is not a git command\n",
 				cmd, argv[0]);
 			exit(1);
 		}
diff --git a/help.c b/help.c
index 9da97d7..7f4928e 100644
--- a/help.c
+++ b/help.c
@@ -350,7 +350,7 @@ const char *help_unknown_cmd(const char *cmd)
 		return assumed;
 	}

-	fprintf(stderr, "git: '%s' is not a git-command. See 'git --help'.\n",
cmd);
+	fprintf(stderr, "git: '%s' is not a git command. See 'git --help'.\n",
cmd);

 	if (SIMILAR_ENOUGH(best_similarity)) {
 		fprintf(stderr, "\nDid you mean %s?\n",
-- 
1.7.0
