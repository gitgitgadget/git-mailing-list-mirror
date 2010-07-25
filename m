From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: [PATCH 2/2] simplify digit_in_number
Date: Sun, 25 Jul 2010 19:43:18 +0200
Message-ID: <1280079798-4993-2-git-send-email-ralf.thielow@googlemail.com>
References: <1280079798-4993-1-git-send-email-ralf.thielow@googlemail.com>
Cc: Ralf Thielow <ralf.thielow@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 19:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od5Ek-0006TZ-UR
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab0GYRn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:43:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45676 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751524Ab0GYRn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:43:26 -0400
Received: by eya25 with SMTP id 25so342059eya.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 10:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=NOzt3K0ja8GTGSTI+6ur+vxo9r9y6YqEj5x/KJQJYCQ=;
        b=JcBE5FOI4j77hstZQcd0pUowHrhZfwGXpfcv0rhvhQFMvn0rxzDx0fPtr9F8hLAO/z
         TJT+KL75KJpL/DFPfOEnVwTmqDbUV5Ipy4ZgdAnq9vpDhZ7P+hecP3DYe+YK+lqEyIKQ
         ZM341ACHG3luO61R7GxAS8f+4PU20n0/eTI3s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=sJstO62N2ionY2WkJZzjOjb0737x7tTJcyOnAlBhlSkgBFsbTDfWIOzaU6tWlYnF0Z
         f2rRJsNneACq79iDI2cDa+qbxRLjJm/4G4i+2GehFAm/zZNdrJrF7bNqc4YpIb5+hBV7
         rp5M4DnIpMyalF3I6WIZDg9Bcgd1dr1TTUoX4=
Received: by 10.213.34.140 with SMTP id l12mr5530996ebd.31.1280079805328;
        Sun, 25 Jul 2010 10:43:25 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-222-159-075.pools.arcor-ip.net [94.222.159.75])
        by mx.google.com with ESMTPS id a48sm4218558eei.0.2010.07.25.10.43.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 10:43:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280079798-4993-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151770>

tree-log: simplify digit_in_number

Simplify the algorithm to resolve the digits in a number.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 log-tree.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 95a00a4..c2af716 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -254,10 +254,10 @@ static void append_signoff(struct strbuf *sb, const char *signoff)
 
 static unsigned int digits_in_number(unsigned int number)
 {
-	int digits = 0;
+	int digits = 1;
 	while (number /= 10) 
 		digits++;
-	return digits++;
+	return digits;
 }
 
 void get_patch_filename(struct commit *commit, int nr, const char *suffix,
-- 
1.7.0.4
