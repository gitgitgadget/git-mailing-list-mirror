Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF1344DAD
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 15:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353968; cv=pass; b=BGmnr5bTB00KO3xvgNlEGbC7XC4+/7z0gkljQwg1LLb3iz27M1z5ef9IisIEhKgRU3inK6ANNYDk7gv7/z5xl3l0aESo8FxxrhK6Up7FMFZmM+9wOLVCNFJgeQdmqz8fVisg94xCklXWO4cADktRqHG4+RG07rinHfgGXXfaQK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353968; c=relaxed/simple;
	bh=E0IRCYLXKF9COpb50jDsCDJGk6z9O8Htb4yapkfx3zw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EKCVTtkewIYl/2bdHCcXPkDIC7cpm0ybdiyDp9iABObC3O7JZMPPMJPdHxbVg12aTsl99odY+OWDJgKfGtEGS0KJuI1exNgcX8BTAXpEqx77dFS7Mvtbrba/NT5ahQPEEgQ8U4qVlgZXCg5+keM0lip8ifrLgU0M5CzeomRjyGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=cnmfWFfO; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="cnmfWFfO"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so13689266a12.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 08:39:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776353962; cv=none;
        d=google.com; s=arc-20240605;
        b=R0PQ4+gpdfsS6QHpEcGJeIJl6ya5Z/4VWcD1yEu7kuVJDFGmTkGNA/9p2Qbc8yc+yX
         7wGMKTDX2U500UyX/H0lGIcUpnPoQ3/KkWdiZeacXvW1YtPLHo1G6zDYQMzvhGxAd4jb
         uIFXpnI7TYcswRGH6d9ul5mDY5pQ35UCELyli5t4GWKPvqMzDLx0qmx7SnkZuvvZnCE5
         2tXcZO2qYE2nXPpWNGC79wNulCqjR+MbgSnXPSRZSVPcdGdU8ghsQxVGk4tPw3MmdZBz
         gnlDcVJVmZZKWdB3eRZHJpxl6hXVbGaKfN+4ICWpUn0ZHYpBRS8vNKxcLOK4gHcBjumM
         LlMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ly8ZF0cLC98sd5Q4ROI4wD3mgO8d3lzf4Xtu02X0u1k=;
        fh=z8UfAuIQ3Iqm5xia8RYFh9CmhBCWvwPFK0uvY0mJYeU=;
        b=F6pm85L9DGqBM56XTpZM3Tpx26u+2sWlKKqTnxSGzS3SXs9C8CnbNcJFSo4ANROw3W
         NRwmF8Cy562PxIepVtP0Qj+yCQoqla/I3CrZ82Zr6dBVW4Vjm6YEMDq0kmou91jVqWan
         118EwbiUmqeJkNi+Th//3hZEAw12v8Sl4a8aJu7hKblTkA9qOF7F+87qSF+AzKjZf6ND
         GhIuyyzZl4iV43ppyeKxVMAu6E7PUSUMx+H0KpFaG4ykMYHpV5a7rtkDfYWe3vBjNfLl
         8o1KdvmaEAWIzPnj1JI5Kba+bzmKkOLe5La7tAVn62+1HeSM+xGv7EfBKa57VYs/PFMC
         EtKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1776353962; x=1776958762; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ly8ZF0cLC98sd5Q4ROI4wD3mgO8d3lzf4Xtu02X0u1k=;
        b=cnmfWFfOBwWMsYbrgHoZocSJHwPirUHN9n95lPQtlJF6ElubdsLhtoBiTTaugFeXwX
         IYbVkzJGZp7YfbCHPWFrs6eJ2t+JgM8rz6h0Z56v6jgfdAgODMkVyyM8iexbDWaVMZcW
         MaRVGuROPeulCzcS+SrKyqlyRdr9h7E+IozpI7OzPasOUrboxPxRuNGMCWP9Otsh4/aj
         iOVTc7EQA7RZP2vZI0H+UbQIFI5gVBifBVsxgMIR3liOopLTZEtaMVhl0yxwBR2ZAfJR
         DxF28H08KmeJ2lgMTdQbR3anhLBaD9ZslbeXUO0k7Swdr19Imy3W48CGhbzawj3Z8LJ4
         GsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776353962; x=1776958762;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly8ZF0cLC98sd5Q4ROI4wD3mgO8d3lzf4Xtu02X0u1k=;
        b=Tigco9QX8mjplrv5pA4aImh/HqiyNq4a+8eZGdNDsb4WKnN6rxVHNy5KVv2XTWolId
         Ls8YzA0xv0JGYerXaTXLRgMAjDruDNpCzGx8xfrNCkkSp5bRKUs11b7j0bhDN6rurOq1
         MJW9YnHN3MWLLoH4X1jqSur1daxfZwKQosEjaNL1tOwlxKKjw5Ix0bpyHxMYuZfkV7rQ
         7V/WLKjvoILShX7BB82hBc3yg3qrOOlDA7qzcesx1dKc+CEeLJM9s/lU8Rgu3ce6qHRk
         XyY3r5pdHQdDzk/09xdqrSh5iKkp9ilJHS3hhRygT8qIsHxbxJ3GigaF0ZXktbO2l9Kq
         kh2g==
