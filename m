Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793648435;
	b=S5YjrOk+w0AyWASXt1K1wxs+o2GDvNIInNjbrlMMg8J3y4lzeEcronePeOqvaJAy93uS
	 cdJzucZgno9X4bPUJrx9v4UEhY2zwQM3G/2bZhqNLEzQErFuRtX986EwId/6jBrDVJHDC
	 fCis/NooKRdXOGWmZ2YDuA7NUxUAEfvKqpEv6u4JvPsPw4sLwj/pLOlHFZF2pmtCf+Vcm
	 wMKAvcxRiXW4hOI6s82cMcuOjyMwXOiYG5ZvnuZHD8D98A3Vk+NfW0YXyFY9N7V8EOr1Z
	 JzWOdS81lhXN/TrtbC7ArdBCpP020hZlqu4fo2QCPsF09ktJrvNXSDZGv2KAtKgCk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793648435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=DHxs4ls0hU44dtlCZ9Z9n20lCy4iSe0AGizmASKOsfs=;
	b=yXj6pxE30h3P4rNj1VIVYyRCI+DI966NmKaMbzVRcCbP/3lgpOa3wAPkt8Hcb6cmSnsE
	 YS8SqNChhnjyPcL6N5c6m9SKbN5jJXl8PT2p71Q5fHGF9m9RBojpQcYXFApZQkINWubN2
	 c/hIMCQc4pasaMGzhGgy5I28eg+nTnSlHjjxO7OKzSZkuOaI5oiSentXCiGv+CeZqeTmk
	 I68/pa/3cbtDcblUkEGs7MljnujOGCrw2ANxMeGXyt7eM1IT+FOxhlQsOruACmQLb0ALd
	 zE/c9mq1bab6TNMf2d9M1lu6Dd2cCfdR0p+WtvdYVtKKdsWW9V8UBlM38D3CrIkMb8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zqjRg/74";
	arc=none smtp.remote-ip=209.85.160.176
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926046082BE2
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 19:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 926046082BE2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zqjRg/74
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5363c8de563so42215111cf.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 11:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793648433; x=1794253233; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DHxs4ls0hU44dtlCZ9Z9n20lCy4iSe0AGizmASKOsfs=;
        b=zqjRg/74G8gI8G1Q+v4/MQlTW7SfS8EY739O5ALXr0nz3emWhi/AeRQbahxLum+dpL
         BMdwlhqWat538oFSi44pbYByrKElTMvsKroaBHbuhdErpBOQHqlJ215A4JxrswOk4KoQ
         L1ZIj6+dLnYFyZOGgKpkbvVRgvpjptaDKRnskj2PFnLOgjZXJNPuvDnLJCqJbv9zEXJN
         l31Uix+kfVtwbsgBBHIXb99TpsynBelC82CQM0zDz30YF4yK5cVh1nNNkof7OtLK/uuH
         UD7vTKnnb027kTB/ti92YuTo3d5wlCbGIufP/DMZUe40lxeYK4R0JOYvEkWJMSvhH27c
         PAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793648433; x=1794253233;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DHxs4ls0hU44dtlCZ9Z9n20lCy4iSe0AGizmASKOsfs=;
        b=24b7lc0+7ztWySmJjzRcXoevQ2hceI5NjktkZqS02Pi9ILJf5otPSXaWWXta++ncns
         jIhWMTbT0DrgWAJSINPVTicFTVX6ZkgqnB8SyUN8fxwRqE78lEAeWTngzqcopXrXSaaM
         uSkFz/2S41rB8ivZayeXrtE481LTVUqBVwvh4SU1gENXEK2D/hAzRHPvIs07ORmVXgMC
         VzAV9KkJH64Z9ghMCf8bQmlTUq5BnrVgPkE1dbLsDwhEfrsfrwBHSUYIOXGSnAI+ptPW
         tk23d06M94QCDcCgKJFCQUE869mm+niUtKuNwOICn0zxIat5m1KUIZ/oIiX58+err2vr
         ncTQ==
