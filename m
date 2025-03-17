Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE662054F2
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252424; cv=none; b=DY8fx1xXIUE/Nr8VtboduEjIOpKxli/cLb5mwWxu6F9uXBiHuo0aFiuxvhsK1egRfe1jPI2WFjWjhXyhNX4XjhTDZgJC/HMNa1Tc444Jt1mqWkz9/ACY28zm2yqKx57GUyiDO5PiKnXgMlw/H339GIFwSSQ1sYX8fWrm/Lf3G4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252424; c=relaxed/simple;
	bh=3D7qwAvdfdHfo7HJiMh5wPn2Rn3aPkDMmZRYZn2DqFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGc5zx8nZloJ9JjZMwfeoM3JyHiAEYubxgwofZZt7ZF/LUATncO9NwaMjRkLardxLiL2483pGC7fb4kpLDf+EAoyUqIRdO6Cbr8i9lPQYAmZs1YsjTD1ja9KDomVMwryQrdfNAFQfdoFlaFOkwRKyD0QfOdgNM4Cv158cCT7YWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bpY4U2MI; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bpY4U2MI"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c54f67db99so519094285a.1
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 16:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742252421; x=1742857221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7g+31hGIC6UafQoO2326PvHRLMcOv7XFl6ZWDT5n0ts=;
        b=bpY4U2MIRQflsKBGnsGbVWVlU5pyF9DluGFGrezK1NKrIwnxCnLt6z8NYBQdXO0glr
         Fu+QWt2k/nEF04MyjU1gfLy0voX03DFlqJ6B6/PkMR1q8DNhfs+PHiuwZU/N1x81wkFN
         jcYfKZSMeuqJv5E1lxS5H9Bw63pvzkUE/vGxBkcw7Jz4PHLPj4jsrlDBt/PzGw2KLbRd
         PInWUBjF1zk9vVQJUXgVIodtT9ViWUtiGvIoqn90I/VGsZX+SebqEggntpbs9HDaEkKb
         IyZha1dVTdoabNrD1AWsnOxTJtZzsOAkabJSrXM3cmqdJ9MYUz4bf+8tE7owm6Rb+dUp
         YDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742252421; x=1742857221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7g+31hGIC6UafQoO2326PvHRLMcOv7XFl6ZWDT5n0ts=;
        b=IfTFBfC9xMokgmCqIddtQIwV/G9UxEl1GltqO3O9oOd/cc5YZpX339r+dVPZt4cM7l
         v6/uMVBk3rqWIdnv954xD/3MebtMZvs72eB0NYI8LNgw/m0PtLztH7HnzIvBXsTLJoCT
         WKBOj+YLONcOyFaJ8HBsrO++e4SRv1ImjbIxYIcsmSePkmiDt1l6qKtKH8Do54PuGbEn
         rXTK97dlAEYoGce/QloleC9tZaw6RKu/twZ5bmlhmXLJ7nBljZqd4sAjcqWZXMjYKaH+
         W/VGkl8oCYVm5Qo7ntX6m0QFhwJcDbTLDGzupaPIf/dZOC8UuABuW1cDnJwqrA0HKEDo
         y4dw==
X-Gm-Message-State: AOJu0YwCMrLW4D0/snzRJ2ZxlYzYPKu6dCOOiezmxOlDE8fPRF0MFOZP
	0ma26GuT+pe+XVF3Io6qOptSCjH8r2m3n2PO7w+b72zJ0WgLL6gkBS7GiAksWp5b3C5fypySuts
	ShwU=
X-Gm-Gg: ASbGncs5SYMwhtQMMq4RIA6/5nrSPWLEXetbqbL3vB2RrBQWPsMFx0uE54kpfsCVX+7
	zZBFNpoEqCRnyt3y8rBhRbfRjGme9dEnFsc9QnonicsFUGCgufYWTljix1QMdCRcH1RYmEQ4bSp
	lpuaAGzjr5Gak5NS/FWxnage+UuzpizPEJNYjt/gy7Wxs/otS75fek8nt+oXcCBGQl/zrvdNBKN
	IB/9XNwkYdOiOOAfZPx13pmxBJfcL9YCchzBzc04dfs38gVqqc648tApQziVDhLYwV1H6jqEeCa
	r5pcBoyRUK2V6Zko14YlpVjLGAsNnOx4J1CHabjyYY2FKDUs2TJL5JyxbempGSjFmxMCVRWUx5P
	QIgyHZQQV8SL0rZ7XkScJl6ND4bU=
