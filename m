X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] git-status always says what branch it's on
Date: Thu, 14 Dec 2006 15:25:23 +0000
Message-ID: <200612141525.23671.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 15:25:38 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-TUID: 68739b742d1f3437
X-UID: 193
X-Length: 953
Content-Disposition: inline
X-OriginalArrivalTime: 14 Dec 2006 15:27:24.0974 (UTC) FILETIME=[5B3DB4E0:01C71F94]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34348>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GusSg-00052n-Li for gcvg-git@gmane.org; Thu, 14 Dec
 2006 16:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932803AbWLNPZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 10:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932804AbWLNPZ1
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 10:25:27 -0500
Received: from mail.360visiontechnology.com ([194.70.53.226]:32691 "EHLO
 369run02s.360vision.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S932803AbWLNPZ1 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec
 2006 10:25:27 -0500
Received: from dvr.360vision.com ([192.189.1.24]) by 369run02s.360vision.com
 with Microsoft SMTPSVC(5.0.2195.6713); Thu, 14 Dec 2006 15:27:24 +0000
Received: from localhost ([127.0.0.1]) by dvr.360vision.com with esmtp (Exim
 3.36 #1 (Debian)) id 1GusSb-0007js-00 for <git@vger.kernel.org>; Thu, 14 Dec
 2006 15:25:25 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

If the current branch was "master" then git-status wouldn't say

 # On branch XXXX

In its output.  This patch makes it so that this message is always
output; regardless of branch name.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 wt-status.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index de1be5b..9a78dac 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -271,7 +271,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 
 void wt_status_print(struct wt_status *s)
 {
-	if (s->branch && strcmp(s->branch, "refs/heads/master"))
+	if (s->branch)
 		color_printf_ln(color(WT_STATUS_HEADER),
 			"# On branch %s", s->branch);
 
-- 
1.4.4.1.g3ece-dirty
