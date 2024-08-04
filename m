Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D73101F2
	for <git@vger.kernel.org>; Sun,  4 Aug 2024 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722755547; cv=none; b=RVv0m+UV9qAP1IIvwLrvQrfQ+rqCe+picSRQrhVVBlAHsCbJgKUefwhc/EE6oPvzdaTnfYckY33lzNOmENlR/D3VXNSKCto/JueKG2dZB8LuRlJ6n5KIuVl5hbfWeu5RLuvdtCGCrHlGGuvti0Wtv0pUOD1IplqqcPufZGVFc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722755547; c=relaxed/simple;
	bh=zFt/5mqToZnJZvy+0xBTzq0ezWUrhKqpuN0rexFWx/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDxzVhD9N5l++5TO9Bn9++U5Qa01EJyDQ+sIYoSLYbbPusLqIiAGZvmChwIqcAJa8gJBhHKJJB0ss0Yj72fQ7ndrZZKr/TI+MKFLVwEUXGIizHhMSr/mqF0n5vL7cXyB7pPg5InqsNk1HAKx/ucExSMGzsM4YiwUPawRf/dklRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GjesuFW0; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjesuFW0"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42816ca782dso63619265e9.2
        for <git@vger.kernel.org>; Sun, 04 Aug 2024 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722755544; x=1723360344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0oYkeQQovup8wxTSrg5Vch/rRizoqMurx0BKkimlug=;
        b=GjesuFW0A0B080OfPxji3Ox2hSq4ikg8ITfbqzHNv5lM2Eon0tuAJdvJvIAPMDqKKt
         wQjS3NgAMFor8xzNcJP89g7wiD+/4aPDYsmVnZDBEhmNpUFOhMJ+4lgcu/Bfrx/2yUZn
         /k9Sn1CrwNM9U4PPGLM0htzsVSILfNVEfXtNaJJigvSod2rMGcOPB74EDxqv1wdKxs0N
         GgTe1dvkcC2erGZrcYbnwpgPI0cSVgdhmuxuDGoDOg6LCIOomCNKbq4o6u95LF2Rj9rs
         uOcK3jRAJ20NhNtQnE5zvedQAxlIJp/R+Ui3CIpmCe02ahyeGKtl56zTIQvAJMoHMceU
         iBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722755544; x=1723360344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0oYkeQQovup8wxTSrg5Vch/rRizoqMurx0BKkimlug=;
        b=etc8a9/tq/2uTx6Lpx9wXF/9DTpAc/ZicI6NZlDBsfvxaFMShUxZu4ommfs6H13YLQ
         34qmB4aUY5dNfXEUS2xsGjBz46gUltRBjNJ2RiZB8algmzgnqKoQuogO7wFMKrtkMfGK
         o25vRmMDiZjyKUmeWwxfclIdPOmlP9qdwsnvki4PS1LCPK/x7dar4a650G6vd1EppjMS
         yuqJ29pnpfD+yi+aARVLBWJ5XjLaQThyCeQWTLz/S82wZknmiPg2Y9gdWlVewBVPHMHu
         Yiv0juzKCS9lZF7N7Xr6s7/0xkDoqDrXmNa6FYnWwmJ0wC7H/CbjZwUVmzS2qeqd/9Ga
         mhgA==
X-Gm-Message-State: AOJu0YyPn4GghBlfuGslqlZ+BPhs/g40Sbs8/ndD/R1JnkXVFD9ApRnw
	zfOMKK/XZa2vtUj2vePgrBEfHrsb7jAmXyU+OK/eBrGMqOgxx4WL2jS5p8pfs70=
X-Google-Smtp-Source: AGHT+IFSj+AgpcraFVZv54nhSnDFfQUEbNv8AgJBLDYBXYnzuxRWROuyd4vdMpahMtr7froGWu1ADg==
X-Received: by 2002:a05:600c:4ed0:b0:428:2e9:65a9 with SMTP id 5b1f17b1804b1-428e6b7c5afmr53202845e9.28.1722755543496;
        Sun, 04 Aug 2024 00:12:23 -0700 (PDT)
