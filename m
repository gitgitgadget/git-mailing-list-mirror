Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671E239E77
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 21:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753393799; cv=none; b=DERZs6b3cFuNSmkVCyGV1pw/Czggm7263A/slEdMX96UJSRLC4Rh7UwRBTQMUtASR+3Cmso/RvYq5FNQoivhMTKfp/ULEJXvVaaYuGmKsFP/RdURESxgaUeEZrfZQKFbKJriDpmvBkmRanMAsdn+0U1IxSrWLV5rFBzRN30J20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753393799; c=relaxed/simple;
	bh=6vME2te1ZwqN8SnfV0bnWYT67UywGx4u0cUWcsk2g3I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PXRsIvH/i7PaG2V2MQbyuivsbrbFrkjplh/Nv8mgama0ODlXH6MNdDJcxEDTL74eaBvpOoiiNU9JJyf2TDGCatgnpo8F5FKLapAWW7NDlsKBOKIJ2UNLI98FMOKcYwvfiDAhQQh54I9IjFrrcZuuBZZtrL7D2a6XGEtxCXLOf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j83fMqCJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j83fMqCJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3b336e936so287001766b.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753393795; x=1753998595; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uYwkam+GfuloT2mmukER6U8+Kw9DYUTUs6dYAKQE5fI=;
        b=j83fMqCJKibd0LGso22hISZWY8ryN8YvDgthJP23DYPp4dZKBbmZIEgqAL/VvsS1Qe
         +BJbU+juDyJx1TTOBuyE7daJM3nT96lyBsdM1KSU4Bd0py1dGC1cnZ4bZrPuk78I50xI
         9YgPXUXLCUl1tBIJjVJZ+BqCP3W0nopSHi3p2nEFVVNimr8SQpPyZ4biQ5iiLoF3/GGK
         y5cDoV6FzsK3SqzsAp0CPNFEJoCrigRBhFqozBk6WGj883/j8zncaj1lgUD/iOrDLdKK
         n5SJ34UU3lMi/KZ8kDGAFfoT7eTPBp5zP3u+3rSyWv+V/s7EDsQ7WlWFdm6ozcSxlO83
         SMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753393795; x=1753998595;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYwkam+GfuloT2mmukER6U8+Kw9DYUTUs6dYAKQE5fI=;
        b=K7LvowMaS/26ZHYFgvLqwewGnzyYDvR0h9910zENveYhr1ZRO8OBP8NeZsZNnwp90C
         bGQj8E1Cnhd7efrtElgW59WxwQarH92243CxZcsEhVVDpbEgvtWu/Fk7AGC+8dEab8Xc
         qKIvUGzuUtzkBGBCbXzK9MSvywyGY9CSYpUCgeOpYQLT3aeAUP/gnNYWZOGfbNjnmHUj
         pm27ldx9kzVCAPLeqIxSgushB3A1au0kD7jLyqdT6mphaKEKBKBYjQd55ByCz64D4dJj
         kfp8rTjKU0EWcKKa0kthi2VqD0YrItjByZSJctifz+So3fmelqsb2j/Tf3iQYriv4ctl
         T1Hg==
X-Gm-Message-State: AOJu0Yy36cKTM8GCVwBlnJyjzqy/kviln7VzOtsNGfRGniWrKKUmRblD
	WBM61GJvuMt7kuijDOf3xGvtd4hG58ulmaCXeNu/d4RGbIZXQUTcSmS+d0bpi7nQX/SLyuw0Ly7
	o/9XzBGmtyKEnCAI3duA2XQOw90ZPJyWQdJc1
X-Gm-Gg: ASbGncuSucTHYc60HpsnkBmGrNSTgC+b/0y152NN6CWUwyyQuE7r9Xn/QZU7QqjJK1W
	1AFjdPuXqI/GdZGSdyGeHk8ijCVRXgsLxvUJcECQyfPB8diAyNyh5Mci7UYEUlAjBa1D/vj9v7B
	vv9iElspSE5ltVYsJNjfhqc5hwf7ooBB5GKMsWqSxmROzUgZb2gWJFVKydao6QC0e54OLFYZJun
	QH/WHpKhg5WgCA4
