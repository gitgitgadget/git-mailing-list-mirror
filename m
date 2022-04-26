Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027FBC433F5
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355117AbiDZUqg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350152AbiDZUqd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749813A4C6
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:24 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id w4so27021603wrg.12
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OcKuP5szKC9QdBAWkLw/2yWtY9M4uWGL+c5sLoq0NEA=;
        b=eKhNkyMhgRnfUGNoBVKfSsj+CNHjdsl8iQZxz5mS1aZ1TxEUcWGl8S3eELp0OkGtbq
         be8m0bUe34lgyg9kcc2TZXf75MYDLzOPfOebjpLk9RiTiqs3bH51Wdo++XelM6qSSWdy
         oq3V3oHvNXfMs7o5qayITzC28rOSI3sKvSLi5p6VfofVVdg0n0V88AL4FCz0kNvKu3su
         C+5154NEDmr7tLHHcMnGdFxr3481ttr3CI4zHULacUu/g17KbsBiNDxILBfDDLjsztdr
         RRcFBi3+gOJ02Arqd2q54LXX1ygCTeXvjnb5LQ+xs68r+/l/tVZkfsTCe+MdNQdRMXZz
         zjjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OcKuP5szKC9QdBAWkLw/2yWtY9M4uWGL+c5sLoq0NEA=;
        b=sp0Jcxwm7OC7AgzNitCeslIagg68Bfiy31CW2SXfYnPoeoCQaEKz7TG69TwFyc4vQt
         k5Iq10nM6Mb1A0SZkgzWa7UJp2l0pSGQyS5fP102L116E0hBUF7tAk4eJpnuqa/whI07
         dsh6Y5+zTNe7+LsfaLQvfpQjcoPbWFjfoV7cY1S0XKq8oRpki/yH9u3Oc9WF2faVJbbL
         oSVFaftLzuOwli9neeZ3rY/7v9uJJCwQ1PtqNYv3xR6ZoukEdieJ0LzSn1kEytjXSML4
         5kqidMqUzRpEmNGdxyHbQBQiWzeHs0bY6OLWJSJ6hCHZKpBDHqs42eWa1MOpzXajky2t
         rvGA==
X-Gm-Message-State: AOAM533QKEYXfJKtiDum3veEsFTLuFDRaKrvCQkmwsAPl4F88NTMK+KK
        irIMacw1k0U2kkN8eGbBhROlN4r2so4=
X-Google-Smtp-Source: ABdhPJyP8CzccI/VI71TjIvzslkuc5AEbWBW07eKRESvDYCZ8vLoSBMu3Sj6uf3MdDC5gAyEmAY02w==
X-Received: by 2002:a05:6000:3cc:b0:20a:df53:9a0e with SMTP id b12-20020a05600003cc00b0020adf539a0emr7535894wrg.264.1651005803043;
        Tue, 26 Apr 2022 13:43:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6-20020adfca06000000b0020ae96f6ba8sm1510729wrh.65.2022.04.26.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:43:22 -0700 (PDT)
Message-Id: <8c2fdb5a4fc3317c05324da54692036e36fc15f3.1651005800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 20:43:16 +0000
Subject: [PATCH v2 1/5] t1092: add compatibility tests for 'git show'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 236ab530284..74792b5ebbc 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1151,6 +1151,22 @@ test_expect_success 'clean' '
 	test_sparse_match test_path_is_dir folder1
 '
 
+test_expect_success 'show (cached blobs/trees)' '
+	init_repos &&
+
+	test_all_match git show :a &&
+	test_all_match git show :deep/a &&
+	test_sparse_match git show :folder1/a &&
+
+	# Asking "git show" for directories in the index
+	# does not work as implemented. The error message is
+	# different for a full checkout and a sparse checkout
+	# when the directory is outside of the cone.
+	test_all_match test_must_fail git show :deep/ &&
+	test_must_fail git -C full-checkout show :folder1/ &&
+	test_sparse_match test_must_fail git show :folder1/
+'
+
 test_expect_success 'submodule handling' '
 	init_repos &&
 
-- 
gitgitgadget

