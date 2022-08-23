Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A852C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 09:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349016AbiHWJNy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349189AbiHWJLU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F9486C24
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:32 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay12so6806756wmb.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=uRgabWi8kMFnLk7MySU/fiQXaJR9mqMTeDJYFEoMCgY=;
        b=EHwxNOxGk/qKAxIkOy1eY+tubuWk9CuxMItTlDN2MUsmi0NMFbHtAq4RxNLwRgu/vz
         4i2XfiMjrPywPlzbSVs4o+vt/dOG+3zggBURKKEEvQxfPwaPzO7OD7thtj695ho8wqwg
         dSu/yZXOmQ1FIftE6rr0HhPqvOgX+9MjkGAKFtnwjB9g9OF9/9P2M0cRc3qxYszuD1lm
         JExmQz39GKoQvw7NWNNtNQpEXac2yBeN6w//NyUp1XHKLQSPHCA5w68uSMaDtb4hdQH2
         UyjTPsXT6TDJII65URT9BcdGmd8CTsJmZeguqANIBttnVwsATWzl8PL9jjp+TCDin7bz
         5VVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=uRgabWi8kMFnLk7MySU/fiQXaJR9mqMTeDJYFEoMCgY=;
        b=FHhGIl9MZWcn0pA2RDmL0WTp9MSugdwSu5uDTt07OMaWobT2ADoQpOoavK8sy2stfY
         QedKvmcX0YAxgsKaiWbU2Dsn4V1NQmSb1PlvauuwN6KFwLTYEYsUzyLM7TrLfuAtK7wD
         CzYC6olDYHSE8+XohO1AOd1FoX1Z+/Vfo7475SY4Dc6Gs7LhQHNFtOgwifmudzdJkKZo
         vHUIpWFGMThwZ5R+Hh7azvpEbL4rJIH+v3kPdoNYSK/9q/wqMFdq3vteHh+i3df2l8vB
         aOm74xQPtecPaegu4FZ3kzo/8bzoFJvqCOcSzMSwsnHc6pOjnkAZDKrBmfebvbUFh+iD
         IMww==
X-Gm-Message-State: ACgBeo3efDHPg9Qrq3MzsWYZysR9N1LqqwGrzeOx90WBGDyoNvnMqLpz
        IXc7y2lgx2LVXxnlUu5ax/8/ORfBqAU=
X-Google-Smtp-Source: AA6agR48UNasHT5aoWuuM/cRjxtpmKmkBgf16y3ejVoSGaOT2G0ys6KWqjhP3n1DkYpbkNMDtS0ZEQ==
X-Received: by 2002:a05:600c:5022:b0:3a6:ad4:1c6 with SMTP id n34-20020a05600c502200b003a60ad401c6mr1357187wmr.177.1661243466768;
        Tue, 23 Aug 2022 01:31:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a18-20020adfdd12000000b002205cbc1c74sm13536649wrm.101.2022.08.23.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:31:06 -0700 (PDT)
Message-Id: <e00cb37b98ac09cff010e843ef19eeec761f8985.1661243463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 08:30:59 +0000
Subject: [PATCH v2 1/5] cmake: make it easier to diagnose regressions in CTest
 runs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When a test script fails in Git's test suite, the usual course of action
is to re-run it using options to increase the verbosity of the output,
e.g. `-v` and `-x`.

Like in Git's CI runs, when running the tests in Visual Studio via the
CTest route, it is cumbersome or at least requires a very unintuitive
approach to pass options to the test scripts.

So let's just pass those options by default: This will not clutter any
output window but the log that is written to a log file will have
information necessary to figure out test failures.

While at it, also imitate what the Windows jobs in Git's CI runs do to
accelerate running the test scripts: pass the `--no-bin-wrappers` and
`--no-chain-lint` options. This makes the test runs noticeably faster
because the `bin-wrappers/` scripts as well as the `chain-lint` code
make heavy use of POSIX shell scripting, which is really, really slow on
Windows due to the need to emulate POSIX behavior via the MSYS2 runtime.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 1b23f2440d8..4aee1e24342 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1088,7 +1088,7 @@ file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")
 #test
 foreach(tsh ${test_scipts})
 	add_test(NAME ${tsh}
-		COMMAND ${SH_EXE} ${tsh}
+		COMMAND ${SH_EXE} ${tsh} --no-bin-wrappers --no-chain-lint -vx
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
-- 
gitgitgadget

