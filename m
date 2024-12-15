Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBE7154BEA
	for <git@vger.kernel.org>; Sun, 15 Dec 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734263514; cv=none; b=H7L7EaPq9bxVbcCm9zX5Ig3jO7axpXBzMVz/zQMCHOX9oTEz9js5p27vEHus2NZ8KxTquWSjimMq0bpDNCfuNty+uEPuBDtOOddxPXmYyviN4waHi0zqE1hYzRhQ9qpL2ir7dRReOws7+jyRKv2THiulsdX2f12kEjJ8hN3yrR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734263514; c=relaxed/simple;
	bh=Y75vEMwEsknQXeoQ8JNv6jrE341nIJEjRDK8FmSvPVY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=TeCuDUAtkFssJ/ypMgCrf1NLcm5MIsS7wew9785mBVo4oi7fdovmFYPxAi554IhCpXazIGRViKxN1gG8quGSY7LHx5BaXs5KlhXwnzCUpX3rBo1TeugmWNsQSUeVQHa3yX38iFosq1pn9Z0/IBv8eMHWkIp3PUg81tZ5dwKK2QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcvwOLbc; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcvwOLbc"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ef924d84f2so1028547b3.2
        for <git@vger.kernel.org>; Sun, 15 Dec 2024 03:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734263511; x=1734868311; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aq3KQHqNWfW/E8jBno5V3VQw7ZhuTOFpN4GJK7rJYr8=;
        b=RcvwOLbcrwMDZUk+aw/8jhdymtIlbKLlUP7vGif3DyK+XK9sQm+3ecQBs/X1pEclm4
         uEoe6batOnasV93lr6hdMBXEHf3VNwtIZJJbs8fXmWyaf6RFr84zTrcKfg7xmzLX5CAF
         REiMsRIRW1q/obTAIR1sHBAM+eH1pOjgC4JG3Ku/52UAjH2UCuh2bZvgV2M5bo4cxwWy
         kWIeoO3l1ttt7e0Jb8SkALGOfctXqgByhhfjEvjNTxhBJSImrEl5AJgR6uWZvswnU6wz
         p67O/3BpfvY6cQBUoPl8S5CBx5uSzuNsedg7ouBODBHHSvIJUeYZj4gOErW3HoaqR1Ew
         AbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734263511; x=1734868311;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aq3KQHqNWfW/E8jBno5V3VQw7ZhuTOFpN4GJK7rJYr8=;
        b=eKsosVxFk2FCwuU4k0wJ8cRj8vY3DeRqO6vgSoLHkjyISipt/lrejCBrDnDiq0iATn
         SIzJrU/mKI0GMjejysP0mKsIIGzpvLbH8fj8/Q6HotrFbt0UYe1xhCy1nuUNnkzDQ0JP
         9r0orz3MU54I2Nc2IzhlhIDOImGwmoKXqlTS0Ota9yPIpg2SOW1L7p5MKGQb9oQjUHOH
         +QyNPggM3bWjnd2VUzNSfo1ogWNwumh5M3HwwwdzhfLALGhoNtFglyQwde0Pxe8hKynU
         0lFvWxIyvDNzl6PSvgvqD8ymjiBolghR7afDDUNmIB2QXnkdXoRjdLYMDWZEnLl3D16s
         HG1Q==
X-Gm-Message-State: AOJu0YxaATv36Lbp/xFRwwl4WGnmKR6WAgbFgIIMchqJwmzGLWjzi2FW
	A/OXNbV1YgICuCNXwj/pka4oM9FpfSV1GcxFqjGW7KJIIYXQB2tV/0/P7idHKC7YjiGPfD40VOY
	+reewHpdVIVZm8PXJjc+9fr8CcixVYv04
X-Gm-Gg: ASbGncsZ2/AEByvOZOcd0v6xpdef9IOhvsMSRJ1Qu0m90+mJxcmraSL0MpN2/2pxHtQ
	Wqz/sC/GYsu9flF+qWjBbxpTrr7m7kK4N7MT5
X-Google-Smtp-Source: AGHT+IFevBA5ELSUXwr5UkPzxmwAnNrIpgiXU1LEBQ1V9qDqVzzxtzrkNuHQngovBaxSXNDetOXJv6ZgBIgK/ow/6rk=
X-Received: by 2002:a05:690c:4d46:b0:6ef:9cbc:44f1 with SMTP id
 00721157ae682-6f279b94e11mr34012077b3.8.1734263510862; Sun, 15 Dec 2024
 03:51:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Oliver Blanthorn <freedom4cows@gmail.com>
Date: Sun, 15 Dec 2024 12:51:40 +0100
Message-ID: <CADFnu5sMEvGyGy7xH1r0NGBUZJBznCi0waJ_bJ3tSHQ5Y2yX1Q@mail.gmail.com>
Subject: Bug report: ":/[text]" revision reference no longer returns youngest commit
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)

`git show :/Merge` in git's git repo



What did you expect to happen? (Expected behavior)

The most recent commit matching the text "Merge" should have appeared



What happened instead? (Actual behavior)

A commit from 19 years ago appeared


What's different between what you expected and what actually happened?

