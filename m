Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5F317996
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745587074; cv=none; b=d4zGOtus3dYx+YkyxlRXcaZvdS20zyJmu2OGBaM9tHCUyeskrmsvR6n8X/jbmyChUjizm63bUXrbvNJ5bqGI81TSLIZMMYLJySP3/EXkhcRmaMdixkkWJt0K872r9Sb8aOfPaokn2xCfFdUtXFO49U1OviDf3VtJC3Cr27JGki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745587074; c=relaxed/simple;
	bh=e4cmo86n8nDiuszDyN4FsuJnvE5NcL9pUv0mgW7OGlg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=eTQVIG841fdYKhq7nslRYnzpCUGpzGeUmjpPXYkiqAvDYycOEXWwR0hYlki01Mubs63uHdaaeZAM0f6MHwVPcPFXy+PI4WOwiQgjriTrYG7BhRFE5h8WSCeKMKa06Xst8abGEY5/CoRdOTx7hlSDqXm6BEZRUaVS8G9Xciz98O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8DvBBHO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8DvBBHO"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cf034d4abso21282295e9.3
        for <git@vger.kernel.org>; Fri, 25 Apr 2025 06:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745587070; x=1746191870; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ef/sHKB3s9E8tyYCAfO6CgIV0OAxuAu29oidyyNDeEg=;
        b=I8DvBBHOPoYbkpkEkKKr8gK1vgzKOtgZkmFYW7TVu5h7Ol7YTNRGRgPxqwh0WLZWCe
         zBmeGVSsLSHU89jJ69gQpxFQpy0bOK90qr5p7lwpMKzhn3MNGP8THx2WRmZhCS/mFMdR
         735n9K6dcFcPT4RXsLty51NjNLn+owPMwtBAzLCgudxu5GsjJtkn0cGRCPpU/hemLlIg
         8g9/c4Je1jZDPfGIODCEd17scDquQFG4dKJFjIUUufynqf5bjcG95EGExxsRc2W1Fh+E
         dbTHTy+uCwAh7FlY3Pt4Dxh9eLNacHw5VtEWeiKpuCBgQjZGrQ9jNS2Y2ICR8tEOhRHU
         Iqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745587070; x=1746191870;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ef/sHKB3s9E8tyYCAfO6CgIV0OAxuAu29oidyyNDeEg=;
        b=dhspsb+VZ9QaQ2dSmA7hR3jXxY81j0Qgae298xxEFYyXFs0fPtlxkpfR89u2SWtrSC
         5z3pZbs5gHkp1tJ8MyFmgpZQ0r5nTQX5U64QNaWt3iddXUIGtVntV72nsM9EF2PquEoq
         B5qkr8m28ERT+qobstA8q9EmuIUtmw/WQK6fpLW9Ta7xCyGUIHvC9AhO5lPA2G53lReI
         bI7On+g/WC5+jv6tslcuXhz0NljHWGTxQpKRPdUU0kyFvnap03Y1ytrWTHECFjrK4WS5
         AzEd7EibnlHqR3Pyx3T4Pwam+oqvFmSXwJOkJsDwIImYNICs5h5JKW4h2f9U7yRW4Ajl
         mCig==
X-Gm-Message-State: AOJu0YwMH6kxK0IVs2xSA98tTh15/MTz9KUHQPf4SMdLV4XlGNZg25+t
	B096xmHipGsrY7gcXZWheQ3QncEli7ldchYultcVJwUy+7RjqnCr4I1qAw==
X-Gm-Gg: ASbGncu+DqaGBs73IppwSx89dIwdNL0KszQZYQHAQGgalil4zkTiW38XMrunR1ujBIC
	ZEzrMxtIAv1Nsgz9FDDF9KNqoYdNUSancJmPxUNmFpYgnusI89Ni9bNIsG6aOS5AlvkgpOFUaMH
	tmBQqXzl6oIB1qr26TJk5C+0Wsk4VcY3vufsHcB7bOp8Fuj45890Xy4bzea6evQipnVcAVIWx5E
	ULc32VH+FazX7aPt+NMJ5zcTiMn0XK2/nTTDGLDzx/kMYwpK/cZGY5Vs3Jt20UDjoqR9Sc7bsYQ
	5B6uaauWl0M6k39ibfi91DkIuWID+hkH1Ayph31cWQ==
X-Google-Smtp-Source: AGHT+IFKqBs7yyLkqnNgKVnqLm2Pz4INjnNBvccjWULc71QoCG45X0+z4pE55ItBCLwD2K9GnQYzVQ==
X-Received: by 2002:a05:600c:3488:b0:43c:ed61:2c26 with SMTP id 5b1f17b1804b1-440a660612fmr24563065e9.17.1745587070162;
        Fri, 25 Apr 2025 06:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a02csm25009805e9.27.2025.04.25.06.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 06:17:49 -0700 (PDT)
Message-Id: <6957ee2fed2f04ad7cd02e5785eb89a1a55f81f5.1745587067.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
References: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
	<pull.1897.v4.git.git.1745587067.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 25 Apr 2025 13:17:46 +0000
Subject: [PATCH v4 1/2] bundle-uri: copy all bundle references ino the
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
 bundle-uri.c                |   2 +-
 t/t5558-clone-bundle-uri.sh | 172 ++++++++++++++++++------------------
 2 files changed, 87 insertions(+), 87 deletions(-)

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

