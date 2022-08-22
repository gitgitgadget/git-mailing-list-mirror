Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0156FC28D13
	for <git@archiver.kernel.org>; Mon, 22 Aug 2022 18:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236333AbiHVS0v (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Aug 2022 14:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiHVS0r (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2022 14:26:47 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708AC481D0
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so6479460wms.5
        for <git@vger.kernel.org>; Mon, 22 Aug 2022 11:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=8GjrBUDxUA+1dHZ1zMyoVoPCKa7Y1oWgKjXqnJ6/uuU=;
        b=Rs3JVi/20iQHiH2U3gA5TBhDvii/enhAHkeIo4ew2GIfJJHB+PzOEcwLZE554zi62L
         ez6WSMFVpiUxaRUGsyWbWKurIoNQVkVVuZ72XquFvCyEa7mal8IphvQWJuivj/OBiEXF
         PhJIbbwak1bcrwgOqeYei/tbiY3Yl0qcBVKAd4qTI2+JS1gAVJxGbEqBAEkX8U2UX3bx
         bCqGx8NOWm8L0aMs/jMOt40ove14Zvu31cvwpkc/+5RCgKwNExqsLIFQRoMjjqQF9/+U
         aNev7rZtu4lV3OxhF2eojsqJfu9FW86rQ0ly+Fi/aU8QCwxfoEtwPT5NOjWTbHutr63V
         YIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=8GjrBUDxUA+1dHZ1zMyoVoPCKa7Y1oWgKjXqnJ6/uuU=;
        b=2YW8YqTja3pQzFcstdwkJ67nOSZ02eLFdlhNGgVyaMtSnCRm/cFSrSyjmZetfxMW1q
         WzPvK4QFNPpCzBZC0F2jHZDWvhIVvN/5UD+rGXR9x5s6JCDy93bm+G7f2ZVThD/4cDpb
         fJY0VXo1/mPbJSgyzxFFdcGYTLuA5q7QYi62zmre+aLV9UX5ay9mLOb0E4rmuABK5Pe1
         Mr7+SCWml55kYWTKzYyrkIGNBxPZ9WaklUY9usETA0gxZawt6ojSYGXlWfxIczH+L+tV
         3FfD0ypRouBZZaANFsuFJErH0Pxa08Zi2dj8/RFhZbMQc26OLdFDxvYm6MPmhrgkW120
         nFew==
X-Gm-Message-State: ACgBeo3OTPiYvdIs9qulgQPMaE3WPO6V9IiFAiBPIWC27c2/I45HpqIW
        XOM/8YjJCfWVP8IkaVZIYHlYZOxlCiU=
X-Google-Smtp-Source: AA6agR6WsLNrVgNldvLp3rA1QGEENlXNmAmwPRnUEjyYz3E0N4AX5NrFV8glZPMvHpLTK3QgCBUt7A==
X-Received: by 2002:a05:600c:4e94:b0:3a5:b7e5:9e64 with SMTP id f20-20020a05600c4e9400b003a5b7e59e64mr12987378wmq.26.1661192804747;
        Mon, 22 Aug 2022 11:26:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe44f000000b0021e4bc9edbfsm12144948wrm.112.2022.08.22.11.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 11:26:44 -0700 (PDT)
Message-Id: <15d7520479f412d13de17c323311aba077043bf8.1661192802.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
References: <pull.1312.git.git.1661192802.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Aug 2022 18:26:40 +0000
Subject: [PATCH 1/3] t2407: fix broken &&-chains in compound statement
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

The breaks in the &&-chain in this test went unnoticed because the
"magic exit code 117" &&-chain checker built into test-lib.sh only
recognizes broken &&-chains at the top-level; it does not work within
`{...}` groups, `(...)` subshells, `$(...)` substitutions, or within
bodies of compound statements, such as `if`, `for`, `while`, `case`,
etc. Furthermore, `chainlint.sed` detects broken &&-chains only in
`(...)` subshells. Thus, the &&-chain breaks in this test fall into the
blind spots of the &&-chain linters.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t2407-worktree-heads.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 50815acd3e8..019a40df2ca 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -41,10 +41,10 @@ test_expect_success 'setup' '
 test_expect_success 'refuse to overwrite: checked out in worktree' '
 	for i in 1 2 3 4
 	do
-		test_must_fail git branch -f wt-$i HEAD 2>err
+		test_must_fail git branch -f wt-$i HEAD 2>err &&
 		grep "cannot force update the branch" err &&
 
-		test_must_fail git branch -D wt-$i 2>err
+		test_must_fail git branch -D wt-$i 2>err &&
 		grep "Cannot delete branch" err || return 1
 	done
 '
-- 
gitgitgadget

