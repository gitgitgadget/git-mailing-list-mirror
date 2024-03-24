Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E440D18E29
	for <git@vger.kernel.org>; Sun, 24 Mar 2024 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711299470; cv=none; b=sKnJVQRbBXD0NP30irXjmcCV89ubh3yuWSJg+jFt3/gc0JUK+z01SGJ+ED9DvGj+KtHy0HFN3LyQvDxawla0198k/XZZ449kFVjbP5XdG7UDxvJ/yPAylXHBg1wMploL9uOzOzTW7UJJefnepVbNu7vn1gkV/H6NSMaI/jEqsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711299470; c=relaxed/simple;
	bh=cIBOSOiOSCfN1nVo5kqmwsTjeIXWgpmb2GiE+a3aYus=;
	h=To:Cc:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=K1ZFFy2oYcR0uLk2gRbvQFyREr+TCA9LYyEyzr1JQxUOgDMvBjRHnNAmSn/bOqGixLP1GASAejUvk5kjER+29neJ+R+eG7rIDB1AtFAYHXmK4d3o+OrDiPY7yVn8+AjdhsNM8wzVMcQXfJzspj+iD+1VwVWNuYpTeBm41gMbzR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bRU5T5Ao; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bRU5T5Ao"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789f00aba19so280430685a.0
        for <git@vger.kernel.org>; Sun, 24 Mar 2024 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711299468; x=1711904268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZhNQeJMb+Nibj3fH9FHaTBqzr+dpeadRzFEAGjEutI=;
        b=bRU5T5AotI2nCgTMr6Qfpuedt7cm4WRMe6sjIIi2XRfmYfDAi9BPKAxD1CreusyiMT
         f/ux16lP0l4mKcQMC/8rgG3puxjdwXd3bnmCa/M3v9xKXykxJUjRHFK4N+7hckSEMhhY
         hi0R/eCny/sDmenRT7B5hJ0ibC/6E01Xtxr7emSg96XeMPDnvHvmuThYdB+98aP2aOOv
         SwzbQYhkW6ftm9Y1rF9/yVBGz8R+lZEQf8nh0NmuV8aGXKQeuVBAPJTO9FcnH9qalc6w
         aGfkKF+h+P2nqlqqJXFfiiJNwdgqYonUJupVzI2bcE8GYZTDDCglf3RuKxAQBRcDGmH0
         Ivpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711299468; x=1711904268;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ZhNQeJMb+Nibj3fH9FHaTBqzr+dpeadRzFEAGjEutI=;
        b=UPZUGAXAopnkAxmvC5ewFDM9U8vlnG7nCxFsODOaPJwmqAAGiVjaevfySaIyLK4hTf
         TU7TnEwjPgltK/zV+qzcwQO6G84BbABhfYpUsM+eOhYbuWyy4ivPyW8HnjOwN135qPQA
         1337FXUzJ4YgutkBLplwy/2lj44RWwTaxOf4e340fvBV7Mt39dvTjYuOfcKRxDHUBDKK
         ER1PY7LkHabbPx0T9eyKUA9HrGcTT8OCjUrUox7nO50SSfzpY8Qu/6kF6D8EtFP/y+jb
         bl5ZQauYE6r7tPIoSBdLirJEFArm0SlX7R7Z/NYfesoukbGbDNslwKLNxgTHW+cZRlH5
         DoTQ==
X-Gm-Message-State: AOJu0Yyke6BQ2QKreRD507B6b4keBgSXZ9ZjEfciPdyay5la9rzweHJk
	CdfQbkk8hKfQOF5Me9Snu7m7TT/J8v82mk5dygO8CUwDkA9l0lMu
X-Google-Smtp-Source: AGHT+IEW/UBENmo2ooNMJqyieHHbdArhLAu/irgFhde+beGbcIzOrO1D9YpSlBSrup6XZFWAxUxYPQ==
X-Received: by 2002:a05:620a:535f:b0:78a:da8:58e2 with SMTP id op31-20020a05620a535f00b0078a0da858e2mr5383813qkn.9.1711299467767;
        Sun, 24 Mar 2024 09:57:47 -0700 (PDT)
Received: from ?IPv6:2606:6d00:15:103b:7d73:db39:fcae:4412? ([2606:6d00:15:103b:7d73:db39:fcae:4412])
        by smtp.gmail.com with ESMTPSA id k10-20020ae9f10a000000b00789e94cf424sm1481027qkg.108.2024.03.24.09.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 09:57:47 -0700 (PDT)
To: Git mailing list <git@vger.kernel.org>
Cc: Christian Couder <christian.couder@gmail.com>
From: Philippe Blain <levraiphilippeblain@gmail.com>
Subject: 'git bisect run' not fully automatic when a merge base must be tested
Message-ID: <6ee4b8d8-5acb-3d3c-28e0-be972945e8d7@gmail.com>
Date: Sun, 24 Mar 2024 12:57:45 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 7bit

Hello,

I have encountered a situation where 'git bisect run' is not fully automatic,
i.e. it stops before finding the first bad commit with the message:
"a merge base must be tested".

