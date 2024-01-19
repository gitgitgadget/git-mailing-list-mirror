Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3095787F
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 20:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695551; cv=none; b=leZTc0JBiS7haBp47yiK37dhzVs+HoR2EIjw6dXsYEjttoufVRPn5e0JyLxe4P9i59Ibihr9zGqZtoKXnFTcfS8jX7+HCUoCkKgnFNcwSfE3Swb7n142JZdIkKSiyfGCb2G+IJ8iSEoaKxyMkRIBbBZekec+ibyZ2Tg/RvUHHb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695551; c=relaxed/simple;
	bh=qlFuWhD1SPvWR5O7I18X5TxShWssvOZe3cDLWitA/RI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P+caurcQIVHeQDhM8eatCKlu+Y9RF25bf65PFWtR74i9f7kRm61A94kXRVd1uYkgxbGB/vD/YLklBgvklj0TCoK+IU+AX9yKqqTRZd6HZV8O/CsOK650mQsZGPfwZhReLQTztv+I/0BwvAZ3rECTufW3WFxyBUiAEfgCvqA+jjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed9ggALf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed9ggALf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so13435155e9.3
        for <git@vger.kernel.org>; Fri, 19 Jan 2024 12:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695547; x=1706300347; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5LAoa+8TpL70822AWNODhae4tBNU6PkVIKDUKMrj2Ok=;
        b=ed9ggALfwJymycnRfTQftYewVeBa/6fVV2b7SXyNtzzlM3ybftUGI9Qg+3Gociv4hw
         +CebcLs1PMOfAGIYMTaTBxBI9fN1gdMVd5D99l7ZVb4cKe03ZwuBNSlEK8aju8p9HvSb
         3meTTwKbGWxi6YNwXRNyrwgx2gKFptAZgNsOYd+CJPYmSIZVPLx91uw6IdFQGeKEtXzl
         fcsnR5As2c7MleqzyOF9iTdAZWS+cFmhrADeQhhW0RmC3jTYMIjfpu2YfA+KAT0mBSaP
         wNQTU3CukO8g0tUkKdX7vNKbQzMPfDByfDSRQe8ap0woA26Jo9AdOGUV8gjHiwYiFHMg
         /Sew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695547; x=1706300347;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LAoa+8TpL70822AWNODhae4tBNU6PkVIKDUKMrj2Ok=;
        b=bBxgRGsu4rLX0XTOqV9CP6H/fnXF0BLRLETZc7YKVin06x5BQBkvGxmA3AfQnZ1LY2
         /7nee3WCUp0sMrfJjwTNl8f/ibmlZNVQsc8wfSw2WWkg/KWqK9VKjwe+X2F4T3dKst7U
         5FoZSDy3na/NnQXShFn9yhQasx/KMaTQ2HvdhQ0GZzGYhnWWWrYupD+RZqUYFNUKPsk1
         ncyfStZD5Xb8YLNaIJeE0dcBX+83Msjvep3IF5T/nr2hF4UNPUlj2To/jhHz1Vq78vpt
         KicrM4qckvoxI0bm1vXBFR/BZG4lIrKvzHcPfIKwUHBrJy83bDUEtmTCQ18jPBCJiQZS
         0jPg==
X-Gm-Message-State: AOJu0Yxp+1OQcRZtzzw5idlqKqKWny8BOHokqjOdKtwiIcRmBqOWwRly
	l3CNLtrVts+aQo2z6MBcF9NqysfRcsbM+ann71dkhRt+Tkrr4wG4bwfShqkc
X-Google-Smtp-Source: AGHT+IGHqquNSUF5H7EDncPhc/KWbcSPuSfAPTPL5i/nX8guTNuNHRaukrH434P1Bi39/QrSE45xQw==
X-Received: by 2002:a05:600c:4747:b0:40e:a334:146a with SMTP id w7-20020a05600c474700b0040ea334146amr55865wmo.14.1705695547283;
        Fri, 19 Jan 2024 12:19:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n15-20020a5d4c4f000000b00337d6f0013esm3552683wrt.107.2024.01.19.12.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:19:06 -0800 (PST)
Message-ID: <d93c9c410b995b0c72958b1e9edc27c785857c55.1705695540.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
	<pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 19 Jan 2024 20:18:55 +0000
