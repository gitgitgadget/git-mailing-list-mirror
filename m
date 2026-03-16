Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357B325A655
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644687; cv=none; b=oaJhd8mHVYTqh7LSJNK8yetWUTpeeNkd8UINBp7PQxkPBt8AW2Kwy5JjwGmUroy7SjN/TuToWPx1n0jlnsb6eoL/TXDN/PUpR3noqm3lg3IbNVvJ1EkgGaiCyzBG2YfQIuuadkecNlqEp6w+1PhkueM3B95MfKRNzr75CMG3EaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644687; c=relaxed/simple;
	bh=B71c64mqyh4VC7bB2btNgInYaH2DNQUs5/bm7Pzs2No=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZOWtrWuEB4IHYeuzDoKcSVwXbHy77MLtpJsJ4LSm5f/vm9tMYuDWyE/EfyvwkZrOHDfdMNh8nb/F6zoANHufvHINFsyOcUYc79v4xJzIl2j6zFI9G+e2nKKDziA+5qCguLwY4C1R85wYFMas906aC7BwhrfRPaS2C/53zSiOGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQSqL9UH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQSqL9UH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0603ee486so135485ad.0
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 00:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773644685; x=1774249485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JiIW/5DBYS3cOqX97IfZwA7DmeP3o3gnqYNcvYttppg=;
        b=DQSqL9UHzfXvjwPYpScvKQdoWhXOGh3TOHqOCoyEiyl06gJXZHIjEfdSmL8B11OsV0
         JPqRM2LVMdSr0mnoQ7ZcHkRcJF6unSolb7XEidbE2i6MtgqM4bldmtxjY6VdwieYO/dU
         zQf06mWYIYBk8WldxuXi0tjSmcjZfG7STTPVGg2/JbGIYy8fFqd9BahR8+WD5D3vAi/n
         NBhV+DIpcxOCzNEW9OpK6LZSMgCT9qeDxtQUqjrxnxC++REdpvbfx3Btw7xe7Fgh1LZT
         TjwSw4+6zRzyV1R7pVRpPRadXiGOlKntSA2fMwG2GCs8GkPyRfFDOHJcY4hJvDX8tgvS
         7XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773644685; x=1774249485;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiIW/5DBYS3cOqX97IfZwA7DmeP3o3gnqYNcvYttppg=;
        b=q5bXnF+RHm9Pd6Gzhh2Ribpy/Eob08QHNdqkIr5a5+Gcr6s4s4NxSk293rpS9FnwmX
         lelMdmkrFSgDdp8fx0jGmMfsPuFzcmhcs6iLX+FCeOf3bsJfGOz09BG7ZWEYIbb8uMH8
         fiPqd+Dv+UhtBZ1NNcNtboYU7m6HaMVJZoVppqseiFQldv6UBSjTY3jIsMsxsvpJZ/a7
         2OXN2vmJopRQS8im2maP1qYTHmzFoPqHBv+TL/vGK/KMLZgX1YTwjDwEi8Y/mCY6uCzk
         ppnOP2SuHNUFSynDc75JB8f9hRQV7XBmSp4dQxUppQ7vgcn9eg0j1ereIeVNhT5a2HvQ
         s2Pw==
X-Gm-Message-State: AOJu0Ywff2U7y2a9Je5DyBrccavWg6cREnAN/xo+1fBq6uU1cz6nYFpB
	a6LAXOwWgb/2CDm6+QDeEQrRyqtBJTeqxsXkST56EgAaSlbzTko+LPTgwXO63w==
X-Gm-Gg: ATEYQzz0jMUJP4a/RDLbK0Uz5eelOEPxbf0gxOgRK2V9AJ/IiomapSoUtImvgt/TkYu
	ox7g4p0ROYQGIXE0WLstRStb4nryhrvZHGACx5V/Gxppupv8lFgsbPrI/4mqhM+lqLks7NzzuZ7
	u8ZFhwtd20eoLnPQDEWWp6hMiLryp7SpH40sytffCkTgGiSg6Q4iKG+OeXBCFw8lsq33Cu2+6Dd
	uNlkRUPC+Q2Bx+KLtWmK5EBAFEsKxa6qbfa9j3k0RhaJe22YNNFDchDjLJw9Omd3h2/K4N2EGrP
	TcJDnBzoiMQqVqjIt1bkcNpQ7nzb19F6uO7fB7mTzU2rhzoWEk9syetZy8QuCcydDZbTxfFP3NW
	EKdOHpfvOVRTQhXpzfNyg+6v/Lux1kOFs3JWi8H2/iAmZs005EZEMyqD5wAEu+GWxD9y0+HL6s+
	ElWHjWeohWLfHflw6exmG4wkFJto35LwzOluBn/o359LLEtqnkWZ1U4oI3tvpR
