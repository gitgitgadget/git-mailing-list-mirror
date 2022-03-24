Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2D6C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351957AbiCXQxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351954AbiCXQwx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:52:53 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE06B18A1
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r13so7458027wrr.9
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fUl1iulHJn6M4DhZIvnlR7KK07qkvc0JZ9TAzGaZ+4M=;
        b=pJEsXNMIzGLeQf2nzCscTNgYHFiEQ6mHBnl9Nv2qjHwexcQhG0dBE+tgnL7aKQwwzQ
         tuTIMa5sFtF6Sij0Ct8eqD4PE1hFO3E80l7K+uYNSD8YGmG/e1B3UYulmMuHbPxhNTgY
         Q8a5JFcum+YSTKHYiIAIolLNY9Ts3htoSoCjfZX7R9P4rnylc6CVarBEEF3zssAGsNXD
         OYDwbv7qyqBcOGtsQDzhOLZW6bdBHqe39A3+ww21/OGZRitMBatb4+CZEQFODn8f+HHG
         VcygVjTBx50z9sn/G0akBx/Y0p0hzXC41r8cZnAtNsrSJIceK/dQTrs3XkYVqpbNyoYx
         q/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fUl1iulHJn6M4DhZIvnlR7KK07qkvc0JZ9TAzGaZ+4M=;
        b=5jKSFTwUiNP/1WxCQZtgw03dDeCXLv5yKoDcEikdp+srhQVCpfhwb4Zwy7WQ64w/o+
         Tw865O7ymBH3MP1lIPzADxlBC6ufRJpiH7inpHHejuB2xcG0b/THp00ublPt2cRkEaZs
         ED40T3/In3Eikuigrs2Xe6/ZYE+SseetoqCW4X0VHnGCn5k11z/jClh42259UG8fTiNd
         f8srl+4aNMNnY5M9KJCE5/CSod3b38k/r9x0kuKO8W3jtQH7i9Tpq/h/K4Sd8kNkyf+l
         NyiGNmH2JKu3J2ItWnLzS5bHxXvk/foPOO+xeO4QlN/Pgw0Vt2g7ocRWPzsFM+em6T96
         hRCw==
X-Gm-Message-State: AOAM533NosfktW3ZtbE90xmd0VWxy2GpavIgYjsvdwb1ZzM7VnnfGGDz
        VuPOtoVzCxG10otFyTqML+we0agbqoU=
X-Google-Smtp-Source: ABdhPJxY3zYRl1BEj4b22FFHYQjaVeJ2x7ailUSEwyFGFH2bjInTcqZfOnXbWpAqJtDuC4NeGvITDw==
X-Received: by 2002:adf:fb47:0:b0:1ed:9f2c:492e with SMTP id c7-20020adffb47000000b001ed9f2c492emr5521150wrs.196.1648140627720;
        Thu, 24 Mar 2022 09:50:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d6181000000b00203fc0e79a3sm2978571wru.46.2022.03.24.09.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:50:26 -0700 (PDT)
Message-Id: <f87a1eba693b297d049281fa2d0c21b573027347.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:46 +0000
Subject: [PATCH v8 30/30] t7527: test status with untracked-cache and
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
        Tao Klerks <tao@klerks.biz>,
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
index 3570bf764aa..1c40d8d2035 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -216,6 +216,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.fsmonitor=false add . &&
@@ -502,4 +504,117 @@ test_expect_success 'cleanup worktrees' '
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
