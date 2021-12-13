Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F1CC433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbhLMQCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237294AbhLMQB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:01:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CA7C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id q3so27860945wru.5
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=Qgy3RTS9Qc3+BkJbb3L248VWvJ1ydNRlTGyaRtFsxJzODtVl0FnejZNLgY0YFi31ji
         WvY4H9tn/GhbN5/2hO6RalU83meTCUioEdD3XZnRcJ4wDCMAO9fihUENkkPvczo8J9Yq
         k0N6Cz8JwDUYInJVXe8PRF0er/KHqrZTn6RqLklekTlQ8bBrsmS5L/HvzQIpbUBMmVrq
         3N2MLjMBpHk4TdLONFsJlxt0ZyuUW7SR3Jkw1LRhFyt+qY/XF4qDkSalC4QJkRl1C1lG
         Ccv+LF66zRgJNF29bCvpB4/KqYNTQxQI/52nOeylOVxBhMAofGZf7pY7dM+y6XmfnJag
         lmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=FOij2mqaFH0PzHIehsK7oqVgeYDe5tyl7wMW74pOlvODhXePvwPy7Vp4XDiKQEDbhu
         l+uqM4fboFIpLTpT7267eDMTrp5Zga6X6U9ye/A+oNLXv9bDal5Y0Sl0oKn+IxOMu5Oj
         uQ7Wu1MYCsOY/2rMNy2VTWi2Pb4EfKmrglToMj/UuqNEO52M4P69bWh+YrHwwHoh0UxB
         ZhYMKJvcswC22VbyMH4nSC/zFXUH9RltwS7p7mQeAa6qiEXzTnsxIBWISEhYwLmgs009
         ZPGukEe2RIQlA5P0ZePvmue5n9w0XDhmxSxp8SW5aiVABigN3GaDDM5g62c2tmOP39jd
         MnEA==
X-Gm-Message-State: AOAM531F5+dkpcGG8FBxA/sknh5xpC6BNzLRrpDIWv34ci5ZrxEMYXg7
        ZDQEjccyApYY4pa1fn4pFi2f3XKGmZU=
X-Google-Smtp-Source: ABdhPJyijUErJFPE/GOAkKAGBgJbLKi/rQnOlJOnlACnmNU4+lJJ0Fz7OEfYA91eyLvFDMzkeNE3Gg==
X-Received: by 2002:adf:dcc8:: with SMTP id x8mr17714242wrm.684.1639411316814;
        Mon, 13 Dec 2021 08:01:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13sm8321496wmi.0.2021.12.13.08.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:56 -0800 (PST)
Message-Id: <1dda4ee717fc6465e95d22863f84975f79265a91.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:42 +0000
Subject: [PATCH v3 04/11] reftable: check reftable_stack_auto_compact() return
 value
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

Fixes a problem detected by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index eb0b7228b0c..d628420e63a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -814,6 +814,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget

