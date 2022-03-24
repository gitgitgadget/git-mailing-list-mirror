Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1250C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352727AbiCXSgi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352723AbiCXSgg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:36:36 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449D549CB9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:35:03 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a1so7852761wrh.10
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Msrw6N6zWhpn6WlfX1IZpiD3eqdVEuOsQYMylnKan4w=;
        b=FtJLgrKmpgFp4tufho3ZC4GjgYBcjCESqUIunP0DF7htoaw1/Y2OulzB3c4NMM4gNQ
         wa2cCjXLlovtGczWn/GnnQPhlCg0FHD1expMFSg15dD/xM9FxpOvYv4JTV8wWsZrFTE8
         kJwByQnLfyUhiJW3H5tQ02gvBQcw4M5p9hCoG6X4cqgTI7aHc7Ymrk0MJ3usdC0MqBNK
         gOifrJ8vwCY+JwVDMsjEv4rqF9xmdhdaCvh4RyqQY1CZQogIjrtjDfqgaoTDx8LsXZEL
         BuA/tmw96iSmGy+aI98weJiqN6i8oseniUPwQL/N+/z109VCM9WiNoUu6uCUCaNaGKJR
         fNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Msrw6N6zWhpn6WlfX1IZpiD3eqdVEuOsQYMylnKan4w=;
        b=fcu6dp3pLP/Z+A0zMhnGfzVuuv+GtRGCf+2cP7qo478BRirjGALqAWGw+F3IdZfXB1
         R3j7zSkquReLFMJLJLLQVnQuYQXn/xQy1omEFsUE+bPX/A/+gOAyNVwaWeh9WJJ0sC2M
         JqsfaPP3zOYL8khbn+EwaBa4Wj4BppGfxkAZLZQF68p1toBcj+x+aW7aMg3zNChAVVKH
         q2EJoyotioNsUD3MA1pQ/Uh+4EDOKrpVVkib3wK3YdjYxv5LQi6cKVjXZZNzkr2+OyBj
         wg4WceZOOzBc9HqqJHICmFBxhZ9qnxenUmaUf/2deGJNrT8bd3O2pG0rZrlFd9XiPv3X
         rvHw==
X-Gm-Message-State: AOAM531B2BmbofsKuswbY1oMN66UScVtYGERpvAetMHrhUyptcnryU+/
        xEiKd2EVQw8ff8fsDyWB6sz0Arolcf8=
X-Google-Smtp-Source: ABdhPJxtruyE7PBWZxb6kR7s6d4Pt+MJxJ/6RrTaCVCCuXecskTyCGCOx2CP0Rm7WNqpxKH8PcrsrQ==
X-Received: by 2002:a05:6000:168e:b0:204:f90:de02 with SMTP id y14-20020a056000168e00b002040f90de02mr5871532wrd.108.1648146901554;
        Thu, 24 Mar 2022 11:35:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n37-20020a05600c3ba500b0038cc9d6ff5bsm2923881wms.4.2022.03.24.11.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:35:01 -0700 (PDT)
Message-Id: <ed67b7489719a01c88d7a6765e7499c1157da32e.1648146897.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
References: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
        <pull.1185.v2.git.1648146897.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 18:34:57 +0000
Subject: [PATCH v2 2/2] test-lib-functions: fix test_subcommand_inexact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The implementation of test_subcommand_inexact() was originally
introduced in e4d0c11c0 (repack: respect kept objects with '--write-midx
-b', 2021-12-20) with the intention to allow finding a subcommand based
on an initial set of arguments. The inexactness was intended as a way to
allow flexible options beyond that initial set, as opposed to
test_subcommand() which requires that the full list of options is
provided in its entirety.

The implementation began by copying test_subcommand() and replaced the
repeated argument 'printf' statement to append ".*" instead of "," to
each argument. This has a few drawbacks:

1. Most importantly, this repeats the use of ".*" within 'expr', so the
   inexact match is even more flexible than expected. It allows the list
   of arguments to exist as a subsequence (with any other items included
   between those arguments).

2. The line 'expr="$(expr%,}"' that previously removed a trailing comma
   now no longer does anything, since the string ends with ".*".

Both of these issues are fixed by keeping the addition of the comma in
the printf statement, then adding ".*" after stripping out the trailing
comma.

All existing tests continue to pass with this change. There was one
instance from t7700-repack.sh that was taking advantage of this
flexibility, but it was removed in the previous change.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..8f0e5da8727 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1811,8 +1811,8 @@ test_subcommand_inexact () {
 		shift
 	fi
 
-	local expr=$(printf '"%s".*' "$@")
-	expr="${expr%,}"
+	local expr=$(printf '"%s",' "$@")
+	expr="${expr%,}.*"
 
 	if test -n "$negate"
 	then
-- 
gitgitgadget
