Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6CDC433EF
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiEWUPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiEWUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAA8AEE1C
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e2so11281395wrc.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7Z2VcCY4SpohDrJdBMGgDngNb1kXPfT8ojz6rlIKRBk=;
        b=Y+Xac1siAkW6IkXZukDl1f2BssM4cmVJGBG0rtqNhs9Nlpty1PAogdcscJfJLTQsGZ
         tLl02q+9hlepy9LBi/bXpnCDn+lAH5EDX9oQ8vzXrwSXWnF8B1o5IqLY0cZdCyzAeHy5
         tYQ49D7VwSRE7D/t0FjtNZWZAK2DBKAx/8lYDQjTpnvmi4xugAsRfIxPSxJpDN96QUh1
         9o8mp41Ywcut8qJyiXa01sFURXLLMbrD+4wLNI6RoBuhfCDHnqkbLzMzldneZJPS9d05
         kiZzdg0suJMDtDfB7Wh875oSzUmMxnPfATp0HsaCM2l9rAaz+TCfE1205KVWYx6PcDo3
         KgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7Z2VcCY4SpohDrJdBMGgDngNb1kXPfT8ojz6rlIKRBk=;
        b=X7TB2KHK4FTdS5Up4WJRMxrpg+inXMogqa85t1otfRPNc8Sih6pyQQ8etqI3rNTNGy
         DGGSSHXuFgHFITykpV+mmEpnRUzfL9KVpMFMoP1Mjc/jV4mKeKu7FVLpbpYUxDxaWlFJ
         BIwn76zaZLZcHKWPu21km7AXnAnBmCK0wMGpPBuwBRb6oefMI+ocsA0TOvJIY9o3YXFU
         2CfNO1YqcMXNPYEuNMyZeYe5zz9GdxsxnvYVu+D79x/I7cOHxp2Pff/9d/m9CXE2jDna
         kZNeI4i0kd3ADeJrctzuQh6ezHUVMp2DCrO52aZ07MsV0XoPQVKIa7TWaG079LOXNTmd
         BYDA==
X-Gm-Message-State: AOAM533sp8f867VMkz/i/K573CbGvf+q61pW2hvgjHloYQgaHcuOBN8l
        gStSQTEfXM62iqnt/aiEsUloWF4v4eU=
X-Google-Smtp-Source: ABdhPJyLOOm1WBOLFM1Q6eclfFNXEUis4cKanzif7/fqlaNjLGez2TM6NLrCN3SUUW2lF6MB8afcIA==
X-Received: by 2002:a05:6000:156d:b0:20f:c26d:dc0d with SMTP id 13-20020a056000156d00b0020fc26ddc0dmr13275350wrz.676.1653336804986;
        Mon, 23 May 2022 13:13:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17-20020adf9591000000b0020fd392df33sm5584512wrp.29.2022.05.23.13.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:24 -0700 (PDT)
Message-Id: <ca833ecc7a17925d3568572f183ba4fc0833a54b.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:45 +0000
Subject: [PATCH v7 30/30] t7527: improve implicit shutdown testing in
 fsmonitor--daemon
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
        Jeff Hostetler <jeffhostetler@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhostetler@github.com>

Refactor the tests that exercise implicit shutdown cases
to make them more robust and less racy.

The fsmonitor--daemon will implicitly shutdown in a variety
of situations, such as when the ".git" directory is deleted
or renamed.

The existing tests would delete or rename the directory, sleep
for one second, and then check the status of the daemon.  This
is racy, since the client/status command has no way to sync
with the daemon.  This was noticed occasionally on very slow
CI build machines where it would cause a random test to fail.

Replace the simple sleep with a sleep-and-retry loop.

Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
---
 t/t7527-builtin-fsmonitor.sh | 54 ++++++++++++++++++++++++++----------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 19edc96fd4d..56c0dfffea6 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -124,6 +124,36 @@ test_expect_success 'implicit daemon start' '
 	test_must_fail git -C test_implicit fsmonitor--daemon status
 '
 
