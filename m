Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9FC433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiEYPCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbiEYPB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:29 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97472E8A
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id s28so30367568wrb.7
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kUTb3iU8XWgR798P6YdKsfHBU+ci261+gHJ9yA28Wks=;
        b=MUJ7bWWFu1xQyVasmGFhRRuv4hG06B75KgwWkWUXEoXTkIdnXcRpkmcUUGQzNLY7Cd
         R/onSmEUF8LcIqWeG4mN2sYtGUbL5o3miJ6Eqzrk8lkHYKRmMUX2eabo3RiwaXVAAvqb
         iXg16DSJQwBGJxUncHmsGV4w8CRQj+L8cky302weQTqeyprSCTjWb0JULpEisXr+HnLe
         k12eOfjXN5yh2cflo+fgpaIeIlq990b+tLcg3U6BtCGxPF1cK0cJ9FVfcWf317G+6hpi
         /WA1eRmU7L+Nk4dHlNvBU7ny/WM6g3bzj+IgXjG3WetVpYl0pWQi5rrhRQJ11PXYMtrX
         EO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kUTb3iU8XWgR798P6YdKsfHBU+ci261+gHJ9yA28Wks=;
        b=KxLEAeQ1IMoDebQW+ICX+AkLr1bataRpqeOasU3YXBtER2UnTiofv8QFFVe2ENX6ml
         1bPcVVTyDwGVbPyVeGUKq3MaxNhxDWKVXWA35G09UR+7Z0u0fZWQ2rsA3NstNcrfhxn3
         UDaKKObbPS7ZebvwHnr0S7pGBLO5d0SAi8B6vt3Nmb9SGORSdVrLw2lsFL8htORcK+9h
         CSxMp9P6WB5fU66VXS2xH59KGvcK1BW05G9RQnFvsdEd8YGq4TcLZxuglwhjly0XPyZn
         MYwVqbSv4aSURqVe34qh5GebKlE3NZ9s92kKPmG9W5uXjTIH+CMKFrQq8Od7HaGScbwU
         yv8w==
X-Gm-Message-State: AOAM530IgXVObpI+eltJXkR6TOLjtFPJwed32QasVwk+v4H2sct78/IL
        sVtcjBg591adlS7OW4xNrsJ4R7J4vdQ=
X-Google-Smtp-Source: ABdhPJy1JnRsYKSnWBF67i/nsMGwfUyCCAiJg9oEjfaJ0nzIv/8FRpmXEu8B+1dxboS6Lnpv1c2iDA==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr27256320wro.661.1653490886665;
        Wed, 25 May 2022 08:01:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f9-20020a5d64c9000000b0020e5b4ebaecsm2656373wri.4.2022.05.25.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:26 -0700 (PDT)
Message-Id: <d058d7e0c0829bed9df266c4f6c9f12c30caad4d.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:43 +0000
Subject: [PATCH v8 21/30] t7527: FSMonitor tests for directory moves
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

Create unit tests to move a directory.  Verify that `git status`
gives the same result with and without FSMonitor enabled.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 12655958e71..3bc335b891d 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -274,6 +274,16 @@ test_expect_success 'setup' '
 	trace*
 	EOF
 
+	mkdir -p T1/T2/T3/T4 &&
+	echo 1 >T1/F1 &&
+	echo 1 >T1/T2/F1 &&
+	echo 1 >T1/T2/T3/F1 &&
+	echo 1 >T1/T2/T3/T4/F1 &&
+	echo 2 >T1/F2 &&
+	echo 2 >T1/T2/F2 &&
+	echo 2 >T1/T2/T3/F2 &&
+	echo 2 >T1/T2/T3/T4/F2 &&
+
 	git -c core.fsmonitor=false add . &&
 	test_tick &&
 	git -c core.fsmonitor=false commit -m initial &&
@@ -356,6 +366,19 @@ directory_to_file () {
 	echo 1 >dir1
 }
 
+move_directory_contents_deeper() {
+	mkdir T1/_new_ &&
+	mv T1/[A-Z]* T1/_new_
+}
+
+move_directory_up() {
+	mv T1/T2/T3 T1
+}
+
+move_directory() {
+	mv T1/T2/T3 T1/T2/NewT3
+}
+
 # The next few test cases confirm that our fsmonitor daemon sees each type
 # of OS filesystem notification that we care about.  At this layer we just
 # ensure we are getting the OS notifications and do not try to confirm what
@@ -660,6 +683,10 @@ do
 		matrix_try $uc_val $fsm_val file_to_directory
 		matrix_try $uc_val $fsm_val directory_to_file
 
+		matrix_try $uc_val $fsm_val move_directory_contents_deeper
+		matrix_try $uc_val $fsm_val move_directory_up
+		matrix_try $uc_val $fsm_val move_directory
+
 		if test $fsm_val = true
 		then
 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
-- 
gitgitgadget

