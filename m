Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D705276049
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776357144; cv=none; b=Aj6xaUMonit7EttP1QjAuK8RaIGvS6L8xY3KzFxUr43Lc5IujigD6Y4Yz8YfJ8u2ablAg1uUTOv3c8OHPprdbL83PUO1x81nwcDuVdAATS9FAfyCcyUfpaHNTq9KzeC6RtBNxKN3StBKyPVCVGMKK+nh6oDeJ0rvHzpoE8EBQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776357144; c=relaxed/simple;
	bh=j5VHmlWWOj9a890rQg41cmRL4mqXgjvG3N9anMx9bfU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C0VwA+4uohSxxNuvEL3Q2q4r7XU8dIPwaywWjjpb6psymo0bhx04HhS8rJdQmpW92l04zLAqUPZAlQvGJwfmbRKDkktn8k0ZEl39bgewac7mifLQwJnmXmAqxhUrCgqR3Ir+NqoADv82bIbysZ8zulJGXj9Muj8v360FtPXuwOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZRaibR8; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZRaibR8"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso77703875e9.3
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 09:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776357141; x=1776961941; darn=vger.kernel.org;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QaBWD7vwZ6tZF+XjV+DN0+BCwivEGIUumB13udclUlA=;
        b=jZRaibR8PlNdMBxEaZWgHVgAHBG6judWM+GYK+NmD8joryH38+ETCdBiIrODAbnArh
         gT08g7HzV/pQOStVOikRWz55/1BbDR+jrSj4NP4NJIdpa8RbBOuOInr145a02LmE7zCQ
         rK0XTcJ1aiAUmmhy7INk1rcGm4EJN+0VbS8Bo+zmneRUyLatyIto6k4diVd73Y9ITqLd
         VqIO7/CI2rrUA/4ewdLPgvJewkCc7TBjpKFVJqI2yKJCaL+BvifAFOzJfGaNd6ASsOMH
         kntzXQ5RdaByzhF9NQD+JlELzLCbs5+3zVYIpHR5yL4KhOEr++6/YEzLSNTVgmKnCnK3
         LR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776357141; x=1776961941;
        h=content-disposition:mime-version:reply-to:message-id:subject:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QaBWD7vwZ6tZF+XjV+DN0+BCwivEGIUumB13udclUlA=;
        b=pCg9fYJ/Ttxz+nMWuR5AdygJxj56E6pxsx8SeHZZ7vz4WTCsjHCiDabMkxoGVSJ1qO
         fudZECKFpsJySK6yN1i8qRQZtY/y1EPs84by0tuEjvXednM8cWLbKF3etubC925lYZ3v
         fw+Z/caX0bUKVN7MCdU3XTE2K66uqd7roAqeJWzNseSX7+x7zsi9JBEiqigD50nR8brn
         GR6TDUpRO4n0v6mGy6+g3axCIQX2vFZuNtjZH7I1ptpzV8o0CsGVy6z6W2gZWWVlaK2E
         nLLcIyL2YPpt7xCkwYaf5zfI3ehnbDw98VKJxhScevtebNOSTU39CBlV50jG37W07xEn
         xBEQ==
X-Gm-Message-State: AOJu0YzSB7Fy1rAspSuxy+M2aImdSa/bTvfMUhG6fUMDlQ30rmU80D9I
	Qw/EaD7AKteeAsacNKrOgHOSFCQP3NLS/niaR4+GJfXZoQLvF/mRe754UweqwQ==
