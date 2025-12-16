Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD2734D928
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885587; cv=none; b=H4f5nnF1Q2wF5/r5EKmDGO1cj9KQ0vA+6d80VF67xXUu198xKltF/JKEcU+/8QRUfoKsdn7CVVNUyg6OoVA+Q5WJTlfs0dxoAc2e+g3HYQAZcktegqLWVJEmK1qAX2bDNvR+UKukU79zQo1gLapLsC84HRk7jlx0D4y+0gco1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885587; c=relaxed/simple;
	bh=NJLyjStT8CtJY7u3JKMc79pbawme/rAuvso2pNsfeAg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=e8taFJzaGF3OMckzkdOYn3CP9MTKlg7sULjGNvBwXjhd+Lu/QgoKhWe6keM8G63MedbUyNbu46S6+BxN2vGsC/cZbxqSuLkRMuBea3kTlJ4eJz9IV2dhzKTRr/lIRv4dXkS+O3QWGXvbaS3x095b26dfFHoBAxsAXIVMwjCnZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B745yBTa; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B745yBTa"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b89c1ce9easo5169853b3a.2
        for <git@vger.kernel.org>; Tue, 16 Dec 2025 03:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765885584; x=1766490384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFx7qdVYve8sQ433qVfjcBYHpYa/9aP+lFpxSa9X+j0=;
        b=B745yBTaAah/H9F6sIPE3JE1EFzqxQkZsm3tQVov3j/d/rN7Wmf8qDSXzt3mUegfV2
         625fYtXOvQCdr5JmVh/QCo6OgzYAZ7uRviqg3De+bv/MpMwwSBww5w915Zbg1hkyOxkz
         5KchPG9OXP6bDv0moEAPgTNv0my0S3XOsSl3fsOysISSBsGp8Xwp2wrHK50gMm7C+WC+
         OYPxGsLyRThieHLwSmI77I6nFxiwVsjZ9mi95ZXMS3xuRMyjb4xapA+2ED99U7W3EfV6
         /tQvWA1eEfyzwdzeppAXZ8zVhHgb3GXP83ZpQie9h5vMCA6U5VLO76JmazbCXBFTecpn
         uRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765885584; x=1766490384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qFx7qdVYve8sQ433qVfjcBYHpYa/9aP+lFpxSa9X+j0=;
        b=UDKxxuI3kHAK+cJHFIK5bR3+qz0VW7YyLiVNG8s9bqg/PXgoFpyOSPjuJ6oi4i6xJ9
         S+jEcsN9M6v228JwGO9gpLTIG9WAli9cb6dt7HFT7JFaeaeuEQi5Ch6INLTD2bh4FUNj
         dDskzA20aYLQONxVkEs8TD5C6nfZSdGqlRICxV4+6B82Gdj08AptYuIxrNt7Xbe3rjGl
         ga5EeGNlE5AGZ26J+SApivwT9pBLE74gnrvBmLIz4/+3GYtCYVPNhBNGEcSlHci5EnsW
         MSOWyOa6tryribmeY9DV+PA1LwnjAzAb1rtaOZ+XAOxzDf1Zc0VXjwFBSGIw1xgqc3TT
         5SEw==
X-Gm-Message-State: AOJu0YzXY6Si+NZrhyr2Lcx5yPorjfqsl8UwzK8YrrekYEJFMavq3PPr
	5X8NGLWzdOUv7Nso5t3pDiYMoGHY9XKPkJ/fhtD5dpKJaKIv2DP/wUKneQxYyg==
X-Gm-Gg: AY/fxX4sGhbPfdP7CYjUtX+68/FTI+VeTWDiicVgj2ZpoqGFn+j7Zs7x08+Kr9QoZCl
	49RWxdQfuSMTNdG4pan5FveXopoLI1VTQfMy7rgOeAJunTG1IfLQG9mvArE/OyGDtOtymygSWSH
	9BrXbrP8co9YXZzQBo0Qy+8iinBTO/GHvvy7a7fqwqRf6aalaiR3nz9JX6hG4RfvFjxIp/+9nRD
	W/NVNKm+tynlWxgLVuWkit7GjytgK0oo2Q5ytw0hJA1vaUB+3X1GnXmRLbaSAKM7vmSCeua7YGW
	zkCJBQMz1tDe9r62WG3GkQqsc0GL2AXWhvg8jWGhwnoPF/97kl5IV9JkdGUMv9zc2+z5ic2x3ij
	DKroFS9+G9/URd4v+69myb/ezndMljUBPphFaqAty1GzS7vC4TDJ/17lPuWIJk3QA54rCJ4BT57
	928EXA2SsKVI/t
X-Google-Smtp-Source: AGHT+IHBGBpT0kMEQaJybYPbMAyXJSAf/yWxiYywsIs1wIUy4VuuiIpERLst5mQ/50I6J78W0bW02w==
X-Received: by 2002:a05:7022:e809:b0:11d:e40f:ee69 with SMTP id a92af1059eb24-11f34c1969dmr11543285c88.36.1765885584447;
        Tue, 16 Dec 2025 03:46:24 -0800 (PST)
Received: from [127.0.0.1] ([52.161.69.165])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e1bb3b4sm51415436c88.4.2025.12.16.03.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:46:23 -0800 (PST)
Message-Id: <70237394c64101b3d70a1d31bd4a763997474cb1.1765885577.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
References: <pull.2009.v2.git.1764946945.gitgitgadget@gmail.com>
	<pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 16 Dec 2025 11:46:11 +0000
Subject: [PATCH v3 04/10] t0001: handle `diff --no-index` gracefully
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The test case 're-init to move gitdir symlink' wants to compare the
contents of `newdir/.git`, which is a symbolic link pointing to a file.
However, `git diff --no-index`, which is used by `test_cmp` on Windows,
does not resolve symlinks; It shows the symlink _target_ instead (with a
file mode of 120000). That is totally unexpected by the test case, which
as a consequence fails, meaning that it's a bug in the test case itself.

Co-authored-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0001-init.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 618da080dc..e4d32bb4d2 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -425,7 +425,11 @@ test_expect_success SYMLINKS 're-init to move gitdir symlink' '
 	git init --separate-git-dir ../realgitdir
 	) &&
 	echo "gitdir: $(pwd)/realgitdir" >expected &&
-	test_cmp expected newdir/.git &&
+	case "$GIT_TEST_CMP" in
+	# `git diff --no-index` does not resolve symlinks
+	*--no-index*) cmp expected newdir/.git;;
+	*) test_cmp expected newdir/.git;;
+	esac &&
 	test_cmp expected newdir/here &&
 	test_path_is_dir realgitdir/refs
 '
-- 
gitgitgadget

