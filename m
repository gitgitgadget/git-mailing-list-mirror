From: Angus Hammond <angusgh@gmail.com>
Subject: [PATCH] Remove redundant line of code from grep.c
Date: Sun,  6 May 2012 19:17:15 +0100
Message-ID: <1336328235-27387-1-git-send-email-angusgh@gmail.com>
Cc: Angus Hammond <angusgh@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 06 20:17:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR61d-0001aq-38
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 20:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663Ab2EFSRd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 14:17:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:38550 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637Ab2EFSRX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 14:17:23 -0400
Received: by werb10 with SMTP id b10so852557wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 11:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6ZTznybwzFmH0Un9ico4GzFiu4TPfoZCx+ZGenHh9ew=;
        b=EkgBWDN3pwyKX+I5+wyyd03DB7hPtMSTwGg84s69F27KkygAeaJzA3lumwiXOunAox
         xUlDl2NcWHSwLeg9gDqhTgG/fu+bbyRq+nofFc/gUC+1wQ+iZOS6LKY3Cyaa65qu3e5s
         sNFRnLWltVEGBur3at8JbOVirPXzTGi+I25QeR5p3y+Ao3ndtjcrfLMgYfmqA45j3GNO
         lBWObMpWClv8n0KYVh6xaYnaJ9H6ZK9O0rb+Wi6geBvOMzztIMft7vFOiLqtCOVYXKGV
         IhEjlrMUsxLHxBijIfbB4cUANmBgioBG8ZZTjO0VSuV2D+5Tk1C41v+Y1ZL7iiMUGfvp
         M9sw==
Received: by 10.180.83.38 with SMTP id n6mr28985156wiy.4.1336328241937;
        Sun, 06 May 2012 11:17:21 -0700 (PDT)
Received: from localhost.localdomain (levelgrove.demon.co.uk. [62.49.19.234])
        by mx.google.com with ESMTPS id fn2sm24641978wib.0.2012.05.06.11.17.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 06 May 2012 11:17:21 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197204>

Remove double initialisation of p in grep_expr.
Signed-off-by: Angus Hammond <angusgh@gmail.com>

---
 grep.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 190139c..f8ffa46 100644
--- a/grep.c
+++ b/grep.c
@@ -318,7 +318,7 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 
 	if (!opt->header_list)
 		return NULL;
-	p = opt->header_list;
+
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-- 
1.7.9.5
