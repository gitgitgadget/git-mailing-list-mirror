From: drafnel@gmail.com
Subject: [PATCH 3/3] builtin-gc.c: deprecate --prune, it now really has no effect
Date: Fri,  9 May 2008 23:01:57 -0500
Message-ID: <14594477.1210392054360.JavaMail.teamon@b303.teamon.com>
References: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat May 10 06:02:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JugHd-00005I-KB
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 06:02:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbYEJEBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2008 00:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbYEJEBS
	(ORCPT <rfc822;git-outgoing>); Sat, 10 May 2008 00:01:18 -0400
Received: from mailproxy03.teamon.com ([64.85.68.139]:44574 "EHLO
	b303.teamon.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750791AbYEJEA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2008 00:00:56 -0400
Received: from b303.teamon.com (localhost [127.0.0.1])
	by b303.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id m4A40sU18416;
	Sat, 10 May 2008 04:00:54 GMT
X-Mailer: git-send-email 1.5.5.67.g9a49
In-Reply-To: <7vabj0b1re.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81645>

From: Brandon Casey <drafnel@gmail.com>

---
 builtin-gc.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 6db2f51..48f7d95 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -219,7 +219,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	char buf[80];
 
 	struct option builtin_gc_options[] = {
-		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects"),
+		OPT_BOOLEAN(0, "prune", &prune, "prune unreferenced objects (deprecated)"),
 		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increased runtime)"),
 		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
 		OPT_BOOLEAN('q', "quiet", &quiet, "suppress progress reports"),
@@ -249,7 +249,6 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		/*
 		 * Auto-gc should be least intrusive as possible.
 		 */
-		prune = 0;
 		if (!need_to_gc())
 			return 0;
 		fprintf(stderr, "Auto packing your repository for optimum "
-- 
1.5.5.67.g9a49
