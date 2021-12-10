Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF80C433FE
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 15:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242696AbhLJPQz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 10:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242644AbhLJPQy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 10:16:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D76C0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id c4so15420876wrd.9
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 07:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z1lsY1IELUoUSjAMa97erruqhiY9BJgxhgMt/g/gEqo=;
        b=i82NCnCctIu2HuTb5DtM4V1n4y3N57wfiEcj5fpX2oSTzm/gbFO01QhwLJU452Fpdi
         4hiBxSnVwjzo0CszCwsJIpg5gEBb1QCkXF0JEnyfUVxLEdH0+/mWGbf7IhTMooMOihEi
         FCcDtkJrZL3q5DF+s06i7RsXitAyY6KfS8PJh/+YIV9CZGOStUwsyJyKmdNmFt/IfxuV
         gl428bLF4FgW6beEXpeYE75Y+4XocSdd6PCgOXtHxx5UcDJxSSornr33mWnPQq/Gpe9K
         75HwO7HMd4MgJnizk8ZlCEFNhqFAObKoW0BdLvLhdXIThTs19siZa9LlMWLWyIfOSPt+
         wtzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z1lsY1IELUoUSjAMa97erruqhiY9BJgxhgMt/g/gEqo=;
        b=pS4SDIavx2r/+ZX0k1gyM+r2v4+rACQQu0myJ7jQr30Z0V9pyVhKmRE2ZjWxka4tg1
         4RpzObjlusOYjQibHaCIW8FiaHpNTC3AEtiVEyvNJqELozPNpQwgOr1P89Zs4RYqq8Yt
         aBjmANFjmZk2NDv+/rrhZAD0r+GeAyjrwUKaTo4m1snTv4fMpUt7ztvWrtXxfk6nSSnJ
         Khyzh949NCYsZz09KEDcT8X60TCurR2NHJE2KIGk/MShE/xuvIacX/QxXVeT75th1E8m
         1GA4XfqWrlhOOFF6tAbudZmYfmj5gRTpv7IhgRr5Cf9oudntvbozs6qAjnMhKag7+4Nm
         E8bw==
X-Gm-Message-State: AOAM532zN8cXq9tHx/GYgS0mVjlWAg0uTSnYZaPmdq7qG9A1neb8HuQm
        1V9PnQKXZNsRTJnUo28d3szpxY9du/E=
X-Google-Smtp-Source: ABdhPJyDz62EeQCNvU1XxpMo1S7eAoQ9kbQopnDT/oDSNG3D67+wbYF1Z4tbHbyn9CGME41K9jLHSQ==
X-Received: by 2002:adf:f001:: with SMTP id j1mr14539018wro.351.1639149197792;
        Fri, 10 Dec 2021 07:13:17 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2sm11801525wmi.36.2021.12.10.07.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:13:17 -0800 (PST)
Message-Id: <f014368675495812dd45291a36902cecdfa00c63.1639149192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
References: <pull.1080.v2.git.1638992395.gitgitgadget@gmail.com>
        <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Dec 2021 15:13:11 +0000
Subject: [PATCH v3 4/5] t1091/t3705: remove 'test-tool read-cache --table'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that 'git ls-files --sparse' exists, we can use it to verify the
state of a sparse index instead of 'test-tool read-cache table'. Replace
these usages within t1091-sparse-checkout-builtin.sh and
t3705-add-sparse-checkout.sh.

The important changes are due to the different output format. In t3705,
we need to use the '--stage' output to get a file mode and OID, but
it also includes a stage value and drops the object type. This leads
to some differences in how we handle looking for specific entries.

In t1091, the test focuses on enabling the sparse index, so we do not
need the --stage flag to demonstrate how the index changes, and instead
can use a diff.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 25 ++++++++++++++++++++-----
 t/t3705-add-sparse-checkout.sh     |  8 ++++----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..680e0043c36 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -212,12 +212,27 @@ test_expect_success 'sparse-index enabled and disabled' '
 
 		git -C repo sparse-checkout init --cone --sparse-index &&
 		test_cmp_config -C repo true index.sparse &&
-		test-tool -C repo read-cache --table >cache &&
-		grep " tree " cache &&
-
+		git -C repo ls-files --sparse >sparse &&
 		git -C repo sparse-checkout disable &&
-		test-tool -C repo read-cache --table >cache &&
-		! grep " tree " cache &&
+		git -C repo ls-files --sparse >full &&
+
+		cat >expect <<-\EOF &&
+		@@ -1,4 +1,7 @@
+		 a
+		-deep/
+		-folder1/
+		-folder2/
+		+deep/a
+		+deep/deeper1/a
+		+deep/deeper1/deepest/a
+		+deep/deeper2/a
+		+folder1/a
+		+folder2/a
+		EOF
+
+		diff -u sparse full | tail -n +3 >actual &&
+		test_cmp expect actual &&
+
 		git -C repo config --list >config &&
 		! grep index.sparse config
 	)
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index f3143c92908..81f3384eeed 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -181,13 +181,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
-	test-tool read-cache --table >actual &&
-	grep "^100644 blob.*sparse_entry\$" actual &&
+	git ls-files --stage >actual &&
+	grep "^100644 .*sparse_entry\$" actual &&
 
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
-	test-tool read-cache --table >actual &&
-	grep "^100755 blob.*sparse_entry\$" actual &&
+	git ls-files --stage >actual &&
+	grep "^100755 .*sparse_entry\$" actual &&
 
 	git reset &&
 
-- 
gitgitgadget

