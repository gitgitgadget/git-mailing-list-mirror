Received: from mail-dy2-f24.google.com (mail-dy2-f24.google.com [74.125.229.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8593AC0D7
	for <git@vger.kernel.org>; Thu, 24 Sep 2026 20:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790280122; cv=none; b=rw+DjEdVHeGvFQ4Pr3Vqtcdf5/0PNIF7kwYad/2G3Z5QhPf7wotv65WExKAyd6arq8evDqvQG9UEj1MCcNrQJMUjFHwBhfP51TBpGJQmcHMwHpLfZGprgZsb6L3mU6Ja8NdCCgCVbQvB4YrP2h8k0alqhiCHiBIHDPjy5kRF8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790280122; c=relaxed/simple;
	bh=/3/Y69z4UU70h0IXB01ZFjq86HuYErTNOc4zanrELLg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E+6NBmsFeiBjipwx++FaV6+HwOrIZfE/MBG9dBM1EWPYndnZjDwgP6xMoCtSzVM3SGJaKVcsRbP+SjnDOt8U/iYBaX4J/lQMK456svjr8Tedhr5y0KdC8xAFYg8no0Y6n/ZUMryd4gvSFYl9Ioj/5SxOYhoY+vpHHvkqUo7iWl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fzeXBUCi; arc=none smtp.client-ip=74.125.229.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzeXBUCi"
Received: by mail-dy2-f24.google.com with SMTP id 5a478bee46e88-328664dbdd2so44232eec.1
        for <git@vger.kernel.org>; Thu, 24 Sep 2026 13:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790280115; x=1790884915; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Du7cb2UzzPAoCH2GwlCk5cIM2dQbLXFdJZN/4jp9HjA=;
        b=fzeXBUCiWe40gWRXDemB2Vb+Q/C11WCrMoq+O75hITeDbACFai2mARdATJrX7pgnRy
         3+U3dPQKXGQU89ZnkmG3CQtPL/JK2uPgbxaPBtf1ufWA2NW3zijcLzaNYkbtDqX19KHq
         NSfriJOxG2CLNxamW3C/CN/xMz3afRHLo89o+p/jUnHj2NkEdm0NYcmXSgliuLGH/De2
         Pthh+pp5UBjJ30QdVA2yMS27zLgv4rpmGOfFBqyIryJBnnSwBoehY2mD3QqdHwCPmXLV
         y7aotvNvWpjNDcBEy6M9IEBiV+ONzc8huNjI2I/PPEG9vSWqR8DP+DQYluqWYS0E4UuH
         ptrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790280115; x=1790884915;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Du7cb2UzzPAoCH2GwlCk5cIM2dQbLXFdJZN/4jp9HjA=;
        b=pPUYXOlPCWd4Vywtgk0P2/hjsJurnb294CTvzb1ZlaKv0b7G9DFzePRE7dneUxj8E6
         ym9eCraPZNSJPC300/imxB1FjenLU/yL+NrajFI5g+oxj6dn2Jsik2qhdLfOGScqFBEc
         ++1IztkrYUw9thzZggjuyW6WZe4gZOIDv/QtUMGup3D2tecp4GCsgfAg4+hsy5tIcBmf
         XZvGtbYdmSB9t84Q6idtmVMIDxtjWWUWYHiiY3sTnFsRhWunbsLeiOFTWkgfU563Z8Vo
         Z8uYsXUpLO4AzqFE4dZ+4BGfcPrH4eBZ4/8ytoNeYLc7RQaF0SwXlwXc+c0c0GrmUMOJ
         Ih3w==
X-Gm-Message-State: AFuF++m28B7SrSBcGrm7Wp5E2vE5pFXSTTppD5bg5acimpAqfj94IKv6
	UI0Hnk0EhF595ea0wcBhZrsQVn7H6igX7nqTHmvP2xLL7fE4licehQvs5cIIh4nw
X-Gm-Gg: AYBFou0Nqm8oUD6YegqXg7L2bDb1xK5OH+99k9Z6wuCHPvh77vBoIVB5b+oNVabh/4K
	bd/tQWWX4Sf0Qg2NC3hKuC2/KSU27QwEIt6gVatoYCDSZKfizFOSWgKDAUI8qcjrFixehD7GXpL
	R4l8UH227Pkq5QwaXF1TU7bOVnHXjxHFDLNbTOodec1tGjAxER0Xhet0RtH5Kv4QUqFEb7/Ovk3
	mLFA50E+o6oRfo47/9qCqtXJJ1uzegso46T7vCegaTYyouS+dPBQMCjkk6oQLV63UgITkkPU7cp
	2GOqMOGxP6WK+9p2keCb7bmgOKFw+pD/z1dKZ8ZgKbF2aa8A0vaVN7pQJAZVEUOCwWd7PXsDxWg
	piEd8SiDoXAgTkcP86KfJhErE8M6HsjVmVTrrKnXxqHy6HPwLnt6X6Pi7pq/L2tMqL9hN+8Pamv
	jZJb2W5yAnyie5XYd4BZHAUGURaReq2x4YXhf2nrHCtLaWHveC5oFFcvcvuUjY4bj8VTGb4+rgK
	lk=
X-Received: by 2002:a05:7301:e0f:b0:33c:29d8:bc21 with SMTP id 5a478bee46e88-34004a89af2mr2354241eec.10.1790280115215;
        Thu, 24 Sep 2026 13:01:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.153.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3414485a9cdsm769942eec.16.2026.09.24.13.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 13:01:54 -0700 (PDT)
Message-Id: <pull.2233.v2.git.1790280113.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
References: <pull.2233.git.1789819933.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 24 Sep 2026 20:01:49 +0000
Subject: [PATCH v2 0/4] gitlab-ci: fix the cargo invocation in the Windows job
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

In https://lore.kernel.org/git/xmqq8q4zosri.fsf@gitster.g/, Junio mentioned
that the GitLab CI seems broken since I enabled Rust in the Windows-based CI
jobs. This patch series should fix it (lightly tested, but I don't have a
whole lot of build minutes on GitLab).

Changes since v1:

 * Reworded the commit messages to clarify previously confusing statements.

Johannes Schindelin (4):
  ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
  ci(gitlab,windows): preserve exclusions during dependency setup
  ci(gitlab,windows): fix Rust setup for GitLab's MinGW build
  ci(gitlab,windows): provide GNU Rust's host-linker support

 .gitlab-ci.yml              |  5 ++++-
 ci/install-dependencies.ps1 | 22 ++++++++++++++++------
 2 files changed, 20 insertions(+), 7 deletions(-)


base-commit: d38352cd43ab9745686d697872408bc3249a153f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2233%2Fdscho%2Ffix-cargo-in-windows-gitlab-ci-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2233/dscho/fix-cargo-in-windows-gitlab-ci-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2233

Range-diff vs v1:

 1:  6a389b2bad ! 1:  cdf2eff480 ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
     @@ Metadata
       ## Commit message ##
          ci(gitlab,windows): provision GNU Rust for SDK-based MinGW builds
      
     -    The minimal Git for Windows SDK already supplies Git and GCC. The
     -    MinGW Makefile build needs the GNU Rust toolchain, not another Git
     -    installation or Meson.
     +    The minimal Git for Windows SDK already supplies Git and GCC. The MinGW
     +    Makefile build needs the Rust toolchain that targets GCC (as opposed to
     +    the more common MSVC one), not another Git installation or Meson.
      
     -    Let the dependency installer serve this configuration while keeping
     -    the existing package set for MSVC builds.
     +    Prepare the `install-dependencies.ps1` script to be able to install the
     +    GCC-targeting Rust toolchain.
      
          Assisted-by: GPT-6
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
 2:  8855c25128 = 2:  19a4d93181 ci(gitlab,windows): preserve exclusions during dependency setup
 3:  57a83d15fd = 3:  6703fa0349 ci(gitlab,windows): fix Rust setup for GitLab's MinGW build
 4:  1ed79f00cf ! 4:  5310afcdf9 ci(gitlab,windows): provide GNU Rust's host-linker support
     @@ Commit message
          https://gitlab.com/dscho/git1/-/jobs/16593470275
      
          Although gitcore is a static library, Cargo first links `build.rs`
     -    as a host executable. We omitted the GNU MSI's `Gcc` feature, which
     +    as a host executable. We omitted the Rust MSI's `Gcc` feature, which
          supplies the required linker and platform libraries:
          https://github.com/rust-lang/rust/blob/1.96.0/src/etc/installer/msi/rust.wxs
      

-- 
gitgitgadget
