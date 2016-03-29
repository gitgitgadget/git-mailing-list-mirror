From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 3/5] t/t5520: use test_i18ngrep instead of test_cmp
Date: Tue, 29 Mar 2016 18:59:58 +0530
Message-ID: <1459258200-32444-4-git-send-email-mehul.jain2029@gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:31:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktk9-0005B1-9u
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756596AbcC2Nbe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:31:34 -0400
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33121 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbcC2Nbd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:31:33 -0400
Received: by mail-pa0-f65.google.com with SMTP id q6so2154036pav.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0VB7ltIVUyAPU/xMeflPyUkXEkwb2cONgNAbkIE+ALI=;
        b=rPl/c+zrve5Ezpi2VzhyTkjDT7wFScYWpJwY6GtY2gKHVXyegGflmL6gS9tU8qy/3V
         pnhdjKSmKUrpB5zvRKenXc9LIKSOXK/uvQuId6AgISz4Mvy2CHOTZPPvZ+8EKl7BCnLj
         lmH1D7Wd4Ye7BQH7TTnq4XEWUSx38GbIT+6zUibXaUc8ZtKYJEwO9pUaZFlpBWZdwHhF
         V3Jt2kmWnpAFJLOcVAvRGRCYCcTOFJ+CVgXEwThUchCn/Grb4sHEENdrCam/dzwZ7Eug
         lYx7ftYgZXdL8aqxvkt9aAfF4PRTCakJ7gbYzy4jxyKZbJmdMVba0isItiYNwvXZwAHc
         XEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0VB7ltIVUyAPU/xMeflPyUkXEkwb2cONgNAbkIE+ALI=;
        b=gDhvGuv192LBexFsSsgXwcF523Wqmo0KJN++yAixkjAbbajk5eBJsxPjqdRZKw8Ly7
         UuN+ssifpGUS7rrxkEcHYJzYrBlqb8MEbCxthhRfFJavLQp3lm9/F9yrIoZkodRc1/8U
         CxV8LJsKyPjZzW+WPsdxx04a4NFcLrCtSpWhMtQaQyo8PfXbKiWysg6yvVHwVwYNxX+r
         D9dPdRCVZY4MsDOguNQS3uh55A/AkYi9zXMhFA7KizEpVt+0AtKF1XBXM879c1OpIZlX
         wQmwD1eHsPSARxVxEyb3fHsrWlf4wOSr/z4ONweOceHQ2CFlfGHro8w4tOiHxzqPkp1r
         oL3A==
X-Gm-Message-State: AD7BkJJ3AucyO+Pp8P5KdN5jd5/ZcYRGRPiR+COlnzKkQWbuajWtr68HTXEGqVkUN4c2Ng==
X-Received: by 10.66.246.165 with SMTP id xx5mr3470159pac.87.1459258292282;
        Tue, 29 Mar 2016 06:31:32 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.29])
        by smtp.gmail.com with ESMTPSA id s66sm43430514pfi.3.2016.03.29.06.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 06:31:31 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290138>

test_cmp is used for error checking when test_i18ngrep could be used.

Use test_i18ngrep to check for the valid error.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9ee2218..d03cb84 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -317,15 +317,13 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 '
 
 test_expect_success 'pull --autostash (without --rebase) should error out' '
-	test_must_fail git pull --autostash . copy 2>actual &&
-	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
-	test_i18ncmp actual expect
+	test_must_fail git pull --autostash . copy 2>err &&
+	test_i18ngrep "only valid with --rebase" err
 '
 
 test_expect_success 'pull --no-autostash (without --rebase) should error out' '
-	test_must_fail git pull --no-autostash . copy 2>actual &&
-	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
-	test_i18ncmp actual expect
+	test_must_fail git pull --no-autostash . copy 2>err &&
+	test_i18ngrep "only valid with --rebase" err
 '
 
 test_expect_success 'pull.rebase' '
-- 
2.7.1.340.g69eb491.dirty
