Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B0FC433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 22:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiDVWj3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiDVWiT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 18:38:19 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6F5289179
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id c10so12779180wrb.1
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 14:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fYdYWvjzE1EgS55opkbt63SsI5PTGeZOfl6/dljP550=;
        b=Y9EET3G1Fk+T1pYNgzXeZKRIKKKMfzsVOGI80XkOLQqfOXK36oYyAwiiqZLbax+BJh
         p7xgzfI/74V6unED4F6o/aRS8U3I+vRfmZPOhf1meehRGtgq7UKh+C5+HP0I5OZsK3KO
         xHm9zNEgT/3NTQ5hVDtcMJL2VYsF+Jc/LepJ/IMxu8unLGR0Bwmm1e4Tl80aG7geY2yU
         JO9UNNhAy0gOaoeSLFuzP2u4w16vpcjHeoIw+nlhtEKJr7PyFfZ3lPVcAPnD5KmTk7Bn
         V5WBp3AfKbTIAXuXIc41ha40eVGNRjuCOzZMHr3NDCh3KQ+WInFpJjncq5V2rl0qvrho
         xnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fYdYWvjzE1EgS55opkbt63SsI5PTGeZOfl6/dljP550=;
        b=uVj4KjiyJx8VVcr5uty/1Sc1tk70Ebmj5C/SZK6vsCaws15LFue3RB1YE6k6kMT/Jn
         xFr36ZIDcxKcuEUsN1D3lQuS9f8aiZlLOr/EfuG1EpOQ7BQblQnHCEtZwYQGDSaIrmjP
         HrAdpz/QYDbOIggeA6DyspTM5zxfo7IHR7nfSJBM3VzCb0uBWNJcboeBUH+1lntTKi90
         /E7Q6T2o3R8YF62aHW6fqR+B9xkzVR4P/lm1yilsSEDqBQMtE1PV5BAhcAsmCGepD52M
         jDPvdYiorOi0mjGHD0dUiUBJZS31dHloitPhWzpgE8yHa6KIt5nGNYN6U9GTK3FV1/xe
         nP/w==
X-Gm-Message-State: AOAM5332wm62m3EfkmB17EDt1Nf8XjjSz1VysL2g1/SnSrF4HdjTcXmn
        QUBnSP772T2HI1nPvj4Vf08fVl8H3LQ=
X-Google-Smtp-Source: ABdhPJy/UZk/oHhA73X5vJEZO0jmsBzdVlMmwqCb0SGDo4JWHOpWRqXY3Lbl76ALFrOo6mfAknAC/A==
X-Received: by 2002:a05:6000:15ca:b0:20a:c416:e60a with SMTP id y10-20020a05600015ca00b0020ac416e60amr5256256wry.60.1650663026067;
        Fri, 22 Apr 2022 14:30:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14-20020a5d6c6e000000b0020a9f757708sm3198609wrz.33.2022.04.22.14.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:30:25 -0700 (PDT)
Message-Id: <df1b4f3a80f812a284cff4caeb0ab2ca75e38c2f.1650662994.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
References: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
        <pull.1143.v6.git.1650662994.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 21:29:54 +0000
Subject: [PATCH v6 28/28] fsmonitor--daemon: allow --super-prefix argument
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
index ab29cca535d..f6e1d2da6d6 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -832,6 +832,56 @@ test_expect_success "Submodule always visited" '
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
+test_expect_success "Stray Submodule super-prefix warning" '
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
