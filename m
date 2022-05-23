Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E991C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiEWUOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiEWUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A21AE272
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e28so22291227wra.10
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4Q8NCwKBR4h76mmPvMVi3XVoVst203o7US4feb91EME=;
        b=GXYaLr7v/gVfHhFTbyW4vyUMaznsZmuNREXEAIHaaQ538n1t5ygIJ0ciOTcuhvYVM7
         F1zK3G0HnfHQZGY4Nw/4/mV0fEGqQoH5unuWVzhyvtW3h/gAH+7sFgUN2AfqBMsffXC/
         vhzAA/SMUjDmlnNzNf/tQ8I8h46RXiLhckpDfMmjo6a53e/BSoGx1WXoodoXH0ZliD+N
         xCHkpxAkKnJDoLLdwy/oUnMQ6Emy01ZKvye1F1d4geGHlaODHQ5d1NwFdlRj3VQBdydT
         rclZ1qL60UJXFNddMkpWnWtz007H923GYyWaIa6qDT+jWoPnRpF4m5FwZhvOFi2UPFW2
         kRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4Q8NCwKBR4h76mmPvMVi3XVoVst203o7US4feb91EME=;
        b=YF4Fmpiyd2ytjyTP5FsVvScZysO/9X5CQJY9GTTcZGsc7v0+gUzxqSoigawJMNYI+J
         S+7e8160z3vZExBix6O30yph+ABZ1NH02KpGJe1tddI4vTM7nlkpxsuaOHpIQNjHEf0r
         EDXZglhQwy6wOxcWTuVo03stKu8qNiLmHcTmLBXCv2px9zWP7nCrNcxLYQ+F9mpECoRe
         NFkJ8D0SiWpEvGjPlFTevSM6SyghaGRVGqvzcu4N3UdZnujgjvzIHnARgP21YpDK2TVl
         VGCV9wfJ8juGWSo1RIsgfY/tEfDf8WFA7k3dSm/KA+cluIVv7+5HbwuVpQpwpm85zCkb
         lucA==
X-Gm-Message-State: AOAM531ED6oWG+MkqzcKr1Iu4yIh3H9Rt2zTDD9fZljnMDv1XZeaMKVZ
        h+NGQFzX1CKs0wwg2BK9nDrQ9rr9QQ0=
X-Google-Smtp-Source: ABdhPJwMXa9tYz2SMbFILj83pqlAarMZHaQ6ZOrd9S2Y/iPHSRJ795wq10oRvOH4lxOQYQxYEGTJhA==
X-Received: by 2002:a5d:540a:0:b0:20e:69db:4dc5 with SMTP id g10-20020a5d540a000000b0020e69db4dc5mr18679112wrv.337.1653336798739;
        Mon, 23 May 2022 13:13:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p6-20020a05600c358600b0039726cd3ae5sm344680wmq.3.2022.05.23.13.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:18 -0700 (PDT)
Message-Id: <40b80adbb31e866afb2b74b681695d3dadffc8df.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:39 +0000
Subject: [PATCH v7 24/30] t7527: test FSMonitor on case insensitive+preserving
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

