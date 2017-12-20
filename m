Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611061F404
	for <e@80x24.org>; Wed, 20 Dec 2017 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755951AbdLTSdb (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 13:33:31 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35829 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755292AbdLTSdY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 13:33:24 -0500
Received: by mail-pl0-f68.google.com with SMTP id b96so9494865pli.2
        for <git@vger.kernel.org>; Wed, 20 Dec 2017 10:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=PX2ti6W5yORWQoIejY5nV7BHRZe9uCWh/qP4X5ne+eU=;
        b=iaVBe634BiAqX/3SiB8q3ASrSBDqv9NGWXo7nagEuQ7NpofPNuUexh1WRDuURjae1x
         wLIBFR3R7JlyhTo/pNPdhuphOgR+Qw0kGOU8SA1YYMMvzWKMRUQz4sfSBdPqb5XgkaLt
         QZjsmigLkmPFOgrvArSZw1dQQDQGvLJZZAdbKd050Z32b3AKJ+KwXt3Bo6IplWbeQuh9
         S7ajS+4LmvrT42hRww7j7Xcw25AqxBDukUGPnyMVKv+mrGVXgOUk8bknDLnzW4uJNosI
         kwWrXNNrSf/HHvJ2xZFNXQ2Bdr0tPennOLQnJvlPjXgSIuBuB+yHh0FEFMlkW8mczeWJ
         l0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=PX2ti6W5yORWQoIejY5nV7BHRZe9uCWh/qP4X5ne+eU=;
        b=LW78Tz8Gf9qc+trOiIdSLv7HyZ5o/xzvtRYfC8wq5CPYo9etPto89jqugXvK4tKcpg
         ou0UNzM2Rt5ZrUV7PKv4O3lkknIGpXwTrsH9aFrNpiOKQ83cXBX49LBoy5JzP8WLqztR
         vXg8i2VQau/h5YyrgYmeADLPv0X7Da8542OiGgW+DOwlPkiEIaoMKgjF69xjTp7WgGcV
         z3pJozQpagVBtf9x4NzVOkQnH8BOczDS8Cjpb5T5DEnFchb1BTnbn6hSLMjSapjjiwd0
         1TCLtmZ/9m/ftYlSx4c8IruIYcB5pJkQ9JsBwzYDMGxmyygunXlfDAMLg/+aktvvRhcQ
         DylQ==
X-Gm-Message-State: AKGB3mJzQehwBKJz51IlYCYWtu+W94yv5d9MZoVPe+0eGbmRdiN+Jr5U
        zjif5SARkIiivLREFV/JqZ4QpNM9
X-Google-Smtp-Source: ACJfBov2YoZD8rLByZtwzGDJAyPeHtpmkzJ8eXJX8JSlw++8sU8139AEEO+Lx4aq+jni/M8shj+iVg==
X-Received: by 10.159.242.196 with SMTP id x4mr7890700plw.342.1513794803491;
        Wed, 20 Dec 2017 10:33:23 -0800 (PST)
Received: from unique-pc ([14.102.72.147])
        by smtp.gmail.com with ESMTPSA id e9sm37496517pfl.138.2017.12.20.10.33.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Dec 2017 10:33:22 -0800 (PST)
Message-ID: <1513794792.9785.2.camel@gmail.com>
Subject: Error in `git': free(): invalid pointer (was Re: [PATCH]
 sequencer: improve config handling)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
In-Reply-To: <20171213114621.30250-1-phillip.wood@talktalk.net>
References: <xmqq8te84yo6.fsf@gitster.mtv.corp.google.com>
         <20171213114621.30250-1-phillip.wood@talktalk.net>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Thu, 21 Dec 2017 00:03:12 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently encountered that error when trying to do an interactive
rebase after using filter-branch to remove a file completely in a
repository. I bisected this issue which pointed at this patch. I'm not
sure how it is related as I'm not too familiar with the sequencer code.
I could help in case any specific information is needed. As a first
step, I've posted the output of "strace /mnt/Source//Git/git rebase -i
HEAD~10" below.


-- 8< --
execve("/mnt/Source//Git/git-next/git", ["/mnt/Source//Git/git-next/git", "rebase", "-i", "HEAD~10"], [/* 62 vars */]) = 0
brk(NULL)                               = 0x55a494d30000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f25bd940000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=114620, ...}) = 0
mmap(NULL, 114620, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f25bd924000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\300!\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=105088, ...}) = 0
mmap(NULL, 2200072, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f25bd506000
mprotect(0x7f25bd51f000, 2093056, PROT_NONE) = 0
mmap(0x7f25bd71e000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x18000) = 0x7f25bd71e000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0Pa\0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=135440, ...}) = 0
mmap(NULL, 2212936, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f25bd2e9000
mprotect(0x7f25bd301000, 2093056, PROT_NONE) = 0
mmap(0x7f25bd500000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x17000) = 0x7f25bd500000
mmap(0x7f25bd502000, 13384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f25bd502000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/librt.so.1", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\340 \0\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0644, st_size=31744, ...}) = 0
mmap(NULL, 2128832, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f25bd0e1000
mprotect(0x7f25bd0e8000, 2093056, PROT_NONE) = 0
mmap(0x7f25bd2e7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x6000) = 0x7f25bd2e7000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\4\2\0\0\0\0\0"..., 832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=1689360, ...}) = 0
mmap(NULL, 3795296, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x7f25bcd42000
mprotect(0x7f25bced7000, 2097152, PROT_NONE) = 0
mmap(0x7f25bd0d7000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x195000) = 0x7f25bd0d7000
mmap(0x7f25bd0dd000, 14688, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f25bd0dd000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f25bd922000
arch_prctl(ARCH_SET_FS, 0x7f25bd922e80) = 0
mprotect(0x7f25bd0d7000, 16384, PROT_READ) = 0
mprotect(0x7f25bd500000, 4096, PROT_READ) = 0
mprotect(0x7f25bd2e7000, 4096, PROT_READ) = 0
mprotect(0x7f25bd71e000, 4096, PROT_READ) = 0
mprotect(0x55a49424b000, 12288, PROT_READ) = 0
mprotect(0x7f25bd943000, 4096, PROT_READ) = 0
munmap(0x7f25bd924000, 114620)          = 0
set_tid_address(0x7f25bd923150)         = 9667
set_robust_list(0x7f25bd923160, 24)     = 0
rt_sigaction(SIGRTMIN, {sa_handler=0x7f25bd2eebd0, sa_mask=[], sa_flags=SA_RESTORER|SA_SIGINFO, sa_restorer=0x7f25bd2fa0c0}, NULL, 8) = 0
rt_sigaction(SIGRT_1, {sa_handler=0x7f25bd2eec60, sa_mask=[], sa_flags=SA_RESTORER|SA_RESTART|SA_SIGINFO, sa_restorer=0x7f25bd2fa0c0}, NULL, 8) = 0
rt_sigprocmask(SIG_UNBLOCK, [RTMIN RT_1], NULL, 8) = 0
getrlimit(RLIMIT_STACK, {rlim_cur=8192*1024, rlim_max=RLIM64_INFINITY}) = 0
open("/dev/null", O_RDWR)               = 3
close(3)                                = 0
rt_sigprocmask(SIG_UNBLOCK, [PIPE], NULL, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=SIG_DFL, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
brk(NULL)                               = 0x55a494d30000
brk(0x55a494d51000)                     = 0x55a494d51000
getcwd("/mnt/Source/bash/lxconf-bash", 129) = 29
stat("/mnt/Source/bash/lxconf-bash", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat("/mnt/Source/bash/lxconf-bash/.git", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
lstat("/mnt/Source/bash/lxconf-bash/.git/HEAD", {st_mode=S_IFREG|0644, st_size=23, ...}) = 0
open("/mnt/Source/bash/lxconf-bash/.git/HEAD", O_RDONLY) = 3
read(3, "ref: refs/heads/public\n", 255) = 23
read(3, "", 232)                        = 0
close(3)                                = 0
lstat("/mnt/Source/bash/lxconf-bash/.git/commondir", 0x7ffcd3d12100) = -1 ENOENT (No such file or directory)
access("/mnt/Source/bash/lxconf-bash/.git/objects", X_OK) = 0
access("/mnt/Source/bash/lxconf-bash/.git/refs", X_OK) = 0
lstat(".git/commondir", 0x7ffcd3d12270) = -1 ENOENT (No such file or directory)
open(".git/config", O_RDONLY)           = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=738, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=738, ...}) = 0
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 738
read(3, "", 4096)                       = 0
close(3)                                = 0
access("/home/unique/.local/etc/gitconfig", R_OK) = -1 ENOENT (No such file or directory)
access("/home/unique/.config/git/config", R_OK) = -1 ENOENT (No such file or directory)
access("/home/unique/.gitconfig", R_OK) = 0
open("/home/unique/.gitconfig", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=866, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=866, ...}) = 0
read(3, "[user]\n\temail = kaartic.sivaraam"..., 4096) = 866
read(3, "", 4096)                       = 0
close(3)                                = 0
access(".git/config", R_OK)             = 0
open(".git/config", O_RDONLY)           = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=738, ...}) = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=738, ...}) = 0
read(3, "[core]\n\trepositoryformatversion "..., 4096) = 738
read(3, "", 4096)                       = 0
close(3)                                = 0
pipe([3, 4])                            = 0
stat("/home/unique/.local/libexec/git-core/git-rebase", {st_mode=S_IFREG|0755, st_size=16486, ...}) = 0
rt_sigprocmask(SIG_SETMASK, ~[RTMIN RT_1], [], 8) = 0
clone(child_stack=NULL, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0x7f25bd923150) = 9668
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {sa_handler=0x55a493f78a70, sa_mask=[INT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGHUP, {sa_handler=0x55a493f78a70, sa_mask=[HUP], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGTERM, {sa_handler=0x55a493f78a70, sa_mask=[TERM], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGQUIT, {sa_handler=0x55a493f78a70, sa_mask=[QUIT], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, {sa_handler=SIG_DFL, sa_mask=[], sa_flags=0}, 8) = 0
rt_sigaction(SIGPIPE, {sa_handler=0x55a493f78a70, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, {sa_handler=SIG_DFL, sa_mask=[PIPE], sa_flags=SA_RESTORER|SA_RESTART, sa_restorer=0x7f25bcd75060}, 8) = 0
close(4)                                = 0
read(3, "", 8)                          = 0
close(3)                                = 0
wait4(9668, *** Error in `git': free(): invalid pointer: 0x0000557bf5cdf98a ***
======= Backtrace: =========
/lib/x86_64-linux-gnu/libc.so.6(+0x70bfb)[0x7fcb647d1bfb]
/lib/x86_64-linux-gnu/libc.so.6(+0x76fc6)[0x7fcb647d7fc6]
/lib/x86_64-linux-gnu/libc.so.6(+0x7780e)[0x7fcb647d880e]
git(+0x1463f9)[0x557bf5c853f9]
git(+0x6b5dd)[0x557bf5baa5dd]
git(+0x13848)[0x557bf5b52848]
git(+0x13b06)[0x557bf5b52b06]
git(+0x12c0c)[0x557bf5b51c0c]
/lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xf1)[0x7fcb647812e1]
git(+0x12c4a)[0x557bf5b51c4a]
======= Memory map: ========
557bf5b3f000-557bf5d4e000 r-xp 00000000 08:09 1178454                    /home/unique/.local/libexec/git-core/git
557bf5f4d000-557bf5f50000 r--p 0020e000 08:09 1178454                    /home/unique/.local/libexec/git-core/git
557bf5f50000-557bf5f5c000 rw-p 00211000 08:09 1178454                    /home/unique/.local/libexec/git-core/git
557bf5f5c000-557bf5f9f000 rw-p 00000000 00:00 0 
557bf7917000-557bf795d000 rw-p 00000000 00:00 0                          [heap]
7fcb60000000-7fcb60021000 rw-p 00000000 00:00 0 
7fcb60021000-7fcb64000000 ---p 00000000 00:00 0 
7fcb6454a000-7fcb64560000 r-xp 00000000 08:0b 263716                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7fcb64560000-7fcb6475f000 ---p 00016000 08:0b 263716                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7fcb6475f000-7fcb64760000 r--p 00015000 08:0b 263716                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7fcb64760000-7fcb64761000 rw-p 00016000 08:0b 263716                     /lib/x86_64-linux-gnu/libgcc_s.so.1
7fcb64761000-7fcb648f6000 r-xp 00000000 08:0b 268114                     /lib/x86_64-linux-gnu/libc-2.24.so
7fcb648f6000-7fcb64af6000 ---p 00195000 08:0b 268114                     /lib/x86_64-linux-gnu/libc-2.24.so
7fcb64af6000-7fcb64afa000 r--p 00195000 08:0b 268114                     /lib/x86_64-linux-gnu/libc-2.24.so
7fcb64afa000-7fcb64afc000 rw-p 00199000 08:0b 268114                     /lib/x86_64-linux-gnu/libc-2.24.so
7fcb64afc000-7fcb64b00000 rw-p 00000000 00:00 0 
7fcb64b00000-7fcb64b07000 r-xp 00000000 08:0b 268132                     /lib/x86_64-linux-gnu/librt-2.24.so
7fcb64b07000-7fcb64d06000 ---p 00007000 08:0b 268132                     /lib/x86_64-linux-gnu/librt-2.24.so
7fcb64d06000-7fcb64d07000 r--p 00006000 08:0b 268132                     /lib/x86_64-linux-gnu/librt-2.24.so
7fcb64d07000-7fcb64d08000 rw-p 00007000 08:0b 268132                     /lib/x86_64-linux-gnu/librt-2.24.so
7fcb64d08000-7fcb64d20000 r-xp 00000000 08:0b 268130                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7fcb64d20000-7fcb64f1f000 ---p 00018000 08:0b 268130                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7fcb64f1f000-7fcb64f20000 r--p 00017000 08:0b 268130                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7fcb64f20000-7fcb64f21000 rw-p 00018000 08:0b 268130                     /lib/x86_64-linux-gnu/libpthread-2.24.so
7fcb64f21000-7fcb64f25000 rw-p 00000000 00:00 0 
7fcb64f25000-7fcb64f3e000 r-xp 00000000 08:0b 263835                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7fcb64f3e000-7fcb6513d000 ---p 00019000 08:0b 263835                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7fcb6513d000-7fcb6513e000 r--p 00018000 08:0b 263835                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7fcb6513e000-7fcb6513f000 rw-p 00019000 08:0b 263835                     /lib/x86_64-linux-gnu/libz.so.1.2.8
7fcb6513f000-7fcb65162000 r-xp 00000000 08:0b 263494                     /lib/x86_64-linux-gnu/ld-2.24.so
7fcb652c1000-7fcb65343000 rw-p 00000000 00:00 0 
7fcb6535d000-7fcb6535e000 rw-p 00000000 00:00 0 
7fcb6535e000-7fcb6535f000 r--p 00000000 08:06 57439                      /mnt/Source/bash/lxconf-bash/.git/packed-refs
7fcb6535f000-7fcb65362000 rw-p 00000000 00:00 0 
7fcb65362000-7fcb65363000 r--p 00023000 08:0b 263494                     /lib/x86_64-linux-gnu/ld-2.24.so
7fcb65363000-7fcb65364000 rw-p 00024000 08:0b 263494                     /lib/x86_64-linux-gnu/ld-2.24.so
7fcb65364000-7fcb65365000 rw-p 00000000 00:00 0 
7ffdf94a1000-7ffdf94c2000 rw-p 00000000 00:00 0                          [stack]
7ffdf95cf000-7ffdf95d1000 r--p 00000000 00:00 0                          [vvar]
7ffdf95d1000-7ffdf95d3000 r-xp 00000000 00:00 0                          [vdso]
ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0                  [vsyscall]
[{WIFSIGNALED(s) && WTERMSIG(s) == SIGABRT}], 0, NULL) = 9668
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_KILLED, si_pid=9668, si_uid=1000, si_status=SIGABRT, si_utime=0, si_stime=1} ---
write(2, "error: git-rebase died of signal"..., 35error: git-rebase died of signal 6
) = 35
exit_group(134)                         = ?
+++ exited with 134 +++
