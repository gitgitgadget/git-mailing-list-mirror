Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9499AC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbiEYPCa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbiEYPBf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D0AFAC5
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k30so30497972wrd.5
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Q8NCwKBR4h76mmPvMVi3XVoVst203o7US4feb91EME=;
        b=WjdZXm8D5OR3dPMDEbFWZO3W4dDb5o1HwztXVjPcp6y147WqhXVzc00tg0Z+y4SCZH
         VoYQ6xj5ukenOc4tPFZSLH+kNZr8FkiePFZFrPV6FTGoHiD7Fr2T9vEEj2V7ZdAiji6P
         5k/f+uG+Iw0Kye4J0MNFW4fArFAHcd4QBATzGRVXvNfUqSlxQG7WTt8xa6z3PJknvGf7
         0E0mkj/+mcNP9TAfnI5BkEwF2MOk9HuMEtqaguAnLfgm36LSmgpmq1uUOHiFuJR7H0Rg
         IkgD7TfctXG9Rjbm0rsHtwuYfsL24maFxiBQEFnL6/lAQbr6N+Hu4uL9uQbJlyq3DFf5
         3+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Q8NCwKBR4h76mmPvMVi3XVoVst203o7US4feb91EME=;
        b=DYhNDTuUyjwjHq8dqGEa8n8I1nTpA8zrluIa13fySANSB26NK3kskl9qJp+B6tgI/e
         cRpJhHGDeoCsxlF14wIRQvr0TzwhtpDzDoJpUSgeAUSKr9vOAtxMavVRfTaOCmLl000z
         T7czsKEbHvp7NhwtR2Mj5diCzdFNztw2s6XUpNZQeo8Hg5SPg2Qnlm3h8xCZLzyYqzXH
         N+/dumDb+M11bp4edYOZzoMU0XWSFbdOv7z0Yi+Xa6e4oqwE34bEK3bkbJ21x4J5aKEb
         jLTRlYinaeZoDrFd1qpg+wlwB7P8nmjFdThLwZxv5d92ZLHWafBbL68gavBLd1wVJEo9
         wNeQ==
X-Gm-Message-State: AOAM530YcyfXhfp2qfGejLurTChU3NqzujrJeHUuZwe2T4KJDK4QFIol
        d/wrqtdmIkYKadA+Gmih/ATkRYOTsOk=
X-Google-Smtp-Source: ABdhPJyi77Gm8QNyKb3DnLUHyFMVEZ4blanXBWfTa4IXPt3JMxyc3wrL5glXFjlSpEH5cnUVv1khtw==
X-Received: by 2002:a05:6000:91:b0:20f:fb45:ab0a with SMTP id m17-20020a056000009100b0020ffb45ab0amr4303060wrx.34.1653490891467;
        Wed, 25 May 2022 08:01:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 206-20020a1c02d7000000b0039771fbffcasm1398678wmc.21.2022.05.25.08.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:30 -0700 (PDT)
Message-Id: <40b80adbb31e866afb2b74b681695d3dadffc8df.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:46 +0000
Subject: [PATCH v8 24/30] t7527: test FSMonitor on case insensitive+preserving
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
 t/t7527-builtin-fsmonitor.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index cf4fb72c3f0..fbb7d6aef6e 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -832,4 +832,40 @@ test_expect_success 'submodule always visited' '
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

