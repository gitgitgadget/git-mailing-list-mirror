Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2EAC433F5
	for <git@archiver.kernel.org>; Thu,  5 May 2022 08:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbiEEI5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiEEI53 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 04:57:29 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC434A3FC
        for <git@vger.kernel.org>; Thu,  5 May 2022 01:53:49 -0700 (PDT)
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N0Zfg-1o0khi3bM4-00wRFG for <git@vger.kernel.org>; Thu, 05 May 2022 10:53:46
 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id 95C701E01E7
        for <git@vger.kernel.org>; Thu,  5 May 2022 08:53:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Lr4LHQ1RgCas for <git@vger.kernel.org>;
        Thu,  5 May 2022 10:53:46 +0200 (CEST)
Received: from pfwvexchange.corp.cetitec.com (unknown [10.10.1.40])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 1AB5D1E01E6
        for <git@vger.kernel.org>; Thu,  5 May 2022 10:53:46 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (10.8.5.23) by
 pfwvexchange.corp.cetitec.com (10.10.1.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 10:53:45 +0200
Received: by pflmari.corp.cetitec.com (Postfix, from local account)
Date:   Thu, 5 May 2022 10:53:45 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     <git@vger.kernel.org>
Subject: Crashes in t/t4058-diff-duplicates.sh
Message-ID: <YnOQmVFVRuqnanMi@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.8.5.23]
X-ClientProxiedBy: pfwvexchange.corp.cetitec.com (10.10.1.40) To
 pfwvexchange.corp.cetitec.com (10.10.1.40)
X-EsetResult: clean, is OK
X-EsetId: 37303A29E82A2D51667D67
X-Provags-ID: V03:K1:jQm+hsCKJBTm4BjHA+9CQxUMS8XuxM3ouYHzFecafJeIjbmrktl
 Djkf0goCalKLp1IOrkG1YgcSED7E0pD6kfGaHhe8GSeMy0EwlHRXZWcJg8kAFKX/vyReybC
 zzSPSOoifebRjBp9GfrjFOAG9k95FnoomKKzr7C4OtvXt/jzhyaGUS4BxlSclqltt1rPZO6
 9BlGAr9ME0auqYktG+VLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TuLzUfgLaSk=:sM0Km8Rcy4v8RCI3NzkOW2
 gz5f8AOPqsr8B58JpPK1raSh1jagyxBwf0e4Xm/NFWo9BTzdhtcI/fJ4FBg/vXgPOoNpWITUT
 J2ixQAgEup2m8cfHHseV34JG4Rt/30haUwLqf9BtwC9psuYd//TQWwE0oktyJj+5T60un29bs
 b8mv5ROb3vyGiO9x9KhqLmARPwt7p7tX89RMymNh4N1zQlMn2sGzOTUeoe/6tEvkyQjQd2F5g
 C4yfnlPXc5Bf8Ghd//VwTC+lXgkVr61nDlpEpvHBZ93jaGs5GoJVsQfjPY3SKdnnJEKiRYaMf
 wpepYAWm2iSrUBWsdcrQ0cThlkH5fK62NJFu0StOP5TWEmgW3A9zP4TQmc0rq7Y5H7Ge69NCs
 cmr4bsb5uLRXcBjChtBPE22ZHKNxrwDTfLsHB/MB/27/DI7nAdgGgpiSF250Qw2H4qYT5AnKf
 ESrLR1YrEHAxcqn4JLX9q79rc1OEimB8bNlshA6GhfdGuVsP4+e6+x3/67defQ6ES62SJ9RbO
 im08qCRDXawRGAyauHg58QQArCV3WI1KAkWPf99xuguau74QkVtlxBYBdqi1FV8hlUmswKoZQ
 aL1Yab0QPdFAxh9Pu8IvAqkpHQ+iIDgAT26i6iomyapc1EQ1rOHqbdESayTXvSkLADtw2Rek2
 ZwMjPuKd/XH8CfA+Wsj6a/vxbZEpb1WQCOKTaQdjZdeBmRyGN2WkxvL0dCiWNsQEj1h6vVpmI
 ImO5e9Mwr7OaywfO
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

the test t4058-diff-duplicates reliably dumps core here:

CORE-OF: /home/xxx/yyyyyyy/git/git

DUMPCORE_ARGS:
 9975
 9975
 11
 !home!xxx!yyyyyyy!git!git
