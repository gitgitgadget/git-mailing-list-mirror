Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9947CC94
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348680; cv=none; b=myZaK/KZFixtU9k8v8BgY3O7gnZERaHv/fFzRDtnKZeMEFhxsm99mc7JqqpbWq57pM9Jbb9qN/RgzHQsRx6UsI9+aeUVFQKWjTdglgrbgDUxdAmg73sTQJzgc/mYUPlS+/BsSjbTpZOpFtwNV2U3t4RW/Dsq9WLva7GVbeSarpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348680; c=relaxed/simple;
	bh=j5eKuqAUXjDbUw1d12fRmNLXff9tulh7G6arYnL+S0Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZbqOdFt54vXdvq3cSmgoNUSo7OeBrHZ1tMsClhpiy0oe8uUC9+Gwnrg/U7bkHWhNij63mnX24Bc94M7dRnL4TVBpATSd2rFu0dhEodqbqiDmexwI+ryW2raVkIewRYXz77baBGradp+hYhVWqKlZrMUj89zyFiQ1f8daHiETic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IcmFIOZc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IcmFIOZc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso872932a91.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 04:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788348678; x=1788953478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dW7Ledq7r45PnFtqWUzEXFe6sMCCe01yDpsJhB0IY0U=;
        b=IcmFIOZcNmUc0fU/1E4U1+m9qkAYqNyCgeW2zhZVMxVoYvRnYG5BDT0XQDhPpxLJ81
         tygX0OptNCi3CmybbKxgYReylD8p2Xs0wnjo9MKqq0oD67yFP9FsLIXqRT+2vXvGNvKi
         BNvUxRfU0x46LXmSBmwpMhiSyM58mExqNuIz2/jIiaBZsIyl2TIsin0clbguTBpmcPhq
         WxX3C2AHrnUFaQplIjk3vLzq6ktEj5p0yYNqss0UPxyzqFt1CwheNfwTLQuNnDsfaPWf
         8HlJ5OLeziO02oha1rvRUSbs880hQbHg7ZHAznvPV0sqlRaRVsPE1u03rV1Zvck7P2RY
         vUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788348678; x=1788953478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=dW7Ledq7r45PnFtqWUzEXFe6sMCCe01yDpsJhB0IY0U=;
        b=FtwFDDBR5rTsCpEUxSjRF4HnrHpr5Rljkajk98AACniUYFNWFqme/tbQ2p8oRvgVZP
         9XxRi4o0PdLb+8jJSSnP6lrM7FQO4xvd39pCJ7U56OG+ItJOcoLoAVFRqPPZ2BN3djVb
         TPmK68454t4fOeucBow59ICrLIKNdfYyxEqZvOu3bcX0+PqheCQaakxMfL5YNk1TLVgK
         P1aJY4jEAwOghMmPcY0n+tniV+dJfL0GFeMtVm7ikMKaYKcTJ0fPZYa8rXd7uMyNGVJn
         wpdpb99iybhlbInnp8GDy7fdcFDXBKBIcN86KEnEDKswiPCj6YscZEknHuiw6MziJY2m
         +N1Q==
X-Gm-Message-State: AFuF++kSrwhX6XorUMYwyf4dBxhtoecLsdIuHV4cNJgSFTWqNgkLh4rb
	GzwTElpsAmYfEGpZXb/OqWQmlRyzDVbQiEmDLahyfUeBazqTb6TXLrab3n53pw==
X-Gm-Gg: AYBFou2MaxBkEyo8oDtGcK8S8iFpZpI4ky7h01P5P08RL5ngJJKywWUoSvrel3EkbVT
	NmuEgz/B9Y3hO8PyCovkJ2ychqreMr5qdP5/nx9MWD5UHZeNvhD02Q+GoWp27840CbbjknY298U
	fc55MaXSYazKvXQQDhjW1HOr2WohZypcqHIWgc7fjmtvavrQbZ3D4GxEYiZjp4JwdrDkzHeN/UI
	fc+I25AEmzy0gADK0kw06xo72Da12qAvzOTyrTs45QqfhtXOb9DrQn59Hb4050cvgSL2lldUV9F
	7eW51gmYZ2T4uDAbHI++rJqE/QGggVzh2zVHdOYVJOYRgNjMsng8Vdeft46aWmOUI/qcQyz+8Yn
	yTIv8//uoAaTlhR088pZqi2/OF5ZgxBztI22H+k8NKtjmjNjNKSBtdoe3uultuxQ6cTFdGI+btl
	YdUupElkco9OuGN+ci38CSqXQTm1VEw61asKfV0+DuEN3kPFNrxMdgaH/jRyiaX80kmzCi64oHZ
	P1d6lAhFqe8EItzFXMVBtQy5hr2B2qdDYlZVfCErkxLbA/QgYqX9Ag+ggBfDNiExmw9fLqH6tX7
	ko5GakQYuyZ7gBjSdP9UbI+u5w==
