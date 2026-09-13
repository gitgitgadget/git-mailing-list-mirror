Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0432FF672
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789332075; cv=none; b=NNm6qWkZ3mVDoZjFELS7qr28Tq6P5s3tMwv2VL3qBsVEz3xnVx/xkLvDXBzJp32OLDz6PLWFQ6G+MGWrbKW+X+XQ8CPXN4RCWkh6sR7d/716XxEj49LGd7SAg7sxcpSwxihnXf8KMk5uGdUnDVTmz6UbU4pFg7f0ZkIwIuTWoVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789332075; c=relaxed/simple;
	bh=n3k/IK2AEVAS+H75sJU184FcoIpHHngK15b6SBJXaDQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=EassMyjcXGzsZEOJrklR7ZOd7G9WJYTVBPjaJaLKEIV3z52IFZY3OfvrXgOFXyml8rDPEBHrvj20AS80zBVUBGZNTV0nM08NudxeS/KynoIMdxea+Ym4NOBbDvpYjRjutGHA2e4ODXenPmrT2SDkn/qzZFZBGBmfMJm/dY+KoQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gj6GWxuo; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj6GWxuo"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4aa0f1766so913031a12.0
        for <git@vger.kernel.org>; Sun, 13 Sep 2026 13:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789332074; x=1789936874; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=jqL4hVFI8w3xE6aH4rCKyoeZbyytrFO1GJRX9WTVldA=;
        b=Gj6GWxuoNqLByQCkRHQ0AD8ENrxewG2gdr4EBQXmpPot4N3j0uPvZo0rlqfcWyY3fy
         dDy3zpYup72hqU4RdHRcYAqEZ0sLLJA64M+QcQmz30CKh5L2ky7mZA33nJyP8rn8Pn+H
         guLSUtF7D4RkYQitYKyN79Jhe+uUAbhdi/NykS14bolsTlZo/rPau7+cAA2h0NIdmdVA
         aEBW4vRuzSw9cNC/7YBzGtQ+hmH4szrlq+MjXc0KA3YheMkSG4SW3uKkipeY447LWaF5
         IFJwHDm9W3dTatQ/0GF31d//eFRx0Cc500MveJhgGEswvZuf2ubtVxfB7yG5/A4Ly0Ot
         heDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789332074; x=1789936874;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jqL4hVFI8w3xE6aH4rCKyoeZbyytrFO1GJRX9WTVldA=;
        b=NbcI3ShSreeJlFx8dml4KNhT1skAj3pKF0/zBurmcN/3lR4EYOWnNlZNxbs38pQZuW
         nFArQMolJmMAe5XAHrOi4Nd4qpJFKK9xmK9KzHK1SIBVXjr4moSdd3X7wN832fNPibOx
         +gf+SY+iLNWaFzuIphfRHsUN3M5ulAxkzmIli5NGWTKGFu435frjSi9CBopvW3saBt5m
         +Eh/EsK0ajOwMmzZHktzJtsYeCsPVMSLzfuNIVj3ZI1ad/5XxYLijgd8EI96rXor+ifn
         Tinx1bIXVnzL4ytqF6e6OCqWvaoy/oj4MsIdV/4srX4NPevIYkaM+iOGmVQxtO8Otvab
         SWtw==
X-Gm-Message-State: AFuF++lPgUPjk6UcC3WzNdepO8J6JWq7a+1JVMsfARzA6OJGpv0d5T7L
	v+ywjhJjv/oOT6GvdGLT/gb9phR12Uo4cyYD2XuojIyx/4wOfJjrKEb3biCEmw==
X-Gm-Gg: AYBFou0BgjODpEhfHzaBLibSJ+vtFEAg0/SVsfgLy7FEaSYsSgLb5c+J4Jz4C+qN93k
	/DPbt41T8HLxNHYN3oiNa7RpEdvW0UFpXLC0MUCtaGqtZPZcRIBzOPGBdgtbYrYISam3EQMkOpP
	meI5/eDfGaS9rZ20apzJO0/nzaZXMSl5oSaa/m7IX3IwDGowbB7kTjvV+H46lVI8yWdJjX3PTqc
	0yxrkixPu/lFD5ayh5AxEP8J6Rw9WrV1yG6fOgeAM86JXH1pKVBabu9YH8+sN5psOl5V49UxUhR
	bd2ulSTGEIA3SsmTJha76koBNPU8MoUPdyz1eLbUISC9OWshtfJ0+Xex2PchIYOniQtmMTJZtTe
	FI7F9w4iib3WnjQ8Vs8ugZl+qTtrWD/v2xDc9VVvju/XEORRi9PwLWf4t0Ra+Psdn1CxBeAYMBD
	qivJpugf3XVA2JkqowRG6LOBSaTqE+4G55ETMGrmyyIuonl+G7n01dLc/a3hk6gqgkYJviHFQ=