DUMPCORE_ARGS_END

PROC-9975:
 root -> /
 cwd -> /home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates
 fd/0 -> /dev/null
 fd/1 -> /dev/pts/7
 fd/2 -> /dev/pts/7
 fd/3 -> /dev/pts/7
 fd/4 -> /dev/pts/7
 fd/5 -> /dev/pts/7
 fd/6 -> /dev/pts/7
 fd/7 -> /dev/pts/7
 fd/8 -> /home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates/.git/index.lock
PROC-9975_END

ENVIRONMENT:
GIT_COMMITTER_NAME=C O Mitter
USER=xxx
GIT_AUTHOR_EMAIL=author@example.com
GIT_TEMPLATE_DIR=/home/xxx/yyyyyyy/git/templates/blt
XDG_SEAT=seat0
TAR_OPTIONS=--atime-preserve
GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
_x05=[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]
GIT_EXEC_PATH=/home/xxx/yyyyyyy/git
SSH_AGENT_PID=3796
XDG_SESSION_TYPE=x11
GIT_CEILING_DIRECTORIES=/home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates/..
USER_HOME=/home/xxx
SHLVL=1
LESS=RSX
HOME=/home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates
OLDPWD=/home/xxx/yyyyyyy/git/t
GIT_AUTHOR_DATE=1112354055 +0200
_x35=[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]
DESKTOP_SESSION=lightdm-xsession
ZERO_OID=0000000000000000000000000000000000000000
OID_REGEX=[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]
XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0
PAGER=cat
GIT_AUTHOR_NAME=A U Thor
DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-qjoVRmyD3o,guid=8cdc53ee0598990a001ad838627364a4
u200c=‌
COLORTERM=rxvt-xpm
test_prereq=
GNOME_KEYRING_CONTROL=/run/user/1000/keyring
GIT_TEST_MERGE_ALGORITHM=ort
EMPTY_BLOB=e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
GITPERLLIB=/home/xxx/yyyyyyy/git/perl/build/lib:/home/xxx/yyyyyyy/git/perl/build/lib
LOGNAME=xxx
GIT_ATTR_NOSYSTEM=1
WINDOWID=56623113
_=./t4058-diff-duplicates.sh
GIT_TEST_CHECK_CACHE_TREE=false
XDG_SESSION_CLASS=user
COLORFGBG=15;default
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
TERM=dumb
XDG_SESSION_ID=2
COLUMNS=80
GIT_TRACE_BARE=1
USER_TERM=rxvt-unicode-256color
GIT_MERGE_VERBOSITY=5
PATH=/home/xxx/yyyyyyy/git/bin-wrappers:/home/xxx/yyyyyyy/git/bin-wrappers:/home/xxx/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
LESSCHARSET=latin1
GDM_LANG=en_US.utf8
GIT_CONFIG_NOSYSTEM=1
XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0
XDG_RUNTIME_DIR=/run/user/1000
DISPLAY=:0
GIT_DEFAULT_HASH=sha1
LANG=C
LSAN_OPTIONS=fast_unwind_on_malloc=0:strip_path_prefix=/home/xxx/yyyyyyy/git/:abort_on_error=1
GIT_TRACE2_EVENT_NESTING=100
GNUPGHOME=/home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates/gnupg-home-not-used
SHELL=/bin/bash
MALLOC_CHECK_=3
GIT_TEXTDOMAINDIR=/home/xxx/yyyyyyy/git/po/build/locale
EMPTY_TREE=4b825dc642cb6eb9a060e54bf8d69288fbee4904
MALLOC_PERTURB_=165
OSTYPE=linux-gnu
ASAN_OPTIONS=detect_leaks=0:strip_path_prefix=/home/xxx/yyyyyyy/git/:abort_on_error=1
GIT_COMMITTER_EMAIL=committer@example.com
PWD=/home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates
SHELL_PATH=/bin/sh
PERL_PATH=/usr/bin/perl
LC_ALL=C
GIT_MERGE_AUTOEDIT=no
LC_NUMERIC=C
TZ=UTC
GIT_COMMITTER_DATE=1112354055 +0200
LF=\n
MANPATH=:/home/xxx/share/man
EDITOR=:
GIT_TEST_FSYNC=0
ENVIRONMENT_END

PID_TRACE:
9975 (git) S /home/xxx/yyyyyyy/git/git merge update 
 cwd: /home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates
