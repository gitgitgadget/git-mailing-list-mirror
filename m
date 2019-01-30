Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 487901F453
	for <e@80x24.org>; Wed, 30 Jan 2019 09:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbfA3Jt7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 04:49:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39972 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfA3Jt7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 04:49:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so10817953plq.7
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 01:49:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehEc+rRcypnYc0I7Ml7XAII7cul1tCReuGdXdLRYLc0=;
        b=KnbjyqNHf47QacCV2HFFmLnUuyFUzoTa4nUaIl/Hb7J/9z351dUHTf9SQDE3x9ElOr
         dgtc6o5zenK3m7AGnWYbr888WaHh/FQCHyLWiAHiGj0jaIOHep3KsiHGSoTgqXAi8Ouv
         UEt379GVleF1qTEKsMqwOxIQYQ7gnHRlBTDArGtoFnidC4/CNSGKieazG+tFpflW5OYo
         MU6uCC6KcMohwT7PY/PeFi3cNtBfUFDk7ojg3ACWnSalfCq0JEVBI/nVMciCXD+EearK
         GArQ7J9VEdVM0XMbxBO2DwWmie/NAItfRLJSfCAXZx7sy/GG0pR2MtKU5sTtecHhwt4Q
         Jy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehEc+rRcypnYc0I7Ml7XAII7cul1tCReuGdXdLRYLc0=;
        b=BLSRJrJO2lYn/WDJdunQF1jWbvVVCKcZQl/Z3Og3akCtfIpOsjB9sON1AASk98oGqW
         0AC77oIIT6OC5iTJ+KfP6Sbn5HNYBUfMUai53oe8ilYTn/6FFg8vbuuZ7ih1wKm7PmK4
         NYPW9rm1VZwbeBnZQ3M96ikjakeLzTocXp5rztUF/lZyIeunmwzmI8WotjMgjTiXRSpe
         sy2qCa2dz09HsnhHmFypglRRBCH4XwkC/Gh0GJlqpaRRPlBk9wGJxRmv7Js+n3UTqVQ6
         iHlMDBXzG7MpKmjm3U8EzP1mEk+jUk3oojYwcXYL9uCNJx+OlQWj/iXCavxQG1f+XnGl
         ZX3w==
X-Gm-Message-State: AJcUukesMFtAfCFxV2PXAknH67Kc4dQ99KKUFpxSeZ8fm8t4OXBib1Qw
        +gcG1TYVFrLyV3i+H1Elv4L3X2lw
X-Google-Smtp-Source: ALg8bN5PvwUNh92RDXsZ/oUEVkuAkaTLwrYjCocUmoYIQrxwUfjVbna0VRpm0etmjrsVUcmvsSDCIA==
X-Received: by 2002:a17:902:2862:: with SMTP id e89mr30139267plb.158.1548841798225;
        Wed, 30 Jan 2019 01:49:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id f13sm1746609pfa.132.2019.01.30.01.49.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:49:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 30 Jan 2019 16:49:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 17/19] t: add tests for switch
Date:   Wed, 30 Jan 2019 16:48:29 +0700
Message-Id: <20190130094831.10420-18-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190130094831.10420-1-pclouds@gmail.com>
References: <20190130094831.10420-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t2060-switch.sh | 91 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100755 t/t2060-switch.sh

diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
new file mode 100755
index 0000000000..252f78c79e
--- /dev/null
+++ b/t/t2060-switch.sh
@@ -0,0 +1,91 @@
+#!/bin/sh
+
+test_description='switch basic functionality'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	test_commit first &&
+	git branch first-branch &&
+	test_commit second &&
+	test_commit third &&
+	git remote add origin nohost:/nopath &&
+	git update-ref refs/remotes/origin/foo first-branch
+'
+
+test_expect_success 'switch branch no arguments' '
+	test_must_fail git switch
+'
+
+test_expect_success 'switch branch' '
+	git switch first-branch &&
+	test_path_is_missing second.t
+'
+
+test_expect_success 'switch to a commit' '
+	test_must_fail git switch master^{commit}
+'
+
+test_expect_success 'switch and detach' '
+	test_when_finished git switch master &&
+	git switch --detach master^{commit} &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_expect_success 'switch and detach current branch' '
+	test_when_finished git switch master &&
+	git switch master &&
+	git switch --detach &&
+	test_must_fail git symbolic-ref HEAD
+'
+
+test_expect_success 'switch and create branch' '
+	test_when_finished git switch master &&
+	git switch -c temp master^ &&
+	git rev-parse master^ >expected &&
+	git rev-parse refs/heads/temp >actual &&
+	test_cmp expected actual &&
+	echo refs/heads/temp >expected-branch &&
+	git symbolic-ref HEAD >actual-branch &&
+	test_cmp expected-branch actual-branch
+'
+
+test_expect_success 'force create branch from HEAD' '
+	test_when_finished git switch master &&
+	git switch --detach master &&
+	git switch -C temp &&
+	git rev-parse master >expected &&
+	git rev-parse refs/heads/temp >actual &&
+	test_cmp expected actual &&
+	echo refs/heads/temp >expected-branch &&
+	git symbolic-ref HEAD >actual-branch &&
+	test_cmp expected-branch actual-branch
+'
+
+test_expect_success 'new orphan branch' '
+	test_when_finished git switch master &&
+	git switch --orphan new-orphan master^ &&
+	test_commit orphan &&
+	git cat-file commit refs/heads/new-orphan >commit &&
+	! grep ^parent commit
+'
+
+test_expect_success 'switching ignores file of same branch name' '
+	test_when_finished git switch master &&
+	: >first-branch &&
+	git switch first-branch &&
+	echo refs/heads/first-branch >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_commit expected actual
+'
+
+test_expect_success 'guess and create branch ' '
+	test_when_finished git switch master &&
+	test_must_fail git switch foo &&
+	git switch --guess foo &&
+	echo refs/heads/foo >expected &&
+	git symbolic-ref HEAD >actual &&
+	test_cmp expected actual
+'
+
+test_done
-- 
2.20.1.682.gd5861c6d90

