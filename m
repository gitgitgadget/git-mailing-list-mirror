Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B288D2D24BA
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 10:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277110; cv=none; b=YHWIme0xCugYpf/8SjMu9IAfvpOa0eeqUzQJ9V9eB2z2U1IyWXnDK/fEb02lIb+p+aI/txXj+X1gezJnSCNlogdceQ1KiB6DL4O8evXYv1IK9Ll/nb6kM2sy1R9J3COQKJ4HpDmNsF35XYhL2EfRY8Bx6RDPrtw6EVXVP/oYg1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277110; c=relaxed/simple;
	bh=MlTRjcCPvwI2p7k4xigHuycCwmBV0PCvvD9INGJQlJc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VmUx3lLcVRsVAVt30b6jLxeyoW25+fnrdKJ6INFZfOK+0qLtqjfOHfEs770XgYQqQycO7g3IIasQsvURZCSoqCiTO0Q43VA4IGQFJmHV8tW6Pmye7CUUqAIjk4mOtbdW4kqHZjxAM5SkaB8IcC4znOw8VHoz3BIbDenrqpVSoiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ape3000.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=ape3000-com.20230601.gappssmtp.com header.i=@ape3000-com.20230601.gappssmtp.com header.b=py2ISpvf; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ape3000.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ape3000-com.20230601.gappssmtp.com header.i=@ape3000-com.20230601.gappssmtp.com header.b="py2ISpvf"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso890058a12.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 03:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ape3000-com.20230601.gappssmtp.com; s=20230601; t=1758277107; x=1758881907; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zvXVOmK03bncqhW09JF6T8HZzCJBXodlUAl6AncejaE=;
        b=py2ISpvfpdKhLitAwL0C8+KzhA7LS+QuMlAa2jgxX/+91hj+C/WwNEqtumi2XS9n82
         bK3SGIDDxbNRuoQSVYcl+aFflaSWIhgHGMr6v+NDanSs8dO7+YKLDCWBz9jw9eX5MDPD
         nmkrMbVClmY+FmpI+leBojN2z7ZLW5zWw8R9zZ/7iccbpywo1EC64BCKntMJLELLPj0B
         zrJeGtWF7czDGpG6xOOQOi3mA1TAXBYgvgDPWE4GpNiruD+wXoKhNKUNHWQ24pX+zYCt
         9N52bu8XWEwz1Jtyb8/u/KEDjq+RtUBhC6sV5J98qB8hz2GX0C9PCktrmhMvqRed/e+1
         fkFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758277107; x=1758881907;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvXVOmK03bncqhW09JF6T8HZzCJBXodlUAl6AncejaE=;
        b=b2UaWuR8RhYmPz1VIuRQkfIvHVZCWrspZP7V2904fshWksvybK34Cp1odVnvbUpWP/
         4AegsQBXrr4tvGou9PZAEEfhfaJumcuw+2ifEJ2MKM9vnS8clqMgHSeNj5a2OwpLP1SK
         RELM+DhOw5ZeYfvByJXtG3nMnAHUB8s7gtvQzQEYos3DzcquOBXsRYtkMC7gF3+vWhhm
         ST1GXmLFv2gevWRowDPNLcMul+Aplfa34cxzGWhvZFuXJRcObK6qgKpuuPiz049UTe7i
         oYWz28/SV3uszFbYtm1bJijaJMiY6BQTD5MJmrXRyH2O4HOiSgY0XLs7yXXDDtLaZvoM
         SaQw==
X-Gm-Message-State: AOJu0YzLz8mAiDCU6p2Rlj7MRPE9OtXlCfA78NriOjpmwGGJyEpscU/t
	sJVGbZ4Px0VDo2PnsOv0T70jIdF+m+VADs9PSaxs/PdytmycPpFfWO53Hr80kOlW8DzCYlFTgUY
	XAU6zxpaUlBSmTwVoik6eKYCCRQaBSlTbzQWNxGGBQw==
