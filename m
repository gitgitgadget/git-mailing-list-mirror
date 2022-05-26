Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553F7C43219
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349406AbiEZVuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348520AbiEZVtg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:36 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2E5EAD2E
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id k30so3653640wrd.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3IAiMHgRwhfbvkUdsr17fwV8M0Qk+EnCGfvQEEa+RAk=;
        b=anIOTXtCGKdky1X+Fo1AbP3CtOApG3F+KJgGfuM8/hD5EGRX5FNCdn73UQi21E+zFV
         +JBeS0PnL+4p/BOSuva3oGOJ4ulIaJLnqSK6uMMduK3+zVQn5iH3eu3kPd1tYC2pCbpn
         0RD1/fHJp9FiXcnS5N3tybb8OZTkmQKUS+BWhbBCO+VbPIbrAGOAzOPvQ912b6PvOBir
         mAPQ6H8ZJ17cTx7NnuCQlRK5ofs9jPwsp0PoG9AJ3bPuXbKWpTyAc9QsAHkavan0WgGR
         84csCr8jJ5aMnTLJ8rzD/6KHVt9A58+j+7szZAk72zgRl8WDQCw0uilHxQX2psI4elaY
         vwaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3IAiMHgRwhfbvkUdsr17fwV8M0Qk+EnCGfvQEEa+RAk=;
        b=fo+2jsR3w0ZKzP5/cY83FFKN4y4VFjpq0+lrdUjuP//3bX6yxY9lqNaeTn9r5OHRLa
         29HaZuY+0xmLOAYH2LcOOzGWd9zsm1WZBz1WwjP7RqEidB+8NMQYlCd8bYf3mPPNRUAi
         U6f8kmaQs61tzQ6JGNTzKAejly/H4Py7f67KMZA9Gd6n11ICOWZYo7hTx1v7LWZLhiJS
         VWEEpe36TeD3B/5uCTgWFhIj+M1GM66N0Jk87zvN69VNMsWM271BM48y9pubS8llzUb/
         z+MFvVE9PuRNoeCmLa40rMa+18aEPsiNRyp4d5ggPPCiUsKWScakfzmRRySk1Z8BAYxS
         xjCg==
X-Gm-Message-State: AOAM532wBiZIIYEY7Zjbum0yqM8+mOLZTP+RMdjbgQBJEh31flnsZIrJ
        ZbZF9DBmyzbV7ClWcEBp+eUVZkVMqFE=
X-Google-Smtp-Source: ABdhPJzIa0s6A6w3n1qbn8oJZ3c8RPYaEC5zvKVteidzQ8frCcBJn4F122aH5F9xxwTwMAwawCDcFQ==
X-Received: by 2002:a5d:6da7:0:b0:20f:eb44:f3c3 with SMTP id u7-20020a5d6da7000000b0020feb44f3c3mr14859675wrs.621.1653601768363;
        Thu, 26 May 2022 14:49:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m5-20020a1ca305000000b003942a244f3asm314379wme.19.2022.05.26.14.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:27 -0700 (PDT)
Message-Id: <81559df45ab6283bc0ee69ac252fd3691f057ed1.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:16 +0000
Subject: [PATCH v9 22/30] t/perf/p7527: add perf test for builtin FSMonitor
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

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7527-builtin-fsmonitor.sh | 257 ++++++++++++++++++++++++++++++
 1 file changed, 257 insertions(+)
 create mode 100755 t/perf/p7527-builtin-fsmonitor.sh

