Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C31C433FE
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351976AbiCXQyE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351903AbiCXQxX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B6EAF1E5
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:51 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so7513471wrg.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=LjtzV8mZv5c+OEC0dIXKDp5i1zGkkX+xjRt469dhrJI=;
        b=BvzoVJ9hhMpU3dTKEpj4qw226hCy7JWl10L0W8YC9Xi5XBf8Y4KOVVhgTi7cNBYvRK
         I05manmjYqzHsgi8nVdgkf4l3pMw52Mp2eXsY0r8yfLVYhaFmNGIKhAuEQ8E+zHFZ3FB
         IbFgQwCUjLfkCwcS8QtK0zN9Fktkv3sKvaRgBVeK19yOObXxgI/fgHUp9fKj1D5wRk8H
         6oGH6ZLQBVlP1PfEif90OvgPRPk7PVAdGe3n2MRbNPnUKTsfjeGry7gndNSUqQ2lP9UJ
         09mipEQMFcoI+xclFWU/bLOaP6M6Cor+YKl0gu6jwj48W2BkePxbAj6rdy1YRN19AnRX
         H6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=LjtzV8mZv5c+OEC0dIXKDp5i1zGkkX+xjRt469dhrJI=;
        b=z5SvmuVxrtxfWJ1MOQOFM9mT3atqtLJPasIF35F036ugNnNDtvgsDM9sxfSWp+K8y4
         PaXRszvdHGQSpIAusYgFHRRhYAzXXLhAOYl5KNddchzDcguHolkBaHwS4JDOti2k7yWT
         h6o+jA0casmTJpw1CrM7nubHwqivHv+2hGR46rQ2OxGcaRrZ0IU9nLdwLOMWJgLBax5a
         wQTciJ8T4kGS96a7Hjq0G5BDOyiYwvjWit7wKBwwAv4PJSUag+91DzgqnR9VwNm5P37N
         keqHE0Kyp4QRmJkdS2HjnflgvZCBWKqfloGBYAy817TvARIO8QztSUhrPUCA+hvx3RRW
         N3mQ==
X-Gm-Message-State: AOAM533Ku1pNeUa5VCp5bhsVByjYdom4jah3jm6qsQi3vwfzYLgF5re6
        ib/i4yoTXWuykD2L2gP0ZJj59tFg+PQ=
X-Google-Smtp-Source: ABdhPJweloF+MgR/EMfpZyQD2yWVFm6zfuaKRjHcmwHNbLVmluqiHt9LUumHqs6m9i1E9rRzNLZINQ==
X-Received: by 2002:a5d:6101:0:b0:204:871e:9912 with SMTP id v1-20020a5d6101000000b00204871e9912mr5333337wrt.60.1648140710053;
        Thu, 24 Mar 2022 09:51:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10-20020adfe40a000000b00203eb3551f0sm4231250wrm.117.2022.03.24.09.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:49 -0700 (PDT)
Message-Id: <3010b22e6906a0a18128004abe7cd7eb2953d1f5.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:14 +0000
Subject: [PATCH v4 21/27] t7527: FSMonitor tests for directory moves
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
index 0509ffe30f2..3f794fb9821 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -285,6 +285,16 @@ test_expect_success 'setup' '
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
@@ -367,6 +377,19 @@ directory_to_file () {
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
@@ -671,6 +694,10 @@ do
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

