Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C127DC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiCASpo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbiCASo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:57 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3D6661E
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:44:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ay10so4108836wrb.6
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eB3v/8E8+3K2F4p78oh14iDjR5lnR3MP13qtVVjU7W4=;
        b=j2teBM5Y6jQ0lOTO6zhREOdtqXkXQE3+AUfl/YjTdjZa7BOOgz2OrMUbA5dGwmohFl
         lwkC1rIHZQvESBJ5gn/34OMicqZVIUuTs7QJZq7eSWP4Y0UaJ/q1Ozo4ZGDSBylSekj1
         1/prGEzXPZqx9ryHmz2LOavVnB+gPjUV24GAGgDn1cSiHNZnjXi/1VlbuZtJZ7LwWvxT
         YyrvRcrsEmcAr4pqt1gBFWY4so/4P6WzaIesuH8koSaNJyvfvPYRvUpKoTVxMegy0nX1
         13g7vyII91cqcznyT8FnI1uc6Zeb+sEK9HJ8u5GvTEJ2pE4HDgcVVW8CMs9f9l91dyRH
         nzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eB3v/8E8+3K2F4p78oh14iDjR5lnR3MP13qtVVjU7W4=;
        b=s5YDMD8dUdzpqxRKXeMgAeay6s4s5okqhr4RHeQozkMCft905A7NIoXith5rcKluka
         bXguq03cJoGxFD8sCHNwi1QKkVnrQTxpTCZ1XMBxU57GoIJmRE6rgLcJ2nx2VK1ozrKV
         Er+Nr0UWXDFCgEBHE8ZklnTvSnmmNdC53WysRog3J5K4KGZb3cuZZBACAFG9uEgtGb/G
         Rsvg/aejkTI4ZbpgPV+9tRRSpI4dEYRqZb3oKEvNwEheKvfEOpHpA0/2S2Jp7bnq1rqS
         7Ch+6rstli95rLHtomi1ccRif7X5PVgzWCFp5zJhNqwQDd1wZaVMyc7AQGTAZycFQtmM
         RjyA==
X-Gm-Message-State: AOAM531nT/l853soI0UIacKoclWSzc8S5+ZDrG+3QQmigBCBnTJos4sZ
        9k8bABWx/N97o2bvHw8kgYKreXYjCqY=
X-Google-Smtp-Source: ABdhPJzF8AWwoicPoSsaHvMlFugu/huy8br+ydTJ6paQx7tICC948mIgWwf50M6Xom0uCnEZ+K7KSw==
X-Received: by 2002:a5d:4dca:0:b0:1f0:2543:e10e with SMTP id f10-20020a5d4dca000000b001f02543e10emr520911wru.60.1646160239565;
        Tue, 01 Mar 2022 10:43:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b003816bac83f6sm3703039wmg.27.2022.03.01.10.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:59 -0800 (PST)
Message-Id: <6fc1430285ff814ef972ad3f3128f09e751cdb1a.1646160213.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:31 +0000
Subject: [PATCH v6 29/30] t7527: test status with untracked-cache and
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
index 5f7b8e54233..0ccbfb9616f 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -162,6 +162,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.fsmonitor=false add . &&
@@ -508,4 +510,95 @@ test_expect_success 'cleanup worktrees' '
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
+	uc=$1
+	fsm=$2
+	fn=$3
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

