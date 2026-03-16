Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C49024336D
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773644899; cv=none; b=eZlfHScMPh5d6IXgftSqM4tC2wGOI9aApbUlUFg539PvqjLcHIc9bM4rJ7UsbntGZ1R9Z3NYdts2RTh53Th242P9RRkawokr0XdzYamxNrKgSY0MsdSAAtcs+lfou5uHW2dtXJzo+wlegBaeguK+WpU1881YQha4TDK6anjKCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773644899; c=relaxed/simple;
	bh=Q2LnH/bjWOLAKwZjlg4LP0zqdHcm92PEZnHSbdp/ONQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uSyBE519POm2bTH10k+sO3Xjd+C8lvIedxfWlZdWmLWYHi1zm8FGvLS7enseaGXG+qITpXXYOzuqFje/ftvB6Da8q5GjL0VAjXAv3NEu4h4MsePrkeFILAKi+pXhopctYbjGt0CIqPwjM1o5p8BGLj0x7WwPsTCuEyc04QfVIuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gEEGzXq2; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEEGzXq2"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35b88a4f123so738674a91.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 00:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773644897; x=1774249697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=794E9R4Uj7Iv8p83a4ku37+33iasKbJu5QGYzm8g8go=;
        b=gEEGzXq2TZp1G7oUgptjLN+gjvcHTuAt0AChz3+XQtUj/aiXGTCR7oVPu6OcEw65DX
         YTg2i7hqMLReMBTosqBJaI2aOfPSozNXMxS/HrcVbfGJa2IT7lyNyyd8x3v4tRLswSiz
         xUWmwDLi6nB1Cdp+L6A2h3NCYqP52C9l15AdFVQF3XYwvsAa9c1gfb4KtV3rmFUOWBLo
         tXeUBlMOugV4Zvrlif8lzkvkUnj9QbRUJUwaQsOggi56v8V2SPPlcOBDrIMYuAEl4Kjc
         y+8x53N8HErwCl8qhHeVIkRTYdzUA0jyj60HRWYq/VVjV7i1OvvWj0L+Dlpcr5DK39T/
         YFkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773644897; x=1774249697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=794E9R4Uj7Iv8p83a4ku37+33iasKbJu5QGYzm8g8go=;
        b=PmvlOJf7jys8xPs16fB7q4ZEn+N3CdKAvEdQf9OX2u7E4hFWO0GjuBVjTkz6Fw32Uz
         EcUAySX3+WnBqtgg0AQVt8FTctudEnQSAfwxWotzTfqNL0PQvBUSHKFrg+/kP/4zDZ+n
         jW9Lg+GDtqXWjFFQpvN+oy2ionR4ROio4m7V5VtoydttACiZVv3MABHZeDvDznKJOLLz
         F3WhSqh2hr76tTE7UWMNsuOdVne0qMXTYCWaQP9oUWanTLEfcOtu0C7pmkUFs89FRaVo
         6xPqDp+PJdQTqWha6FmWfQmgPsV6sPXndsPOaXKtw+BhPtaeiVC38dSoBvqt1aykUHns
         466g==
X-Gm-Message-State: AOJu0YxQZIdQ5Oy+grGDYfKOa++0Pcbiq6s7KhyO7rcugSP278G4HtaY
	Z59INsDgLo+H9js1T2fQj0gw48FPCMUTkxVM/1rVZlc2x+3qcpWkfKOdXJN11Q==
X-Gm-Gg: ATEYQzxNwTzOaa0KY+7/0K+Eajt1LE1hiTdy9Lp5R2UCETIOXqZbBWicoWwCd1KpkBy
	XkH4ikUk4jR/RhmW7IjNJL+6IV2ome7kEWG3A0AjerkB/LVuL/kVPxm9oP5dXaUlvfNVpiGP8W3
	Oc+PYPdvojjzYqfm0yL+z7ueKQt9WQR+EG2IFxQOqq02CUu0c9xRjNFPZ2GYacD5196TrzJockG
	OeTY6UBZEqU1eQ3MK7tEsw+xBlZzMH/GGVlpETbd0Dc5u46S+GC3Z7umoLLl1LTFrSPyxj+YfLU
	+sFYMiEKl4lb/yw40f9AWQXn1PLDREkcye3/HpSUg/wzjIIlPS4xKcyTXOs83vXVTnIGGO2i6o0
	MyYPLY+NJZShJzCHB8OOLyeByl6rmekT99s3GgLkP8XBhurh3eQ2iAgLuZV8L3PoV5s23xDi3Jw
	8DYdOsu5A+B51GRkcw0SGt2P5bTR4tEUzIjh9b+mJatStQyt8OY9GKpltBb+9D
X-Received: by 2002:a17:90b:1a8c:b0:35b:9ab6:1d59 with SMTP id 98e67ed59e1d1-35b9ab61fa1mr2497540a91.13.1773644897012;
        Mon, 16 Mar 2026 00:08:17 -0700 (PDT)
Received: from localhost.localdomain ([115.244.141.202])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a244c6136sm4399233a91.5.2026.03.16.00.08.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 00:08:16 -0700 (PDT)
From: PRASHANT S BISHT <prashantjee2025@gmail.com>
To: git@vger.kernel.org
Cc: PRASHANT S BISHT <prashantjee2025@gmail.com>
Subject: [PATCH v3] t4200-rerere: use test_path helpers
Date: Mon, 16 Mar 2026 12:38:12 +0530
Message-ID: <20260316070812.84760-1-prashantjee2025@gmail.com>
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

