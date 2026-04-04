Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92801224B05
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 10:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775299180; cv=pass; b=L+aiI/nBsVCq/LWVoL504aaqCDJ+XYzIXOQHw1C9bmCvO6RnftOcp9g7xELSIXhFU7DvewMPslN0FmxV373MHoUdJdy9Vbc/7WUOz7MGvO1WymmX80gtWS+Fxip9wKC8n3Q9TCMjCrbajnF6LlbK/loPjkcfoTPOcBrvWvDQsMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775299180; c=relaxed/simple;
	bh=QtXxxtqWTUwl2DTwVycZI1Kzj2ArFr+q3lzmsf9Z8iE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=NmCrxq1NFgzPVMVWfL1LDU/Re3p/cfU1ykWZRotZ5tcPcqvffJy+TiHpmv7ACbklFj5dhxc4RPkr/I/eztTPgWHcGZZ3zMsI2VUgiDYmFVMve/9pIaS4f/1AJf9gppr8V68nQAx7bSdIiLR/9tfRUUhENea8XC+eh+oXe301m7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOzEwjEr; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOzEwjEr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b258576d8cso16340075ad.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 03:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775299178; cv=none;
        d=google.com; s=arc-20240605;
        b=KIbfDEmldJNBaOzFQiqrdo0eIR5mAe0Smj1Wcf+sbWyy81XMkmJcwggaON6l5SVNMC
         kRUU7yx4+DJJ1fwuSjmmI6n2gJkL0EmrPWxsjQ2nJCb1vJd9VhcNClB6w4EiZLNXNbpQ
         XjKkwZUV6Cn6cRn8vsFVVszas8k6dFuv9TnpbzfZKs9H1t7oEpc88Bd/QeM5pfqbYU/+
         AV1nemAbpO6ahW41UjnXG/Ip5xvCgZhDzVTxYM6MWSIXAT3D5kW7OsoHQuGMA3zpiTJg
         mc49t4wv7owMfNLngIPgQvA7pGq98FX/x+ocSELy+7J98jMGPN24hi7IaRDhuKAjdpAh
         9gCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nVcqBHi6VwInOQCYsUwB5ztQabClgTqwDktm1lNCPYE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=CGUftokq3/v1OgpMxCsc4QMFa8wXndGDgBAdblJXU8v54CqZRBTcTDfy05bKd63e0J
         djTxsssYWZdlBjxvNLoowQP8BcVWWk7mJBe5FEU0dQNG7guJfNR+RdYnkHJPGhPBCChL
         JmfUDswICMt4sJ2Ky/7sIXFKwMQ9g9D+c+kSCCd2cGh9xlWXWa+uYc1+jRs/Qjaopvyj
         7V7Wvw5srOZLXD8DyzNVQ/jp0NgsD3vjXcfnBlFRkeNRz2LIXwEFwcphWfqDZdTHjIO8
         LC3AnshWZb4aPbDCJysd1vYjyxoVKUQQrhkN9a2ifMU2RA6/bSAX/hBex8x5F37D8diS
         M8zA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775299178; x=1775903978; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nVcqBHi6VwInOQCYsUwB5ztQabClgTqwDktm1lNCPYE=;
        b=gOzEwjErJCGp9WF6pcqqSYM+0vI3OpVih/7tXEyTfA5V/vUIjeHzMN+NFOlFqgeriM
         18GDE0BVlU1XuhP1puQeeliAtorlKf1eMTEaN70G8C54ODDxA6O0oBdTOoGCMFfRBpwG
         5rdC632yVvQ/Bxwn9NVvKSV72cthDNjXeMWB16YYv51yTB38PbQs+7eJqmHXwl42hI4v
         tOAYqEyuS1hd4J+H1mD4/xBBjYTuIQjIjvAHNU8wB+eYwmlbEM/5KRufkruNbZo8aPOg
         FHGwJ3NHcy0jFPIEJ84uhe3BT7uRAewUS86e8yMW8coQvG/aSYWRi52Vh353hQaTTPNz
         aMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775299178; x=1775903978;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVcqBHi6VwInOQCYsUwB5ztQabClgTqwDktm1lNCPYE=;
        b=jxs7vpXKLeD/1Uqv4VKXhYHFgJZDBUY9hEM0VSffH8D7Ebo42eVET8IeXy11GUhd/m
         iYOwcJ2vhGjnlpseWCx/Kn0iZRJ+5fCvJ2+riFq1Qy0m1jP7HspC/U5huJgX0q5AAH8o
         /I/ydQpvNqQKjaBoirkH8z/5Fac7v/cXgYI8wBc9fmunB/xlTW1JkvqnYiZc93VOq+Oh
         2N4pxtnY+U+qNqBklWuRbpeLz9o+cxHR02Lv39gQFVMG/WOAG8i9pTXd1GSIh8iEXvwz
         uV9jGhqodIbPXzymd9vrKNqhDYxkrDo+ZtBjAo9dO9NRYuXdj+Z23MYkIOOY7L8H4XAs
         4peg==
