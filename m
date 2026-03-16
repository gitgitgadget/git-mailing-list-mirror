Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34247080E
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 04:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773634979; cv=none; b=d33B6UwYXN/7H4KWj7IWtfKDoq1OCyfPoKMdVNIaXATDsnApo/iyvZSOV7fmk+uIbj1O0xJOOf4mR1fX31iwurOMv6fNPVfh6LnwUwr9ORG2ad+Ik1s7WmTIFrAb2cVPSeikZmmPzBYV6AV46BqQc4+horifpuKVQ/sGicsOizc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773634979; c=relaxed/simple;
	bh=VMB9bf00F7KhKKMvOSoBr/reCvKbkQhbGDk2Kkpm09U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttbji2vkz9qE3zCe5SNyisvhPE5351WqQI/y4DUF15fWnUtYUXyGGjQ9tL3qZuoxMcpHV6i01/Wu3eufjGkB9NPRcub7s6FZxhA2C0KDnS7yBWtgVqh4TTsv60ACG6QiWk4xMp65IfqUSttAbHimQfj3cfB7jmTXfYRZl1LJ8OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMbnv12u; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMbnv12u"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so681867a91.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 21:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773634977; x=1774239777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dvVZssfErEff+vvwXC7q/Kn8WogDtECcjJud3ey/E1w=;
        b=mMbnv12u8Zm98wCCjfYWstV7b3yVwqSj4q5sIHhLJSjzudYaTxSlr0+O9gOZVlh6Ec
         3MP3WABrxrOqC52457ltxejBlBoWH2jyV7hF7o2SLktW0rFAUwbVLFEfabuoYzuIIFd+
         iuFFONJWyWNrhRImdRkiLYivLv842AmHApP4OHI38Dj2h4HYmnvkmbhmQIsWG6LGTAI5
         JdsvT+SusJWVx93+EvWd1xdbqgdrdg/G1tLSfQJ2IotgyCXHnBhTd/38IwqhZe+SCynG
         77SISGap73KixKU8R4bxKlGzov9Xis5vqJVqFJUHO5rbTCLwncHPoPkoUnZodxsc3Il8
         UBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773634977; x=1774239777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dvVZssfErEff+vvwXC7q/Kn8WogDtECcjJud3ey/E1w=;
        b=OsXWRU8b9KrTRmWU2cteHyY1044r10pL/Q6/TjvL52ElGjs9g9dweYNC0w5yLDQ6hJ
         N4GKkUhyUeF0NuP+qmOe4r2WHyTz5cdRVgVnMq0kfOOwBIXiPqt+GwGXSxp3WaVe0z1y
         FB7LAA148XSScGqaFzVKPs8uahRycRl1VTF5XJn0e2zrJb7P5eyLSi1RMypvqmLO+Psm
         MFPMdSWabBiWwCT447xFnSvrC1Ez1hFZjpgPaS2m22KoavQa20sFJDOZsD8VWdwkbqfA
         NbUawQqLe9yQyd3hIpMTvu45LEhcoO8MHjRdxAlozirwlyAiOWMxwBNdoacml5mhxgXz
         ZK3g==
X-Gm-Message-State: AOJu0YxfJUxoDtMoR07mkU2Rrv271FqrxT0acywDqkcrb/ncT22JVkDT
	vo+HMilofjvvA8oJDOKpACC2FyqKpDf8eA1XJ7qdRDqrQZhje469bzR2bVV+Zw==
X-Gm-Gg: ATEYQzx3qChYsudPcUmeAAkmnl+RUs8lz2wn6VAfmUvaJHNx8QdlJVia4sKsoN3BgWQ
	8GVPmP9p2TR+m8AinOuAcK0CQhMv37xZGmrUqIkKrq0cw1rbSjjcL/ow00DGhUDrYUBeoAFe0XA
	petOsCX548kFm+CZn2AI4wSr6MeEo4wCEbN/lmRVWExuGhlkVNfCilLVhxvqtylEVc5qOVzkQbJ
	fe7HpYcLEIMEvEHmDkub2l+U5w4kv0Cuk+/OeCna9KMsTyK8mkwK7C1y+OeANgHguFy5qbrOctV
	e/sLtNQARdWbansnCMRTtsQjFGb38mAJ5eyUbhGsWRTxuG8KxP7xAMNx5r+vxb9QNKKoJVGVf9k
	+sRrloe4HTkiEJP862gvZELDeJ665yz048N8514yhnQZ9YzajWT8UZBgOiv7SO3RCjUjxbWWTWV
	LVCxiJ44fSFiHLjCK8svm6Olf3lWaJ0vSijLKUH+t+EZaedk4rfZL2rExer0Ta
X-Received: by 2002:a17:90b:2691:b0:359:84a3:1942 with SMTP id 98e67ed59e1d1-35a11ab44admr13743836a91.13.1773634976804;
        Sun, 15 Mar 2026 21:22:56 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73eb996257sm7589956a12.9.2026.03.15.21.22.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Mar 2026 21:22:55 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH v2] t4200: replace test -f and test -d with test_path_exists
Date: Mon, 16 Mar 2026 09:52:48 +0530
Message-ID: <20260316042248.63278-1-prashantjee2025@gmail.com>
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

