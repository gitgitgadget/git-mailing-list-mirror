Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD3C3403F5
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780961817; cv=pass; b=s3sNCDeBzj9LonUbnf5Khcxv0XZpEiaVGcJAGCbBzWqyZdEM34P6HX+/ZMGYRd6qLY/emw4yvF1Pp4EqOzxv9oj9y60BS2C0dZ7kLt8NQDSuyHSQff930Pai0jyvFaZ0llsc/J5iAcFnYtTB3f37mNYSGxKKY5LiCGu5G0da1wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780961817; c=relaxed/simple;
	bh=XodyXgpuf+VnegI3pYtaP/qL8zoJ1tXwyYwDQjE7cxk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=O3yFa8emaC1y/b2w7g+kWpVXKyjYqO2tCpxswyhr9wiHLC/rAnL1m7fEWXj/LPXHlL7anCXT/H4OASoymEmCI5eLZ1gOvJHCHSjhlIxCH6gu/Yq6NMGjxayBfXwcKPsbQoLQ3WbnxQwRMgEF2XTmLqDSLohYpQOeHkFI87VvB/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CN9Uo82m; arc=pass smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CN9Uo82m"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso4822761a91.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 16:36:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780961816; cv=none;
        d=google.com; s=arc-20240605;
        b=SK0FifKmYrqIO8BrUrwmCkYTjepxISyG3lT1lAP/BBks12blv0Ik5FUVXV1eiMjnJ7
         UszqKsySuhSwxyrlrpYx8sv4yxT1SsrsEkzLQWUdQSgY/odWUHlnC9M+B9eoRBrXuAU1
         BDJh7BtfbargYvd8RgCtsxvLC59zk5TICRPWEefZbuWXz356LzPm3ZXUmtmgrnP5A4k4
         fKC/S+MrzK2IWgJs0Szp0jPDtlBeqL9FUdQczfxEuIOT9holF1Dl2ssWGcpDtJ0BHDLe
         5/luq/TqG7kAY3bsF3qZBE+vPDtrMxK+A238b/fMhlNnkGZECAk5/eH6V8pyzSdgF1tO
         hzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ij79ouBFf/WYx184r4TdYnfS8nIaYFBPXnbq296CK6M=;
        fh=WfJB1YkHjfxkSMCsogHMbYc3pvCTmQRpLXh1eGJSZoM=;
        b=CKYbEvVFjo2o7h3QVS1fIp4mS1U52CsQxu0jJdXvkUNTu2h16xxsalh48hjyPx1sGa
         wfxw0EKBkwX1CL3cNCHUJHxSz7frcHswznwKLnkVe5mJaC3KFxpAoM7XzqlNwXwNGFP5
         zavxpIpVBWHrF6iHqYlY+SW0huacl2R0EexRxWB7kPfXIncwPNYvfafnuM+uZWTuBstp
         1G0nGW79dWScPq66735yEjoxamXyIOrxHDD8CMFKblVu9DQ97glFPDDgBu5JaKRKueMk
         qj0vTXVEyYvANFIP5SSiEBcS87FPYVDWmk8Arl6CGHY0uCVaSh5WdCNiULahhBx7/nsY
         3cLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780961816; x=1781566616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ij79ouBFf/WYx184r4TdYnfS8nIaYFBPXnbq296CK6M=;
        b=CN9Uo82mCKC2BXiMOxzjblFfuRP8K+iuM92ED08q4t7WPVqIVJB4HgiHdbMrkhjqGZ
         pEA5JQXl0YTfhdZqAjMPAbkonuexIWuFb43UFi38xPkGKbhdT6nam50TN6yBzvm4xEgC
         SFs2aEQ0Jvh1MD3gJ2pjF0SoHrJU+9OJ8h/qv/GnSLc9rDK/nP9olcWhR8MPHcTQfpNn
         ioBfv3uh9O+39oxplzGqGwou1sFZMvJczPt4Y9OoGOmzVHjaSJGjlWLSSzNYPYOwPFsB
         4tSNE7rZ12k/9wInwdCdW4A4fe7vGH+cwHwqlk2z/nTBp6+NAvkD9xW/PWjJudsdA1Bl
         CmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780961816; x=1781566616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij79ouBFf/WYx184r4TdYnfS8nIaYFBPXnbq296CK6M=;
        b=mWvwcvLLbHvLUg7DNc2g0K7zMCF6mQHRS1Vp11ksm1rVwQPmAhc6D2bAXWw4TBCF+b
         F07vIZr6s1rFAQYjXhBtN1rL6XDyJ+yCX3l4ym0Zic0+8e0V7IejFuGcAILueDvJ1iRG
         lyFbwrLOdQxjhCRrpQAqt2XDMzAWmQmlArWh+BDTShTgtKn3dodzZLJsZg5CYveA6s/+
         PdwB9NT0qEOKCVVFUKFNRxvhIN/sMBh0TKVp8eksunHTqYDKQWhE4VZZHyh66gwzGBib
         BUYjLStQUTe6bPlhEP0qfE7E9GTlvzYaRAa659M4Q5p+v5lovR+QP7bbu2fLeZJj7MUh
         f8Hw==