Is there a reason why it could not run the provided script 
on the merge-base that it checks out ?

For context (and a reproducer), I was bisecting the 
'git commit --verbose --trailer' regression I reported in [1].

I was running the bisection on a machine without curl installed, and so I 
was building with 'NO_CURL' and thus needed to cherry-pick my 30bced3a67 
(imap-send: add missing "strbuf.h" include under NO_CURL, 2024-02-02) at most steps
of the bisection. So I was running this command:

git bisect reset && git bisect start &&
git bisect bad v2.43.2 && git bisect good v2.42.1 &&
git bisect run ~/bisect-git.sh

with this script to drive the bisection:

=== ~/bisect-git.sh ===
#!/bin/bash

git cherry-pick --allow-empty 30bced3a67
if   make -j NO_CURL=1
then
    # run project specific test and report its status
    ~/bisect-trailers.sh
    status=$?
else
    # tell the caller this is untestable
    status=125
fi

# return control
exit $status
==== end of ~/bisect-git.sh ===

and this one to reproduce the regression:

=== ~/bisect-trailer.sh ===
set -e

export PATH="/path/to/git/bin-wrappers/:$PATH"

repo=${TMPDIR:-/tmp}/test-trailers
rm -rf "$repo" 

unset $(git rev-parse --local-env-vars)

git init "$repo"
cd "$repo"
date>file
git add file
export GIT_EDITOR='cat file'
git commit --verbose -em "file" --trailer="key: value" > /dev/null
git show | \grep -q value
=== end of ~/bisect-trailer.sh ===

This results in the bisection stopping at:

	HEAD is now at 4a14ccd05d imap-send: add missing "strbuf.h" include under NO_CURL
	Bisecting: a merge base must be tested
	[d57c671a511d885a5cd390e3d6064c37af524a91] treewide: remove unnecessary includes in source files
	bisect run success

with the following bisect log:

git bisect start
# status: waiting for both good and bad commits
# bad: [efb050becb6bc703f76382e1f1b6273100e6ace3] Git 2.43.2
git bisect bad efb050becb6bc703f76382e1f1b6273100e6ace3
# status: waiting for good commit(s), bad commit known
# good: [61a22ddaf0626111193a17ac12f366bd6d167dff] Git 2.42.1
git bisect good 61a22ddaf0626111193a17ac12f366bd6d167dff
# good: [5edbcead426056b54286499149244ae4cbf8b5f7] Merge branch 'bc/racy-4gb-files'
git bisect good 5edbcead426056b54286499149244ae4cbf8b5f7
# good: [5baedc68b02c1b43b307d436edac702ac3e7b89d] Merge branch 'jk/bisect-reset-fix' into maint-2.43
git bisect good 5baedc68b02c1b43b307d436edac702ac3e7b89d
# good: [2873a9686cf59ecbf851cea8c41e6ee545195423] Merge branch 'rs/rebase-use-strvec-pushf' into maint-2.43
git bisect good 2873a9686cf59ecbf851cea8c41e6ee545195423
# bad: [03bc5976514f706889fceea623f35133014ebe78] imap-send: add missing "strbuf.h" include under NO_CURL
git bisect bad 03bc5976514f706889fceea623f35133014ebe78
# bad: [9ae3c6dceb187af1ae09649dc5c61bb05a7013d9] imap-send: add missing "strbuf.h" include under NO_CURL
git bisect bad 9ae3c6dceb187af1ae09649dc5c61bb05a7013d9
# good: [007488839cabbb5bc6777924ae03c4edeb1b6110] imap-send: add missing "strbuf.h" include under NO_CURL
git bisect good 007488839cabbb5bc6777924ae03c4edeb1b6110

This was the first time that I did a bisection with 'git bisect run'
that was not fully automated so it threw me off a bit.

I tried it again today and realized that if I modify my ~/bisect-git.sh
to use 'git cherry-pick --no-commit --allow-empty' instead, then the
bisection runs to completion and finds the bad commit. So my understanding
is that cherry-picking a commit during the bisection (without --no-commit)
alters the commit graph and might not be the best idea... Looking at the man
page the example does use 'git merge --no-commit' so I should have known better.

But the question remains: in general shouldn't 'git bisect run' do everything
automatically and not require the user to do something manually ?


And a side note to finish:
Initially I did not use 'unset $(git rev-parse --local-env-vars)' in
my ~/bisect-trailers.sh, and I was running the bisection in a secondary
worktree of my clone of git.git. This did not work at all since the
'git init' and 'git commit --verbose -em "file" --trailer="key: value"'
steps were running _in my secondary worktree_ instead of in $TMPDIR,
because of how the repository detection works in worktrees and
exports some variables (I think...) This was also very confusing
and I'm wondering if we should add a note somewhere about that 
in the documentation, although it seems specific to bisecting git.git...

Cheers,
Philippe

[1] https://lore.kernel.org/git/8b4738ad-62cd-789e-712e-bd45a151b4ac@gmail.com/
