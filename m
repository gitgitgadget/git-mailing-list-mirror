Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C0254AEC
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 18:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752605879; cv=none; b=pIQjA80k0N9dqNK9YEYGHW5m58quTOp4Agdq+rCQ5qIWYdh2PPIWL0rjpxkkqsyAmAEa+5Aj/ZEpYJleef6ZDOHES8B2QAiVAhI5Nr+XVO+IU9St08qlDUFmQOPjzM6lCgO5nHpEuQfGcICSOf0MnxipGpGN6iucoyl5FkRQwBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752605879; c=relaxed/simple;
	bh=EOQcYX/Vsp1m0NKzn8xnWhDCV7hXDmvdvNtHUKcDQho=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RjymHT24sbsQdofnZJXJCl/Dn+MWi+JOPHCBpKWfK0BhlylmeDlPYZ0SUVrWKcW+SmFU0EsnweEYlheXZcvbOyCxK78545h+VbkUAzCcAHmqbdCTKKSan/0RhtVLMLmLEcyfPneMqN7qLBAHOP3eA2gh0Tg7eRJlR9/vDd/y4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hm+UhP3a; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm+UhP3a"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455b00339c8so31530585e9.3
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 11:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752605876; x=1753210676; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/EpvfCgoSBoUKKJ8IZ4lF29Fxv4+p4Vmrrj212oiF8=;
        b=hm+UhP3aeMPn4Bdsh1xOCNipkihuwlNA7UboFvnl4TVWIW6DVv6l/LdfYX1ijNBqJo
         x5bsSm6TOYykQp+43TT0Y0ijPPKisu9UKpy1qUSuIKbCOK0y/I57WCqpj6htMrvv/jiI
         UPSXV+PqwV9LwAd7DAxkb3jq63pKwppREAMFwrsHvFnQKOLonFg2naZALZRcDtAXMy2t
         R33vB9lG+bQPqQqlotLVbEzowFMSJrhK8nSI+FS1NuE2RAm/lrGw6i3hqITIZraigUlx
         ne1xpqChWlWra3g2KuAfu27dRcZY6wuYfaXG6/b2XealJFsMVcFkGZRogZKPe5ub/2bM
         4F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752605876; x=1753210676;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/EpvfCgoSBoUKKJ8IZ4lF29Fxv4+p4Vmrrj212oiF8=;
        b=c5nhuxOv1BXXE9A0IEBw2w40ZzgdU28CFghcYmzkZQAYq3aYgNX2+N+xaoRnNXZXwP
         xefJzAkr1McxOnI4Wj6Rx9zgkhY5LTaWLnX03jzYyXD6nWHXdJ/ym1oYs05rkRh6q+eb
         wKdYztyNVnuSDjfoKB/hWRklJPx+igasmH6GusPukVWDTw+WVm+nndH0U81F+7kFuyFY
         vUizciaaRMnrAR2BVhL53TdD9QlFMmmL4Gk9pA3EDCtsArLGAg5JwhGk5pdgtSBlAwot
         Hi/AyeJsAr2YFwVxbm2oU1eUBu47N9TRfIci/pLWNH3zjMoCPkxlFggF0bSQJ3kGBNpi
         65Hw==
X-Gm-Message-State: AOJu0YzvaECr1jeZa9n+icZRzUW6/tzIjWGMLNd2e8F43O0eGw9b6dKl
	GQfpbtBQlGA1KPQ7OSsSWUeijRtyEZoVAGilYAbKPb36vmmIu8+bdWkUWbBtOA==
X-Gm-Gg: ASbGncu7Ee+hV7U2Yei2GihTs81CjpBdAy9SgDzCO0vJgHtNACSaS9uHnQhuP7inr7L
	NV9dScheQGm6sccqUMTC05tzkYZZSpsdgSDPmFR2OJtthvhWq6LKNm6uIOL/dwXxGLJknT/uR1O
	cFrlgHRSfedjQ8Qm57usprVPHJeIoJyCtBuD1C7bwFo0WQhHt3G1/oclQ0UD3Woqer2oDp4uv2s
	D2rd2vB1kVmdjqkQ1PYkTsCNnBrf5cAOC+5O4FBJTZJDerHFnLrSgMKj+jzLL7rHOnJ2ywyDetI
	GUqzRPh+ep+VtKsUk/DF46cvifwOkp9uYy+4vz4T5HwRP+NgqkaC8+qMo//jRhxS30LO5DeFfLq
	qR3zp5hMjzFAwdhhIPGl6NZM=
X-Google-Smtp-Source: AGHT+IHRR3fIrcKZOURV4CMjN0TZNSiW80PlcaSoq5I+LX6TsMJASWWqPuT3CXgG6QCDB8XJWxaDEQ==
X-Received: by 2002:a05:600c:1c0b:b0:456:1006:5401 with SMTP id 5b1f17b1804b1-4562e02fdfbmr552565e9.5.1752605875748;
        Tue, 15 Jul 2025 11:57:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-456172f3ec6sm79764185e9.22.2025.07.15.11.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 11:57:55 -0700 (PDT)
Message-Id: <pull.2011.git.git.1752605874596.gitgitgadget@gmail.com>
From: "Kyle Lippincott via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 15 Jul 2025 18:57:54 +0000
Subject: [PATCH] test-lib: respect GIT_TEST_INSTALLED when querying default
 hash
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
Cc: Kyle Lippincott <spectral@google.com>,
    Kyle Lippincott <spectral@google.com>

From: Kyle Lippincott <spectral@google.com>

$GIT_TEST_INSTALLED can be set to use an "installed" git instead of the
one from $GIT_BUILD_DIR. This is used by my company's internal test
infrastructure, and not using $GIT_TEST_INSTALLED when querying the
default hash meant that the tests were failing because the hash was
effectively set to the empty string (since git didn't execute).

In the two places we attempt to detect/execute git itself prior to
overriding everything and putting it in $PATH, use identical logic for
identifying the git binary to execute. This also has the effect of
including the $X suffix when querying the default hash, but that's not
strictly necessary. You don't need to specify .exe when running a binary
on Windows, just when testing whether it exists or not.

Signed-off-by: Kyle Lippincott <spectral@google.com>
---
    test-lib: respect GIT_TEST_INSTALLED when querying default hash

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2011%2Fspectral54%2Fdefault_hash_respect_git_test_installed-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2011/spectral54/default_hash_respect_git_test_installed-v1
Pull-Request: https://github.com/git/git/pull/2011

 t/test-lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 6dc2022ee10..621cd31ae1d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -134,7 +134,8 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 ################################################################
 # It appears that people try to run tests without building...
-"${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X" >/dev/null
+GIT_BINARY="${GIT_TEST_INSTALLED:-$GIT_BUILD_DIR}/git$X"
+"$GIT_BINARY" >/dev/null
 if test $? != 1
 then
 	if test -n "$GIT_TEST_INSTALLED"
@@ -536,7 +537,7 @@ export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
 export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
-GIT_TEST_BUILTIN_HASH=$("$GIT_BUILD_DIR/git" version --build-options | sed -ne 's/^default-hash: //p')
+GIT_TEST_BUILTIN_HASH=$("$GIT_BINARY" version --build-options | sed -ne 's/^default-hash: //p')
 GIT_DEFAULT_HASH="${GIT_TEST_DEFAULT_HASH:-$GIT_TEST_BUILTIN_HASH}"
 export GIT_DEFAULT_HASH
 GIT_DEFAULT_REF_FORMAT="${GIT_TEST_DEFAULT_REF_FORMAT:-files}"

base-commit: e9779f64349fbcc8d177d055208039877316e652
-- 
gitgitgadget
