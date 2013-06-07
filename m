From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 2/3] test: improve rebase -q test
Date: Fri,  7 Jun 2013 15:32:22 -0500
Message-ID: <1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 07 22:34:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3Mj-0006ZG-2x
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247Ab3FGUeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 16:34:24 -0400
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38155 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603Ab3FGUeX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:34:23 -0400
Received: by mail-ob0-f176.google.com with SMTP id v19so7198765obq.21
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=707Lbx6Mm3EtFp15/DqRmXWiGD6nsoTNUUwArVIvMPg=;
        b=kb/Dg8d49dKdirdqRWZIDV6J3AqxskzKIXjjRkrmghDES13Wj8JINxgqA//dc3FQtu
         Qrc+HY0iJes/fmSwhQ5iCR70gC7wE/PhOQmm455c8g3YBwd/xHztj5w+2MJgjr+hrjvd
         kBhu3Sko/5FG0yVl9CGpTog5p+3BLVBQZoOi1wHH1pXrbt4sj7/K4viVNTm2+BYkeTP6
         PwcJv3+uabdr59isog8TXWUPIW+gWwo2QaxwNyphMHp6pshpHdmjN0Fp/OvQEkBnns9F
         mtd/9gFoIg7Bgo0YmTEI673rsiUxDQIQt0Nl1ovY+E2jA668X0vYABvRenS0ezy3sZPJ
         em3Q==
X-Received: by 10.60.174.111 with SMTP id br15mr194724oec.130.1370637261721;
        Fri, 07 Jun 2013 13:34:21 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id eq4sm518639obb.5.2013.06.07.13.34.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 13:34:20 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226702>

Let's show the output so it's clear why it failed.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t3400-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b58fa1a..fb39531 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -185,6 +185,7 @@ test_expect_success 'default to @{upstream} when upstream arg is missing' '
 test_expect_success 'rebase -q is quiet' '
 	git checkout -b quiet topic &&
 	git rebase -q master >output.out 2>&1 &&
+	cat output.out &&
 	test ! -s output.out
 '
 
-- 
1.8.3.698.g079b096
