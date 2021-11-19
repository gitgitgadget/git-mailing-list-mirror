Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8ADC433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 23:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbhKSXG4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 18:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhKSXGx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 18:06:53 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE13EC061748
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so20634531wrr.8
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 15:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=L9faUOUIjPF+NLN+ELTzI5NereQrkPug1GdsWQHqOzk=;
        b=T0F3DU821tppgYRJeM6hJlUvR8nx4a9ErAKpl6K/kg5U4/9N9/ZHIOO29O7RGeKViL
         U1S7p+4ETwBBbbLxooHAuS8caSAliLqW9rPLq0IjBD3ph8R+l3u2cmFE/jeuxRNqWtXL
         7Lp1kGJKSeveWJcTZwmBFXaN5WRNCBfc/VZ97NzZibrjKUgmNEyEF6JyD+7NujChZB/p
         zOZpGP/SZpyWakSX12XSpC4vER03A67FRtT5DwoLqnpPjMerMoB6z9M1LVr/7eMkq9vJ
         bC6QkIJfCgjh9gzsRq1dBBOURm8p4IdWY1/c1qji11r93QmaWluei+/OoS7L1joag7Kn
         qoBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=L9faUOUIjPF+NLN+ELTzI5NereQrkPug1GdsWQHqOzk=;
        b=WbozHxmfF56birBVwfVP96XXF36W0f24B8I/kWMH2QZReweKbKPaPbADu+/xYMiYH9
         R5+4/vAP/71IQs8n1fwqZnwhK81HoIeGL0o7u7HW1I2AJ63Q0i5JygwKbrXXBJFgSZ8o
         CjPUJZXMIuQUVL1c/MmBvzkX/z3j/eilKqgRQSJsM9r8oSSfxmjpo3KRKTCZX2zNemFX
         8J7mGhukbjrbhuCYfHRjMi2HaN1h6/RSskCjP6PkAxkIPLDeW8NMmhOtbyCFgNGnK7hp
         EQ6ZIytFcM01KOYMu8KOCoIfzbrdZdJ27xbPnmZIAbW0RJX1ZRpZplUhODz0KJGPBhJK
         RuFQ==
X-Gm-Message-State: AOAM533GAWcIGoiKMBNYOJoDRRuyzMvcgAV10RWV6slWhALV7tGhZMSa
        8wlTtwuq0vCoVN8pv+97Db7l2HnT4Io=
X-Google-Smtp-Source: ABdhPJw3mzKyWXM31vspELa0PejOmkEwAxvc3awBQt3z99noTWIFOidA7enUK9VVvcunKvqZrsNFoQ==
X-Received: by 2002:a5d:4904:: with SMTP id x4mr12584832wrq.139.1637363029252;
        Fri, 19 Nov 2021 15:03:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 138sm8573759wma.17.2021.11.19.15.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 15:03:48 -0800 (PST)
Message-Id: <a39b9c812146f6721353a066670d248159161615.1637363025.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
References: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
        <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Nov 2021 23:03:32 +0000
Subject: [PATCH v8 05/17] cmake: optionally build `scalar`, too
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The CMake configuration unfortunately does not let us easily encapsulate
Scalar's build definition in the `contrib/scalar/` subdirectory: The
`scalar` executable needs to link in `libgit.a` and `common-main.o`, for
example.

Also, `scalar.c` includes Git's header files, which means that
`scalar.c` needs to be compiled with the very same flags as `libgit.a`
lest `scalar.o` and `libgit.a` have different ideas of, say,
`platform_SHA_CTX`, which would naturally lead to memory corruption.

To alleviate that somewhat, we guard the inclusion of Scalar via the
`INCLUDE_SCALAR` environment variable.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index fd1399c440f..dd7496b0322 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -729,6 +729,13 @@ if(CURL_FOUND)
 	endif()
 endif()
 
+if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
+	add_executable(scalar ${CMAKE_SOURCE_DIR}/contrib/scalar/scalar.c)
+	target_link_libraries(scalar common-main)
+	set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/contrib/scalar)
+	set_target_properties(scalar PROPERTIES RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/contrib/scalar)
+endif()
+
 parse_makefile_for_executables(git_builtin_extra "BUILT_INS")
 
 option(SKIP_DASHED_BUILT_INS "Skip hardlinking the dashed versions of the built-ins")
@@ -953,6 +960,13 @@ string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
 string(REPLACE "@@PROG@@" "git-cvsserver" content "${content}")
 file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
 
+if(DEFINED ENV{INCLUDE_SCALAR} AND NOT ENV{INCLUDE_SCALAR} STREQUAL "")
+	file(STRINGS ${CMAKE_SOURCE_DIR}/wrap-for-bin.sh content NEWLINE_CONSUME)
+	string(REPLACE "@@BUILD_DIR@@" "${CMAKE_BINARY_DIR}" content "${content}")
+	string(REPLACE "@@PROG@@" "contrib/scalar/scalar${EXE_EXTENSION}" content "${content}")
+	file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/scalar ${content})
+endif()
+
 #options for configuring test options
 option(PERL_TESTS "Perform tests that use perl" ON)
 option(PYTHON_TESTS "Perform tests that use python" ON)
-- 
gitgitgadget