diff --git a/t/perf/p7527-builtin-fsmonitor.sh b/t/perf/p7527-builtin-fsmonitor.sh
new file mode 100755
index 00000000000..9338b9ea008
--- /dev/null
+++ b/t/perf/p7527-builtin-fsmonitor.sh
@@ -0,0 +1,257 @@
+#!/bin/sh
+
+test_description="Perf test for the builtin FSMonitor"
+
+. ./perf-lib.sh
+
+if ! test_have_prereq FSMONITOR_DAEMON
+then
+	skip_all="fsmonitor--daemon is not supported on this platform"
+	test_done
+fi
+
+test_lazy_prereq UNTRACKED_CACHE '
+	{ git update-index --test-untracked-cache; ret=$?; } &&
+	test $ret -ne 1
+'
+
+# Lie to perf-lib and ask for a new empty repo and avoid
+# the complaints about GIT_PERF_REPO not being big enough
+# the perf hit when GIT_PERF_LARGE_REPO is copied into
+# the trash directory.
+#
+# NEEDSWORK: It would be nice if perf-lib had an option to
+# "borrow" an existing large repo (especially for gigantic
+# monorepos) and use it in-place.  For now, fake it here.
+#
+test_perf_fresh_repo
+
+
+# Use a generated synthetic monorepo.  If it doesn't exist, we will
+# generate it.  If it does exist, we will put it in a known state
+# before we start our timings.
+#
+PARAM_D=5
+PARAM_W=10
+PARAM_F=9
+
+PARAMS="$PARAM_D"."$PARAM_W"."$PARAM_F"
+
+BALLAST_BR=p0006-ballast
+export BALLAST_BR
+
+TMP_BR=tmp_br
+export TMP_BR
+
+REPO=../repos/gen-many-files-"$PARAMS".git
+export REPO
+
+if ! test -d $REPO
+then
+	(cd ../repos; ./many-files.sh -d $PARAM_D -w $PARAM_W -f $PARAM_F)
+fi
+
+
+enable_uc () {
+	git -C $REPO config core.untrackedcache true
+	git -C $REPO update-index --untracked-cache
+	git -C $REPO status >/dev/null 2>&1
+}
+
+disable_uc () {
+	git -C $REPO config core.untrackedcache false
+	git -C $REPO update-index --no-untracked-cache
+	git -C $REPO status >/dev/null 2>&1
+}
+
+start_fsm () {
+	git -C $REPO fsmonitor--daemon start
+	git -C $REPO fsmonitor--daemon status
+	git -C $REPO config core.fsmonitor true
+	git -C $REPO update-index --fsmonitor
+	git -C $REPO status >/dev/null 2>&1
+}
+
+stop_fsm () {
+	git -C $REPO config --unset core.fsmonitor
+	git -C $REPO update-index --no-fsmonitor
+	test_might_fail git -C $REPO fsmonitor--daemon stop 2>/dev/null
+	git -C $REPO status >/dev/null 2>&1
+}
+
+
+# Ensure that FSMonitor is turned off on the borrowed repo.
+#
+test_expect_success "Setup borrowed repo (fsm+uc)" "
+	stop_fsm &&
+	disable_uc
+"
+
+# Also ensure that it starts in a known state.
+#
+# Because we assume that $GIT_PERF_REPEAT_COUNT > 1, we are not going to time
+# the ballast checkout, since only the first invocation does any work and the
+# subsequent ones just print "already on branch" and quit, so the reported
+# time is not useful.
+#
+# Create a temp branch and do all work relative to it so that we don't
+# accidentially alter the real ballast branch.
+#
+test_expect_success "Setup borrowed repo (temp ballast branch)" "
+	test_might_fail git -C $REPO checkout $BALLAST_BR &&
+	test_might_fail git -C $REPO reset --hard &&
+	git -C $REPO clean -d -f &&
+	test_might_fail git -C $REPO branch -D $TMP_BR &&
+	git -C $REPO branch $TMP_BR $BALLAST_BR &&
+	git -C $REPO checkout $TMP_BR
+"
+
+
+echo Data >data.txt
+
+# NEEDSWORK: We assume that $GIT_PERF_REPEAT_COUNT > 1.  With
+# FSMonitor enabled, we can get a skewed view of status times, since
+# the index MAY (or may not) be updated after the first invocation
+# which will update the FSMonitor Token, so the subsequent invocations
+# may get a smaller response from the daemon.
+#
+do_status () {
+	msg=$1
+
+	test_perf "$msg" "
+		git -C $REPO status >/dev/null 2>&1
+	"
+}
+
+do_matrix () {
+	uc=$1
+	fsm=$2
+
+	t="[uc $uc][fsm $fsm]"
+	MATRIX_BR="$TMP_BR-$uc-$fsm"
+
+	test_expect_success "$t Setup matrix branch" "
+		git -C $REPO clean -d -f &&
+		git -C $REPO checkout $TMP_BR &&
+		test_might_fail git -C $REPO branch -D $MATRIX_BR &&
+		git -C $REPO branch $MATRIX_BR $TMP_BR &&
+		git -C $REPO checkout $MATRIX_BR
+	"
+
+	if test $uc = true
+	then
+		enable_uc
+	else
+		disable_uc
+	fi
+
+	if test $fsm = true
+	then
+		start_fsm
+	else
+		stop_fsm
+	fi
+
+	do_status "$t status after checkout"
+
+	# Modify many files in the matrix branch.
+	# Stage them.
+	# Commit them.
+	# Rollback.
+	#
+	test_expect_success "$t modify tracked files" "
+		find $REPO -name file1 -exec cp data.txt {} \\;
+	"
+
+	do_status "$t status after big change"
+
+	# Don't bother timing the "add" because _REPEAT_COUNT
+	# issue described above.
+	#
+	test_expect_success "$t add all" "
+		git -C $REPO add -A
+	"
+
+	do_status "$t status after add all"
+
+	test_expect_success "$t add dot" "
+		git -C $REPO add .
+	"
+
+	do_status "$t status after add dot"
+
+	test_expect_success "$t commit staged" "
+		git -C $REPO commit -a -m data
+	"
+
+	do_status "$t status after commit"
+
+	test_expect_success "$t reset HEAD~1 hard" "
+		git -C $REPO reset --hard HEAD~1 >/dev/null 2>&1
+	"
+
+	do_status "$t status after reset hard"
+
+	# Create some untracked files.
+	#
+	test_expect_success "$t create untracked files" "
+		cp -R $REPO/ballast/dir1 $REPO/ballast/xxx1
+	"
+
+	do_status "$t status after create untracked files"
+
+	# Remove the new untracked files.
+	#
+	test_expect_success "$t clean -df" "
+		git -C $REPO clean -d -f
+	"
+
+	do_status "$t status after clean"
+
+	if test $fsm = true
+	then
+		stop_fsm
+	fi
+}
+
+# Begin testing each case in the matrix that we care about.
+#
+uc_values="false"
+test_have_prereq UNTRACKED_CACHE && uc_values="false true"
+
+fsm_values="false true"
+
+for uc_val in $uc_values
+do
+	for fsm_val in $fsm_values
+	do
+		do_matrix $uc_val $fsm_val
+	done
+done
+
+cleanup () {
+	uc=$1
+	fsm=$2
+
+	MATRIX_BR="$TMP_BR-$uc-$fsm"
+
+	test_might_fail git -C $REPO branch -D $MATRIX_BR
+}
+
+
+# We're borrowing this repo.  We should leave it in a clean state.
+#
+test_expect_success "Cleanup temp and matrix branches" "
+	git -C $REPO clean -d -f &&
+	test_might_fail git -C $REPO checkout $BALLAST_BR &&
+	test_might_fail git -C $REPO branch -D $TMP_BR &&
+	for uc_val in $uc_values
+	do
+		for fsm_val in $fsm_values
+		do
+			cleanup $uc_val $fsm_val
+		done
+	done
+"
+
+test_done
-- 
gitgitgadget

