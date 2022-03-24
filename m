Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E122C433F5
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351898AbiCXQwo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351901AbiCXQwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:09 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C15B0A6E
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d7so7477736wrb.7
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=Q0mad94WEaAvTEnrcz9uFBcqatBcrVoW2iUKioIgbpOJuais7dKKe0Rvxzzq61XIzL
         ppxUp0BtCaOdfFOOpLDyORnbtF2AEv612+rQbeVMeGa9Wt4TMuGZASMdk9JABXIIxEU1
         jKyRf2Sadplm2a+i07RMJZp3OvRlN58/it/DABj+WWo+4DNqE/rLMFesEV4706Xm7guN
         KOaznkDelJ6SrJx5rwrsZNvTWwQ1DkmNmr3DyUr6n/Vs9pHxyZXNw2CdGuHnpQjT4fYG
         jKy3USGIA2o1xqrK9xSZ4Z7G++ini0vhNog5jshFwOnlsF2fUm3Rv4H0yqpaohucBlkr
         wmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=Xr9JeE+QLM8/YcnJcx1FVywJRuw604eutqkljdkM5GMAyBewqvCTyXRkHmmt/7zxIf
         eFgA+xXQo67yr5shB6WSV/GIQOUE7GozrncB3E9tp94TBbs/aMQrlMPi0O1ZzhRU8smD
         doW/ODlW7RbW7680WOy6yL+TfWmlAlvc7EYqY3ptFAFZ/RwSqji6dsiRyDfyVi7sTf3N
         6VN1xwd2ZhMwB/OwPLzHva1o218RX/62xwvJFywgwJ+MuNWB7OfDxIBp70UZiUFgRd1R
         LIX8uQmO6J5ymXe8rsMU0HtwYfd/iVjOrmAh/O0GEv8/0XyDHfKLkSxaHpILE/NfdmBU
         93Fw==
X-Gm-Message-State: AOAM532MleehN8Zso9KkXAFMIuhGuS387IXFsFC3mZoOjI+jHWQAlWd5
        niKZfNKh2EZpI13JKyEKid/zMiPRlc0=
X-Google-Smtp-Source: ABdhPJxhWeSaVOpoDqzIONiCHSNM/0id5+qsF6AdL8N249XOmirEEDGJPJmVOJrAvVzZjYV+tR71kA==
X-Received: by 2002:a05:6000:1379:b0:203:ee50:45ad with SMTP id q25-20020a056000137900b00203ee5045admr5256430wrz.268.1648140617752;
        Thu, 24 Mar 2022 09:50:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d6d09000000b00203ecdca5b7sm3385100wrq.33.2022.03.24.09.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:17 -0700 (PDT)
Message-Id: <2bb3eb84767b205a0bed2d00662aaa2b91de52e9.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:39 +0000
Subject: [PATCH v8 23/30] t/helper/test-chmtime: skip directories on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach `test-tool.exe chmtime` to ignore errors when setting the mtime
on a directory on Windows.

NEEDSWORK: The Windows version of `utime()` (aka `mingw_utime()`) does
not properly handle directories because it uses `_wopen()`.  It should
be converted to using `CreateFileW()` and backup semantics at a minimum.
Since I'm already in the middle of a large patch series, I did not want
to destabilize other callers of `utime()` right now.  The problem has
only been observed in the t/perf/p7519 test when the test repo contains
an empty directory on disk.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/helper/test-chmtime.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/t/helper/test-chmtime.c b/t/helper/test-chmtime.c
index 524b55ca496..dc28890a183 100644
--- a/t/helper/test-chmtime.c
+++ b/t/helper/test-chmtime.c
@@ -134,6 +134,21 @@ int cmd__chmtime(int argc, const char **argv)
 		}
 
 		if (utb.modtime != sb.st_mtime && utime(argv[i], &utb) < 0) {
+#ifdef GIT_WINDOWS_NATIVE
+			if (S_ISDIR(sb.st_mode)) {
+				/*
+				 * NEEDSWORK: The Windows version of `utime()`
+				 * (aka `mingw_utime()`) does not correctly
+				 * handle directory arguments, since it uses
+				 * `_wopen()`.  Ignore it for now since this
+				 * is just a test.
+				 */
+				fprintf(stderr,
+					("Failed to modify time on directory %s. "
+					 "Skipping\n"), argv[i]);
+				continue;
+			}
+#endif
 			fprintf(stderr, "Failed to modify time on %s: %s\n",
 			        argv[i], strerror(errno));
 			return 1;
-- 
gitgitgadget

