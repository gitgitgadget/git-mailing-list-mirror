Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FD36923B
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981139; cv=none; b=ERDEK23D7WzVpM8knb+K2LtzhqW1bESGgdNOCbx25VW4Whc4fBTwcpuvUBT790NwlivL72jzRdOaTUAXiGcDSw9GlRTO1C0gTV8rpCEDD5fAlwn/p2xf6JiTLJ4ZGytnIrqVYecdKO3szKtEvT5VEjAUSSYQbU7gw7CORyv29zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981139; c=relaxed/simple;
	bh=FmZ1EmmFxNcMpg7KM7vErvr9YWR3QeIOBWc7lA2I9mw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Oy2k+hn8Ov46nP+mDm35cd7rSxNcaGsP3t10uYfADECamAUnQPOu7LDJnZcYSc7uM8fCoIYWUGfeK7E8wCqpb3fYCpp11vt3wyDhQc/W742vJT4H50LKfDoLc/ooWZy9PuIRmf+2aznkWEo4TOlNjt6h1POER9yFoBQVYdlW8BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AiC5p2/M; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiC5p2/M"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c7660192b0so4115491a34.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981134; x=1766585934; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jln5oKLuVcu/8Peam3zLKYxnxJWWhgAblJ1HPG65xkM=;
        b=AiC5p2/MZswo5Myo2VzgBMYLO2VW3tP+hjWj7uDdeVMYksjzgu9syliBu4t/uRLlXj
         NUEfCPZEeDNprfmwSQzux8lD0JWYVy2giC5aKaZR29cluIefuy8TARSnrG2fR971YbEd
         aVx+8eyYU0EGB3JGXo+btizL+KUNUcVo304TfOYKkLNhaCwfQZgTaylH/T0jClV2wI5P
         pUWnqmbP4veKkH1dpZLbZwIoDbP8fHB8OLKBm36km+Ou/YW9qWJCKI0uqaqlMRQwtsXg
         FT+hP3Cf5llraksY7Sr4G4LG/yBbRW3NLB9o8ZH/y2AjPzkAsLY/Y096PghgcASU2vsE
         bKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981134; x=1766585934;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Jln5oKLuVcu/8Peam3zLKYxnxJWWhgAblJ1HPG65xkM=;
        b=GBGGXEWLb0M8kQB1oQcTfGw+wdfYdCDPFGIVbzq3hr0ppMSb/RUxRSrUweEetYta14
         ArFNGe7BSKdk5YAOK4R4btqN729yRILTeYVYTMgm3On/zcWosGpCrmA1wN60xYNhXLCE
         yP4M6HORL49UpAblBMNJJIA2c5pxbAwl2+CFeDCpxgX0rmacPzq31GhCrM/9oDv4oOu2
         8CqH0NErMbWhxLrcmgyXtHl1c5sc6X68KRW2+J/aKWU47R8CmONxLzB5urJ0sF5WwVT9
         TR6mFQTTl8GTbDni7/abImnJKihj63rPZ42PKCU7ZJ1wL3hTvQBMHohUTMf5OBCAkqH8
         y5jg==
X-Gm-Message-State: AOJu0Yx0GhusmBTHP92s7z6tjdr3VFY7CEr3IHf0yt2LoZjQk3MjStHw
	mJwdOcHMJ+IB/heSRjQ6r7mkrorRzzK1U4mNWCkDZBXrSSCUmGA4HGlLkS+164DUpA1IhQ==
X-Gm-Gg: AY/fxX7F/xgUbW0AUaRfUk/iA23NQQfrLP6HyZLuy1Y+xgY4JPub3FLXjTFdnJmVL94
	d7pY/2tCrUjaY+HvCsJWDFirOumdvv2Bhcb0nEfzK6UMdYdg7Yb2xtr5FgNXyshSbWKL/z4J1Kg
	APRj54CSzhugdcj3sAYCI5jPQX/PyQAMCc683kyI+yNxo9sG4dWwRm7ubjyc3vIqdlaLmfUNOzX
	dnSnzTxtNmGSIQ5TzldrKfYmrcQHZAjmPCyIAhyPmBtjPYlKBDXZvhMllPLySqzZ5FjmX5jfKdS
	VPlwEjBlLrbevYbWf8K9utqWZ8Z8+y/1FCNujr1pRRgQzlUOUgurmnUBYQwhudTYelDyhHi1wzQ
	YZ0cQWKxSv9FOM46Xb3bMaOMKFGu32+I4s5gmFT2L2/OhXf0pPGL6r+Cb9pgMmSe9EIRqG9i0w/
	30mwLLQfhi5zqbisasNSPvpBQ=
X-Google-Smtp-Source: AGHT+IH+q1YqO2enpvgehYRXmFFMui5Ix2IJPBXwguChJfPDzGzZJIaJNAF946+zF7r+ZqLqvkZ2SA==
X-Received: by 2002:a05:6830:6d9a:b0:79d:eccc:96eb with SMTP id 46e09a7af769-7cae8364daemr8206244a34.26.1765981134401;
        Wed, 17 Dec 2025 06:18:54 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cadb34577dsm13572643a34.30.2025.12.17.06.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:53 -0800 (PST)
Message-Id: <0d371ee552a0fd8aaad9e94c3a7477823852d25e.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:41 +0000
Subject: [PATCH v4 05/10] t0301: another fix for Windows compatibility
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

Just like 0fdcfa2f9f5 (t0301: fixes for windows compatibility,
2021-09-14) explained, we should not call `mkdir -m<mode>` in the test
suite because that would fail on Windows.

There was one forgotten instance of this which was hidden by a `SYMLINK`
prerequisite. Currently, this prevents this test case from being
executed on Windows, but with the upcoming support for symbolic links,
it would become a problem.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0301-credential-cache.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
index dc30289f75..6f7cfd9e33 100755
--- a/t/t0301-credential-cache.sh
+++ b/t/t0301-credential-cache.sh
@@ -123,7 +123,8 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
 		rmdir \"\$HOME/dir/\" &&
 		rm \"\$HOME/.git-credential-cache\"
 	" &&
-	mkdir -p -m 700 "$HOME/dir/" &&
+	mkdir -p "$HOME/dir/" &&
+	chmod 700 "$HOME/dir/" &&
 	ln -s "$HOME/dir" "$HOME/.git-credential-cache" &&
 	check approve cache <<-\EOF &&
 	protocol=https
-- 
gitgitgadget

