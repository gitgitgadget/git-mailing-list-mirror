From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 1/5] git p4: Fixing script editor checks
Date: Tue, 24 Apr 2012 09:33:19 +0100
Message-ID: <1335256403-22162-2-git-send-email-luke@diamand.org>
References: <1335256403-22162-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:33:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMbC0-00088z-1W
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756264Ab2DXIdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:33:37 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:64178 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab2DXIdd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:33:33 -0400
Received: by wgbds11 with SMTP id ds11so3260330wgb.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:33:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=WQHece7ib8xyQu/a+Sx4GZ9i/PWbyC12dRUBQZwmrc4=;
        b=mfkUc2tsx1xYh0twdz6ixaM6E0IhlGxvmx71INrepNtOryBju2p3RSPdzo5aIGodft
         zuT1t8EMz6Mbx5btJNbn7lN+3xIC+2i26NzbCn8mYNHBMlq4jlWR4143eKhIC/QedkB5
         QjI4n2geg9KdPhz41EVlRfwCa+DPeeMxBjgkM8fA85Z4Op39/ORcCWxkS/a/OmZyYMoU
         6FZfS/rDsk0M91pRejedmPF0VrInBPa7t0VntiQoDU2HinIBziGZgIXL+9tShd+ZwozV
         6eExxyte3pLo3nNoQjmbMme8H1dR/ldkNCGOUnmTkUYNi4oKv3MwwnxPtRj7TH/TwOJl
         RIkg==
Received: by 10.216.137.149 with SMTP id y21mr12104245wei.110.1335256411831;
        Tue, 24 Apr 2012 01:33:31 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fz9sm28534467wib.3.2012.04.24.01.33.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:33:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.8.g12781
In-Reply-To: <1335256403-22162-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQmdmXmF5lDMsJwsKw9YzYR7T072z0MJfnor//8G9zt/NL6Gd8sB9Mgh872aSXNRMwjSfZzj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196213>

If P4EDITOR is defined, the tests will fail when "git p4" starts an
editor.

Signed-off-by: Luke Diamand <luke@diamand.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9800-git-p4-basic.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 13be144..b2f0869 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -335,7 +335,7 @@ test_expect_success 'detect renames' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
+		git config git-p4.skipSubmitEdit true &&
 
 		git mv file1 file4 &&
 		git commit -a -m "Rename file1 to file4" &&
@@ -394,7 +394,7 @@ test_expect_success 'detect copies' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
+		git config git-p4.skipSubmitEdit true &&
 
 		cp file2 file8 &&
 		git add file8 &&
-- 
1.7.10.8.g12781
