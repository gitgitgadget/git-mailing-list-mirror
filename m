Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E27B322B
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 12:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743079433; cv=none; b=f4h4cWYeYsYTDF2bfOE7Ygu58I8y/mTUB700ne/ylyGWM3lHv0Go4JEw9CEVAUmm8ELcfltLXEylnMm8w1l7gk47IShgxMXLphW1nHMXcsf41d7+FbwzZx0PxrClTeQ1aj5mXAHzSbxA2lWFqEYxLfWwm11O2wLDCSXLAA63Noo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743079433; c=relaxed/simple;
	bh=2YN096XaarfBzazyMx6gyVE/si1VsRT+mpAKsDb1pPI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=O0ajPvPvrp6gTq0Augvv6XCqBe2449pS0l6hTNer6wBJ+vqYhNWde3YQqFYfi8NUWYByIJiTFDIzge98dYFsPZXCIPA1z3tQ9lVZW5nApZ2vc9sBqpMtE2nmDi7KSMgRnkiH883F0XVj6hHppq9urtNPKyw6zI96runLV5ALNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMsDtPiy; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMsDtPiy"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso6900845e9.3
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 05:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743079430; x=1743684230; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R01yEEu9dei5IhsBCMvUNF5aiSiIM/m0lftBxo7zjm4=;
        b=SMsDtPiyOafgmfYt4y7qpzdS96+vn4zDGaG3HOrEbt07WKajrF+9o4IwIG5kxASzGs
         UV2dTrXCQsxqmBe/B32vsG6Asf2T63yIgc4PZZUZZjMtd9MbzPNJzRM0s7u8Wmec2WzD
         EIruW5AAsqtyJHN0NXy8AXgRq+dRNtQ6wmo/Br8TP57rmYqne9fl5/0Y7z0rY+Kveeoy
         hO3C5kotIKchPUhLUgDh8DKruPrT+CLOasRpZrWanURX4ojMv23nAYLHSxcnRwEi8HCh
         Qmnfl1yhaRLaJhmqaP2KRnT54a7aQkR8YgP7ZKecbWbRdOacSVgffw8EZt1/+x20aSnb
         +ShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743079430; x=1743684230;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R01yEEu9dei5IhsBCMvUNF5aiSiIM/m0lftBxo7zjm4=;
        b=iAQEa79yzzHuFWciRsyrFg1W7dL9HBZQFDSVFkr6nFLVML1+BrXGF/bIFkZ6D/apCc
         czT6Kx2VDcjpy/dPrJLzj6SPSOkTeUuEmBvQoJD5sMAP6DSIqgeQOZjkrNkzzRgA8lQt
         T/aQCTFPKGXkTNMoqVVCHZnWKbRBdwAtf89kBNs+Jnj6wxPKqsQ8v6zdLdTy1nLRTm8q
         hsQG9854Y/nFSj690aa1yZibI8WrSmR2dBPufGykHvV6kJL1Tu2vBF1GvcTWNvh/8kGk
         4E1Ul/RRbvJnHXJScR7jZTdW6W9Nav2C1vIIcKICU+ADFVWtcu9ngmtfl9BoFkDxlsdX
         Yfdg==
X-Gm-Message-State: AOJu0YyoRAKIRx6UZRMp2rKk7KmUV66fZwOMTcH6ge1h6VULYqIv6/AT
	d8lY+ZAh0IpGK7vRq1h8Zi37M/i8Ri62BoZ5pUBfAl+VS44+Swlil0XIwQ==
X-Gm-Gg: ASbGncsbLbRxGstTDPPMp7LPMpbI742pmxIBx0lfgSrwzSUph5By69tKfI5mS523jUE
	RgBjbk0YHW1w9pjma9Eca1UE+BkEyt0w9CAhfzak+m6iJnPuCHKQnR7j0g6E3EaTmu6LcgSKAoQ
	205Eegjq7nZqkjszKt6GEFEYD2y78B2sQGXEyi1HDZn1RgYoov6Du0A72ubNElM1+YAArc7MZIQ
	cDJBYJxBEVuG6LHXL6KaINnkYsE/O6ouI/D8w9AAw58cUILcDt0DKzwP/lc4+P7G5O6zw8C+8Tq
	dNp6C2EphfjEChj2NTo0aN6HC6oY3XhtejqJ0ojeeiLUxg==
X-Google-Smtp-Source: AGHT+IGouXpP7aTlzislogjffVOFuxNDlH7MLQgXsCR+OG0VZ6TXo20IQR/uV8NbeVDB2Xsy3RSd7w==
X-Received: by 2002:a05:6000:2ca:b0:391:487f:282a with SMTP id ffacd0b85a97d-39ad178c955mr2667470f8f.50.1743079430130;
        Thu, 27 Mar 2025 05:43:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ac8745d9csm8051581f8f.95.2025.03.27.05.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 05:43:49 -0700 (PDT)
Message-Id: <pull.1888.git.1743079429.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 12:43:45 +0000
Subject: [PATCH 0/4] Initialize a few uninitialized variables
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>

When I ran CodeQL on Git's source code, it said that that variables might be
uninitialized in a few places.

Johannes Schindelin (4):
  cat_one_file(): make it easy to see that the `size` variable is
    initialized
  fsck: avoid using an uninitialized variable
  load_revindex_from_disk(): avoid accessing uninitialized data
  load_pack_mtimes_file(): avoid accessing uninitialized data

 builtin/cat-file.c | 2 +-
 fsck.c             | 2 +-
 pack-mtimes.c      | 2 +-
 pack-revindex.c    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1888%2Fdscho%2Funinitialized-variables-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1888/dscho/uninitialized-variables-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1888
-- 
gitgitgadget
