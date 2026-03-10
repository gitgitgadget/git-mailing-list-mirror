Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A8F34D917
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 08:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773132233; cv=none; b=ilHnoevFvd21834vNzagetq4IWppr0299J6dRWc8qrdZCE+5NQX3LiiKAn255erDwnI6Haxi+2wl0gDaWOgEOMzMHeFYWisvvbRoRxuXCLo2Ppwv9zLQi9cF28s2eil38g9/Rr5uNHTZ9HZPI4NwyZl4eOYVuSCUTJBOCW2TBRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773132233; c=relaxed/simple;
	bh=VMB9bf00F7KhKKMvOSoBr/reCvKbkQhbGDk2Kkpm09U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VnzS3oor+LIE7hiJwN0JkeF+D2l0DF34JvAuujgmRx1qP1oUbHohzwTlMW4KjqV9v7NSEb40WNqaARdqd+RS7aBvh7MWvGD/ft1mwwvjd6VbGxuO8SRMyqrm37AghhiXOS7IsIAGhI+Di47QFRoR0SmItUQ3rvZYa0unWsP2QfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD180rov; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD180rov"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso6853552a91.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 01:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773132231; x=1773737031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvVZssfErEff+vvwXC7q/Kn8WogDtECcjJud3ey/E1w=;
        b=PD180rovnsECd/UujuMtxMMrp4Ft7iV9w9XhGMcnwxJnq7nSXbvhRs0vVDCr9VGzlX
         9RwPoMVo0XfY2jNrzFZthOYBg2sEuKtq3rKBUbgnk9I0DX7/ZYu336uJCNE6jYF73bMQ
         NMdZuOzn54yfE3BIkMQ25J/IIDM+/wjKV84935567jl0Ir/DlB1oOXND8yqfWpc9RLfp
         yKINV6pYVwY8IjpYYuIKfJqx9262RBG8g0vTfuUHEf/IIG2DuN3Mi5Vavs2lx1OiwJKG
         XqLAwaDyY1eU92Ugy40cCCN/DSr+M/aX8/yqDAR9mo7qArGr/JHQeeqle0hypMis39fd
         x5VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773132231; x=1773737031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvVZssfErEff+vvwXC7q/Kn8WogDtECcjJud3ey/E1w=;
        b=U1dLnv1hHDjbytmeKkOx+wpxsycgK2CzICGT6BsJebBi86CC50Repa6n+yuhz8Libp
         04a+UYZWWpqn/xEZzA9/S/VMvEQUznEfk+i0LdHM/fCn8xsioMJIroqyLEMoXJfr7duC
         N+EWtSeFZGJye6xqg7ahSEK8sSrO50B2bfJdPXa0IiFyVGJSvUeVtlPNbB4x4v1Z+cMe
         iTuL8NmTiTD38wD5lpt5M76ww8KXOZXRTKcCtyzu5T5pknG8aqa2qFZ/tgtXeBvaNt+L
         JIP8G8ow/cxje3Q4ap4aXDW24xUBL9ySlQnHOng4TsZgJdnXvJH89PpTTOgVUc7asFM1
         YE0w==
X-Gm-Message-State: AOJu0YzJq/nUfiE9jTNJG19APa6W+MsTCLG/l6FeZW6s6lrnQisJTBFZ
	fsZfKia4qE30kfrAnONnNwKqfCbklHMPfI7UhD+AirgRl6MOu554aqIRr/zXBA==
X-Gm-Gg: ATEYQzxXl1+SFLlWxbT0ad+IQDUeFLwvWoJ6GOarPc2x+EBYi/ari17U6h6egj4VFxf
	QOwUF5P6Fygp+7O0VmVqJZVbqaoFlXUTKFHwOOOhUxWwrnK2PtUTofROoX48KlU8acTUf4OdpmD
	5h5VPhs9IM0V9mHary86XBDoNAgkBOp5Wi4Bny2zpdZXU6W1uY5dtsQ2ggvGzcT/ZkQpIrOcM4s
	uQbEk3bSrCv8J63Bh67NlM8MJx7C/gYXVj6XYa8ib3tgYXQtB5fGwCWFobliAzJy2tagLyokCWG
	dDPvkp2DcwrU6EjYqNI+G0ih5qrdQJKIH/YSSn1bW2jP9v+pyvrgLgVLpPaS9d0wzT/S7xKGP2Y
	/+auM8a60mxTFgkjXRyUkfLeFWKmHL0w9XlNaxCqz9j502Gorf0FK7VJ9KGovPjeELMHxoJtuub
	2WvvG8ATpxx4ggqCLDUzBdyzMWAsrTZnSK/iEteK1FFMHLQmQ/jHvGsNuY53eo
