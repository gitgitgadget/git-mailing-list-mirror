From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 4/5] dir.c: rename to name_compare()
Date: Wed, 18 Jun 2014 11:45:16 -0700
Message-ID: <1403117117-10384-5-git-send-email-jmmahler@gmail.com>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:46:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKsK-0007SQ-FJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754357AbaFRSqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 14:46:13 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:56295 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754339AbaFRSqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:46:12 -0400
Received: by mail-pb0-f52.google.com with SMTP id rq2so1017452pbb.25
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/20+CvyAMshoYuioSVsgr5UeWZCclBEEEui1VGyWl8E=;
        b=MmgWi2esnvcDYw5rKO3jo5uRUiWuYIiTCkcZVz7lvKH3gdZG9YU+FPHaraQAfiXSf8
         8o5mWcTMM9M1iJJjyvhvp65tNOugs8EzxIP/dAHuwuWjH3CRadshAKar2IYh2I+CJ3dt
         YucBrJKFvz5IOMS82/XygBYIQAHR81g9qc8GhM0kp1n//y/f47qkHfXyDmBG2yVkPrej
         LSJguDXrEDpwXkYD2nE1rmOvf1uwGua9pWYt/JAkMd740monsA6X6VhX9SD2bQrw3k1T
         hF/OzwXp4zZ1RGNSsDrKSdQ5I+a4ZdF26FLFZO9Zp+H6qsoRFGzW+YYPuq+P4EPOXb/B
         4K5A==
X-Received: by 10.66.141.109 with SMTP id rn13mr4777159pab.117.1403117171197;
        Wed, 18 Jun 2014 11:46:11 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fn2sm14247499pab.22.2014.06.18.11.46.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2014 11:46:10 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.697.g57b47e0
In-Reply-To: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252022>

Rename the call to cache_name_compare() to name_compare().

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---

Notes:
    This is a case where cache_name_compare() was used even though it had
    nothing to do with a cache.  The new name makes it clear that no cache
    is involved.

 dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 797805d..e65888d 100644
--- a/dir.c
+++ b/dir.c
@@ -1354,8 +1354,7 @@ static int cmp_name(const void *p1, const void *p2)
 	const struct dir_entry *e1 = *(const struct dir_entry **)p1;
 	const struct dir_entry *e2 = *(const struct dir_entry **)p2;
 
-	return cache_name_compare(e1->name, e1->len,
-				  e2->name, e2->len);
+	return name_compare(e1->name, e1->len, e2->name, e2->len);
 }
 
 static struct path_simplify *create_simplify(const char **pathspec)
-- 
2.0.0
