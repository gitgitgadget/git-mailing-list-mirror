Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647413207
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 20:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710101102; cv=none; b=n+R1WeIvQOz3cA6kbLDcnAhN9hPihTEzHULl1OWHcXyBpHQ5rGNUpH/dz+/2J1tLhAbkKbejxo32c/kWNH4Arrj2TAA/djOvWqbnL8XvWXNUJdGItdGk92siJzajtAQVI/ozlP4s9ckP0yWRae3huNiJa0Q/2TNSonXeyFJZHPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710101102; c=relaxed/simple;
	bh=TVydEBoMUOLwZYeIa/WxXcynVkvJnWi84PFfmot5lxY=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rGCEDkYDhol/E8UiI/NU0AR8XDOU9hZL0drgftH+GNnu37rrmZX8tzP97E8Q2J/aLoRQ+Z2K5kWbgcgyyKpfRihbaoIzbREhRkRR82MBkcCF/PAMp5crGpROEjg1JNPQakGdlmefMrHf3w3Z88bsiGqJxKFQrDfPgRLSr+u3kYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkqju63x; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkqju63x"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e95b68b3eso388035f8f.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 13:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710101098; x=1710705898; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RmaYbiLe6TwNl83HXDyn/fl9ZsvrIdTHeX1qXdfzVtw=;
        b=bkqju63xU/TTmwthI1dEHPEM1ExSCFK6S4C5ELtqGYiZylBFpMtmfjHMf9NMKO15jQ
         bVq39SOzAhTJ+iW2S8stpNs2Aemcznn5okyM8fnejJDeL+zeODZRsxS3cvsI6YnpVw6y
         gXQS+yWMruHN1AmIRemGw6Q0e/cInuz62P3DjBpkiihMTejE+THFFMxp32oSZ9A33VL5
         2Jiuk/WTxqFf+8ZOn8O5rKC9jQmrt2aJphM8xIcb2/B6Ov+zJQCj0ZQ8YHb1tOu8U+mZ
         8nLg47T+QyTlaOJhjgozu58Msh1yhWYgaA1TiVC2g4kO4pkKtMc4s+DNsgkBpCys+z51
         CF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710101098; x=1710705898;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RmaYbiLe6TwNl83HXDyn/fl9ZsvrIdTHeX1qXdfzVtw=;
        b=eZqIsH61ML24aW00C/5Axqn2MYIFg2fC1ofBlY+X8rNuIzEdvqn+YZwNW5Ji/RiaOD
         2MqpttwSSh5VpGRvnKGn6IXqacqDuL2T0LfIPbQ6a6k2yxA7NyxzM3lBxMStWWyDmHRF
         y8irhOaKMWWEZLNc/yK95c0wfspnboTkXfObW+xomyQ8UBs2aeOYLhuN3psGNCom471c
         57OewYkqH1bD9lbBkpVpoAyDBwCGsXot2YwNCo4ulLpxJBA5ayv/vZZQpUF916U3C45s
         b9bLW0hGb5/SuKPejWBtS+WXGGUdwTPk2K+d0ypes/Gi1zHSlpj/u4FN38gIRIzJasTQ
         CdCQ==
X-Gm-Message-State: AOJu0YwxoYFBrNk1K7f79zE8K3vhQ20g4SyeDQu9SxjbjLy6oyD/0c42
	w4pXjiVtuEHb1wOak5FEKUd+8fxaCuQfhn+153v53grBgTX/mp1k2VXcpreV
X-Google-Smtp-Source: AGHT+IE2VWQeBIi8dK40TFpLPNY6rhwc4+v2PMMwPQSNhGhhGMdcO3C5TekbooW/J5whZxOVF059hg==
X-Received: by 2002:a05:6000:24c:b0:33e:1efa:962b with SMTP id m12-20020a056000024c00b0033e1efa962bmr3167841wrz.60.1710101097984;
        Sun, 10 Mar 2024 13:04:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id co15-20020a0560000a0f00b0033e42ab5114sm1471552wrb.2.2024.03.10.13.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 13:04:57 -0700 (PDT)
Message-ID: <pull.1688.git.1710101097072.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 20:04:56 +0000
Subject: [PATCH] ci(github): make Windows test artifacts name unique
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
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Victoria Dye <vdye@github.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <levraiphilippeblain@gmail.com>

From: Philippe Blain <levraiphilippeblain@gmail.com>

If several jobs in the windows-test or vs-test matrices fail, the
upload-artifact action in each job tries to upload the test directories
of the failed tests as "failed-tests-windows.zip", which fails for all
jobs except the one which finishes first with the following error:

    Error: Failed to CreateArtifact: Received non-retryable error:
    Failed request: (409) Conflict: an artifact with this name
    already exists on the workflow run

Make the artifacts name unique by using the 'matrix.nr' token, and
disambiguate the vs-test artifacts from the windows-test ones.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    ci(github): make Windows test artifacts name unique
    
    I noticed this while working on another series and thought it deserved a
    quick fix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1688%2Fphil-blain%2Fci-unique-windows-artifacts-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1688/phil-blain/ci-unique-windows-artifacts-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1688

 .github/workflows/main.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 683a2d633ed..3428773b096 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -159,7 +159,7 @@ jobs:
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
       with:
-        name: failed-tests-windows
+        name: failed-tests-windows-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
     name: win+VS build
@@ -250,7 +250,7 @@ jobs:
       if: failure() && env.FAILED_TEST_ARTIFACTS != ''
       uses: actions/upload-artifact@v4
       with:
-        name: failed-tests-windows
+        name: failed-tests-windows-vs-${{ matrix.nr }}
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   regular:
     name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})

base-commit: e09f1254c54329773904fe25d7c545a1fb4fa920
-- 
gitgitgadget