X-Gm-Gg: AeBDiet6eaVKP08CeF52Rop8Ib8wGx7pxTqKeJT1Vzs+nluf7TbjgWKqvjo+rrOa/Z2
	w9PfRCmK3GF54eTsTC81lD8hSxnuZYK+yOUxgbMa5aEdYI7c967upVGMd9aV6WjDxdgh3zMDfFR
	+Ve9lC3lJdpzmzxRGzlO99z5TouqEWGprgdDyEEKrLmehncKs22fc9HkCNUfVvuUvMuFZAONBnS
	O6GYzWlqx1kgW7W/411D/+cayVFmDVpHwTkISTY8QS0zWDSqAdf9Nli9M4Vg45OjjHAhLWxnRnw
	B4wZhJvrykoyKcylNYAZQU6NfsNdPIzsmaSNCwYAq9yT0E3C6SB5yYZWdF7ETsDlPJMNna6nL1P
	E4VHRLzua6723w0PtkLpZjZp3ud3kzEF1tBXetISBTCNurDPh24+rLXVzmFFSGqvMr4nC0rPPhh
	g56Ug49aLf4z6hF9pHaUp77Afeir8vyD8yrC0mjAdBX2veMxBd5n0LNDGML9GjCUIWVuGeoGN9X
	H+5DJEcMcQDBrV4
X-Received: by 2002:a05:600c:45c9:b0:480:4a8f:2d5c with SMTP id 5b1f17b1804b1-488d689cf9emr361917695e9.29.1776357140728;
        Thu, 16 Apr 2026 09:32:20 -0700 (PDT)
Received: from RTX ([79.117.197.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5854163sm66538705e9.13.2026.04.16.09.32.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 09:32:20 -0700 (PDT)
Date: Thu, 16 Apr 2026 18:32:18 +0200
From: Jimmy Aguilar Mena <kratsbinovish@gmail.com>
To: git@vger.kernel.org
Subject: [PATCH 0/3] worktree: add --recurse-submodules support to git
 worktree add
Message-ID: <aeEMU-ohKz2tnSWq@RTX>
Reply-To: CAPSFGa8uu9CEEPH3XVjfN5VEOfcnb2p8YgXVuansjKc0S2S_tA@mail.gmail.com
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

This series implements the native --recurse-submodules flag for
"git worktree add" discussed in the earlier RFC thread.

The approach follows Phillip Wood's and Junio's feedback: each linked
worktree gets its own per-worktree submodule gitdir under
$GIT_COMMON_DIR/worktrees/<id>/modules/<name>/, so HEAD, refs, and
the index are independent per worktree while pack files and loose
objects are shared via hardlinks.  The gitdir isolation is the same
model git worktree already uses for the superproject.

Patch 1 adds the --recurse-submodules flag to builtin/worktree.c and
calls "git submodule update --init --recursive" from within the new
worktree after checkout.

Patch 2 teaches clone_submodule() in builtin/submodule--helper.c to
detect when the main worktree already has the submodule cloned and
reuse it via "git clone --local --no-checkout --separate-git-dir"
instead of fetching from the remote URL.  This avoids redundant
network access and disk use: the objects are already present locally.

Patch 3 adds tests to t2405-worktree-submodule.sh covering both the
happy path and the gitdir-isolation invariant.

Cleanup is automatic: submodule gitdirs under worktrees/<id>/modules/
are removed when "git worktree remove" calls remove_dir_recursively()
on the worktree entry, exactly as with the superproject's per-worktree
state.

Changes since the RFC:
- Replaced the shell-script cp -al prototype with a native C
   implementation in builtin/worktree.c and builtin/submodule--helper.c.
- Per-worktree gitdir isolation is now handled by the existing
   submodule_name_to_gitdir() path; no extra plumbing is needed.
- Added t2405 tests verifying both behaviour and gitdir placement.

Jimmy Aguilar Mena (3):
   worktree: add --recurse-submodules flag to worktree add
   submodule--helper: reuse main-worktree gitdir in linked worktrees
   t2405: add tests for worktree add --recurse-submodules

  builtin/submodule--helper.c   | 54 +++++++++++++++++++++++++++++++++++
  builtin/worktree.c            | 23 +++++++++++++++
  t/t2405-worktree-submodule.sh | 24 +++++++++++++++-
  3 files changed, 100 insertions(+), 1 deletion(-)
