Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BD3389105
	for <git@vger.kernel.org>; Sat, 18 Apr 2026 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776521842; cv=none; b=A2sSm6pIBASn7CmM+3xNts0/p+6cmOQ2ukE2+o2vijaqiAPBYWMFZXpa6Nhvoy5tednd0O2N/1aedgzvk20Kz6vdLGUNzXRkCAcOebfqy70I2Khm5PszGwDFLG2vtEP+W8ssJtMsMrGyLysnyWgeJOI02sfIn0//NFZUe4cjbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776521842; c=relaxed/simple;
	bh=/Ok9OQUE+T6O9RtntfsfN2UW3+Vh4cPIXQkaiI3nkkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLpi7QAwjl9NKbcorDzddsv4tYFrjMOJ7ORACYzvhpo0zugbRul0PXS6O5oh1bIC1NUiy9idpesneqDp4aH2+U4OVkt1qBNkvOpxYXKRiWNjMy/hIDHGq6HxsS6uDb2BxuVbTRFl7bi/GJaKS1j2GxcdayFD4mdoY0FYQV5GwYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B8krz/WK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8krz/WK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso22319955e9.3
        for <git@vger.kernel.org>; Sat, 18 Apr 2026 07:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776521839; x=1777126639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x9XBul9fkOLAgOhHZ3hGObcidkInpbR9yX3Yrta6zBw=;
        b=B8krz/WKnUfyrGGv8QFd4jpWARqniwLLvZQb/dVrrM85q6KDngIgsA1Xvdyba86C5s
         ynLvOE23Xkw75++nBrF4qi6Dd43YNmtWJr4P0mazwJEhZ7bmUqJPwdEF5yDJZUsYW/DT
         OTi4aIMVFhTU3G8qp37vb3senoyF5Lq0C51pu/365F8ovmEfSbVV+srsMhbugWVoa5cY
         grms8ntICz6fSVnIw+usP9UNZAB8OarSmMXbiYrwfGnMU02DjzUWTQvt16jfGbzjU9dv
         Asckw88yEzC9hymFl3P18SasV3yxCb+161CoBsuN9h5GV4hF3+jwndPdrNjGVMAH54HY
         wHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776521839; x=1777126639;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x9XBul9fkOLAgOhHZ3hGObcidkInpbR9yX3Yrta6zBw=;
        b=JT+WI4eAjAIqc3B7rbaA6Z/IYiGLW8KSzqxLJtl3jijPTqp3wyLc+GhOSoYbM6rb/c
         3ramTGulMj69mKEVg8fworEz29WXYRKOp8+cYV1W9BRZb7jKP2p3WS97TzvQn44vpdR4
         0Cijxssi6IqlG34QV0DV7SuCmD5HcJr4dTBDP7OMF0iALQsps8OjUeiLxfylczj69YGC
         UtfJsbb2Sc5OySzyl61gaj0BYeE5S9fiBoHPOdp1OY7nGU0CWU+M5vzhfv1kdRZj1J3z
         TVjfqVxXwM0FjJ34uSE5+Vaz7eqttrF+o3Jjm1oxlr8RE4Yv9TMb3ZJUnJrcLd5PY5W9
         bYUg==
X-Gm-Message-State: AOJu0Yw6JbnLfx9YcC+EWczCEortg9yJGajU+ggH5P/wHuLgrO7c8k6h
	3gooTBhF+RK4rK+t3DzjiK7BPdlW1R/iHYBc9EDYCJXlnbzBzpgein8q79DDQA==
