Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF7934751B
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280119; cv=none; b=PRgmOJhvmhzc0DvtRs08It3yx5Mvu7Iq3HgYX318mpZb+EZ1Y4UMVm/I+VqdrT+RfnkVi+4u23P4LQuff6annjBhQCkXppJWKV1WUb089kQo1+H4IeKmMkXGqZNSKIUPYJc8gV9/p4Z/+28S7F7rnuZPL6NbWFxVJKtRjOERwQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280119; c=relaxed/simple;
	bh=l6IxXC9j1P3+HDp2l3EdShN4M34Hx9SOWChvTLohcMc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YWGPU/RxE6hJGXfGcp5zLy7POsvR57A6fRNnbzIyyi+ebjLuc7xln6/sXNp0AltuYZffdtiGenLJRJjJG4zkGTCVUoWwv85RolHhgDnnO9hPPLoeC0v1kFF8Vp+YI7LDq2XF7dNtVlYVxEM3NTxdnogww4VM9JaQx3S9Q5o1lsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnJAETxh; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnJAETxh"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso197482c88.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280117; x=1790884917; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ym/yQuKvUxl6QFnuYMjcCLHdnW5C9njQzylDUa03pgY=;
        b=LnJAETxhBABbfu49MGWAvHEpIT+lvoEAAB/TkinFvhWIR0SnVzHJjmoLqawOozffSN
         kRhSrNnslvUhm9E4Bv1b/Sgz83aPt9VmQ1VXoUsaumt1Dlq6WUwekxIFTeuiB+53GyCC
         H4veT1X82Vwkz0pkHwfAUL2d3q2kGWfCNwrCVjTYugKTbvI3MwbMHb9EOqshYgSckzaL
         SQdS6CrKbpStEQhyF8r1L8dzu5hVWF0wvOzITtrO0s7+9uE+EB/ygYnzH5WuZcbT48QA
         irCcaUwvV+6cvwtriNHiiuQPk66ddbfePS1E2BzuquIw6n7pfXb6Q+tJVPmoRhdqn7Bd
         Jy+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280117; x=1790884917;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ym/yQuKvUxl6QFnuYMjcCLHdnW5C9njQzylDUa03pgY=;
        b=TFa5FQDEO2FEIiKDZn3S2ZN36dlNwnsuAlac+lBtVPAOeBK8wE3aFYLCmAjtNgfOO2
         PDXvlSJfplFF/lmKB1pfgHTHVvkziscqj7M187VuE+J/wDkQyNVp3Wc4bUwoS+0CIebp
         genE0Jl8uXVz/vqoDzYRDDcQ03OQRLSI/54V0dKbGjwMHF3836oUIbZEn2ySkDy1nxZV
         fgyE0RrNhjjao96xRpGFBtN2NWVFZG7ZsGKgY600+NRuGIHXz0/o0d1547lp9Imx9a69
         35nQFs0Ek3++aq6VpiLJVp6U5IbUG6ZWhJX2yq92zYDQ80AOz/2fmx9/Ye+Gi9uh6cxW
         UaMQ==
X-Gm-Message-State: AFuF++lRdimp5yXau/eQd4TPMnLYBa5khpbASR4SHc9bCrC3zUpGikQx
	QgEE01d1zNWeW0LZhBb8dncLACQm8CL7c3TfJXe8F+SjGqJG5dsftMTrWrGbPMic
X-Gm-Gg: AYBFou1skYtIT9W3zlKGJV5DseaU9gmdZcbbXxgQbiG6y0ytnnnwob2UHhwy6YCdm2+
	IL1yABwNRdJWpKLLQIwJf2zgicSfd4bKoK7rDErkNa+aYsOHZJZ2tKPS/GRi3ydr/7SxSOURwMV
	AMtfMjkkhHrUfAdiYeVJwYXyqOszH6+UwhY4Markp9D+TOrI8015xzWWtQvgKE6FqadesuAmHj9
	hCqsZQBcUYJngbq0D3TozeiEUw5QsqeraGBFka+ruaz8pFlL60CMQaG7mlO07lMBnUj9SKRPZXB
	BbNRNhPWscJzkxYK0HjrUWowiXeOxdDGdMaiPd8r2qAVuYmlqlJDNW8fieGEHzd4Ysx+LvUxwKG
	WixzWj/SFBQaz73IUcbR/KgDw5Q4zEMxRCXM02/1/AL46Lzit/x0aayUiNKEf/yeaZw6C0LyMZN
	Zk6cQTci9DYH2pT7X5K7marvM4yvv+yGW+9mpUyjr2OQXDPRcqdB6i9kFPmLh8eVrNiZEptZxlS
	RI=
X-Received: by 2002:a05:7022:294:20b0:143:54c6:6a5 with SMTP id a92af1059eb24-14503ff8b14mr2611117c88.37.1790280117061;
        Thu, 24 Sep 2026 13:01:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.23])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-145aa0cb7bcsm734102c88.2.2026.09.24.13.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:01:56 -0700 (PDT)
Message-Id: <cdf2eff48020ef72bcfe36aa55467c9cc8ece9ac.1790280113.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
	<pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 20:01:50 +0000
Subject: [PATCH v2 1/4] ci(gitlab,windows): provision GNU Rust for SDK-based
 MinGW builds
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
    Karthik Nayak <karthik.188@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The minimal Git for Windows SDK already supplies Git and GCC. The MinGW
Makefile build needs the Rust toolchain that targets GCC (as opposed to
the more common MSVC one), not another Git installation or Meson.

Prepare the `install-dependencies.ps1` script to be able to install the
GCC-targeting Rust toolchain.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.ps1 | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index e3b367fa54..8c68fb0cfc 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -1,5 +1,6 @@
 param(
-    [string]$DownloadDirectory = '.dependencies'
+    [string]$DownloadDirectory = '.dependencies',
+    [switch]$Mingw
 )
 
 $ErrorActionPreference = 'Stop'
@@ -41,6 +42,17 @@ function Invoke-Installer {
     }
 }
 
+$rustTarget = if ($Mingw) { 'gnu' } else { 'msvc' }
+$rustMsi = Get-Installer "rust-$rustTarget.msi" (
+    "https://static.rust-lang.org/dist/" +
+    "rust-$RustVersion-x86_64-pc-windows-$rustTarget.msi")
+Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust',
+    'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
+
+if ($Mingw) {
+    return
+}
+
 $gitAssetVersion = $GitVersion -replace '\.windows\.\d+$', ''
 $gitInstaller = Get-Installer "Git-Installer.exe" `
     "https://github.com/git-for-windows/git/releases/download/v$GitVersion/PortableGit-$gitAssetVersion-64-bit.7z.exe"
@@ -49,7 +61,3 @@ Invoke-Installer $gitInstaller @('-y', '-o"C:\Program Files\Git"')
 $mesonMsi = Get-Installer "meson.msi" `
     "https://github.com/mesonbuild/meson/releases/download/$MesonVersion/meson-$MesonVersion-64.msi"
 Invoke-Installer msiexec.exe @('/i', $mesonMsi, 'INSTALLDIR=C:\Meson', '/quiet', '/norestart')
-
-$rustMsi = Get-Installer "rust.msi" `
-    "https://static.rust-lang.org/dist/rust-$RustVersion-x86_64-pc-windows-msvc.msi"
-Invoke-Installer msiexec.exe @('/i', $rustMsi, 'INSTALLDIR=C:\Rust', 'ADDLOCAL=Rustc,Cargo,Std', '/quiet', '/norestart')
-- 
gitgitgadget

