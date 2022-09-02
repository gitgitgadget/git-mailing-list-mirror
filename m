Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FE2C001B5
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 16:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiIBQGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Sep 2022 12:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiIBQFx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2022 12:05:53 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC391264A6
        for <git@vger.kernel.org>; Fri,  2 Sep 2022 08:59:40 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id e13so2889048wrm.1
        for <git@vger.kernel.org>; Fri, 02 Sep 2022 08:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=ebEbClj28u/OFZ6mfth/2Z8IDZ5nSDnITNepZWQuAH8=;
        b=LLffPWkCwddA0C7C6k5P3KD1YdUrh6xWU3OZiaT29U2vL01WbaMPZfd/h2NSfXmasO
         FvXlvbaWwyQ6uSmn7EjtHXKLj51HSIhsGbfxclP3P+GuAFlcOUaG+wWSPi5LYMe2pmM1
         25Nyv2dbEkvR4Ux82SX3f5tqtsRTLjwxFGUEKh+f2X6K2uPpECCye7I8y5jc6XukWmfh
         +Y9EGWckXescdgo6893mOzgmT8RbX6SG2QNehJLWXj21FrUbTvuByC8n3ECoyHKnGpLH
         yDrxU6x9utjKXk3MyB0bc/Df0CiKgxMApwwTNlIGsrIcPJzZ7C0lokXK/XfVqkYoQTzX
         LE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ebEbClj28u/OFZ6mfth/2Z8IDZ5nSDnITNepZWQuAH8=;
        b=pb/mSLeyDG7ydqs9fhn0vM4EwR/yQ/1IauwHhRvSycdxhzu1qcm5Ym29MaJgS1bD+R
         pkmMg0mazFrxZuCOf+KlI6crt5NE+rg/+CC8uUqozwmemDYxxiJWOv+6tSK0BYnb24Kw
         j8vRTDXUZ5kA9TsLSmtMc7EZLvHlygfDCwBf5t6O7TlH4/a9wzimn256V4AaLBJ0Ujvq
         Qn4efZf/R7yheneIrhYfnCfG1CwAerrQGvLCX/ZxXH6nGPZN1l9tKxhVdj5WARePlSv/
         ffdYPOtHYRKOQa/l3Qz3+w8tqwPuJZzbfol4OA49Ut/ZxndrXqZqcYB1oUfhfsz5/nDd
         tzDg==
X-Gm-Message-State: ACgBeo3QODIvDv5ZyDuqrKNMkvl+iJjZ8oo8HeS0FT2WEJxjrLQn1//c
        kZivju7mljsqxNo2pI4nDdCpotcKM+U=
X-Google-Smtp-Source: AA6agR6n5Wp9EXNlfRBTNTkTVVk0IMbXE8+RSWHKh6xVxSD86mHKQK4YQ+BuHAx9GoGkl8/Qdix6FA==
X-Received: by 2002:a5d:64cd:0:b0:226:e332:3d1 with SMTP id f13-20020a5d64cd000000b00226e33203d1mr10916664wri.253.1662134218606;
        Fri, 02 Sep 2022 08:56:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id by8-20020a056000098800b0021d6dad334bsm1817867wrb.4.2022.09.02.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:56:58 -0700 (PDT)
Message-Id: <15acf20274bc78231cbbcb456b303d24fc2ba425.1662134210.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
        <pull.1341.v2.git.1662134210.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 15:56:47 +0000
Subject: [PATCH v2 6/9] scalar-clone: add test coverage
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create a new test file ('t9211-scalar-clone.sh') to exercise the options and
behavior of the 'scalar clone' command. Each test clones to a unique target
location and cleans up the cloned repo only when the test passes. This
ensures that failed tests' artifacts are captured in CI artifacts for
further debugging.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/t9211-scalar-clone.sh | 151 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100755 t/t9211-scalar-clone.sh

