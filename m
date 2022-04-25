Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF19C433FE
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244071AbiDYRwa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244060AbiDYRw1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:27 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EF7201BB
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso5874wml.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6eQ1Pc+aBHONbUEQKmYcjYqoFFXNa4hlLY7Ed9HYS/o=;
        b=DkbaRbv0v8UqCM2+0LABzbkBs7ARMpysBdDZneamfwz+7p4U511hVi/Wwurov8DGBV
         U9fS5iurcda/9SX/Vqz0EtEMpj2w3GzJE8DCli0wqz5Ap08LcvILsCkuq8b6jvPvywP1
         ELHjrgB5IzggnVGHq7GU0FJ7S+JzEvmzvp3cmyJh6iC/0C877EvdxtJjtxNLPfFX3MOx
         F+HtDXeX8knacX0zBtJsWqHbr303STAq3qjPvIW62kSFOKhf5jSb3DL+5wX1iUj8+CoS
         1wJGzeuH1RxKbmSmkjGEhWVPbHOmkvGEomePsW0PjkgUU9PmbYORwW2E8y0sJ4VFYoEP
         P6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6eQ1Pc+aBHONbUEQKmYcjYqoFFXNa4hlLY7Ed9HYS/o=;
        b=XajZ6GHG8QI++9aKiyvNCX7nr/qlmTZSWLXvZJqVsTcmzx0ubbP6MceWed4zem9b0z
         XqKiIJChf3ksNJOO+K4tGYML+nzpoVLsmkDKH3Zpz8iYR8qqkNazJccbkowOk1pCIJki
         pbaIthgswwow+GXmffbga1qv5q59Iz+tGhyf/Eob0Ln3V3SzZ2nDGwjH0gTuC303Asu/
         bLwM2Kaour9iC9mMkwqat6lFjSbS2TtrxruZbKgLvv4ZnNHwlcFTG3Z5yTEkjN1XnfA7
         gMqgDEN/xcxycAlRG/TOzWpMYDn3QmCXxlGYBkSBNyj+L/S/vU0s60RPlB+96NGaU3kP
         HeAg==
X-Gm-Message-State: AOAM533PyeaJtbRL2mmw+HPkrjWGH6RxbL1zU9ubgFULreuEFsriPX0l
        /twKqeb7zHdVWgQDvAjDmn9Pu94gpQU=
X-Google-Smtp-Source: ABdhPJy/ymP/X86PNHLujxgZOM6QQBBhgJT61Hq47CJW9UkNwQE/ZRbhyRcDLfiHmWeLb2tmml9dxw==
X-Received: by 2002:a05:600c:1ca5:b0:393:e846:4ea1 with SMTP id k37-20020a05600c1ca500b00393e8464ea1mr8619811wms.32.1650908961628;
        Mon, 25 Apr 2022 10:49:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f14-20020a5d568e000000b00207ae498882sm9111378wrv.32.2022.04.25.10.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:20 -0700 (PDT)
Message-Id: <994864852a020d4de5bbe9914908b84377acaecc.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:11 +0000
Subject: [PATCH 1/7] stash: expand sparse-checkout compatibility testing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add tests verifying expected 'git stash' behavior in
't1092-sparse-checkout-compatibility'. These cases establish the expected
behavior of 'git stash' in a sparse-checkout and verify consistency both
with and without a sparse index. Although no sparse index compatibility has
been integrated into 'git stash' yet, the tests are all 'expect_success' -
we don't want the cone-mode sparse-checkout behavior to change depending on
whether it is using a sparse index or not. Therefore, we expect these tests
to continue passing once sparse index is integrated with 'git stash'.

Additionally, add performance test cases for 'git stash' both with and
without untracked files. Note that, unlike the other tests in
'p2000-sparse-operations.sh', the tests added for 'stash' are combination
operations. This is done to ensure the stash/unstash is not blocked by the
modification of '$SPARSE_CONE/a' performed as part of 'test_perf_on_all'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 49 ++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
index 382716cfca9..76710cbef35 100755
--- a/t/perf/p2000-sparse-operations.sh
+++ b/t/perf/p2000-sparse-operations.sh
@@ -106,6 +106,8 @@ test_perf_on_all () {
 }
 
 test_perf_on_all git status
+test_perf_on_all 'git stash && git stash pop'
+test_perf_on_all 'echo >>new && git stash -u && git stash pop'
 test_perf_on_all git add -A
 test_perf_on_all git add .
 test_perf_on_all git commit -a -m A
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 236ab530284..baf95906729 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1151,6 +1151,55 @@ test_expect_success 'clean' '
 	test_sparse_match test_path_is_dir folder1
 '
 
+test_expect_success 'stash' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Stash a sparse directory (folder1)
+	test_all_match git checkout -b test-branch rename-base &&
+	test_all_match git reset --soft rename-out-to-out &&
+	test_all_match git stash &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Apply the sparse directory stash without reinstating the index
+	test_all_match git stash apply -q &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Reset to state where stash can be applied
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git reset --hard rename-out-to-out &&
+
+	# Apply the sparse directory stash *with* reinstating the index
+	test_all_match git stash apply --index -q &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Reset to state where we will get a conflict applying the stash
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git reset --hard update-folder1 &&
+
+	# Apply the sparse directory stash with conflicts
+	test_all_match test_must_fail git stash apply --index -q &&
+	test_all_match test_must_fail git stash apply -q &&
+	test_all_match git status --porcelain=v2 &&
+
+	# Reset to base branch
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git reset --hard base &&
+
+	# Stash & unstash an untracked file outside of the sparse checkout
+	# definition.
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/new &&
+	test_all_match git stash -u &&
+	test_all_match git status --porcelain=v2 &&
+
+	test_all_match git stash pop -q &&
+	test_all_match git status --porcelain=v2
+'
+
 test_expect_success 'submodule handling' '
 	init_repos &&
 
-- 
gitgitgadget

