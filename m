X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Make filenames line up in git-status output
Date: Thu, 26 Oct 2006 15:17:24 +0100
Message-ID: <200610261517.24468.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 26 Oct 2006 14:17:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 3b0d244473e306f7
X-UID: 134
X-Length: 1971
Content-Disposition: inline
X-OriginalArrivalTime: 26 Oct 2006 14:20:28.0664 (UTC) FILETIME=[E317AF80:01C6F909]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30222>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gd638-0000ku-N3 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 16:17:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423336AbWJZOR3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 26 Oct 2006
 10:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423495AbWJZOR3
 (ORCPT <rfc822;git-outgoing>); Thu, 26 Oct 2006 10:17:29 -0400
Received: from mail.360visiontechnology.com ([194.70.53.226]:38252 "EHLO
 369run02s.360vision.com") by vger.kernel.org with ESMTP id S1423336AbWJZOR2
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 26 Oct 2006 10:17:28 -0400
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 26 Oct 2006 15:20:28 +0100
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1Gd62w-0002sm-00 for <git@vger.kernel.org>; Thu, 26 Oct
 2006 15:17:26 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

When all the filenames line up it's much easier to copy and paste them
somewhere else, or to remove the "modified:", "copied:", etc prefix.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 wt-status.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 4b74e68..3952809 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -72,25 +72,25 @@ static void wt_status_print_filepair(int
 	color_printf(color(WT_STATUS_HEADER), "#\t");
 	switch (p->status) {
 	case DIFF_STATUS_ADDED:
-		color_printf(c, "new file: %s", p->one->path); break;
+		color_printf(c, "new file:   %s", p->one->path); break;
 	case DIFF_STATUS_COPIED:
-		color_printf(c, "copied: %s -> %s",
+		color_printf(c, "copied:     %s -> %s",
 				p->one->path, p->two->path);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_printf(c, "deleted: %s", p->one->path); break;
+		color_printf(c, "deleted:    %s", p->one->path); break;
 	case DIFF_STATUS_MODIFIED:
-		color_printf(c, "modified: %s", p->one->path); break;
+		color_printf(c, "modified:   %s", p->one->path); break;
 	case DIFF_STATUS_RENAMED:
-		color_printf(c, "renamed: %s -> %s",
+		color_printf(c, "renamed:    %s -> %s",
 				p->one->path, p->two->path);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
 		color_printf(c, "typechange: %s", p->one->path); break;
 	case DIFF_STATUS_UNKNOWN:
-		color_printf(c, "unknown: %s", p->one->path); break;
+		color_printf(c, "unknown:    %s", p->one->path); break;
 	case DIFF_STATUS_UNMERGED:
-		color_printf(c, "unmerged: %s", p->one->path); break;
+		color_printf(c, "unmerged:   %s", p->one->path); break;
 	default:
 		die("bug: unhandled diff status %c", p->status);
 	}
-- 
1.4.3.3.g5bca6
