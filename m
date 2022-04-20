Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D028EC433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382227AbiDTUrl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382204AbiDTUrK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:47:10 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFA63CA79
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:58 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i20so3833840wrb.13
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QQfkCROKa0jO56Rlj7mP24f41yEspKClpJ9PGHlvIJM=;
        b=JuSf5DxL/9riqWIbFBPXJMcHh3VFrOHwZQcQK35DBbNku3kJwPcHO0R53ufpdYhk7m
         moJkc6tvJ1dsa7SOQzMxLc3UGYJUhhcCBDLbcxZlXrk4sUpfVAnht0UgzFXnDKULuGcC
         vWcVV9xyYB/o4+rq5GiGoijHbbmOI0orMfDnEW5v49L6Fei/wrieP3GcfE8iFnCq8BGi
         ydl+ArBdbroE/M6XnnHhn++qUzQEjY0RAYM5jo3CYJxuwEpbRIrWHeI/qx2sKnKyGGyY
         6vDbx2YvTFmn7Dkg1Hu2zliOH0ki3FSwrXYlmQUbTlvrWlGmBPPffAVGtWRBKmqkrfLa
         kvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QQfkCROKa0jO56Rlj7mP24f41yEspKClpJ9PGHlvIJM=;
        b=SYp2E3xfOWapx9jgamvMoYKqLeZbYoV+28+nVEqykPsmmRBZ8EkTjkiThb1Xpo9o0y
         /cW5JY3ju+4x/12mEzQRt/b3rK2hcEvErRkSZyiQvHOwoh2Di+tWpeImB72QTFJ5zqQf
         4QJtJ5y/kfao5Edzwztn8bB2hIn7GCmI3Q90E9H5lH2PvLNEIFfhb2D1z8JEAS3cNfkG
         AI/5KWKYiR6o+x+0AB5g5/ClPUoBvTWKSOFcBVfaMIS6C6lu+yIgEkBzXGKSzPU/K1ty
         rbVa07LHzh9/JrBfQ5Ekw0lBibHQL/8nXcwiK5uGhZOuFEXx8mwLErDmlnNn5ew/ag+K
         zuow==
X-Gm-Message-State: AOAM530msb2KJ0ELKX6CHfbvCsDZSsH7h5L4t//w05jXkrvSAA8YLDPm
        DJscMKVdJaaiccT4hX5jn77sMLzxh/A=
X-Google-Smtp-Source: ABdhPJw7amANwpkB7ZYGU0RlMEJtCx99pnhdy4OjawqF0zbW13yCSX1cVqVOCzEfvaxIV88G02T67Q==
X-Received: by 2002:a05:6000:2a1:b0:20a:7ae5:70ff with SMTP id l1-20020a05600002a100b0020a7ae570ffmr17414578wry.717.1650487436735;
        Wed, 20 Apr 2022 13:43:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v2-20020adf8b42000000b0020aa790a258sm712364wra.8.2022.04.20.13.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:56 -0700 (PDT)
Message-Id: <b8325fb7c78d44dad44fd13ef5d9e81519dd8868.1650487399.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:43:18 +0000
Subject: [PATCH v5 28/28] fsmonitor--daemon: allow --super-prefix argument
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
index 5476a01cbff..237df6f3c4f 100755
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
+	create_super "super" &&
+	create_sub "sub" &&
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
