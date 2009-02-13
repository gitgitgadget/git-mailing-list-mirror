From: Arjen Laarhoven <arjen@yaph.org>
Subject: [PATCH 2/2] builtin-branch.c: Rename branch category color names
Date: Fri, 13 Feb 2009 22:53:41 +0100
Message-ID: <1234562021-2397-2-git-send-email-arjen@yaph.org>
References: <7vy6wbi7gm.fsf@gitster.siamese.dyndns.org>
 <1234562021-2397-1-git-send-email-arjen@yaph.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 22:55:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LY60A-0008SH-SM
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 22:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbZBMVxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 16:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbZBMVxq
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 16:53:46 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:2635 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbZBMVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 16:53:45 -0500
Received: from localhost.localdomain (aragorndsl.demon.nl [82.161.19.32])
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id n1DLrfD9081945;
	Fri, 13 Feb 2009 22:53:42 +0100 (CET)
	(envelope-from arjen@yaph.org)
X-Mailer: git-send-email 1.6.2.rc0.186.g417c
In-Reply-To: <1234562021-2397-1-git-send-email-arjen@yaph.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109777>

The branch color constants have the form COLOR_BRANCH_$category.  Rename
them to BRANCH_COLOR_$category as this conveys their meaning better.

Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
---
 builtin-branch.c |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/builtin-branch.c b/builtin-branch.c
index fe139e1..6d241c8 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -39,11 +39,11 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_GREEN,	/* CURRENT */
 };
 enum color_branch {
-	COLOR_BRANCH_RESET = 0,
-	COLOR_BRANCH_PLAIN = 1,
-	COLOR_BRANCH_REMOTE = 2,
-	COLOR_BRANCH_LOCAL = 3,
-	COLOR_BRANCH_CURRENT = 4,
+	BRANCH_COLOR_RESET = 0,
+	BRANCH_COLOR_PLAIN = 1,
+	BRANCH_COLOR_REMOTE = 2,
+	BRANCH_COLOR_LOCAL = 3,
+	BRANCH_COLOR_CURRENT = 4,
 };
 
 static enum merge_filter {
@@ -56,15 +56,15 @@ static unsigned char merge_filter_ref[20];
 static int parse_branch_color_slot(const char *var, int ofs)
 {
 	if (!strcasecmp(var+ofs, "plain"))
-		return COLOR_BRANCH_PLAIN;
+		return BRANCH_COLOR_PLAIN;
 	if (!strcasecmp(var+ofs, "reset"))
-		return COLOR_BRANCH_RESET;
+		return BRANCH_COLOR_RESET;
 	if (!strcasecmp(var+ofs, "remote"))
-		return COLOR_BRANCH_REMOTE;
+		return BRANCH_COLOR_REMOTE;
 	if (!strcasecmp(var+ofs, "local"))
-		return COLOR_BRANCH_LOCAL;
+		return BRANCH_COLOR_LOCAL;
 	if (!strcasecmp(var+ofs, "current"))
-		return COLOR_BRANCH_CURRENT;
+		return BRANCH_COLOR_CURRENT;
 	die("bad config variable '%s'", var);
 }
 
@@ -303,20 +303,20 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	switch (item->kind) {
 	case REF_LOCAL_BRANCH:
-		color = COLOR_BRANCH_LOCAL;
+		color = BRANCH_COLOR_LOCAL;
 		break;
 	case REF_REMOTE_BRANCH:
-		color = COLOR_BRANCH_REMOTE;
+		color = BRANCH_COLOR_REMOTE;
 		break;
 	default:
-		color = COLOR_BRANCH_PLAIN;
+		color = BRANCH_COLOR_PLAIN;
 		break;
 	}
 
 	c = ' ';
 	if (current) {
 		c = '*';
-		color = COLOR_BRANCH_CURRENT;
+		color = BRANCH_COLOR_CURRENT;
 	}
 
 	if (verbose) {
@@ -335,14 +335,14 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 		printf("%c %s%-*s%s %s %s%s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
-		       branch_get_color(COLOR_BRANCH_RESET),
+		       branch_get_color(BRANCH_COLOR_RESET),
 		       find_unique_abbrev(item->commit->object.sha1, abbrev),
 		       stat.buf, sub);
 		strbuf_release(&stat);
 		strbuf_release(&subject);
 	} else {
 		printf("%c %s%s%s\n", c, branch_get_color(color), item->name,
-		       branch_get_color(COLOR_BRANCH_RESET));
+		       branch_get_color(BRANCH_COLOR_RESET));
 	}
 }
 
-- 
1.6.2.rc0.186.g417c