X-Gm-Message-State: AOJu0YzvXpUbYxYaz2YpntvL4UXRQZRXy2KF+mBnyXweQ/sI6flpxwYA
	DNWDfiXAHveNcNnQfAJz4a1QI/E+UQeFBOjj/I4mwfVvysbr/frCygjGU46CHBIqm96hMEnguvS
	ru271Rk15TX5HdxLQY4paI63EQvDtzZmM5syfF0BGOOX6AhQEfrokhXXpVgbC
X-Gm-Gg: AeBDievB6AgEE1BTNDcEjAfktivg5mC99mA+PMvLmfI9cEn0aYDyRlu2CLD1vt2LJ8w
	NkpwoqLcEq1VyVFRlVVRmsIoZruOIdkPd3DZJxOja/KZDqDMxq2UWBmS24WkwsCWXvd5wULxKh7
	jcyRKGRHZcO3R8i7vGgS+HnZk+1XurYZwUsUo7+em+KFAhFjF+QgQirXtU9VOdPQ1fURetnMUbe
	cqQKeKyXeP82xJJtv88jFwFYmMYV1wcanepnnDZCJvRrf+bGlR7D5QkPzbyuL2+mBsdJgsMzDHL
	oR4af6AD/Zd81zJRcT3CgsxqxlnlUuAtaXgmxOXYCVXdB1faJSInXBzMm1Ro7so6KOfXbHtcfbc
	ku14XXEnMcVN6wYRziA==
X-Received: by 2002:a17:907:268b:b0:b98:2542:6135 with SMTP id
 a640c23a62f3a-b9d7243f5d8mr1490704566b.3.1776353961933; Thu, 16 Apr 2026
 08:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Runxi Yu <runxiyu@umich.edu>
Date: Thu, 16 Apr 2026 15:39:10 +0000
X-Gm-Features: AQROBzD8xl0MYAAXDEf2AX5uP5X1LqCErKOfsNRcazszCsR0_PhbwG0A0b4WB3Y
Message-ID: <CALLBc2Ph163mUAqr4H-AJPz_rxQz1bzGh=jxna-u-A=SwhF=0A@mail.gmail.com>
Subject: Unintuitive behavior of git-archive and git-checkout-index on tree objects
To: git@vger.kernel.org
Cc: me@runxiyu.org, Kevin Pettibone <kpetti@umich.edu>, hax@runxiyu.org, ron@noisytoot.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

Consider the following commands.

/ztank/programming/runxiyu.org/content $ git checkout
43aa0d7ea653e17e70a3bdff91143bf0a064169c96c14c55ed150623902f8ed0
fatal: Cannot switch branch to a non-commit
'43aa0d7ea653e17e70a3bdff91143bf0a064169c96c14c55ed150623902f8ed0'
128 /ztank/programming/runxiyu.org/content $ git archive
43aa0d7ea653e17e70a3bdff91143bf0a064169c96c14c55ed150623902f8ed0 >
/tmp/kd
/ztank/programming/runxiyu.org/content $ xxd /tmp/kd | grep -v '0000
0000 0000 0000 0000 0000 0000 0000'
1 /ztank/programming/runxiyu.org/content $ # empty tarball it seems.
/ztank/programming/runxiyu.org/content $ ls -l /tmp/kd
-rw-r--r-- 1 runxiyu runxiyu 10240 Apr 16 15:13 /tmp/kd
/ztank/programming/runxiyu.org/content $ export GIT_INDEX_FILE=$(mktemp)
/ztank/programming/runxiyu.org/content $ git read-tree
43aa0d7ea653e17e70a3bdff91143bf0a064169c96c14c55ed150623902f8ed0
/ztank/programming/runxiyu.org/content $ git checkout-index -a --prefix=/tmp/kdd
/ztank/programming/runxiyu.org/content $ ls /tmp/kdd
/ztank/programming/runxiyu.org/content $ ls -a /tmp/kdd
./  ../
/ztank/programming/runxiyu.org/content $ git cat-file -p
43aa0d7ea653e17e70a3bdff91143bf0a064169c96c14c55ed150623902f8ed0 |
head -n 10
100644 blob 450ae52cc72fe249f3b42e5776fb9c5b6cbb303306ede27052c5a52e2e4d65d3
   _index.md
