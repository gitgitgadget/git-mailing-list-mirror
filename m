From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 6/7] t5520: reduce commom lines of code
Date: Sat,  2 Apr 2016 23:28:31 +0530
Message-ID: <1459619912-5445-7-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:01:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPrp-0000iy-NN
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbcDBSBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:01:46 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32840 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcDBSBp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:01:45 -0400
Received: by mail-pa0-f67.google.com with SMTP id q6so16352490pav.0
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 11:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4SeluJ/qxmq4Uxah/zeWCDkvMJmxte7VPNPZ6b0CTUs=;
        b=rg12XwvbI/SnsYw8D7+kQtAkyeSg2WnggBXMkodyVQ2cnmv0N8hbcWSOe3w7IzIDXk
         oyJs/DFp8rJOv6etSHgU+P0ZP9sXaXdgrNLyG6OQXMrTe4/bsFQ4CINcHgCMxBrqxO3l
         ujnQA6wQK55CaneaKudv5o42MjDdWmKB1KpxYDEzcUQ2Lxpx2liBpiB5Qaw4e3ZArG7i
         3PuklHfGE+3GYVr7zN6mfjkiqJFanMmy8IrbVlDKdjJmg7HzrX2ur0rBlPxAevWWeo1d
         9KW4SbbQeuqiq6P9hoKJNv0LRuYQTGO+w1cvlxp0jSEgM05/6MILjwkzpHyoypkZSOea
         uv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4SeluJ/qxmq4Uxah/zeWCDkvMJmxte7VPNPZ6b0CTUs=;
        b=ZAAV1wv9K9Hfyzysswn8Cjkk65xITOO+y7Jiul25tdqEBeDgBHx7Krq/lEkb3JftPo
         JyJyCi+UeOzWEUiPfkDH0C6CmqKb8vD9qQkNwlFN8JCNIwNhaz2Lfjm7Baop8yRmvues
         A6ntlHgiFi7y0RK8weolw193wB5o9F5+/gUvSdcszLq5AhdrJjq87izrEF1SQOud2ysY
         OibEHhtef9Rwm3Wzmi7/I65J/yccyDxGJfyDtI7ujwKahIzXoous+WffdRv+Vl5mc6J4
         VEgRpWtQmFAox2njX4YXlE+mnUTBrPmlsxlSt8fZYZzKrBlMauWIgzA19WXh8cU3JQcO
         vRWw==
X-Gm-Message-State: AD7BkJK2Tf/9uFtv/pvvm35QLKBSaBX3aBpM/D+CLLyEn4LsD4zLteZwg4ZEmPo9o0gSQw==
X-Received: by 10.66.236.97 with SMTP id ut1mr91565pac.24.1459620105197;
        Sat, 02 Apr 2016 11:01:45 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.11.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 11:01:44 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290602>

These two tests are almost similar and thus can be folded in a for-loop.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index fb9f845..e12af96 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -298,15 +298,13 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 	test_pull_autostash_fail --rebase --no-autostash
 '
 
-test_expect_success 'pull --autostash (without --rebase) should error out' '
-	test_must_fail git pull --autostash . copy 2>err &&
-	test_i18ngrep "only valid with --rebase" err
-'
-
-test_expect_success 'pull --no-autostash (without --rebase) should error out' '
-	test_must_fail git pull --no-autostash . copy 2>err &&
-	test_i18ngrep "only valid with --rebase" err
-'
+for i in --autostash --no-autostash
+do
+	test_expect_success "pull $i (without --rebase) is illegal" '
+		test_must_fail git pull $i . copy 2>err &&
+		test_i18ngrep "only valid with --rebase" err
+	'
+done
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.7.1.340.g69eb491.dirty
