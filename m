Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0678C433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 18:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244634AbiD0STi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbiD0STf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 14:19:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE0DDFE2
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:23 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b19so3610376wrh.11
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 11:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=igvrIJQoQ0c+Op40m9NQxfZ07jOrWXFTaW9zMmhrCSA=;
        b=Zgk8rmYueSleFdy5GZyS/WNr7fLgUUilmE5c3BQl6AwkL6LwNsZ9y4ynwZGU3EZ1U8
         p8eBKDYKR6adaonmHydzngGZKKKuosBSOUdBop8qgVnW1HGHZ+VDp0tD/0Zl3iFg417U
         XeFO8QSCcTocossYjtsAesI5d5NJiNdy2zp8ZlAMFBEJlYgwHg3xabwH+W2gdHfwrlSU
         83XkHd3I61N6+kKxWmtWZaLC2bGNWotQ2QoIqHUCia0hovmERmKL0UOtNWMRFEsY+PA/
         i2XK3p9ei8fn9DeiLCnamm76+jXmBoRGYDxNji1bN5iOw0TP9Mli4VwTnBgVmiweP80P
         g7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=igvrIJQoQ0c+Op40m9NQxfZ07jOrWXFTaW9zMmhrCSA=;
        b=c+kWffUc1kDTRBJnk6HgyAIDdLqQHZ4RSpdoOEs1tuFHGe7Trys+qBj1hhqomBJg8T
         NzOXRI54wSq4djnYc9PbZkhYp7l5N9u2cNF9Rr+X3U6XKrkQRTBoIrd71F2aWgU/si8N
         mFDx/7opKGBB9wgkGgDwg95wv7Feb+EWjmV9CwiOlBawgWbeZKSQ256JgnVvpJsv2U8F
         +XvbPg8L5QgYlHdBLAFqeDmFWQTl6yu419ThoJDldNr77b6dh5cTDCcV3IDAZwU3gi/k
         oBl1dWjiep1jN3UmGzS8LfpKKgekSWSA/KZuOADOmiM62ilU9AXJ3uatXjWav3mcKUMB
         D+EA==
X-Gm-Message-State: AOAM533ogXt8a5YCPLZdqLILuf3YRj9v+e5WXKTZALTXjOgVOOBEn/5P
        2bxZKSOftP9IkDGnrHMLMyvqKWusrK0=
X-Google-Smtp-Source: ABdhPJzEy6A9UsMQeXpLsdPMXF61JIU/R/ftN5R6u0zvGXCIP0FqLOVK5IFCsLxuOY3A/fhyldGCvA==
X-Received: by 2002:adf:f943:0:b0:203:b456:c71d with SMTP id q3-20020adff943000000b00203b456c71dmr23170151wrr.568.1651083381795;
        Wed, 27 Apr 2022 11:16:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020aa79d55b5sm17064823wrb.35.2022.04.27.11.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:16:21 -0700 (PDT)
Message-Id: <8ea986cb249448f59078e2410e9c9daf13b6c714.1651083378.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
        <pull.1171.v2.git.1651083378.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Apr 2022 18:16:12 +0000
Subject: [PATCH v2 1/7] stash: expand sparse-checkout compatibility testing
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
index 236ab530284..86312b30444 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1034,6 +1034,55 @@ test_expect_success 'cherry-pick with conflicts' '
 	test_all_match test_must_fail git cherry-pick to-cherry-pick
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
 test_expect_success 'checkout-index inside sparse definition' '
 	init_repos &&
 
-- 
gitgitgadget

