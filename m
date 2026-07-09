Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EA3EEACA
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 09:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590163; cv=none; b=l+SHMYHaz+8Cl5VfP0A+MqbZ9MLOgbWR9wO/yi8hvidW1EzuDrzzhbaee2K9Q+k2YhxLc4Lb4ZONS+OjA/ACgoIzPc3uYQkg2dBd1dQ9Uz7rmWWwjyLvREq/8mgqNe5chHgrtnv/DZ6xP+IbGrn2+AIPou17+KoJOBh0NP3X/lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590163; c=relaxed/simple;
	bh=P8A/ipAGggZMJJsaF2W0P9RvWlkOA53Easnt4UoU/Ck=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=RKRxv987vo88h6WiQlhPw+wLHT7SYN7YpVwphTY5gfx/gbdkzlysk+5RJWXyg2So5KmFxbPuK39WFHffWFjopmRnfivc07/zTzNBzzu5hwa5DxnlXmpcS8Zc0J1Ii59fTLVl4dEV7B1n9oLwsaWEvrwvDGDcfgqChvAnc3259F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBpFaOU5; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBpFaOU5"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c05dcdf49so15252721cf.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2026 02:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783590161; x=1784194961; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ogt0pWUzM5HqEwJ55FDItv18XmUzhvKSibZedsyoQg4=;
        b=OBpFaOU5gj4WoTGd4BPKymMRtWijpXa1Zasa6hI8UtzmVhjkGgxovJ1O3HY2cQH+AJ
         CF3qd+Ft1VX/8f8xG9X0Afq0q4L6c8m+akJsYqzce6Tc1D0RR/BhZrZufZAfOYwY3pG4
         HhfUvKu1QyQiHWxGtN6GkzAHrfoLYPTsSx0eK8IaT3CkMdOjMHeqs2P5qHApQlE60Af2
         xDoOmCARLkFNajxfPjLhJ+i3JhkWU9XJ3TU4TZHs72o1FSSwwszY4/rwlwxW9omK2x45
         qrTHbYDuIsIqcSkUUIpQM+oO8kyYuRJGkLpYvBQJUMal19yruhqVBG/wHWgjJwTKrq27
         8fEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783590161; x=1784194961;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ogt0pWUzM5HqEwJ55FDItv18XmUzhvKSibZedsyoQg4=;
        b=LKEyhZS/UE/5cadyJvtjgzNlCBUAe6SmEqJD/2QlXR4ehCxmv1QopakV1pYveasph9
         k/cN+U8KIF7ckpzBa5GCrGTBgRROzSZ0qUY9mCrBhLMg6RGYHiysyWZTxdgefzxs4Uhl
         aZ+Ka1ZyHp4l4qC0ubVLWC8LkhCG37O+KCjrknGS37z8qHEEtS3K+Xl09N89Z3sne15g
         3QqWdinhYVcJ6VKXLyufslFFnNY2H0uv7v5lgBCrwiEkO1Y2cTHLlLXWkP3uU9Pmclyc
         QvwNg2eHZqDxrZiI0efjSPqfpbTEoJRjYbhqUA9z+ofjp1PcBj/qPrJTldTJUIjW9au5
         R7SA==
X-Gm-Message-State: AOJu0YxEH2bCm/95sm0h07q8GPSA0aKi4HtEon8x59QTrN5m76tHxnM8
	MJLzS5TLPnyrT1fsPzqa3j5+9ZzTJdnEGdL39CzciKTohuxoiiO09crQRvy8/g==
X-Gm-Gg: AfdE7cmwfNGpFPUSeFnFuYxzteBQpcnJlVQpA8stioCDGSLjf1BhvgkIKJsp7gNNcAx
	9RWZrKtt2G0kHeW2uOtXp1CIRNiq9prKj/4GLc6KqjxCSqb0iJg0dF7q0WxfD113w3yIwknCAHX
	CVFFet+GYu+h5+P5uSzdCxVMXe4xgrfautacj1MlWNPBV7nkmCIs4mFZfMrZs2HppXLm9ZVL8xh
	sPLM+UoylXcTVGYH4/W3nataJogWcNUXBUd5E3O/AdYIVMXR7lZmreAR0rclVQnjjyima50MoBs
	MY7x06ZwiS0gULxg5rA2STuP90doMyCrrFqtkbVaISU2II9G/W9vRc3HH76t4jbz2zjxPpas2Jo
	9XnY+UBuEyHahx5mV7EhGyzH+zUUhvyVVdiGCSWLi5cpe4NDwU7kvI4U3GAWlydyO+ZuQ8sqi85
	Hr6aqgz0M45Ajt4WHVLQ28R3c=
X-Received: by 2002:ac8:5751:0:b0:51c:7b12:5fd3 with SMTP id d75a77b69052e-51c8b4382c1mr67446201cf.79.1783590160778;
        Thu, 09 Jul 2026 02:42:40 -0700 (PDT)
Received: from [127.0.0.1] ([20.84.47.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41d37426sm155650041cf.16.2026.07.09.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:42:40 -0700 (PDT)
Message-Id: <pull.2174.git.1783590159.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Jul 2026 09:42:27 +0000
Subject: [PATCH 00/11] coverity: avoid dereferencing NULL
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

This is a continuation of the effort I started in the patch series that
became js/coverity-fixes. This next batch adds guards to avoid dereferencing
NULL pointers and accessing NULL file descriptors.

Johannes Schindelin (11):
  diffcore-break: guard against NULLed queue entries in merge loop
  diff: handle NULL return from repo_get_commit_tree()
  remote: guard `remote_tracking()` against NULL remote
  reftable/stack: guard against NULL list_file in stack_destroy
  mailsplit: move NULL check before first use of file handle
  bisect: handle NULL commit in `bisect_successful()`
  replay: die when --onto does not peel to a commit
  revision: avoid dereferencing NULL in `add_parents_only()`
  pack-bitmap: handle missing bitmap for base MIDX
  bisect: ensure non-NULL `head` before using it
  shallow: fix NULL dereference

 builtin/bisect.c    |  9 ++++++++-
 builtin/diff.c      | 10 +++++++---
 builtin/mailsplit.c |  6 +++---
 diffcore-break.c    |  2 ++
 pack-bitmap.c       |  4 ++++
 reftable/stack.c    |  3 ++-
 remote.c            |  2 ++
 replay.c            |  8 ++++++--
 revision.c          |  9 +++++++--
 shallow.c           |  2 +-
 10 files changed, 42 insertions(+), 13 deletions(-)


base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2174%2Fdscho%2Fcoverity-fixes-null-safety-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2174/dscho/coverity-fixes-null-safety-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2174
-- 
gitgitgadget