X-Gm-Message-State: AOJu0YxW59IaBsyN0/tLeUrgygMglb4S/PHi0wiA2sdPFk/HsDWCwffm
	HQSS3UA0hwciAAjdh8sGGvnOS0M/7HftYBa/msboLulBDagSYilfZZMX3VizM5JyXo0DBB9H9hk
	tQW3HtXcB+gtdmc0fYqX+g3MXb8JNEGEDvawmZZM=
X-Gm-Gg: AeBDievtTD8LvjW6uMNwoA95AxE96iDRnSQR8Udy5k/bSlZCWaNg1G4POEpf2FkIGNy
	2NdsP/+nc7Q7W2aDjl0RxZIpkDdEt7Y8qoWAFkDsfFOtLxcpA7QIjlg91b8l494q+Mb8D+MfXEm
	BLQ+nlp2SmczlsL0KTWHPgx04sn2ItrsEkouOFCDpB0PswYV7hTRzceZnC/VIJZxYyxvM+OXWHi
	mH1K8xoGjpsM040ijvrDH3V2N6sDQG7XI+/bgE0PjjyFuU2bxj0JM0q52kzjEdOH1x1R9e5nRDJ
	WBSW
X-Received: by 2002:a17:902:f60f:b0:2b0:917c:bc4 with SMTP id
 d9443c01a7336-2b2817d94c3mr63468525ad.4.1775299178472; Sat, 04 Apr 2026
 03:39:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luca Stefani <luca.stefani.ge1@gmail.com>
Date: Sat, 4 Apr 2026 12:39:27 +0200
X-Gm-Features: AQROBzBAoNDbMs-BRjIp_pMJmaCmHk5EgsqEOJZf3mLCV7v4gCSmJY3aIJvFn7k
Message-ID: <CAO0HQ0X_pQmew5tJReOL=u+CMxCjAQynx8JfjykoYAUE59YNzw@mail.gmail.com>
Subject: [BUG] git diff --no-index segfaults on large files (NULL object database)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

`git diff --color -- file1 file2` SIGSEGV in case file1 and file2
are "big enough", that is when the file size is bigger than
repo_settings_get_big_file_threshold()

What did you expect to happen? (Expected behavior)

Not a crash, it to say "binary files are different"

What happened instead? (Actual behavior)

Program received signal SIGSEGV, Segmentation fault.
index_fd (istate=istate@entry=0x5555559ccb40,
oid=oid@entry=0x5555559d3c80, fd=4, st=st@entry=0x7fffffffc5c0,
type=type@entry=OBJ_BLOB, path=path@entry=0x5555559d3ce0
"4/root_part", flags=0) at /usr/src/debug/git/git/object-file.c:1634
1634                    transaction =
odb_transaction_begin(the_repository->objects);
(gdb) bt
#0  index_fd (istate=istate@entry=0x5555559ccb40,
oid=oid@entry=0x5555559d3c80, fd=4, st=st@entry=0x7fffffffc5c0,
type=type@entry=OBJ_BLOB, path=path@entry=0x5555559d3ce0
"4/root_part", flags=0)
   at /usr/src/debug/git/git/object-file.c:1634
#1  0x000055555579ab75 in index_path (istate=0x5555559ccb40,
oid=0x5555559d3c80, path=0x5555559d3ce0 "4/root_part",
st=0x7fffffffc5c0, flags=0) at
/usr/src/debug/git/git/object-file.c:1658
#2  0x0000555555720f83 in diff_fill_oid_info (one=0x5555559d3c80,
istate=0x5555559ccb40) at /usr/src/debug/git/git/diff.c:4690
#3  diff_fill_oid_info (one=one@entry=0x5555559d3c80,
istate=0x5555559ccb40) at /usr/src/debug/git/git/diff.c:4679
#4  0x0000555555724aba in run_diff (p=0x5555559ce900,
o=0x7fffffffd188) at /usr/src/debug/git/git/diff.c:4738
#5  diff_flush_patch (p=0x5555559ce900, o=0x7fffffffd188) at
/usr/src/debug/git/git/diff.c:6247
#6  0x0000555555729850 in diff_flush_patch_all_file_pairs
(o=0x7fffffffd188) at /usr/src/debug/git/git/diff.c:6802
#7  diff_flush (options=<optimized out>) at /usr/src/debug/git/git/diff.c:6942
#8  0x00005555555b0d34 in diff_no_index (revs=0x7fffffffcbd0,
algop=0x55555598dbd0 <hash_algos+112>, implicit_no_index=<optimized
out>, argc=2, argv=0x5555559ce2a0) at
/usr/src/debug/git/git/diff-no-index.c:427
#9  cmd_diff (argc=<optimized out>, argv=0x5555559ce2a0,
prefix=<optimized out>, repo=<optimized out>) at builtin/diff.c:516
#10 0x000055555555fe05 in run_builtin (p=0x555555994ec8
<commands.lto_priv+840>, argc=<optimized out>, argv=<optimized out>,
repo=0x5555559a3c00 <the_repo.lto_priv>) at
/usr/src/debug/git/git/git.c:506
#11 handle_builtin (args=args@entry=0x7fffffffd980) at
/usr/src/debug/git/git/git.c:779
#12 0x00005555555612cc in run_argv (args=0x7fffffffd980) at
/usr/src/debug/git/git/git.c:862
#13 cmd_main (argc=<optimized out>, argv=<optimized out>) at
/usr/src/debug/git/git/git.c:984
#14 0x000055555555d794 in main (argc=6, argv=0x7fffffffdc58) at
/usr/src/debug/git/git/common-main.c:9
(gdb) p the_repository->objects
$1 = (struct object_database *) 0x0
(gdb) p istate->repo->objects
$2 = (struct object_database *) 0x0
(gdb) p istate->repo
$3 = (struct repository *) 0x5555559a3c00 <the_repo.lto_priv>
(gdb) p the_repository
$4 = (struct repository *) 0x5555559a3c00 <the_repo.lto_priv>

