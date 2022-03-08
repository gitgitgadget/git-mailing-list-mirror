Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9DC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350716AbiCHWRd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350714AbiCHWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:59 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA78580FD
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:55 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r10so271093wrp.3
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4+KRgNH1UC8Hq1Q1521pi3Q8bCSKs8SjV1oI5ePqdS4=;
        b=ANd79n6FDu04bhyUPcD2cBU6yG6M8lbMG2cXX87NNXUwlrnP/WudNHKmbUrt2rQp4e
         5joz0C7CxyMcYEetyDACp5HNC2BZpOOu6XLfmgmf3fhQAnlrLddQF1qxI0fKvEpSaKcU
         wVxbgpeR9ttz13jQDI6BQ2gD2x91B9i7REE3HwBhxPGLmk/lVCXcDnOX5UWVh+5MXk8f
         3UkixrjDz+eAhoHtFTgxQ/nvcGzgNoA0PN64iLL/Bc9Yck+OibPFpdmjxjlKWyEuLILt
         D9BBdbnN7TpspfyIh1R0sr7uTqTvDRZ6bnIjKJgcJ4Zqn7UMz+lamj6wXtyf6qENt6ot
         zlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4+KRgNH1UC8Hq1Q1521pi3Q8bCSKs8SjV1oI5ePqdS4=;
        b=cn9EQjn6NgOYHlYigE5E+IAlxcV0aZDiuG7cp0KJvs16snljcPQQxSzunDGzfwGR/k
         f2Q7R7dsUUtv1soQ1Ky7X8SKte5g0bUduHvGt04t4ZSmdjFB0YEeUBIcfUTyIVrVibmC
         bUK6NR5OjJrIK/VE0mcc1SGTr0/SD/a8Ojyi9sdmi3sy0Xvwxbnu3K8pCTcghKEDLBJ7
         KncnYCIoLX9cm0LgqmazCen9ByHaPOIY9LZ822wqwVWZ7lL725oeBRD1gZNzhlmLUd2m
         ZI1CqcPOy1kgi39smLrs8pIAC5MF7vgMyz3dk1oeYvj/qqlFPS3jnkST66UqRpSAtcL8
         +rHA==
X-Gm-Message-State: AOAM532nM1iw0C195AUvsNkatXIEy2/B+nvWpxtGVLQPRVkrf1WC6Vz+
        cgf4Qm7Zf82B2VEmEiFTFKV+FyJ5fjA=
X-Google-Smtp-Source: ABdhPJw/0VsWL/w9c4FrJaTbi/q0yTXIj8qKWfc1KnCP3Bk4sCZkbIulYG5yI6uHYMkWB4E0sQPmRw==
X-Received: by 2002:a05:6000:1ac5:b0:1ea:7870:d7eb with SMTP id i5-20020a0560001ac500b001ea7870d7ebmr14091157wry.171.1646777753604;
        Tue, 08 Mar 2022 14:15:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10-20020a7bc1ca000000b00389bc87db45sm76187wmj.7.2022.03.08.14.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:53 -0800 (PST)
Message-Id: <c7264decaf6de8e3d39c3ea5421f45c93a7a84bd.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:23 +0000
Subject: [PATCH v2 23/27] t7527: test FSMonitor on case insensitive+preserving
 file system
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

Test that FS events from the OS are received using the preserved,
on-disk spelling of files/directories rather than spelling used
to make the change.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index a18e077d375..a41e37236b5 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -821,4 +821,44 @@ test_expect_success "Submodule" '
 	my_match_and_clean
 '
 
+# On a case-insensitive file system, confirm that the daemon
+# notices when the .git directory is moved/renamed/deleted
+# regardless of how it is spelled in the the FS event.
+# That is, does the FS event receive the spelling of the
+# operation or does it receive the spelling preserved with
+# the file/directory.
+#
+test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
+#	test_when_finished "stop_daemon_delete_repo test_insensitive" &&
+
+	git init test_insensitive &&
+	(
+		GIT_TRACE_FSMONITOR="$(pwd)/insensitive.trace" &&
+		export GIT_TRACE_FSMONITOR &&
+
+		start_daemon test_insensitive
+	) &&
+
+	mkdir -p test_insensitive/abc/def &&
+	echo xyz >test_insensitive/ABC/DEF/xyz &&
+
+	test_path_is_dir test_insensitive/.git &&
+	test_path_is_dir test_insensitive/.GIT &&
+
+	# Rename .git using an alternate spelling to verify that that
+	# daemon detects it and automatically shuts down.
+	mv test_insensitive/.GIT test_insensitive/.FOO &&
+	sleep 1 &&
+	mv test_insensitive/.FOO test_insensitive/.git &&
+	test_must_fail git -C test_insensitive fsmonitor--daemon status &&
+
+	# Verify that events were reported using on-disk spellings of the
+	# directories and files that we touched.  We may or may not get a
+	# trailing slash on modified directories.
+	#
+	egrep "^event: abc/?$"       ./insensitive.trace &&
+	egrep "^event: abc/def/?$"   ./insensitive.trace &&
+	egrep "^event: abc/def/xyz$" ./insensitive.trace
+'
+
 test_done
-- 
gitgitgadget

