Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3F29A9CC
	for <git@vger.kernel.org>; Thu, 15 May 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747314714; cv=none; b=ENslcxXdXZW7bUCN1yHqM1hj5TOm4MWm3oi6bqyD+3vrabBUfswW9S5ovFbM+YESqZ/HyzdUe/t6PrsaA24RshukSH/nshOxyjDvspEBzSnPaXdcs2IkTSqPOYZeN7kLvaZ0vZm22IjgdRZmbjD7stt88lV+TLfzWH+FXC6BVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747314714; c=relaxed/simple;
	bh=1KIV0PCbhs/IQwniGOmuDwM9QDmLM4QDABmVXK4ixg4=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=l2LizzwHpW9vOdqTaw0PML9/dALTfPRm+tH/FYpWVTu9RgoNmvtVPXkKGxfgDdLZ+7vdUb0mH+WmWDcjMD8UGQhxYPKRuMe7C7eJkFctu0/ulVioOuTNBB7iB4JfbxxkhCRK6d0rHe7dBsmu0nM3RuDIjrDk9mbekpAUsxMdLvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R26QKSA8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R26QKSA8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so7051495e9.1
        for <git@vger.kernel.org>; Thu, 15 May 2025 06:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747314711; x=1747919511; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8C9cZ0IuXSPGjSXsfTlt9AYszR6DTc3L3HmZ9U8PAIE=;
        b=R26QKSA8HHvUF5o3MGgqgrVmERASPHoCMGS5zLY1kqvXg/sQtnPzsl1+DH8JhxDqhM
         LlMTovhTBpbXbE8o8BpkKP5K9riv9UnTnX7rsM7+0iDJkFOGIiraWLsu9jsb62Pz98Pc
         pWK20GeZ9fT43diR1fpMkOPijbOzfA/yAlU3rvKROnEf73KpbMXfsrj5J5nPNIdaTBV2
         G5bklZIH6GQjKFzE5WYQy+BhcvcgM9s+9quh9b5yYwrHwDZ+I5fnxUA4SS4h5Dtaef6S
         5UixsiyixK9YOeiDhdK5ywRls9/JJGhw0qmhPWPUOHX7Pfe2niyMhZYyfELAp84C2CC+
         UExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747314711; x=1747919511;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8C9cZ0IuXSPGjSXsfTlt9AYszR6DTc3L3HmZ9U8PAIE=;
        b=Va5MUdUcTPhBK1ncaZytY4iLvi8cP9hu6z1ZyGrxL/TQaVCIyyzepjES0jvJ2j9AOP
         wmRLyVgFu9sxvrej3XxE3JgKyGv2k/QMmtyfXmgmfArHgAGnN4fT+LuJxeqw2vvdEj+p
         LaBv8WHk/KThhd85G7Qpx4NpbAVj+mFqTo74CE6PKGBze5KEQ3mtdm9moddxZNVm24P1
         7xlwcG++1GrY+aPG7wtIDhbON3uAQ3ge0d8vpd9TNDu08z/k2WT3zyM0YXd1yFLbRE69
         khJsLQsThB8SKKR1JA/f+AvlwnjcbZ6jxdNa57LRfCwumXp2JFnpyNfQjlk60x1LrWuv
         SBoQ==
X-Gm-Message-State: AOJu0YzYF0gpq4+TWOtho1dTdn76aUArrpIVGumZE5C+7Ag09tXqktN3
	2UdLsrg18yVT2Aa3TsTqN3L73Y28gMgsZznfINGbC5nBLeKEAqDZQNk287Hlpw==
X-Gm-Gg: ASbGncvhRVpGluDz14gCQKkR9c/rFoEFjy/ugvLizWD225bPKKxaue5vMroKKcbX+o+
	OCN0aXT2BUim4dBufsNmbdy1Wggv5fF7TBji96j6XNKIBupI+yI+2Vp9yFIJwIwR5h6TIi5ciOt
	P2EcmaE6sXb/Kake4Nq/6ZHH+86zx2lVbpKD3/ZBCKZR935rO2Z0b+idMgWmIEBs4ogAtelRCO4
	+t4g3u8Mwqk+JHIcLAi1Qd6hpXLRFqF+OUcKgaLAKPPUlutF6yxpWHJQJaZ/+z8wgIGRAg12k6D
	dUw1vj6sslktlUgVvOmS9lj0cG+kYpzauKTsya8FzzeFpOANURtN
X-Google-Smtp-Source: AGHT+IEomt+5FKmz6JM8xTLDESsQmQYRLAiKGzPaXlXnyzSqUUD5YvYrLmQWJTIEqn2RtkAoMzL6QA==
X-Received: by 2002:a05:600d:19:b0:442:7c40:fda4 with SMTP id 5b1f17b1804b1-442f84c209dmr31528305e9.1.1747314710949;
        Thu, 15 May 2025 06:11:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm70736265e9.6.2025.05.15.06.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 06:11:50 -0700 (PDT)
Message-Id: <pull.1891.git.1747314709.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 May 2025 13:11:38 +0000
Subject: [PATCH 00/11] CodeQL-inspired fixes
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

CodeQL [https://codeql.github.com/] pointed out a couple of issues, which
are addressed in this patch series.

Johannes Schindelin (11):
  commit: simplify code
  fetch: carefully clear local variable's address after use
  commit-graph: avoid malloc'ing a local variable
  upload-pack: rename `enum` to reflect the operation
  has_dir_name(): make code more obvious
  fetch: avoid unnecessary work when there is no current branch
  Avoid redundant conditions
  trace2: avoid "futile conditional"
  commit-graph: avoid using stale stack addresses
  bundle-uri: avoid using undefined output of `sscanf()`
  sequencer: stop pretending that an assignment is a condition

 builtin/commit.c   |   2 +-
 builtin/fetch.c    |   3 +-
 bundle-uri.c       |  12 ++--
 commit-graph.c     | 148 +++++++++++++++++++++++----------------------
 help.c             |   2 +-
 read-cache.c       |  55 ++++-------------
 sequencer.c        |   9 ++-
 trace2/tr2_tmr.c   |  24 ++------
 transport-helper.c |   2 +-
 upload-pack.c      |  34 +++++------
 10 files changed, 130 insertions(+), 161 deletions(-)


base-commit: 38af977b81bbf8ce8c0004d3f4046a823ecb30a1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1891%2Fdscho%2Fcodeql-fixes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1891/dscho/codeql-fixes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1891
-- 
gitgitgadget
