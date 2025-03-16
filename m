Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA3E140E3C
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742108344; cv=none; b=n8x+mbdUBWYCFLHl0N7/gOKs8ZQhRqoHvh8N+m75j9FyvE+GjmrZXAmo1SYu5OPszSx3bCBb80vlHKX5pskkvrtGocYJurqd/tpD9tEE+iOchhUb2zPrPCFnaDLEFuuxOeqgCPhbvRowYSx2ilpuhHddJpJy4dGw2tqRNQATqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742108344; c=relaxed/simple;
	bh=apP5UqMZGXwb0DZ88mta8rRxcDr+aebkLur4UtaB6Do=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=G49bRVG7Ni/s5JPBcGMIJdB77rT49TMFYwLJYBg2cP3Fnr2QFz3R6ECvKiToN2S3yW2435tsQbz6Vc2+PTXt5dzVM20oDc94zqNxMrt6YPwychafK99/S7Y9/sQW8y/oEqh6rNOMO/HxTYCUt4NX80o7aXL5WFBV8F0LXv3TWnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhEoJbmp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhEoJbmp"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-39149bccb69so3237149f8f.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742108340; x=1742713140; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pEzcRiFgIMURa9nqT9zJfnAId0aaeDxMsudrucdW6H0=;
        b=XhEoJbmpSGrplvU/BYr40rezk9xwZ4QHHIWr4urLN3g9TJN3W5D3JDWeryQv0z7567
         PD76woWQJ/AyNg6tRGhf6FEDrbjY/F0n6/vQ99XOHKmorNMn00sqqRlArUnXF8Bdw6V3
         y/fT/LKkoWiUpyy+pDmCSrdMNQ/rCgWTir6Gn30SQKJlEv87EEDGjy7GM3QK1TGzKSe7
         opUYW61NWX4sISXDIATpktVK0iUM99joPbqD6UYCD4zW5CB4H0TEgD/7u+HGJZKjqCc1
         81gzE9idgtUbIUBoDUPbw3+s6QEr8hMVwZyaOpU0mWcEtpSE789NPyT3wet7XcR6acnQ
         22WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742108340; x=1742713140;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pEzcRiFgIMURa9nqT9zJfnAId0aaeDxMsudrucdW6H0=;
        b=eGBMPNXeZ7dABUN1aCr06iJqCt4FvrBgb+Gijy0qBnwjI+GIUFWH9RP7xxEZHorivq
         fOOx75/Zr+7B/AMthbH7wCRemrXJlkn4pjkDPQkxngWD1u5lopaa+J2lwrlx8g2doqT5
         A6S66OIAwibAEyxNy4deQ3e0VJgAIUEb8vZHcLQ6wYD1h022BqD17WS2TxVu7ivU/siY
         Tv8M0PYw0ZrNoPCFBmtlZ8pJHZskHTnnFdDi5gdOH4XTMC9486hVxNo53/MMjSPSWK2d
         1bb5603vBWeGsGEKBP8FcAML0DPtJw029Oh36Vq5QJMCIaOjDXFaajBXByYAdja53i1l
         P92Q==
X-Gm-Message-State: AOJu0YxotPqvVIULgMdykK2LReThztO3IIsKm9PJui4wAJAmqHRHwgvG
	b+wGpvWcybYv8vx7/HXknELrt3xFPMNcuuwG11BgK/SVY35pdmOB2+7hcQ==
X-Gm-Gg: ASbGncuUlSU8bWwDHsf8lHiBVjLeSnb71D/xmfkbOCFVMfH8zhpGwEuM4rdA0wdOf7D
	Yr70XkLepAcNAIR9gYcnfiattLnlxGwIO3OagyPNTwL6d1vxtiH9Bkpc+750WiEz0fjMih22klB
	ry8WfmIG8TeRgecswlbcWq2fRTg2eFKE0tLoOsYW2dy3EDyzr5mmb1j1VEL/My/t7UxvzRH2Mem
	u5z0+qrcnXrcwWfuBp8aLRWHqBPbjb8WdR3jzFBEQG5xk69zc8KHKA8pftQmkJC6z/jYedi14I8
	TzM28HEbAEOalVAMLo5p7dBIG0G2EvXPPeqZZTeaFKSsDQ==
X-Google-Smtp-Source: AGHT+IGCLOA12E3xJZKVUBs2J94WqJ3BH3M1C6sSn0i0DJmkgkOJ6AON24RZ/8fUUAI9OUPkMMV0dA==
X-Received: by 2002:a5d:6d06:0:b0:391:2ba9:4c59 with SMTP id ffacd0b85a97d-3971e971f44mr9864802f8f.43.1742108340299;
        Sat, 15 Mar 2025 23:59:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6b37sm11362784f8f.37.2025.03.15.23.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 23:58:59 -0700 (PDT)
Message-Id: <pull.1882.git.1742108339.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 16 Mar 2025 06:58:54 +0000
Subject: [PATCH 0/5] Miscellaneous fixups preparing for the removal of merge-recursive
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
Cc: Elijah Newren <newren@gmail.com>

While working on the removal of merge recursive, there were a handful of
miscellaneous fixups, none of which changed any behavior. Each is a very
small localized change. This does not depend on any other PRs, and in fact
each commit in this series is orthogonal. I'm just grouping them because
they are all tiny, miscellaneous fixups.

Elijah Newren (5):
  stash: remove merge-recursive.h include
  t6423: fix a comment that accidentally reversed two commits
  t7615: be more explicit about diff algorithm used
  merge-ort: fix accidental strset<->strintmap
  merge-ort: remove extraneous word in comment

 builtin/stash.c                            |  1 -
 merge-ort.c                                | 10 +++++-----
 t/t6423-merge-rename-directories.sh        |  6 +++---
 t/t7615-diff-algo-with-mergy-operations.sh |  4 ++--
 4 files changed, 10 insertions(+), 11 deletions(-)


base-commit: c9d3534de317f31915f37e9d9c0d52d4cf901482
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1882%2Fnewren%2Fendit-misc-fixups-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1882/newren/endit-misc-fixups-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1882
-- 
gitgitgadget