The same issue happens in master, the same path is taken and when we
finally get into
`odb_transaction_begin` where odb is NULL, and reading ->transaction
causes the illegal
segment access once again.

Program received signal SIGSEGV, Segmentation fault.
0x00005555557c6283 in odb_transaction_begin (odb=0x0) at odb.c:1075
1075            if (odb->transaction)
(gdb) bt
#0  0x00005555557c6283 in odb_transaction_begin (odb=0x0) at odb.c:1075
#1  0x00005555557b94f9 in index_fd (istate=0x555555a88b60,
oid=0x555555a8fcb0, fd=4, st=0x7fffffffc730, type=OBJ_BLOB,
path=0x555555a8fd10 "4/root_part", flags=0) at object-file.c:1665
#2  0x00005555557b9651 in index_path (istate=0x555555a88b60,
oid=0x555555a8fcb0, path=0x555555a8fd10 "4/root_part",
st=0x7fffffffc730, flags=0) at object-file.c:1691
#3  0x0000555555730937 in diff_fill_oid_info (one=0x555555a8fcb0,
istate=0x555555a88b60) at diff.c:4699
#4  0x0000555555730b81 in run_diff (p=0x555555a8a9a0,
o=0x7fffffffd1a8) at diff.c:4747
#5  0x00005555557361d5 in diff_flush_patch (p=0x555555a8a9a0,
o=0x7fffffffd1a8) at diff.c:6258
#6  0x0000555555737cae in diff_flush_patch_all_file_pairs
(o=0x7fffffffd1a8) at diff.c:6813
#7  0x00005555557382b2 in diff_flush (options=0x7fffffffd1a8) at diff.c:6953
#8  0x00005555557228cc in diff_no_index (revs=0x7fffffffcbf0,
algop=0x555555a49b50 <hash_algos+112>, implicit_no_index=1, argc=2,
argv=0x555555a8a2f0) at diff-no-index.c:427
#9  0x00005555555c04b1 in cmd_diff (argc=5, argv=0x555555a8a2f0,
prefix=0x0, repo=0x0) at builtin/diff.c:516
#10 0x0000555555574f47 in run_builtin (p=0x555555a4aaa8
<commands+840>, argc=5, argv=0x555555a8a2f0, repo=0x555555a7e620
<the_repo>) at git.c:506
#11 0x000055555557544e in handle_builtin (args=0x7fffffffdab0) at git.c:780
#12 0x0000555555575778 in run_argv (args=0x7fffffffdab0) at git.c:863
#13 0x0000555555575c0f in cmd_main (argc=5, argv=0x7fffffffdc50) at git.c:984
#14 0x00005555556a7414 in main (argc=6, argv=0x7fffffffdc48) at common-main.c:9

What's different between what you expected and what actually happened?

Anything else you want to add:

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.


[System Info]
git version:
git version 2.53.0
cpu: x86_64
built from commit: 67ad42147a7acc2af6074753ebd03d904476118f
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: enabled
gettext: enabled
libcurl: 8.18.0
OpenSSL: OpenSSL 3.6.1 27 Jan 2026
zlib-ng: 2.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.19.9-arch1-1 #1 SMP PREEMPT_DYNAMIC Thu, 19 Mar 2026
16:33:17 +0000 x86_64
compiler info: gnuc: 15.2
libc info: glibc: 2.43
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
not run from a git repository - no hooks to show
