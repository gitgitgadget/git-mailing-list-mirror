Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF15C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244931AbiEYPBK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbiEYPBB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17CAAEE2D
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:00:59 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso1264656wmh.3
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LKUw9/jQ5pKOTmRH7NqnSRqnbMLjrfCSfR++z8h3F08=;
        b=iILse8iZ9G/8iiQemdlPrlgjiePD3Uq8mMtI8HnhzhWwrsXyukNswHkV2LLknm1aPg
         Y6IzsZafZEA7mKD2wS/Nfspkgmke2ej70TXKmYuQewLV1tBDd4/v2q9k2+3pMIkfyXo7
         1S6NTSqJSiZXhoWif0PSHpdHDJDNGPrNw8XN7KSam6wyC3S5el+twry7GjVeKj2Lu2zp
         rsaRadJzMw9rmOVpZvbWycSgWHjxS/qtFAmR6406EKSp2gOG5xwbZs+q99XSno/5Njru
         bFSQiKMRT5zPY5XzBgIj8/asG9xGRljoI2SyHdvo27s0nq1d203QYh0fKvAdzZzXaXfY
         gOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LKUw9/jQ5pKOTmRH7NqnSRqnbMLjrfCSfR++z8h3F08=;
        b=vqLLkhRSKOkelaxScz2Kr2h/kDvGTxEAjhgsD7ECC6V2BS2viFeKI2TcmNkdj68onw
         29rgHkLvep0UgGriNvUj+S379u2vK0b+15h3LqkiQ8//+3Jdb53Fd7A+O9xtAcYTUwen
         egD111UPdyeDnNuHFjnqNWv2PWOamrLLfzyJbs5MZy59ZiF/NLxIbiRytekQKa74i3SA
         SMjL1gGfymt6Lj9scM/leiCkxkdkVtk2WbC0dM+onFjXbaMIO6cCzs1mrV8AoRIIuIPF
         t5VEoSe14UDUAsIgYtk3DHEaot9amvQUKuzSEuF6Uu6bZEe7OAaZ+3g2xojy2su7RcWE
         QcJQ==
X-Gm-Message-State: AOAM532ADXlp2V5hNt/+/2yflL7gTF4xnxDfhDkNUXrXXlIOsG59dcfn
        o7azZHPFpYzmoZT97f1DL1tX62cBTBg=
X-Google-Smtp-Source: ABdhPJwKzkHA2JWCUQqLhuX2Fn5LbB30qa16FYs4F8Gez8xfxrGNkKKNGT/v2+kLsOkjSW5ixgMs/A==
X-Received: by 2002:a7b:c183:0:b0:397:4924:7cfe with SMTP id y3-20020a7bc183000000b0039749247cfemr8690661wmi.128.1653490858048;
        Wed, 25 May 2022 08:00:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d5245000000b0020ff7246934sm2245202wrc.95.2022.05.25.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:00:56 -0700 (PDT)
Message-Id: <1bf2e36b6adb127dd1654bba0b6ba84f626535a0.1653490852.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:24 +0000
Subject: [PATCH v8 02/30] t7527: test FSMonitor on repos with Unicode root
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create some test repos with UTF8 characters in the pathname of the
root directory and verify that the builtin FSMonitor can watch them.

This test is mainly for Windows where we need to avoid `*A()`
routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1be21785162..12655958e71 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -671,4 +671,27 @@ do
 	done
 done
 
+# Test Unicode UTF-8 characters in the pathname of the working
+# directory root.  Use of "*A()" routines rather than "*W()" routines
+# on Windows can sometimes lead to odd failures.
+#
+u1=$(printf "u_c3_a6__\xC3\xA6")
+u2=$(printf "u_e2_99_ab__\xE2\x99\xAB")
+u_values="$u1 $u2"
+for u in $u_values
+do
+	test_expect_success "unicode in repo root path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon -C "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

