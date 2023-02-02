Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D27C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 17:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbjBBRUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 12:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjBBRUH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 12:20:07 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FA673070
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 09:20:07 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id g16so1043685ilr.1
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 09:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmhkVegYjW20jRBrrgoaQbpNTKvLPJa0MWNb5fbJfB8=;
        b=DhodbnPy0IevcOzRJnfo44WcmlPk5f/Oob2n7e7TU3Xh/P+dAa3+qqhfai+C4aEMbN
         U3KIzcqogmJGNwjPeWWsoonWIRFSdHKC7+OU6V94mt8aLi4Jc5/Fb5BquHJYwWjeUTSL
         53KFQkYzYXGkqiPrpzWC6tXQ8DhB4DpJPqefMZSvSCLs9SAG2pc/mfXWTJWfuCzCPlpT
         wm+72K/WIr00rXZ4I2wzhoKKPRmL+F8xQnZrk8h9lLUcRYIQo6f18V15txl/avs1TATz
         lrOiwejX3xT1yIas/IBCMBiohgTDr73zMl0Qx7FBiXsyKMCXXTuVCrgFD257erS4a7rW
         qi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmhkVegYjW20jRBrrgoaQbpNTKvLPJa0MWNb5fbJfB8=;
        b=hrRzOW8FGpk1zEqFj4bAzHIp91KX1zknZZhGS7hDJ3B/wPgIRAZgYSoCgtybKF0gKG
         3ZNMzDY5j6cF9Ej6aqikiPThRKxrTp5uAUakLlpHdBNC79qMMolX1I0EzkIjtv52iMVH
         yVso7uQf/Yg0l+CRJSDZ3wLKrYymT+avy9Jn6dPpEklraiLg2Arm97NYjmIGk9qOaNRN
         DTGOIZUJxfpIf00DUnXXdzWLJSAPbko239GTKAwfEhKbJTaAiID2NlGaOy8nLi7hel0P
         H8dN49TeRj0lGfCOHrsdWZ7UUKAPwaHlj9ae3llYMX3Xn4efSXjWwsQ6EFI1Uus8P1Q2
         iDSw==
X-Gm-Message-State: AO0yUKVhPV3Fex9X0G9UvvP8DQ69vPN4vooEpMpMmCpdyRXtpmwlsqp+
        tueP1xxwaIIKaDRrWijmsC14uhHpBOxe2A==
X-Google-Smtp-Source: AK7set/YqW2DBWm1IF5IJCA+3pSyDLWq/i9Tl/NR8yqvdlTrZu7wCezLloosFHu+TyzGe0fGM9NLKw==
X-Received: by 2002:a05:6e02:12e7:b0:310:bec9:72f6 with SMTP id l7-20020a056e0212e700b00310bec972f6mr6049538iln.13.1675358406389;
        Thu, 02 Feb 2023 09:20:06 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a3-20020a92d343000000b0030bfdb6ef60sm55887ilh.58.2023.02.02.09.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 09:20:05 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v2 4/4] t4113: indent with tabs
Date:   Thu,  2 Feb 2023 12:18:21 -0500
Message-Id: <20230202171821.10508-5-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202171821.10508-1-cheskaqiqi@gmail.com>
References: <20230131224929.2018546-1-cheskaqiqi@gmail.com>
 <20230202171821.10508-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t4113-apply-ending.sh used 4-column indent with
space,fix it in use tabs for indentation.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index d5b15e97d3..9e28c72355 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -23,11 +23,11 @@ echo 'b' >>file
 echo 'c' >>file
 
 test_expect_success setup '
-    git update-index --add file
+	git update-index --add file
 '
 
 test_expect_success 'apply at the end' '
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 
 test_expect_success 'setup for apply at the beginning' '
@@ -48,7 +48,7 @@ test_expect_success 'setup for apply at the beginning' '
 '
 
 test_expect_success 'apply at the beginning' '
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 
 test_done
-- 
2.39.0

