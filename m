From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] t7406-submodule-update: add missing &&
Date: Mon, 16 Sep 2013 01:38:21 +0800
Message-ID: <1379266703-29808-1-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 15 19:39:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLGHn-0007yb-M6
	for gcvg-git-2@plane.gmane.org; Sun, 15 Sep 2013 19:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab3IORiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Sep 2013 13:38:50 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:57095 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164Ab3IORiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Sep 2013 13:38:50 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3212366pdj.34
        for <git@vger.kernel.org>; Sun, 15 Sep 2013 10:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id;
        bh=KkvpWJ69w77Onu01c2jW4WM2Vvm16Bm4zvMiNLTjkQw=;
        b=XvlxPmTa7tNCAFo+0JypAWmc0d5IIAAya3ClqRRoUp5Bg04BWIyx3njRR718/M1t05
         wSX+eFHjskH+BNWZUZfRiTMk50SLFUl8vsdcFeT6Fra+cbPYr854zMV/1r662GCtALPg
         TCvt2GOrdYpnJmtHan6ZiXiMhd+Z5m2YHIIH6X6GCTyqqk6ofW8XwJ9mCjAcU/ZC8bRF
         e70Hh2CfTsZWFFLJwvk4k4KT4hpW5mamt5NjO1jdpdKzCOFQX/OcjV8xMsA6lSXeFGum
         qLz3+IpmU8xk442ENxqU7tNE6Mkccuxve3wOiWNzwuhiIFmSf0m2yTcv3Ai1eOA1zcKW
         ZjjQ==
X-Received: by 10.66.88.3 with SMTP id bc3mr26243771pab.48.1379266729779;
        Sun, 15 Sep 2013 10:38:49 -0700 (PDT)
Received: from ubu-01-asus.nus.edu.sg ([42.60.190.192])
        by mx.google.com with ESMTPSA id uw6sm25617621pbc.8.1969.12.31.16.00.00
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 15 Sep 2013 10:38:49 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc4.527.g303b16c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234821>

322bb6e (2011 Aug 11) introduced a new subshell at the end of a test
case but omitted a '&&' to join the two; fix this.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t7406-submodule-update.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index b192f93..f0b3305 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -58,7 +58,7 @@ test_expect_success 'setup a submodule tree' '
 	 git submodule add ../merging merging &&
 	 test_tick &&
 	 git commit -m "rebasing"
-	)
+	) &&
 	(cd super &&
 	 git submodule add ../none none &&
 	 test_tick &&
-- 
1.8.4.rc4.527.g303b16c
