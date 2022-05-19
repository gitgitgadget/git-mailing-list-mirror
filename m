Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07161C433F5
	for <git@archiver.kernel.org>; Thu, 19 May 2022 17:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243505AbiESRyD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiESRxa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 13:53:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5313D29
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso5494428wmh.2
        for <git@vger.kernel.org>; Thu, 19 May 2022 10:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2IlzxJ7VZLFYW9FoTSMVdEvLGG9ryAdgqq2Dl4y6yJU=;
        b=fB06fFnhM4qX3LUifp9wCR50JL/17ctaz9gpXiScYUQnuU3hxl25DffVwSpHtJsnnp
         NzCDfw3xSrVzgfvwnnbfBFxJjpBkek+UmykQJ8CbVQGRRiByFVOTWPOul9bsmuxViJb9
         rcDEQeJPZHbA3ua3qc4zV7hEw1/f8ULARs8CHswFUdWnDElo6yOr1We4CACOdrXTmvJB
         btAyJ9VbDqR+u7szUCVLFDRIyh6aomZFkJvOhmNEzY6ol+W+AqXeM0CIC+Pyb92iE/d/
         yi9IExkLpQXbNBKAC9w8HvtRWi+J6xg7IPoCYZ9fOnZ4LFinKZ1H5Bq96/Slz3kLBvL2
         05MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2IlzxJ7VZLFYW9FoTSMVdEvLGG9ryAdgqq2Dl4y6yJU=;
        b=UZG2yJQZhWaOtX1HnuZlBeu32wtEWXAN2LJjtSnfilVomzaq+PolpcXmfIYoSzyfwz
         /wwI0kZzdWOGXDcgEqF6S8/5FSCbZu2ACEoi6uY99HTdw0Ov+KxCfyw/2UDOXqWSNq1X
         bx8bx7mTl3k5a37YQVnC0+DDclkiKUa6uiAAMSpnVsIIzlvQX8XN0WP4+6CywbGU2jW1
         cfqseihFIV9Pi/Cg8epqctn8OCtGQPSuS1ItyJiCU8aT722eYB6P1/jY2O1dWK0kglBu
         gQ4uPAM9Y7FFvBHXwnUmMl/aZp8fJsqs4iY7+OZLhbpDi7kaEKSs3vk5wpNl25tSPtpd
         NGhQ==
X-Gm-Message-State: AOAM532XDUK6aSMyyuaUcb8J6rqVZ4ebC1edddBLQO4xaYzj1lHEya9F
        cJhj08iGzoJeYi8gW4OkbyatQ4eN8GQ=
X-Google-Smtp-Source: ABdhPJwQYIGoBD5y4CGKbtqdcFsRuivtFk6GtF6rv8yfmQ1FEn7SudwfOzV7vHTVZQy4ftI3J1H85A==
X-Received: by 2002:a05:600c:3b11:b0:394:57eb:c58b with SMTP id m17-20020a05600c3b1100b0039457ebc58bmr5291236wms.3.1652982770560;
        Thu, 19 May 2022 10:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o17-20020adfba11000000b0020d11ee1bcesm182544wrg.82.2022.05.19.10.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:52:50 -0700 (PDT)
Message-Id: <089ab086f584054a7b2bb8a2868a01c545e38d27.1652982759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
        <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 May 2022 17:52:37 +0000
Subject: [PATCH v2 09/10] p2000: add test for 'git sparse-checkout [add|set]'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The sparse-checkout builtin is almost completely integrated with the
sparse index, allowing the sparse-checkout boundary to be modified
without expanding a sparse index to a full one. Add a test to
p2000-sparse-operations.sh that adds a directory to the sparse-checkout
definition, then removes it. Using both operations is important to
ensure that the operation is doing the same work in each repetition as
well as leaving the test repo in a good state for later tests.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/perf/p2000-sparse-operations.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 382716cfca9..ce5cfac5714 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -110,6 +110,7 @@ test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
 test_perf_on_all git checkout -f -
+test_perf_on_all "git sparse-checkout add f2/f3/f1 && git sparse-checkout set $SPARSE_CONE"
 test_perf_on_all git reset
 test_perf_on_all git reset --hard
 test_perf_on_all git reset -- does-not-exist
-- 
gitgitgadget

