From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] prune: allow --dry-run for -n and --verbose for -v
Date: Fri, 06 Aug 2010 22:28:05 +0200
Message-ID: <4C5C7055.3090100@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 06 22:28:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhTWh-0000bA-M3
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 22:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762015Ab0HFU2S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 16:28:18 -0400
Received: from india601.server4you.de ([85.25.151.105]:52178 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0HFU2R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 16:28:17 -0400
Received: from [10.0.1.100] (p57B7F69B.dip.t-dialin.net [87.183.246.155])
	by india601.server4you.de (Postfix) with ESMTPSA id 9ABE02F80B5;
	Fri,  6 Aug 2010 22:28:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152810>

For consistency with other git commands, let git prune accept the long
options --dry-run and --verbose for the respective short ones -n and -v.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/git-prune.txt |    2 ++
 builtin/prune.c             |    5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 15cfb7a..4d673a5 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -31,10 +31,12 @@ OPTIONS
 -------
 
 -n::
+--dry-run::
 	Do not remove anything; just report what it would
 	remove.
 
 -v::
+--verbose::
 	Report all removed objects.
 
 \--::
diff --git a/builtin/prune.c b/builtin/prune.c
index 81f915ec..99218ba 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -125,10 +125,9 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const struct option options[] = {
-		OPT_BOOLEAN('n', NULL, &show_only,
+		OPT_BOOLEAN('n', "dry-run", &show_only,
 			    "do not remove, show only"),
-		OPT_BOOLEAN('v', NULL, &verbose,
-			"report pruned objects"),
+		OPT_BOOLEAN('v', "verbose", &verbose, "report pruned objects"),
 		OPT_DATE(0, "expire", &expire,
 			 "expire objects older than <time>"),
 		OPT_END()
-- 
1.7.2