X-Gm-Message-State: AOJu0Yywbcp+X5ufzBEjXKqUjbNbykCbJLmD4fEAYUdks1kCC1TqlZ8H
	wA5Fi8QcHog4d4yl3GkAYc7pxPoChYikJ+4/jrqaqrLFIeFa9IRZ9Kx6Y+OgkvwgBFMbgKtncQX
	5+nWVuL5O/z+ak8LwnTAYn9wS2n8+aqNrgGgJ
X-Gm-Gg: Acq92OFlLbsYyW+WJq9LX+A2KMnWFxcs6EgRqTc/XW/Z9CbC69uB8H/O6vIPiNg7CjR
	udtDRp9Kh7nUnIpMb9ZomLqlvsAOzdVxrrJo6Ow16e5Z+IlxXA0/wn0vkmySzuynhPi8OXNUuPl
	6TYS7gVM62IM7SX3LZFrmVGpmoav6HQ6qugAlRK7wkI5SPaBgdEXB6Dorr2SVjSQbtTPoTurJ4I
	r8O0w7A0JNZfTTks4LMAXyd4CzyrM+6KNtiQ0NjOw8Q4b6bqZLNghFy3dp9vfxS7+bNVlFwVD+J
	TzTrmOdcGQpKqCTzf9H54yVVF6bUj3h5eotittAbk0h8XArH6Xglr4Sq3U5+2ULWQs9oxpfohq/
	THAswZZWOI/Tet7LEGbEnZZkhaX0M7cdC5uyOeg==
X-Received: by 2002:a17:90b:4b0f:b0:366:1172:597e with SMTP id
 98e67ed59e1d1-370ef2efae9mr18901235a91.9.1780961815992; Mon, 08 Jun 2026
 16:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 8 Jun 2026 19:36:45 -0400
X-Gm-Features: AVVi8CdsHynfyr4cUFmwV2t6fqwqrQFuibSDthN9G0FRpBGxj60Tk_xcTSaOfF0
Message-ID: <CALnO6CADMJSixqYvL1Yo8qKX5rWhKQ+2OoSEuPUh-yoeK9TseQ@mail.gmail.com>
Subject: git-diff in a worktree is an order of magnitude slower?
To: Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

I'd like to report and offer to help fix what I view as a serious performan=
ce
bug:

    "git diff --no-ext-diff --quiet" performs about ~10x slower in a second=
ary
    worktree than in the main worktree.

Fortunately, this doesn't seem to extend to "--cached" (and "--no-ext-diff"=
 and
"--quiet" are probably both red-herrings, since it _does_ extend to plain "=
git
diff").

Here's a short demo in Git:

    # git switch -d v2.54.0
    # ninja -C build # where my meson-generated build dir is
    # git worktree add --detach ../perf-test v2.54.0
    # hyperfine -N --warmup 10 './build/bin-wrappers/git diff'
    Benchmark 1: ./build/bin-wrappers/git diff
      Time (mean =C2=B1 =CF=83):       3.4 ms =C2=B1   0.5 ms    [User: 4.2=
 ms, System: 3.9 ms]
      Range (min =E2=80=A6 max):     2.5 ms =E2=80=A6   5.8 ms    677 runs
    # pushd ../perf-test
    # hyperfine -N --warmup 10 '../git/build/bin-wrappers/git diff'
    Benchmark 1: ../git/build/bin-wrappers/git diff
      Time (mean =C2=B1 =CF=83):     223.3 ms =C2=B1  10.5 ms    [User: 210=
.4 ms,
System: 19.1 ms]
      Range (min =E2=80=A6 max):   213.5 ms =E2=80=A6 243.9 ms    13 runs

