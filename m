Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25934145B3E
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 23:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038931; cv=none; b=Flnfy0vunyHBa9CYf6UFLULegKJ+W+hTZZFbot4FBNxr3jZLM9fxP0dcs3LGNFtrgLTfoeJ08L9XDVRogbySZWkh2eYQSMcvjwNHY5VXaZ5YeF9iuUvhEA0d6HPu9ufnp28OCgoWvImxyhg1wnOHS6W7cKaV7iBpRb5nEUImZHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038931; c=relaxed/simple;
	bh=NUMPKSybnUGleLkQIyEos81R9/mtsjghGnkatHTWOyY=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=m6wOpKglST6YocvP0zEwdonP1Bx/jNdh+ddXJWElTGE7pwMnhd2vGXcelBUpLxGnDWbx6urCP+OB75N6XjHPpe7nzwxJ1p8pQHCieLzozq+6YrhkyKsbDUgTZh3fSY3BswciYysejaMpSb24ROIgygpK5kMpTM/yYNbQygx/Rm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMUlTqQI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMUlTqQI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-412393ea2a0so850595e9.2
        for <git@vger.kernel.org>; Thu, 15 Feb 2024 15:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708038926; x=1708643726; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fCpx2iTB+knlFxESDE5zPJS9nO4Nsk3QAatLPdDaj/c=;
        b=KMUlTqQIpCqqK/qgDcjzkpRGxHPFvDmj3H6Q6bkUVSgcHDBnX6V+Ekce1HkTi40puF
         iRNamn3v/Ke1t96rvvBrRLVpRHBxs6t2M2EiHoE81XDaBWsIKmgIC+boxN1qFn5ry7XU
         79gqRQCGJo/NroLth6aTLiGdpmLrFib8IyajebmiHn+RNKx4YgGJTqoBo08e3ChGCsV6
         Fa6iKCyogH/0jbPvRkWhddq36VQYxBd3UaonVdRJupBc4KV9gA0evvA7w5Bk/4jfnYjG
         3bE13UrCyZmKhhBxFAQI5fgCwjDXIu8s0S/Fidi1UaNiycfpUqLZR3GpjgcVywXDUAmo
         NIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708038926; x=1708643726;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCpx2iTB+knlFxESDE5zPJS9nO4Nsk3QAatLPdDaj/c=;
        b=jNFtXH6INZKcWznIp43fgm4UGmgwQMGv1ldMpPPCiI/hwL/5p3Skj6OORuA/S37sVg
         zTjXHrrAp8A2Ya39ruKy4or5xQ3rBU+h30OVKbEY03TMKaJ9mTSyNJVHlGgqh0fn5brO
         LWP0j0O8imMJwx2c9a9CHUqrq7FnPehQfkVpEtyHbqTA9hh1diMKFnYreghRjks5XdKX
         nnVaX8J03IkNEHA34uIZBgHEHuXODEj5+i3CEz4lVdLafRF3AkgGox/1iJ54E0rDkpZK
         peK9DrLaaPSwORJOnfHJPVyt+jMlntueQAqo1bknPF5tdFLbpVguLm6P2eoSOzSuX61q
         CXZg==
X-Gm-Message-State: AOJu0Yziq5e0QzpOJFH9vt/23nJpA66DEY3EnVhype2VBzsSbm7/xKdR
	MSDMZR9eOVudibU55QuctSJQCHsWG+jhLpP0vI4Wf9XzKggxnR39kbgaRB2T
X-Google-Smtp-Source: AGHT+IE9hvcsf1ViVzuUJqOoL2Uy5n4p/eqYbLEZ0XjfEZsOdxYWq42Zw3Lvuyz94KH8rLM2pUmunQ==
X-Received: by 2002:a05:600c:3b86:b0:410:bd9e:c6 with SMTP id n6-20020a05600c3b8600b00410bd9e00c6mr2291952wms.17.1708038925479;
        Thu, 15 Feb 2024 15:15:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x11-20020adff64b000000b0033d157bb26esm444866wrp.32.2024.02.15.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 15:15:25 -0800 (PST)
Message-ID: <pull.1666.git.1708038924522.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Feb 2024 23:15:24 +0000
Subject: [PATCH] cmake: let `test-tool` run the unit tests, too
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Josh Steadmon <steadmon@google.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The `test-tool` recently learned to run the unit tests. To this end, it
needs to link with `test-lib.c`, which was done in the `Makefile`, and
this patch does it in the CMake definition, too.

This is a companion of 44400f58407e (t0080: turn t-basic unit test into
a helper, 2024-02-02).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: let test-tool run the unit tests, too
    
    The test-tool recently learned to run the unit tests. To this end, it
    needs to link with test-lib.c, which was done in the Makefile, and this
    patch does it in the CMake definition, too.
    
    This is a companion of 44400f58407e (t0080: turn t-basic unit test into
    a helper, 2024-02-02), and is based on js/unit-test-suite-runner.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1666%2Fgit-for-windows%2Fjs%2Funit-test-suite-runner-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1666/git-for-windows/js/unit-test-suite-runner-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1666

 contrib/buildsystems/CMakeLists.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 804629c525b..2f9c33585c6 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -1005,10 +1005,11 @@ endforeach()
 
 #test-tool
 parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
+add_library(test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
 
 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
 add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES} ${test-reftable_SOURCES})
-target_link_libraries(test-tool common-main)
+target_link_libraries(test-tool test-lib common-main)
 
 set_target_properties(test-fake-ssh test-tool
 			PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/t/helper)

base-commit: b3b269c2d8931642c4b9f03b9ce9e81c20995eb8
-- 
gitgitgadget
