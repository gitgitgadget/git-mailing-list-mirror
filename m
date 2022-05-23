Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589CAC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiEWUOs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiEWUNu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:50 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6762ABF58
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h14so22902444wrc.6
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kUTb3iU8XWgR798P6YdKsfHBU+ci261+gHJ9yA28Wks=;
        b=MEn70yO8KybukVpZz1m+7E9pszRXh/2O3MmETx1fvjlcGLDfnxl700IPZJLVvBmQio
         e1rPy4I01aPeOCLg0L2RJAJDpIJZ4/1JcrXYLsCRXxfv4Stn8dfVtxQvmLTnyQRBzJd4
         KhM4KIMywkOtYn8QtAfvm1xdSF7NFH4eyjR1FTRKjgOe2o2WF8PmMhRsdq/4ceGqGD9L
         ozI83c7U12kRNPZegQ3YcnA4p6qqB4WdqSE9ScxFwrO0mP1qbqTWspU8HT9D34OunfRO
         qO8TfqwE5uaeYsmCgRgWrekthJoYj4+atSv4kOe8RssC1UIudoj3b5rqUAC2UVbyvvbR
         xYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kUTb3iU8XWgR798P6YdKsfHBU+ci261+gHJ9yA28Wks=;
        b=x57LT0HDRz0E8g/JXnEfUvIzj3cvT1rT3DPN4Q6yee7SURk7fdwap1HoCoBwXpbY2d
         U6OguCLxpTEUNknUaRLl0ZnrsrVC+ZZjYowoH3XhtHgBfMQlIpB9bVdMy/gLUmLSqY5e
         zupWX20cYLc63qmHd6udVx+7x1BE6jlcgtdDX6EbkNWj2FUe4eKilGXndg8k4Ek7c4Hx
         C0lc6GEq72gsDG1nTPG1JLHiXD9iCOp1hyw1N5oFLWDe+onSpL0bjH6yrAxaHxTJJuY9
         kDBotzrk8iusLQWiKpS93JYGFJjdUZR4+ptsH+g65P9fXYexMVNHTPZEBcU1Jo3seR1Y
         uZWw==
X-Gm-Message-State: AOAM5329f7iwN68cA3ODvrOPgtd590P2wdbQ+vQR0P51aj1u0bLQSTDS
        jAOyYP3U5nYyQs+1di0gnXoV9Dy7280=
X-Google-Smtp-Source: ABdhPJynyV0wWO0SEjNHXncfYRAajsNXAdCPplHqVP3iwAlOb3kucsORh/XWkp4LUlF7I0pIiJHjdg==
X-Received: by 2002:a05:6000:1786:b0:20e:6267:5700 with SMTP id e6-20020a056000178600b0020e62675700mr19764374wrg.600.1653336795226;
        Mon, 23 May 2022 13:13:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13-20020adfba4d000000b0020fe86d340asm2386138wrg.98.2022.05.23.13.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:14 -0700 (PDT)
Message-Id: <d058d7e0c0829bed9df266c4f6c9f12c30caad4d.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:36 +0000
Subject: [PATCH v7 21/30] t7527: FSMonitor tests for directory moves
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

