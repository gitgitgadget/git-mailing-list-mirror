Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5AC0C433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD8F46121E
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 14:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231702AbhJUO22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhJUO1v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 10:27:51 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EFC061233
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:29 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so310053wrv.9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MWkQxm8DkZA7vgDWcKlPWF0sm3Y54JBB2C4HoOMBks4=;
        b=GlBNmRcYuIpVP8p0/bwDSPwfQTjBXFGI6oYtNyb+w/HNsRJO8qW2OFVyq8U4JMCWAo
         R3nW/LIXzfYUhjRPsPGvq4FVK79r/dmBs0r+2PK7u5AnCZSaraLID+d7jcSbMV148Vex
         WKYR0kyeRbnxYsGa3py6HO9LGAr6bywxuyIU8xwv8vBQoksOTBljfvbOCgi3vsVv1cak
         D2yP4QZ39HE7e5aplJLBwRTgjxmtkmBYN/6wMrF5CkDahpoKSfcYj1IHwF7e0h7GoQFA
         AtHJDpx4baFn/PSXNjynZzGWoZNqBhEwOMhdYj6LAUJglIUh/YwRbjaTZWLBcGorNEpQ
         e8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MWkQxm8DkZA7vgDWcKlPWF0sm3Y54JBB2C4HoOMBks4=;
        b=kozWTzX1WY87uhNbP6YLK0VwQdTanaJ9S0p2q0up7iKoSb56JnFHAOBLTjmU0XN1GI
         NixGzDpZ3yH2ogiUPdNo2s6qvfYyc6UU2hIjEYsGyf7H3zdum4972oVlIljILtkdknzC
         eCo53daHnu5afjy4yoz1mZ9EXOqLL4RniywUaucxUOBzAm657SXpkVmwDy0XSTpQI8PM
         8NgPQDxyaLGZshQiIgZPgjGQnTexFOPbPzr6E2HjhH7Cc5KBO0wQ5v7lRuwsEbtIJBSm
         WLmmuszGWvSQvbauK+kKx+HkH66ds5A9jqTIJ4+f725+TzPNcCLRtA2829tOQy+tNbII
         Acng==
X-Gm-Message-State: AOAM531o91oWaaaSZycoeTLCYIZtyt8Pi8UlIE1dElJU/99I/6MRMgXg
        laXWus3Xp4yj27qE+CNGjs572TzhUYQ=
X-Google-Smtp-Source: ABdhPJyJc6ln47NjJ/1JwN7UudttGSjEs5a6+gm2ukCp7o2ItHNyi621ZaXS43L93X6T6sUWs2UGag==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr7731329wry.12.1634826328224;
        Thu, 21 Oct 2021 07:25:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm5991099wms.27.2021.10.21.07.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:25:27 -0700 (PDT)
Message-Id: <507020bbef08a02afc53815754cc999c390eb7c7.1634826309.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
References: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
        <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Oct 2021 14:25:09 +0000
Subject: [PATCH v4 29/29] t7527: test status with untracked-cache and
 fsmonitor--daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
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
---
 t/t7527-builtin-fsmonitor.sh | 96 ++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index eea9ca1a309..e62ec9aa3ca 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -162,6 +162,8 @@ test_expect_success 'setup' '
 	.gitignore
 	expect*
 	actual*
+	flush*
+	trace*
 	EOF
 
 	git -c core.useBuiltinFSMonitor= add . &&
@@ -508,4 +510,98 @@ test_expect_success 'cleanup worktrees' '
 	stop_daemon_delete_repo wt-base
 '
 
+# The next few tests perform arbitrary/contrived file operations and
+# confirm that status is correct.  That is, that the data (or lack of
+# data) from fsmonitor doesn't cause incorrect results.  And doesn't
+# cause incorrect results when the untracked-cache is enabled.
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+test_expect_success 'Matrix: setup for untracked-cache,fsmonitor matrix' '
+	test_might_fail git config --unset core.useBuiltinFSMonitor &&
+	git update-index --no-fsmonitor &&
+	test_might_fail git fsmonitor--daemon stop
+'
+
+matrix_clean_up_repo () {
+	git reset --hard HEAD
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
+		if test $uc = false -a $fsm = false
+		then
+			git status --porcelain=v1 >.git/expect.$fn
+		else
+			git status --porcelain=v1 >.git/actual.$fn
+			test_cmp .git/expect.$fn .git/actual.$fn
+		fi
+	'
+
+	return $?
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
+				test_might_fail git config --unset core.useBuiltinFSMonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop 2>/dev/null
+			'
+		else
+			test_expect_success "Matrix[uc:$uc_val][fsm:$fsm_val] enable fsmonitor" '
+				git config core.useBuiltinFSMonitor true &&
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
+				test_might_fail git config --unset core.useBuiltinFSMonitor &&
+				git update-index --no-fsmonitor &&
+				test_might_fail git fsmonitor--daemon stop 2>/dev/null
+			'
+		fi
+	done
+done
+
 test_done
-- 
gitgitgadget
