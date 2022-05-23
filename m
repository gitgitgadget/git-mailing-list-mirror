Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16858C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 20:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbiEWUPN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 16:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiEWUNv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 16:13:51 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A26AEE1D
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:27 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id p189so9456198wmp.3
        for <git@vger.kernel.org>; Mon, 23 May 2022 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uU2/c+aPwrNZLDw5bIR3T3N2u2DdFYRmZnPeQS1ZxNA=;
        b=azPtIJMk4u1DSZf/6M4Y18KR8OkA0CwZTSEWO6JF7wk39yHAXP9N880La8x0+FbffK
         9Qps6M12IRzSPdOE4lfROfZWCLNwNeZ1rNzhvL0aIg8LnB6xBMl1ksjhyoIFt3hPX7kN
         Ye6wpoYtKMicvoLEcQaS6XSiK2ZEMvYXzwcMGCohByns02RyKTS7hAYtj54DctIGi7r1
         606eP77onsLVZrcSEnS1efSSyeFncGM89jg95N3aCnVqz97F+4olU4QN6reho9RXm+cv
         9vZjaVkXbZ49ePWyaY3AKAH6JONvK5rYRie3dPaKCcZNOuw0AgZi+yGbvzzPYQLQLlJ2
         Bn+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uU2/c+aPwrNZLDw5bIR3T3N2u2DdFYRmZnPeQS1ZxNA=;
        b=1ukbiI9+31oA7pE1mFHtbfeMZpTemGK4ON/Bm1S2J8sCR5imHtT9mwo3Tf5nTOpLFV
         mi5PH/+E6VIJMV6MiqLoRJG/Y8Cp6gQlIUF3663cwJqQq5YB0rJ0d+DMHfHMexg3rNne
         6lcr5xjm0JJMPhivGmrgQNSnHiMctI53Y+Ke+FxYyh97rH5Dzjp+wYo9NZaZ9R9inPeB
         /dJc33UWGQ1nBpTQK/w1n+Tm6BipgTqc6bAeWhs4+b+nhaeu7Cb7GHqmQ6Dm8tCEc6H8
         pfx73XY9yPw995emk6NgLMrXZRQxRuohVPdtgATLVw0//B7UTKu2N2hecryCafj770qz
         kuCw==
X-Gm-Message-State: AOAM532z+NL/jiVQv2npa8wtmclWjzGY/jh0cEteI/g5mvE032k3yNNg
        m6NNvasuc2lLRZczpj63fiS8AhAb3FE=
X-Google-Smtp-Source: ABdhPJxK2DYfx5wfh7uNMSSHLZ5/FJ2XlUlaR52GocSs8FTHeTt5kgu6iYB9BqgNkACMTdOcQPrU6Q==
X-Received: by 2002:a05:600c:1c9b:b0:394:77fa:c7db with SMTP id k27-20020a05600c1c9b00b0039477fac7dbmr610758wms.87.1653336803975;
        Mon, 23 May 2022 13:13:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc350000000b00397470a8226sm224429wmj.15.2022.05.23.13.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 13:13:23 -0700 (PDT)
Message-Id: <9fc7c970929d025f023666ce5d8432a3bcfa1714.1653336765.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
References: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
        <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 May 2022 20:12:44 +0000
Subject: [PATCH v7 29/30] fsmonitor--daemon: allow --super-prefix argument
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

Create a test in t7527 to verify that we get a stray warning from
`git fsmonitor--daemon start` when indirectly called from
`git submodule absorbgitdirs`.

Update `git fsmonitor--daemon` to take (and ignore) the `--super-prefix`
argument to suppress the warning.

When we have:

1. a submodule with a `sub/.git/` directory (rather than a `sub/.git`
file).

2. `core.fsmonitor` is turned on in the submodule, but the daemon is
not yet started in the submodule.

3. and someone does a `git submodule absorbgitdirs` in the super.

Git will recursively invoke `git submodule--helper absorb-git-dirs`
in the submodule.  This will read the index and may attempt to start
the fsmonitor--daemon with the `--super-prefix` argument.

`git fsmonitor--daemon start` does not accept the `--super-prefix`
argument and causes a warning to be issued.

This does not cause a problem because the `refresh_index()` code
assumes a trivial response if the daemon does not start.

The net-net is a harmelss, but stray warning.  Lets eliminate the
warning.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 git.c                        |  2 +-
 t/t7527-builtin-fsmonitor.sh | 50 ++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 3d8e48cf555..e6fdac1f8e3 100644
--- a/git.c
+++ b/git.c
@@ -537,7 +537,7 @@ static struct cmd_struct commands[] = {
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
-	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
+	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, SUPPORT_SUPER_PREFIX | RUN_SETUP },
 	{ "gc", cmd_gc, RUN_SETUP },
 	{ "get-tar-commit-id", cmd_get_tar_commit_id, NO_PARSEOPT },
 	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 9edae3ed830..19edc96fd4d 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -832,6 +832,56 @@ test_expect_success 'submodule always visited' '
 	my_match_and_clean
 '
 
+# If a submodule has a `sub/.git/` directory (rather than a file
+# pointing to the super's `.git/modules/sub`) and `core.fsmonitor`
+# turned on in the submodule and the daemon is not yet started in
+# the submodule, and someone does a `git submodule absorbgitdirs`
+# in the super, Git will recursively invoke `git submodule--helper`
+# to do the work and this may try to read the index.  This will
+# try to start the daemon in the submodule *and* pass (either
+# directly or via inheritance) the `--super-prefix` arg to the
+# `git fsmonitor--daemon start` command inside the submodule.
+# This causes a warning because fsmonitor--daemon does take that
+# global arg (see the table in git.c)
+#
+# This causes a warning when trying to start the daemon that is
+# somewhat confusing.  It does not seem to hurt anything because
+# the fsmonitor code maps the query failure into a trivial response
+# and does the work anyway.
+#
+# It would be nice to silence the warning, however.
+
+have_t2_error_event () {
+	log=$1
+	msg="fsmonitor--daemon doesnQt support --super-prefix" &&
+
+	tr '\047' Q <$1 | grep -e "$msg"
+}
+
+test_expect_success "stray submodule super-prefix warning" '
+	test_when_finished "rm -rf super; \
+			    rm -rf sub;   \
+			    rm super-sub.trace" &&
+
+	create_super super &&
+	create_sub sub &&
+
+	# Copy rather than submodule add so that we get a .git dir.
+	cp -R ./sub ./super/dir_1/dir_2/sub &&
+
+	git -C super/dir_1/dir_2/sub config core.fsmonitor true &&
+
+	git -C super submodule add ../sub ./dir_1/dir_2/sub &&
+	git -C super commit -m "add sub" &&
+
+	test_path_is_dir super/dir_1/dir_2/sub/.git &&
+
+	GIT_TRACE2_EVENT="$PWD/super-sub.trace" \
+		git -C super submodule absorbgitdirs &&
+
+	! have_t2_error_event super-sub.trace
+'
+
 # On a case-insensitive file system, confirm that the daemon
 # notices when the .git directory is moved/renamed/deleted
 # regardless of how it is spelled in the the FS event.
-- 
gitgitgadget

