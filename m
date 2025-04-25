Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A301821ABB7
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 19:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745609286; cv=none; b=vFRpZ2CQFgjNH4Eyxgf0QOlpwJs4UgJP5CcVIfyAUEvBvDx17P0Z2HwEV8rAkf1ZHOtrMEG66peMDv2UvBHERZRRs4fdJLtpeuUhVTK2bq9n+2wNdhqdKom/BWx5Gdiaju11GcRLaKsxUj62MUmSO9bUQZZBv1AwzpwHSGw3O7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745609286; c=relaxed/simple;
	bh=9lcg/d5nCCOF4wkrCPUlPqpifvpDO3ai1eSYN0GgzRI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hNt6iYffowRwt4cbVjHKFc6jFjmcerOwHdb3iLLeYaPpCglyR+H6FfR1m+Ec7+hqyHwkCpETaMevHqkYQrqeuVxUJSyC2aY2WLwcK9eDzT4hcO67dH494YAEjFxI1U7A5AHvDXFFoWfviuhx76NN8I/dhLvrsrpbMlbEJaEX1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eMaT+uZi; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMaT+uZi"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso18835775e9.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 12:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745609281; x=1746214081; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6iSdZ9D20c1adTSq3zmU96mXsyXtnaKEsJ8gom0bX8Q=;
        b=eMaT+uZi8H+CvbHDSdPeUiHLPmJf8qfcEAWTZkGE6Fcub6rEGT+SI704+iSYvU4L8P
         zPiWPPYtSXBpM7Z0mMLDs5kPKeS7g/AXL0PHnCij7DYlac7ODTpB8O4n+ZTbOR0a8Ozs
         0ZqzOurRvLAUUuSl+edbjiHA3pIioVCqcUlpc7TpfmuMfxNOMudTW3ghG8Tsg20SJk30
         MNfaKdcFJB07fbiEyeptykdmMKof8RyPDtJttOZsUnQ4ocZoti0kjiutDjvu+jm30A6/
         TKkxqIayCbTDj2hK8mlB4hBaGgHVr7vFUAsVklEXzvhX3XLMxOChPmTvFM9zYvB9EW0x
         VhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745609281; x=1746214081;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iSdZ9D20c1adTSq3zmU96mXsyXtnaKEsJ8gom0bX8Q=;
        b=J7NQD2o1FJKfhy3Xv2wKMLd6AvjrLJQZ+gJPJAX8oX65CtPQPbo/9c1HkKPDIfdMWe
         X9d/SPHqXNRKL32Ttoe4n3EL9o96ar6LDO8PBxxkHEKEpHhvKzYUhV18NWSEt8u7SIQr
         sqyQGUHj5Uq6vvN706JQ9Qzs6IuyojwGz4MrM1Dq/DcM091jBeTqogZwPNQKU2ARyQsc
         aw5pHe0eG87zpzZEn35mAGIsBoEciSzLynIaNSGTj+ysWE7kFrCbnzDDr9EN/f2bksvd
         ITnd6l/SnAVVQuKTp8CyDypXH6J2ZHa0D727u/ug4YdLYDS/f+Xfurt+2NrZwh5Malot
         CZ4g==
X-Gm-Message-State: AOJu0YwsNoTaZ6/UVR6xhLKIWlSG4vO7m+FL3lpN/d1tkDBMjgZKAVZY
	c93tRekt5XktBmZtII9n0aoSOSWmFob62f42MA+Ua8SfVhe5JNJHcRhPiA==
X-Gm-Gg: ASbGnctHV/zHEhtff1OfPHeIDyDLNVXzN3kdz47o0p0Pfk6Xa5tuSr9TUXN4P1xFApV
	LCAk5bWXpviqIsRIZ36I2jRoj94tOF2a/xl93JIL+ZIH9s/UqojPABtW8lHri6AcbOjyakF6baH
	g83vy0AP3ynlG51nQ1GmCp1/nShfmbUq2xXsLIXe6B0MdhgUuFUMoY3kbBO7QiW3Qrh/MNQu+B6
	CR0FncD4KenE/byoowCcMsdilq+HtppVGznj9J5pS1h2M05xidVs4NORJSA64HpYESUHR0bPLST
	0iApMwcfvFNj+lVPLmKp4SowVCLN6NWKDhKAj0DbMw==
X-Google-Smtp-Source: AGHT+IE4lBd9IRkjeilgCxQfP8ncW8vSOIXSSNZaOI3IQdQ4Z+eRuTjGnvckBbVxSiwr2JXdE28uQw==
X-Received: by 2002:a05:600c:8414:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-440ab7b7073mr5021675e9.8.1745609280906;
        Fri, 25 Apr 2025 12:28:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8d1a5sm3271466f8f.13.2025.04.25.12.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 12:28:00 -0700 (PDT)
