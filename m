From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH 3/4] log --count: added test
Date: Wed,  1 Jul 2015 22:38:55 -0700
Message-ID: <1435815536-30611-3-git-send-email-lawrencesiebert@gmail.com>
References: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Cc: gitster@pobox.com, Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 07:39:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAXDj-0001Y2-AT
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 07:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbbGBFjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 01:39:31 -0400
Received: from mail-yk0-f179.google.com ([209.85.160.179]:35887 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbbGBFjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 01:39:25 -0400
Received: by ykdr198 with SMTP id r198so59122696ykd.3
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 22:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gQHwhgTCnZE6W6jPku5u0t3HCIzzh8a1hqcTcCxuNdI=;
        b=CH212S2ZVpQQo6rX7ZWgA/W4vsgLyaS8JNFgzRxrDnR34PEHNdzmiB1FZCpdrhKAEG
         YPH6gXlstlCLob8rzkq14i/GPNq19PWxiSRDi2VAEjpNU13zl3dAjeujPxxbTK3/l+f2
         zSI6dPOBC28k+WwW5jxTqX0FP2teTrxZGOwp9CkdJPpwFy/8moOPCoI3G6YMFj/YR0QQ
         Fa/8qaLdSi3nvHOTfWUpL2zZ+P2rwycaFgFjYSo14sjZd6nXsiJn3F/Bk02xgaNz71eQ
         MLHRhCgB+PDbQR2t92PjZco9JBOXVMDPqiJJH64o3yAWTjiqkoCWlOHRdnxD0LC3u54k
         hiMA==
X-Received: by 10.170.188.1 with SMTP id f1mr36578799yke.65.1435815565070;
        Wed, 01 Jul 2015 22:39:25 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id m12sm4563641ywd.22.2015.07.01.22.39.23
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Jul 2015 22:39:24 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435815536-30611-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273215>

added test comparing output between git log --count HEAD and
git rev-list --count HEAD

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 t/t4202-log.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..077952b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -871,4 +871,11 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
+test_expect_success 'log --count' '
+	git log --count HEAD > actual &&
+	git	rev-list --count HEAD > expect &&
+	test_cmp expect actual
+'	
+	
+
 test_done
-- 
1.9.1
