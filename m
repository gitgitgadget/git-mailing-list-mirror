Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F38C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiCYT3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiCYT3f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:29:35 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84BF55F8
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:04:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id b19so12043517wrh.11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tPukjc2YCWWKLgm+y0vzYwCeZbE+rpSJVnltmQJirJA=;
        b=mUFWqCyOYa6oTUlDM2GjTy+X7vAgEhh/Il/qGrGCVAuV38GDUazHZeqMLdWHF+W+ip
         HyAigA2x/9/voqtLjPthIYtyC9LCbMyZW/JIjJyVvyQY2/2O3Bj8ZOveEALOm3P1LAQS
         vZbq/EI1Zd6Xbmc0ZhXVK68t7eAwyMbJIxxgTG5SMFO+00/p8Ur44WVs/Hez41baB27c
         E5DOLYGgC6CXuYykiop/i+id41MzTsq/P2ZcsZsA5JvYIn1ggkkyLyNPxI03zgkpUJd2
         3jE588Gy48NGLJVovZq6bqiPJ/sYVkPl+McU+LS6hYkCxnA9wNnv8QBqZv05wU5ct+wp
         jI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tPukjc2YCWWKLgm+y0vzYwCeZbE+rpSJVnltmQJirJA=;
        b=GL6JlfSGNMehF8sHW0b6LHbotXzop91tHEVIwFLOCOgat94aKzSqZyAed4Q55g/MX2
         HqUnNRuspyeKnDjFdWJLMYz3Upx31cG3hbm35iwZLnK8XQgTuSsKuXc1bptf+xOMmU1J
         8xU937eQ+LQC4UEfEDvzRGLRF0MsRjCxuYO6Efw9oQcqBhRLY6wmtmpZRKm5S2KfDAOt
         P8p2OZav0dseSqm3FqVTpCts9MaXHQW4RZ1gu6cilcSXJOg6WM5Fp2jsR9KlZfpF7IeS
         KtjoWcBCcs5HsS1Z31aZX8aXQZYSgWFk73vpg0Zt3UJ3sLnERHZje3fMNLBw5ZitHG6n
         LSWw==
X-Gm-Message-State: AOAM533pAcHFNn15eGYURd0YIw1PjgPHuVysr5EqiWQRHYGfhM1JFrns
        7zcoMW4OLPRlsvWLN0S5iGwyYRNmlpA=
X-Google-Smtp-Source: ABdhPJxgwuOTLgboq4OMf2efZhLbyfkG6YpiX3lll68xNQ1Hl5MtCbGzRK/iY3BBF+DhDgUEAmtX1w==
X-Received: by 2002:adf:e348:0:b0:1f0:537:1807 with SMTP id n8-20020adfe348000000b001f005371807mr10136376wrj.11.1648231427880;
        Fri, 25 Mar 2022 11:03:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm5575743wrv.79.2022.03.25.11.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:47 -0700 (PDT)
Message-Id: <5eb696daba2fe108d4d9ba2ccf4b357447ef9946.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:03:13 +0000
Subject: [PATCH v9 30/30] t7527: test status with untracked-cache and
 fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create 2x2 test matrix with the untracked-cache and fsmonitor--daemon
features and a series of edits and verify that status output is
identical.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7527-builtin-fsmonitor.sh | 115 +++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 062e01c0dfc..bd0c952a116 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -205,6 +205,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.fsmonitor=false add . &&
@@ -491,4 +493,117 @@ test_expect_success 'cleanup worktrees' '
 	stop_daemon_delete_repo wt-base
 '
 
+# The next few tests perform arbitrary/contrived file operations and
+# confirm that status is correct.  That is, that the data (or lack of
+# data) from fsmonitor doesn't cause incorrect results.  And doesn't
+# cause incorrect results when the untracked-cache is enabled.
+
+test_lazy_prereq UNTRACKED_CACHE '
+	git update-index --test-untracked-cache
+'
+
+test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
+	test_unconfig core.fsmonitor &&
+	git update-index --no-fsmonitor &&
+	test_might_fail git fsmonitor--daemon stop
+'
+
+matrix_clean_up_repo () {
+	git reset --hard HEAD &&
+	git clean -fd
+}
+
+matrix_try () {
+	uc=$1 &&
+	fsm=$2 &&
+	fn=$3 &&
+
+	if test $uc = true && test $fsm = false
+	then
+		# The untracked-cache is buggy when FSMonitor is
+		# DISABLED, so skip the tests for this matrix
+		# combination.
+		#
+		# We've observed random, occasional test failures on
+		# Windows and MacOS when the UC is turned on and FSM
+		# is turned off.  These are rare, but they do happen
+		# indicating that it is probably a race condition within
+		# the untracked cache itself.
+		#
+		# It usually happens when a test does F/D trickery and
+		# then the NEXT test fails because of extra status
+		# output from stale UC data from the previous test.
+		#
+		# Since FSMonitor is not involved in the error, skip
+		# the tests for this matrix combination.
+		#
+		return 0
+	fi &&
+
+	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
+		matrix_clean_up_repo &&
+		$fn &&
+		if test $uc = false && test $fsm = false
+		then
+			git status --porcelain=v1 >.git/expect.$fn
+		else
+			git status --porcelain=v1 >.git/actual.$fn &&
+			test_cmp .git/expect.$fn .git/actual.$fn
+		fi
+	'
+}
+
+uc_values="false"
+test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+for uc_val in $uc_values
+do
+	if test $uc_val = false
+	then
+		test_expect_success "Matrix[uc:$uc_val] disable untracked cache" '
+			git config core.untrackedcache false &&
+			git update-index --no-untracked-cache
+		'
+	else
+		test_expect_success "Matrix[uc:$uc_val] enable untracked cache" '
+			git config core.untrackedcache true &&
+			git update-index --untracked-cache
+		'
+	fi
+
+	fsm_values="false true"
+	for fsm_val in $fsm_values
+	do
+		if test $fsm_val = false
+		then
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor" '
+				test_unconfig core.fsmonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop
+			'
+		else
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
+				git config core.fsmonitor true &&
+				git fsmonitor--daemon start &&
+				git update-index --fsmonitor
+			'
+		fi
+
+		matrix_try $uc_val $fsm_val edit_files
+		matrix_try $uc_val $fsm_val delete_files
+		matrix_try $uc_val $fsm_val create_files
+		matrix_try $uc_val $fsm_val rename_files
+		matrix_try $uc_val $fsm_val file_to_directory
+		matrix_try $uc_val $fsm_val directory_to_file
+
+		if test $fsm_val = true
+		then
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] disable fsmonitor at end" '
+				test_unconfig core.fsmonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop
+			'
+		fi
+	done
+done
+
 test_done
-- 
gitgitgadget
