Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C3318ED9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861772; cv=none; b=cXojfz+vmAxy2TJrMWhvZslPOWaR2YBBUtqQjalT2/VWQc6ZzVcd/9nzLnexwwnhS3BfoxIlZFjOD8OdMhtcDkIEQ7Al1qdSrf5aJRk/qcr8KRO0YteAJPjkb8D+IHQNlT9T4VpsVdVemqB7zw/pmYLQIzlYSgORfw4ctSef4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861772; c=relaxed/simple;
	bh=sHziz/Xf4Uu+xZG8sL4UpBSWzZCM5N0S7f//9tSpzcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJMbFFNLZmB2z4jD2DZ7HKZMtaMV4tePL9Ib4775czxXoE/DKsOk+hgX6b+52U5bi0S28gaXFak+YVtNFfMDu+PzyBowhMVg3GJVPxRS/RUrgP/WOj9palUrt/4/nOb/v9jSC4iRYediFjBhRkqfo6aT4SqAuZKrGknRJqCMXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BosCd3FB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BosCd3FB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso40715825e9.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861768; x=1776466568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=If2qTK2ZXOtbCj27dzH21fc3ca1IRC0ZR/vty3G37xA=;
        b=BosCd3FB02cp3bbJmg2BnhS5giQ0Tp+rmBalJaL+/JEuX5DxpYrvdEJyvTVZZqOF+g
         XgEZqPtJdNUHtwNkjFBYOZTEyP04MhJPKgwB9CV0Ehv8pEr9EUPpf819mVAyJ4jKtxob
         2NffbzewNN8d/ufYBrNBJI99fAGTm0p26Jwh9cgc5oZNa+OXAkpYA5g6EeMFjPegoaHI
         AAo+Xrs2SQ9cYixZVHLPhtH4wzaiMCp5OsCm3KGZ2vktFQLxrQ53Rk5W1lzfbIr52JAz
         YAL6Qnhq8QAE3QfFRDyanzTuvxp42NkhwAVTK+uJVQN7P0G+Q7FRooBC7OE9JGXPVV50
         goQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861768; x=1776466568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=If2qTK2ZXOtbCj27dzH21fc3ca1IRC0ZR/vty3G37xA=;
        b=dk4b6O1f+evVGWWnlzDtdRcsR8ytSksW6CIrOmaucEkjLZX9hA2MidR3seHBy7UaIv
         cKueVUW2MPdc4YvfZfVtphYAG7deS5eQpcaY78k1KmEJv9JfJMZujQg8jT02UAaCNjKE
         oqiyTqlm3SHsyTT9i+tjxWD/b7pk87Ehy7Z33H1n6yro3e6TMrUyT0Y9/HnxCAHGyUu8
         xvOHDXXNplFCn5UIv26Krqs2JZcK104/JriIKGrwwFazA2wH/BSM7xwSPwE736ntG1Oj
         +d588x6MuEY5wPXKKVuY9n7onph6GFwI/bqUFNJkFWiGMD9fND19wWTG7xthlTDZU/fQ
         pyNg==
X-Gm-Message-State: AOJu0YysybnnvCT8S9VXihrTFACXB+BOhN0TS4thd42pHwqSOjkyghY0
	gnX9goGFi0+VY/T6taRpSg2Lkyx+bwHziz5hMvXa27tlpNbCdfn9uoNeWGpEm6gxtW0=
X-Gm-Gg: AeBDietfOCU7N8e8uuy9UzR9OdT3FLkFeSBAxkCNyVbsA9L2hG6CyBiqmt8Rh3pBQjn
	3rExHYp2opFY/g26YtteNBS4xNdX5rhS1TyLEA1A+IMs2zCBYk1s/meFaV4Xn7MMCmmqwv46gSz
	0MhQnwwyhvP8oWiA6EVud5pgXyTrdf1ceCqqgVxRLbwbjZ3s7x1MTAe2rO6aeCakEpqeI2vd/DK
	N6A2ExRdv57kRkAk8nzEa1xrIMtHvr3zWwMuqmkgBnLvTQ/lXOcw+sWwFf3z06mYECVaQtFRPXL
	2kT6DDed/YE9/FNTeqeMkR+4KS3Xswmd4p1nUDDYJ6wkEco4joqaVd6H1wrQtYaHPMBRIz+HnGu
	mo7/QcsVhUuQ1nYOP1MkVyTBfK6dBFvba7/Bd1oUgACnty3GWFXdEDs2Ww0ls3OTAbtlarurDJx
	96EKlG4Hv4Jph+EyNPTh2YOSqR1WD7KaFh
X-Received: by 2002:a05:600c:8218:b0:488:a14d:3d81 with SMTP id 5b1f17b1804b1-488d67c7034mr78066465e9.2.1775861768470;
        Fri, 10 Apr 2026 15:56:08 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d58bb830sm105134655e9.7.2026.04.10.15.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:56:07 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:56:05 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 5/6] t7703: test for promisor file content after
 geometric repack
Message-ID: <ab307e68feb9f84898dba748ef1f4598b07fc0e2.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>

Add test that checks if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a geometric repack.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7703-repack-geometric.sh | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index 04d5d8fc33..a8e3e6ae3f 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -541,4 +541,37 @@ test_expect_success 'geometric repack works with promisor packs' '
 	)
 '
 
+test_expect_success 'check .promisor file content after geometric repack' '
+	test_when_finished rm -rf prom_test &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 2 packs with 3 objs each, and manually create .promisor files
+		test_commit_bulk -C prom_test --start=1 1 &&  # 3 objects
+		prom1=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
+		oid1=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid1 ref1" >"$prom1" &&
+		test_commit_bulk -C prom_test --start=2 1 &&  # 3 objects
+		prom2=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d") &&
+		oid2=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid2 ref2" >"$prom2" &&
+
+		# Create 1 pack with 12 objs, and manually create .promisor file
+		test_commit_bulk -C prom_test --start=3 4 &&  # 12 objects
+		prom3=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d; \|$prom2|d") &&
+		oid3=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid3 ref3" >"$prom3" &&
+
+		# Geometric repack, and check if correct
+		git -C prom_test repack --geometric 2 -d &&
+		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom3|d") &&
+		# $prom should have repacked only the first 2 small packs, so it should only
+		# contain the following: "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
+		test_grep "$oid1 ref1 " "$prom" &&
+		test_grep "$oid2 ref2 " "$prom" &&
+		test_grep ! "$oid3 ref3" "$prom"
+	)
+'
+
 test_done
-- 
2.53.0.584.ge8720aaf12