Received: from abdobngad.. ([197.40.96.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e3c0b7sm88477595e9.23.2024.08.04.00.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 00:12:23 -0700 (PDT)
From: AbdAlRahman Gad <abdobngad@gmail.com>
To: git@vger.kernel.org
Cc: AbdAlRahman Gad <abdobngad@gmail.com>
Subject: [PATCH v3 1/6] [Newcomer] t7004-tag: redirection operator
Date: Sun,  4 Aug 2024 10:11:32 +0300
Message-ID: <20240804071137.30326-2-abdobngad@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240804071137.30326-1-abdobngad@gmail.com>
References: <20240804071137.30326-1-abdobngad@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modernaize 't7004-tag.sh' by removing whitespace
after the redirect operators.

Signed-off-by: AbdAlRahman Gad <abdobngad@gmail.com>
---
 t/t7004-tag.sh | 50 +++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index fa6336edf9..3100a4c219 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -213,9 +213,9 @@ mytag
 EOF
 test_expect_success \
 	'trying to delete tags without params should succeed and do nothing' '
-	git tag -l > actual && test_cmp expect actual &&
+	git tag -l >actual && test_cmp expect actual &&
 	git tag -d &&
-	git tag -l > actual && test_cmp expect actual
+	git tag -l >actual && test_cmp expect actual
 '
 
 test_expect_success \
@@ -269,9 +269,9 @@ test_expect_success 'listing all tags should print them ordered' '
 	git tag a1 &&
 	git tag v1.0 &&
 	git tag t210 &&
-	git tag -l > actual &&
+	git tag -l >actual &&
 	test_cmp expect actual &&
-	git tag > actual &&
+	git tag >actual &&
 	test_cmp expect actual
 '
 
@@ -283,7 +283,7 @@ EOF
 test_expect_success \
 	'listing tags with substring as pattern must print those matching' '
 	rm *a* &&
-	git tag -l "*a*" > current &&
+	git tag -l "*a*" >current &&
 	test_cmp expect current
 '
 
@@ -293,7 +293,7 @@ v1.0.1
 EOF
 test_expect_success \
 	'listing tags with a suffix as pattern must print those matching' '
-	git tag -l "*.1" > actual &&
+	git tag -l "*.1" >actual &&
 	test_cmp expect actual
 '
 
@@ -303,7 +303,7 @@ t211
 EOF
 test_expect_success \
 	'listing tags with a prefix as pattern must print those matching' '
-	git tag -l "t21*" > actual &&
+	git tag -l "t21*" >actual &&
 	test_cmp expect actual
 '
 
@@ -312,7 +312,7 @@ a1
 EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l a1 > actual &&
+	git tag -l a1 >actual &&
 	test_cmp expect actual
 '
 
@@ -321,7 +321,7 @@ v1.0
 EOF
 test_expect_success \
 	'listing tags using a name as pattern must print that one matching' '
-	git tag -l v1.0 > actual &&
+	git tag -l v1.0 >actual &&
 	test_cmp expect actual
 '
 
@@ -331,13 +331,13 @@ v1.1.3
 EOF
 test_expect_success \
 	'listing tags with ? in the pattern should print those matching' '
-	git tag -l "v1.?.?" > actual &&
+	git tag -l "v1.?.?" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success \
 	'listing tags using v.* should print nothing because none have v.' '
-	git tag -l "v.*" > actual &&
+	git tag -l "v.*" >actual &&
 	test_must_be_empty actual
 '
 
@@ -349,7 +349,7 @@ v1.1.3
 EOF
 test_expect_success \
 	'listing tags using v* should print only those having v' '
-	git tag -l "v*" > actual &&
+	git tag -l "v*" >actual &&
 	test_cmp expect actual
 '
 
@@ -1171,7 +1171,7 @@ test_expect_success GPG \
 	git tag -v emptyfile-signed-tag
 '
 
-printf '\n\n  \n\t\nLeading blank lines\n' > sigblanksfile
+printf '\n\n  \n\t\nLeading blank lines\n' >sigblanksfile
 printf '\n\t \t  \nRepeated blank lines\n' >>sigblanksfile
 printf '\n\n\nTrailing spaces      \t  \n' >>sigblanksfile
 printf '\nTrailing blank lines\n\n\t \n\n' >>sigblanksfile
@@ -1569,7 +1569,7 @@ test_expect_success \
 
 test_expect_success \
 	'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment > actual)
+	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
@@ -1587,7 +1587,7 @@ test_expect_success \
 '
 
 get_tag_header reuse $commit commit $time >expect
-echo "An annotation to be reused" >> expect
+echo "An annotation to be reused" >>expect
 test_expect_success \
 	'overwriting an annotated tag should use its previous body' '
 	git tag -a -m "An annotation to be reused" reuse &&
@@ -1639,7 +1639,7 @@ hash3=$(git rev-parse HEAD)
 
 # simple linear checks of --continue
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1679,7 +1679,7 @@ test_expect_success 'checking that first commit is in all tags (relative)' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v2.0
 EOF
 
@@ -1688,7 +1688,7 @@ test_expect_success 'checking that second commit only has one tag' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1705,7 +1705,7 @@ test_expect_success 'checking that third commit has no tags' "
 	test_must_be_empty actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1723,14 +1723,14 @@ test_expect_success 'conversely --no-contains on the third commit lists all tags
 test_expect_success 'creating simple branch' '
 	git branch stable v2.0 &&
         git checkout stable &&
-	echo foo-3.0 > foo &&
+	echo foo-3.0 >foo &&
 	git commit foo -m fourth &&
 	git tag v3.0
 '
 
 hash4=$(git rev-parse HEAD)
 
-cat > expected <<EOF
+cat >expected <<EOF
 v3.0
 EOF
 
@@ -1739,7 +1739,7 @@ test_expect_success 'checking that branch head only has one tag' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1757,7 +1757,7 @@ test_expect_success 'merging original branch into this branch' '
         git tag v4.0
 '
 
-cat > expected <<EOF
+cat >expected <<EOF
 v4.0
 EOF
 
@@ -1766,7 +1766,7 @@ test_expect_success 'checking that original branch head has one tag now' "
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
@@ -1780,7 +1780,7 @@ test_expect_success 'checking that original branch head with --no-contains lists
 	test_cmp expected actual
 "
 
-cat > expected <<EOF
+cat >expected <<EOF
 v0.2.1
 v1.0
 v1.0.1
-- 
2.43.0

