From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Always reset the color _before_ printing out the newline
Date: Mon, 24 Jul 2006 14:41:41 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607241440340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jul 24 14:41:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G4zkp-0000UY-6G
	for gcvg-git@gmane.org; Mon, 24 Jul 2006 14:41:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWGXMlo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Jul 2006 08:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWGXMlo
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Jul 2006 08:41:44 -0400
Received: from mail.gmx.net ([213.165.64.21]:20113 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932136AbWGXMln (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Jul 2006 08:41:43 -0400
Received: (qmail invoked by alias); 24 Jul 2006 12:41:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp028) with SMTP; 24 Jul 2006 14:41:42 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24142>


This patch brings the benefits of part of v1.4.1-rc2~37
to the "commit" colorizing patch.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 log-tree.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 608f3ec..b67b8dd 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -144,9 +144,9 @@ void show_log(struct rev_info *opt, cons
 			printf(" (from %s)",
 			       diff_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
-		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
 		printf("%s",
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
+		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
 	}
 
 	/*
-- 
1.4.2.rc1.g41e1-dirty
