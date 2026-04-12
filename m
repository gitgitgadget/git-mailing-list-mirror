Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26AF4F1
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 23:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776037511; cv=pass; b=M/ScHheeaff5M/y4tZk55lkr628b9y53xvHQFC3UNRHdGZsShXeqxw2vWoL8p6601lClD3LDFX3fO+XahbSdgYnfc099uFmG/l1/EvTeKe2fW1SrwSfOv4gbq4lEnliuu+15kvN9+ige48084Jr2Oha2GJzXSxjO26Qzhufd4mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776037511; c=relaxed/simple;
	bh=ONQO7k/tbjALq9RAMf4UOGWfI/lOEFoPUbUqeU46ZR8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PQc9XNHX9YoV790eT4ZR5l3GtkJz3PX1WTNrO31STq5XERA4JSW6BgSZiF6W2j7BLvIhs0Ala+vVEl0Hf/oWgwz3RycvUELqPIded4epGJxbnu5m+IQSR7Nik38p3qh6d5BvjLZQZrZpDPPsNIG8sXCmj9JLPsuC7XYc0aumJ00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSMtTpVF; arc=pass smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSMtTpVF"
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so4793731e87.1
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 16:45:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776037507; cv=none;
        d=google.com; s=arc-20240605;
        b=jeSudXOn3cUCcuyyVEzTL9SFU3FkxkMdfBcZCAu899BmxqIiAbnCbj1sau4W2w0xIS
         QLQl1cSjpovb0RN9A5VKEK5+hBr7dTL0RMpW80MAQSgN9Ppr+b50dXLZQzqFpdFoNdm3
         ffEf59QfvrNWR7aMAjNCfFEmuH7QvjFCO/kWk4n1N7D4p4cwlILFFOx7tqn5Kb7/77hE
         ae7umGRWvmBJf51+sH3sYRmKv/AC6ZFqXg0240It26iFYSx11pnaFv/33mrGr9W5ccrC
         4OSPPRkgWw0b4EAPjLuwy61Qiy0n3GI1L58dDByHNHTX6NEsqBhjRe2aznjJyaGGuGRx
         /Yog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=EcugTq8nV4ACyRi3tMDqDF0ZM/zCWTG4TOTLs3kjIpQ=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=E1IYsHDLi2AcTjacPvlTeFmFwl/PrckQMfj9pp4b9KevNltytwo38DHvn+AKbOWZFx
         xYSG0hIKvT+jPvYXlOU7JInJY3t+YMfO3d7TOetU+lyAEyk0DAzy3wUnJvNzFvfgTkG6
         08yy/SsFqzzJENw7XXprascuGO2JPDWnkQBZZaPIAj4GMr6oWilKuTPj7maTeNtAl3l6
         7GmlyshI4PA2szREI3SI9MKYZJj3xtoz8J6c1trd4X4Iv3ldj6rtcCnIG7zVpTjo304t
         IQQiXiwVBUqKRbKMmG2f9BpLsLod1D8RYC5IMCWlCrPJkVKhdXCUVcabJFvSCwnzFdT9
         47AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776037507; x=1776642307; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EcugTq8nV4ACyRi3tMDqDF0ZM/zCWTG4TOTLs3kjIpQ=;
        b=KSMtTpVFdU1bWJ5t6NZhcVg74UJIjP9mozL7hJAO1tu/MClKmLLzUplOlur1y90T0z
         yOdqJKi/PaYfrdl6FJESesm7MOSZ0+/uaw+6bidOC4kNqFjGbNaPEABRZLFAH1pFoPPc
         bJCPqIyfPmyFB0aeGV5ajbBOdsywgNxSzm94w1X4CSujdPJuFs8aF+k9zta7KaYRihVR
         nAaRvQIi7HxAMlXMjMZ0YW2NtTS7A5gAqA8zdkcOw/uzel9+Grslf2Y5ch0V7ATA+Wjo
         6zvd0PuStryF2ftgEWefN0hQLxvmrj1IbectAfZOQxuRB7KBAd4TPAsb7EZ3Ja9qGioA
         TR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776037507; x=1776642307;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcugTq8nV4ACyRi3tMDqDF0ZM/zCWTG4TOTLs3kjIpQ=;
        b=V2gfOD3H4tzO/Ro5jwZdwbxQ7F9KlTrUQj0r7zK32fJkKAL3zFe8+bbp5XxCHND6dB
         Gpo8FjqKyFUGCorCVvOTRumWfGcntZzAh1rZkCL0qF2f8iR1nNi96Vu1kWsx6tOA5u+Z
         Kdy/MEQTUchkgQrGuNH1XEdDlAqgqjYFa/BsE6rHnojdilAgLCmpBzcpaft328gblE2S
         gyU/UGCzGMPEgbpC283ZZIYjOwOrsFM0ZZLqdwFt5pU8J5p5mYL3Kc0dryXYpahGnfrh
         UIXiJf1rb9/Oz1KMyxEwOim85rJqybPc53TW3s08i6y0ZUsyB4YJP+Wh/P14Z7flMEhv
         s7hQ==
