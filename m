Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2AAC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 15:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiEYPCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 11:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239987AbiEYPB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 11:01:56 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B4BAFB35
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:44 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id bg25so12631266wmb.4
        for <git@vger.kernel.org>; Wed, 25 May 2022 08:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uU2/c+aPwrNZLDw5bIR3T3N2u2DdFYRmZnPeQS1ZxNA=;
        b=PN7zz//7vtGO8uHoiUVcldNxos/iH1OzBNr58CgNferJ04sWITLusyb1FphSlyefz2
         TJPt/YKHaxttBCC7b0oo/KRMsve19wN87E/QXwhlH1N6z1b8ZQO0MkFJpaav2qXgjEPU
         lGNZWcTZqsQwvYYSSJ0jKmUxmMlCUn+y3dhM/kFnj1bPRE7Wy3quIM5PMka3bqqzEG2l
         pBOHy6+7iH39aCsqMqGOq5wE4XI5N0BKdjYMJIcKeSNqo3uncf5uCxqis/j5jEun2aUs
         7nFfThBG17f+wm7ucrAln9DeSNVtoBgiKdo37aPob3SzHKVfUOHFvaxjISsV3jLPI4dD
         b7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uU2/c+aPwrNZLDw5bIR3T3N2u2DdFYRmZnPeQS1ZxNA=;
        b=6ywvWkDbDwA4gtr75OKM71/tjECAlenmuglLtkOapvBat7PXfnXkyph0fXSg13IcET
         0bfXMllHve23yJSX4c0LIiNNm5AaVxlMb9HEAhjdI7ew5HCaKFmEXMGCIWWLI8SEZmfd
         j91kcIXNZ6xhJNZGFx7BVG58D2KTdCFn/V6klXzRALbbSyWlYeVXUbAZWRw77hL+3LVI
         Z9SS2revxR2/1sLNgGxiFQkEgXl6dHkFZ8ry6xCqenDKvNjF8Wy0wvp4Mt9a93hNlzL6
         5AY4dU4TNHUcvnmpM71ZS4GTprseLZ1BYFChe19KMy3YkpeFH5Su1DYb7luRiF1nCZhU
         5Wsg==
X-Gm-Message-State: AOAM530yvpm7u4exAcxOWJhWlsvona0oQnPX5mteMY2QgD6WmQO+c5Ld
        cuZUuD2B0hNQFA2tbNNvkCiSy6ozHJs=
X-Google-Smtp-Source: ABdhPJx1S9itMT9ntMqL9VBfDtp1HEhAqz6nEI+ZxG5saRxiQLm7ylf8QuroRdw0e7Oj0OdNgV/DHA==
X-Received: by 2002:a05:600c:600b:b0:395:b668:b3fa with SMTP id az11-20020a05600c600b00b00395b668b3famr8477848wmb.46.1653490902077;
        Wed, 25 May 2022 08:01:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a0560001a5100b0020c5253d914sm2287449wry.96.2022.05.25.08.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:01:41 -0700 (PDT)
Message-Id: <25676ca4ec2bdaa6fdaf265dcdfe39b06d4d7bfe.1653490853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
References: <pull.1143.v7.git.1653336765.gitgitgadget@gmail.com>
        <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 May 2022 15:00:51 +0000
Subject: [PATCH v8 29/30] fsmonitor--daemon: allow --super-prefix argument
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

