Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E59DC352A1
	for <git@archiver.kernel.org>; Tue,  6 Dec 2022 15:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbiLFPLU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Dec 2022 10:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235210AbiLFPKz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2022 10:10:55 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219CA2FFF4
        for <git@vger.kernel.org>; Tue,  6 Dec 2022 07:07:55 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h11so23823682wrw.13
        for <git@vger.kernel.org>; Tue, 06 Dec 2022 07:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9ugu4fNxtU1zAxW18abmRi61pBz5/hF5ZLMI568bLw=;
        b=RZMfdTkDgnouNjyMwguk5Nue4grZ6oeLIlM5e4VqO6DxLCIj+S5R3n7dq6e36+rh7P
         e2p3kuIsxSYTEM1pLesxWMNMrT2y6VReyzqFDkdpmZMegNcTWrloTnu6vBCO4CmKJ7TN
         etT1uA5LKGjRmDp24PLEZtyomv4YH9Ik4I/m2w6G7AOMMhFsjx6pHpnENiOo5pIxgjv5
         uw2Gh4NIwIAtDgJ+VfytMT+OcQwPLKo94trzJm5OmSg0hPZXO9fsmzmyAJjvDF4dPG+g
         gKCm0AgdRdxe5gJpVc7tLa8HpqDgPu/zZCh0nFULaYbjDsTIbWYs8V1p8oRrJP61+vD3
         VXGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ugu4fNxtU1zAxW18abmRi61pBz5/hF5ZLMI568bLw=;
        b=iGTMLJqR+lN4fiC8udqWeFWT/gUKH4MV3VmcqZXMT43ndU0UM29rmCtD03sgHqpG4V
         0A7m4QG/9dffLdesQlweeKltayY1J78K9bLD44DPLenBItXbKhM3adxlbPTA/G004Sl2
         /VP8Nsl+afRCKsXQm5i5hZ1aje/rGS92r0lbHnOhHHQZPeuLQgo21KZXHEcqdC8z3/Dp
         ausS9iE9otkulJxCc7EHweICK9CQLj9/Q5lVA/LoNJyGzmpKS6iB6cL0D6pR6KLxdoZh
         NNmEVSIQ6qyvLVZHFZFAkjbQbGGEqoEM7suviKo5g77vSYiZAV6wwqtVmTriju0/ICOs
         jFGA==
X-Gm-Message-State: ANoB5pnCp2goEgA6V49NysxsS1zUQ1MtK11P9OUTtR2GgPxF9L9I4n5U
        tn4gHSJjjAaxtIvq+8O6hmtP35f/D5Y=
X-Google-Smtp-Source: AA0mqf6l7zoEWVXd3YQtA8wd3bjGR+6tfIQvfbNicRC3ozZE7Hld7bYRVI/hHAUVVcWr9QCnF9MQsg==
X-Received: by 2002:a5d:6a06:0:b0:242:140d:43d5 with SMTP id m6-20020a5d6a06000000b00242140d43d5mr26485335wru.53.1670339270651;
        Tue, 06 Dec 2022 07:07:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15-20020a5d4acf000000b00241e5b917d0sm20568979wrs.36.2022.12.06.07.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:07:49 -0800 (PST)
Message-Id: <b38b8fb5a85e10d6189d68b6633adf23fca7b65d.1670339267.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
References: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
        <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Dec 2022 15:07:46 +0000
Subject: [PATCH v5 1/2] t0021: use Windows-friendly `pwd`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows, when passing paths from shell scripts to regular
Win32 executables, thanks to the MSYS2 runtime a somewhat magic path
conversion happens that lets the shell script think that there is a file
at `/git/Makefile` and the Win32 process it spawned thinks that the
shell script said `C:/git-sdk-64/git/Makefile` instead.

This conversion is documented in detail over here:
https://www.msys2.org/docs/filesystem-paths/#automatic-unix-windows-path-conversion

As all automatic conversions, there are gaps. For example, to avoid
mistaking command-line options like `/LOG=log.txt` (which are quite
common in the Windows world) from being mistaken for a Unix-style
absolute path, the MSYS2 runtime specifically exempts arguments
containing a `=` character from that conversion.

We are about to change `test_cmp` to use `git diff --no-index`, which
involves spawning precisely such a Win32 process.

In combination, this would cause a failure in `t0021-conversion.sh`
where we pass an absolute path containing an equal character to the
`test_cmp` function.

Seeing as the Unix tools like `cp` and `diff` that are used by Git's
test suite in the Git for Windows SDK (thanks to the MSYS2 project)
understand both Unix-style as well as Windows-style paths, we can stave
off this problem by simply switching to Windows-style paths and
side-stepping the need for any automatic path conversion.

Note: The `PATH` variable is obviously special, as it is colon-separated
in the MSYS2 Bash used by Git for Windows, and therefore _cannot_
contain absolute Windows-style paths, lest the colon after the drive
letter is mistaken for a path separator. Therefore, we need to be
careful to keep the Unix-style when modifying the `PATH` variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0021-conversion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index bad37abad2c..15482fa78e3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -8,8 +8,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
-TEST_ROOT="$PWD"
-PATH=$TEST_ROOT:$PATH
+PATH=$PWD:$PATH
+TEST_ROOT="$(pwd)"
 
 write_script <<\EOF "$TEST_ROOT/rot13.sh"
 tr \
-- 
gitgitgadget