9653 (t4058-diff-dupl) S /bin/sh ./t4058-diff-duplicates.sh -d -v -i 
 cwd: /home/xxx/yyyyyyy/git/t/trash directory.t4058-diff-duplicates
4932 (bash) S bash 
 cwd: /home/xxx/yyyyyyy/git/t
4924 (urxvt) S urxvt 
 cwd: /home/xxx
1 (init) S init [2]   
 cwd: /
PID_TRACE_END

GDB:
Reading symbols from /home/xxx/yyyyyyy/git/git...
[New LWP 9975]
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
Core was generated by `/home/xxx/yyyyyyy/git/git merge update'.
Program terminated with signal SIGSEGV, Segmentation fault.
#0  0x00005629e52f4a00 in traverse_by_cache_tree (info=0x7fff27e7dba8, 
    info=0x7fff27e7dba8, nr_names=2, nr_entries=4, pos=0)
    at unpack-trees.c:807
807			len = ce_namelen(src[0]);
Threads:
  Id   Target Id                        Frame 
* 1    Thread 0x7f408feb8740 (LWP 9975) 0x00005629e52f4a00 in traverse_by_cache_tree (info=0x7fff27e7dba8, info=0x7fff27e7dba8, nr_names=2, nr_entries=4, pos=0) at unpack-trees.c:807
Stack:
new_ce_len = <optimized out>
len = <optimized out>
rc = <optimized out>
o = 0x7fff27e7e930
tree_ce = 0x5629e596e7d0
ce_len = 240
i = 1
src = {0x5629e594a518, 0x5629e596e7d0, 0x5629e596e7d0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0}
d = <optimized out>
src = {<optimized out>, <optimized out>, <optimized out>, <optimized out>, <optimized out>, <optimized out>, <optimized out>, <optimized out>, <optimized out>}
o = <optimized out>
tree_ce = <optimized out>
ce_len = <optimized out>
i = <optimized out>
d = <optimized out>
new_ce_len = <optimized out>
len = <optimized out>
rc = <optimized out>
#0  0x00005629e52f4a00 in traverse_by_cache_tree (info=0x7fff27e7dba8, info=0x7fff27e7dba8, nr_names=2, nr_entries=4, pos=0) at unpack-trees.c:807
#1  traverse_trees_recursive (n=n@entry=2, dirmask=dirmask@entry=3, df_conflicts=df_conflicts@entry=0, names=names@entry=0x7fff27e7df80, info=info@entry=0x7fff27e7e420) at unpack-trees.c:872
#2  0x00005629e52f5668 in unpack_callback (n=<optimized out>, mask=3, dirmask=3, names=0x7fff27e7df80, info=<optimized out>) at unpack-trees.c:1479
#3  0x00005629e52f3162 in traverse_trees (istate=0x5629e541c980 <the_index>, n=n@entry=2, t=t@entry=0x7fff27e7e6f0, info=info@entry=0x7fff27e7e420) at tree-walk.c:532
#4  0x00005629e52f82fa in unpack_trees (len=len@entry=2, t=t@entry=0x7fff27e7e6f0, o=o@entry=0x7fff27e7e930) at unpack-trees.c:1882
#5  0x00005629e523d2ae in checkout_fast_forward (r=0x5629e541caa0 <the_repo>, head=head@entry=0x5629e594be24, remote=remote@entry=0x5629e594be6c, overwrite_ignore=1) at merge.c:94
#6  0x00005629e5135742 in cmd_merge (argc=<optimized out>, argv=<optimized out>, prefix=<optimized out>) at builtin/merge.c:1578
#7  0x00005629e50c921b in run_builtin (argv=0x7fff27e7f9c0, argc=2, p=0x5629e53ead48 <commands+1608>) at git.c:465
#8  handle_builtin (argc=2, argv=0x7fff27e7f9c0) at git.c:719
#9  0x00005629e50ca53d in run_argv (argv=0x7fff27e7f700, argcp=0x7fff27e7f70c) at git.c:786
#10 cmd_main (argc=<optimized out>, argc@entry=3, argv=<optimized out>, argv@entry=0x7fff27e7f9b8) at git.c:917
#11 0x00005629e50c8f03 in main (argc=3, argv=0x7fff27e7f9b8) at common-main.c:56
GDB_END

end

P.S. dumpcore (the tool which produced this trace) is this: https://github.com/raalkml/dumpcore
