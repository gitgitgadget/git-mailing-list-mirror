Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E22253E4
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758071816; cv=none; b=FHLqB9q2WJou8RHHcw463HRzx6cUMA5hlckq3XjoVgpY8Z+Xixu8a4MS04sl3HGx0Y8KHkPFUdom5Gx/GAgO2oMfR2/uKYnpQk3GubAWkIHKX9GOSeewswqV3Lkg8PoWSaGPSEITNnLJK8VPq/6vJS6frOAEYgVax912iPXf6fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758071816; c=relaxed/simple;
	bh=nNHVmNTCjQO7yY4nVFbWrwLss/wmvO3fRs/G5ryQS3M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uI2TXGfSu6Ty4KWHEUbvBJydqA24sXfSAjjf9AbSLAOVeNehE7FhlDTGH/SdHxCqjWgpL0rspHTwJJXlg7AR5k6gyux1Ytku7nZ/o9+/rv/+zCJu2JW1FeAcOmrm7SjPqKoTyiGSDbVlN/XhcuK+LOpQg9UQ6HHqThRHSq62zIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSDMhX3a; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSDMhX3a"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-267facf9b58so4861875ad.2
        for <git@vger.kernel.org>; Tue, 16 Sep 2025 18:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758071814; x=1758676614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ChiBXOgkM6HRe/JlKpHRL7Pd6P6pCW1eje+6JrEdnA=;
        b=KSDMhX3aij0of5ZAVr+jFzSijrDd6P1AapCBH181x5I0XJ8aA3I/HMrcILQ33RWN3v
         lTwBe7wa+49lBrASG7LCstsRHyX2VNEMBAa0G31s1n7Y+fIMQVaGXqh2Atx7cJuu8TP/
         Q7/kCo/jTcMw4lMa4QseF6tVNO1XHc0LsRwwnds+PEvvgTEV6jMq2Qyi4vQJS9IFqw0S
         vjAdXbLB3aJm4/WNOEhrAH5T+SXP1PoWVgbKY4c9P/g9PCRD/2WVy60/Kre+mlHPZjrz
         B7HszBRXZREtWKuvSzHSLXNj/IP9q0L5SF8It7N0Frmqv3dvgCXEVWQamfeXEI//gFFu
         wf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758071814; x=1758676614;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ChiBXOgkM6HRe/JlKpHRL7Pd6P6pCW1eje+6JrEdnA=;
        b=BWsjS7ZPkQwdpTfBlbvto8iPbBruxOqm38jzwoeQgSR1R7qXnpk2WdD1wsJ6A8DdpJ
         L0WAzmLb0NKxaLxxrP2DcKkhzRyOxVHR7WVt3EDGvtYvVvDdh3YgQyCEZdsqIzywy3JH
         Hjq9uGqCt/D4XVXutNCrb5lmVzt+8Qs5bfuuuhs1kxKngMaKOA3wTKUqCFgNIh+yYBqt
         zj80WUndjBRqP1FjM1unWsKMZf7DUDYBcFx3nRwaiLX7L6jZDEj0jB3ba/dGaVTGEUc3
         eOzN3aKtj64H0WjMYlunrnU42ij0QJDk+1TDYd7jbNh43mWiIUf8l5SN1HsGuUiF9Eyp
         0tHQ==
X-Gm-Message-State: AOJu0Yz7/JWv7ZxS4mMhcT7vtOIUt96O967fbON/B+rtYa7lWOk3HuQe
	UliS3/cJ9tlFMQBJi8b1835zPYbtfNjRALX31jBfApy2fCzZ7CWSIbMvdo3kYQ==
X-Gm-Gg: ASbGncuEz6ajFqvS8EdpOURmWCvUUERFxjBJh1D5Ol1cCeEUYFUBfnhdy+BhRev9Gen
	jhgO0PaXeGbPnu6wHrUF48JjxCCBDf1UZd9k7ec3gdo+HXuCv8FT4WzMFoT0tzIS4XVp59Nni8a
	lMNe9yZ7gYBf2jZBNet9qTmlZupDQJDIdxoDMrqAXY8HTO4Spr0sZQwaxa716usmnbXyaTC7azH
	dSm7p85ZydAQLDfWdFvePxCwaEa7wsgJm4JGuEFUc/AY7j3xBrqzpHHPXcdRuv/dqtWyjhoSDxg
	43w5U7/GYj/1eXrqf38odscCpIwwN56w71Ll/S8z5Jiz9Y6RQDAy51MPv/8AkSpGKf8/XkqFHLX
	6h6wcD4Xfip1t6lfKvwryLIVCUXU=
X-Google-Smtp-Source: AGHT+IGk6oKMivYxuj1ExnBGF3W/xvXtjDhpi+yO83AgTEB06EmEeonZcdzhVU6FzlcKOQLMOi3ECQ==
X-Received: by 2002:a17:902:e950:b0:248:a642:eec6 with SMTP id d9443c01a7336-26813be813emr3567855ad.50.1758071813919;
        Tue, 16 Sep 2025 18:16:53 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.209.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267ba746249sm41557075ad.35.2025.09.16.18.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 18:16:53 -0700 (PDT)
Message-Id: <1e13d6c45fcca68eae493689470c58b6be2e2f81.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Sep 2025 01:16:31 +0000
Subject: [PATCH v2 11/18] github workflows: upload Cargo.lock
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

Make each ci workflow upload its Cargo.lock file as a build artifact so
that we can audit build dependencies.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 .github/workflows/main.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index e986684a2f..ff314d48b7 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -150,6 +150,11 @@ jobs:
       with:
         name: windows-artifacts
         path: artifacts
+    - name: upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows
+        path: rust/Cargo.lock
   windows-test:
     name: win test
     runs-on: windows-latest
@@ -311,6 +316,11 @@ jobs:
       with:
         name: windows-meson-artifacts
         path: build
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-windows-meson
+        path: rust/Cargo.lock
   windows-meson-test:
     name: win+Meson test
     runs-on: windows-latest
@@ -393,6 +403,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   fuzz-smoke-test:
     name: fuzz smoke test
     needs: ci-config
@@ -503,6 +518,11 @@ jobs:
       with:
         name: failed-tests-${{matrix.vector.jobname}}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
+    - name: Upload Cargo.lock
+      uses: actions/upload-artifact@v4
+      with:
+        name: cargo-lock-${{matrix.vector.jobname}}
+        path: rust/Cargo.lock
   static-analysis:
     needs: ci-config
     if: needs.ci-config.outputs.enabled == 'yes'
-- 
gitgitgadget

