Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4CC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233681AbiDVWjq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbiDVWiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3331F9E2E
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x18so12805653wrc.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TYM9RAesGeaqNz2jBk6tvQuIkZPINQDoc+UjrbhzKIs=;
        b=F4rPF/CS3wWgKNBCRJcqscjoAuUFmEam3daFfH2ihk2eW1OUIRhw6rxnP9D+c2279r
         Kh6JZdllIo/k+yJPtCC6Rs6uLqHaham0DIVm8C0zOi6/+tI83mCOwP6EbvQnV2Mx+4qI
         soqbDr3CVH1FKipAoDM5sDU5iR9nalTVs7E9f5ECB6mjwkdX1YbgCEIjHc8JW5LndWRP
         R1zvP2h9GmzLwvQatzPO2pvWgLSszZUIsbKBJpI5nH/zbBzN7UGX5IR330yQCTkkghsX
         x/i8EYOmRcZ5miEe3msrpDJM1LwdcubvWKutFOrQC9ZsrnKCFVoovIJtR/zheNuX5BEm
         A12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TYM9RAesGeaqNz2jBk6tvQuIkZPINQDoc+UjrbhzKIs=;
        b=V0TV4rA8UXbg90EIxwCa7dEuR0ZXuMOAdvh0URiqxJeVa0vSJ2/Fsb93Ha8JZ8esFh
         xf/QhZO7EPYV7+fXGMxL8WxOtWQDY9dfZQzUVAv/jn3E7zmx9WcNi1PaoG0ZRc/13Dbj
         V4ofkNQ0Ac3OI8nyx9aBOAijlmvCaPR9zViz1943S/L/VyYaoDrCUbyWHRaxAnbhHPW1
         xryF1jiCM93RbCKjO+rVCsL8MJH89yOhnpcjdqEQSh5O5CUhaP8FpU/MZuPLW8fuywsi
         BOMI4larW2Nij8FJG/HZDO5ieK0SZFxmLQQuNExvarH8Ur+BcbwFZ3Dg+yTB5ojtYjbL
         M9CQ==
X-Gm-Message-State: AOAM533QpTOZhr9QkidkSjAQX2bWNMDzfCMEY4sW+k6j5LPDuLuNIyY1
        CM5zgWGtjQIEnAg9NdMywfTzz4MvMX0=
X-Google-Smtp-Source: ABdhPJy9f/HVpY0DNdpyEWsRre46PdK84qtOVQuZTJkBZwWR25VJRjm5df3pq2tSYEBJP2TaqoffCA==
X-Received: by 2002:adf:fa86:0:b0:207:aadd:bff5 with SMTP id h6-20020adffa86000000b00207aaddbff5mr5131905wrr.469.1650663018504;
        Fri, 22 Apr 2022 14:30:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi7-20020a05600c3d8700b0038eb78569aasm5075958wmb.20.2022.04.22.14.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:18 -0700 (PDT)
Message-Id: <a9b35e770f32dce0443c15a11caabc3c8e15faaa.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:47 +0000
Subject: [PATCH v6 21/28] t7527: FSMonitor tests for directory moves
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
index c9c7dd77e3c..d0e681d008f 100755
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