diff --git a/t/t9211-scalar-clone.sh b/t/t9211-scalar-clone.sh
new file mode 100755
index 00000000000..dd33d87e9be
--- /dev/null
+++ b/t/t9211-scalar-clone.sh
@@ -0,0 +1,151 @@
+#!/bin/sh
+
+test_description='test the `scalar clone` subcommand'
+
+. ./test-lib.sh
+
+GIT_TEST_MAINT_SCHEDULER="crontab:test-tool crontab cron.txt,launchctl:true,schtasks:true"
+export GIT_TEST_MAINT_SCHEDULER
+
+test_expect_success 'set up repository to clone' '
+	rm -rf .git &&
+	git init to-clone &&
+	(
+		cd to-clone &&
+		git branch -m base &&
+
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git switch -c parallel first &&
+		mkdir -p 1/2 &&
+		test_commit 1/2/3 &&
+
+		git switch base &&
+
+		# By default, permit
+		git config uploadpack.allowfilter true &&
+		git config uploadpack.allowanysha1inwant true
+	)
+'
+
+cleanup_clone () {
+	rm -rf "$1"
+}
+
+test_expect_success 'creates content in enlistment root' '
+	enlistment=cloned &&
+
+	scalar clone "file://$(pwd)/to-clone" $enlistment &&
+	ls -A $enlistment >enlistment-root &&
+	test_line_count = 1 enlistment-root &&
+	test_path_is_dir $enlistment/src &&
+	test_path_is_dir $enlistment/src/.git &&
+
+	cleanup_clone $enlistment
+'
+
+test_expect_success 'with spaces' '
+	enlistment="cloned with space" &&
+
+	scalar clone "file://$(pwd)/to-clone" "$enlistment" &&
+	test_path_is_dir "$enlistment" &&
+	test_path_is_dir "$enlistment/src" &&
+	test_path_is_dir "$enlistment/src/.git" &&
+
+	cleanup_clone "$enlistment"
+'
+
+test_expect_success 'partial clone if supported by server' '
+	enlistment=partial-clone &&
+
+	scalar clone "file://$(pwd)/to-clone" $enlistment &&
+
+	(
+		cd $enlistment/src &&
+
+		# Two promisor packs: one for refs, the other for blobs
+		ls .git/objects/pack/pack-*.promisor >promisorlist &&
+		test_line_count = 2 promisorlist
+	) &&
+
+	cleanup_clone $enlistment
+'
+
+test_expect_success 'fall back on full clone if partial unsupported' '
+	enlistment=no-partial-support &&
+
+	test_config -C to-clone uploadpack.allowfilter false &&
+	test_config -C to-clone uploadpack.allowanysha1inwant false &&
+
+	scalar clone "file://$(pwd)/to-clone" $enlistment 2>err &&
+	grep "filtering not recognized by server, ignoring" err &&
+
+	(
+		cd $enlistment/src &&
+
+		# Still get a refs promisor file, but none for blobs
+		ls .git/objects/pack/pack-*.promisor >promisorlist &&
+		test_line_count = 1 promisorlist
+	) &&
+
+	cleanup_clone $enlistment
+'
+
+test_expect_success 'initializes sparse-checkout by default' '
+	enlistment=sparse &&
+
+	scalar clone "file://$(pwd)/to-clone" $enlistment &&
+	(
+		cd $enlistment/src &&
+		test_cmp_config true core.sparseCheckout &&
+		test_cmp_config true core.sparseCheckoutCone
+	) &&
+
+	cleanup_clone $enlistment
+'
+
+test_expect_success '--full-clone does not create sparse-checkout' '
+	enlistment=full-clone &&
+
+	scalar clone --full-clone "file://$(pwd)/to-clone" $enlistment &&
+	(
+		cd $enlistment/src &&
+		test_cmp_config "" --default "" core.sparseCheckout &&
+		test_cmp_config "" --default "" core.sparseCheckoutCone
+	) &&
+
+	cleanup_clone $enlistment
+'
+
+test_expect_success '--single-branch clones HEAD only' '
+	enlistment=single-branch &&
+
+	scalar clone --single-branch "file://$(pwd)/to-clone" $enlistment &&
+	(
+		cd $enlistment/src &&
+		git for-each-ref refs/remotes/origin >out &&
+		test_line_count = 1 out &&
+		grep "refs/remotes/origin/base" out
+	) &&
+
+	cleanup_clone $enlistment
+'
+
+test_expect_success '--no-single-branch clones all branches' '
+	enlistment=no-single-branch &&
+
+	scalar clone --no-single-branch "file://$(pwd)/to-clone" $enlistment &&
+	(
+		cd $enlistment/src &&
+		git for-each-ref refs/remotes/origin >out &&
+		test_line_count = 2 out &&
+		grep "refs/remotes/origin/base" out &&
+		grep "refs/remotes/origin/parallel" out
+	) &&
+
+	cleanup_clone $enlistment
+'
+
+test_done
-- 
gitgitgadget

