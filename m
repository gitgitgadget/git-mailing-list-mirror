Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E7C4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 14:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236762AbiKNOHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 09:07:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236724AbiKNOHN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 09:07:13 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1462B1BD
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a14so18469381wru.5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9ugu4fNxtU1zAxW18abmRi61pBz5/hF5ZLMI568bLw=;
        b=KGcMNMv7Lk0Jug+u7BaMrd9BIwUYDArrZ1gCKmZqsBOL9u7aWFpG16ZJGG2offqjZX
         XenUPEJ7zJ8XQa5vUEmdGpHOY2Em1PUYPOBxxBnvRk8cyoTKF9L5/wXJXyNv+fH19SpM
         Mtn3MS3+Y/KGQZVbfCL/KuUX+G1KpsWFWUOwQf2opZnOW3vflehrIiG4HSr9hl1b5Yr4
         POX04k+G45dKRr+U5FkSYCUDYAKVx/haFHePs71yNR0EEswzKUcCDTlgDXLk6IoSzl0U
         w0L9v/+8IdNjSDDgF6XbLpeJYSQFtc5NdEpQHUwZLC+O26Z0PGi61r2FXxTsggCHbQMm
         dHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9ugu4fNxtU1zAxW18abmRi61pBz5/hF5ZLMI568bLw=;
        b=COzobQMCfpdNkoqvqVT4UWbOG/ZsGuT4HEo/ztslQg1rRHv6jtPHxwzrfn/1cRPOMq
         9ZutLymGQsgLt4aQi6OorGRRoKx7vD5ecpNDV2NDetRWmINFmfcQcUiJgeQQxKmrnwi4
         CyyhRb5ttLfsygj0aPBPyH1LYYHGxpXrzJnHt3QTULW2/cYq8VIVJ6oIX3QiqANQhu2I
         KVsTj9RmTxpwZsC3Or8s7XLce1rdO7hs8nG9vPEdozpZVK9LbCCC0c3ZGolUP744ajas
         BPsB8N0olEGcm9uIPpk3cA/roZSSjxkL8Kyn9oELT3hf+tv/U131LbTYkarK7IHewUaz
         vsbg==
X-Gm-Message-State: ANoB5pkTshP4b4+K1pyfYkYR1U72g+P+1dxcsDduBhlstudPPNed8sUq
        tKoAa/FBXGXD0ohZ3xuohO+pZ4fJbcs=
X-Google-Smtp-Source: AA0mqf651FZvpxeukKale+yH/8ycgSdijDLJqAf4lTqIBAApicZBU7Kubpny1lUEKIrw1m+Io0Ookw==
X-Received: by 2002:a05:6000:181:b0:236:8dd4:f902 with SMTP id p1-20020a056000018100b002368dd4f902mr7482370wrx.481.1668434817276;
        Mon, 14 Nov 2022 06:06:57 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id fc18-20020a05600c525200b003b49bd61b19sm19931474wmb.15.2022.11.14.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 06:06:56 -0800 (PST)
Message-Id: <b38b8fb5a85e10d6189d68b6633adf23fca7b65d.1668434812.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
        <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 14 Nov 2022 14:06:51 +0000
Subject: [PATCH v4 1/2] t0021: use Windows-friendly `pwd`
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

