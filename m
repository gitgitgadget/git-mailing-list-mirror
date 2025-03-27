Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C681F8736
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073562; cv=none; b=g98HoLNW1mR7f+uKTB0m1cAcXAxTyWo+8cgkME/LgI0+FmrX6wHgFREH47XLNh4E6yYiRoLKu24QzDn4205ohym4K4o5LGMcFLLVJ6ALfGAJIo4B709pyb+Y13gMJwPk/p+LKfl9l6wQe6Udf87xQl/zFdc6sU+bHF3HM8cpwFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073562; c=relaxed/simple;
	bh=ragUzQ5O/wX/TRwTALbs6BHIiTqcBq73j46Q1y5aXOg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cq1C+qb44v53kFj6/anwppGZNWm9n3f1uTyE+lYREGuvGcyFEd3lZLhBPROlSBJbsxFB3rDgwzXRP4ErappugQfmd9icbC2MU+W0cxCpAbYGW9+5KLHJR8ly21vLWe5i3NrdSMYcMWh1xPf0d+D0M/u9okULgNXkw41GlruDwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNeVBYFe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNeVBYFe"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf257158fso5829165e9.2
        for <git@vger.kernel.org>; Thu, 27 Mar 2025 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743073559; x=1743678359; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vn73IO/BBdWzdahN4n7VsOgxFmrihYjSf3qH2SOmk/Q=;
        b=GNeVBYFe1dxlvhTNgXi0CfK4dmBRA21xNiqz8xJ/ov3wmPBzYjxBHrhAZpyRuJoqpk
         4XTKGOp0KX5oUPxZxQ8R62bvLg+1etR/p5ECzXIHGHuGus27jX3vi6pdJtSV/9KFapqx
         QpVUWW1gL/ipgpSryXbOy6gxPRkk8fuG+lNgzTOzlL2Kmd1lX1Sc/VPMRYFdnVXVLYFa
         ixDMryyEG5px64zupHtNA6tUyaOCnelWLaaIGBqZIcw/ZaPu0iek5t+viWDd/B0C1Lfu
         DLKpQQdz5ympyIJ9Rlkdv/RT5N42+Vcs7fKSMGk3nbAgjeBt24jOeO9imPmogT9uq8Go
         LJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743073559; x=1743678359;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vn73IO/BBdWzdahN4n7VsOgxFmrihYjSf3qH2SOmk/Q=;
        b=B4tMV3TZll8jrQRs5rM2HRM2r85MN6Mhot9KJUEV7mduGN8VidBOakvxf+VhYWBKHF
         YLDx+QjZy+iRIX3VcR4zGxMrp97IQ2Z6d7EzK9wSxq/jixqoqcuh9gwjb7kNe0b+KOJD
         5XQulhHvsDH7LFKSKIHKYey1MJSu8nBh/i8FCMHbDzxgRiOlCU6rUQ6knwLUYqPF1gqN
         BG9bxXs38pf1nVMuhNdcQiEBKhNSKXuTtcasMywKDsTK4w3/gEC3PsxzJ7tBbKAa2lfr
         elfKNNMeVX8VbgBvxxEUavaZE7iKMlew4LjXkHH4KQW5wj8vxMuaR99Bz9j4VA+oMytj
         I7Lg==
X-Gm-Message-State: AOJu0Yyu1Kk+F75hI6+gHkJtJrcQRzL5bV8CztpPfLUrl9/mO5H8eUCR
	VaEhiFSDKWGO1tfQSLoEOTlSoyaapA8sIBhNafT22s24GmPQNmvuEwFuww==
X-Gm-Gg: ASbGncuPuRpZhAv+10emwQEA/xiytue9s130nYhaOxiC01lB9ZQCU/25qMoFa8cI2G2
	ouGzRZsOFwasZd5D80g7va5SJIVIk0PKJYNqtzBJ6aGrYauhck5SeJYoC7ALP6UyYgShMabmJOa
	YQedCtwojgwlNpCEpXV5bbq2SJCBkFPsk1ule1n4W3rZex/+bVxhO37ML4SOpWCas83xQ1ulpdL
	hq/OprmSsLqcTICu//mGhkxIIb6ab2Ok+vgvRgfhkyTeMNMf+RT/GF1XpLOIk8XtJoDfLjqbdMu
	yvGGFsyRjPVdG8RHFQxv93/JanVB3HyLKF91cbmSQ4lR72fkKCN4L9VC
X-Google-Smtp-Source: AGHT+IFKrWhifRwzVFcdYBikipUBO5/lw4Nn2K+lqsQnbkofhiU1mZZE0oahvso1t+/XY3YQpclwxg==
X-Received: by 2002:a05:600c:4ed0:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-43d84fb6014mr26710325e9.15.1743073558563;
        Thu, 27 Mar 2025 04:05:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9efdedsm19774489f8f.96.2025.03.27.04.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 04:05:58 -0700 (PDT)
Message-Id: <pull.1887.v2.git.1743073557.gitgitgadget@gmail.com>
In-Reply-To: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
References: <pull.1887.git.1743010011.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Mar 2025 11:05:55 +0000
Subject: [PATCH v2 0/2] Range-check array index before access
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
Cc: Jeff King <peff@peff.net>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

If we want to check the range of an array index, it makes much more sense to
do it before accessing the corresponding array element, not afterwards.

There are two more instances of this in the clar code, fixes for which I
offer in https://github.com/clar-test/clar/pull/115.

Changes since v1:

 * Clarified in the commit message of the second patch that this range-check
   technically was already right before the array access it wants to guard,
   but that it still makes sense to move that range-check to the beginning
   of the loop condition.

Johannes Schindelin (2):
  diff: check range before dereferencing an array element
  read-cache: check range before dereferencing an array element

 diff.c       | 2 +-
 read-cache.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1887%2Fdscho%2Frange-check-array-index-before-access-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1887/dscho/range-check-array-index-before-access-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1887

Range-diff vs v1:

 1:  ddfb44ed924 = 1:  ddfb44ed924 diff: check range before dereferencing an array element
 2:  d4e94a243b0 ! 2:  73cae301293 read-cache: check range before dereferencing an array element
     @@ Commit message
          read-cache: check range before dereferencing an array element
      
          Before accessing an array element at a given index, we should make sure
     -    that the index is within the desired bounds, not afterwards, otherwise
     -    it may not make sense to even access the array element in the first
     -    place.
     +    that the index is within the desired bounds, otherwise it makes little
     +    sense to access the array element in the first place.
      
     -    Pointed out by CodeQL's `cpp/offset-use-before-range-check` rule.
     +    In this instance, testing whether `ce->name[common]` is the trailing NUL
     +    byte is technically different from testing whether `common` is within
     +    the bounds of `previous_name`. It is also redundant, as the range-check
     +    guarantees that `previous_name->buf[common]` cannot be NUL and therefore
     +    the condition `ce->name[common] == previous_name->buf[common]` would not
     +    be met if `ce->name[common]` evaluated to NUL.
     +
     +    However, in the interest of reducing the cognitive load to reason about
     +    the correctness of this loop (so that I can focus on interesting
     +    projects again), I'll simply move the range-check to the beginning of
     +    the loop condition and keep the redundant NUL check.
     +
     +    This acquiesces CodeQL's `cpp/offset-use-before-range-check` rule.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      

-- 
gitgitgadget