X-Gm-Message-State: AOJu0YwDoNtLdOHYCiVCBDzI/70txsCarVf2b1ovGJUjkGZ6AYY0rp7e
	qBEFGXcQIAiKYeGKiQmy6wwGBerHkExvtqo/1Srwroz1FhBt5EwTSIP+bLfNK8bt8zFscZKsMJH
	W/sZy49Yz5Xs5lZNIXydF6PQ50HYQILW9DTlJUha0Sw==
X-Gm-Gg: AeBDietvOPx2LGu9Jh7eRzoq9xqjFzQxITeVGcwufzi5CXVuMlXjnq9iDnkkkKgH9iS
	2dNF+FaoybzxNhiCRWvQ/ts9d5preP7tBb2/c47KkU3pQOZMIjlaFMccWe5MLw6LxD7YQ1Lr4H9
	mzB1MOB1fWq8Y8e5ls7eitEuVO0Ldp0PpdyiwPO905uZ/veYiAfPIO4aEnsFq8MazxtvDVW+F/H
	k6trLB2a4Ly/4zzoLd6mSqq5oP4jUBIHQbxxTYkODECLwxcAZDEm82EJ/sKZKEzYWaiiVbqLAiH
	GHmRgIaWWXj8vQvfuuFhVLWZAJcDLZnlvNnKdPAsjov2EA3AOYCR5YmyARsLbDkxq2Ds0OCKkVc
	=
X-Received: by 2002:a05:6512:3194:b0:5a3:ff6b:cff5 with SMTP id
 2adb3069b0e04-5a3ff6bd3b0mr137207e87.20.1776037507229; Sun, 12 Apr 2026
 16:45:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: AMMAAAR BAKSHI <the.ammaar.ic@gmail.com>
Date: Mon, 13 Apr 2026 05:13:34 +0530
X-Gm-Features: AQROBzAXo2Gt6ZPUIIbtb8cESXWwwN17yPxy7Kx6wlAfP8comwpxQqumeiE47AU
Message-ID: <CACqkj0pxih1BSa8z9+Yw-g55G1rNcvvQao+SLwQ7B-eQodcvgg@mail.gmail.com>
Subject: [RFC] New command: git-recall -- a developer standup/activity tool
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'd like to propose a new command: `git recall`.

## Motivation

Developers often need a quick way to review what they (or their team)
committed recently -- for standups, weekly summaries, or general
self-review. Currently this requires constructing a `git log` invocation
with --author, --since, --oneline, and formatting flags, which is
non-obvious for casual users.

## Proposal

`git recall` would be a porcelain command that shows a formatted
summary of recent commits, grouped by date:

  git recall              # last 1 week (default)
  git recall --day        # last 1 day
  git recall --week -2    # last 2 weeks
  git recall --month      # last 1 month
  git recall --year       # last 1 year

Example output:

  --------------------------------------------------
    git recall  --  Last Week  (since 2026-04-06)
  --------------------------------------------------
    2026-04-11
    448e66e  Add login page  @ 19:41  Alice
    2026-04-10
    91bc3fa  Fix null pointer  @ 14:22  Bob
  --------------------------------------------------
    Total commits: 2
  --------------------------------------------------

## Implementation

I have a working standalone implementation in pure C with no
dependencies, available at:

  https://github.com/AMMAAR-IC/git-recall

It currently runs as an external binary (git-recall). I am interested
in contributing this as a built-in Git subcommand if the community
finds the idea worthwhile.

I am aware that similar output can be produced via:

  git log --oneline --since=1.week.ago --author=$(git config user.name)

However, git recall aims to provide a more discoverable, human-friendly
interface for this common workflow, similar to how `git switch` and
`git restore` were introduced to simplify `git checkout`.

## Questions for the community

1. Is this functionality considered within scope for a built-in command?
2. Would `git recall` be an appropriate name, or would something like
   `git activity` or `git standup` be preferred?
3. Are there existing plans or discussions around a similar feature?

I am happy to write a proper patch series if the idea is well-received.

Thank you for your time.

Ammaar Bakshi
https://github.com/AMMAAR-IC/git-recall