X-Gm-Gg: AeBDietKggK25Z8Mvy/00So+RVCxdGfIPAp4I6kkVv99qHvlGz90PcEq7rQLgeiqG8d
	tn8M6Y3z1Be8LLgxhb+bK+6ssgsJlptRUV68KkUQnYcwRAWom4jVbjChYN3HIEFvFPyISo1L6JG
	2VBcRRYmI+IaY+tR1qOW/aPSHTGexWnM4NQ0pJzOdPqQ7aq3J+dDD9w+guC2dFi8LFlrt8AWy3x
	zqmodksyIqC66uNUHNwnZjT5vL4llrx6pdy7ycshkUtST8AbBHNDpr1LKGtZGfpJUWOpuNRPVyn
	P8DxN+gyogMLsp4oX8cG8aMJWplFNWeUwAksUZZW+TbyaJaVGUgABRFHksVmuUHmLTsjk+rJ15O
	V6NoqCmpULPWtGHLkKdgRnxMxSfQ++zO/c4QlFV1VumjdI0WvVqjTV3QDLBLmkwpC9ASN8IqRX/
	Abkc3YjbObslg9he2/Rlk/7Vl2fjGFSogW/yK1j593pQXg0NSvwIF3RMrmdIKZ7gkswaqvXmaXm
	tfhWkOaNkJ91HA6RmY=
X-Received: by 2002:a05:600c:350e:b0:488:b811:51c4 with SMTP id 5b1f17b1804b1-488fb788231mr98299165e9.25.1776521839214;
        Sat, 18 Apr 2026 07:17:19 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ffc558f2sm59910295e9.1.2026.04.18.07.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 07:17:18 -0700 (PDT)
Date: Sat, 18 Apr 2026 16:17:16 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v6 4/6] t7700: test for promisor file content after
 repack
Message-ID: <3a999ef230431473f5b79cff8e10ba0c1f072056.1776384902.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776384902.git.lorenzo.pegorari2002@gmail.com>

Add tests that check if the content of ".promisor" files are correctly
copied inside the ".promisor" files created by a `repack`.

The `-f` flag is used when repacking to ensure that all the packs
(created with `test_commit_bulk`) are repacked into a single new pack.

Helped-by: Tian Yuchen <cat@malon.dev>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 t/t7700-repack.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 63ef63fc50..1decd7520a 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -904,4 +904,65 @@ test_expect_success 'pending objects are repacked appropriately' '
 	)
 '
 
+test_expect_success 'check one .promisor file content after repack' '
+	test_when_finished rm -rf prom_test prom_before_repack &&
+	git init prom_test &&
+	path=prom_test/.git/objects/pack &&
+
+	(
+		# Create 1 pack
+		test_commit_bulk -C prom_test 1 &&
+
+		# Simulate .promisor file by creating it manually
+		prom=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/") &&
+		oid=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid ref" >"$prom" &&
+
+		# Repack, and check if correct
+		git -C prom_test repack -a -d -f &&
+		prom=$(find $path -name "*.promisor") &&
+		# $prom should contain "$oid ref <time>"
+		test_grep "$oid ref " "$prom" &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cp "$prom" prom_before_repack &&
+		git -C prom_test repack -a -d -f &&
+		prom=$(find $path -name "*.promisor") &&
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
+		prom=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/") &&
+		oid1=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid1 ref1" >"$prom" &&
+		test_commit_bulk -C prom_test 1 &&
+		prom=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/; \|$prom|d") &&
+		oid2=$(git -C prom_test rev-parse HEAD) &&
+		echo "$oid2 ref2" >"$prom" &&
+
+		# Repack, and check if correct
+		git -C prom_test repack -a -d -f &&
+		prom=$(find $path -name "*.promisor") &&
+		# $prom should contain "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
+		test_grep "$oid1 ref1 " "$prom" &&
+		test_grep "$oid2 ref2 " "$prom" &&
+
+		# Save the current .promisor content, repack, and check if correct
+		cp "$prom" prom_before_repack &&
+		git -C prom_test repack -a -d -f &&
+		prom=$(find $path -name "*.promisor") &&
+		# $prom should be exactly the same as prom_before_repack
+		test_cmp prom_before_repack "$prom"
+	)
+'
+
 test_done
-- 
2.53.0.584.g6b87e8e9dd

