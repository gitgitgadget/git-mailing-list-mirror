Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7EBBC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiCVSD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240220AbiCVSDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:03:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F062869CF4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:01:00 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so1436162wrg.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jGZDkT+MUFBJpraI3WUoND6rWQdI4FmV4UvOjCEtaXU=;
        b=kUyMepLw12m5YYe7Id/QOL6YC3xLq2wwCWUfDFNCpSGOgIbbvn0HxRniW4eYEFxQUu
         jepSgpCc2ZjqjXlyl5OZIvYw5k7+PnCsOBs0U71LVy6Ri6GrY9a79BMQVZQMs92z3v5F
         PyR1o8yIm/laeFg7bby59WGpPYMkmzvVAReB90kCQzS2fZcZZKkyoCwESLwYII/hhSqt
         U3j3LPzFVz1YKUceSZ6J9xLj1kv8aEMOSGRInil1TgUVqQ5wRmz6PAT5uhFcFf9KT6F/
         DrgIvFiqnQXlZrnjBv26dx88zfnuhRK9JMc8mpGkpjdUc7cfFgW+0gBSsGg4eOTXfS/g
         917g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jGZDkT+MUFBJpraI3WUoND6rWQdI4FmV4UvOjCEtaXU=;
        b=y4GKziox/y94jM//vLZi9NMTxgEnwTbVyNCVshkxarRS47NdSU2+RVX29nTfak16t9
         CdaSWf0l8NWNUOmvZupPWvrGXh//BQcU0rWU0Yka9MB4EtqK/obbzCKLx92KSQCENL6y
         I4LvKfkSN8nZ6F0ct+XI0DigSIrC+HB7osOYrulTip8yqu52P2+VAIT2lHSbx2E72A39
         hqWMGGQslwWhEwXVz3b4zb1Hq+v3JsGTfGByvzg6Mw9+7p4lVRJDL4yc122ovmVbZ4d9
         tubgGqSH8DAeH9lUO/y7j0F8bHGmx8vSKlGhovaAuDH1Li21bwr916HFE2uPyjIEdvK5
         cmbg==
X-Gm-Message-State: AOAM531cdUbgph2NnZcpZwnIQF+l3qXGzLumzWi1xnbOU6bwMUjspFsw
        UdHd5mwII47d0Z9qvaEmZjwQRI6HKY8=
X-Google-Smtp-Source: ABdhPJzE/2dgd8g+cayowu3hN5u06uFcSwu3DPOvYlAJOhd8QzDW+HcUrZpAqti6xtGZ7K9/FL/tJg==
X-Received: by 2002:adf:a482:0:b0:1e3:3e5f:496c with SMTP id g2-20020adfa482000000b001e33e5f496cmr23109215wrb.606.1647972059361;
        Tue, 22 Mar 2022 11:00:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d64a3000000b00203ed35b0aesm22708759wrp.108.2022.03.22.11.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:58 -0700 (PDT)
Message-Id: <e6cf84dc8eb4933220187849b84e5cb96cda185f.1647972011.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:00:10 +0000
Subject: [PATCH v7 29/29] t7527: test status with untracked-cache and
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
 t/t7527-builtin-fsmonitor.sh | 93 ++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index d79635e7596..389ebf431c6 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -212,6 +212,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.fsmonitor=false add . &&
@@ -498,4 +500,95 @@ test_expect_success 'cleanup worktrees' '
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
