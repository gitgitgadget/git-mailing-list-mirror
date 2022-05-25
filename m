Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82861C433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbiEYPCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245057AbiEYPB5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:57 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B01B0414
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p19so4186902wmg.2
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=btuy/6nsewzbtzT+ydmOLWgKtgnAfHH3ecrs/ObWIdg=;
        b=knQ3ljRqldvTgMWI9dsIAUkDmsGyxsnfNDY+WvSFshcEIoXarKU3NF40/ZDhUpEqio
         1RU/19w7xg+Z13MD3+a2voCZdvHuhg8vI7Ef6L6V1Bf//NhkVaxSa4NOoA/jSf0plOGT
         wN0paQpmZa3Nq+fh2Ya9b4GX7jwqFc9Z5odmTsu2XehoFKsYYiL0eHIvY5lzh7V6BWyC
         htg96xja/6YVVSXVYnzlOfy6lCK5B5I+xV8BclybVVHRCKhyl2PMHf0vyN/14Nok/lX4
         0SpPyKcw5ukGW1p1YwVU0vdHVE/lxottACtPPqMfALiLKsJ+kwxryB1t8e8+t+DWIHeW
         69Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=btuy/6nsewzbtzT+ydmOLWgKtgnAfHH3ecrs/ObWIdg=;
        b=idXvh0yXlwxdXGKz6o2gPjXypVz6MhfnSY3/JY2K9uOXPyMl5gRZbhHus+sN7qLOyv
         ngwxNF5HiCW3Gro3PoNRMGsE3aVZu4VW2LnlcI3G0e4KyljM5yg/W1O1nFWx/uxWOsPY
         C9S23FZEtbqysSyKskI6Ox5A80yRsl1hNaGDcK2OWaOZaTu0At46ibxM1uHcm28oA/r+
         xo2HjS7aRq60j5eN+BMI1283OjgQyn9rYHRIJt5V0ivi5YdsH8vKubGvMug/6HzUiB0W
         4blKa60+IXNKrJfAhBWu4mZcL99fKnwrVsm20L4gGNKIJySVkxJq+zfmo8dyJaUIvEPd
         qLYQ==
X-Gm-Message-State: AOAM531h59jnJ/LQaNMphz0rTOrBPuVwSY7kEhO1lW3oe2eQtPsPKtcI
        rEpXZVFQj9cumKOMn8h/2eh37g86OEE=
X-Google-Smtp-Source: ABdhPJx4r9ff8gC4yhX/ewHglbWdTgiBkelRQCBkGlXHLk+cEWYN2ZfAuRU0RtSlvYV9Key7UAaqRQ==
X-Received: by 2002:a05:600c:a03:b0:395:bb63:b457 with SMTP id z3-20020a05600c0a0300b00395bb63b457mr8647790wmp.192.1653490903683;
        Wed, 25 May 2022 08:01:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az19-20020a05600c601300b003973c54bd69sm2093056wmb.1.2022.05.25.08.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:43 -0700 (PDT)
Message-Id: <d70d2545a5a97efa226a7796e317c4447e81bf96.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:52 +0000
Subject: [PATCH v8 30/30] t7527: improve implicit shutdown testing in
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
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
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