X-Google-Smtp-Source: AGHT+IGcjcvCIbsz0LYAovqNKASORcs8mVnigvAPo2m79eAhPitK4bk/owuNjW4xxmDMsg0XeoN84w==
X-Received: by 2002:a05:620a:801c:b0:7c5:438b:78 with SMTP id af79cd13be357-7c59b5be82dmr242009685a.6.1742252420899;
        Mon, 17 Mar 2025 16:00:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573c9d8absm640194785a.55.2025.03.17.16.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 16:00:20 -0700 (PDT)
Date: Mon, 17 Mar 2025 19:00:19 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/5] t/t7704-repack-cruft.sh: clarify wording in
 --max-cruft-size tests
Message-ID: <5e8bd3e66e304f42d4e84ec2aa9f06b82321d64b.1742252411.git.me@ttaylorr.com>
References: <cover.1742252411.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1742252411.git.me@ttaylorr.com>

Now that a number of new tests have landed in t7704, make sure that they
all make sense and are testing the things they say they are.

Things are mostly OK, but a handful of tests needed tweaks. Those tweaks
are as follows:

  - Use the terms "too large" or "too small" in tests that exercise the
    '--max-cruft-size' behavior. This has historically been treated as a
    threshold beneath which to combine cruft packs, but that will change
    in a subsequent commit. Prepare for that by using a more generic
    term.

  - Remove references to "--max-cruft-size" in the freshening tests.
    These tests provide coverage of our ability to record updated mtimes
    for objects already in cruft packs whose mtimes are upserted from
    various sources (loose objects, finding that object in a new pack,
    another cruft pack, etc.).

    These have nothing to do with the '--max-cruft-size' feature, and in
    fact none of the tests even *use* '--max-cruft-size'. Name them
    appropriately to make it clear that these tests exercise freshening
    behavior, not '--max-cruft-size' behavior.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t7704-repack-cruft.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
index cd452040ea..e6e4c2fad8 100755
--- a/t/t7704-repack-cruft.sh
+++ b/t/t7704-repack-cruft.sh
@@ -149,7 +149,7 @@ generate_cruft_pack () {
 	echo "$packdir/pack-$pack.mtimes"
 }
 
-test_expect_success '--max-cruft-size creates new packs when above threshold' '
+test_expect_success '--max-cruft-size creates new packs when too large' '
 	git init max-cruft-size-large &&
 	(
 		cd max-cruft-size-large &&
@@ -173,7 +173,7 @@ test_expect_success '--max-cruft-size creates new packs when above threshold' '
 	)
 '
 
-test_expect_success '--max-cruft-size combines existing packs when below threshold' '
+test_expect_success '--max-cruft-size combines existing packs when not too large' '
 	git init max-cruft-size-small &&
 	(
 		cd max-cruft-size-small &&
@@ -236,10 +236,10 @@ test_expect_success '--max-cruft-size combines smaller packs first' '
 	)
 '
 
-test_expect_success 'setup --max-cruft-size with freshened objects' '
-	git init max-cruft-size-freshen &&
+test_expect_success 'setup cruft with freshened objects' '
+	git init cruft-freshen &&
 	(
-		cd max-cruft-size-freshen &&
+		cd cruft-freshen &&
 
 		test_commit base &&
 		git repack -ad &&
@@ -257,9 +257,9 @@ test_expect_success 'setup --max-cruft-size with freshened objects' '
 	)
 '
 
-test_expect_success '--max-cruft-size with freshened objects (loose)' '
+test_expect_success 'cruft with freshened objects (loose)' '
 	(
-		cd max-cruft-size-freshen &&
+		cd cruft-freshen &&
 
 		# regenerate the object, setting its mtime to be more recent
 		foo="$(generate_random_blob foo 64)" &&
@@ -275,9 +275,9 @@ test_expect_success '--max-cruft-size with freshened objects (loose)' '
 	)
 '
 
-test_expect_success '--max-cruft-size with freshened objects (packed)' '
+test_expect_success 'cruft with freshened objects (packed)' '
 	(
-		cd max-cruft-size-freshen &&
+		cd cruft-freshen &&
 
 		# regenerate the object and store it in a packfile,
 		# setting its mtime to be more recent
@@ -304,7 +304,7 @@ test_expect_success '--max-cruft-size with freshened objects (packed)' '
 	)
 '
 
-test_expect_success '--max-cruft-size with freshened objects (previously cruft)' '
+test_expect_success 'multi-cruft with freshened objects (previously cruft)' '
 	repo="max-cruft-size-threshold" &&
 
 	test_when_finished "rm -fr $repo" &&
-- 
2.49.0.rc0.6.g7f120c35e9

