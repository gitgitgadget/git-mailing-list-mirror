From: Lawrence Siebert <lawrencesiebert@gmail.com>
Subject: [PATCH v2 3/4] log --count: added test
Date: Thu,  2 Jul 2015 16:50:10 -0700
Message-ID: <1435881011-13879-4-git-send-email-lawrencesiebert@gmail.com>
References: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr, gitster@pobox.com,
	Lawrence Siebert <lawrencesiebert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 03 01:50:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAoFo-0005Eb-B7
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 01:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753455AbbGBXus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2015 19:50:48 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:32828 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754186AbbGBXuo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2015 19:50:44 -0400
Received: by ykdv136 with SMTP id v136so82840602ykd.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 16:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eZ8zCl6Wb9aWgi7GIvhAQKCloGVnfjGCh9Czi1voGgA=;
        b=lUsOlVSXeQe6tLqXkNVDnt2Ya7YReVFnB0iCxxJSwofmJwAnNcp1rsm5InpjcfatFm
         Spjk9nCsTFapYQ4/fastxkTy6zOrH8mgI4Z9hTehnE5ueRv9g3RqZt7BPocTOvTc0YT+
         yM7kttYRIAHbcSpzLq8kZF95APOC7rlY79zJ1AKM5HtTHejOEJCHLoZ2MDB6cQkXMCer
         lY5tn4/7Ui1MaFrrjH38kuOXIZQjoMxf/EVuGhsjY9tcV7KEgiTtX2mApzmz3GdshtuW
         TqcWcxMz958zBs956g9Ybfxozni+oMk/0ZQDP6eMFkCIKRLUW95sLq2w5HiG2+7PGNNm
         V8qg==
X-Received: by 10.170.190.212 with SMTP id h203mr38769761yke.3.1435881043626;
        Thu, 02 Jul 2015 16:50:43 -0700 (PDT)
Received: from localhost.localdomain (24-176-234-59.dhcp.atsc.ca.charter.com. [24.176.234.59])
        by mx.google.com with ESMTPSA id b131sm7190938ywc.18.2015.07.02.16.50.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Jul 2015 16:50:43 -0700 (PDT)
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1435881011-13879-1-git-send-email-lawrencesiebert@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273276>

added test comparing output between git log --count HEAD and
git rev-list --count HEAD

Signed-off-by: Lawrence Siebert <lawrencesiebert@gmail.com>
---
 t/t4202-log.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1b2e981..35f8d82 100755
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
