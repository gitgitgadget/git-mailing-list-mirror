Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73434C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351970AbiCXQyb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351962AbiCXQxj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:53:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669D9B0A6F
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h4so7461650wrc.13
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YdTvUAWiXuQmPZccH82HfdnQNSh1BkB0JOVGIddrSQM=;
        b=ME4oT3uN2rdPvDT8yWowliq+UuvHlSYc4h8dyrLTnLtJPl/2OT6Wlr+oOclZZ+7H1U
         POf2TsXQdEhaVKEuvRSnG7ARFwVqwRQfw49fmM380vDvnLX3T+pwp3+LP6GOjFZSMlFg
         PxZdEIlF7Vo0BZd2OeLZ8n3FgveUVCe5ARXRsRV/7b45dLJGWSYy5yT0+Lcj/WJz2CNZ
         ARSal0bU6sumOJwrpY41QwOrkSa9VWaroyRRPTWNZ3npChtBTa+phR3CKZwyUgFn2uZn
         5Am99FkPFcQ+DhQLXcwdjQOsNux8pkZWtiNdaz6FoSUiEEdmXMtcpMME4+4rohkZAlWZ
         YBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YdTvUAWiXuQmPZccH82HfdnQNSh1BkB0JOVGIddrSQM=;
        b=4gwf+cNPBVLGeicPOwNHgwYBKD5PFucfnpcK/Av6zAnoGo02i5olcPgWch1oLkOVBv
         kaTPjExaKzY8gxtaJsAdO6Gn3eWq6ABQd2fordT6/4KmMyU0YjsT9MG0szMnwFLrgI9/
         6mQO3a9NP8XHbv0XO85BqKZtePuJx6/MFVIi0PUokStkE5OopTnXn3LAP03LTIzZyX16
         Jg+VlYWmN3+B5MuZugi33HUZKASkphCTYPYtUQzxICTbP3iG/545u02eRYaTQrViOi01
         5gXBSNPqNo9IbzjsrI0TvTXuuNW8BjsmPFuf84kwKIr+H2yg+qjB7zoZPIvEFaKodEwD
         00AA==
X-Gm-Message-State: AOAM531oRibPsI8zNT69eACPwD+xLwiCLYYMG9VKjR8K/YHQYJviFCXe
        k2mTU0XO94+1MSQ0Y/1zGXJEFLVsiPo=
X-Google-Smtp-Source: ABdhPJwTyKtzWkZVqCvLO4fB5qc0X1tNSHdChlYh2hpyLYQ8sIZLKDXU3NYeCBbCe54m8SiBOEJmyA==
X-Received: by 2002:a05:6000:2ca:b0:205:9e2d:ae37 with SMTP id o10-20020a05600002ca00b002059e2dae37mr705723wry.128.1648140714848;
        Thu, 24 Mar 2022 09:51:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm3612273wri.52.2022.03.24.09.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:51:53 -0700 (PDT)
Message-Id: <6e99f5e4f2a97a3fc416c5b0d2014ec61f79721f.1648140680.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
References: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
        <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:51:17 +0000
Subject: [PATCH v4 24/27] t7527: test FSMonitor on case insensitive+preserving
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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
 t/t7527-builtin-fsmonitor.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 7de178a9bf8..0b92a9bc22f 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -825,4 +825,40 @@ test_expect_success "Submodule" '
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
+
+	start_daemon -C test_insensitive --tf "$PWD/insensitive.trace" &&
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

