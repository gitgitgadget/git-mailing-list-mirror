Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371339EF20
	for <git@vger.kernel.org>; Sat, 19 Sep 2026 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789819946; cv=none; b=R4GzX8U73gmENbtDe015mdX2L+ctKTWbQrcmmBGDkgBOU9Baor4H/HXXFrqgwvqJ4VPzNyzbwkRathVW16OAo2sR0WsOKhyxM8fPAnfWkdh0eNd2ImbtY4WQ531qgZqwPmozstvsdZOg8TIZSzs4/eEoaXNa6IUlU3SBWJeIv3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789819946; c=relaxed/simple;
	bh=uigROy0QuvosDRebXqHsJeHk+vjz5eIh/3cpE26mArs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gwd8sjJpzNnwXeuu8DUmYW7RzZVXyRH1DtMfssfFSEDR7EuxDD7WtDyimnHSO6jg4cGTPZh6ZAHOuvd4Mgt79xcuMcJ5ZK1YoVs2+ld71N4OC+QGj+ZpBHFf8e9fDkEkL43gAfVB8DFfbQNMzF5GoF4jbp46yGy3cgw294sRWHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q4UibzOI; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4UibzOI"
Received: by mail-oi2-f12.google.com with SMTP id 46e09a7af769-7f4f0cfb33cso944244a34.0
        for <git@vger.kernel.org>; Sat, 19 Sep 2026 05:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789819941; x=1790424741; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dK/34v6th/YupG6bOyeQHyuBfgOC9wBdyc4skoSQF/E=;
        b=Q4UibzOIKVN5aY9Bbu0fle8ODbio9gdc/BwMbQTmb04jIOR/axVdg77Hs/S3Axr/dd
         o+3DGVwMEkzbr4BU8FkS+kGTQoHnZOCkHWjqudAFm7wikIxRdJjedRC29hD8Rq7uwzKM
         T+HmIHCmVKUcF8/P9hEPUQapTau7ufDagMMX088VfJKgTb8mVpwL9clRepj2JqPWRp8/
         4P8DUhpsLVrwSBT5jC/+R3KwLF5SU6IzqixCteZx5covpKp51l1MTKgJIBkfpwPZSx3b
         aBW+Fj1PvQ1kOemLvZHD666rVxNoaMPofSUTAzX1paexs+AuQ22t0m+cu+eSjtkcHz9S
         A14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789819941; x=1790424741;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dK/34v6th/YupG6bOyeQHyuBfgOC9wBdyc4skoSQF/E=;
        b=y3CtsIoib3zNcz0zBQFo/MrxplTqHM8byOi1o4gOy2SvvFSNgE9xBmlsf9LuDxuMod
         3zLt8GyBbysrtShvgjqRaW2J+FBOho5z9C+erBoNsfX5a7zvIHUS9oZ9qi51q/j9wosw
         sOX6JsNJ8KbafAPE/agJwkJsWKqdsX1C6XLSp22RAKNWxNPJdmZVwzvM/lkAyx6xDa2a
         qkoe28zON25QXj4oD7frS0pIlSXaVJUI26C/93Q2VKRCjGE1hjEjNqdC9e5TFl+ePovP
         2I8CkJ8yYPz/bd0CSx5ArZulE5jtEguC7gXtUhVLBS27v2/SLiP8ll1TMboGKMa48ylY
         bvag==
X-Gm-Message-State: AFuF++k5DWablt1pLGEZd83cRMHGxWmvSrgOPLfNSuVMDlV4ukR3sOL6
	jiZbm1bYKkrANaC8YjjlBONF6cHqD0knt5TFhrISenzXk0AqB7yh9woiub1xLw==
X-Gm-Gg: AYBFou0mssY8MoxepVvAnIw+BbG/lC7KNK12HUYTWlQGmMLVPGIuZ/ZCY2gCatL2Qa+
	vXep9dOqdTq06bBRhzIgkaUnebeG7DTVAVHiu7TiThMaA3Jlr9X85UO/+2/bQHuO1lPNGk+73Vi
	2KAo2CRgzekzDriSvRPWIJU+zgGY1g5SvDUXAws87tW6bFa7YO5SmlBM+VSDW6ZGhUXhMw3Tt1y
	OKeZy3yPK8A/u+/y7TxBsbZH45uzHRjS6soFAk9rjl8Hcm9694hPn2Pkq2PXq6jkgMN0woCbnoi
	Br/7BYO0FB8WRC5fcbaOyz6to9V/hfd6tvoXMeHaecNEYWUuKwn2xJ4gdOwPvBlYxyrCR/5HeZh
	+L5KDTE8/JTxEXYGjifEH8t0JzehtyWyS2jT8VwWJjAdSiFHGsp812BIml8WD4WQVrMTI7mzHrZ
	vn3ZKZERSgcd0f6ySueICyuoFgFUjh4Nz6OJFpcVuO725EvIuiOelKR6o7fpsjnJlm6Ed+duzYD
	J0=
X-Received: by 2002:a05:6820:823:b0:6c9:82b3:f6f1 with SMTP id 006d021491bc7-6ca9ce4f514mr4845832eaf.60.1789819941231;
        Sat, 19 Sep 2026 05:12:21 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.141.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4882178b8bdsm2008786fac.11.2026.09.19.05.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 05:12:19 -0700 (PDT)
Message-Id: <8855c25128d7bd91bd6514a259ef8165f2fd81ac.1789819933.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 19 Sep 2026 12:12:11 +0000
Subject: [PATCH 2/4] ci(gitlab,windows): preserve exclusions during dependency
 setup
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

Creating .git/info/exclude as a file with `New-Item` and `-Force`
truncates existing contents.

When install-dependencies.ps1 follows install-sdk.ps1, this discards
the latter's /git-sdk exclusion and causes ci/lib.sh to reject SDK
files as unignored build artifacts.

Assisted-by: GPT-6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.ps1 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ci/install-dependencies.ps1 b/ci/install-dependencies.ps1
index 8c68fb0cfc..f6868dc670 100755
--- a/ci/install-dependencies.ps1
+++ b/ci/install-dependencies.ps1
@@ -12,7 +12,9 @@ $RustVersion = '1.96.0'
 
 New-Item -Path $DownloadDirectory -ItemType Directory -Force | Out-Null
 New-Item -Path .git/info -ItemType Directory -Force | Out-Null
-New-Item -Path .git/info/exclude -ItemType File -Force | Out-Null
+if (-not (Test-Path .git/info/exclude)) {
+    New-Item -Path .git/info/exclude -ItemType File | Out-Null
+}
 Add-Content -Path .git/info/exclude -Value "/$DownloadDirectory"
 
 function Get-Installer {
-- 
gitgitgadget

