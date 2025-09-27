Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FABAD23
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 00:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758931665; cv=none; b=GzXRlpaZuXgDTJ0SGJteMKpFWSmZZH4shKv5fTxzIYeclP0fAEnBqztFtp+A9BasImtsC58DtAX0ayH4QsjISGoftpcZ0myTV6fEer7VTjekas4Qmv1cgGwFuhx1UPpE6CsMVo5ftwhXwIZENx7RQnCD9MV78KnVvTPfArbEhzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758931665; c=relaxed/simple;
	bh=iHE6ryTOpcPDLhjSoGUfG4PNqaaSHpF26u5Ekcykd+U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HZmrKUblJ6BoSKamSwUPcUhmU2lUvIGxi9M1DpQoKdbgWLKylNHRtUwkIvXU71oIf+juG/evCTVW91fVRHSpScdmqovwQfq1Uih2N1eQYJBf8pHwH8VwgAFgG2bghmaq6IOBAuqjFsymKde97rcjeznNL0+93NZYNpxqikfnrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THd19RcT; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THd19RcT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4df0467b510so2429191cf.3
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 17:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758931662; x=1759536462; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ajNUIyN8r1Ljkdpi6NRy0WS8IXInGh8FPN52e+5oTqQ=;
        b=THd19RcTSp+TvBb9QMT6i60NhUSjJ2wNHtv7t+bCJFInD4+cL3Pe1Tx8KM7gKu0eYD
         ViZaL9GgirnhPkhYS1HNB03fG1o7qaejAqe9cVN8Pa3NQk69CyrwGgjdycX55YcojZQM
         bAL2b8jSr8gWitHpqNgvMC8byA62Pmfo3WSLP+a6ky+t9ZCx7GywZpIf59gq4e8rvDCW
         5cfuJdOCjBuUu62VIYcxyZn4NsTXZ16i2ZosYzSBSAmHPZm9rFi4Suvgv59+UNq/UtkT
         UXXXzRV1HiqOvccgCCWzPEPCFn3MSuyFJEPhcL9D/zvp/IcFYDr66k5fwORoV5g3vAIA
         Nzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758931662; x=1759536462;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ajNUIyN8r1Ljkdpi6NRy0WS8IXInGh8FPN52e+5oTqQ=;
        b=C2XxnOIVLiDeLza83vF+mBToDD4SFovLsOMnY0nG0Tf8PRP4ec+DH8U29HkwQMdFTK
         Xqe6AUoKzPod8GCG4gfAB7urWXqIqMyPFEbwPDgydygnl7/oJZr/+BsBL/fY7qzUKBbn
         NmYwN4MkR8v9fk8fY9LmL0+jvaBeV+UZHu6eq1ruaxZxSP7WXqcWzd3PwnRtBq1R1qZ6
         /BTVBX/Ebtho7S9S+Vdxoedzl4uZW4GgAwkTkMNXhujrwrxmLjqPTaOzSip8HRi4l683
         C7A4gXLQrK3adiF1btsnNwylgfdU9rwzASoFjN7VkG9HgOp30KfKa+FjYV+xcp3xyt2q
         T0pQ==
X-Gm-Message-State: AOJu0YwTxsEh9+yuJAUnNGRRJEe97dy4r4t/m4HujqWO1aVgOThkXwlq
	IeB6PtsUZjIL3lnLOu0+pEXIBQSLwLUjXeRP3Kb3RNmPGkKe7hQoY4EgHLz/t7gU
X-Gm-Gg: ASbGncuI810NjtNOy/78BoLVIzlSxBUIYDS+ado0uNHaMsxmYfJU0I19W8Nzc7hk8G+
	eDJPRLRhd/gYqBz15FgC1dKK2i9iQ695xSMVFkU+DVIpkEDGLfC6MXQdPZUisgW2Gq4fQ1nIzBV
	jBy47jHvGd8CVMtaZDiWavZ1QubMJVrguRJnT5Po+B1VINTWE7rRk/E2hiCuJYQ01+oTrv2ReaC
	tCb2DsZQZgXwagWcG4/DlE8VKTgN0w3KHFx999fQ+S1kjo/ymeMSO0lAvuMHWJATCq5YBdjGfHa
	Lg86FlguIN9aEOvwAAEq8HW0/Zpp3h+3yCElWqc3FU66qU1wE9B4ZQOYNiQ2C6c8jQySZ9dxxt7
	ZUqLPo+fDMmxNcxePYOCughgDHw==
X-Google-Smtp-Source: AGHT+IFVLQOMHaGm8GlpAPL2NQF49/EwIHFM4ZJudLPEBS9UfUnFUcw2r1gjuN6/vQuU3lr7I+kS3g==
X-Received: by 2002:a05:622a:7d0b:b0:4db:d59c:264b with SMTP id d75a77b69052e-4dbd59c2897mr75100251cf.37.1758931662349;
        Fri, 26 Sep 2025 17:07:42 -0700 (PDT)
Received: from [127.0.0.1] ([145.132.102.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db11222a17sm33347421cf.38.2025.09.26.17.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:07:41 -0700 (PDT)
Message-Id: <pull.1977.v2.git.1758931659.gitgitgadget@gmail.com>
In-Reply-To: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
References: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
From: "ions via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 27 Sep 2025 00:07:36 +0000
Subject: [PATCH v2 0/3] libgit-rs: add get_bool() method to ConfigSet
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
Cc: Chris Torek <chris.torek@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    ions <zara.leonardo@gmail.com>

Purpose

This pull request introduces a get_bool() method to the ConfigSet module in
the libgit-rs library. The goal is to enhance the functionality of ConfigSet
by providing a way to fetch and handle boolean configuration values more
easily and consistently.

Implementation Details

• Added a get_bool() method to the ConfigSet module.

• The method retrieves configuration values as boolean values, ensuring
proper parsing and error handling.

• This addition simplifies the process of working with boolean
configurations for developers using the ConfigSet module.

Testing

• Added unit tests to verify the correctness of the get_bool() method.

• Tested edge cases to ensure robustness.

ionnss (3):
  po: fix escaped underscores in README.md
  libgit-rs: add get_bool() method to ConfigSet
  libgit-rs: address review feedback for get_bool()

 contrib/libgit-rs/src/config.rs    | 27 +++++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config3 |  2 +-
 contrib/libgit-rs/testdata/config4 | 10 ++++++++++
 contrib/libgit-sys/src/lib.rs      |  6 ++++++
 po/README.md                       |  6 +++---
 5 files changed, 47 insertions(+), 4 deletions(-)
 create mode 100644 contrib/libgit-rs/testdata/config4


base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1977%2Fionnss%2Fadd-rust-configset-get-bool-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1977/ionnss/add-rust-configset-get-bool-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1977

Range-diff vs v1:

 1:  d7810781fc = 1:  d7810781fc po: fix escaped underscores in README.md
 2:  a5904a2ac0 = 2:  a5904a2ac0 libgit-rs: add get_bool() method to ConfigSet
 -:  ---------- > 3:  43784e3ff9 libgit-rs: address review feedback for get_bool()

-- 
gitgitgadget
