Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9BB34F472
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 15:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629698; cv=none; b=m28UXqmHEj8r9mGYdx6OSl0p635p5KZxbZcQyMH2Kk19h+M5S1iY4z2yIyOxdEnFgZf6a8GFxM9VahNKqQBRMHORyJHV/rQYAmSk61Pnv2JoHoSrwDx8fsyx6RCv6p/2upyZJnmPHfd/fZvqcLuFDgv5mrWJa3TnqQsaP28in0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629698; c=relaxed/simple;
	bh=gFOiMylTOonT9meeH0c6xHdNm+GoJ+XDxzVSrd318us=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D+CRIrVEaLWBDC6tmYJohahSN+FULepYq7gWb6hYdB94knEz3Ye74QNQtu4XnihAXnXNr3QIq+fA2j+q8Gg7fR3OZVKVyw2+kYfMcR1jGHzMqPR86vWCYF6apfs9Atxza3RfZ9tUqbG+tyJ1Cl8NngpVKknMwSyUH9XjuQ+Cfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYqWB6iR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYqWB6iR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-87c11268b97so15812336d6.3
        for <git@vger.kernel.org>; Thu, 16 Oct 2025 08:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760629695; x=1761234495; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XVmxR9bMWSoI4Zj06ezJqgChED7IXzFMcAPd/PMMgs=;
        b=IYqWB6iRwmJeJ0ewJd9/zX3B4LecD17+iiazAbbmAP+78IAmV/DjuBAowWxrCRzjnz
         nQZrRhUmIFYjrJILQ4F6MNJXuq4ENwxt86RN8/I28X28b4k5LRIXWVkkDoGN/0hQPP9M
         +Mv0Okem27o2yiYMXVx7yUxGsiOHu83JN315I5wd9YCjtHoF3apfgiJOV9NJkc+2svgp
         55Brhp1eJDN/9g7qQ5OvSw8M8zOQJJ8KycLHiUSoMHPDnPYf5OB4N7zKDwEMbkNfqqGR
         BnXhffwPk5fiZ5ix40N6EuC9bmwoZZJdtqh07ik1n/H+lfp2PQpf4TFfjniBw55y1s9+
         h2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760629695; x=1761234495;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XVmxR9bMWSoI4Zj06ezJqgChED7IXzFMcAPd/PMMgs=;
        b=RG/ZU9LOdblO99wgY0G5urgbC5te22a/Q7YWjrKFlngTy6c39s0YwyvHeV6yGyiGeZ
         ncAQ5YxMnbXT8sOg885uMFzE6+qkZ2+2uykFXfkDi1goF1WHCft542zKxmwIrCuFnbUP
         zjXGvvJ5JPM2TwBANUnLVrio8X2STovdEkzVOEtozes6yIf47cy++Z57MT4ZtP/wh0ul
         RSAJ6kb9A16tOEX7h9rLAEU003hwXAk1lXj4vmk1mvrOmLn9K0COv0yQ9O3iTll0PEaM
         /vYD7Bn+XKl2MG0ETKX5aUci9z9JU0Y4jXZbXgHvvHAxUvRwTSF7bAEqNrFae3OHvG5E
         BKhQ==
X-Gm-Message-State: AOJu0Yw0ZG8vq5OODL0IrHf85em7Tsx4PL10p4f+0L6pQwLyBY7Gxv5O
	pMPfT5dX1THNG2CUtXcUpWmWt9ZpnJ6Z2mIvP7MYaOD/vFwAeORJp4ARx60B1Q==
X-Gm-Gg: ASbGncvVOT9GWy21ZRZVrtof5EIjsINTcS+CQHFy95SA9Ntus5nM75eIsQ8ce3RWjxO
	tcwie1/EC1jXpD8Owp5qPd/walxGq3ada8f8xaoiHw+abcjReOw4B/GZkgIfrJcV8yXnCjjZBcM
	afrJhoFtRKO9TNHbL4dKw6cmT31aLsS9EAVBj31fyJZ7RqtarGnCJYwVzY/AHPboUWCGla+Fuwr
	sxp//F3lu/p8vPdmytki87TqFEkS1ucq7jazlNwv58WEXrFTvW/sUEuePErHQ6ifR1FvE+fJTdj
	NPuLle2fUOapp1pU1fGUiA7McurcCgnnsRCopCHP2UJtJnAFN20ZUhnIOb06ZV1W64DZVaBsTmQ
	yClzjPzdTuFa6icLCXsdYKjEBVY9FW3pflSS2jQ8lis18K6Ywds2RB6pUeQSeRmhL65gqQo3YmE
	9c6fkZi+ixgajK
X-Google-Smtp-Source: AGHT+IFY/chQM2jsAzBK6SUVKkXF01mEL8ZM8xaVT2a5aUBYoxYd7gf///R3HY65A/ntywu7WirZiw==
X-Received: by 2002:a05:6214:19e2:b0:809:19ab:599f with SMTP id 6a1803df08f44-87c20760f90mr8435706d6.27.1760629694622;
        Thu, 16 Oct 2025 08:48:14 -0700 (PDT)
Received: from [127.0.0.1] ([20.51.198.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0121c198sm42365196d6.21.2025.10.16.08.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 08:48:13 -0700 (PDT)
Message-Id: <d7f81da7fe7b35577522847430a9247c540dad5e.1760629692.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
References: <pull.1990.git.1760629692.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Oct 2025 15:48:09 +0000
Subject: [PATCH 1/4] build(deps): bump actions/download-artifact from 4 to 5
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

Bumps
[actions/download-artifact](https://github.com/actions/download-artifact)
from 4 to 5.
- [Release notes](https://github.com/actions/download-artifact/releases)
- [Commits](https://github.com/actions/download-artifact/compare/v4...v5)

---
updated-dependencies:
- dependency-name: actions/download-artifact
  dependency-version: '5'
  dependency-type: direct:production
  update-type: version-update:semver-major
...

Originally-authored-by: dependabot[bot] <support@github.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/main.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 393ea4d1cc..a1c76c4641 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -140,7 +140,7 @@ jobs:
       cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
     steps:
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v4
+      uses: actions/download-artifact@v5
       with:
         name: windows-artifacts
         path: ${{github.workspace}}
@@ -226,7 +226,7 @@ jobs:
     steps:
     - uses: git-for-windows/setup-git-for-windows-sdk@v1
     - name: download tracked files and build artifacts
-      uses: actions/download-artifact@v4
+      uses: actions/download-artifact@v5
       with:
         name: vs-artifacts
         path: ${{github.workspace}}
@@ -292,7 +292,7 @@ jobs:
       shell: pwsh
       run: pip install meson ninja
     - name: Download build artifacts
-      uses: actions/download-artifact@v4
+      uses: actions/download-artifact@v5
       with:
         name: windows-meson-artifacts
         path: build
-- 
gitgitgadget

