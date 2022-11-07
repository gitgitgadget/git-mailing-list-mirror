Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3882AC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 18:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiKGSht (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 13:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiKGShG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 13:37:06 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E544286F7
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 10:36:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id g12so17518054wrs.10
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 10:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyDhYllrkxRfsgW7soBJoMJVOrtdrnjGA3pcE7VQQbs=;
        b=Zx3ZmsUmnvhfTQDQwNrda7dhgp+9KoCEFPkOCNuXCsS92ScYBAkqPgwzMkpobBKSNH
         SGfN9B7iTyjSUdtg80K28lggbLwy8AgK3/rxW0FTKHOu6SHRQSnDCrPuhShWIkQBJSiU
         fgnRU6HcxjmKhmfwigBc6l855hjdcKXXRAk2eouQ5QwnBf/A+2xcbh+4CO3eEEM4lNI8
         H4JOmKOilgh81eABqVFS3mRafk44AprHh4ndghbDWxDTaFpNZHqoaomMglOKF9hytcsq
         sdZX6VLa9QqFYlwBG6fOuzOiMtSBwhpiDXWQuxapUk70cD4xJPITNP51/LaZdTifXbE2
         Am6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FyDhYllrkxRfsgW7soBJoMJVOrtdrnjGA3pcE7VQQbs=;
        b=bnbA6IDPEwH+UzzQ2CJHPgQA2+lC1CaeD/OKGPLx+8QsJCce7VXEmk7vSQubzmrbbK
         /JuUvCabTwSLO2q+2ZMMPgESCLI/ptpMj4iwxlXsUDNTiJ1xdIVPpfazdpEJe1Xh/oAF
         TknVx72K4P7LFCF2tDaBdfMsKS3koJMYj8cQh0hztcp0Cn8Mvh/2Fy3Fy5IfvWVTvOs/
         3fUgpIx1JvCTq6y8Hy+xTfmWG1K7dOt1KJQ5EGOY4vMgcd2Gw7igSm5WQk/OQSadnCdV
         8vCDr+SlJBe3K/EFhcOquJBXs/bUQ7OsCj4e34e4SRFy9UiqSE33CbQ0GVRl0XwBZd6S
         rDcA==
X-Gm-Message-State: ACrzQf04kitL5z6rRIKrUqtlxaU8vVUo4298akEokoLk2NgVtl9qkdqi
        rwckQEt82f8NLCpKP9uiBH7z+YOWsvg=
X-Google-Smtp-Source: AMsMyM6zU9urN5s5bFZfdYYB0OhpgmrS2o6IJkPGUGfPPt5ztxT01JdUwR5rZ8rnPit0r7NmRq9mVQ==
X-Received: by 2002:a5d:4b51:0:b0:236:88a2:267f with SMTP id w17-20020a5d4b51000000b0023688a2267fmr31535988wrs.461.1667846189390;
        Mon, 07 Nov 2022 10:36:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b003b49ab8ff53sm9590365wmq.8.2022.11.07.10.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 10:36:29 -0800 (PST)
Message-Id: <188a55ddcb876aab4e5476234da5412ace053b7b.1667846165.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Nov 2022 18:35:57 +0000
Subject: [PATCH 23/30] t1409: test with packed-refs v2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

t1409-avoid-packing-refs.sh seeks to test that the packed-refs file is
not modified unnecessarily. One way it does this is by creating a
packed-refs file, then munging its contents and verifying that the
munged data remains after other commands.

For packed-refs v1, it suffices to add a line that is similar to a
comment. For packed-refs v2, we cannot even add to the file without
messing up the trailing table of contents of its chunked format.
However, we can manipulate the last bytes that are within the trailing
hash and use 'tail -c 4' to read them.

This makes t1409 pass with GIT_TEST_PACKED_REFS_VERSION=2.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 t/t1409-avoid-packing-refs.sh | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index be12fb63506..dc8d58432c8 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -8,13 +8,29 @@ test_description='avoid rewriting packed-refs unnecessarily'
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
 mark_packed_refs () {
-	sed -e "s/^\(#.*\)/\1 t1409 /" .git/packed-refs >.git/packed-refs.new &&
-	mv .git/packed-refs.new .git/packed-refs
+	if test "$GIT_TEST_PACKED_REFS_VERSION" = "2"
+	then
+		size=$(wc -c < .git/packed-refs) &&
+		pos=$(expr $size - 4) &&
+		printf "FAKE" | dd of=".git/packed-refs" bs=1 seek="$pos" conv=notrunc
+	else
+		sed -e "s/^\(#.*\)/\1 t1409 /" .git/packed-refs >.git/packed-refs.new &&
+		mv .git/packed-refs.new .git/packed-refs
+	fi
 }
 
 # Verify that the packed-refs file is still marked.
 check_packed_refs_marked () {
-	grep -q '^#.* t1409 ' .git/packed-refs
+	if test "$GIT_TEST_PACKED_REFS_VERSION" = "2"
+	then
+		size=$(wc -c < .git/packed-refs) &&
+		pos=$(expr $size - 4) &&
+		tail -c 4 .git/packed-refs >actual &&
+		printf "FAKE" >expect &&
+		test_cmp expect actual
+	else
+		grep -q '^#.* t1409 ' .git/packed-refs
+	fi
 }
 
 test_expect_success 'setup' '
-- 
gitgitgadget

