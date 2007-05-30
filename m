From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Silence $(CC) command line when compiling test tools
Date: Tue, 29 May 2007 23:11:23 -0400
Message-ID: <20070530031123.GA12044@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 05:11:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtEay-000104-SE
	for gcvg-git@gmane.org; Wed, 30 May 2007 05:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbXE3DL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 23:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbXE3DL1
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 23:11:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42727 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbXE3DL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 23:11:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtEaf-0005Dd-8C; Tue, 29 May 2007 23:11:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4617A20FBAE; Tue, 29 May 2007 23:11:23 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48729>

Like our other $(CC) rules in the Makefile we typically build with
$(QUIET_CC) in front of $(CC) so that we hide the compiler options.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Makefile |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Makefile b/Makefile
index 3680b09..25c3f37 100644
--- a/Makefile
+++ b/Makefile
@@ -956,25 +956,25 @@ test: all
 	$(MAKE) -C t/ all
 
 test-date$X: test-date.c date.o ctype.o
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) test-date.c date.o ctype.o
 
 test-delta$X: test-delta.o diff-delta.o patch-delta.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 test-dump-cache-tree$X: dump-cache-tree.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 test-sha1$X: test-sha1.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 test-match-trees$X: test-match-trees.o $(GITLIBS)
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
 
 test-chmtime$X: test-chmtime.c
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
 
 test-genrandom$X: test-genrandom.c
-	$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
+	$(QUIET_CC)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $<
 
 check-sha1:: test-sha1$X
 	./test-sha1.sh
-- 
1.5.2.869.g6b3ba