X-Google-Smtp-Source: AGHT+IG0lc4gQmOIvaZruHZmI9vWjcJKswXQG988GsIRMVUHLnhnz6GcjlIITHP6+YpIEA6IlVLmOw9Eqxz05Rf5Aa4=
X-Received: by 2002:a17:907:3cd4:b0:ae3:70cb:45d5 with SMTP id
 a640c23a62f3a-af2f8d4d8d3mr886620066b.48.1753393794414; Thu, 24 Jul 2025
 14:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tim Cederquist <timcederquist@gmail.com>
Date: Thu, 24 Jul 2025 17:49:41 -0400
X-Gm-Features: Ac12FXxk2D4Xv_h8uAgiOlaKWG1XiGVku7wRitglW73AZfErX6PzMmF2K7ibqYI
Message-ID: <CAFb3DeA9TwRnieajpa5S88ioc=65bUWh55mvDYz3CBp-xUcB3A@mail.gmail.com>
Subject: git clone fsync error on FSx Ontap
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

What did you do before the bug happened? (Steps to reproduce your issue)
  Mounted NFS from FSx Ontap, typical home folder posix permission of
700 with inheritance. This is nfs4.2, hard mount. users home folder
has full complement of ACLs A:FD:OWNER@:rwaDxTtNnCcoy and the owner is
my account. I can write into the folders just fine, I can append,
chmod, create folders, delete, append files, etc. I can dd with fsync,
i can run install file with permissions set to 444 as indicated below
so basic IO operations similar to what git clone is doing should be
represented and are working fine.

What did you expect to happen? (Expected behavior)
  git clone https://github.com/githubtraining/hellogitworld.git
  Command should have cloned a public repository the NFS hosted home folder

What happened instead? (Actual behavior)

Cloning into 'hellogitworld'...
remote: Enumerating objects: 306, done.
remote: Counting objects: 100% (32/32), done.
remote: Compressing objects: 100% (13/13), done.
remote: Total 306 (delta 22), reused 19 (delta 19), pack-reused 274 (from 1)
Receiving objects: 100% (306/306), 95.63 KiB | 1.84 MiB/s, done.
Resolving deltas: 100% (70/70), done.
fatal: fsync error on
'/mnt/home/tcederquist/hellogitworld/.git/objects/pack/tmp_idx_gpahXY':
Permission denied
fatal: fetch-pack: invalid index-pack output

What's different between what you expected and what actually happened?
  fsync error - permission denied

Anything else you want to add:
  From Ontap storage host sectrace events command, it indicates the
failure is due to the user not having 'Append' permissions to the file
and generated the fsync error.
  Running an strace on the git clone command shows the process runs
"openat" with 444 file permission but with O_RDWR flag.
  Ontap creates the file with 444 (read only) posix permission
  git continues on to write() into the read only file - ontap rejects
it and fails the command due to read only status of the file
  I've tested with linux "instruction" command to set permission and
copy a file in a similar fashion:
    strace -f -o trace_install install -m 444 src.txt test/a/test4.txt
    This command opens the file handle 600, writes into it, and then
chmods to 444 << not using 444 to start the file as git clone is
trying to do.
  Additionally, I've added an inherited non-intrinsic permission to
the user of A:FD:tcederquist@domain:wa << this appends the required
write + append attribute and the FD means it is inherited by all files
and not overridden by posix permissions. This is not a solution but a
testable method. With this permission added, the git clone works as
expected.
  Suggestion is to use 600 on the openat/fopen for the pack index file
instead of 444. This is how 'install' sets up the file. However, I
don't know if this was an attempt at a cross platform mutex? I cannot
imagine any other reason why 444 would have been used for a file that
would have content written after opening with read only permissions.

Please review the rest of the bug report below.
You can delete any lines you don't wish to share.

[System Info]
git version 2.47.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
libcurl: 8.3.0
OpenSSL: OpenSSL 1.0.2k-fips 26 Jan 2017
zlib: 1.2.7
uname: Linux 5.10.236-228.935.amzn2.x86_64 #1 SMP Tue May 6 04:10:50
UTC 2025 x86_64
compiler info: gnuc: 7.3
libc info: glibc: 2.26
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]
not run from a git repository - no hooks to show
