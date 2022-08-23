Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48551C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 09:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbiHWJNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349217AbiHWJLW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 05:11:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD94A110
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e20so15581044wri.13
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=V59jbhymdjJGkgMRC+pw9il5wsLo5lKgfJAb6RRGIdk=;
        b=Q/QQ1h6qW0XbS/3ijkDdP7XWbunLK8D+G6eJ7JkBdFVzW0XcacVaF9GD3ibUm6lT5E
         tBPDdhBcCjltqUq/rFXR5TsnGEMxdxv2dCADHaizad9HnvUB7jwgMNh46q5YNbd1bDJ3
         02fmaalNn27oIt1xomV2lK/SJkKlNDzk2heMh2Vp/HimYUlQDSWcoTQH98cIyAufYQnl
         HsA4tZfNvUC1RNI1sGO1DIM2dRJS9Nq0tZgm3u93f5yKOjvYYgKGM4eNIfalMYhnGwtd
         h1/Z3NtS+eFhXv+U0tKZyi+U5n/eafXY2RoS4UeVL6ukvmkByxxa9y4qocXElexiJgl9
         vL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=V59jbhymdjJGkgMRC+pw9il5wsLo5lKgfJAb6RRGIdk=;
        b=kGI0OiO38Ub33Mwr1ARDkbgJ8ptm10bggAIPYfXU/wGxQW40zEaFD690+8rCr+NBuQ
         Da4Wi/YnZGQ7v3m0OAECbF1+XMVCoRk/vgqqFbjct5bjB6g8cUvGrUH3qfviaRoVrRow
         UqxUSaF0q0RNQ4r9iyc2HIQJtg/r+5iRDKAgcdvhX9n/6+AMEyp8pEcxyRVdfhikE2Hb
         CtEDpQIyV8yjlO9WDGlCN/dBNYxd+xl1kuQIZYCrqgFNIHfL3KUx0mC7/RHR0gSR2T6A
         1QgsCVsVtyfFXqVoWS6fonReRc/kmnKG+WCHVS6sdgqAyfPsf2fzTXaK/QJZZnvftQwd
         1XTg==
X-Gm-Message-State: ACgBeo3CsBbwksi8yGbqq5hGlKqlnRWGjeVwtW48iUVTOsYo8+Hu1ABj
        q7A+TreNozM0IvOIRzQJWVDMz3wzaIE=
X-Google-Smtp-Source: AA6agR6ixuUNxZ1QbQPpj8kRx3rgoFIxt1xY79DfSxrwn5jJVpWVuYP2bqZXkL+p/wRnZuUEcRIUzQ==
X-Received: by 2002:a05:6000:178b:b0:222:c6c4:b42e with SMTP id e11-20020a056000178b00b00222c6c4b42emr13897533wrg.275.1661243471084;
        Tue, 23 Aug 2022 01:31:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b003a5c2abc412sm24013788wmp.44.2022.08.23.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 01:31:10 -0700 (PDT)
Message-Id: <6aaa675301cc56081d07974a0eb8662700fe96f8.1661243464.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
        <pull.1320.v2.git.1661243463.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Aug 2022 08:31:03 +0000
Subject: [PATCH v2 5/5] cmake: increase time-out for a long-running test
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

As suggested in
https://github.com/git-for-windows/git/issues/3966#issuecomment-1221264238,
t7112 can run for well over one hour, which seems to be the default
maximum run time at least when running CTest-based tests in Visual
Studio.

Let's increase the time-out as a stop gap to unblock developers wishing
to run Git's test suite in Visual Studio.

Note: The actual run time is highly dependent on the circumstances. For
example, in Git's CI runs, the Windows-based tests typically take a bit
over 5 minutes to run. CI runs have the added benefit that Windows
Defender (the common anti-malware scanner on Windows) is turned off,
something many developers are not at liberty to do on their work
stations. When Defender is turned on, even on this developer's high-end
Ryzen system, t7112 takes over 15 minutes to run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 29d7e236ae1..b1306f95256 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1088,4 +1088,8 @@ foreach(tsh ${test_scipts})
 		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}/t)
 endforeach()
 
+# This test script takes an extremely long time and is known to time out even
+# on fast machines because it requires in excess of one hour to run
+set_tests_properties("${CMAKE_SOURCE_DIR}/t/t7112-reset-submodule.sh" PROPERTIES TIMEOUT 4000)
+
 endif()#BUILD_TESTING
-- 
gitgitgadget
