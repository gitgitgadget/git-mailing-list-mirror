Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF24FC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AEC61A79
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 14:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbhKQOXC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 09:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbhKQOWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 09:22:43 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34353C06120C
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:35 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i5so5055822wrb.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uhb/QROHr1fftnLBMPf7ahiE/BQ2/n7oC7jxd7xCuug=;
        b=NoJGGxqFqYm8OnyRY7bmBADyfvMgOIdggSTS+DFryWWhnOiHo52Rz6gvkKnCtJuEGw
         EsB3478GuStu7OS0k2qYsy0nNjU6TBNME6U4ZmP0j55ctfg7M/9cMn0MdWrjNL3v0ugd
         rd48OjeKzjawssSTirWVN6fAyJdJs6tlZbI8tXSJvzRu5IDsyJ90zrxLtfqUA5eZpUU5
         Zo+sP0XyqZOLQw3IBRpUwQcuR6nnWFG2omjPtEYv26RDaQ4CB99MVsKz2cGM3E2U1Rx5
         cXxhD0lDp0fNG1XaoO418ezUt+nGOrFoJK8fS+0jG863dSu6opMsUsrvFmeolqq5V9AD
         wJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uhb/QROHr1fftnLBMPf7ahiE/BQ2/n7oC7jxd7xCuug=;
        b=qntx/VD/L2MiK6cl9EdBUmnX+YdfRz8libDC83NFMshEs0hrS/dYZKsz1D9RhPBMXp
         F+tJM2JQJMj9LZU5mwN3arGzCXhIpv6/ZrVG3C+X508gn/YMhm8KZJDKkSe9pvemARjz
         UdAzhKWTE0C9VVLeuA62jiyzhcgMsaIU0ocs8k0LJi4KrbnQT2UI01hfCRiq2xT19p70
         l+UbRyq1q0SDJ9Xa+/+PGSuVzl1KNIN0r7IyNGr3nfLhvXam9/FnddnWPIiJ4eqe7uf+
         VdFov9N5xgiSVZJsRmil5s9UyVpwquujdmbAEQd+CgYa8ZCshcB22V7ZRBQUgtAsHk3F
         eiLA==
X-Gm-Message-State: AOAM532dpRd52FrWvpGciIky9MVjhZraM5OO0iKrSkk48mooPZPV98MH
        gjOERjIlDD/5DrNtpU2pZtNYiV32BKM=
X-Google-Smtp-Source: ABdhPJyUN/DeQ6tN3A0d3rkuiknLysmq09KqG7/sO3+1qzsmbvXOhXDbm6aJC8pp3GdLtmtGoLcgFA==
X-Received: by 2002:a5d:4a44:: with SMTP id v4mr20608604wrs.246.1637158773590;
        Wed, 17 Nov 2021 06:19:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g13sm9950wrd.57.2021.11.17.06.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 06:19:33 -0800 (PST)
Message-Id: <dbaad4753c156487e91b766ebd3c9a39d68c1b12.1637158762.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
References: <pull.1005.v6.git.1635323239.gitgitgadget@gmail.com>
        <pull.1005.v7.git.1637158762.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 14:19:10 +0000
Subject: [PATCH v7 05/17] cmake: optionally build `scalar`, too
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
        Theodore Ts'o <tytso@mit.edu>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The CMake configuration unfortunately does not let us encapsulate all
(or at least the vast majority) of Scalar's build definition in the
`contrib/scalar/` subdirectory.

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

