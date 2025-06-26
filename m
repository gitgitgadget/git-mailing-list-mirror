Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86924264626
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 10:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750934978; cv=none; b=eNQzRX82GoQQ30mqHwVX93PGzsVfaVsZiR1j/SsvwmgtKVIn7xaiOwtmNlbsxS0U3vIVGjjNhOk7URtnGk0tHRLPDm2vaqw1OZJ8cIuVnV5xnQ/c8twJUVjd9DCy5Smhcr+EWRrhl0BsxF8OihsZD9uOxRpcec1sk4eTVq08eyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750934978; c=relaxed/simple;
	bh=sOp41vGPCgb+7DiqeeBHClQFVZXBFLn28L6pZcaUQ1E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VgRFRrtD/VqLKVtS4Dy6/KGS9usNLWe0Hp1e45/BqV6s1/il+Ft5mC3LR3lgDo1slYfOK1slJj7Sxn2AkS8mtWX2CaaSqjZNrvO9bTBLrHIzhNRG4FZsJv6LuVd9jX6iNJ60lkq20Li3Cq84ucqVYCIz2J/1Tad215V7ZmbzZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OyAE/3Kc; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyAE/3Kc"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0d758c3a2so102344966b.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 03:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750934974; x=1751539774; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xDBAnCIO+6JrqLnLpCzh0oJk4nlBfaM0tP/YtIKMuwk=;
        b=OyAE/3KcMlZaXnlBUfZ1DYFApfyMpwUIUhnTGzG97HLsQPGLP1c6y7jzt+PLIR25c9
         csuc0ZVPIlSv8NI+qLO3VFwuDHN8Rs2yCJGj1uJOGvwx3HzPCVgMPoCQ0NA/4GBLI9S8
         GIg5hK0y+ZDMuM/uO2Pv0lqhvzJoFbEI5A50PfbsTInxP0+NQ2NjBAgPr/4jUZIFq0bo
         w64HHpFwP2HUj42ErpHjnSkE7P6yuk7IQxJDvbOOPT0Q6Ti60Ay8sMuKSt9bcIAls0dO
         quEREKfUg1zH7qfbUkLv7AH23tHH9XCQUHN1LIJqYkjumplci10PMX4CwGu0iZhzuQ/m
         rZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750934974; x=1751539774;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDBAnCIO+6JrqLnLpCzh0oJk4nlBfaM0tP/YtIKMuwk=;
        b=hl/wAv7wXrNhgbEw4z/Ela3Hqq0enjLcClQpUIeYuiCuqqtgFkJp0rCsGgI2nNkPtx
         mkezK4/7VnqbjmTDo7ByFx6ucQ1TvjdFNSUN1o4BSPyZbW35GB3ZXzdXivAixG+coVTy
         6kaBpX0W0wm/Z8HsKsS/L9LKnlAvmPubwH8eJ4XcHu8cMrD4QGgH40vQKSVPRQ9qJ7xA
         2HUOyHc0ABrui5tfa3oxJMjYAIrV5XPv4aHW46QK+61VGLf+jF7akK0YiRN8qh1GYSHr
         01YfdBrGyx8v6Au+iar50cXuwGBLnFKpsUpVfKWpKCASJyvzV0DhbuN+tt/tapCQGVx+
         qOow==
X-Gm-Message-State: AOJu0YwI7rXKCC3bUrPi4TNMxC5V1Ck0c87ZeMox70a7LLLTYNj+uD4o
	c7yTMLB+FXea7dfia+d9IhjkGmCzv/vkjpZxQIdx9KZeOv3RGN695jIQ0v5liLYfb2/tYkjGitG
	VQvnBIk9NkyjHQENbpJ4urjSCNFtRnNk3jeOZfjoxpw==
X-Gm-Gg: ASbGncso3GscUF7b2pKqc/58rGLk4+C9O+vgw/qDT5dOqLfyNzmwEQezYgL5DoW/wBw
	EpHdOLlbOLHjY2diJLvygYydelDLWiXg1tQIuMVd9OqW1d1wdGI2GvgWg7Q2R1UZsv7Ly304WW6
	O57s/8framm0j/HwU30xhZP1hxShKbE2CbgEWbOWnFIgfT
X-Google-Smtp-Source: AGHT+IH8+Tzd/JiYLeuZcX2i9xsStaz6hV/HssSLN8WwE5IcMQqtxxp0QnZ+3YymvVRGM1jkhpow8oV+b538keDbJJ8=
X-Received: by 2002:a17:907:d87:b0:ad8:9b5d:2c1e with SMTP id
 a640c23a62f3a-ae0d0cd69damr355567766b.29.1750934974428; Thu, 26 Jun 2025
 03:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Denilson_S=C3=A1_Maia?= <denilsonsa@gmail.com>
Date: Thu, 26 Jun 2025 12:49:22 +0200
X-Gm-Features: Ac12FXyYR1Yr20LOZLi59wkURU242lgDDNXmVkBrHwxMEociicrS5ofwErZzLZ0
Message-ID: <CACGt9y=WktE5Tqkxf6_tb_YnaeDyJTGYZoU7vErnSGnZMpuC-Q@mail.gmail.com>
Subject: git rebase interactive breaks when working on a secondary worktree
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

git rebase interactive breaks when working on a secondary worktree

## What did you do before the bug happened?

1. `git clone` a repository.
2. `git worktree add` to have a second branch checked out in another direct=
ory.
3. Continue working as normal. The main branch has a bunch of extra
commits (at the main worktree).
4. At the second worktree, after a while, try `git rebase -i
hash_of_a_few_commits_ago`, or `git rebase -i main` (where main is the
main branch at the main worktree).
5. Approve the plan, even without any changes.

## What did you expect to happen?

It should work.

## What happened instead?

I get this error:

    error: Your local changes to the following files would be
overwritten by checkout:

Followed by a list of several files that were NOT changed in my
secondary branch at my secondary worktree.

What's more, if I redo the `git rebase` but without `-i`, it works
fine without any errors.

## What's different between what you expected and what actually happened?

If I try following the exact same steps (the exact same git rebase -i)
on the exact same branch, but this time having it checked out at the
main worktree, then everything works.

## Anything else you want to add:

I've been hitting this error for several months.

It doesn't happen every time, it depends on the commits from both
branches. Thus, it's hard for me to give you a minimal reproducible
example git repository.

Given the circumstances, I believe some part of the `git rebase
--interactive` codepath is not working correctly with worktrees, and
thus it's misbehaving.



[System Info]
git version:
git version 2.49.0
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
libcurl: 8.7.1
zlib: 1.2.12
uname: Darwin 24.5.0 Darwin Kernel Version 24.5.0: Tue Apr 22 19:54:29
PDT 2025; root:xnu-11417.121.6~2/RELEASE_ARM64_T6030 arm64
compiler info: clang: 17.0.0 (clang-1700.0.13.3)
libc info: no libc information available
$SHELL (typically, interactive shell): /bin/zsh


[Enabled Hooks]
applypatch-msg
commit-msg
post-applypatch
post-checkout
post-commit
post-merge
post-rewrite
pre-applypatch
pre-auto-gc
pre-commit
pre-merge-commit
pre-push
pre-rebase
prepare-commit-msg


--=20
Denilson Figueiredo de S=C3=A1 Maia
https://denilson.sa.nom.br/
