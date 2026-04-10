Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5253D646D
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833467; cv=none; b=H9CqfyDugH97yAScYpaa30gbRko7rjKMEkpYJLMrPL1Tpmz6UBbyHcZOg5XlrjXuiSI7F7eQmPBRM+Sk1OaQ4PIW4cpumL3BOQzamFe+i9ffuWSFc6xf3hx2njfdHOrK7uwlgvRxhNWwSLO1OI6SN1I0s1gyjINKL7cpUD08jF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833467; c=relaxed/simple;
	bh=bHZ2u+ighV2Hg2+WYrOEjAIkUxzzjkbbbf2TdUxobFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=do6OIOB/PC8pxjhZGP9YVTBkO3Chv2eZHYPeZAV3eXLH87KNkSAprfQZFZ8Xbi49wq5JRasoQQFOg/pCMNegfCeDokMIxc3oxhRcVgD+davKZZDeAdMXE6D0COs4MbNbZLRN0B5+IW+rplTHf7CbNDfT8KZxlEiK/JS6f4KSmz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAybcu7t; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAybcu7t"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so27633625e9.2
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833464; x=1776438264; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlVSkwokbNpEL2Oo9az0AwqipuPSQ8CPKMp80X5+Nq4=;
        b=AAybcu7tihcm6d+qpA8AS5ObdMFKsxzrtq/Rjg+6eNAa22ZM+C9nOYt6oBotsNnrWE
         JA+JKg/G8i+oKPS07e07CNgCJuUqCtLqIUr5Djs92GVipIS035z4fBj3j2LOx9xyLXDb
         7I96d5wsNOeS8ZU4+p79z4I6v/tNoECPtSu9JcjicHhzusux4SJ2xfxJPY5dNptZz7Zx
         ZP2YA/Y8IldN9he91wCvODXReM9RKGgTkgO+iCzrBJSu+QpIkedbkpbjMQ/S9AS8Qq6s
         2VatEc+V7c1H1yz84kAxxPHJ/14EgDhqX2aBgI7wR/rq5uaJFdbJelJ73HUJeQqDj41c
         TGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833464; x=1776438264;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlVSkwokbNpEL2Oo9az0AwqipuPSQ8CPKMp80X5+Nq4=;
        b=df0wvHUxWuiXt3ivaaUeFTkizDA+fqIbOmnaXIOB+nk5jjvTmw3yc07KkPkA+dPWou
         T+GR9itdJgCaRlCf0Y/GxH0TjPTe7iKNphViDJ3n1NjVaoSYu+qL9ft4weAWH9PnTHm+
         7OHQak3ooT8XA7uU/6Z59Ygs9YieKsFzN1NLHO+/79lNgVIYEy7B0RfjzjP94p9CYyo4
         ps4EqPWaiUl8qdJB4PtSzf+L/DeqNQ05j8JDboidja3V2u/sLhuGvZAmv05cidKxlaFg
         tfwrLnVfAKZzRJN4gyFkht65+l+Zz7Ext+dkmLuPZsibyjaiZaugxHuTQLLrmzG+PVOg
         y5GQ==
X-Gm-Message-State: AOJu0YywXNV9Xeznkm62seXX76An6BU9uNpK1orP9rZsYzd5D/axIjt/
	oLbGL5RZFdfNNflWgRwkqVmT0MvvFfTELA/3yVyT5hidH3leSQDfLPozJ/2c3W7APk0=
X-Gm-Gg: AeBDievPa5SoF8EqyDdLE/UY5P/nILN5jGJC6jl7yMl09/CIq7Y99GATXG7Zq7buSDR
	0MRu1jr4XizS0zI1O4AYh1sQF50nBFswGuw55ixaEKIXg+P0jVchXdfH8VIVxXlu+Bv/gPZhWJ6
	g2RYOLRVsGBN6wXFm3ARcbfjviuVoBkXc7eM0k65NvnhnmHg8MJOQp4YD9ZRylQnCwxvlj/0j2H
	9eFQjVpuaHzup6IKtswP3C+eHizxSSNlkcqNiM30trbNfsqC3KTDwpoElqiyHczWZ7+8eJVwAgi
	iKCKLXohbCqmYFCeKEWFi4m/5vT+8MH2rjZdhSk3zNcVQMMNVZWULC0ItNB3z3NIoOWLM37Bexp
	5enoboMmx06hAu49Lv3468iI9Mm8FrKlrFXI3k8ZZFlUfTbAavUOSux4eUtakCbp7X1TB+6bNvl
	mf5Pzc+fv7CHi5V1e9NquZ6qP6b3hOgyexHH9n/WQ4I38/E4aAnGTfxdA30Tt0aVGCujacbMzS2
	rCtsUmXoINUKpUnndM=
X-Received: by 2002:a05:600c:19c8:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488d68ab2ccmr45176695e9.29.1775833463760;
        Fri, 10 Apr 2026 08:04:23 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5734a94sm73051605e9.0.2026.04.10.08.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 08:04:23 -0700 (PDT)
Date: Fri, 10 Apr 2026 17:04:21 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Patrick Steinhardt <ps@pks.im>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Tian Yuchen <cat@malon.dev>
Subject: [GSoC PATCH v4 4/5] t7700: test for promisor file content after
 repack
Message-ID: <0aceaed480b990abfd981dbdd696ea53a2238e1a.1775832056.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>

Add tests that check if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a repack.

The `-f` flag is used when repacking to ensure that all the packs
(created with `test_commit_bulk`) are repacked into a single new pack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7700-repack.sh | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..186a931ea7 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -904,4 +904,64 @@ test_expect_success 'pending objects are repacked appropriately' '
 	)
 '
 
+test_expect_success 'check one .promisor file content after repack' '
+	test_when_finished rm -rf prom_test prom_before_repack &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		test_commit_bulk -C prom_test 1 &&
+
+		# Simulate .promisor file by creating it manually
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >"$prom" &&
+
+		# Repack, and check if correct
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should contain "$oid ref <time>"
+		test_grep "$prom_before_repack " "$prom" &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cp "$prom" prom_before_repack &&
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack "$prom"
+	)
+'
+
+test_expect_success 'check multiple .promisor file content after repack' '
+	test_when_finished rm -rf prom_test prom_before_repack &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 2 packs and simulate .promisor files by creating them manually
+		test_commit_bulk -C prom_test 1 &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid1=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid1 ref1" >"$prom" &&
+		test_commit_bulk -C prom_test 1 &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom|d") &&
+		oid2=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid2 ref2" >"$prom" &&
+
+		# Repack, and check if correct
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should contain "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
+		test_grep "$oid1 ref1 " "$prom" &&
+		test_grep "$oid2 ref2 " "$prom" &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cp "$prom" prom_before_repack &&
+		git -C prom_test repack -a -d -f &&
+		prom=$(ls $path/*.promisor) &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack "$prom"
+	)
+'
+
 test_done
-- 
2.53.0.585.ge25071d955

