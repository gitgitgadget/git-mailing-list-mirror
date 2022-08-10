Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E302C25B07
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbiHJPCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbiHJPCf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:02:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA6B75FFA
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l4so18026775wrm.13
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=4gnUj/pP2WGXtTkhNLh91Vsayn8+83uN5fCWQI2ZtrY=;
        b=j4mIb9HJLC2G+r/nDzkIZn78gVy+5YSiFQz0DkAHMi3mbeuSld53Wm/4QllQRQ+Vg9
         MJv5fsAV1J4b29BiFMWTP0orPaZNEILJWyWeyjyYaYUTLznl2OuK1iwp/1QDWUzxG0Vy
         msmV8McBBCXQWf9Q4WJcqZU3RjNHeIoFqVt8Bq2d8tmatlwxl5qLXfi16zrHtBN2JvUV
         TG7qxMOTRvJsvSSaUfGQu1/aBayhvNSYelyQOPl+1440WySJ4ZGO4mKMCU7RDNIt7kPN
         oSvc4pmsJZtyvbFa2IDeaxzQ8V/x5LJ7DqaLvME5zLdzbndxKYkdn3PRj4KO1CYGRi39
         eMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=4gnUj/pP2WGXtTkhNLh91Vsayn8+83uN5fCWQI2ZtrY=;
        b=i0fkyFmSLvkxziSMlYSRBHJzraQEMek6Fl++ImyQ/vIrSYT3F18pfVaIRV9eWcLQPf
         /a6BoKZrxTVo5WvBBPR2PU+PVu1Wwy41JxLrmYlD5z0wytIZ3k4RiKxKjRM7tTL1mtul
         KIW4EC1XEkrnn0hZnFOIHEcagd1ioWQyX9FzFLhjcHofttI22V1qdVfKQHTloG9D8IkH
         N70hUhtl2624sX51ZpwJV9HUJNnRsyvQzOevNHXBay1vDXnttGBumKhlZj7qcjkXUhOS
         byvpctCjJvv3JwoGbMXc4rMWNpSHDLMIC95WSyNRSwm4oom4S0YIZOQIrYqi1LI0IJ8T
         AyMg==
X-Gm-Message-State: ACgBeo1/18RdyzcMPesy7SNVVr8DTvkALUuqmfEjhlqEVaZLb2w9Mu66
        gBl/+cNpwXhKAwXHkWiAxunBmnh1+WU=
X-Google-Smtp-Source: AA6agR7vCemB84OFoxM8oT6+nFjmfOivNqzoW/5lIX29z9wwL11KM2IYYpuWt+qmpR9yDAthq7uo0g==
X-Received: by 2002:adf:e848:0:b0:220:7dc6:135f with SMTP id d8-20020adfe848000000b002207dc6135fmr17556270wrn.24.1660143752900;
        Wed, 10 Aug 2022 08:02:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m11-20020a7bcb8b000000b003a550be861bsm2607391wmi.27.2022.08.10.08.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:02:32 -0700 (PDT)
Message-Id: <9cf14984c0a71b1ccdff7db0699571bf5af1209b.1660143750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 15:02:26 +0000
Subject: [PATCH 1/5] cmake: align CTest definition with Git's CI runs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git's CI runs, the Windows tests are run with `--no-bin-wrappers` and
`--no-chain-lint`, mainly to win back some time caused by the serious
performance penalty paid for the tests relying so heavily on POSIX shell
scripting, which only works by using a POSIX emulation layer.

Let's do the same when running the tests, say, in Visual Studio.

While at it, enable the command trace via `-x` and verbose output via
`-v`, otherwise it would be near impossible to diagnose any problems.

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

