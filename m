From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-rev-parse: Fix --short= option parsing
Date: Sat, 18 Feb 2006 02:10:53 +0100
Message-ID: <20060218011053.GB2562@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 02:11:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAGcn-0000vK-Od
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 02:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWBRBK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Feb 2006 20:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWBRBK5
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Feb 2006 20:10:57 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:41656 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1751002AbWBRBK4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2006 20:10:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 26F2952D395;
	Sat, 18 Feb 2006 02:10:55 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04036-13; Sat, 18 Feb 2006 02:10:53 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 6A0B552D4A3;
	Sat, 18 Feb 2006 02:10:53 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 7F2596DF845; Sat, 18 Feb 2006 02:09:55 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 507FD61BD0; Sat, 18 Feb 2006 02:10:53 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16379>

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 16e2efc524d181cf46dcb252532139a0aff4a28f
tree c57ea8bf09b25fb643aadd224e7e73673187cc60
parent b867c7c23a42fbe9f261153a9814a5efbc071a29
author Jonas Fonseca <fonseca@diku.dk> Sat, 18 Feb 2006 02:04:26 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Sat, 18 Feb 2006 02:04:26 +0100

 rev-parse.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/rev-parse.c b/rev-parse.c
index b82f294..70a8271 100644
--- a/rev-parse.c
+++ b/rev-parse.c
@@ -225,12 +225,12 @@ int main(int argc, char **argv)
 				continue;
 			}
 			if (!strcmp(arg, "--short") ||
-			    !strncmp(arg, "--short=", 9)) {
+			    !strncmp(arg, "--short=", 8)) {
 				filter &= ~(DO_FLAGS|DO_NOREV);
 				verify = 1;
 				abbrev = DEFAULT_ABBREV;
-				if (arg[8] == '=')
-					abbrev = strtoul(arg + 9, NULL, 10);
+				if (arg[7] == '=')
+					abbrev = strtoul(arg + 8, NULL, 10);
 				if (abbrev < MINIMUM_ABBREV)
 					abbrev = MINIMUM_ABBREV;
 				else if (40 <= abbrev)

-- 
Jonas Fonseca
