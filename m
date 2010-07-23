From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 07/13] (trivial) git notes prune: Accept --verbose in
 addition to -v
Date: Fri, 23 Jul 2010 12:14:58 +0200
Message-ID: <1279880104-29796-8-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:16:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFIV-0001FC-7u
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756023Ab0GWKPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:20 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755802Ab0GWKPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:18 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000G9Z9TBM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:11 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id F04411EA554B_C496BAEB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id D9A7C1EA3767_C496BAEF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:10 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151517>

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-notes.txt |    4 +++-
 builtin/notes.c             |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 5540af5..ce0ea03 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -133,7 +133,9 @@ OPTIONS
 	would be removed.
 
 -v::
-	Report all object names whose notes are removed.
+--verbose::
+	When pruning notes, report all object names whose notes are
+	removed.
 
 
 DISCUSSION
diff --git a/builtin/notes.c b/builtin/notes.c
index f653f59..888a9e3 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -802,7 +802,7 @@ static int prune(int argc, const char **argv, const char *prefix)
 	int show_only = 0, verbose = 0;
 	struct option options[] = {
 		OPT_BOOLEAN('n', NULL, &show_only, "do not remove, show only"),
-		OPT_BOOLEAN('v', NULL, &verbose, "report pruned notes"),
+		OPT_BOOLEAN('v', "verbose", &verbose, "report pruned notes"),
 		OPT_END()
 	};
 
-- 
1.7.2.220.gea1d3
