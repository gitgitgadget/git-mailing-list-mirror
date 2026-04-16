Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED28D35DA4C
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776379699; cv=none; b=TD8YBr216fNhlltzIjfPoIqgkpUijykrnIr6X4Rs5A0fU3Y0ap7jEvxgTHkX2qz23GhUyUVLmp7ktx3ebWhT5C+Y1zsNAnJwahPajO/JvpXRfkFkDZoO8+rn9Lw7ujNWk8GJNaOvi52a+5cVbQ4o0BiH0S7MEli1Pr1sUFSZ0dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776379699; c=relaxed/simple;
	bh=cypEsF4Qo/r3cwYGvQlb0Pxsf+VqzfPEgPDXpnY3NPA=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=pJjXYGB5hDVWNUrb07bPe6opRxawYnS8mVQTsHRd+0a+6XsjGkBquuAgf83INdDvSR9YuvLco0BQSrON8JdNEVhUNrEuHOHrCm6uOlwBUL1OFWYxYjXxioCRqNLMAblMDfjyvDr1mtfRY34eJNar9DkT1Szowekr++9Ol2ZXEPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=irKxyoe3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="irKxyoe3"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-506a747448dso743271cf.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776379696; x=1776984496; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Kre6PSaRtlzdhOvA6GUFb+iH9C7FiWtJoENRPqb7D6w=;
        b=irKxyoe3dygMaLaEuRFd8Q1cnABHYu4gCf5gboO9qOGzo3ohlDlxmo7a1RKmD4c6RL
         IoJaZEgVzutf8jwrZomhIBW40Mq6kjJjxbz6EPuE340Wk+QYnNFfzY/mvK8cXgb6m6yh
         Ea5I/jwF+3+VX4I5Qdg4FdjT999JIR2iVj/d5WNBjUau2+u0HxW6i9wFSSwEM8iy+L8M
         Zyym8mPhAtPZY/4tOpZuYGbNyfFyi5E5Y8KfO2chCS0DIfRq71DelIesHhtcFE4/Yvs5
         ZMunzz4cFhk56W7pf1VUXQBQgwH1mHN9H70LohoioeS/KSqQgQHLuULzPJjJanz8K81h
         ajRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776379696; x=1776984496;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kre6PSaRtlzdhOvA6GUFb+iH9C7FiWtJoENRPqb7D6w=;
        b=aruXcMvTthpjynIsRZ0Oscj36j+XuMfneIfJ9wXlZ+2T9vEcGtdHHNHz8srWJj1n0j
         DnR4zbLOjcBHeMkNVjm8VCO/IrG8I+XimMBoDnoGBJCOKrzXMfzqBg2YsLhIvK3qzfbF
         0vzmz6OVgefg2QEIdw+rbzA4ZRntpbg7SWP2usN6qJrpFuKsMgVX9uThavYj2rIFnMBw
         CyBAY8qhz40mKN/E4pGAWCVJnsWmd7iW98tjNE5tXdGGeNKTm+M5181Sr6aoWtyqAdqq
         uDFXv3VmaR+eJdiuZv6K6+Sy/Jywnts0RG5xm1mzLzSsPFYSdFDd9pG+aorSOg4pEJGj
         /A3w==
X-Gm-Message-State: AOJu0YxNEahiCx6awHOIF1EVlMnBXMiCP2zInnL6c3X4o5TZgPh2f45V
	5wdtiAd+nlSmd62NWJhwg/ZoPr9JJeqLZABf4mtsbtwOwHGsrL+gS2erx3h7Wgpv
X-Gm-Gg: AeBDietSqoeckPph4d0KzG5zaLxlqUcG/bwwCnPYdj71Ye/j9ZvZ/xS78ywQHyP3BUN
	2JAI0Pugz+hQg8ynWMixnhUP9vjtotTNUCyIPJEhYVkS3wJ6v6tqkf5wj10kSYgrmMzK91esOmB
	nnyBFvt5pXf2iQToImYuy7OKnux//btXS0gkwe35FceYKAel0ulBR8bZ0cupWUruJlH5OItrAt0
	g7lHGTNeRWAk8ur6sa9+FvBuKYSxz42cSGDi3YbKS/Z+AXUqdhNpy0w8PYBBSZO19RGk2ToY09E
	FS4OuoKvuF6K5n3s00/K2/SKal5RbBMCVSQpZn+Yrj8Ilgcmb0P/qDR4gvRUXHUxhOo/SJap9oI
	xwEfJr4+8U//OLtnecHWMe8AR6beS8AapLKcsRnfTQy0+YnOZwHjwGY+7ViS46Ps9j2zlYT4LNG
	8gYbOL0f8BCttUBbSCTbYd2J+T2C+R+Q+0R+YCCw==
X-Received: by 2002:a05:622a:1303:b0:50d:a8f5:d515 with SMTP id d75a77b69052e-50e36e93acfmr5355931cf.51.1776379696299;
        Thu, 16 Apr 2026 15:48:16 -0700 (PDT)
Received: from [127.0.0.1] ([172.203.213.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1adbcf10sm46181701cf.10.2026.04.16.15.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:48:15 -0700 (PDT)
Message-Id: <pull.2089.git.1776379694.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Apr 2026 22:48:11 +0000
Subject: [PATCH 0/3] Batch prefetching
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

Partial clones provide a trade-off for users: avoid downloading blobs
upfront, at the expense of needing to download them later as they run other
commands. This tradeoff can sometimes incur a more severe cost than
expected, particularly if needed blobs are discovered as they are accessed,
resulting in downloading blobs one at a time. Some commands like checkout,
diff, and merge do batch prefetches of necessary blobs, since that can
dramatically reduce the pain of on-demand loading. Extend this ability to
two more commands: cherry and grep.

This series was spurred by a report where git cherry jobs were each doing
hundreds of single-blob fetches, at a cost of 3s each. Batching those
downloads should dramatically speed up their jobs. (And I decided to fix up
git grep similarly while at it.)

I'll also note that git backfill with revisions and/or pathspecs could also
improve things for these users, but since backfill is a manual command users
would have to run and requires users to try to figure out which data is
needed (a challenge in the case of cherry), it still makes sense to provide
smarter behavior for folks who don't choose to manually run backfill.

Also, correct a documentation typo I noticed in patch-ids.h (related to code
I was using for the git cherry fixes) as a preparatory fixup.

Elijah Newren (3):
  patch-ids.h: add missing trailing parenthesis in documentation comment
  builtin/log: prefetch necessary blobs for `git cherry`
  grep: prefetch necessary blobs

 builtin/grep.c                                | 142 ++++++++++++
 builtin/log.c                                 | 125 +++++++++++
 investigations/cherry-prefetch-design-spec.md | 210 ++++++++++++++++++
 patch-ids.h                                   |   2 +-
 t/t3500-cherry.sh                             |  18 ++
 t/t7810-grep.sh                               |  35 +++
 6 files changed, 531 insertions(+), 1 deletion(-)
 create mode 100644 investigations/cherry-prefetch-design-spec.md


base-commit: 9f223ef1c026d91c7ac68cc0211bde255dda6199
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2089%2Fnewren%2Fbatch-prefetching-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2089/newren/batch-prefetching-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2089
-- 
gitgitgadget
