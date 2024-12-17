Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7091F76A9
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456726; cv=none; b=byI8xSfQwDvymOKKMbY4Os+RoWkYHGrOGKTUiPBTK8Bfbm1WubIItmy6TsXcWx/ppSQbGU5AgBg37xC1Ka+SOrX/J3FIv2R2OqQB7Blc+YpoWMkNbBfjQ+lDKfCGnCTJSBipu4SFTMEKUVBuBcKHM3dSaD7H/BqqN2ECxIbAKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456726; c=relaxed/simple;
	bh=lsXgQ5tMCZLC/FFQfeMGV+9UgyGeyrXZNGRBZ2Veyug=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=JLDwC9O4hczHdEYU2UezbcCTAm9AoiWvCCc7iq3wo/Dlz4ONfZth7AvYP0I+dyvMMKWIce5XVQHLwkCfbSmteFavYJ8NIspAwmTZqOwc2tvt2g4rQpHKqjE+3woDNt7fuKFoUrXreyO6c1QgSxJRKZmyXnZgtu7rMV8xblDdM68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll/wKoTJ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll/wKoTJ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-385eed29d17so2857587f8f.0
        for <git@vger.kernel.org>; Tue, 17 Dec 2024 09:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734456723; x=1735061523; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=n75txKiVFK2ijPcnLr5Edf08hz71lNoHeNO81/ZJwTU=;
        b=ll/wKoTJ5NQAg+R05wxx0LOf8xUmONtZgdFOdHkmAHnbbVMBJ4JegiFiD5ZhB/R0dX
         o9PdYGB07RS+2nFL+O6pA5z6K3nikDch3roRxS/nbAvIowPFDaQCX5+dpdZXScAseNXA
         +8SFWpFeBbsbQ7XCScfItjsro6A+bLpDsuHKBx41/nXImqY6/pifxbE4wplWvBEyayxx
         4Fiq5MTZlDbKxUAj6Z+b8iANJ7j5/D4940O0wwVHOmyMeoZDVlZPKP4uH2qhxLcsk+q3
         KG/LqioSjl33HzcqQZMYNHu7qWVm0VLLt9ENfJSj97KcyLOfTKrNHFlyen5XRB6zU+Zd
         2j+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734456723; x=1735061523;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n75txKiVFK2ijPcnLr5Edf08hz71lNoHeNO81/ZJwTU=;
        b=ljjxgnrRulMXnDzhWtx2YoFOhMhEcb6ijgxmYCVN1a60Ux2S4/gUYI8m0HeORsy90y
         vu2dN3FuZ2jnspMMMtavGMt0zCrYUmqMfOwwwzig0/yPjoguLZsUKVAerP7a3qfDK8+2
         adNWZPZJfAOeSgNQdTaG2G06IaVpuDWq0yvdS88gOccttTRuvc3c9sAOUjLvuE51py47
         YbrBOYGLFhGENyZZGZVe1QfG/9xU6rR4QmjMoOnhhujWSEldwKS8CTcyLt/XJhYKEq+X
         K3IBFLlWzolheHk/5jscrWxXbcB7VORir6wWE6XTrVg5FMLZBA+IuTorHE0MYwqwGRcG
         +X1A==
X-Gm-Message-State: AOJu0Yyj9JgU4UVq/iiq7hgigWiA73dD4SpDFjWq9l9VGSAk0NsPdZIB
	UEa2qcQFze45U/kLQdh1ZSehRYwljRHuukg2w12K/ew9J/g69XhUscPOJA==
X-Gm-Gg: ASbGncujyiQPPLJqO5wxOf8+vlVZ4Q8GpHG5sFTEbP4ZGS2/65FdBjpg1dY/qA0DPPC
	Eo/8/VCDTufWu7u+YhJZW6IK5wzSME9QjZPVoWz7bmChQwLOVj1WqGCkVDSzG6lmcyCT2Gs6XP4
	HI6J34UBn1tPO2DLyFQ9k2KoqFdFctbL7hRYr+FEEelX1xW3i01OiOySix+ASaNqYhPCxr9VCZZ
	VnDtFu+HXjGTFaqZYAeGl1risYQ4NcSVCFBTpUsKALDNLYh8rt/5sdtcg==
X-Google-Smtp-Source: AGHT+IGgymCNBIRsVinGA+mGDr2lC2uc8GTt4wNLqmshTs/8H93KaY10mDIs8gczzc9q40xf70vcDA==
X-Received: by 2002:a05:6000:1fa9:b0:386:4acd:4d77 with SMTP id ffacd0b85a97d-3888e0b8b65mr15510125f8f.44.1734456722472;
        Tue, 17 Dec 2024 09:32:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c8047089sm11887960f8f.85.2024.12.17.09.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 09:32:02 -0800 (PST)
Message-Id: <pull.1840.git.1734456721.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 17:31:56 +0000
Subject: [PATCH 0/5] ps/build follow-ups
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

These patches were required in the course of getting Git for Windows rebased
onto Git v2.48.0-rc0. They are based on ps/build.

Johannes Schindelin (5):
  cmake: better support for out-of-tree builds follow-up
  cmake(mergetools): better support for out-of-tree builds
  cmake: use the correct file name for the Perl header
  cmake: put the Perl modules into the correct location again
  cmake/vcxproj: stop special-casing `remote-ext`

 config.mak.uname                    |  4 ----
 contrib/buildsystems/CMakeLists.txt | 15 +++++++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)


base-commit: 904339edbd80ec5676616af6e072b41804c1c8eb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1840%2Fdscho%2Fps-build-followups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1840/dscho/ps-build-followups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1840
-- 
gitgitgadget
