Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1541CA691
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 19:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687405; cv=none; b=oEh8tqcEGBjZSvgfxYISH7hM1PWmcOijvZE8941pfdfMvcRMldRzRn0iN4Omwb2oFYpV3AUjdZy66armu1Vgw5Y6O4bka/OeslWDOMtTG0vZ+DebtlsGmV/6M6dZwUaX8flUwyjIcm2yIeYpolHc0deEDADMtEE7RgDKBo/UrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687405; c=relaxed/simple;
	bh=6NCBcuy269Nf9bNjqoVEXVN/8n/Fcb8MWgTraLmpSm8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=p6Q6tRDNFfimhzjM8jtXi8bDD+z46JJRgXFpHpsd1Cl9J0NCvgoCyu/3KkX7B27T2WtglQEVCqxzMAc0Pa2oHPGv6NkdLJ0eeIU+u+RI6kPcN8bsdj/wGNsnNL+SlN8t3Oonhokwnju7bLLtp45viPfoKF/wqAWpDlSE8PDZJ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adViz5hp; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adViz5hp"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a81bd549eso1525066b.3
        for <git@vger.kernel.org>; Wed, 18 Sep 2024 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726687401; x=1727292201; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wlegsfWF0cC+5S7ioDE4kLeveLFRO0HVB8CITpgdNHQ=;
        b=adViz5hpfgOgwYKSmPng56Pry+fEw9qd3Z0Ca+Dku/6BltBHzKL4crCGuV2dPzzkEQ
         zBmcfNRrlAQlLcVQ+ATx3049Gl8QLfc3x0fnDkRPqXvmiTIlOuG4hbo6Qln1iM+HU+Qs
         TAtNz0fkCfamc0dPbOVGlkjxciu+GYNRNvxcr+oHNJKcS3AqCCBMuDEw4ZREqqFSdUBD
         QBlWQFroPagRDI1/0EMLzdmkwWuz9CWQxM4Y5MwaBWnuvg/K0GbKMMErGszsEDvX83qc
         uZcPysIsL/kfheiIj90wk8r9hgoZgCVnSR6ZdpnPGeAhUN9mgXoesq1zBf7KXU0v55Uq
         QavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726687401; x=1727292201;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wlegsfWF0cC+5S7ioDE4kLeveLFRO0HVB8CITpgdNHQ=;
        b=fXxYmGusIJoUxzGCo2jJHqjefRWSDSN5aKm8D19chKvS70DCTQxCyQZC+UBw0J/LMd
         kgZsbhlTQxhMAHlXDQJT1KGfMATKNjNwIfsUdvlebd3/MLc+pSAqc7rErQeD9MqYQn8I
         JgIeetc8SSGxwAnzt1GF8FQnj/an0jzibZgrOwc3xV4JCp2gwNITWO2KPm7DRrH4SCHg
         6IV8TIaZkbDeUf4L3yoNKFFm7VaXQgKPzE02RgPmv5FqI6ta9QeoZAydZsuIdp4cu0mv
         7FLZ2RRs+UORNt3shQnQqAJXTRYVAKpvFOq5yXXeBhpsrfC5wkxrTU6746/Bk2ZJxuph
         nc7g==
X-Gm-Message-State: AOJu0YxHSN57C3U4FuLtoraJYFw0aQzYh6dc7sIdqKZxmGhaeL6fMuj2
	mZOwSKTvzS2eHhz4uj3h7AGzyNmQOkckS2AggU21/hZV5nxQYjyJVrWBIA==
X-Google-Smtp-Source: AGHT+IHs2w76auWwJKJLlMBdRLe3N62ETiSLrYY274Et7fGl7RtgajZeukgnoiB22w2gMSKHz2jyVA==
X-Received: by 2002:a17:907:3e94:b0:a83:94bd:d913 with SMTP id a640c23a62f3a-a90294a9ccamr2590456766b.10.1726687400989;
        Wed, 18 Sep 2024 12:23:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f43a4sm620083466b.83.2024.09.18.12.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 12:23:20 -0700 (PDT)
Message-Id: <pull.1796.git.1726687400286.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Sep 2024 19:23:20 +0000
Subject: [PATCH] cmake: stop looking for `REFTABLE_TEST_OBJS` in the Makefile
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As of 15e29ea1c648 (t: move reftable/stack_test.c to the unit testing
framework, 2024-09-08), the reftable tests are no longer part of
`test-tool.exe`, so let's stop looking for those lines that are no
longer in the `Makefile`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake: stop looking for REFTABLE_TEST_OBJS in the Makefile
    
    This is an add-on for cp/unit-test-reftable-stack to let it build with
    CMake and Visual C.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1796%2Fdscho%2Funit-test-reftable-stack%2Bcmake-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1796/dscho/unit-test-reftable-stack+cmake-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1796

 contrib/buildsystems/CMakeLists.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 832f46b316b..af7447de6f1 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -970,10 +970,6 @@ if(BUILD_TESTING)
 add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
 target_link_libraries(test-fake-ssh common-main)
 
-#reftable-tests
-parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
-list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
-
 #unit-tests
 add_library(unit-test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
 add_library(unit-test-lib-oid OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/lib-oid.c)
@@ -1009,7 +1005,7 @@ parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
 add_library(test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
 
 list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
-add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES} ${test-reftable_SOURCES})
+add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
 target_link_libraries(test-tool test-lib common-main)
 
 set_target_properties(test-fake-ssh test-tool

base-commit: 2b14ced370aea017efc32b525fd72a6dd2cc60c5
-- 
gitgitgadget
