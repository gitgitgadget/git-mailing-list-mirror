Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9403CC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 09:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354964AbiCPJrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 05:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354959AbiCPJr1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 05:47:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5876548B
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 02:46:12 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j17so2180637wrc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 02:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C4ha13NdA8AAfRlxrv/Rcs26ujOjxqGHmrkqZGYUC4A=;
        b=ItobP0VWHfiXIZ38HD/14Ui5aV1+lDrhBozmOQaaYL8IfqfOfU49jcmC1eOtRkYQGZ
         ikljzFbhpcuXmJrzOkrAPb2mhBE0N2lqLNfCA822TC9qZGtKmCBj19LCuGLIsSlyMgvt
         hrn7PCpk17DAzs78FxsSzirgzUcO2HBK6hgUTNiwdvIoCiW8OUljn4FDe4u5lMRnvwLD
         8rzDxY8yivtIk7I8koMNQR7NQi1WsQnNaF+woXDgYxLvvmeDNkQyHrKtuhJ24fIvo4ij
         HQFYWES3Au0Exm6sApZ7OCS8uZ472/LI68rNwzO10TPYW4vr/qdYKCat3Atcr9RyDx8G
         j6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C4ha13NdA8AAfRlxrv/Rcs26ujOjxqGHmrkqZGYUC4A=;
        b=N+a01+oV0zNgMCq7Z36jfL+A97SuvRWE6PTdJ18ZfpKDCQTZOPHsQuBAOrA5TwNPcJ
         0EcrPC+LxXFdvutSa+/ODjZzpcrnKveQd7e+a/ZACQ5up+v7sEJCV4nXeSDh02EexsTS
         dpymUuxvCw2oRiMYJ+O4ggJwq8+cKaJOB8BmBWwJaToIr4NEa+UJ8ht42Kkkj4UOUCm+
         VXKJg/Jm3sy7IoSEIoY54B6Z/n/zhj1RWiJtn6F5s3Ca8rATvDiFUXb8TgfzlXJju59R
         tMHXXTP75w392+koOLxj6ZshPCrmC4nBWcf6iMspT5fz3FvDXeNsj7F5WfFHzS5Nl4Ds
         B1Lw==
X-Gm-Message-State: AOAM533PEMslStG3K6kzTVZsLCfAAKmPPJNPmaGVFSvK16VQx3ADqUcO
        gJvvUeM5HXVqGO1YKB1rGztlef93paA=
X-Google-Smtp-Source: ABdhPJxVxOnnWtYTQVhy9G0MZ0AgAGMUlrO1MgbzSERnSHDIYAyabaZJvnJovNeWmZa6xBCrEN3sdA==
X-Received: by 2002:a5d:5846:0:b0:203:6b34:37af with SMTP id i6-20020a5d5846000000b002036b3437afmr24680943wrf.58.1647423970525;
        Wed, 16 Mar 2022 02:46:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f2-20020a056000128200b001f1f39d05b0sm1183690wrx.100.2022.03.16.02.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 02:46:10 -0700 (PDT)
Message-Id: <pull.1175.v2.git.1647423969576.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
References: <pull.1175.git.1647193162570.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Mar 2022 09:46:09 +0000
Subject: [PATCH v2] partial-clone: add a partial-clone test case
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

In a blobless-cloned repo, `git log --follow -- <path>` (`<path>` have
an exact OID rename) shouldn't download blob of the file from where the
new file is renamed.

Add a test case to verify it.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
    partial-clone: add a partial-clone test case
    
    changes since v1:
    
     1. remove the event track method to detect the downloading as it is not
        future proof ( and buggy).
     2. Instead see if the file is missing initially and after running the
        git log --follow ... command.
    
    Fixes #827 [1]
    
    [1] https://github.com/gitgitgadget/git/issues/827

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1175%2FAbhra303%2Fcheck_partial_clone-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1175/Abhra303/check_partial_clone-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1175

