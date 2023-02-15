Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB42FC61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBOCkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjBOCkp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:40:45 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24E0234D0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:44 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id m12so20500919qth.4
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhNQlDKUjRXmK5rcweYMF5p62ggFuazYB7/5iE0iZ7Q=;
        b=mPGr6AaUXfimrkzkoromj0b54f/qxPu4WcBidVIaaimP2VNvx7eQWpBfImiylTO0mE
         j+H32XutCMRqwjCSDjB5FfV5hkNEq81N+tg4w9pyRIWEfR1sLzk3+Nr22FIBhYj+thSN
         zVhO+STcj11vZMCfj5juom9ue/H06uIlqHbbrSHbnm6haw1oCpxWYqgVGQV4EXMrSzmt
         BB9QxpebjMrKUWlw2+79VXeuObVd8l/8slLuYOHnzd3z1KPrpyGf5KyT7+w3HnnwXCcA
         GE+iMW7G6TPO0nVHa3uvnOgTmikN7ssHRfxZ5zoFmcI4g/otaPs1MmEB/ZcGDyXKklJD
         s66A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhNQlDKUjRXmK5rcweYMF5p62ggFuazYB7/5iE0iZ7Q=;
        b=AsCBsZcB5ZXaCmmbgUWot5NZUUdrzUDjuRsxIg2iC6IEuVmf+bYruqbW4OCxA/I8PE
         E5qL+Wzeys1R4QR9WI7yB2wx/Z1Uuimg8q3lmczfl0wKk8uJYFc0HB1dXjyo9hV3/8Ul
         X9j4W1Quk1t7fgzXlOKRG/2TSmt0crJOfWJfFdyuDp15hteBpnsw+4Jifxr8xgVFe9ge
         UrSiesYYNKnMOnf+RdE8Z64YoNASehcAu8RtAIgyDkeCI8Mo55qplG8kvjzTieUZhC4A
         VDPxfw3Yis3QAlepMcFN/V9NXtC1+bk4KB5tjk2nG3ey1Vb30qi2dqsuEcNOgsVxzxl9
         pi+Q==
X-Gm-Message-State: AO0yUKV8ikKUC7P2R5r+NLC1ltjhOjknhPXdhbvP9qP7n37WRob5Loww
        VFka336jbZTIf4SecgMgt1gi4O1tQHpzvQ==
X-Google-Smtp-Source: AK7set/Cryf6L1qX7td9t44E/YbNezUwnhc9KiPyUrRCnjbITztRD0205rpDblJhdc81T3KMPY285A==
X-Received: by 2002:a05:622a:1207:b0:3b9:e0b2:9a49 with SMTP id y7-20020a05622a120700b003b9e0b29a49mr749385qtx.60.1676428843718;
        Tue, 14 Feb 2023 18:40:43 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id e184-20020a3769c1000000b0073b69922cfesm1069734qkc.85.2023.02.14.18.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:40:41 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v6 2/3] t4113: indent with tab
Date:   Tue, 14 Feb 2023 21:39:52 -0500
Message-Id: <20230215023953.11880-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215023953.11880-1-cheskaqiqi@gmail.com>
References: <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230215023953.11880-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, the shell scripts
are to use tabs for indentation, but this script
uses 4-column indent with space. Fix it in use tabs for indentation.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 41526ca805..a470c9ce7b 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -25,12 +25,12 @@ echo 'b' >>file
 echo 'c' >>file
 
 test_expect_success setup '
-    git update-index --add file
+	git update-index --add file
 '
 # test
 
 test_expect_success 'apply at the end' '
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 cat >test-patch <<\EOF
 diff a/file b/file
-- 
2.39.0

