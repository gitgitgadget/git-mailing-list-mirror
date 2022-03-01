Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270D5C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:44:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237142AbiCASpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbiCASo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DFB66203
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id q7-20020a7bce87000000b00382255f4ca9so1272740wmj.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=TB3lev3fBle3txTe4GzyvBzYCAFH0qfgFhmQPdCdSC3rsq0OfDPtbiKV28TqRLB52M
         uzjdmqQHxaeK5TTh9IvCPq2JXb/eTO7ku8yERTzhYsKXNlHUvqjG/FL+rUuDv60ThYTZ
         rZkV1xbt15Ny2rVnuJLaSqIZ000yn5h4jmArCHFCpoo9wDlRnpdl4CI76l6eZwBQZU3s
         HmArJft/FXA4Yk5IFT5+c3zJfD8NHlvlz4SUgy8/ygt1BrmRAI7U0nvKV7WrWXAHi8cM
         Wpx/KcCkONnmW63wFudLeQbR2sbCSTcI0d0iZseDdHv03mC8FCspN5Q3ViNl3CofbS/X
         Q25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ytZGPKQBsgePTFk8nBNZCqEs9yPPwA8MYf3sa3pnTvQ=;
        b=eBnJyBHAbKqlERsxC4SuS2RUcTDRtd0tceKUoc7qdcwV3WIqjHxcMotNAFpqafYx65
         wED6fTw5hs2dYdrOKDRTgrU/y7sLQJMpSgrMEwH75EfpamgVrrWpEE+17L+CZalBedAi
         MgDYBgWO2ZlOQWlfn/mTo7BEsUEnrg9f7QXxO2Ns7id450e35cFRyH5bFDwgbtS60/vu
         faimSmjaz4RbpNzYBFCgrnwE/bUvE3en/dScWEMtWOSfo3KcTbYEY2cnSm9QWn2oK/V+
         FwHeBnJjo2b9V6XEBF3FcXf6g9Vp5sfpTYvxlgBrrdTG3WTvhbwO5LX2eDBlurY3eyS3
         l2zg==
X-Gm-Message-State: AOAM533E/db/MfCEVojNrMAT6cfUanbZopuozowRuz+BmivBNFlFUUHY
        FfnLipMv3yAvQvJQDZeqycU5H21SnBE=
X-Google-Smtp-Source: ABdhPJz62pY1Jf+5Kx1ze8++v/5bSKTT7etDa/L+tFncFra0XlXQ2LbcC5n/9/CfIJEokjVt17fLfw==
X-Received: by 2002:a7b:c351:0:b0:381:6824:aa61 with SMTP id l17-20020a7bc351000000b003816824aa61mr8504100wmj.19.1646160234563;
        Tue, 01 Mar 2022 10:43:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020adffcc9000000b001e9e8163a46sm20464817wrs.54.2022.03.01.10.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:54 -0800 (PST)
Message-Id: <4cb97918d20e19cf57c69e6a2a66d289ae873a7e.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:25 +0000
Subject: [PATCH v6 23/30] t/helper/test-chmtime: skip directories on Windows
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