X-Gm-Message-State: APuU4Z96Iiq4b47NbI7Pa5CiUp7A3r+ECy7cW+uCFx2R2ghVfNWPHyE/
	guCKizAGA4HKh3DPh49slRFzGMsNzyzD7FW1MUHTC0EyKldFJpRDpL+BEpQxKWYq
X-Gm-Gg: AYBFou0qWjqnaLpxSRgQtMgMUk9w1OpDzcDcOr+2L1s5IxkYyfn2KzDpNqNDSJEiPyI
	r8QsDJV+J400C4AcGOQdsJ5zmJrfOuyNG6VM6g/0ecXXADmh472/5Z4OIrDhtW2ogGDeHUhRs1x
	8DKeiskuqYvqnSaAH66L1D9STeBortkAlsL9TPqqGlwYtgZEh6ki+8cp56NSRD3ihMPL0/u9lEO
	OKTPYIpyA9fsdONib4wfO917MbgxdkK46ojqjZbIhYy9HdlSsRBvHsARwIoHyb/El1/IRIVXymU
	ng7bgYLnA3Hp8eUTvpm495biYMNCbcI8sm9RLvSNa66b7TKx4zdSMbylV0BatSpqW/2/YzFgkbf
	nFNAmnrYOhas4CfU0oRB7dbELEFuW5wfKXq38tor75QAFRbUV0uFamGpzdaZ1NJU2Bd0Y0Zpgin
	1bZy4Vv5ngcThC944eYjNg0ogD1rbj9H91EO+Xz31mAN7FXyBIDGpfy7HxVJexpV+xYVq768aO8
	1bC9LzGDtB/1A6grH7iqGR45BvsUGAYzD//dLE0WgIpFoF48GmYHFyg00bVwqt3L4HBDZuKrpqG
	z5Ryxww3elb5+SFz47lq7P0P0ES30+qq
X-Received: by 2002:ac8:610a:0:b0:535:86ac:574 with SMTP id d75a77b69052e-542b66895a5mr181083751cf.16.1793648433202;
        Mon, 02 Nov 2026 11:40:33 -0800 (PST)
Received: from [127.0.0.1] ([172.214.47.41])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce1dsm5880401cf.5.2026.11.02.11.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:40:32 -0800 (PST)
Message-Id: <99a1234544840e63e6f3dcf3c6beae3ba02af84b.1793648430.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
	<pull.2288.v4.git.1793648430.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 02 Nov 2026 19:40:30 +0000
Subject: [PATCH v4 2/2] t4041: test SHA-256 submodule abbreviations
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

The expected abbreviation for a submodule commit depends on the
repository's hash algorithm. Use test_oid_cache to provide the
expected value for each algorithm and remove the SHA1 prerequisite
so this test runs with both SHA-1 and SHA-256.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
 t/t4041-diff-submodule-option.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index e80472af32..4539d6bba5 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -14,7 +14,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
-test_expect_success SHA1 'submodule commit abbreviation uses submodule object database' '
+test_expect_success 'submodule commit abbreviation uses submodule object database' '
+	test_oid_cache <<-EOF &&
+	submodule_commit1_abbrev sha1:0000000000e
+	submodule_commit1_abbrev sha256:24c81a5
+	EOF
 	test_when_finished "rm -rf collision-super" &&
 	git init -q collision-super &&
 	git init -q collision-super/sm1 &&
@@ -27,7 +31,8 @@ test_expect_success SHA1 'submodule commit abbreviation uses submodule object da
 	git -C collision-super update-index --add --cacheinfo 160000,"$commit1",sm1 &&
 	git -C collision-super commit -q -m "Add submodule" &&
 	git -C collision-super diff --submodule=log >actual &&
-	printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
+	printf "Submodule sm1 %s..%s:\n  > child\n" \
+		"$(test_oid submodule_commit1_abbrev)" \
 		"$(git -C collision-super/sm1 rev-parse --short "$commit2")" >expected &&
 	test_cmp expected actual
 '
-- 
gitgitgadget