Message-Id: <d6ec5c87b433e0b0a5d1e799fe7ac937a61b7d4c.1745609278.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
References: <pull.1897.v5.git.git.1745607965.gitgitgadget@gmail.com>
	<pull.1897.v6.git.git.1745609278.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 19:27:57 +0000
Subject: [PATCH v6 1/2] bundle-uri: copy all bundle references ino the
 refs/bundle space
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Toon Claes <toon@iotcl.com>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

When downloading bundles via the bundle-uri functionality, we only copy the
references from refs/heads into the refs/bundle space. I'm not sure why this
refspec is hardcoded to be so limited, but it makes the ref negotiation on
the subsequent fetch suboptimal, since it won't use objects that are
referenced outside of the current heads of the bundled repository.

This change to copy everything in refs/ in the bundle to refs/bundles/
significantly helps the subsequent fetch, since nearly all the references
are now included in the negotiation.

The update to the bundle-uri unbundling refspec puts all the heads from a
bundle file into refs/bundle/heads instead of directly into refs/bundle/ so
the tests also need to be updated to look in the new heirarchy.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
 Documentation/technical/bundle-uri.adoc |  14 +-
 bundle-uri.c                            |   2 +-
 t/t5558-clone-bundle-uri.sh             | 172 ++++++++++++------------
 3 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/Documentation/technical/bundle-uri.adoc b/Documentation/technical/bundle-uri.adoc
index 91d3a13e327..f2551e71177 100644
--- a/Documentation/technical/bundle-uri.adoc
+++ b/Documentation/technical/bundle-uri.adoc
@@ -232,13 +232,13 @@ will interact with bundle URIs according to the following flow:
    are present in the client repository. If some are missing, then the
    client delays unbundling until other bundles have been unbundled,
    making those OIDs present. When all required OIDs are present, the
-   client unbundles that data using a refspec. The default refspec is
-   `+refs/heads/*:refs/bundles/*`, but this can be configured. These refs
-   are stored so that later `git fetch` negotiations can communicate each
-   bundled ref as a `have`, reducing the size of the fetch over the Git
-   protocol. To allow pruning refs from this ref namespace, Git may
-   introduce a numbered namespace (such as `refs/bundles/<i>/*`) such that
-   stale bundle refs can be deleted.
+   client unbundles that data using a refspec. The refspec used is
+   `+refs/*:refs/bundles/*`. These refs are stored so that later 
+   `git fetch` negotiations can communicate each bundled ref as a `have`,
+   reducing the size of the fetch over the Git protocol. To allow pruning
+   refs from this ref namespace, Git may introduce a numbered namespace
+   (such as `refs/bundles/<i>/*`) such that stale bundle refs can be
+   deleted.
 
 3. If the file is instead a bundle list, then the client inspects the
    `bundle.mode` to see if the list is of the `all` or `any` form.
diff --git a/bundle-uri.c b/bundle-uri.c
index 96d2ba726d9..dc120664d1e 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -403,7 +403,7 @@ static int unbundle_from_file(struct repository *r, const char *file)
 		const char *branch_name;
 		int has_old;
 
-		if (!skip_prefix(refname->string, "refs/heads/", &branch_name))
+		if (!skip_prefix(refname->string, "refs/", &branch_name))
 			continue;
 
 		strbuf_setlen(&bundle_ref, bundle_prefix_len);
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index 3816ed5058d..33a7009e9a2 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -58,7 +58,7 @@ test_expect_success 'create bundle' '
 test_expect_success 'clone with path bundle' '
 	git clone --bundle-uri="clone-from/B.bundle" \
 		clone-from clone-path &&
-	git -C clone-path rev-parse refs/bundles/topic >actual &&
+	git -C clone-path rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -68,9 +68,9 @@ test_expect_success 'clone with bundle that has bad header' '
 	git clone --bundle-uri="clone-from/bad-header.bundle" \
 		clone-from clone-bad-header 2>err &&
 	commit_b=$(git -C clone-from rev-parse B) &&
-	test_grep "trying to write ref '\''refs/bundles/topic'\'' with nonexistent object $commit_b" err &&
+	test_grep "trying to write ref '\''refs/bundles/heads/topic'\'' with nonexistent object $commit_b" err &&
 	git -C clone-bad-header for-each-ref --format="%(refname)" >refs &&