X-Gm-Gg: ASbGncuE+wUps7Zqo7UdK7B70eqs4lkKSUVixQBHnq2K8eC/6CCyDFOyI1gbO6gvTik
	nA+PZ91QQ3PiA7TPaDZjdvPnbnZrJp2YwOAPkRr/tBZtaclFS9X+qy3XySU6meUOIIkeRL/Yany
	vH8km8UX/lktcxA2tagLDUgX3osl2Kg9S7Y3tAL6UKUeTRzVxrz/WNsvzsYQH5iOz9Y4VarWN04
	9wLfAKwEVcBUT/JoBk=
X-Google-Smtp-Source: AGHT+IFQU4ykJhpdsCtwScbVa8UDcD3wAzpYEPd8ii8odPknkEcZwLOhbWdSh0IpfzpHBuMsqTdt+l+XuM5iNh+sKeg=
X-Received: by 2002:a05:6402:5107:b0:62f:1e7a:f842 with SMTP id
 4fb4d7f45d1cf-62fc0abc18amr2696475a12.27.1758277106414; Fri, 19 Sep 2025
 03:18:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Lauri Niskanen <ape@ape3000.com>
Date: Fri, 19 Sep 2025 13:18:15 +0300
X-Gm-Features: AS18NWDAcWuwb8rhCvA4cbMPc6an_miBfgPbRUjBB2iNZzzupx9drGz__dOtPB0
Message-ID: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
Subject: [BUG] git stash show -p with invalid option aborts with double-free
 in show_stash() (strvec_clear)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened?

Create a repo and a stash entry, then invoke `git stash show -p` with
an invalid option:

git init repro
cd repro
touch a
git add a
git commit -m init
echo x >> a
git stash
git stash show -p --invalid


What did you expect to happen?

Git should print a usage / option error and exit cleanly without crashing.


What happened instead?

free(): double free detected in tcache 2


GDB backtrace:
#0  __pthread_kill_implementation (threadid=<optimized out>,
signo=signo@entry=6, no_tid=no_tid@entry=0) at pthread_kill.c:44
#1  0x00007ffff7c98a13 in __pthread_kill_internal (threadid=<optimized
out>, signo=6) at pthread_kill.c:89
#2  0x00007ffff7c3e410 in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
#3  0x00007ffff7c2557a in __GI_abort () at abort.c:77
#4  0x00007ffff7c26613 in __libc_message_impl
(fmt=fmt@entry=0x7ffff7db4355 "%s\n") at
../sysdeps/posix/libc_fatal.c:138
#5  0x00007ffff7ca2d65 in malloc_printerr
(str=str@entry=0x7ffff7db7d78 "free(): double free detected in tcache
2") at malloc.c:5892
#6  0x00007ffff7ca82e8 in tcache_double_free_verify (e=<optimized
out>) at malloc.c:3350
#7  0x00007ffff7ca80a5 in __GI___libc_free (mem=<optimized out>) at
malloc.c:3547
#8  0x00005555558570ce in strvec_clear (array=0x7fffffffc580) at
/usr/src/debug/git/git/strvec.c:134
#9  0x000055555567d9f9 in show_stash (argc=<optimized out>,
argv=<optimized out>, prefix=<optimized out>, repo=<optimized out>) at
builtin/stash.c:1047
#10 0x0000555555686f25 in cmd_stash (argc=3, argv=0x5555559bd260,
prefix=0x0, repo=0x555555992ae0 <the_repo.lto_priv>) at
builtin/stash.c:2410
#11 0x000055555555fd43 in run_builtin (p=0x555555984698
<commands.lto_priv+2904>, argc=<optimized out>, argv=<optimized out>,
repo=0x555555992ae0 <the_repo.lto_priv>) at
/usr/src/debug/git/git/git.c:480
#12 handle_builtin (args=args@entry=0x7fffffffe1d0) at
/usr/src/debug/git/git/git.c:746
#13 0x00005555555608a2 in run_argv (args=0x7fffffffe1d0) at
/usr/src/debug/git/git/git.c:813
#14 cmd_main (argc=<optimized out>, argv=<optimized out>) at
/usr/src/debug/git/git/git.c:953
#15 0x000055555555d784 in main (argc=5, argv=0x7fffffffe518) at
/usr/src/debug/git/git/common-main.c:9

