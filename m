Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E30C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 21:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjBFVTB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 16:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjBFVTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 16:19:00 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CA818B1B
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 13:18:59 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id g7so14524734qto.11
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 13:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhDb9GX7cKqEkxXAs2Re6h2AA64BV+VeqjoIoVOlvTk=;
        b=NaTAkIfC80pem9oC5hF11ITm4WFSrNP05wCxt+5y47S0yOrPevoYMsBCtZ+d8cg24w
         85MwQ7zvZMzLPZtxCKUflV9teOP56wrxt5ZUGnz+cP6ZRup+EeHOono4XTDDwnPwhEZU
         jigGDt6uvUTfjFyuFi3nauWJ/GzB8NXe/2K78jZHKK3bxOJUmR+NnW9R8JuKfN5MGEND
         LLsXX8li4xSC2FG0/hfVppWee8wu+NgrEpgpoyqGlTlMNVt1Y+CR8cjLJnapAppIKRqD
         cZ9G5ZbuSjBHXJ0uuH15TUufTIIm6Lgs3QC3oMyoLpIGFfuwGxNbwX0yUGA9kRJeu1e9
         r6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhDb9GX7cKqEkxXAs2Re6h2AA64BV+VeqjoIoVOlvTk=;
        b=oLFB3cf/LaGfV7UmRO5dQuUeZWRuowK27YTOcVqB2TlpThvhYpthwWDgREFG1EhxG5
         8a3B+kpMNrAM1MwT49OaqPVdYUpAutMTiL3hbeZyvjnV+Zbvh11xCxDE6TED8sOyfNi5
         DgIs1lyctvJa8GHqbfU3fB9Lc2/D9iqHbptGhd/LVpN8CXdBtn6EstRsxorVyVxA6AfX
         AZtZkjuRbWqLvaC8X222e3GgI+0+vSk4uwtF/OyPlB92w/1M75cTZ/SPoybzUnrjbyCC
         91eGgdOE4pkJ0G6sEU8gH04A7T59qMGoRFzNO6cvKEVHSxTgsu1WVqg0mhlP6ebnKmpa
         62pA==
X-Gm-Message-State: AO0yUKXuxkxo6R+/svm0MCKyKsazqjk9epbyaYMz6Z6BmRbOVVaFF0Gb
        mcjKg87SkTHNXn1mjCzeiDP2ob0J0N4G7Q==
X-Google-Smtp-Source: AK7set9XpP1eAGcbGtAFSoGNAZLBse46lthnBOkXLULOHw+/y2Bn7JT9SCzGMQoHu/H32G8+tZqhiA==
X-Received: by 2002:ac8:5804:0:b0:3b9:bb27:e116 with SMTP id g4-20020ac85804000000b003b9bb27e116mr1631299qtg.1.1675718337801;
        Mon, 06 Feb 2023 13:18:57 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id f11-20020ac8014b000000b003b86d5c4fbbsm8033014qtg.1.2023.02.06.13.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 13:18:57 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v4 2/3] t4113: indent with tab
Date:   Mon,  6 Feb 2023 16:18:22 -0500
Message-Id: <20230206211823.8651-3-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206211823.8651-1-cheskaqiqi@gmail.com>
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-1-cheskaqiqi@gmail.com>
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
 t/t4113-apply-ending.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index aa57895b22..5ee177e8eb 100755
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
@@ -49,7 +49,7 @@ c'
 git update-index file
 
 test_expect_success 'apply at the beginning' '
-    test_must_fail git apply --index test-patch
+	test_must_fail git apply --index test-patch
 '
 
 test_done
-- 
2.39.0

