Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0550F20248
	for <e@80x24.org>; Thu, 28 Feb 2019 15:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389115AbfB1P1u (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 10:27:50 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45823 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730287AbfB1P1t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 10:27:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id f19so7930645eds.12
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 07:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w9D51nzePpOyGIwULQ/4KBCN7t8Dy6bXd4Z3X/qKuvQ=;
        b=O2zFk3pswYnXlS9IjhTIowQVn22uwW/FFz2xHUubD6AnffjDXeUxEn3awcIYTTEXa0
         rZBt2D+vXF0QhQFbwelKP8S8GPE3UVnaKsIa2u8gj9QmcNzIewAn7m9brudE5D4ywcik
         S5uaix+owMqNzk1nq1TVs7pTJsUrOXCFtD7VBitWmsrf2cXBBXSfCkrLxofLy3rjJ6CO
         /ZYIE48yAmfxvyDumuS11rpY2LN9OuRAuIRKrizN+7fApESAxpGY3vL6rsZZUdR2XS2x
         BUHkypddlP3PrY1mR/wvU6u5HHYsdoy3+saZ1V5lu6G6PwRwEt9OyW7qdIQHwwkkK7as
         5fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w9D51nzePpOyGIwULQ/4KBCN7t8Dy6bXd4Z3X/qKuvQ=;
        b=ka6G3iwFMvYlr72U0ooJJOP16hU55Q2zS8LikcIhENlfX59ayCniA4IHCTOrmC5MM3
         QVJ0au1jZy+AovBXwS6KpWwfZ9VOstwVjPSt+ibXuxChrFdKIcPAc5Fw4ForuMzYyy7J
         bfytmxyUtHZmikB2FTlQG48esyXCyjhH2YHL19B0lvH0RM3OcLp3HCUlhJCRkNOuLUgo
         2QR5ebooVjm1Nu1dqUcX9rVc5JuMK4L2bZWXdmy+p/8n9PI4KKC1wvv1OH7fsz5tatDH
         oOlmxSL7G3qHQtJtMWPeu3Zui/j0eFsFxdIDDs8GSh4vZ6idLJn54cV0yjPWl/j8GOcY
         +XnA==
X-Gm-Message-State: APjAAAWjZHzxHlO0NvAihpA1oxhWSWkZXXmIyMCVfkp3GRO0qQNgGsLd
        TqI2F8DHpZxJS1iTTK4e8tpxt1B+
X-Google-Smtp-Source: APXvYqxCVEiAV1Wk7Vp08G0r/1bt0f4tydzP97ufd4RJJ25FYcD0sJLh4fZZpAE8XoUe2pbbCRgJ5Q==
X-Received: by 2002:a50:9012:: with SMTP id b18mr166567eda.30.1551367667503;
        Thu, 28 Feb 2019 07:27:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g20sm3279735ejk.72.2019.02.28.07.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 07:27:47 -0800 (PST)
Date:   Thu, 28 Feb 2019 07:27:47 -0800 (PST)
X-Google-Original-Date: Thu, 28 Feb 2019 15:27:43 GMT
Message-Id: <1bc3cbad265926d963655a0112db74e2c655adb4.1551367664.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.153.git.gitgitgadget@gmail.com>
References: <pull.153.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/4] built-in rebase: demonstrate that ORIG_HEAD is not set
 correctly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nazri Ramliy <ayiehere@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The ORIG_HEAD pseudo ref is supposed to refer to the original,
pre-rebase state after a successful rebase. Let's add a regression test
to prove that this regressed: With GIT_TEST_REBASE_USE_BUILTIN=false,
this test case passes, with GIT_TEST_REBASE_USE_BUILTIN=true (or unset),
it fails.

Reported by Nazri Ramliy.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3400-rebase.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 3e73f7584c..7e8d5bb200 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -59,6 +59,14 @@ test_expect_success 'rebase against master' '
 	git rebase master
 '
 
+test_expect_failure 'rebase sets ORIG_HEAD to pre-rebase state' '
+	git checkout -b orig-head topic &&
+	pre="$(git rev-parse --verify HEAD)" &&
+	git rebase master &&
+	test_cmp_rev "$pre" ORIG_HEAD &&
+	! test_cmp_rev "$pre" HEAD
+'
+
 test_expect_success 'rebase, with <onto> and <upstream> specified as :/quuxery' '
 	test_when_finished "git branch -D torebase" &&
 	git checkout -b torebase my-topic-branch^ &&
-- 
gitgitgadget

