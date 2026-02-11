Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF721C16E
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 08:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770797148; cv=pass; b=R6zniRNVcQwNwc3mgwV8hld3zpk1jmNCCFJVZxW6J3/7R8QSmmuxMExFqNUoZQAaWgOHQg+sCBr63JBT+bYFYAIeXHQ3kCQYmxIsr7/PnVgkUzqPjQoFc7p77PfNxm+T5R23aVFH4Rf4u+aJL7jRZRMDQZt1RVNOwOBipPAqjo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770797148; c=relaxed/simple;
	bh=SvoT2lgelnloVHHAYjMC64RVOlg+bJ3gMNxecltxwEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tv3HYuWsqxZngDx35dFx6p/RX3npAhT0G79xvaSE5h/r8nZKvjanD3rYftXt2fW0J+byrPQtqs9XOjhRVdqyU1zbNrnmd47DrMSGbXcL6fbmmGHOq1wLFcagQU3RibVLqI8T4r9tVqJXQDPhzSq9mzw+6FxdflALM0PTuJgq6Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGZL1pQI; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGZL1pQI"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12336c0a8b6so1145396c88.1
        for <git@vger.kernel.org>; Wed, 11 Feb 2026 00:05:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770797145; cv=none;
        d=google.com; s=arc-20240605;
        b=HDK9JmlAC2oX19mw7ANSGF5UrL5w4BLweG5UGQBlxfY1FRoiINnOItrGbWAEpK7C8f
         DizHAJOA5cCCXo4likGZEfoMtPYBEWpn5YdRH/DmPrX5Q+24CNspq+MrreWS14BFYWVz
         V/VB9scoklppjAdtXyRs3mMWWxM2yrFGBY89OnQlJNcYaohrp48QaHwv9zHN/jg0Elj7
         a8BjskERIQvpbtDV50LeVagShKkxltuPIQkz9qq8TnmJMf0Ll8G5BT60sY+4lwjsZeHo
         CUm3bSud7owoGohQUsjRKV9ZGEhITDvRPJCr4zFSEdVliAImYA2N5tY5scqpJf8SThzE
         JIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3dEW2fHR8l0JwaSHgH4n/edM/BZ45ATL0BlpNMFr6gw=;
        fh=aE5BSS+9FxTxmESdCib8pVnFL01tZJaubiFrVnPT3no=;
        b=GrEWnR1d9Luhc2VUnQhJXVCR78rRhaqk7/z1AcriUErQ8XOH4LQf23o8MhFp4fYn64
         I4ADvdVGq8csHUNfd1zafBkVZhLCBt/NoHxXKMGTrAJZFAZTyw18S4OyJ//+89pVpr+/
         oeb0JgjRh6XMV4OAi3C68brmmA8gzLu1/+gf/1sltmVQ03G6eYl/q2TYECA0+Fq9Zry1
         qtQmS2QvU/zZM+bxAMup6cCHgFuB6XDyfg9I9scB+Wjc80E0aDsgTgUy+quCE0U9Tlx6
         x530uHzPYrrlEswmnQt7j+5OjafNvRbCYAVF/EgYoDHKHCKlXnug2mTt3eCpqCzRNwih
         Q0vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770797145; x=1771401945; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3dEW2fHR8l0JwaSHgH4n/edM/BZ45ATL0BlpNMFr6gw=;
        b=cGZL1pQIBjZwJVaY17a10PeiMxSJtdLyTvTPBnDmJOG2uTCBRWEkIqnr9Cez0F4rM6
         TbyNZPo0J8pymswwkKN4zhX0Bg/aPlRwG5k65mLKnYQ4upzC7la1+8e7f3V4X/9D95XJ
         sM89zF3DP4T+zVw0R8pAFqeA/SKmNsyrgTHeZfdEm1EHLo5PMZV17IYscH9I7DFB496e
         FyzCpTf8kXaOeEpN0k0z4P31dztOdCz5d2P4dzfsIB+m4jhbVsAMNCk5fshZfcfjperS
         JllAzsSJ2ov+yUcTEoyjfBoa8eIqNl9zHsnDV/PWGrY2ME5Ly9+TLnVNJq9HnsYnO9ZW
         VMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770797145; x=1771401945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dEW2fHR8l0JwaSHgH4n/edM/BZ45ATL0BlpNMFr6gw=;
        b=mwGEakDJTLlI41cxbvoy3hLjmTBSVpkFy/Kv4fAe2ZXLzHBUjybluhCnvMUfl5N3Td
         S+Pfdf2HQTAnV5U8JUpoAJJorWFvwk6x6+wbgDokfRrAs9+su/ZLMvAt2HqXH9/bKjy/
         fDDAJ2sFL/hBa47unguPfRencXPR+7sxCyBFvx4jy/bWERBVI6A+rvNTuDS1kfZBC45l
         Lexj7ha9ylkL8cYmZxk6NXVkrVQ1X5pqUD9PCxxZabLB9+khKJHWfHEtHp5KSfWaK5zA
         A/s5tMlee0b4zzb3sSwVPILjR1Qdv4MW1s7cipMLh9RGWtvTRWVYwSBrkN81FBxxYwyc
         YZew==
