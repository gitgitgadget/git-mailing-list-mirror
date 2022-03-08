Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DB0C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350671AbiCHWR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350699AbiCHWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:59 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A041580C9
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:52 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u10so234490wra.9
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=alHS+bRntRrjIrbh+LYXIH/iRVyMrR0OzALWZ2LvUN8=;
        b=MGoM7STdI4Z4yjmaxPZP/sMcnPyg4T21BDkkktbjjoRkBm38dv2OO4IqF4db9CwP82
         tplX3LOyn/idBDGBDVrnOj2cbF+WDXuYK18+U2wnU7zuBTcuts85AN9m4tlUqDL6erxD
         RDCeMoVxD//gm0X6uWEqyT9eQH9gTrRVK4Srv8a6QVl7l5xr1QjQCln2QQaB/y8b5Cjn
         NXTp5/F8ShVkPquMIoQV4Tn30eju74Qoj/yLfuGxYg+uqeqIIid+er6QJVNCNeD4TiuF
         X2Yh/+C5biBCuVt94B9nWubKGNUub/lLrNWb5i9Cbe6MpOmvUzVIU+40zqBFL2wqSytQ
         FTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=alHS+bRntRrjIrbh+LYXIH/iRVyMrR0OzALWZ2LvUN8=;
        b=eaF3zSPu+7qraKKjgQ+WaQgl+oV+Sjng+b5cUm0uBmNVKquk4vklrrcwkgAeBovFpq
         b680bbA2UiCVUp7JNKcXDk8Yk/XIcdGX9PzImeiQQAabvgET+uUFwiVv36cRvL408s6i
         TIvUjx4WRHX644zKo3PeHeSyOuby/3pLDaJotWMaIbj2CQ9TlfO7t888nQXiCA4xrvpq
         DxPaCFkWMPh0MxsAi7H71IBKxntu4cRkil7UzXNrGg3h/skcBfl/ES2pqlt9Iur0w6y7
         VMX5MczjU9rmJn4MnFjBQQwjGO0BU/SxntqkERebWfIgY4GVAUS1Eogei4bE4VjvS8i2
         llCw==
X-Gm-Message-State: AOAM531RnCNmNeJrzyGBFAjFvOZLfxTY6NO6G+P+a+iZjm/DfclCxgFx
        igAJ+qbaye+sMdBJqxXjLrDAVQFVqhY=
X-Google-Smtp-Source: ABdhPJwS7AbnVyTofQLhXxEsQWRG1p/S8hEGcBwlhadxFSrSc+nBGFqeNKVJyWLj1Q3LZEn+xsklBQ==
X-Received: by 2002:adf:bc09:0:b0:1f0:2483:48b with SMTP id s9-20020adfbc09000000b001f02483048bmr14351788wrg.118.1646777750805;
        Tue, 08 Mar 2022 14:15:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12-20020a5d548c000000b001f1f99e7792sm78101wrv.111.2022.03.08.14.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:50 -0800 (PST)
Message-Id: <06a32413854c2b35f289da3b42861fc051e1d4cc.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:20 +0000
Subject: [PATCH v2 20/27] t7527: FSMonitor tests for directory moves
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create unit tests to move a directory.  Verify that `git status`
gives the same result with and without FSMonitor enabled.

NEEDSWORK: This test exposes a bug in the untracked-cache on
Windows when FSMonitor is disabled.  These are commented out
for the moment.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index c2627f28865..8b63067cbf9 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -231,6 +231,16 @@ test_expect_success 'setup' '
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
@@ -324,6 +334,19 @@ verify_status () {
 	echo HELLO AFTER
 }
 
+move_directory_contents_deeper() {
+	mkdir T1/_new_
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
@@ -655,6 +678,22 @@ do
 		matrix_try $uc_val $fsm_val file_to_directory
 		matrix_try $uc_val $fsm_val directory_to_file
 
+		# NEEDSWORK: On Windows the untracked-cache is buggy when FSMonitor
+		# is DISABLED.  Turn off a few test that cause it problems until
+		# we can debug it.
+		#
+		try_moves="true"
+		test_have_prereq UNTRACKED_CACHE,WINDOWS && \
+			test $uc_val = true && \
+			test $fsm_val = false && \
+			try_moves="false"
+		if test $try_moves = true
+		then
+			matrix_try $uc_val $fsm_val move_directory_contents_deeper
+			matrix_try $uc_val $fsm_val move_directory_up
+			matrix_try $uc_val $fsm_val move_directory
+		fi
+
 		if test $fsm_val = true
 		then
 			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
-- 
gitgitgadget

