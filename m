Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB1FC4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 22:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbiKLWHt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 17:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbiKLWHs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 17:07:48 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B513CF7
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 14:07:47 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k8so11008634wrh.1
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9ugu4fNxtU1zAxW18abmRi61pBz5/hF5ZLMI568bLw=;
        b=H1d51LG696pQSzTeUDDsZZjrdezV5og1JQxRsUMMm8bB6ED1/psT77KIeeVkk18k+u
         2tF5zZnQMgV7+XnTau2Zv08UgsPyP/R+QOkCITFDh9/dptaznB9gzK6MQIAkrCOWTXKO
         fQNbT2ErIJhOMwNW0x6DcnVQcsDN0AP2BWlMwvyor8lk+PX7GJ6ujUhSxXK8nf2nYldj
         UC4WuvHJj8sY3L4H3b1zgTPaZbDDxv8oxmjevwG4W26s+bZ5c5FjBmFtToNlq6DdVZHr
         3YptGq3BTsrLn0cTY1lOnSSMFuRE0aJMnLs+TELagLCyGNsVh9HjiTJ0mzJ6obZfpFwE
         pxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ugu4fNxtU1zAxW18abmRi61pBz5/hF5ZLMI568bLw=;
        b=h2YcMA+r07jsBCYNvgVt4Tzut8Addfob0mx8/knGm4a33MqZYgZrlAo+G733Bg+iup
         VVpLjUFxbBeuzsRNoOTi2Zo4QoC6uFQxo9m8AbwmoKZeh6bgcbYHgL3VYgrhdoUyN4/Q
         YECBQHM5uaNbOGjTNWq96AglmG29k1XXWKGZyK05CqHTZ22hZTRyWxvf4R9GqJv8T15c
         x0VQAnyw50BPXkeUpRAKvy5SUDSkrtOeCUcgeisTn1+BqCPHvMiNNNv/5sw8Q6XUg4MS
         EDeRABo+ckORsUciEjPZ31tYTspEN6Gf8pbAlKYKvBVBxMpqJNKTofneyHhgjQkAlL27
         HZCQ==
X-Gm-Message-State: ANoB5plEI4nplopekJhyLsJAdEnwRwBtDr1DD+OgzcEKU0yKH30KfdiM
        0wKOG4+gBO/3KwwOL+2hAuCVNXhf4AM=
X-Google-Smtp-Source: AA0mqf7uUuGwGk9aopkyqkC+Jl5FdwqlbSv6xvt6+9FirlJ1FYJBHvOTgZ22wexCrLCl78Mfq33edA==
X-Received: by 2002:a05:6000:691:b0:241:7e9f:8afd with SMTP id bo17-20020a056000069100b002417e9f8afdmr1564138wrb.228.1668290865743;
        Sat, 12 Nov 2022 14:07:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c1c0700b003cf71b1f66csm8294790wms.0.2022.11.12.14.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 14:07:44 -0800 (PST)
Message-Id: <b38b8fb5a85e10d6189d68b6633adf23fca7b65d.1668290855.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
References: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
        <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Nov 2022 22:07:33 +0000
Subject: [PATCH v3 1/2] t0021: use Windows-friendly `pwd`
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

