Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D399FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbhLVS4w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344960AbhLVS4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:44 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0EA2C061756
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso2020567wmf.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7hrVqwDEsCy4jvGx2ygf2ufkTVUbjR+/cx/GyTSeOVg=;
        b=PooCSs4+UhraBHChon8vgD80jAgb27qqJI6/jon/r6xuB/OXAylmOKdFCGDZeTn7MP
         2SUOjgHQH5PewZqjCNETVq98E3s1VoAfRFLP0/+n/GQXO1pj6Nv+G/Z6k4H1T8OY4q31
         RhKnIPYxUvi6GGwTzOm1o/ue6I4WeYmjOnzsSfSWYX0HCOrGDqauYRCpQSULtqOCJ6oQ
         1JJBYEUnsYfEVNnzCRgSq1rkbXnw4LMAjq6Mo+RF541MxwMqQ7HKwJ5lWrHZ/APpr/zv
         4l/3J96HNKrK917caeyqwO+G2OOXlZ6bIKaP2mbqpfVzh9mLt9ZmERz8lGXYtCExcZH5
         nVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7hrVqwDEsCy4jvGx2ygf2ufkTVUbjR+/cx/GyTSeOVg=;
        b=h8r29F7uINRlXutxBHvomHtNzZe+NqYSdg+f+fgraA/jOHGT2HYongFvTZWv14PQ/J
         Q1KOkpk6ezcn3p07Y0q8rZNHE9fXECCY9+ZwxG4YY+KKh78ytZOyU3L2hBnHpxL83TH0
         fGGiKcqnoHtJnTOCHnAPoJvnILsOwYeQS975e9Z9bDXh1/G/vj21vHzkyK2zuObyWDP9
         oPTPXjYUrxSeVK7zAVLSFFCGLp98SJQ3SIijOvQO5g+X1gKdNmo0+DOMjSLRkfjKEUls
         hg8xx3tZrVsRYfqs3IQ+vLnotvYrnL40i7SeQBzz/5WewmMKjw/mJWxMTs2MJ6wiyu2f
         5ZsA==
X-Gm-Message-State: AOAM530eHiwkjXJxIqZscQMaK3GXVMEIJNJHeV5KfCbf2kYrEnmaBJOX
        u3JIRDfD5kQzP97j82AdElOuDyBWbfM=
X-Google-Smtp-Source: ABdhPJwMEc6iibsI/Ez8FKx6bY/nwTUrvw4TNJHHYrHALDOIWzS7lpAPr8m215BfHaNt4MZ8hYCyfQ==
X-Received: by 2002:a05:600c:4e91:: with SMTP id f17mr1808165wmq.195.1640199402402;
        Wed, 22 Dec 2021 10:56:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y13sm3092564wrd.89.2021.12.22.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:42 -0800 (PST)
Message-Id: <f90846cc103b8b04ff62ce1f942ee1cd0383573c.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:28 +0000
Subject: [PATCH v5 08/16] reftable: order unittests by complexity
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is a more practical ordering when working on refactorings of the reftable
code.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/helper/test-reftable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 26b03d7b789..1f0a28cbb64 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -3,15 +3,16 @@
 
 int cmd__reftable(int argc, const char **argv)
 {
+	/* test from simple to complex. */
 	basics_test_main(argc, argv);
+	record_test_main(argc, argv);
 	block_test_main(argc, argv);
-	merged_test_main(argc, argv);
+	tree_test_main(argc, argv);
 	pq_test_main(argc, argv);
-	record_test_main(argc, argv);
-	refname_test_main(argc, argv);
 	readwrite_test_main(argc, argv);
+	merged_test_main(argc, argv);
 	stack_test_main(argc, argv);
-	tree_test_main(argc, argv);
+	refname_test_main(argc, argv);
 	return 0;
 }
 
-- 
gitgitgadget

