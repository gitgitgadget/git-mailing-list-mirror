Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513D12D770
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707212988; cv=none; b=EZlyGBbx4/YuE8sRnpk809zOmUQ9+Q6AqpAGB7muQOUMKC4ZkcWVpOzq9VwTiOvSKp/0h3634HfZ6DmD5matyVho0Dhi74mZyXqxGCPDbo6tpdYZs//mnkeuMl+DT1FkxSOsxwVG1anJAnY2cp7EdPl1As4bNEBiwSv11d/Qlts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707212988; c=relaxed/simple;
	bh=MGWIqPFeek6AFznRhcmOEbiA/DCeJUYqu8wefCTrEGI=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=HKV/veo7dcbKXKzufK1AsUYZGNUqonEmWlPXD6R/Cf0/IKSMdcDREL0vStPR2Su50/g9hpBBb1YPFIwMlaoJlej+VFkFR7VHMIsn/rnMPIghesynZ4rvXLnFmlw8HAFvSZAHrMIwtR4Ehak3/zJLjn0CHTMVvrul6yQ4XjJG1xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Knj28P8c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Knj28P8c"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fe79f199bso1722905e9.1
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 01:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707212983; x=1707817783; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=00eylBT2p3AsuzOj0/01BSYA1Mt9fCjN9hcSVfDbm+U=;
        b=Knj28P8c4xIDpKCJ964MZ7uQ9AJwsICiJ+lcMTE1andVC3znKAkNgCYZLJ7w4EXN6T
         iOte7H9EdY3vSab381LNhJOjcIvHl/hMcH3a4LO/ou2Zs/oZuW6WEJc9+ssAjsw4Ojdj
         cWNZOCKC683aLysf/3cTYLxT9qmbN3XtQCk/FXdMNexzT2MWmy9iziUKKfxTBjrQR4hA
         aQ3nKV33J3u+88bzgQ95Zl5320OidvIZYnFZJxLpVGboXEM3oqkLHcg47epviCecQkvU
         E23l3ou7WXAnV5FZmIdoiynz1z8CR34/SZmRwgyD6fNTe0CRoRya2EucjpMT3BaUNq/w
         OSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707212983; x=1707817783;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00eylBT2p3AsuzOj0/01BSYA1Mt9fCjN9hcSVfDbm+U=;
        b=pWKYR+8WtOHCMyaJGCPyussWHBi+RtwNYxvi1nRFbvNw1Mocz1ZNhsOWxoWUq/nhcA
         r4c96EBdustbjF9xIkMHF3s1UYSFzWSY4kJU0TtxCZMJQak9t0W2zNOQbPkxvlMyeIG5
         pSBxOt00lZxdTOUEYZqryKOTLPsGyR3U1LBup/9zrbe4qPN7nqEgBgliPddkWpVNSezA
         rvWrPddYlTKtsbKKxWR7jYhPKEE7VDU4FsC0cYSCZa28+BHWEbUvC7KhpGZIBF1w0y74
         QduoyE1frmWgjy2txBdtGdwUDMTL6PTDyNO2y10DzBNJlprkY9uO6+PWAQwZfiDFEaph
         xwSg==
X-Gm-Message-State: AOJu0Yzg4ylH2/j2635eHDyLq6G1RGtUaz/1kRiXbjYYIy6xtYm320bv
	61yztu83pGbsdUmJwOdUADOxRXP2lqFr+8s856WpNm3PAz5U4nx8q6yrASee
X-Google-Smtp-Source: AGHT+IFEZy/+aDwluFdnF3zHbUmJVo8jWmDwJ9JLCn4TYiThRgvGGElnmDhApcF4Kva5WSpGV3v4Fw==
X-Received: by 2002:a05:600c:35d1:b0:40e:fb93:96a8 with SMTP id r17-20020a05600c35d100b0040efb9396a8mr1749192wmq.34.1707212982646;
        Tue, 06 Feb 2024 01:49:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n33-20020a05600c502100b0040fd2823f52sm1437856wmr.2.2024.02.06.01.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 01:49:42 -0800 (PST)
Message-ID: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 09:49:37 +0000
Subject: [PATCH 0/4] merge-tree: handle missing objects correctly
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

I recently looked into issues where git merge-tree calls returned bogus data
(in one instance returning an empty tree for non-empty merge parents). By
the time I had a look at the corresponding repository, the issue was no
longer reproducible, but a closer look at the code combined with some manual
experimenting turned up the fact that missing tree objects aren't handled as
errors by git merge-tree.

While at it, I added a commit on top that tries to catch all remaining
unchecked parse_tree() calls.

This patch series is based on js/merge-tree-3-trees because I introduced
three unchecked parse_tree() calls in that topic branch.

Johannes Schindelin (4):
  merge-tree: fail with a non-zero exit code on missing tree objects
  merge-ort: do check `parse_tree()`'s return value
  t4301: verify that merge-tree fails on missing blob objects
  Always check `parse_tree*()`'s return value

 builtin/checkout.c               | 19 ++++++++++++++++---
 builtin/clone.c                  |  3 ++-
 builtin/commit.c                 |  3 ++-
 builtin/merge-tree.c             |  6 ++++++
 builtin/read-tree.c              |  3 ++-
 builtin/reset.c                  |  4 ++++
 cache-tree.c                     |  4 ++--
 merge-ort.c                      | 16 +++++++++++-----
 merge-recursive.c                |  3 ++-
 merge.c                          |  5 ++++-
 reset.c                          |  5 +++++
 sequencer.c                      |  4 ++++
 t/t4301-merge-tree-write-tree.sh | 24 ++++++++++++++++++++++++
 13 files changed, 84 insertions(+), 15 deletions(-)


base-commit: 5f43cf5b2e4b68386d3774bce880b0f74d801635
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1651%2Fdscho%2Fmerge-tree-and-missing-objects-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1651/dscho/merge-tree-and-missing-objects-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1651
-- 
gitgitgadget
