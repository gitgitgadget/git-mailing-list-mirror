From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv3 1/5] git p4: Fixing script editor checks
Date: Tue, 24 Apr 2012 09:08:13 +0100
Message-ID: <1335254897-15242-2-git-send-email-luke@diamand.org>
References: <1335254897-15242-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Junio C Hamano <gitster@pobox.com>,
	Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 24 10:08:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SManb-0007pH-Kh
	for gcvg-git-2@plane.gmane.org; Tue, 24 Apr 2012 10:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486Ab2DXII3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Apr 2012 04:08:29 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:57736 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754149Ab2DXII0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2012 04:08:26 -0400
Received: by wibhr17 with SMTP id hr17so3247488wib.1
        for <git@vger.kernel.org>; Tue, 24 Apr 2012 01:08:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=ISBTlF845LsJyI7RTLCPq9OOvYbHfvh6RC/k9RnLuSY=;
        b=FZLkdSBsZG/PIApezx3wDQP7PcXmZPNnhVEZQkPZwmK73E7whB6h6UIOoTYvWUlGPN
         JKPd0OVURqbzzE9iIdYi61XB4xQRedo3+IFV9t4e4T1HWOFU4IhqoR8bnNDypR2vl3LZ
         oaPHotG9I7r/mOG9fQRBObJHpdTL+aDPUEtHUkv3ytWBlnUdMZ4gdmyqHHacZUbLmJ/D
         pRWB1+xgoN2HR/oJX07Zt7QJZYG+hv8ea+koXxD5sMXgfcDxFxubi+37tm/Xw/C25ed5
         AGqQCkW6+lfLdyqUGJRLHsKyPHxNxtyNQOb0Zlj/i/PARb7JmeZLI0QrB0XFNOcwQIF1
         S9Ag==
Received: by 10.216.135.206 with SMTP id u56mr10625586wei.29.1335254905440;
        Tue, 24 Apr 2012 01:08:25 -0700 (PDT)
Received: from ethel.diamand (cpc19-cmbg14-2-0-cust6.5-4.cable.virginmedia.com. [86.6.30.7])
        by mx.google.com with ESMTPS id fl2sm44448146wib.2.2012.04.24.01.08.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 24 Apr 2012 01:08:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.381.gb484f
In-Reply-To: <1335254897-15242-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQnPso3e+JF82AYsA5ByfHgXYai2ovbjR6T2qYrizgChGVlFpoISFrJ7ALacBL9yqU2IxLZX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196202>

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
1.7.10.381.gb484f