Subject: [PATCH v2 07/12] t1410: move reffiles specific tests to t0600
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
Cc: Patrick Steinhardt <ps@pks.im>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move these tests to t0600 with other reffiles specific tests since they
do things like take a lock on an individual ref, and write directly into
the reflog refs

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 51 +++++++++++++++++++++++++++++++++++++
 t/t1410-reflog.sh           | 42 ------------------------------
 2 files changed, 51 insertions(+), 42 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 3bd28699d53..44571033fac 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -308,4 +308,55 @@ test_expect_success 'for_each_reflog()' '
 	test_cmp expected actual
 '
 
+# Triggering the bug detected by this test requires a newline to fall
+# exactly BUFSIZ-1 bytes from the end of the file. We don't know
+# what that value is, since it's platform dependent. However, if
+# we choose some value N, we also catch any D which divides N evenly
+# (since we will read backwards in chunks of D). So we choose 8K,
+# which catches glibc (with an 8K BUFSIZ) and *BSD (1K).
+#
+# Each line is 114 characters, so we need 75 to still have a few before the
+# last 8K. The 89-character padding on the final entry lines up our
+# newline exactly.
+test_expect_success SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
+	git checkout -b reflogskip &&
+	zf=$(test_oid zero_2) &&
+	ident="abc <xyz> 0000000001 +0000" &&
+	for i in $(test_seq 1 75); do
+		printf "$zf%02d $zf%02d %s\t" $i $(($i+1)) "$ident" &&
+		if test $i = 75; then
+			for j in $(test_seq 1 89); do
+				printf X || return 1
+			done
+		else
+			printf X
+		fi &&
+		printf "\n" || return 1
+	done >.git/logs/refs/heads/reflogskip &&
+	git rev-parse reflogskip@{73} >actual &&
+	echo ${zf}03 >expect &&
+	test_cmp expect actual
+'
+
+# This test takes a lock on an individual ref; this is not supported in
+# reftable.
+test_expect_success 'reflog expire operates on symref not referrent' '
+	git branch --create-reflog the_symref &&
+	git branch --create-reflog referrent &&
+	git update-ref referrent HEAD &&
+	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
+	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
+	touch .git/refs/heads/referrent.lock &&
+	git reflog expire --expire=all the_symref
+'
+
+test_expect_success 'empty reflog' '
+	test_when_finished "rm -rf empty" &&
+	git init empty &&
+	test_commit -C empty A &&
+	>empty/.git/logs/refs/heads/foo &&
+	git -C empty reflog expire --all 2>err &&
+	test_must_be_empty err
+'
+
 test_done
diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index a0ff8d51f04..d2f5f42e674 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -354,36 +354,6 @@ test_expect_success 'stale dirs do not cause d/f conflicts (reflogs off)' '
 	test_must_be_empty actual
 '
 
-# Triggering the bug detected by this test requires a newline to fall
-# exactly BUFSIZ-1 bytes from the end of the file. We don't know
-# what that value is, since it's platform dependent. However, if
-# we choose some value N, we also catch any D which divides N evenly
-# (since we will read backwards in chunks of D). So we choose 8K,
-# which catches glibc (with an 8K BUFSIZ) and *BSD (1K).
-#
-# Each line is 114 characters, so we need 75 to still have a few before the
-# last 8K. The 89-character padding on the final entry lines up our
-# newline exactly.
-test_expect_success REFFILES,SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
-	git checkout -b reflogskip &&
-	zf=$(test_oid zero_2) &&
-	ident="abc <xyz> 0000000001 +0000" &&
-	for i in $(test_seq 1 75); do
-		printf "$zf%02d $zf%02d %s\t" $i $(($i+1)) "$ident" &&
-		if test $i = 75; then
-			for j in $(test_seq 1 89); do
-				printf X || return 1
-			done
-		else
-			printf X
-		fi &&
-		printf "\n" || return 1
-	done >.git/logs/refs/heads/reflogskip &&
-	git rev-parse reflogskip@{73} >actual &&
-	echo ${zf}03 >expect &&
-	test_cmp expect actual
-'
-
 test_expect_success 'no segfaults for reflog containing non-commit sha1s' '
 	git update-ref --create-reflog -m "Creating ref" \
 		refs/tests/tree-in-reflog HEAD &&
@@ -397,18 +367,6 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
-# This test takes a lock on an individual ref; this is not supported in
-# reftable.
-test_expect_success REFFILES 'reflog expire operates on symref not referrent' '
-	git branch --create-reflog the_symref &&
-	git branch --create-reflog referrent &&
-	git update-ref referrent HEAD &&
-	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
-	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
-	touch .git/refs/heads/referrent.lock &&
-	git reflog expire --expire=all the_symref
-'
-
 test_expect_success 'continue walking past root commits' '
 	git init orphanage &&
 	(
-- 
gitgitgadget

