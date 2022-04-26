Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B0C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 20:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355112AbiDZUqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355118AbiDZUqg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 16:46:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEE913C2B0
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:27 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id bg25so11543wmb.4
        for <git@vger.kernel.org>; Tue, 26 Apr 2022 13:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=t/VUuHcA6LJhMV7Mx2fkYJRQHiQGtg82S/Ba52cN1qA=;
        b=fp3eu5RzJx0BHRZV4B1TyVmsxfpH3qSxkzNPF80cqdlaUfD2RbHdxijVmfUkJ32vG7
         ZUl56tm/XXeiF7J33mTco2KQLlW7QkFk6qsadiOfrpWpd27nFJw2/bZ6vkJh4GtXBmVR
         XgdkjXm6vp4fbZNnTIEN5Z8KwZUemtwM2EgvKiaxxZtQLAlLn/2kIsJet2/Il7FSb1UD
         0lBuUcapvURDEFQhQt54q/0su+qoBjU7SNBkJkw5YW/kyOaoR2cBUIXx6kdUeXRk6/L3
         v/YLvNZfjdVd0vNBZjH8WHVLiVWBbCRKGb5MfnZLv49zujwkHeoB6BuSENIsGUvOzZC6
         K2hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=t/VUuHcA6LJhMV7Mx2fkYJRQHiQGtg82S/Ba52cN1qA=;
        b=cNUypbeyVA08A7+jjRkj6O9GjDTlZKjglNmsO6YvinarSdUlqJQXsbuIpq1XdNsOSd
         yPbO10DMFcaVl2u5njYDTvd40sH/0ZKZ2TcM/bc0iz9judAg+noegWpTPzEGZhRGvRaR
         MGtQB57LnUQXvNAKMIDO4ms+0r4CYX+PdKvG63L4gdof9IgQR0JdsKJBtyGHy0rBW6ch
         4LcyT4RqwITqnCuS3GIkmk4pffmH+EI98AlyuDt4p6YZWRGWMVFSGeI1XdUgdHmaX+8A
         9B71vUpzSYswtoS2NWlQbfR/0UlO7a1+YiZKGFSYI2nQVmT/O0JYT10QZJN89cn/obv2
         ukqQ==
X-Gm-Message-State: AOAM532KIKkrL8DIWfT19vJGmxrEuWhqxlo3fb6GG7YEeCnJnclU2nxf
        f6ne09wsAitQn7Fle8XquU9398tW4+w=
X-Google-Smtp-Source: ABdhPJzYIwdfjOgy08REixBT3TR6N5yl2Fxa3ENN9uHOK0nhvSAfiUB3u5AjDQbwW2Z9IrhR1q7PBw==
X-Received: by 2002:a7b:cd97:0:b0:38f:f785:ff8 with SMTP id y23-20020a7bcd97000000b0038ff7850ff8mr31590091wmj.44.1651005806106;
        Tue, 26 Apr 2022 13:43:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a0560001a8d00b0020aab7cefc4sm12460288wry.46.2022.04.26.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 13:43:25 -0700 (PDT)
Message-Id: <b730457fccc8b4d98beca70c82400446de4b69c4.1651005800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
References: <pull.1207.git.1649349442.gitgitgadget@gmail.com>
        <pull.1207.v2.git.1651005800.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 26 Apr 2022 20:43:19 +0000
Subject: [PATCH v2 4/5] object-name: diagnose trees in index properly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Philip Oakley <philipoakley@iee.email>,
        Josh Steadmon <steadmon@google.com>,
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
checkout could have the directory not exist, specifically when that
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
 t/t1092-sparse-checkout-compatibility.sh | 18 ++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

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
index 08c9cfd359e..fa1d5603605 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1158,15 +1158,21 @@ test_expect_success 'show (cached blobs/trees)' '
 	test_all_match git show :deep/a &&
 	test_sparse_match git show :folder1/a &&
 
-	# Asking "git show" for directories in the index
-	# had different behavior depending on the existence
-	# of a sparse index.
+	# The error message differs depending on whether
+	# the directory exists in the worktree.
 	test_all_match test_must_fail git show :deep/ &&
 	test_must_fail git -C full-checkout show :folder1/ &&
-	test_must_fail git -C sparse-checkout show :folder1/ &&
+	test_sparse_match test_must_fail git show :folder1/ &&
 
-	test_must_fail git -C sparse-index show :folder1/ 2>err &&
-	grep "is in the index, but not at stage 0" err
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