Valgrind:
==2507916== Memcheck, a memory error detector
==2507916== Copyright (C) 2002-2024, and GNU GPL'd, by Julian Seward et al.
==2507916== Using Valgrind-3.25.1 and LibVEX; rerun with -h for copyright info
==2507916== Command: git stash show -p --invalid
==2507916==
==2507916== Invalid free() / delete / delete[] / realloc()
==2507916==    at 0x4CB18EF: free (vg_replace_malloc.c:989)
==2507916==    by 0x43030CD: strvec_clear (strvec.c:134)
==2507916==    by 0x41299F8: show_stash.lto_priv.0 (stash.c:1047)
==2507916==    by 0x4132F24: cmd_stash (stash.c:2410)
==2507916==    by 0x400BD42: UnknownInlinedFun (git.c:480)
==2507916==    by 0x400BD42: handle_builtin (git.c:746)
==2507916==    by 0x400C8A1: UnknownInlinedFun (git.c:813)
==2507916==    by 0x400C8A1: cmd_main (git.c:953)
==2507916==    by 0x4009783: main (common-main.c:9)
==2507916==  Address 0x4ff4540 is 0 bytes inside a block of size 8 free'd
==2507916==    at 0x4CB18EF: free (vg_replace_malloc.c:989)
==2507916==    by 0x43030CD: strvec_clear (strvec.c:134)
==2507916==    by 0x41299F8: show_stash.lto_priv.0 (stash.c:1047)
==2507916==    by 0x4132F24: cmd_stash (stash.c:2410)
==2507916==    by 0x400BD42: UnknownInlinedFun (git.c:480)
==2507916==    by 0x400BD42: handle_builtin (git.c:746)
==2507916==    by 0x400C8A1: UnknownInlinedFun (git.c:813)
==2507916==    by 0x400C8A1: cmd_main (git.c:953)
==2507916==    by 0x4009783: main (common-main.c:9)
==2507916==  Block was alloc'd at
==2507916==    at 0x4CAE7A8: malloc (vg_replace_malloc.c:446)
==2507916==    by 0x4E6E2AF: strdup (strdup.c:42)
==2507916==    by 0x4129624: UnknownInlinedFun (wrapper.c:43)
==2507916==    by 0x4129624: UnknownInlinedFun (strvec.c:25)
==2507916==    by 0x4129624: show_stash.lto_priv.0 (stash.c:994)
==2507916==    by 0x4132F24: cmd_stash (stash.c:2410)
==2507916==    by 0x400BD42: UnknownInlinedFun (git.c:480)
==2507916==    by 0x400BD42: handle_builtin (git.c:746)
==2507916==    by 0x400C8A1: UnknownInlinedFun (git.c:813)
==2507916==    by 0x400C8A1: cmd_main (git.c:953)
==2507916==    by 0x4009783: main (common-main.c:9)
==2507916==
usage: git stash show [-u | --include-untracked | --only-untracked]
[<diff-options>] [<stash>]

    -u, --[no-]include-untracked
                          include untracked files in the stash
    --only-untracked      only show untracked files in the stash

==2507916==
==2507916== HEAP SUMMARY:
==2507916==     in use at exit: 696,349 bytes in 371 blocks
==2507916==   total heap usage: 750 allocs, 380 frees, 1,221,944 bytes allocated
==2507916==
==2507916== LEAK SUMMARY:
==2507916==    definitely lost: 3 bytes in 1 blocks
==2507916==    indirectly lost: 0 bytes in 0 blocks
==2507916==      possibly lost: 120 bytes in 3 blocks
==2507916==    still reachable: 696,226 bytes in 367 blocks
==2507916==         suppressed: 0 bytes in 0 blocks
==2507916== Rerun with --leak-check=full to see details of leaked memory
==2507916==
==2507916== For lists of detected and suppressed errors, rerun with: -s
==2507916== ERROR SUMMARY: 1 errors from 1 contexts (suppressed: 0 from 0)


[System Info]
git version:
git version 2.51.0
cpu: x86_64
built from commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.15.0
OpenSSL: OpenSSL 3.5.2 5 Aug 2025
zlib-ng: 2.2.5
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.16.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 11 Sep 2025
17:42:36 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.42
$SHELL (typically, interactive shell): /usr/bin/zsh


[Enabled Hooks]


--
Lauri Niskanen
