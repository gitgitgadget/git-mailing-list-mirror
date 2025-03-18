Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C220F08F
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 15:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312181; cv=none; b=gO0RHPkzeys6OE84x0S6y5MGXKmyXU1ycgIyR1jqNoADpz2SwxSFHUSrqSAauqT8kRIG3TEuk3TU6TZphLj+JMhJ25IBGxaGxnzwSYV1ah7rCV+7Wj48wLPTLwdoKXoEApFLh+zKcIgNLmW5ML7xOFXBWymy7pgdiw7CdqJ4cak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312181; c=relaxed/simple;
	bh=dUFPKtSDLKubBJPul4KsU3C2dx/qBSXeYWTMX/5d2xY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Huu657ntkzz215n8IpjJfzQc/Rm04kWBOSSswMsiu6VujcBnrSV49vdHUbwBxOE2z3NDPnDuaynGlJH0nvc3XlZKZ40MrjZGDnGZk4j1aw0/T2ZapRvv6RQGoI+VN0g9jLwdRx7T33efVMvIoZcKFj1iHp2Qr9yIdT7HlNueqwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0GVeYhA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0GVeYhA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so25268845e9.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 08:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742312176; x=1742916976; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxffKrXtNqXMe+SjkFlTbCbH52ygBrk6fY13bDOEEJs=;
        b=c0GVeYhApgM/xLmKl+6HFebF4CLaLoUIcYWDmDG5NwIGdWgWOzjfVsVRuh7XB6NEIu
         U0LUD0hbVQHebHC0DQPRyPzgAuTGt7aJ0/mnSC0XmCkLHB08VvBJm3zAoHXKoCILwY7t
         xTI68UDmpkRUcp4v8vudHKDMLPS6Xr93elHJYj7jMAkfNblkWgA6Xi+q2rxNw3MNhUmd
         gO+F8TJMFtd4ADlsitOw2uS+bWDMFyGSBS98Q+GBrG9q0a4E/9w5ZUJ5aaZ03+4BlMpv
         UznJ/skVkwQzSBgb+NDaXK5uvOr2U3S9ZOfnti0o55lvwOp0oZzRRDpQT6YIr/bXUjyF
         NHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312176; x=1742916976;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxffKrXtNqXMe+SjkFlTbCbH52ygBrk6fY13bDOEEJs=;
        b=Xqjz8PNDVxVqLDFyFxZ4uScRFprhWoh1MtvCrsGV1SmmZQ1GtyZjVSY7H/goGvypt4
         sT8mV6DdJZJuoUyFwbqUnuMdHjSwVCMnApMdVv0Og4D7qiowRhAULI2XkTKewT4pH+d+
         4M9cRRunlL+kymH5fzP7k6aHh8MBG9IRlu5WmW+a7124ssYK0mLEqWYnSbJ+1eBPfl44
         G8eay1Fn/SGUN3O1I5nImdcXxvYNJpS38nE0tojEBCL1ERjmdJJcrvwKaUI/7HpB81Ku
         0LnOQbBO0l/BDAYIilichGzGRzGAbKPuXPqdqfaGSIKihEvgCBZXdd4mjRACVriJ0iXf
         eXyg==
X-Gm-Message-State: AOJu0YwGBCehHyOyjDHaZ7iA6QKHCl+tFnC6L85RM8i0D1m/phFvXvCF
	7TiXwKu3D/Wbb7mDttMZOiLfaj7WnI2puKipOmx+AYA6CB/vjxqoi6oeVg==
X-Gm-Gg: ASbGnctUYPMzF8B7OMoqs7wW6Jiut0DVIdT9dgdqxYwKvZnDxlIeJ4j6zxaOVhmczbG
	gZ1Fm+1hqHLf96O7TFWpGMQvw9xtO1ED6B5fa477ZESi2IgcVzI2lcAkZ2VrMvRHH1lkOITDIou
	RGEmGwTxDEdt32lRLUpjDZAKRYXyyOewNEc7lr20RWzTvv+lbe+sCttt6zw6fP5rYFTZ+4S66On
	cmzng6pizrKr3N1Gb+ELNB54bFnaJQM2sBqPS1/vlFR4uwARtyIiMkgcbOC8BklTpNV6xgNkOuQ
	dZRVAhk6IqQhKU+us7oVjhWZDtS+xb7Bbak49ulPdyv0/y/gRVNThpt9
X-Google-Smtp-Source: AGHT+IGHXTEQcnmbSrTbYcBD6tWylnOIgfhjOzSKWwFFR2mnDpwQ9+yn7byMiGjvKsRls6avSUHpqw==
X-Received: by 2002:a05:600c:1e1d:b0:43d:79:ae1b with SMTP id 5b1f17b1804b1-43d3b9a3369mr35300495e9.14.1742312175589;
        Tue, 18 Mar 2025 08:36:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4053dac3sm2861815e9.1.2025.03.18.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:15 -0700 (PDT)
Message-Id: <2ccbfdcc2dcc77aa33aabce3886ca8690b9253ac.1742312173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
References: <pull.1897.v2.git.git.1740825238.gitgitgadget@gmail.com>
	<pull.1897.v3.git.git.1742312173.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 18 Mar 2025 15:36:12 +0000
Subject: [PATCH v3 1/2] bundle-uri: copy all bundle references ino the
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
index 744257c49c1..3371d56f4ce 100644
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