X-Received: by 2002:a17:90b:558b:b0:359:8812:7c07 with SMTP id 98e67ed59e1d1-359be2c700cmr12892603a91.14.1773132230965;
        Tue, 10 Mar 2026 01:43:50 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359f05edd69sm2185534a91.1.2026.03.10.01.43.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 01:43:50 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	gitster@pobox.com,
	PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH v2] t4200: replace test -f and test -d with test_path_exists
Date: Tue, 10 Mar 2026 14:13:38 +0530
Message-ID: <20260310084338.49923-1-prashantjee2025@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace old-style path existence checks with the modern test_path_exists
helper function that provides clearer diagnostic messages on failure.

This conversion focuses on test assertions within test_expect_success
blocks where a missing path genuinely indicates a test failure,
rather than on control-flow checks (such as those in test_lazy_prereq
blocks) where missing paths are expected in certain environments.

Signed-off-by: PRASHANT S BISHT <prashantjee2025@gmail.com>
---
 t/t4200-rerere.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 204325f4d5..71a49bee56 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -72,7 +72,7 @@ test_expect_success 'nothing recorded without rerere' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled false &&
 	test_must_fail git merge first &&
-	! test -d .git/rr-cache
+	! test_path_exists .git/rr-cache
 '
 
 test_expect_success 'activate rerere, old style (conflicting merge)' '
@@ -84,8 +84,8 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage
+	! test_path_exists $rr/postimage &&
+	! test_path_exists $rr/thisimage
 '
 
 test_expect_success 'rerere.enabled works, too' '
@@ -110,8 +110,8 @@ test_expect_success 'set up rr-cache' '
 
 test_expect_success 'rr-cache looks sane' '
 	# no postimage or thisimage yet
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage &&
+	! test_path_exists $rr/postimage &&
+	! test_path_exists $rr/thisimage &&
 
 	# preimage has right number of lines
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
@@ -167,7 +167,7 @@ test_expect_success 'first postimage wins' '
 	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
 	git commit -q -a -m "prefer first over second" &&
-	test -f $rr/postimage &&
+	test_path_exists $rr/postimage &&
 
 	oldmtimepost=$(test-tool chmtime --get -60 $rr/postimage) &&
 
@@ -190,14 +190,14 @@ test_expect_success 'rerere clear' '
 	mv $rr/postimage .git/post-saved &&
 	echo "$sha1	a1" | tr "\012" "\000" >.git/MERGE_RR &&
 	git rerere clear &&
-	! test -d $rr
+	! test_path_exists $rr
 '
 
 test_expect_success 'leftover directory' '
 	git reset --hard &&
 	mkdir -p $rr &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_exists $rr/preimage
 '
 
 test_expect_success 'missing preimage' '
@@ -205,7 +205,7 @@ test_expect_success 'missing preimage' '
 	mkdir -p $rr &&
 	cp .git/post-saved $rr/postimage &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_exists $rr/preimage
 '
 
 test_expect_success 'set up for garbage collection tests' '
@@ -230,16 +230,16 @@ test_expect_success 'set up for garbage collection tests' '
 
 test_expect_success 'gc preserves young or recently used records' '
 	git rerere gc &&
-	test -f $rr/preimage &&
-	test -f $rr2/preimage
+	test_path_exists $rr/preimage &&
+	test_path_exists $rr2/preimage
 '
 
 test_expect_success 'old records rest in peace' '
 	test-tool chmtime =$just_over_60_days_ago $rr/postimage &&
 	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
 	git rerere gc &&
-	! test -f $rr/preimage &&
-	! test -f $rr2/preimage
+	! test_path_exists $rr/preimage &&
+	! test_path_exists $rr2/preimage
 '
 
 rerere_gc_custom_expiry_test () {
-- 
2.50.1 (Apple Git-155)

