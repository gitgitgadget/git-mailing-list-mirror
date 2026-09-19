Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CAF3A641D
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819949; cv=none; b=tcSc72ce0hWOhHhY5SXlmVni2s8mU9pzvL7/3P2HRRXItN5ushV80OTNTPeqFEGrAAAjCuzpZpyFMO5rxi2cNw0X+YDXHcPluhIuLZ6Jh9Z1QEOvostzhgDe6cO8Pdfqpg2TlBxK9x1MnOXvCQGnL6BiMZ/5EyGif64nXauNKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819949; c=relaxed/simple;
	bh=YvHSfW22iuuILE7uRkll0AfkLOEgCBgktYTQFh/K2Hw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GgQ1k6AkVqtG6C8lUhtla/10/TBo+l89iDS+mPlQLz6TtcJdAW4yV6B9cpAjmLn88EpBUlp8ZLfvqbzLNY3DEZx4bVtRxiYnVNzrataPgYkDYcFg4pBtNzU90D6l1EtbhQkWdCOehWcwAAT1Wi6dz2RdY+naIX043A+Nv1j1hZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M68Ef1SA; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M68Ef1SA"
Received: by mail-oo2-f40.google.com with SMTP id 006d021491bc7-6bc475ffcf6so764118eaf.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 05:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789819944; x=1790424744; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KRS5SWYMGVvjBrWtqBQdv/BIBtxuDkMCtkx9x7QgPcg=;
        b=M68Ef1SAOCDW23xmo8Nl/2l9S/zIHYivyY5aeERQvZm/IzFXzYY3jlbh5RvhuRG3rE
         ysYD1I6MaMg8LVJOq0zB9TBkJw9sjgaLZIwZWQKgcG/C8amFVRYyO5gXLAQT8XB4fOU0
         ZHxvrtRHlf34AjBS4jG2CHPlweBtWEiFUAhbtLntseZIbv9A5s0YOFuXSGBY4I2PqXBr
         5D9GE1lT1mxx/1vxTLCgT75PKc8vBVxF7qSy/ziGuu+3PWalPNN+nj48GFj34RKWX54Y
         fzjqCR8h9NJA16MDtX7MEYv3b/N6t6sFi6AQ51wvTHvMDpX8Koqfsl3Fd1g5uZiHXTlq
         Yr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789819944; x=1790424744;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KRS5SWYMGVvjBrWtqBQdv/BIBtxuDkMCtkx9x7QgPcg=;
        b=hm7RoT8U7LaJ1wJXY05YOa0nNUnJV7klfsNaFEbOpGlCUBoONsqoR0yOW3ENOdkXtT
         eiaRzTalz02UfcUjaZz9E1rKm1lCqrMe5swDE98u3Rx9gedRZU/1AdqZcg9hsVl45VNW
         mo+8xpw4K1j+E+7oCzvtxUaDK+cVH4w/LuybMDtFIdi+uE629bkeIiZAya1PMsaJlgen
         XaA6DPn+Y6efKtEcVfR8xLCVSnCT64FGwGaNzkpoyPcjhAAvShlh0MLGKhY6kSIiqHL9
         ZWurRQ73yio9p/NS/RfT59q3uvH5jkbdo5i8sm6x8BWTaktlDDw3gqWVt7bkQ5MMNPIS
         Z7Eg==
X-Gm-Message-State: AFuF++kqpP5369bvX6Gi6ZT2Jenn71nPjjLncy9b+/mdRzchEutBhK22
	Kt8WeXnGY8UpCfhfdYNbDiS51Mq1xDAcY+VjVt9+3MiNw0p1puU5F8pzXZAcyg==
X-Gm-Gg: AYBFou1UeAe/o6eMkJXEB03xCoI3MydtYHEk4AszvHwSZ9obOf9Ik6xSlUSqI++aGgb
	VKlRcja9uFTyPwIfo/x6NiC4l3wFbiA5THW1xWj5vYCbK6niwVOpK2EewwLOcMXSU59LGQl1Rzm
	5q0Xj7aN6v+Cm8kSHBGIqs1oRiM/EkhqDfezypE/DIAMyXHEpK7lYqOTQW1HxUQVO9HZXr9Mbd3
	SBd3w44vfISDIy/YPwHmhJImNv+RKH7kv+qy33t/w9ZOV6mehqOVxF1ZopvfSi2BqfK0e/vT0nW
	LLdNRdRYNQzCWGkoMbf5A15JbKGrqAU8qkCCjA3RABMdxFi6hTurEnFZVQhVSkPhmzb8k2jFVsE
	xkiwAqb9VKSkvGB+zOGcNLUw2pwt4eyfgJWp64koEY2Ak8nvnou9dpLuWtutQRQjj/3VJyvgLoy
	YjPMHMKoEidisqh04TS+CL10BWbke/3aO2dAz5HTUKjv2e5aDbXPil+mSY5inJ05oNs+NSDzMUR
	ec=
X-Received: by 2002:a05:6820:1845:b0:6c9:80d9:5f4 with SMTP id 006d021491bc7-6ca9c94f271mr5407840eaf.53.1789819944086;
        Sat, 19 Sep 2026 05:12:24 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.141.197])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6cd3453b9dfsm2563689eaf.3.2026.09.19.05.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:12:22 -0700 (PDT)
Message-Id: <57a83d15fda4ad3d4297f665d6c35e205e916e7a.1789819933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 12:12:12 +0000
Subject: [PATCH 3/4] ci(gitlab,windows): fix Rust setup for GitLab's MinGW
 build
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

GitLab's MinGW job fails with "cargo: command not found":
https://gitlab.com/git-scm/git/-/jobs/16576450182

86909a94db5d (ci(windows): build with Rust, 2026-09-13) enabled Rust
in the shared CI configuration, but added the necessary setup only
for GitHub Actions.

The build needs Cargo to be reachable after the minimal SDK's login
profile replaces PATH. Installing the toolchain alone is not enough.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .gitlab-ci.yml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index cd6fd4a504..3f24835500 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -133,8 +133,11 @@ build:mingw64:
   before_script:
     - *windows_before_script
     - ./ci/install-sdk.ps1 -directory "git-sdk"
+    - ./ci/install-dependencies.ps1 -Mingw
   script:
-    - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
+    # The minimal SDK's profile resets PATH.
+    - git-sdk/usr/bin/bash.exe -l -c
+        'PATH=$PATH:/c/Rust/bin ci/make-test-artifacts.sh artifacts'
   artifacts:
     paths:
       - artifacts
-- 
gitgitgadget

