Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7BB156F40
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721820547; cv=none; b=RruwyVG79BDIJmN5ZtIYR56SRJsmPndm8HgcEfgttxu4DCq7jPOPYSrDSJLaXAAOdMcrCdBhfMDbZfiwtYzZ4yQ0H8hiQ4hvsnODxivBZSg07F5q+N162nEQ3HpRWg3fO+2v8svLwEI85Fqezkh+fhEqJknGBhU2ABSb7LacW/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721820547; c=relaxed/simple;
	bh=Pv9EuMZpc9LLjSsg8Mt0zqiAfSocyHwPb8XZVAEqFbE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p3xsr1z18WQrajatGffMnAD7+ZlxLSmcVEABaLgDP57C0j2dKTr6oQlvbEU4y562y7yiO0oV1A4C+2xG5z57xKSKKafLXB08mhAAm65BXW+UY8yepfWQdp4ladVpqn8TMRbJCF6tGDH36USSeLJrDIXcfg8Hh2Ev8W2HY/uNNTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com; spf=pass smtp.mailfrom=koordinates.com; dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b=Ks64/7cf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=koordinates.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=koordinates.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=koordinates.com header.i=@koordinates.com header.b="Ks64/7cf"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4267300145eso58253665e9.3
        for <git@vger.kernel.org>; Wed, 24 Jul 2024 04:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=koordinates.com; s=google; t=1721820544; x=1722425344; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9gtRw2TGWJCQtgWyHj1BRlM/gwp+mHJQsYELaW+8Ygk=;
        b=Ks64/7cfmtBf8FNeeOlNypVw0XimTTJTRhf4/uF9nDcsc9e9WZKMPeepf1ShDQWuv6
         zXunAGDU8nE6hIM3hoLFxLoS72Yvp7ydRRGlGbTWO5w3MUEQtMWODKzl7DBFMyRMkbRN
         0TWkPbaERncEXEIq02z97NiHjxaFi0K8Y0GskO24aKbfN/sVDS+Stfvw5r4hkT9KQ+sB
         oMBhEEXiKDG2Ww7QkDC3yAQ0oVx0vX3turpzTl0O8ZM9N1WpkxL3z/7bBk+awI4MOWo4
         AK9XCLDuQX8lEQVfnOF2N0/ptXVh23nhP+PjenUdUzilojDZhTVK6ivCU7ztCfYHAZA0
         2new==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721820544; x=1722425344;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gtRw2TGWJCQtgWyHj1BRlM/gwp+mHJQsYELaW+8Ygk=;
        b=i86Fa4ZD2RXlkfYA+R/npPYEr+02fH77f0QMotxUAELMbY2iQWzS2HvkcNTcaLnAVA
         NzYpjI9XO+CDWccFB2E2kQFpjJ2H82ihe6jchnGxCKAoEAUsESrXM/iSni+KynoxUZur
         xWOBj2Q63O+wn0UvXm5zTVg9Mc0lKnonJsUZ4p/6AlTogpBgA5397Z4e5nnMLaUP1SkQ
         A8Ph0dnTVO0qCNefRjrwVkHiNkAYSIqnhjxrqNTK96Nxm0Xk9rGts0h3972gs3HoRC2D
         V4mhi1fPNBN3NCsprr8wqD5taZAzIkL6ORPPj6b6w+CsVBwQCpErAoLvceELt45cTCRo
         /NKw==
X-Gm-Message-State: AOJu0Yx5YhWj6GYQ3Tg6M5f+DSq/AWqasmOLXDmtLC1Jr1eWTYT3tJDr
	VhsZBdM2P8J0eVIecT5PjWl4/tZmpLg4NZ3KFdkhWhd7thGihH8/aZLZCD4mw9IcUvuBFHmDz3Q
	VaquLYYNDMNUoZy7nISVPfi/tKwXaG6MhuVvb1MJjavkziJYub3E=
X-Google-Smtp-Source: AGHT+IGS+KkB+eYJIErEA36RHWkfm902ZQj4L4ReHEGS4U9sv2aOBmyr4uoxJ+Z5a9/96YI2P2wO0Ss6roGEKHaM/0Q=
X-Received: by 2002:a5d:64ad:0:b0:368:6583:5b09 with SMTP id
 ffacd0b85a97d-369f0a7c925mr2885850f8f.46.1721820543556; Wed, 24 Jul 2024
 04:29:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Robert Coup <robert.coup@koordinates.com>
Date: Wed, 24 Jul 2024 12:28:47 +0100
Message-ID: <CAFLLRpJgpjJpNRC_UpZmUXF2626e0BiH8CkOkoMrX3zcrOp7YA@mail.gmail.com>
Subject: bug/defaults: COMMIT_EDITMSG not reused after a failed commit
To: git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

* What did you do before the bug happened? (Steps to reproduce your issue)

I have commit signing configured, using 1Password as an ssh-signer.

    [gpg]
        format = ssh

    [gpg "ssh"]
        program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"

Sometimes signing a commit fails, because 1PW has updated and needs restarted
or something, I haven't been motivated to figure it out. But that's not the
issue, there could be many reasons a commit fails.

    $ git commit
    <editor opens, write beautiful commit message prose>

    error: 1Password: Could not connect to socket. Is the agent running?

    fatal: failed to write commit object

If I restart 1Password, and do `git commit` again (signing works), my previous
commit message is wiped and I need to start afresh.

* What did you expect to happen? (Expected behavior)

If a commit fails for whatever reason, I expect to be able to re-commit and it
would reuse my carefully crafted message.

* What happened instead? (Actual behavior)

It got dropped on the floor and I needed to rewrite the whole thing.

* What's different between what you expected and what actually happened?
* Anything else you want to add:

The git-commit docs state:

    $GIT_DIR/COMMIT_EDITMSG
        This file contains the commit message of a commit in progress. If
        git commit exits due to an error before creating a commit, any
        commit message that has been provided by the user (e.g., in an
        editor session) will be available in this file, but will be
        overwritten by the next invocation of git commit.

So, yes, technically I can copy it or use `git commit -F .git/COMMIT_EDITMSG`
but this seems like a distinctly unhelpful default behaviour to me. Thoughts:

- descriptive commit messages are good
- most commits succeed
- if a commit fails, the user _wanted_ to commit, so why would they _want_ to
  drop the message they've previously written?
- even if a commit fails and the user does something completely different and
  now wants a different message, deleting a chunk of text is vastly easier than
  rewriting something.

While successful commits also leave the previous commit message in
.git/COMMIT_EDITMSG, this is _not_ documented behaviour (it only talks about a
"commit in progress"); so feels like we could change it:

1. delete COMMIT_EDITMSG on success
2. reopen COMMIT_EDITMSG on commit if it exists. Maybe logging something like
   "Restoring previous in-progress commit message..." might explain what's
   happening.
3. if COMMIT_EDITMSG doesn't exist, re-populate from the template before opening
   the editor. We could also do this for "parsed-as-empty" commit messages.

I just don't see any particular upside to the current default behaviour?

Rob :)


[System Info]
git version:
git version 2.39.3 (Apple Git-146)
cpu: arm64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
feature: fsmonitor--daemon
uname: Darwin 23.5.0 Darwin Kernel Version 23.5.0: Wed May  1 20:12:58
PDT 2024; root:xnu-10063.121.3~5/RELEASE_ARM64_T6000 arm64
compiler info: clang: 15.0.0 (clang-1500.3.9.4)
libc info: no libc information available
$SHELL (typically, interactive shell): /opt/homebrew/bin/zsh

[Enabled Hooks]
