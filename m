Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346291EBFFF
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758800674; cv=none; b=PJDz2f3MUi5tMXpIRzRRd+6Lf97gwyKYApwIWHWFIPNLCALLRvKm1g7/adqJSce+rpMs85GB8vcVvKiyd7EyS3hF7pmB1E0Hd/kntu90uP97+CCJH4pFL41s6zJsj0wVmjHaZyq6GWNDC8ru9GLChA4g6D3TjVWOIjjWNOkHCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758800674; c=relaxed/simple;
	bh=lF5P4tpFHrGgL/QhY0MPyyexYE6LFc7DCHWrxRNDJGo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=BCA2eJEYTELP/h0BqNZeDU9nLWe6XLnrQIaF+Iyj5KOHdg81QZ51miP2AasTm1vMyZqg8Gk+gEWG7DDXbMcsOiNHMvI+ZUxlVkRc+DRoUB/U2tSv0A/HSZILkik9IKuH1Nh0mJxOwnBy8OZU1DghQBayOuKG2IhCqxafEfWBAq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/7Jce5v; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/7Jce5v"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4db385e046dso4171611cf.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 04:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758800672; x=1759405472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Vl/FPmD+98eS/cHpgJQFph6Y2z6bMVYMAG5SSnHivF0=;
        b=W/7Jce5vJ/PzVS19GQtxTv2JvYUrBYIv/onMZIq6xkmEBZjoXhaBUZ1bNTzWXldUxU
         Th32RArjuh67faPXQVwYLx4M35KEoNJoznYXCvNeagaK3xS+w9I0/5HnnlOnPNZCPCZW
         82KUp40B2QLDRlnWTHM+M1VJiuD2Gn0Iw3Wb0oPoYPkb6kWHhVB9brHA/hHVRK9v/VQJ
         CDYp2l5mude2Jox4V5iQk8su4AACQxyuiGKA12S92ipQ6mIq4peY4fPFIdOoXQAdaeA1
         zd53rzJ8LaH+QsKmhYjo7/k7oDVZHAOlAs3RJ8fyEZ3DYUBz+5JDWhRvLBfnprz7Czob
         HrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758800672; x=1759405472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vl/FPmD+98eS/cHpgJQFph6Y2z6bMVYMAG5SSnHivF0=;
        b=la0vp+aeaZtWxnEqdeHUPAUzFYPNIcde+RQ1oYh6ICf4J5CmCXqMqaIeFb22Nsu68M
         4Yo4fnNLU41qhdWn7i15+hCJwRl5hK31l4/riK2nVTuVuxm8WisxQU/3N9HKGZ4e5COo
         gciSX+wHY/5Vx4cR6BjAjq+ehiokptImJb2otIXlG0+5unMHsaBhshnaSP1cyOwXTpoa
         IZ/zyPXe4L4FHGqXtROO2Su/tJGgrqJL080Kr+c2uAiKNZEf5xBp3jBwP/atqbcBSCyb
         pd14TlDo1ngJgN+MmGw84CP1ewAm/t9MkHPQPN0Ia3lcbgu1OIo+tQA6YhEv0iQ3pa7W
         TMYA==
X-Gm-Message-State: AOJu0YyfB3v1EVIzVWxaEhuoqcmSjPITDcyjpRpQWO/GfXDavkKphC6q
	wjksnAo5yLz9vhUsUldJBxl8bZMIfIlzEr3wlbj98iR/a28/+7it9o0zujTnSsWK
X-Gm-Gg: ASbGncsxnvqBQW/O/6yH3KVB5YUHU/TdQHWSi9y3ktd1L2I8AN6LeqZsTYlaUfyEeej
	adG584SlI8dX6YrRn8+AMSwMbxYotQ1JjBfiT3RJ17nQlfxs4sPW+Ny1lgfwOPJSvMms8atO3IC
	Wrm4eGvAr4Rpd7/mVGKKl5uvtKeVT/WHKo1Ecj3vSKxKr18MfdVd+A3KinpvPW8LZ7botwGb2Vf
	lgoV30lfxkma06ifllW9Tr5xm2WgzobOH6rGieS5pYZliHdQlZUXNe4NdDbmtdVZFOme/RnNfMR
	a6eZHUZp7d64A7iu5SmiU+qXwOLx+ZcYN6kUh1npWzzpMv4I7Tophsfc0mnJArwKzzYmNd245gO
	kDMuP93PJOsYCba3ivg70keOiXXO6O2Jw1HSq
X-Google-Smtp-Source: AGHT+IF1KL+OjBOZSU+gCRLAhbGVwiPhfQYjmorFiabmW6yNiu9RfZnspKOYGD4xgUPb/Ms+9XAT1w==
X-Received: by 2002:a05:622a:40cc:b0:4d2:c24f:848f with SMTP id d75a77b69052e-4da422ec59amr40594341cf.0.1758800671451;
        Thu, 25 Sep 2025 04:44:31 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.167.23])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4db10874b0asm8646661cf.25.2025.09.25.04.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:44:30 -0700 (PDT)
Message-Id: <pull.1977.git.1758800669.gitgitgadget@gmail.com>
From: "ions via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 25 Sep 2025 11:44:27 +0000
Subject: [PATCH 0/2] libgit-rs: add get_bool() method to ConfigSet
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
Cc: ions <zara.leonardo@gmail.com>

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

ionnss (2):
  po: fix escaped underscores in README.md
  libgit-rs: add get_bool() method to ConfigSet

 contrib/libgit-rs/src/config.rs    | 24 ++++++++++++++++++++++++
 contrib/libgit-rs/testdata/config3 |  2 ++
 po/README.md                       |  6 +++---
 3 files changed, 29 insertions(+), 3 deletions(-)


base-commit: bb69721404348ea2db0a081c41ab6ebfe75bdec8
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1977%2Fionnss%2Fadd-rust-configset-get-bool-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1977/ionnss/add-rust-configset-get-bool-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1977
-- 
gitgitgadget
