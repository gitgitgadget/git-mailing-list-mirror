Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E990F2D0631
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 01:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764205853; cv=none; b=hhnIXnQZ0k1EexaRg0VV6DGD1/2fcAKLDGqbwBac5ipZ3WjHjY63Cqn0bU+g9DSkzXW+FA3lzUprNac4DHfgNrE+S3N4nxzNimt46U9bXNbXFF7JxwIA5IQGcZRpDn1LTkKI9tr3TzsKEcYR1goOwaC8xyI7LKGxH6ag+rSxM/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764205853; c=relaxed/simple;
	bh=w1ArhgKf1OywIzwu8jWdxYEQDJtVn2nxedbs+0ASaT0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ARGMIlCcUEt9PXrQ1FRcM5EQ6MpnWyXNc4QqMGptrAkD1MdzRrpVjNtdqXTIFlOq2OGl+d+c3aFdrwn2IjvVORAjVb9FUqX/IXxan5za8oOp68NSoQ+gSvSeK8Vlzwp6kImZOfvED/aTT1PEvrStNGF1kvk3jsaw+vPTwOGPxNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCfAYfGo; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCfAYfGo"
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-948da744f87so18268839f.1
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 17:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764205850; x=1764810650; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmjyh4OjxfIyzmOS53rQYmtaGAlWFFcpuP+xuLLecgI=;
        b=BCfAYfGoCsexErdwVFtELDHtekKgR1xeWfFX8eSno5vJ0nZeEfSmkt2ut1FckbrbBb
         DVnRY5TVMkmnGgVwHctcf+hXQpJAGTHgRYmcbjXbwczIVedhqg/ZKFTBgJ2aMVNyLKXC
         lBorMRwFOi36nTeGXhl9lBLn1Gb/4lIdjK2U2J6RsMZ/53UmWWu8SegVo5K/VZxO9j6J
         1oRjXJKKuQJv3yVDU/LpO+4ZPUUKiIIQjAoB4nj0LZUuSB7ggfsg6V3GRDQugzkmKXMq
         O3hIJncDGNhM+c8U8PMj/aGJY1Jo62sad/V4Xduna2/Lbf2XYZx2hOc1nD9Zt4sGu1zd
         THnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764205850; x=1764810650;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lmjyh4OjxfIyzmOS53rQYmtaGAlWFFcpuP+xuLLecgI=;
        b=mpq2QWor3/1n4ghuUvYi/uMy9+dZxEteeRUZGsiQujBG7EiuHSW3PfXA+cJmJ0ybTO
         DQvl68fDv5IsRvel2/J38glLxCacmUJETgsvm8suwoZPJHYG4HyTTOgNYd/cGPo/IvCB
         JNKoqo2z3twe4DqDPAB2v1IVBAhhgH6oIo4CN+34PYhSuRZIGElFBzR0xsG/AotEjINt
         MT1CSvEPOxw2eXBL5n8IalQfd5mrXhJieUowoxndQF3KoSzGPGbqzFHWsjVFNyqhXU+R
         cJi+HthRuRlNI4rs246ZKFNftise8j44NCqNgiME34TbTeygh1U6ExXDS1EaZCEp3L1k
         B9IQ==
X-Gm-Message-State: AOJu0YwU/F0Li4x+P8crPxhNGfzMGQVJTfcJ9SAohtNm+KNJKi/tj2WK
	yL3Oi4fN6ZqPsN6w5Fs28Nx+RZ6Ga6z5LvwDzibbuyTJiVB411wkb1ADvO137TPU
X-Gm-Gg: ASbGnct+y4JvkGrxWjQca17dHSC3tcyOqvM3Eh5ljJjiqwOb+KKPzv6POWSIrP7pg65
	RPt8AiunE+3D7J6HbO2H84jAZ7/vFAn6sQM9qjaklzuJ66bxADE3JCZdhcFg28sOp64EyEchCRc
	qS/fYJwDu+qtDubCI4mB62MTaTCiMR5UUwF1SbDx72T4ZwJJE1lJvWL9i6BUlpcOmwQc9zorV4m
	x0u1qdv+8CBDA5LJqhViRZ9G2HcS59knPuMHaToZo7G62ZMJgFTUVrPULb4zRZZYsniVI2SZ15R
	CJNeO3INDU04zof7hJPotb+SAS6knlkb8PNNXDLHkn2peu1ZBUhqkIFGyyzKSjt3rfi8OjRGTZd
	rqIdJ2Sn/61HYqKQFIUXcp11hvbZ1P34EH4/mMjzeji2T2zWkm1hZDLukS4Y06cXoHN8rnKO74/
	bvwJJvqoi7vsB63g==
X-Google-Smtp-Source: AGHT+IE2FgRU9XFzJ+LjcGqc54lBy4/TKMnhgebE8U9bTGkWkGCBaB1KrupWZ2k45E+WT4umCz3Cqw==
X-Received: by 2002:a05:6602:4912:b0:945:9f2d:592f with SMTP id ca18e2360f4ac-9497799adb6mr529144039f.17.1764205849780;
        Wed, 26 Nov 2025 17:10:49 -0800 (PST)
Received: from [127.0.0.1] ([64.236.141.183])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9498ffc46d5sm503939f.9.2025.11.26.17.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 17:10:49 -0800 (PST)
Message-Id: <288bdb39d23a0130876cad8d52ab54cbc4463a1d.1764205835.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
References: <pull.2110.git.git.1764205835.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Nov 2025 01:10:30 +0000
Subject: [PATCH 08/13] rust/gitcore: link with c
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
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 Cargo.toml              | 1 +
 rust/gitcore/Cargo.toml | 6 ++++--
 rust/gitcore/build.rs   | 7 +++++++
 3 files changed, 12 insertions(+), 2 deletions(-)
 create mode 100644 rust/gitcore/build.rs

diff --git a/Cargo.toml b/Cargo.toml
index b7b5890934..4585fda0fc 100644
--- a/Cargo.toml
+++ b/Cargo.toml
@@ -2,5 +2,6 @@
 members = [
     "rust/generate-headers",
     "rust/gitcore",
+    "rust/link-with-c",
 ]
 resolver = "2"
diff --git a/rust/gitcore/Cargo.toml b/rust/gitcore/Cargo.toml
index 2f51bf5d5f..fadac77d42 100644
--- a/rust/gitcore/Cargo.toml
+++ b/rust/gitcore/Cargo.toml
@@ -2,9 +2,11 @@
 name = "gitcore"
 version = "0.1.0"
 edition = "2018"
-rust-version = "1.49.0"
 
 [lib]
-crate-type = ["staticlib"]
+crate-type = ["staticlib", "rlib"]
 
 [dependencies]
+
+[build-dependencies]
+link-with-c = { path = "../link-with-c" }
diff --git a/rust/gitcore/build.rs b/rust/gitcore/build.rs
new file mode 100644
index 0000000000..7427a5e45d
--- /dev/null
+++ b/rust/gitcore/build.rs
@@ -0,0 +1,7 @@
+use link_with_c::BuildHelper;
+
+fn main() {
+    BuildHelper::new(std::env::vars().collect())
+        // .generate_header(|_|{})
+        .build();
+}
-- 
gitgitgadget