`:/[text]` should match the most recent commit matching that fragment.
There have been a few merges in the intervening 19 years




Anything else you want to add:

Bisect log:

```
57fb139b5ee7dcb2ea5182bf33bcd2b07df983c9 is the first bad commit
commit 57fb139b5ee7dcb2ea5182bf33bcd2b07df983c9
Author: Patrick Steinhardt <ps@pks.im>
Date:   5 months ago

    object-name: fix leaking commit list items

    When calling `get_oid_oneline()`, we pass in a `struct commit_list` that
    gets modified by the function. This creates a weird situation where the
    commit list may sometimes be empty after returning, but sometimes it
    will continue to carry additional commits. In those cases the remainder
    of the list leaks.

    Ultimately, the design where we only pass partial ownership to
    `get_oid_oneline()` feels shoddy. Refactor the code such that we only
    pass a constant pointer to the list, creating a local copy as needed.
    Callers are thus always responsible for freeing the commit list, which
    then allows us to plug a bunch of memory leaks.

    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

object-name.c                | 26 ++++++++++++++++----------
t/t1511-rev-parse-caret.sh   |  1 +
t/t6133-pathspec-rev-dwim.sh |  2 ++
3 files changed, 19 insertions(+), 10 deletions(-)




git bisect start
# status: waiting for both good and bad commits
# bad: [2ccc89b0c16c51561da90d21cfbb4b58cc877bf6] The sixteenth batch
git bisect bad 2ccc89b0c16c51561da90d21cfbb4b58cc877bf6
# status: waiting for good commit(s), bad commit known
# good: [fe86abd7511a9a6862d5706c6fa1d9b57a63ba09] Git 2.41
git bisect good fe86abd7511a9a6862d5706c6fa1d9b57a63ba09
# good: [92e8388bd35cdddf312011a98e046706bb420fce] Merge branch
'jc/local-extern-shell-rules'
git bisect good 92e8388bd35cdddf312011a98e046706bb420fce
# bad: [39e15b789ad3c3a192f4c8abde3daff83a053aaa] setup: merge
configuration of repository formats
git bisect bad 39e15b789ad3c3a192f4c8abde3daff83a053aaa
# good: [22cf18fd9ede79bdfe5ac93e09986a64052e5781] Merge branch
'gt/t-hash-unit-test'
git bisect good 22cf18fd9ede79bdfe5ac93e09986a64052e5781
# good: [ecf7fc600a5218c9ee3863ee70d5a6e312164f30] Merge branch
'tb/path-filter-fix'
git bisect good ecf7fc600a5218c9ee3863ee70d5a6e312164f30
# good: [d02895ceccd3b5c5422c35671553b5aace0a6087] Merge branch
'l10n-de-2.46' of github.com:ralfth/git
git bisect good d02895ceccd3b5c5422c35671553b5aace0a6087
# good: [25673b1c476756ec0587fb0596ab3c22b96dc52a] The third batch
git bisect good 25673b1c476756ec0587fb0596ab3c22b96dc52a
# bad: [0b2c4bc3ff6504467d84cb1bf6e73d877b553ce6] Merge branch
'jk/apply-patch-mode-check-fix'
git bisect bad 0b2c4bc3ff6504467d84cb1bf6e73d877b553ce6
# bad: [1f0899978109d732abe5b4825b5cfa40ef1d5885] entry: fix leaking
pathnames during delayed checkout
git bisect bad 1f0899978109d732abe5b4825b5cfa40ef1d5885
# good: [fc68633352180fc2645772b5926898fee4e006e3] builtin/remote: fix
various trivial memory leaks
git bisect good fc68633352180fc2645772b5926898fee4e006e3
# good: [50ef4e09c386f46898886b1c3ae8bef5783b4e90] builtin/rerere: fix
various trivial memory leaks
git bisect good 50ef4e09c386f46898886b1c3ae8bef5783b4e90
# good: [145c9790207b9847b609d997c86c7cf8cec043b2]
builtin/credential-cache: fix trivial leaks
git bisect good 145c9790207b9847b609d997c86c7cf8cec043b2
# bad: [57fb139b5ee7dcb2ea5182bf33bcd2b07df983c9] object-name: fix
leaking commit list items
git bisect bad 57fb139b5ee7dcb2ea5182bf33bcd2b07df983c9
# good: [11f841c1cc9c7ffadf5d462d25a378fcab5bb6e1] t/test-repository:
fix leaking repository
git bisect good 11f841c1cc9c7ffadf5d462d25a378fcab5bb6e1
# first bad commit: [57fb139b5ee7dcb2ea5182bf33bcd2b07df983c9]
object-name: fix leaking commit list items
```

Apologies if I've violated any mailing list etiquette - I've never
filed a bug using one before :)

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.46.0.rc2.20.g11f841c1cc
cpu: x86_64
built from commit: 11f841c1cc9c7ffadf5d462d25a378fcab5bb6e1
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.11.0
OpenSSL: OpenSSL 3.4.0 22 Oct 2024
zlib: 1.3.1
uname: Linux 6.12.1-arch1-1 #1 SMP PREEMPT_DYNAMIC Fri, 22 Nov 2024
16:04:27 +0000 x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.40
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