100644 blob cc4b067a0128a1c2ffcf36c164c2275e82f2082355db81e0335783dffb117487
   dust.md
100644 blob 68222f364217131e1924aa8828ba6dfcdad95dec4a54834b4f4a006821078d1c
   flicker.md
100644 blob 36fd1fc4eac70880bdc98b44a87bb4bd408582565516b5c370188da6f67e78f4
   inundating.md
100644 blob 7fd5618b7c1416f3d9b84bfedb7290de5c3d09298669b66e582ec306ed8fdfa8
   kat.md
100644 blob a129e79f3edbe7558246a5012d0e09e7b8dece22da55a449df9915bc2e24d9b9
   leaf.md
100644 blob 8715a9815094190a401842cd3e0f6bc1f29e5ba3a15b2a9f396528124f4605b7
   multiplicity.md
100644 blob 97dde2285aa0abb1456f1c11840e939c92762419eaeceeaed9fdfa7851d8450c
   orbits.md
100644 blob 953f577fd76120938fedd645260addff3b0b5e55aebc07a300722a6a13611d33
   rings.md
100644 blob 957ab79860c3a1bb3ca411d53e8391ed799f496036d7c36d54d3aceb9d581b61
   seventeen-days.md
/ztank/programming/runxiyu.org/content $ and yes this is a sha256 repo
but that doesn't matter.

/ztank/programming/runxiyu.org/content $ git fsck --full --strict
Checking ref database: 100% (1/1), done.
Checking object directories: 100% (256/256), done.
Checking objects: 100% (441/441), done.
Verifying commits in commit graph: 100% (78/78), done.
/ztank/programming/runxiyu.org/content $  # and yes this does prove
the blobs exist; also a normal checkout works fine.

 /ztank/programming/runxiyu.org/content $ file /tmp/tmp.LIP8s2hdGM
/tmp/tmp.LIP8s2hdGM: Git index, version 2, 19 entries
/ztank/programming/runxiyu.org/content $ xxd /tmp/tmp.LIP8s2hdGM | head -n 15
00000000: 4449 5243 0000 0002 0000 0013 0000 0000  DIRC............
00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000020: 0000 0000 0000 81a4 0000 0000 0000 0000  ................
00000030: 0000 0000 450a e52c c72f e249 f3b4 2e57  ....E..,./.I...W
00000040: 76fb 9c5b 6cbb 3033 06ed e270 52c5 a52e  v..[l.03...pR...
00000050: 2e4d 65d3 0009 5f69 6e64 6578 2e6d 6400  .Me..._index.md.
00000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
00000070: 0000 0000 0000 0000 0000 0000 0000 81a4  ................
00000080: 0000 0000 0000 0000 0000 0000 cc4b 067a  .............K.z
00000090: 0128 a1c2 ffcf 36c1 64c2 275e 82f2 0823  .(....6.d.'^...#
000000a0: 55db 81e0 3357 83df fb11 7487 0007 6475  U...3W....t...du
000000b0: 7374 2e6d 6400 0000 0000 0000 0000 0000  st.md...........
000000c0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
000000d0: 0000 0000 0000 81a4 0000 0000 0000 0000  ................
000000e0: 0000 0000 6822 2f36 4217 131e 1924 aa88  ....h"/6B....$..
/ztank/programming/runxiyu.org/content $

/ztank/programming/runxiyu.org/content $ git checkout-index -a -f
--prefix=/tmp/kdd
/ztank/programming/runxiyu.org/content $ ls /tmp/kdd

/ztank/programming/runxiyu.org/content $ git checkout-index -a -f
--prefix=/tmp/kdd/
/ztank/programming/runxiyu.org/content $ ls /tmp/kdd

------------------------ >8 ------------------------

I understand it for git-archive, albeit unintuitive:

       <path>
           Without an optional path parameter, all files and
           subdirectories of the current working directory are
           included in the archive. If one or more paths are
           specified, only these are included.

But it's difficult to understand this behavior for git-checkout-index.

Particularly,

       -a, --all
           checks out all files in the index except for those with
           the skip-worktree bit set (see
           --ignore-skip-worktree-bits). Cannot be used together with
           explicit filenames.

If the behavior is to be kept, should this be changed to "all
files in the index that match the implicit pathspec (of the
current directory)"?

Or an idiomatic way to check a tree out, other than
-C "$(git rev-parse --show-toplevel)"?

Thanks!

Please reply-all since I'm not on the list.

Thanks!

-- 
Best regards,

Runxi Yu (they/them)
University of Michigan, Ann Arbor
runxiyu@umich.edu
me@runxiyu.org