X-Received: by 2002:a17:902:e94d:b0:2b0:5fa5:a68c with SMTP id d9443c01a7336-2b05fa5a811mr2859525ad.9.1773644685029;
        Mon, 16 Mar 2026 00:04:45 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edd14sm125905675ad.50.2026.03.16.00.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 00:04:44 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH v2] t4200-rerere: use test_path helpers
Date: Mon, 16 Mar 2026 12:34:40 +0530
Message-ID: <20260316070440.79892-1-prashantjee2025@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert assertion-style test -[df] checks in t4200-rerere.sh to test_path_* helpers.

Instances were found with:

	git grep 'test -[def]' t/t4200-rerere.sh

Made-with: Cursor
---
 t/t4200-rerere.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 204325f4d5..1717f407c8 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -72,7 +72,7 @@ test_expect_success 'nothing recorded without rerere' '
 	rm -rf .git/rr-cache &&
 	git config rerere.enabled false &&
 	test_must_fail git merge first &&
-	! test -d .git/rr-cache
+	test_path_is_missing .git/rr-cache
 '
 
 test_expect_success 'activate rerere, old style (conflicting merge)' '
@@ -84,8 +84,8 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
 	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
 	rr=.git/rr-cache/$sha1 &&
 	grep "^=======\$" $rr/preimage &&
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage
+	test_path_is_missing $rr/postimage &&
+	test_path_is_missing $rr/thisimage
 '
 
 test_expect_success 'rerere.enabled works, too' '
@@ -110,8 +110,8 @@ test_expect_success 'set up rr-cache' '
 
 test_expect_success 'rr-cache looks sane' '
 	# no postimage or thisimage yet
-	! test -f $rr/postimage &&
-	! test -f $rr/thisimage &&
+	test_path_is_missing $rr/postimage &&
+	test_path_is_missing $rr/thisimage &&
 
 	# preimage has right number of lines
 	cnt=$(sed -ne "/^<<<<<<</,/^>>>>>>>/p" $rr/preimage | wc -l) &&
@@ -167,7 +167,7 @@ test_expect_success 'first postimage wins' '
 	git show first:a1 | sed "s/To die: t/To die! T/" >expect &&
 
 	git commit -q -a -m "prefer first over second" &&
-	test -f $rr/postimage &&
+	test_path_is_file $rr/postimage &&
 
 	oldmtimepost=$(test-tool chmtime --get -60 $rr/postimage) &&
 
@@ -190,14 +190,14 @@ test_expect_success 'rerere clear' '
 	mv $rr/postimage .git/post-saved &&
 	echo "$sha1	a1" | tr "\012" "\000" >.git/MERGE_RR &&
 	git rerere clear &&
-	! test -d $rr
+	test_path_is_missing $rr
 '
 
 test_expect_success 'leftover directory' '
 	git reset --hard &&
 	mkdir -p $rr &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_is_file $rr/preimage
 '
 
 test_expect_success 'missing preimage' '
@@ -205,7 +205,7 @@ test_expect_success 'missing preimage' '
 	mkdir -p $rr &&
 	cp .git/post-saved $rr/postimage &&
 	test_must_fail git merge first &&
-	test -f $rr/preimage
+	test_path_is_file $rr/preimage
 '
 
 test_expect_success 'set up for garbage collection tests' '
@@ -230,16 +230,16 @@ test_expect_success 'set up for garbage collection tests' '
 
 test_expect_success 'gc preserves young or recently used records' '
 	git rerere gc &&
-	test -f $rr/preimage &&
-	test -f $rr2/preimage
+	test_path_is_file $rr/preimage &&
+	test_path_is_file $rr2/preimage
 '
 
 test_expect_success 'old records rest in peace' '
 	test-tool chmtime =$just_over_60_days_ago $rr/postimage &&
 	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
 	git rerere gc &&
-	! test -f $rr/preimage &&
-	! test -f $rr2/preimage
+	test_path_is_missing $rr/preimage &&
+	test_path_is_missing $rr2/preimage
 '
 
 rerere_gc_custom_expiry_test () {
-- 
2.50.1 (Apple Git-155)