Range-diff vs v1:

 1:  6b80b981977 ! 1:  52df433ad5e partial-clone: add a partial-clone test case
     @@ Commit message
          partial-clone: add a partial-clone test case
      
          In a blobless-cloned repo, `git log --follow -- <path>` (`<path>` have
     -    an exact OID rename) doesn't download blob of the file from where the
     +    an exact OID rename) shouldn't download blob of the file from where the
          new file is renamed.
      
          Add a test case to verify it.
     @@ t/t0410-partial-clone.sh: test_expect_success 'do not fetch when checking existe
       	git -C repo cherry-pick side1
       '
       
     -+test_expect_success 'git log --follow does not download blobs if an exact OID rename found (blobless clone)' '
     ++test_expect_success 'exact rename does not need to fetch the blob lazily' '
      +	rm -rf repo partial.git &&
      +	test_create_repo repo &&
      +	content="some dummy content" &&
      +	test_commit -C repo create-a-file file.txt "$content" &&
      +	git -C repo mv file.txt new-file.txt &&
      +	git -C repo commit -m rename-the-file &&
     ++	FILE_HASH=$(git -C repo rev-parse HEAD:new-file.txt) &&
      +	test_config -C repo uploadpack.allowfilter 1 &&
      +	test_config -C repo uploadpack.allowanysha1inwant 1 &&
      +
     -+	git clone --filter=blob:none "file://$(pwd)/repo" partial.git &&
     -+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
     -+		git -C partial.git log --follow -- new-file.txt > "$(pwd)/trace.txt" &&
     -+	! test_subcommand_inexact fetch <trace.txt
     ++	git clone --filter=blob:none --bare "file://$(pwd)/repo" partial.git &&
     ++	git -C partial.git rev-list --objects --missing=print HEAD >out &&
     ++	grep "[?]$FILE_HASH" out &&
     ++	git -C partial.git log --follow -- new-file.txt &&
     ++	git -C partial.git rev-list --objects --missing=print HEAD >out &&
     ++	grep "[?]$FILE_HASH" out
      +'
      +
       test_expect_success 'lazy-fetch when accessing object not in the_repository' '
       	rm -rf full partial.git &&
       	test_create_repo full &&
     -
     - ## t/test-lib-functions.sh ##
     -@@ t/test-lib-functions.sh: test_subcommand_inexact () {
     - 		shift
     - 	fi
     - 
     --	local expr=$(printf '"%s".*' "$@")
     -+	local expr=$(printf '.*"%s".*' "$@")
     - 	expr="${expr%,}"
     - 
     - 	if test -n "$negate"


 t/t0410-partial-clone.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index f17abd298c8..1e864cf3172 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -618,6 +618,25 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
 	git -C repo cherry-pick side1
 '
 
+test_expect_success 'exact rename does not need to fetch the blob lazily' '
+	rm -rf repo partial.git &&
+	test_create_repo repo &&
+	content="some dummy content" &&
+	test_commit -C repo create-a-file file.txt "$content" &&
+	git -C repo mv file.txt new-file.txt &&
+	git -C repo commit -m rename-the-file &&
+	FILE_HASH=$(git -C repo rev-parse HEAD:new-file.txt) &&
+	test_config -C repo uploadpack.allowfilter 1 &&
+	test_config -C repo uploadpack.allowanysha1inwant 1 &&
+
+	git clone --filter=blob:none --bare "file://$(pwd)/repo" partial.git &&
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	grep "[?]$FILE_HASH" out &&
+	git -C partial.git log --follow -- new-file.txt &&
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	grep "[?]$FILE_HASH" out
+'
+
 test_expect_success 'lazy-fetch when accessing object not in the_repository' '
 	rm -rf full partial.git &&
 	test_create_repo full &&

base-commit: 1a4874565fa3b6668042216189551b98b4dc0b1b
-- 
gitgitgadget