X-Received: by 2002:a17:90b:1343:b0:380:f389:447b with SMTP id 98e67ed59e1d1-39aedf6ffc7mr6405200a91.11.1788348677440;
        Wed, 02 Sep 2026 04:31:17 -0700 (PDT)
Received: from ThinkPad-E14-Gen-6.. ([59.89.50.212])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0f2a315sm6179992a91.8.2026.09.02.04.31.15
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 04:31:16 -0700 (PDT)
From: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 2/2] pack-objects: add tests for keep-true-parents
Date: Wed,  2 Sep 2026 17:00:46 +0530
Message-ID: <20260902113109.686014-2-ysinghcin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902113109.686014-1-ysinghcin@gmail.com>
References: <20260902113109.686014-1-ysinghcin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for '--keep-true-parents' to
't5300-pack-object.sh' to ensure that:
1. Grafts hide parents by default during pack-objects.
2. The flag successfully reveals grafted-over parents.
3. It safely skips shallow commits (where 'nr_parent < 0')
   without causing failures or undefined behavior.

Signed-off-by: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
---
 t/t5300-pack-object.sh | 55 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index aac139e6a0..62b29c7e05 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -766,4 +766,59 @@ test_expect_success '--path-walk thin pack' '
 	git -C server index-pack --fix-thin --stdin <out.pack
 '
 
+test_expect_success 'setup graft and test repos' '
+	git init graft-test &&
+	(
+		cd graft-test &&
+		git commit --allow-empty -m "root" &&
+		git commit --allow-empty -m "commit_A" &&
+		A=$(git rev-parse HEAD) &&
+		git commit --allow-empty -m "commit_B" &&
+		B=$(git rev-parse HEAD) &&
+		git commit --allow-empty -m "commit_C" &&
+		C=$(git rev-parse HEAD) &&
+		mkdir -p .git/info &&
+		echo "$C $A" >.git/info/grafts &&
+		echo "$C" >../C_sha &&
+		echo "$B" >../B_sha &&
+		echo "$A" >../A_sha
+	)
+'
+
+test_expect_success 'pack-objects without --keep-true-parents respects graft (hides real parent)' '
+	C=$(cat C_sha) &&
+	B=$(cat B_sha) &&
+	echo "$C" | git -C graft-test pack-objects --revs --stdout >test-no-ktp.pack &&
+	git init unpack-test &&
+	git -C unpack-test index-pack --stdin <test-no-ktp.pack &&
+	git -C unpack-test cat-file -p "$C" >/dev/null &&
+	! git -C unpack-test cat-file -p "$B" >/dev/null 2>&1
+'
+
+test_expect_success 'pack-objects --keep-true-parents ignores graft (exposes real parent)' '
+	C=$(cat C_sha) &&
+	B=$(cat B_sha) &&
+	echo "$C" | git -C graft-test pack-objects --keep-true-parents --revs --stdout >test-ktp.pack &&
+	git init unpack-test-ktp &&
+	git -C unpack-test-ktp index-pack --stdin <test-ktp.pack &&
+	git -C unpack-test-ktp cat-file -p "$C" >/dev/null &&
+	git -C unpack-test-ktp cat-file -p "$B" >/dev/null
+'
+
+test_expect_success 'pack-objects --keep-true-parents is safe with shallow commits' '
+	git init shallow-src &&
+	(
+		cd shallow-src &&
+		git commit --allow-empty -m "commit_A" &&
+		git commit --allow-empty -m "commit_B" &&
+		git commit --allow-empty -m "commit_C"
+	) &&
+	git clone --no-local --depth=1 shallow-src shallow-clone &&
+	SHALLOW_TIP=$(git -C shallow-clone rev-parse HEAD) &&
+	echo "$SHALLOW_TIP" | git -C shallow-clone pack-objects --keep-true-parents --revs --stdout >shallow-ktp.pack &&
+	git init shallow-unpack &&
+	git -C shallow-unpack index-pack --stdin <shallow-ktp.pack &&
+	git -C shallow-unpack cat-file -p "$SHALLOW_TIP" >/dev/null
+'
+
 test_done
-- 
2.43.0