I've had a similar experience at $DAYJOB, where a large repo takes ~6ms for=
 the
former and ~650ms for the latter. I noticed because the Bash prompt functio=
ns
execute "git diff --no-ext-diff --quiet", and that was (AFAICT) the largest
culprit for a slow shell prompt in a worktree. To squelch that from the pro=
mpt,
I have to go down the rabbit hole of the worktree config extension, so I fi=
gured
better to fix the slow diff if possible anyway.

2 questions:

1. Is this known, and if so is anybody working on it?
2. How can I help identify problem areas?

A little more
-------------

I've reproduced this as far back as v2.50.0, which is as far back as I coul=
d get
the meson build to work with little effort (so I can't rule out that this i=
s an
old regression).

Using "perf record -F 99 -g -- <bin-wrappers/git> diff" in both trees and t=
hen
"perf report":

- it looks like the main worktree spends most of it's time in preload_threa=
d,
  threaded_has_symlink_leading_path, lstat_cache=E2=80=A6
- the worktree spends a lot more time in ie_match_stat, ce_modified_check_f=
s,
  ce_compare_data, index_fd, would_convert_to_git_filter_fd=E2=80=A6

Here's the relevant "perf stat":

main tree:

 Performance counter stats for './build/bin-wrappers/git diff':

                 0      context-switches:u               #      0,0
cs/sec  cs_per_second
                 0      cpu-migrations:u                 #      0,0
migrations/sec  migrations_per_second
               967      page-faults:u                    #  65036,4
faults/sec  page_faults_per_second
             14,87 msec task-clock:u                     #      0,3
CPUs  CPUs_utilized
            48=E2=80=AF616      branch-misses:u                  #      3,2=
 %
branch_miss_rate         (57,19%)
         3=E2=80=AF571=E2=80=AF630      branches:u                       # =
   240,2
M/sec  branch_frequency
        13=E2=80=AF635=E2=80=AF411      cpu-cycles:u                     # =
     0,9
GHz  cycles_frequency
        22=E2=80=AF120=E2=80=AF068      instructions:u                   # =
     1,9
instructions  insn_per_cycle  (85,61%)
         3=E2=80=AF634=E2=80=AF065      stalled-cycles-frontend:u        # =
    0,28
frontend_cycles_idle        (9,56%)

       0,006860098 seconds time elapsed

       0,001364000 seconds user
       0,015157000 seconds sys

worktree:

 Performance counter stats for '../git/build/bin-wrappers/git diff':

                 0      context-switches:u               #      0,0
cs/sec  cs_per_second
                 0      cpu-migrations:u                 #      0,0
migrations/sec  migrations_per_second
             1=E2=80=AF585      page-faults:u                    #   5058,0
faults/sec  page_faults_per_second
            313,37 msec task-clock:u                     #      0,9
CPUs  CPUs_utilized
         2=E2=80=AF481=E2=80=AF188      branch-misses:u                  # =
     1,5 %
branch_miss_rate         (48,94%)
       168=E2=80=AF664=E2=80=AF155      branches:u                       # =
   538,2
M/sec  branch_frequency     (51,21%)
     1=E2=80=AF004=E2=80=AF095=E2=80=AF217      cpu-cycles:u               =
      #      3,2
GHz  cycles_frequency       (67,74%)
     3=E2=80=AF864=E2=80=AF851=E2=80=AF223      instructions:u             =
      #      3,9
instructions  insn_per_cycle  (52,73%)
        70=E2=80=AF755=E2=80=AF234      stalled-cycles-frontend:u        # =
    0,07
frontend_cycles_idle        (49,29%)

       0,306707634 seconds time elapsed

       0,269027000 seconds user
       0,045512000 seconds sys

My observations:
- the worktree has ~twice as many page faults and
- executes ~150 times as many instructions (3.8b compared to 23m).

(When I try to run some "perf" stats as root to access other counters, like
syscalls, "git diff" in the worktree says "not a git repository", so I'm no=
t
counting the actual behavior. Ditto with DTrace.)

PS I almost CC'd Peff and Patrick, whose names stood out in "git
shortlog builtin/{worktree,diff}* object-file* | sort -t\( -k2 -g",
but decided they'd be their own best judge of whether they can
understand what's going on? :)

--=20
D. Ben Knoble