X-Received: by 2002:a05:6a21:1309:b0:3d3:ae0f:5269 with SMTP id adf61e73a8af0-3db0e45b55dmr17384084637.21.1789332073654;
        Sun, 13 Sep 2026 13:41:13 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.162.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4cf31c1sm22207904eec.1.2026.09.13.13.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:41:13 -0700 (PDT)
Message-Id: <pull.2228.git.1789332072051.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 13 Sep 2026 20:41:12 +0000
Subject: [PATCH] cmake(windows): accommodate for Git for Windows' migration to
 UCRT64
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Git for Windows needs to ship with a lot of Unix tools that Git takes
for granted, such as `sed`, `awk`, a C compiler and a Unix shell, just
to name a few. In Git for Windows, these are provided by the MSYS2
project.

Part of these tools (such as `bash.exe`) use a POSIX emulation layer
("MSYS2 runtime", a friendly fork of the Cygwin runtime), but others
target a native Win32 toolchain, e.g. `git.exe`. There are multiple
flavors of that toolchain, and historically Git for Windows used MINGW64
on x64 Windows. This toolchain uses the old MSVC runtime, and therefore
the MSYS2 project deprecated it.

As a consequence, Git for Windows switches to UCRT64 with v2.56.0. That
flavor still uses GCC to compile native Win32 binaries, but targets the
Universal C Runtime ("UCRT"). Internally, this means that the new
`git.exe` is installed into a new prefix, `/ucrt64/`, whereas the old
`git.exe` was installed into `/mingw64/`.

A recently-upstreamed commit hard-codes this expectation even into the
CMake-based build, so that the built `git.exe` "knows where it lives"
and can ensure that the tools it expects on the `PATH` are found.

Naturally, this hard-coded MINGW64 needs to change to UCRT64 now, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    cmake(windows): accommodate for Git for Windows' migration to UCRT64
    
    I could not squash this patch into the previous patch series (merged via
    bca240abc334 (Merge branch 'js/mingw-build-updates', 2026-09-11))
    because that patch series was supposed to be merged into Git's master
    before the MINGW64 -> UCRT64 migration completed, to allow for that
    migration to go forward without breaking Git's CI builds, whereas this
    here patch is only correct after that migration. I completed that
    migration (see https://github.com/git-for-windows/git-sdk-64/pull/117)
    on September 10th, 2026, so now I can send this follow-up.
    
    Technically, it would not be required in core Git (because it skips the
    vs-build CI job), but it is required in git-for-windows/git (because it
    does not skip that CI job).

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2228%2Fdscho%2Fadapt-cmake-after-the-mingw-to-ucrt64-migration-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2228/dscho/adapt-cmake-after-the-mingw-to-ucrt64-migration-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2228

 contrib/buildsystems/CMakeLists.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index e76bd19b65..7874e5a326 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -258,7 +258,7 @@ if(CMAKE_SYSTEM_NAME STREQUAL "Windows")
 				OVERRIDE_STRDUP MMAP_PREVENTS_DELETE USE_WIN32_MMAP
 				HAVE_WPGMPTR HAVE_RTLGENRANDOM)
 	if(CMAKE_GENERATOR_PLATFORM STREQUAL "x64")
-		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="MINGW64" MINGW_PREFIX="mingw64")
+		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="UCRT64" MINGW_PREFIX="ucrt64")
 	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "arm64")
 		add_compile_definitions(ENSURE_MSYSTEM_IS_SET="CLANGARM64" MINGW_PREFIX="clangarm64")
 	elseif(CMAKE_GENERATOR_PLATFORM STREQUAL "x86")

base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
-- 
gitgitgadget
