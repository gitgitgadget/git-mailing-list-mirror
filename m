Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22730C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382222AbiDTUrg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382159AbiDTUqr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:47 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E21E44A35
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:49 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg25so1263119wmb.4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TYM9RAesGeaqNz2jBk6tvQuIkZPINQDoc+UjrbhzKIs=;
        b=e0fa1mrxfkDv5SvACTxZE03x2/4BC1MWDHF1y55gkhRbgIMaTUQDzjeUEdTIaOLGqj
         FYkXuJbDY+MH+i92CsitfRQCjvI3eX+qMPgFvDqlB6JxxQdpB8JwEM/r6x9LTUaLVJXA
         aqPY4nrfvRc77I7PEkeqDbGSSN7cXtCv8MrDumPEwa5jPb48oRGvHugGEO3uBe88jfku
         HAodY5x1kEXNTRoTS0F1DL0souIYR8FCJWas4eDK/uXEnoOAMCNI80n0FXL8d0z+/Xgn
         46Gqf5vFJ2ZfjKmaNxccuZMt9e54ka27Gq1BaK3d++XjUvzxEJ4/UvgeXA60ZFmPGmXE
         j9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=TYM9RAesGeaqNz2jBk6tvQuIkZPINQDoc+UjrbhzKIs=;
        b=t/eoG14wxyph5/d7dhUtWPGNaHKPnKuuOq6oSLncEP4R2t/eQFB/01p8mlmFOhtyQq
         y+/lGHt6HUK/q+7uEncLBfBu1d8NDSd6eHC0duIEdSTuU0Y4Rgg+G/wnrLvOM4Zz3MxL
         klatiV8ybNJszLcB2TWQwGShEXDSSh7Ao8OOEB480HBw7z8gxxnSiPW2qtHI6SoiZT3F
         t3VitewrRcg3FcnJHMMuXYebRrDsjX1r0mV4bnNh14J7bDSdrwF6mRJY9mQCSvhKwSqV
         zVSmOK/WnmFH3GoNfTye50wUb0Afud1Ekiz/SUPMxozPiyFttCb2yZ9GMEZS3RLk9ygj
         OSJw==
X-Gm-Message-State: AOAM531ricnDMeAdoj425ycUY5uACcdP/HzntY0IBnQewhuwux7uw022
        Bdj+44TRNYsisrRZtmC577lT0V4b1j8=
X-Google-Smtp-Source: ABdhPJym7NJE5m4J6LEsICukTwmzUFsxjL3wEwH9B0ce/M2Ia4TVDNL7prKqIiUS6x1CMe8kGhuBKA==
X-Received: by 2002:a05:600c:4f46:b0:391:8d69:b336 with SMTP id m6-20020a05600c4f4600b003918d69b336mr5424883wmq.83.1650487427731;
        Wed, 20 Apr 2022 13:43:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f4-20020a7bc8c4000000b0038ebbe10c5esm336137wml.25.2022.04.20.13.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:47 -0700 (PDT)
Message-Id: <9d0da8fc22bd713344da11bee41e6e8c2c644b7b.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:11 +0000
Subject: [PATCH v5 21/28] t7527: FSMonitor tests for directory moves
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

