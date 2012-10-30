From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 2/4] fast-export: fix comparisson in tests
Date: Tue, 30 Oct 2012 20:06:25 +0100
Message-ID: <1351623987-21012-3-git-send-email-felipe.contreras@gmail.com>
References: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 20:07:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTH9T-0002vq-Ls
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 20:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934227Ab2J3TGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 15:06:49 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52686 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934115Ab2J3TGr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 15:06:47 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so340997bkc.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 12:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=3nK4hyrS692DAGc/50tYTiZZ4BHON3sPqHP9kLz5f0I=;
        b=qS5BaWcrna2dRxRvxWb4cGdNkdSdAVJiIVBArdDHbzLUSaPU9ZQjmvHNPHQNv+uqrv
         SIqd94tbwmQ7rI8KkFfIiGI6Z7i+YKpwZEiJEQwkT+8G3Pr+pU+bYvbmINLd2WAlmZ2c
         tgSh61DYJobIy//V6u2nKKe5dtXudp0TOr0p7irSVnhBiq5eBZQdLaIGG6LHMZi8Bzht
         ROn2LY8MnQlFY4U2IvAO66SnU3siaLTk8GwX7TIeJhS4NtoBTFTHWkVjJFAd7lVxCaOk
         vq46Xz8DmATXLTws0dDFNT/d0X9tq9vTo3R4hBaAQWKk57B3jV9KhqQR53eJ/VgaUmLX
         n91w==
Received: by 10.204.151.9 with SMTP id a9mr10226694bkw.2.1351624006770;
        Tue, 30 Oct 2012 12:06:46 -0700 (PDT)
Received: from localhost (ip-109-43-0-40.web.vodafone.de. [109.43.0.40])
        by mx.google.com with ESMTPS id k21sm1979543bkv.1.2012.10.30.12.06.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 12:06:46 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351623987-21012-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208728>

First the expected, then the actual, otherwise the diff would be the
opposite of what we want.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9350-fast-export.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 3e821f9..49bdb44 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -303,7 +303,7 @@ test_expect_success 'dropping tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=drop mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -320,7 +320,7 @@ test_expect_success 'rewriting tag of filtered out object' '
 (
 	cd limit-by-paths &&
 	git fast-export --tag-of-filtered-object=rewrite mytag -- there > output &&
-	test_cmp output expected
+	test_cmp expected output
 )
 '
 
@@ -351,7 +351,7 @@ test_expect_failure 'no exact-ref revisions included' '
 	(
 		cd limit-by-paths &&
 		git fast-export master~2..master~1 > output &&
-		test_cmp output expected
+		test_cmp expected output
 	)
 '
 
-- 
1.8.0
