From: larsxschneider@gmail.com
Subject: [PATCH v1] t9821: use test_config
Date: Thu,  3 Sep 2015 11:34:47 +0200
Message-ID: <1441272887-72633-2-git-send-email-larsxschneider@gmail.com>
References: <1441272887-72633-1-git-send-email-larsxschneider@gmail.com>
Cc: remi.galan-alfonso@ensimag.grenoble-inp.fr,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 11:34:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXQv2-0005Om-EB
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 11:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753594AbbICJex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 05:34:53 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34522 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbbICJev (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 05:34:51 -0400
Received: by wicfx3 with SMTP id fx3so13299289wic.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 02:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cp+V5A2Yld2gAVQCdL3/fffdXPyf9PlhLlOVD1gtiXc=;
        b=GdXJtP6v2iNXsxHpsPtIKaYC26/ZverUEm3FMvrl30a1sszRwcTR8PTwEkOfyB+Dh+
         FwZUz91Cp1kjPcGcoY7oTpDKr5UE6ImXARHjwMpA1rSlaDD+2z38e+Gj6B9Ctlo6pFkv
         /E1taZiKztTpEwqgLe77dfvGmNHlooqNhTSSe7DCHVInrpj40Q8VB/QH5mBWX/5e4Bjj
         sooPXdnh5RROKawQO1z6gYrcJpU5958/RvgbtK0BoEJwiofOrzsY1i4aVxHlnayOrviy
         db+yoSfrmgkUQvswpQmO7jmaCeOrATO3Kgfml2C0sroySa1OUgMJmVdcGc1jWf3CHyXL
         DphA==
X-Received: by 10.180.230.199 with SMTP id ta7mr4845379wic.1.1441272890053;
        Thu, 03 Sep 2015 02:34:50 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id uc12sm8016047wib.13.2015.09.03.02.34.49
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Sep 2015 02:34:49 -0700 (PDT)
X-Mailer: git-send-email 1.9.5 (Apple Git-50.3)
In-Reply-To: <1441272887-72633-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277190>

From: Lars Schneider <larsxschneider@gmail.com>

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 t/t9821-git-p4-path-variations.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9821-git-p4-path-variations.sh b/t/t9821-git-p4-path-variations.sh
index 81e46ac..5a26fec 100755
--- a/t/t9821-git-p4-path-variations.sh
+++ b/t/t9821-git-p4-path-variations.sh
@@ -45,7 +45,7 @@ test_expect_success 'Clone root' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase false &&
+		test_config core.ignorecase false &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		# This method is used instead of "test -f" to ensure the case is
 		# checked even if the test is executed on case-insensitive file systems.
@@ -67,7 +67,7 @@ test_expect_success 'Clone root (ignorecase)' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase true &&
+		test_config core.ignorecase true &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		# This method is used instead of "test -f" to ensure the case is
 		# checked even if the test is executed on case-insensitive file systems.
@@ -91,7 +91,7 @@ test_expect_success 'Clone root and ignore one file' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase false &&
+		test_config core.ignorecase false &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		# We ignore one file in the client spec and all path cases change from
 		# "TO" to "to"!
@@ -113,7 +113,7 @@ test_expect_success 'Clone root and ignore one file (ignorecase)' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase true &&
+		test_config core.ignorecase true &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		# We ignore one file in the client spec and all path cases change from
 		# "TO" to "to"!
@@ -133,7 +133,7 @@ test_expect_success 'Clone path' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase false &&
+		test_config core.ignorecase false &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		cat >expect <<-\EOF &&
 		to/File2.txt
@@ -149,7 +149,7 @@ test_expect_success 'Clone path (ignorecase)' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase true &&
+		test_config core.ignorecase true &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		cat >expect <<-\EOF &&
 		TO/File2.txt
@@ -180,7 +180,7 @@ test_expect_success 'Add a new file and clone path with new file (ignorecase)' '
 	(
 		cd "$git" &&
 		git init . &&
-		git config core.ignorecase true &&
+		test_config core.ignorecase true &&
 		git p4 clone --use-client-spec --destination="$git" //depot &&
 		cat >expect <<-\EOF &&
 		to/File0.txt
--
1.9.5 (Apple Git-50.3)
