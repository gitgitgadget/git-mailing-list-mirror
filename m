Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC2120E31D
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 14:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740149842; cv=none; b=EMzVhsl4wopojBShj5NloC/enwhZftc1LFwHDZpVM1IAmREhDf1V2HVkeyEm6pGTNCd+Dwtkyypw8l0QhwpLK2EtC2fy4jq7X6OsMcZRWZLSfGdhltSOvRKtd8s6uKa4QzPU39ZtrBAcgg45xFwpTZ+jFgDVoPpfhBApNEodlg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740149842; c=relaxed/simple;
	bh=YcuEBLUCfbGc6OvbV+772yu+/IJ8oYzV1SY8QDZItc4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=GG1KxI32cRKkViqxp5QV4Bubyp+hCS6TkaU0W6yWDoLYiM3UIbF4kebp3hxTLhmwjV+Mfm6StPHXoLjo1zUtIWJ7DhwmaQZIVFJkSkZyjv42mN3siqa/XPwFMVW0zwb9C+oKx54phbbpC5sSyht2HexlmJAS9ST39MxSaTF7Md8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWoKVcNH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWoKVcNH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43998deed24so21444105e9.2
        for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740149839; x=1740754639; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq327UOk7yiAtO7wPEfldTJFXsKFL+wHW0y6TF+DrMY=;
        b=eWoKVcNH7vC+IwB98t1TQj7L/fLAe95G5MgIdOCmgfET2FYR23ZEsg31LED4RMF7di
         Rgfxz0qGd8JeO+xTT95ejqTdaotZsUaLafnaMCPBnf80mUEC5ofHJWCRdce0yPLHfeDb
         /19zZrBLr8eyaMi/U5+RUmTFAfG0N5HJIl8ErnNuU5Hfp5DtVHfpFBcg/iT+Pnj9od2K
         n6F15R0rLwfkjDW2i0dBtWu3kaRBKjdiy/hDn7TGQPhJWisNOzJnl3FA0obmzQENAKtn
         FmAKOtTf8c492Em+cT5/7nt+w+gx6CF7U5fT+lgrw+2mOzOSfM4UMWMpgIfwj5pVkSmd
         gJUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740149839; x=1740754639;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xq327UOk7yiAtO7wPEfldTJFXsKFL+wHW0y6TF+DrMY=;
        b=ayObDmSeGfehaeyHyhO9JNBhjK1rzwuuxKURLYxlXo/2WH3V8atufn1E29oMI+NqS3
         xxbMJ0oiXEqTMNUPBL8aPnfx5JuU4GSy/YDwmatimgUOk3MlE7o4kNCRXUXLYOtWkQFQ
         OASqwmzn4TnRf9YL3X4JMZHr6hEH+kTffCmY5xPlLwnjZegQLxIuQrodUyZkFq4C/ZSw
         2Vvisx9ZOwqWzvFAuLzghvmkpbZVNks89850RRMvHYake46ROpePHovz0uAXuvbZUDAH
         lvwHENKxiXZN2ye6tEluxZNRP0IzlcnWeR2E3s2kX9wZUSnsfdKNr5k5bv1hRYcIBTxQ
         /UOA==
X-Gm-Message-State: AOJu0Ywmg8sjt1rnATevN8qaJ0/3IPz0ea9iDuumUVA1WAJhATM37Bln
	PQFXPuPa7H1hAQkhzhV4VN//npVRKs3wnduljMicItg/bejN/+4eQOlB+g==
X-Gm-Gg: ASbGnctMHHmPX3Doobgw8dvkgQkGDIeUCV4f6uB2VjxMLZUE9qW9nfXNTeoHOUmKGUH
	I4bPs3ZDPhmePdquvzALCNLWOMv80ytdIaEQylAF7OqRY3VSQfxBScMMM/BPff/oBzhfb01hQED
	tx7ttYeSgcP1xjzp56BULqpwFbHUTlSghTz7nu4yJOVPl6ZjeCzP8F5dcV38+EEnT7bdIt0xv13
	fmjxH7N07DJQn2S4dxMKi1q91nTMuuTDwDWSZJb5jpxv7Lf5rGc0VZQy8HcfettFW0SW+/AdwDq
	MmJ9tQtbGacxIhjqpaPy8qBJiEU=
X-Google-Smtp-Source: AGHT+IFoDTW9M4s37KZA5aEjUplvQlylXCl7r4NiiYrIZ3RQhaPIKt6Ve8PNtNCh1ur4ckqajlJNfQ==
X-Received: by 2002:a05:600c:1d1a:b0:439:9537:e96b with SMTP id 5b1f17b1804b1-439aeb34990mr33080205e9.14.1740149838809;
        Fri, 21 Feb 2025 06:57:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258ccd95sm23607939f8f.25.2025.02.21.06.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 06:57:18 -0800 (PST)
Message-Id: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 21 Feb 2025 14:57:15 +0000
Subject: [PATCH 0/2] add -p: a couple of hunk splitting fixes
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>

This series fixes a couple of infelicities when splitting hunks that have
already been selected or edited which I noticed a while ago when preparing
the test for 'pw/add-patch-with-suppress-blank-empty'.

Phillip Wood (2):
  add -p: mark split hunks as undecided
  add-patch: update hunk splitability after editing

 add-patch.c                | 15 +++++++++++++--
 t/t3701-add-interactive.sh | 31 +++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)


base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1863%2Fphillipwood%2Fadd-p-split-hunks-are-undecided-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1863/phillipwood/add-p-split-hunks-are-undecided-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1863
-- 
gitgitgadget
