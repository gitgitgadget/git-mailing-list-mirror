Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 585C2C433FE
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiDGQjf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbiDGQja (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:39:30 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF79617E340
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:37:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w4so8633712wrg.12
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 09:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/C88YZUqkIZYHLcMzWANK+XL38MQDB2HjuEiQi7yNZ8=;
        b=Y+w7VApTLTFE//+qZf87SMvxlsToOYHwfdKFwu7o7LrNy+x0KKNlecFkAHJ7/krBpu
         8MQO9ljP6Guzf/GYmN5094aabGu73AvCgCTxxzk55yYHLECvuFQ8nFgPGc535LtTYm9y
         43N/WXLCp2Z4+fPSJCLnAi4mPJfqD92KokvOAgkzeJmCCJLX3YgIxUF70I2WHuTSm6xH
         NLl16/wovHKcYK+vynfDhW6KXrR2fOMBlIzThJ/QW9toTfCj7Xc1u55t6ru4ncy6eOQ/
         /ZR/KeLgUnMqzEL6NJT1W3X6QlODZygVIMH03cci8F4i/Ec2G71a7jeLmeC2Ys4mmZPo
         6sSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/C88YZUqkIZYHLcMzWANK+XL38MQDB2HjuEiQi7yNZ8=;
        b=1vHdUUwcINOyLyO2UhFtYDc1Bo2uRCO4HZohRas1fzw3GLRa/NMfgwcdy7PaZhHLfx
         o53iTfgjvnaOh+RNOUBm5/6O+jGTC3Mqdq5IWVirm7WAribJOVY8Ac2Pf4NrnGTXbikv
         yyOnuzdR1L0cneDWwFQ96A4/ncsirZpxEaFy6tJPVOHB2n9vhLU3MudloNNGrvCLPt6A
         R2obDHjSiYq8NN/maZJe5ja8+6ZWkEXUTeyW1SwZy0StJLTOAJzxdHZPpxWFRKX38Ghb
         vGDnN/Q6lxwcScVg4PHFMWuj7ZG3lsllx4TQ9qxLymdPTYgqSkWP7+9HGhYdNrMi3U4A
         Sj2A==
X-Gm-Message-State: AOAM530L/2IuMYDsfI1aj9XtHxHF2KQR3t/ITq4y6zyYpF61X7Qlb6R/
        QeduxyVHw2RtbZW5bAwigWjGsS9yxLU=
X-Google-Smtp-Source: ABdhPJyCcMjXg6nQuD+3mPw3BsVOY0khgonct2sUy6RpsOKGj3ZI9/7psGi5BPJUqIEFb5Qv9BsGTQ==
X-Received: by 2002:adf:f58e:0:b0:206:162b:7b85 with SMTP id f14-20020adff58e000000b00206162b7b85mr11668534wro.261.1649349447942;
        Thu, 07 Apr 2022 09:37:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm17394281wri.106.2022.04.07.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 09:37:27 -0700 (PDT)
Message-Id: <99c09ccc2406e4f54c620bd7fb2d1205386e23a6.1649349442.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Apr 2022 16:37:22 +0000
Subject: [PATCH 4/4] object-name: diagnose trees in index properly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When running 'git show :<path>' where '<path>' is a directory, then
there is a subtle difference between a full checkout and a sparse
checkout. The error message from diagnose_invalid_index_path() reports
whether the path is on disk or not. The full checkout will have the
directory on disk, but the path will not be in the index. The sparse
checokut could have the directory not exist, specifically when that
directory is outside of the sparse-checkout cone.

In the case of a sparse index, we have yet another state: the path can
be a sparse directory in the index. In this case, the error message from
diagnose_invalid_index_path() would erroneously say "path '<path>' is in
the index, but not at stage 0", which is false.

Add special casing around sparse directory entries so we get to the
correct error message. This requires two checks in order to get parity
with the normal sparse-checkout case.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 object-name.c                            |  6 ++++--
 t/t1092-sparse-checkout-compatibility.sh | 13 +++++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index 2dc5d2549b8..4d2746574cd 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1832,7 +1832,8 @@ static void diagnose_invalid_index_path(struct repository *r,
 		pos = -pos - 1;
 	if (pos < istate->cache_nr) {
 		ce = istate->cache[pos];
-		if (ce_namelen(ce) == namelen &&
+		if (!S_ISSPARSEDIR(ce->ce_mode) &&
+		    ce_namelen(ce) == namelen &&
 		    !memcmp(ce->name, filename, namelen))
 			die(_("path '%s' is in the index, but not at stage %d\n"
 			    "hint: Did you mean ':%d:%s'?"),
@@ -1848,7 +1849,8 @@ static void diagnose_invalid_index_path(struct repository *r,
 		pos = -pos - 1;
 	if (pos < istate->cache_nr) {
 		ce = istate->cache[pos];
-		if (ce_namelen(ce) == fullname.len &&
+		if (!S_ISSPARSEDIR(ce->ce_mode) &&
+		    ce_namelen(ce) == fullname.len &&
 		    !memcmp(ce->name, fullname.buf, fullname.len))
 			die(_("path '%s' is in the index, but not '%s'\n"
 			    "hint: Did you mean ':%d:%s' aka ':%d:./%s'?"),
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 9d32361110d..921cafb950a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1164,8 +1164,17 @@ test_expect_success 'show (cached blobs/trees)' '
 	test_must_fail git -C full-checkout show :folder1/ &&
 	test_must_fail git -C sparse-checkout show :folder1/ &&
 
-	test_must_fail git -C sparse-index show :folder1/ 2>err &&
-	grep "is in the index, but not at stage 0" err
+	test_sparse_match test_must_fail git show :folder1/ &&
+
+	# Change the sparse cone for an extra case:
+	run_on_sparse git sparse-checkout set deep/deeper1 &&
+
+	# deep/deeper2 is a sparse directory in the sparse index.
+	test_sparse_match test_must_fail git show :deep/deeper2/ &&
+
+	# deep/deeper2/deepest is not in the sparse index, but
+	# will trigger an index expansion.
+	test_sparse_match test_must_fail git show :deep/deeper2/deepest/
 '
 
 test_expect_success 'submodule handling' '
-- 
gitgitgadget