-	test_grep ! "refs/bundles/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone with bundle that has bad object' '
@@ -78,8 +78,8 @@ test_expect_success 'clone with bundle that has bad object' '
 	git clone --bundle-uri="clone-from/bad-object.bundle" \
 		clone-from clone-bad-object-no-fsck &&
 	git -C clone-bad-object-no-fsck for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/bad >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/bad >expect &&
 	test_cmp expect actual &&
 
 	# Unbundle fails with fsckObjects set true, but clone can still proceed.
@@ -87,14 +87,14 @@ test_expect_success 'clone with bundle that has bad object' '
 		clone-from clone-bad-object-fsck 2>err &&
 	test_grep "missingEmail" err &&
 	git -C clone-bad-object-fsck for-each-ref --format="%(refname)" >refs &&
-	test_grep ! "refs/bundles/" refs
+	test_grep ! "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone with path bundle and non-default hash' '
 	test_when_finished "rm -rf clone-path-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="clone-from/B.bundle" \
 		clone-from clone-path-non-default-hash &&
-	git -C clone-path-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-path-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -102,7 +102,7 @@ test_expect_success 'clone with path bundle and non-default hash' '
 test_expect_success 'clone with file:// bundle' '
 	git clone --bundle-uri="file://$(pwd)/clone-from/B.bundle" \
 		clone-from clone-file &&
-	git -C clone-file rev-parse refs/bundles/topic >actual &&
+	git -C clone-file rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -173,12 +173,12 @@ test_expect_success 'clone bundle list (file, no heuristic)' '
 	git -C clone-list-file cat-file --batch-check <oids &&
 
 	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect actual
 '
@@ -220,10 +220,10 @@ test_expect_success 'clone bundle list (file, all mode, some failures)' '
 	git -C clone-all-some cat-file --batch-check <oids &&
 
 	git -C clone-all-some for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual
 '
@@ -253,7 +253,7 @@ test_expect_success 'clone bundle list (file, all mode, all failures)' '
 	git -C clone-all-fail cat-file --batch-check <oids &&
 
 	git -C clone-all-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/" refs
+	! grep "refs/bundles/heads/" refs
 '
 
 test_expect_success 'clone bundle list (file, any mode)' '
@@ -282,9 +282,9 @@ test_expect_success 'clone bundle list (file, any mode)' '
 	git -C clone-any-file cat-file --batch-check <oids &&
 
 	git -C clone-any-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect actual
 '
@@ -313,7 +313,7 @@ test_expect_success 'clone bundle list (file, any mode, all failures)' '
 	git -C clone-any-fail cat-file --batch-check <oids &&
 
 	git -C clone-any-fail for-each-ref --format="%(refname)" >refs &&
-	! grep "refs/bundles/" refs
+	! grep "refs/bundles/heads/" refs
 '
 
 test_expect_success 'negotiation: bundle with part of wanted commits' '
@@ -322,10 +322,10 @@ test_expect_success 'negotiation: bundle with part of wanted commits' '
 	git clone --no-local --bundle-uri="clone-from/A.bundle" \
 		clone-from nego-bundle-part &&
 	git -C nego-bundle-part for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/topic >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/topic >expect &&
 	test_cmp expect actual &&
-	# Ensure that refs/bundles/topic are sent as "have".
+	# Ensure that refs/bundles/heads/topic are sent as "have".
 	tip=$(git -C clone-from rev-parse A) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
@@ -337,8 +337,8 @@ test_expect_success 'negotiation: bundle with all wanted commits' '
 		--bundle-uri="clone-from/B.bundle" \
 		clone-from nego-bundle-all &&
 	git -C nego-bundle-all for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
-	test_write_lines refs/bundles/topic >expect &&
+	grep "refs/bundles/heads/" refs >actual &&
+	test_write_lines refs/bundles/heads/topic >expect &&
 	test_cmp expect actual &&
 	# We already have all needed commits so no "want" needed.
 	test_grep ! "clone> want " trace-packet.txt
@@ -363,13 +363,13 @@ test_expect_success 'negotiation: bundle list (no heuristic)' '
 		clone-from nego-bundle-list-no-heuristic &&
 
 	git -C nego-bundle-list-no-heuristic for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
-	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/left) &&
+	tip=$(git -C nego-bundle-list-no-heuristic rev-parse refs/bundles/heads/left) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
 
@@ -395,13 +395,13 @@ test_expect_success 'negotiation: bundle list (creationToken)' '
 		clone-from nego-bundle-list-heuristic &&
 
 	git -C nego-bundle-list-heuristic for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
-	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/left) &&
+	tip=$(git -C nego-bundle-list-heuristic rev-parse refs/bundles/heads/left) &&
 	test_grep "clone> have $tip" trace-packet.txt
 '
 