+# Verify that the daemon has shutdown.  Spin a few seconds to
+# make the test a little more robust during CI testing.
+#
+# We're looking for an implicit shutdown, such as when we delete or
+# rename the ".git" directory.  Our delete/rename will cause a file
+# system event that the daemon will see and the daemon will
+# auto-shutdown as soon as it sees it.  But this is racy with our `git
+# fsmonitor--daemon status` commands (and we cannot use a cookie file
+# here to help us).  So spin a little and give the daemon a chance to
+# see the event.  (This is primarily for underpowered CI build/test
+# machines (where it might take a moment to wake and reschedule the
+# daemon process) to avoid false alarms during test runs.)
+#
+IMPLICIT_TIMEOUT=5
+
+verify_implicit_shutdown () {
+	r=$1 &&
+
+	k=0 &&
+	while test "$k" -lt $IMPLICIT_TIMEOUT
+	do
+		git -C $r fsmonitor--daemon status || return 0
+
+		sleep 1
+		k=$(( $k + 1 ))
+	done &&
+
+	return 1
+}
+
 test_expect_success 'implicit daemon stop (delete .git)' '
 	test_when_finished "stop_daemon_delete_repo test_implicit_1" &&
 
@@ -142,10 +172,9 @@ test_expect_success 'implicit daemon stop (delete .git)' '
 	#     This would make the test result dependent upon whether we
 	#     were using fsmonitor on our development worktree.
 	#
-	sleep 1 &&
 	mkdir test_implicit_1/.git &&
 
-	test_must_fail git -C test_implicit_1 fsmonitor--daemon status
+	verify_implicit_shutdown test_implicit_1
 '
 
 test_expect_success 'implicit daemon stop (rename .git)' '
@@ -160,10 +189,9 @@ test_expect_success 'implicit daemon stop (rename .git)' '
 
 	# See [1] above.
 	#
-	sleep 1 &&
 	mkdir test_implicit_2/.git &&
 
-	test_must_fail git -C test_implicit_2 fsmonitor--daemon status
+	verify_implicit_shutdown test_implicit_2
 '
 
 # File systems on Windows may or may not have shortnames.
@@ -194,13 +222,11 @@ test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~1)' '
 	#
 	mv test_implicit_1s/GIT~1 test_implicit_1s/.gitxyz &&
 
-	sleep 1 &&
-	# put it back so that our status will not crawl out to our
-	# parent directory.
+	# See [1] above.
 	# this moves {.gitxyz, GITXYZ~1} to {.git, GIT~1}.
 	mv test_implicit_1s/.gitxyz test_implicit_1s/.git &&
 
-	test_must_fail git -C test_implicit_1s fsmonitor--daemon status
+	verify_implicit_shutdown test_implicit_1s
 '
 
 # Here we first create a file with LONGNAME of "GIT~1" before
@@ -223,12 +249,10 @@ test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~2)' '
 	#
 	mv test_implicit_1s2/GIT~2 test_implicit_1s2/.gitxyz &&
 
-	sleep 1 &&
-	# put it back so that our status will not crawl out to our
-	# parent directory.
+	# See [1] above.
 	mv test_implicit_1s2/.gitxyz test_implicit_1s2/.git &&
 
-	test_must_fail git -C test_implicit_1s2 fsmonitor--daemon status
+	verify_implicit_shutdown test_implicit_1s2
 '
 
 test_expect_success 'cannot start multiple daemons' '
@@ -905,9 +929,11 @@ test_expect_success CASE_INSENSITIVE_FS 'case insensitive+preserving' '
 	# Rename .git using an alternate spelling to verify that that
 	# daemon detects it and automatically shuts down.
 	mv test_insensitive/.GIT test_insensitive/.FOO &&
-	sleep 1 &&
+
+	# See [1] above.
 	mv test_insensitive/.FOO test_insensitive/.git &&
-	test_must_fail git -C test_insensitive fsmonitor--daemon status &&
+
+	verify_implicit_shutdown test_insensitive &&
 
 	# Verify that events were reported using on-disk spellings of the
 	# directories and files that we touched.  We may or may not get a
-- 
gitgitgadget