X-Forwarded-Encrypted: i=1; AJvYcCWvy8kotQQXGSL0oH5/XKhK1CECUtwcEa3IsabGf5BObYnLZKVQChIp/l43wraToTX58Z8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZPbaUsRvVqeiWV+sHP3ugJ6sywjjjSDWM1jRtx+tD4XRP1BI
	OOB+msr75Ie3u+1b1cV+dAGkYuJtYtsOygcusT4zZtEpf+2wtG0zURPAvabZCaho7JA0sRJGzLw
	8gbTpRkcqnj09h69Km+81UgESjsG3w+Q=
X-Gm-Gg: AZuq6aLcqISyt2yG37SXpKZRWQi6xp/A8BtZtLN+yVp1CT+wYPEAr2XwOUZK7E6xgwe
	QwSv/Fra7TEbUZkVL4ZrI9SE9OeI1X34EVmKCFzwIBNbjqtrXMT0BFikpOi1chYf3uZYYVzXo14
	ZSY5TVXCrT7c4CF94n6qrWG+xNOM0RO3C0rZ+PuDaPvqt++g7GvA66KOae92YOQDPvlEBeujUKI
	d2UMvWA4m4KeTDbJa0Sq+ZBIpGejP8RRuUXKN2FwgNLJw0NAUm6L1XAkgSOy1iZKSJbgkEA/GCe
	Pfp7o8CyTg==
X-Received: by 2002:a05:701a:c96e:b0:11b:c4ee:66b with SMTP id
 a92af1059eb24-1272a7da046mr459999c88.37.1770797145312; Wed, 11 Feb 2026
 00:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aYsEpvFwCSHb5DYO@ubuntu> <0a45d72a-2a11-4363-ad2b-9fabff70bc9f@gmail.com>
In-Reply-To: <0a45d72a-2a11-4363-ad2b-9fabff70bc9f@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Wed, 11 Feb 2026 09:05:45 +0100
X-Gm-Features: AZwV_QiG4ZPD8tpqt7cp9wRXmFg8nmwTNfzTywB7SiAuDy3EUUCHvSccFibkOb0
Message-ID: <CAD=f0L8WwC8rkUVseKWme--xaJO5YnrKUmEVrr8w-KQxqLRCcQ@mail.gmail.com>
Subject: Re: [Outreachy PATCH v6 1/3] environment: stop storing
 `core.attributesFile` globally
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, toon@iotcl.com, 
	christian.couder@gmail.com, usmanakinyemi202@gmail.com, 
	kaartic.sivaraam@gmail.com, me@ttaylorr.com, karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Feb 2026 at 16:07, Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 10/02/2026 10:17, Bello Caleb Olamide wrote:
