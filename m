From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 11/16] contrib/fast-import/import-zips.py: fix broken error message
Date: Sat, 23 Feb 2013 16:20:49 -0800
Message-ID: <1361665254-42866-12-git-send-email-davvid@gmail.com>
References: <1361665254-42866-1-git-send-email-davvid@gmail.com>
 <1361665254-42866-2-git-send-email-davvid@gmail.com>
 <1361665254-42866-3-git-send-email-davvid@gmail.com>
 <1361665254-42866-4-git-send-email-davvid@gmail.com>
 <1361665254-42866-5-git-send-email-davvid@gmail.com>
 <1361665254-42866-6-git-send-email-davvid@gmail.com>
 <1361665254-42866-7-git-send-email-davvid@gmail.com>
 <1361665254-42866-8-git-send-email-davvid@gmail.com>
 <1361665254-42866-9-git-send-email-davvid@gmail.com>
 <1361665254-42866-10-git-send-email-davvid@gmail.com>
 <1361665254-42866-11-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 24 01:22:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9PM2-0002nz-LB
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 01:22:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759385Ab3BXAVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2013 19:21:48 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:55998 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759126Ab3BXAVX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2013 19:21:23 -0500
Received: by mail-pb0-f51.google.com with SMTP id un15so1054637pbc.10
        for <git@vger.kernel.org>; Sat, 23 Feb 2013 16:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=p5LI+pKo576U4OEAA5rD8jXJ/apRD+xFiPEq2u/ZSMU=;
        b=gxYLA32SyEzvwK6LdBnx+LVCOOKQQ/eTJn4y1Y7ajOLux1nf2N+pjK8OL5FDayfxNQ
         GPeQQfm8synpPGx06UZJWcpzKuusRM6ULUPOCty5vlogw4i3d7FiGv4a9lSzgT6AmCO0
         vFdKf9IgmMEJM7lq701aX2oORRRngRyp93E/HtYO/Ous4X4MLYp5WdNWQwU5f83NiOig
         lNuHQq8mmcwrIVB5VnkkN1PLsgQV6OUNeUWsPlfwk2vvJuLEhA6m/H3Qa3/jX/qA64Lf
         IWWtWa/RAkhYQbjYLZLhObsLcICwLDP91gtpD5ApUCxVdBnHSfCIqW9SEBhNZGa1ec49
         DD/w==
X-Received: by 10.66.76.37 with SMTP id h5mr11912350paw.33.1361665282713;
        Sat, 23 Feb 2013 16:21:22 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id wm3sm7430622pbc.4.2013.02.23.16.21.20
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 23 Feb 2013 16:21:21 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.263.g20d9441
In-Reply-To: <1361665254-42866-11-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216951>

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
1.8.2.rc0.247.g811e0c0
