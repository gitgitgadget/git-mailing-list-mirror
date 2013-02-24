From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 11/16] contrib/fast-import/import-zips.py: fix broken error message
Date: Sat, 23 Feb 2013 16:50:19 -0800
Message-ID: <1361667024-49776-12-git-send-email-davvid@gmail.com>
References: <1361667024-49776-1-git-send-email-davvid@gmail.com>
 <1361667024-49776-2-git-send-email-davvid@gmail.com>
 <1361667024-49776-3-git-send-email-davvid@gmail.com>
 <1361667024-49776-4-git-send-email-davvid@gmail.com>
 <1361667024-49776-5-git-send-email-davvid@gmail.com>
 <1361667024-49776-6-git-send-email-davvid@gmail.com>
 <1361667024-49776-7-git-send-email-davvid@gmail.com>
 <1361667024-49776-8-git-send-email-davvid@gmail.com>
 <1361667024-49776-9-git-send-email-davvid@gmail.com>
 <1361667024-49776-10-git-send-email-davvid@gmail.com>
 <1361667024-49776-11-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:51:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PoW-0008WV-HL
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132Ab3BXAvE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:51:04 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:39802 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab3BXAvC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:51:02 -0500
Received: by mail-pa0-f51.google.com with SMTP id hz1so1128695pad.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=q927MngL2B5ysmPjnGe0OA50Q7CiplOBHj+o/Id6tRE=;
        b=V/2W7JSK3ZZMk30+zzEdKL6XOFCFVe/Rru286LpdQE+wlzznueT8iN+Kmp1kGu9Kpu
         oclKJTQJsfkBZnO1SPXG5r7bGuGwll4KZK1mQeS4TYTYJkWb1ysstVAiA1DTLtrU/1xf
         GLKKSYJw6lQxqHzNgiDXUvLg1/QabB3xGoJXPJmye05kNAaqOaxT0oBKModlpEvyRjH2
         36UpSThJk7KG+avLRhlPV6r7k8dHWK4DhDHOTTUCw/a/IP8uWy9v7BzfXmFoRa+3OUba
         0zODKrngSJOuMcI7YT3DfTE9rhYUUzyjlH9rJ5slRucRTNVTeOM8UR2es16zvTjyirh0
         zGrg==
X-Received: by 10.68.202.34 with SMTP id kf2mr10667126pbc.44.1361667061871;
        Sat, 23 Feb 2013 16:51:01 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (remote-11.disneyanimation.com. [198.187.190.11])
        by mx.google.com with ESMTPS id a4sm8190345paw.21.2013.02.23.16.50.59
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:51:01 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361667024-49776-11-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216968>

The 'sys' module is not imported but all of the bits
we want from it are.  Adjust the script to not fail
when run on old Python versions and fix the inconsistent
use of tabs.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/fast-import/import-zips.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/import-zips.py b/contrib/fast-import/import-zips.py
index f54c65b..b528798 100755
--- a/contrib/fast-import/import-zips.py
+++ b/contrib/fast-import/import-zips.py
@@ -14,9 +14,9 @@ from time import mktime
 from zipfile import ZipFile
 
 if hexversion < 0x01060000:
-        # The limiter is the zipfile module
-        sys.stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
-        sys.exit(1)
+	# The limiter is the zipfile module
+	stderr.write("import-zips.py: requires Python 1.6.0 or later.\n")
+	exit(1)
 
 if len(argv) < 2:
 	print 'usage:', argv[0], '<zipfile>...'
-- 
1.8.2.rc0.263.g20d9441