@@ -428,10 +428,10 @@ test_expect_success 'negotiation: bundle list with all wanted commits' '
 		clone-from nego-bundle-list-all &&
 
 	git -C nego-bundle-list-all for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect actual &&
 	# We already have all needed commits so no "want" needed.
@@ -465,7 +465,7 @@ test_expect_success 'clone HTTP bundle' '
 
 	git clone --bundle-uri="$HTTPD_URL/B.bundle" \
 		"$HTTPD_URL/smart/fetch.git" clone-http &&
-	git -C clone-http rev-parse refs/bundles/topic >actual &&
+	git -C clone-http rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual &&
 
@@ -476,7 +476,7 @@ test_expect_success 'clone HTTP bundle with non-default hash' '
 	test_when_finished "rm -rf clone-http-non-default-hash" &&
 	GIT_DEFAULT_HASH=sha256 git clone --bundle-uri="$HTTPD_URL/B.bundle" \
 		"$HTTPD_URL/smart/fetch.git" clone-http-non-default-hash &&
-	git -C clone-http-non-default-hash rev-parse refs/bundles/topic >actual &&
+	git -C clone-http-non-default-hash rev-parse refs/bundles/heads/topic >actual &&
 	git -C clone-from rev-parse topic >expect &&
 	test_cmp expect actual
 '
@@ -553,12 +553,12 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
 	git -C clone-any-http cat-file --batch-check <oids &&
 
 	git -C clone-list-file for-each-ref --format="%(refname)" >refs &&
-	grep "refs/bundles/" refs >actual &&
+	grep "refs/bundles/heads/" refs >actual &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect actual
 '
@@ -641,9 +641,9 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual &&
 
 	# We now have only one bundle ref.
-	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect refs &&
 
@@ -679,13 +679,13 @@ test_expect_success 'clone incomplete bundle list (http, creationToken)' '
 	test_cmp expect actual &&
 
 	# We now have all bundle refs.
-	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C clone-token-http for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs
 '
@@ -721,9 +721,9 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual &&
 
 	# only received base ref from bundle-1
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
+	refs/bundles/heads/base
 	EOF
 	test_cmp expect refs &&
 
@@ -749,10 +749,10 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 	test_cmp expect actual &&
 
 	# received left from bundle-2
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
+	refs/bundles/heads/base
+	refs/bundles/heads/left
 	EOF
 	test_cmp expect refs &&
 
@@ -795,12 +795,12 @@ test_expect_success 'http clone with bundle.heuristic creates fetch.bundleURI' '
 
 	# received merge ref from bundle-4, but right is missing
 	# because we did not download bundle-3.
-	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-http-4 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 
 	cat >expect <<-\EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
 	EOF
 	test_cmp expect refs &&
 
@@ -862,7 +862,7 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# All bundles failed to unbundle
-	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	test_must_be_empty refs &&
 
 	# Case 2: middle bundle does not exist, only two bundles can unbundle
@@ -909,10 +909,10 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# bundle-1 and bundle-3 could unbundle, but bundle-4 could not
-	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs &&
 
@@ -961,11 +961,11 @@ test_expect_success 'creationToken heuristic with failed downloads (clone)' '
 	test_cmp expect actual &&
 
 	# fake.bundle did not unbundle, but the others did.
-	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C download-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs
 '
@@ -1083,15 +1083,15 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-1 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/lefter
-	refs/bundles/merge
-	refs/bundles/right
-	refs/bundles/righter
-	refs/bundles/top
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/lefter
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
+	refs/bundles/heads/righter
+	refs/bundles/heads/top
 	EOF
 	test_cmp expect refs &&
 
@@ -1144,12 +1144,12 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-2 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/merge
-	refs/bundles/right
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/merge
+	refs/bundles/heads/right
 	EOF
 	test_cmp expect refs &&
 
@@ -1204,13 +1204,13 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect actual &&
 
 	# Check which bundles have unbundled by refs
-	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/*" >refs &&
+	git -C fetch-3 for-each-ref --format="%(refname)" "refs/bundles/heads/*" >refs &&
 	cat >expect <<-EOF &&
-	refs/bundles/base
-	refs/bundles/left
-	refs/bundles/lefter
-	refs/bundles/right
-	refs/bundles/righter
+	refs/bundles/heads/base
+	refs/bundles/heads/left
+	refs/bundles/heads/lefter
+	refs/bundles/heads/right
+	refs/bundles/heads/righter
 	EOF
 	test_cmp expect refs
 '
-- 
gitgitgadget

