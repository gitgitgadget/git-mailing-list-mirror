Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9F714B097
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722550231; cv=none; b=tA+MdVI4dUAqUpIIWfmBh8uFSGjOKIOQD2ELMhH58kGcNEU3qfM1ivQwGRrGC2alnd+8+nvSPXSLPNLR94HBNuw8v9LnhgW33XnPCPlDmtYj3//4/13N48fyquObCELbCh9ppiDtdoMMm1AJBmmzvex9PbYgF6oPy9EuYHeDtYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722550231; c=relaxed/simple;
	bh=18abZB9C9H+4L0y6rray6yp8uWbByD842tPUo3+WUsI=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pd/pMEKLtGfWBm1sXYlMsXirBkufxfWBHk2lS1I3I+IyEsQYhQ+hjUm6sPnNxBOdaoHpV0bK1MVtR3yoJTK1y2j1aCe1+48XJ8WZLPC2ZMomFAexJPf+XrTZUycoKhI1hX7FxVYqHpsZuSIbcIdK5dSHZCHHs6zUtrr4iH3RR8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBCsYohD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBCsYohD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3686b554cfcso3789171f8f.1
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 15:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722550228; x=1723155028; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SZiPkZYEVRxV8N71u/AlV+s0sfxMfORdOGPgiOrjLbI=;
        b=dBCsYohDbqVt4JDbxyup39KnQgTjSl08HpqSdsJ8hdAHDys8YUACsCu7Y0uMQYeFSh
         oDDJQFb8s/F1eVK+CjXeVv97uKa8+aw28zcrX0BaI5wQPD4AR2H19PJ2b4gsGtglJ1mT
         MiD3Fix2ybyIcSpTydVLiQ4JQ1E4E1sJVrA6LSs9Uy4vG64lnhjIDXfEay2GmlbYCSOq
         AVdNphXuf+lbR6iOVR02Sj1caCufyH2IianFlTcOixc0fYznMno1NKMjwG2ssqdusMPF
         bKsis+hAPEuWtdL5F0vyjFl5dqvNHn7fttXRumddb7QdDqcC+D+9LnL4PVIDjWK92fWb
         BJCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722550228; x=1723155028;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZiPkZYEVRxV8N71u/AlV+s0sfxMfORdOGPgiOrjLbI=;
        b=bvWA2/7osg7WaeOsscxfYehSFFnzO5/sdM8tFc5C/EFMYC6UZ6GUh2FNfKHvLRcaT2
         oP4T8dumGc0YMFBZY0y4gUOo6t5sj6b11VflOW0VL9XVGCLUpxQQ/k8rwUt6l93Zmope
         n/bLmBmBU2zb19tJ7roO2qBzKQL422DkbQPlLzkdOuO7cjwZda3rlN1Lt+7fULR6HXMr
         KhLWlRVGHwnQEQXnS+tSB1uS5OcjbUlKHRTCvbqvAMn5Al+sPRnX6pm7/Q+2+EvZBaxd
         MQIN2JDL4QsDzh5TzgVX+IYyxJhldfcJqrMNquvjAnmPJr3U/QvcMVYUHa8cXd1BnQ4q
         voBw==
X-Gm-Message-State: AOJu0YzRdOVdBxG0SmsAouVD/8YmZWMnqXjBhQnRjHwUGDaljKpf8faY
	ADBjkwG2JT850zAjRWlLK412XDH67DsLxL2K81hEySY+kkTAzybWpdIC9g==
X-Google-Smtp-Source: AGHT+IHdNUhSfVJuNgqHWFwwgSiSNBLxXorSS4yluIxM5qoEWo8l3VYVuJ2MPy5l61BFNK8vwEm49g==
X-Received: by 2002:a5d:49cb:0:b0:368:7e10:6995 with SMTP id ffacd0b85a97d-36bbc107e20mr657476f8f.17.1722550227544;
        Thu, 01 Aug 2024 15:10:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd059e18sm483857f8f.68.2024.08.01.15.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 15:10:26 -0700 (PDT)
Message-Id: <pull.1768.git.1722550226.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 22:10:23 +0000
Subject: [PATCH 0/3] git for-each-ref: is-base atom and base branches
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
Cc: gitster@pobox.com,
    vdye@github.com,
    Derrick Stolee <stolee@gmail.com>

This change introduces a new 'git for-each-ref' atom, 'is-base', in a very
similar way to the 'ahead-behind' atom. As detailed carefully in the first
change, this is motivated by the need to detect the concept of a "base
branch" in a repository with multiple long-lived branches.

This change is motivated by a third-party tool created to make this
detection with the same optimization mechanism, but using a much slower
technique due to the limitations of the Git CLI not presenting this
information. The existing algorithm involves using git rev-list
--first-parent -<N> in batches for the collection of considered references,
comparing those lists, and increasing <N> as needed until finding a
collision. This new use of 'git for-each-ref' will allow determining this
mechanism within a single process and walking a minimal number of commits.

There are benefits to users both on client-side and server-side. In an
internal monorepo, this base branch detection algorithm is used to determine
a long-lived branch based on the HEAD commit, mapping to a group within the
organizational structure of the repository, which determines a set of
projects that the user will likely need to build; this leads to
automatically selecting an initial sparse-checkout definition based on the
build dependencies required. An upcoming feature in Azure Repos will use
this algorithm to automatically create a pull request against the correct
target branch, reducing user pain from needing to select a different branch
after a large commit diff is rendered against the default branch. This atom
unlocks that ability for Git hosting services that use Git in their backend.

Thanks, -Stolee

Derrick Stolee (3):
  commit-reach: add get_branch_base_for_tip
  for-each-ref: add 'is-base' token
  p1500: add is-base performance tests

 commit-reach.c              | 118 ++++++++++++++++++++++++++++++++++++
 commit-reach.h              |  17 ++++++
 ref-filter.c                |  78 +++++++++++++++++++++++-
 ref-filter.h                |  15 +++++
 t/helper/test-reach.c       |   2 +
 t/perf/p1500-graph-walks.sh |  31 ++++++++++
 t/t6600-test-reach.sh       |  94 ++++++++++++++++++++++++++++
 7 files changed, 354 insertions(+), 1 deletion(-)


base-commit: bea9ecd24b0c3bf06cab4a851694fe09e7e51408
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1768%2Fderrickstolee%2Ftarget-ref-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1768/derrickstolee/target-ref-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1768
-- 
gitgitgadget
