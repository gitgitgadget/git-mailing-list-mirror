From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 6/7] t5520: reduce commom lines of code
Date: Sun,  3 Apr 2016 14:17:37 +0530
Message-ID: <1459673257-6344-1-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, j6t@kdbg.org,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 10:52:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amdlS-0001bp-A2
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 10:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbcDCIsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 04:48:12 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33436 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbcDCIsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 04:48:10 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so2023599pfe.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QqndYTUwZ2YfVwck/E+9K0YGPNjP855Dh1hM1FsH/OE=;
        b=CF5dtv0faylFPOvoINnY/S/8bJUh0+bCNSVoKI8Gnh83otplVd/7/GCsnbxCtO4SrO
         B2ZDX3gkWupNfv6C5MxAzFR6r4xIYvs9nVvldZjeVFqhgUKJ3Cs8LQaV7E1qr8jXQvGd
         oyBIUR0tI1ZMETVSI7H61LaTH/As5Y+DKIolX1h6zQK8p29q9o15M+Lh+uhosmccvydy
         hyz83rBfUSAH46awAfyGU218/ZUiiaNhq4ku/xL3aXXdbCecpWbXGGCHu0SEDGRD6PFS
         uqYPcUtd/fR/qMSTCUeCdI0N/6BxzusZydNo1AB6UOfhDXWhOsiMXpJe/OnUR3xOIbeh
         EPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QqndYTUwZ2YfVwck/E+9K0YGPNjP855Dh1hM1FsH/OE=;
        b=OAWR+iUMQ8SnBE+bR/V9N/uw0bz3EN4TszrL3nPkRDTwJGSxvoE8BTd7xNK3S/Trlu
         /FKEKhmsnLTVEvmgFWQ+YbjeWWof18cBeX1d3mduEGEhuyNgeyMrey/UoMxjFXqw5Q5w
         EcA5YZwX+eFSCMSplN+CUMqTaoP4+zIRaL4ZuVvYNzsctjI5vsDSBoTsTfZEviRjOfYg
         hxE0We3kFZqYBsBwk3hYSqftbUZbLg4x0zxri0Oeak7gegRFcqdZNAiwiyOblkaXz+et
         AiR+hh+ElV8dSDztWrHjikT+i4Ca09vYmx5VlmaDIkfTayBP74x8ols/nt3prJbQVwaK
         fw+w==
X-Gm-Message-State: AD7BkJIs+cxzqPmDtywRT6XEdbMkj29cDS5dDuYByTmYH2AyoJxo9SO2j/+3p36DM3T5tA==
X-Received: by 10.98.7.24 with SMTP id b24mr13643126pfd.125.1459673289876;
        Sun, 03 Apr 2016 01:48:09 -0700 (PDT)
Received: from localhost.localdomain ([1.39.56.22])
        by smtp.gmail.com with ESMTPSA id w20sm31388599pfi.31.2016.04.03.01.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 03 Apr 2016 01:48:09 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290636>

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
+for autostash_flag in --autostash --no-autostash
+do
+	test_expect_success "pull $autostash_flag (without --rebase) is illegal" '
+		test_must_fail git pull $autostash_flag . copy 2>err &&
+		test_i18ngrep "only valid with --rebase" err
+	'
+done
 
 test_expect_success 'pull.rebase' '
 	git reset --hard before-rebase &&
-- 
2.7.1.340.g69eb491.dirty