>
> > Initialized empty Git repository in /home/ubuntu/Code/open_source/git/t/trash directory.t4027-diff-submodule/sub/.git/
> > [master (root-commit) 4431e0b] submodule
> >   Author: A U Thor <author@example.com>
> >   1 file changed, 1 insertion(+)
> >   create mode 100644 world
> > BUG: repository.c:56: trying to read config from wrong repository instance
> > Aborted (core dumped)
>
> What does the backtrace show if you load the coredump into gdb? If
> you're using systemd you should be able to run
>
>      coredumpctl gdb
>
> to start gdb on the last coredump (you can list them with "coredumpctl
> list" if you need to select a different one) and then you can run
>
>      bt full
>
> in gdb to get a backtrace.
>
> If you have an actual coredump file then you can just run "gdb
> path/to/coredump"
>

Thank you Phillip.
I have been able to generate the backtrace

coredumpctl gdb
           PID: 43422 (git)
           UID: 1000 (ubuntu)
           GID: 1000 (ubuntu)
        Signal: 6 (ABRT)
     Timestamp: Wed 2026-02-11 08:43:11 WAT (15s ago)
  Command Line: git submodule--helper add -- ./S
    Executable: /home/ubuntu/Code/open_source/git/git
 Control Group:
/user.slice/user-1000.slice/user@1000.service/app.slice/app-org.gnome.Terminal.slice/vte-spawn-29116a64-3a3d-4a87-b321-1dd9a0e862c7.scope
          Unit: user@1000.service
     User Unit: vte-spawn-29116a64-3a3d-4a87-b321-1dd9a0e862c7.scope
         Slice: user-1000.slice
     Owner UID: 1000 (ubuntu)
       Boot ID: a3430056a91d43f49b602796f4eafc8c
    Machine ID: 4fb1781ac9f64d5cad47e77f1ed4f268
      Hostname: ubuntu
       Storage:
/var/lib/systemd/coredump/core.git.1000.a3430056a91d43f49b602796f4eafc8c.43422.1770795791000000.zst
(present)
     Disk Size: 43.4K
       Message: Process 43422 (git) of user 1000 dumped core.

                Found module /home/ubuntu/Code/open_source/git/git
with build-id: d3afb1a6b38e0303f833747d30b120a5c520f40e
                Found module linux-vdso.so.1 with build-id:
c1c6868625bceb6f487c419392bd09e4edbfc5d9
                Found module libc.so.6 with build-id:
9f32d43c341bff10b9e7196738eedcfc4f3cc36c
                Found module libz.so.1 with build-id:
b781927da654e744ed29ff39815bef9c750eaf24
                Found module libc_malloc_debug.so.0 with build-id:
1e0d2faf0cfdf8b3b9940dc5937792836187f911
                Stack trace of thread 43422:
                #0  0x0000ffffb8802008 __pthread_kill_implementation
(libc.so.6 + 0x82008)
                #1  0x0000ffffb87ba83c __GI_raise (libc.so.6 + 0x3a83c)
                #2  0x0000ffffb87a7134 __GI_abort (libc.so.6 + 0x27134)
                #3  0x0000aaaab14af398 n/a
(/home/ubuntu/Code/open_source/git/git + 0x39f398)
                #4  0x0000aaaab14af398 n/a
(/home/ubuntu/Code/open_source/git/git + 0x39f398)
                #5  0x0000aaaab14af454 n/a
(/home/ubuntu/Code/open_source/git/git + 0x39f454)
                #6  0x0000aaaab14257ac n/a
(/home/ubuntu/Code/open_source/git/git + 0x3157ac)
                #7  0x0000aaaab1425890 n/a
(/home/ubuntu/Code/open_source/git/git + 0x315890)
                #8  0x0000aaaab142609c n/a
(/home/ubuntu/Code/open_source/git/git + 0x31609c)
                #9  0x0000aaaab142625c n/a
(/home/ubuntu/Code/open_source/git/git + 0x31625c)
                #10 0x0000aaaab13eeedc n/a
(/home/ubuntu/Code/open_source/git/git + 0x2deedc)
                #11 0x0000aaaab13eeab8 n/a
(/home/ubuntu/Code/open_source/git/git + 0x2deab8)
                #12 0x0000aaaab1249088 n/a
(/home/ubuntu/Code/open_source/git/git + 0x139088)
                #13 0x0000aaaab1249650 n/a
(/home/ubuntu/Code/open_source/git/git + 0x139650)
                #14 0x0000aaaab1249c84 n/a
(/home/ubuntu/Code/open_source/git/git + 0x139c84)
                #15 0x0000aaaab1132314 n/a
(/home/ubuntu/Code/open_source/git/git + 0x22314)
                #16 0x0000aaaab11328b0 n/a
(/home/ubuntu/Code/open_source/git/git + 0x228b0)
                #17 0x0000aaaab1132bd4 n/a
(/home/ubuntu/Code/open_source/git/git + 0x22bd4)
                #18 0x0000aaaab1133074 n/a
(/home/ubuntu/Code/open_source/git/git + 0x23074)
                #19 0x0000aaaab125e86c n/a
(/home/ubuntu/Code/open_source/git/git + 0x14e86c)
                #20 0x0000ffffb87a7400 __libc_start_call_main
(libc.so.6 + 0x27400)
                #21 0x0000ffffb89cf370 n/a (n/a + 0x0)
                #22 0x0000ffffb89cf370 n/a (n/a + 0x0)
                #23 0x3d455441445f524f n/a (n/a + 0x0)

GNU gdb (Ubuntu 12.1-0ubuntu1~22.04.2) 12.1
Copyright (C) 2022 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "aarch64-linux-gnu".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from /home/ubuntu/Code/open_source/git/git...
[New LWP 43422]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/aarch64-linux-gnu/libthread_db.so.1".
Core was generated by `git submodule--helper add -- ./S'.
Program terminated with signal SIGABRT, Aborted.
#0  __pthread_kill_implementation (threadid=281473778995232,
signo=signo@entry=6,
    no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
44 ./nptl/pthread_kill.c: No such file or directory.
(gdb) bt full
#0  __pthread_kill_implementation (threadid=281473778995232,
signo=signo@entry=6,
    no_tid=no_tid@entry=0) at ./nptl/pthread_kill.c:44
        tid = 43422
        ret = 0
        pd = 0xffffb89c5020
        old_mask = {__val = {16453191242184589568, 281474327489088,
187650095641156,
            281474327489568, 281474327489568, 281474327489520,
18446743528248704984,
            17298308644996116495, 17298308644996116495, 17298308644996116480,
            16453191242184589568, 281474327488672, 187650095637040,
281474327488752,
            18446743042917400560, 281474327489088}}
        ret = <optimized out>
#1  0x0000ffffb8802054 in __pthread_kill_internal (signo=6,
threadid=<optimized out>)
    at ./nptl/pthread_kill.c:78
No locals.
#2  0x0000ffffb87ba83c in __GI_raise (sig=sig@entry=6) at
../sysdeps/posix/raise.c:26
        ret = <optimized out>
#3  0x0000ffffb87a7134 in __GI_abort () at ./stdlib/abort.c:79
        save_stage = 1
        act = {__sigaction_handler = {sa_handler = 0xaaaad0012bfb,
            sa_sigaction = 0xaaaad0012bfb}, sa_mask = {__val =
{187650610900023, 0, 0,
              0, 0, 0, 4294967295, 0, 187651416064000, 0, 281473778608136,
              281474327489232, 187650095641436, 281474327489264,
281473778608284,
              187650610899888}}, sa_flags = -1, sa_restorer = 0x88}
        sigs = {__val = {32, 187650096456616, 243494161448, 187650096456672,
            281474327489824, 8099004987637978434, 3348833620946678639,
            18374721914061273699, 281474327488992, 281474904195073,
187650610899963,
            187650610899963, 187650610899963, 187650610899963, 187650610899964,
            187650610900023}}
#4  0x0000aaaab14af398 in BUG_vfl (file=0xaaaab15763e0 "repository.c", line=56,
    fmt=0xaaaab15763a8 "trying to read config from wrong repository instance",
    params=...) at usage.c:350
        params_copy = {__stack = 0xffffd94dac20, __gr_top = 0xffffd94dac20,
          __vr_top = 0xffffd94dabf0, __gr_offs = -40, __vr_offs = -128}
        in_bug = 1
#5  0x0000aaaab14af454 in BUG_fl (file=0xaaaab15763e0 "repository.c", line=56,
    fmt=0xaaaab15763a8 "trying to read config from wrong repository instance")
--Type <RET> for more, q to quit, c to continue without paging--
    at usage.c:360
        ap = {__stack = 0xffffd94dac20, __gr_top = 0xffffd94dac20,
          __vr_top = 0xffffd94dabf0, __gr_offs = -40, __vr_offs = -128}
#6  0x0000aaaab14257ac in repo_config_values (repo=0xaaaad0012900) at
repository.c:56
No locals.
#7  0x0000aaaab1425890 in initialize_repository (repo=0xaaaad0012900)
    at repository.c:73
No locals.
#8  0x0000aaaab142609c in repo_init (repo=0xaaaad0012900,
    gitdir=0xaaaad0012b10 "/home/ubuntu/Code/open_source/git/t/trash
directory.t7422-submodule-output/S/.git",
    worktree=0xaaaad0012bb0 "/home/ubuntu/Code/open_source/git/t/trash
directory.t7422-submodule-output/S") at repository.c:284
        format = {version = -1, precious_objects = 0, partial_clone = 0x0,
          worktree_config = 0, relative_worktrees = 0, is_bare = -1,
hash_algo = 1,
          compat_hash_algo = 0, ref_storage_format = REF_STORAGE_FORMAT_FILES,
          sparse_index = 0, work_tree = 0x0, unknown_extensions = {items = 0x0,
            nr = 0, alloc = 0, strdup_strings = 1, cmp = 0x0},
v1_only_extensions = {
            items = 0x0, nr = 0, alloc = 0, strdup_strings = 1, cmp = 0x0}}
#9  0x0000aaaab142625c in repo_submodule_init (subrepo=0xaaaad0012900,
    superproject=0xaaaab1656c98 <the_repo>, path=0xaaaad0012080 "S",
    treeish_name=0xaaaab1558cc8 <null_oid_sha1>) at repository.c:329
        gitdir = {alloc = 136, len = 81,
          buf = 0xaaaad0012b10
"/home/ubuntu/Code/open_source/git/t/trash
directory.t7422-submodule-output/S/.git"}
        worktree = {alloc = 136, len = 76,
          buf = 0xaaaad0012bb0
"/home/ubuntu/Code/open_source/git/t/trash
directory.t7422-submodule-output/S"}
        ret = 0
#10 0x0000aaaab13eeedc in repo_get_submodule_ref_store (
    repo=0xaaaab1656c98 <the_repo>, submodule=0xaaaad0012080 "S") at refs.c:2258
        submodule_sb = {alloc = 24, len = 6, buf = 0xaaaad0012500 "S/.git"}
        refs = 0x0
        to_free = 0x0
        len = 1
        subrepo = 0xaaaad0012900
--Type <RET> for more, q to quit, c to continue without paging--
#11 0x0000aaaab13eeab8 in repo_resolve_gitlink_ref (r=0xaaaab1656c98 <the_repo>,
    submodule=0xaaaad0012080 "S", refname=0xaaaab1537d50 "HEAD",
oid=0xffffd94dae80)
    at refs.c:2141
        refs = 0x1
        flags = 1
#12 0x0000aaaab1249088 in die_on_repo_without_commits (path=0xaaaad0012080 "S")
    at builtin/submodule--helper.c:3423
        oid = {hash = '\000' <repeats 24 times>, "\200
\001\u042a\252\000", algo = 0}
        sb = {alloc = 24, len = 1, buf = 0xaaaad00125f0 "S"}
#13 0x0000aaaab1249650 in module_add (argc=1, argv=0xaaaad0010ce0, prefix=0x0,
    repo=0xaaaab1656c98 <the_repo>) at builtin/submodule--helper.c:3522
        force = 0
        quiet = 0
        progress = 0
        dissociate = 0
        add_data = {prefix = 0x0, branch = 0x0, reference_path = 0x0,
          sm_path = 0xaaaad0012080 "S", sm_name = 0x0, repo =
0xaaaad0010ae0 "./S",
          realrepo = 0xaaaad0012590
"/home/ubuntu/Code/open_source/git/t/trash
directory.t7422-submodule-output/S", ref_storage_format =
REF_STORAGE_FORMAT_UNKNOWN,
          depth = -1, force = 0, quiet = 0, progress = 0, dissociate = 0}
        ref_storage_format = 0x0
        to_free = 0xaaaad0012590
"/home/ubuntu/Code/open_source/git/t/trash
directory.t7422-submodule-output/S"
        existing = 0xaaaab156aa08
        buf = {alloc = 0, len = 0, buf = 0xaaaab16572f8 <strbuf_slopbuf> ""}
        sm_name_to_free = 0x0
        options = {{type = OPTION_STRING, short_name = 98,
            long_name = 0xaaaab1539658 "branch", value = 0xffffd94daf60,
            precision = 0, argh = 0xaaaab1539658 "branch",
            help = 0xaaaab1539c80 "branch of repository to add as submodule",
            flags = 0, callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0x0}, {type = OPTION_COUNTUP, short_name = 102,
            long_name = 0xaaaab1538070 "force", value =
0xffffd94daee8, precision = 4,
            argh = 0x0,
            help = 0xaaaab1539cb0 "allow adding an otherwise ignored
submodule path",
            flags = (PARSE_OPT_NOARG | PARSE_OPT_NOCOMPLETE), callback = 0x0,
--Type <RET> for more, q to quit, c to continue without paging--
            defval = 0, ll_callback = 0x0, extra = 0, subcommand_fn = 0x0}, {
            type = OPTION_COUNTUP, short_name = 113,
            long_name = 0xaaaab15375e0 "quiet", value =
0xffffd94daeec, precision = 4,
            argh = 0x0, help = 0xaaaab1539748 "print only error messages",
            flags = PARSE_OPT_NOARG, callback = 0x0, defval = 0,
ll_callback = 0x0,
            extra = 0, subcommand_fn = 0x0}, {type = OPTION_SET_INT,
short_name = 0,
            long_name = 0xaaaab15387a0 "progress", value = 0xffffd94daef0,
            precision = 4, argh = 0x0, help = 0xaaaab15387b0 "force
cloning progress",
            flags = PARSE_OPT_NOARG, callback = 0x0, defval = 1,
ll_callback = 0x0,
            extra = 0, subcommand_fn = 0x0}, {type = OPTION_STRING,
short_name = 0,
            long_name = 0xaaaab15386a8 "reference", value = 0xffffd94daf68,
            precision = 0, argh = 0xaaaab1539ce8 "repository",
            help = 0xaaaab15386c0 "reference repository", flags = 0,
callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0, subcommand_fn = 0x0}, {
            type = OPTION_STRING, short_name = 0,
            long_name = 0xaaaab15386d8 "ref-format", value = 0xffffd94daf00,
            precision = 0, argh = 0xaaaab15386e8 "format",
            help = 0xaaaab15386f0 "specify the reference format to
use", flags = 0,
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0x0}, {type = OPTION_SET_INT, short_name = 0,
            long_name = 0xaaaab1538718 "dissociate", value = 0xffffd94daef4,
            precision = 4, argh = 0x0,
            help = 0xaaaab1539cf8 "borrow the objects from reference
repositories",
            flags = PARSE_OPT_NOARG, callback = 0x0, defval = 1,
ll_callback = 0x0,
            extra = 0, subcommand_fn = 0x0}, {type = OPTION_STRING,
short_name = 0,
            long_name = 0xaaaab1538648 "name", value = 0xffffd94daf78,
precision = 0,
            argh = 0xaaaab1538648 "name",
            help = 0xaaaab1539d28 "sets the submodule's name to the
given string instead of defaulting to its path", flags = 0, callback =
0x0, defval = 0, ll_callback = 0x0,
            extra = 0, subcommand_fn = 0x0}, {type = OPTION_INTEGER,
short_name = 0,
            long_name = 0xaaaab1538750 "depth", value =
0xffffd94daf94, precision = 4,
            argh = 0xaaaab1537cf0 "n",
            help = 0xaaaab1538758 "depth for shallow clones", flags = 0,
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0x0}, {type = OPTION_END, short_name = 0,
long_name = 0x0,
            value = 0x0, precision = 0, argh = 0x0, help = 0x0, flags = 0,
--Type <RET> for more, q to quit, c to continue without paging--
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0x0}}
        usage = {
          0xaaaab1539d78 "git submodule add [<options>] [--]
<repository> [<path>]",
          0x0}
        sb = {alloc = 0, len = 0, buf = 0xaaaab16572f8 <strbuf_slopbuf> ""}
        ret = 1
#14 0x0000aaaab1249c84 in cmd_submodule__helper (argc=3, argv=0xaaaad0010ce0,
    prefix=0x0, repo=0xaaaab1656c98 <the_repo>) at
builtin/submodule--helper.c:3616
        fn = 0xaaaab12490dc <module_add>
        usage = {0xaaaab1539ec0 "git submodule--helper <command>", 0x0}
        options = {{type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab15384b8 "clone", value =
0xffffd94db430, precision = 0,
            argh = 0x0, help = 0x0, flags = 0, callback = 0x0, defval = 0,
            ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab124403c <module_clone>}, {type =
OPTION_SUBCOMMAND,
            short_name = 0, long_name = 0xaaaab1539b98 "add", value =
0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab12490dc <module_add>}, {type =
OPTION_SUBCOMMAND,
            short_name = 0, long_name = 0xaaaab1538f78 "update",
            value = 0xffffd94db430, precision = 0, argh = 0x0, help =
0x0, flags = 0,
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1246e44 <module_update>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1537500 "foreach", value = 0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab123fe24 <module_foreach>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1539110 "init", value = 0xffffd94db430,
precision = 0,
            argh = 0x0, help = 0x0, flags = 0, callback = 0x0, defval = 0,
            ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1240418 <module_init>}, {type =
OPTION_SUBCOMMAND,
            short_name = 0, long_name = 0xaaaab15378e8 "status",
            value = 0xffffd94db430, precision = 0, argh = 0x0, help =
0x0, flags = 0,
--Type <RET> for more, q to quit, c to continue without paging--
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1240ca8 <module_status>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1537e48 "sync", value = 0xffffd94db430,
precision = 0,
            argh = 0x0, help = 0x0, flags = 0, callback = 0x0, defval = 0,
            ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1242a0c <module_sync>}, {type =
OPTION_SUBCOMMAND,
            short_name = 0, long_name = 0xaaaab1539ee0 "deinit",
            value = 0xffffd94db430, precision = 0, argh = 0x0, help =
0x0, flags = 0,
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1243074 <module_deinit>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1539ee8 "summary", value = 0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1242164 <module_summary>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1539ef0 "push-check", value = 0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab12476f4 <push_check>}, {type =
OPTION_SUBCOMMAND,
            short_name = 0, long_name = 0xaaaab1539f00 "absorbgitdirs",
            value = 0xffffd94db430, precision = 0, argh = 0x0, help =
0x0, flags = 0,
            callback = 0x0, defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab12479a8 <absorb_git_dirs>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1539f10 "set-url", value = 0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1247b40 <module_set_url>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
            long_name = 0xaaaab1539f18 "set-branch", value = 0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1247d74 <module_set_branch>}, {
            type = OPTION_SUBCOMMAND, short_name = 0,
--Type <RET> for more, q to quit, c to continue without paging--
            long_name = 0xaaaab1539f28 "create-branch", value = 0xffffd94db430,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0,
            subcommand_fn = 0xaaaab1248038 <module_create_branch>}, {
            type = OPTION_END, short_name = 0, long_name = 0x0, value = 0x0,
            precision = 0, argh = 0x0, help = 0x0, flags = 0, callback = 0x0,
            defval = 0, ll_callback = 0x0, extra = 0, subcommand_fn = 0x0}}
#15 0x0000aaaab1132314 in run_builtin (p=0xaaaab1624be8 <commands+3024>, argc=4,
    argv=0xaaaad0010ce0, repo=0xaaaab1656c98 <the_repo>) at git.c:506
        status = 0
        help = 0
        no_repo = 0
        st = {st_dev = 187650095680628, st_ino = 281474327493248,
          st_mode = 2974518388, st_nlink = 43690, st_uid = 3645750856,
st_gid = 65535,
          st_rdev = 5, __pad1 = 187650097155112, st_size = 281473779032128,
          st_blksize = -1322915768, __pad2 = 43690, st_blocks = 40, st_atim = {
            tv_sec = 281474327493280, tv_nsec = 187650091976020}, st_mtim = {
            tv_sec = 5, tv_nsec = 8}, st_ctim = {tv_sec = 281474327493408,
            tv_nsec = 187650091985032}, __glibc_reserved = {8, 0}}
        prefix = 0x0
        run_setup = 1
        __PRETTY_FUNCTION__ = "run_builtin"
#16 0x0000aaaab11328b0 in handle_builtin (args=0xffffd94dbc50) at git.c:779
        argv_copy = 0xaaaad0010ce0
        ret = 43690
        cmd = 0xaaaad00109b0 "submodule--helper"
        builtin = 0xaaaab1624be8 <commands+3024>
#17 0x0000aaaab1132bd4 in run_argv (args=0xffffd94dbc50) at git.c:862
        done_alias = 0
        expanded_aliases = {items = 0x0, nr = 0, alloc = 0, strdup_strings = 1,
          cmp = 0x0}
#18 0x0000aaaab1133074 in cmd_main (argc=4, argv=0xffffd94dbe50) at git.c:984
        was_alias = 65535
        args = {v = 0xaaaad00109d0, nr = 4, alloc = 24}
        cmd = 0xffffd94dc7ff "submodule--helper"
        done_help = 0
--Type <RET> for more, q to quit, c to continue without paging--
#19 0x0000aaaab125e86c in main (argc=5, argv=0xffffd94dbe48) at common-main.c:9
        result = 0
