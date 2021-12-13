Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC533C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhLMQCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240127AbhLMQCC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:02:02 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62C0C061372
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so11885798wmc.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QXR/sCky+QzBjnekojKvC2yp3qKk1a+wpL2bGIhq5Zk=;
        b=jcQ1CZ6PKd7la5uUAlOQrXYDXwHqPRhE8JQule1OhqkpA19X8poaw13cF3NUoSLMPy
         AoLoNX/0firFeXpVjz0iVlXgdr/uUseSI4nCC1vBnW9ZZdZu+rriLJ8rfwzvGzqKKq4P
         Q0X4K1IJwhegJAFvX6EiFrU5IXrZ6dCjIOPyV91623WD7IhTLzZ7C+1Bs6xMGeYfr0yD
         tA5siuItNJAVvBZBhlnnL2d8mVt7Y1wC2mbhHHG7gHrG7ufj6PkyjpDDa3VSyvs/b5Zr
         +uSP4fb9qgdnpLjNmgFDni1xasH7nJQkHdoII9D7iJycH8XIRoXuNwBTbmrLJx4HFojC
         wszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QXR/sCky+QzBjnekojKvC2yp3qKk1a+wpL2bGIhq5Zk=;
        b=TQJquyQQNNFPsvSVAyAYPNmY2xwBlkOFlCTqkqzGyoQ/ZZvH9sngckO5bwjBAghOt9
         RmJE5Z10qVf5AoWzQ8CtZfEQN2YCe0NoV22RNvw+M8xik8xLUPCQyiygg9Biy5hTqKrk
         A8FKj5+g7kXGWcGT3mPYcxY5nLD/dRQZHlEJKdWbLG/dHI9OL/uiEC3j8+BsrqPSLU4u
         r8um2NzJxG7gpDjcFmv6EsSt9M4OCOeDh7DhJD6Tb7C5sHkCtbVTcI57m2SZlfGCw6rD
         BKD+nYpSJwyn4e0EKnlQiWwolgMi702ghVsgficXDbDQf0aXkvcAVG5OgNiwTtFs8ckK
         gjtQ==
X-Gm-Message-State: AOAM531URLh/OV3ChA/jOq9RS5tj4xtJuEb34ZaS+aVhG1EvhUDNe3BG
        /qqI6O0NnffbcGKSt2509Ch9QK0SwLU=
X-Google-Smtp-Source: ABdhPJzMmlBt3xG+3Uclzm9RG+gjYOp3nPWG4HCA3bezHgjSqYYLoOIclQXwz4Ef6b/kX15jHsnUbA==
X-Received: by 2002:a7b:c24a:: with SMTP id b10mr38200694wmj.166.1639411320150;
        Mon, 13 Dec 2021 08:02:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm10998257wrx.25.2021.12.13.08.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:01:59 -0800 (PST)
Message-Id: <6b0af68f0b94fb96c81e25f9a1911fa05dcf07fd.1639411309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
        <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Dec 2021 16:01:47 +0000
Subject: [PATCH v3 09/11] reftable: drop stray printf in readwrite_test
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/readwrite_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/reftable/readwrite_test.c b/reftable/readwrite_test.c
index 42caf0bde4c..f6546d7b8d1 100644
--- a/reftable/readwrite_test.c
+++ b/reftable/readwrite_test.c
@@ -663,7 +663,6 @@ static void test_write_key_order(void)
 	err = reftable_writer_add_ref(w, &refs[0]);
 	EXPECT_ERR(err);
 	err = reftable_writer_add_ref(w, &refs[1]);
-	printf("%d\n", err);
 	EXPECT(err == REFTABLE_API_ERROR);
 	reftable_writer_close(w);
 	reftable_writer_free(w);
-- 
gitgitgadget

