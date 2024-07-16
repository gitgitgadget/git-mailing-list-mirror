Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396C4687
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 19:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721159344; cv=none; b=U/Zst4uXjup7MWkXKH+0oPlz/FZ36I3dgW4QX/7MhYskn+KSkbWnKQxzSCrJlU5mF6MvtlPb+82rlHjzTF5VZ0dMau8M9aWcNdBgbSYrXP/wfIgZd22A28QZ0riDcOJlX3DVPPDSGDyoeYm+pSZMjSDDNq8y7GAbFgPb3q74ciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721159344; c=relaxed/simple;
	bh=J5Xjz8iFTbgy7vCuLEdkdb7+0NP1kBtPBD9QKLwuu/g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=MWlptXLFfsSrhBRq+UP3vbNEW3TbkmbOhKGPAAF4NrEqvsIoiYR4zn4iYkoSI7vkb3hk3H+elhqRG9U9CIN45Be9XCyCbK2CNMB50UVGzHu4HaTN1iC8V68puKpS5yxQlZH4hi5Q8EysJakNzTrUh+M0Iv8Wtfuecvim+/O3IZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=gFj1+3Iv; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="gFj1+3Iv"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id To7Qs7Y2qLOPVTo7RsuLrA; Tue, 16 Jul 2024 20:45:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721159151; bh=3cxJs7pkzt89hw968PEOnGVJxfMCf1UFmobs9da6Nag=;
	h=Date:To:Cc:From:Subject;
	b=gFj1+3IvXaOZnJ+viASBzkaZ6A128VAHX2L2wOJojn0MxBU+yKB5WafAjoC7UAx5c
	 h83xVjXnaQZxaw0GbXjw46txwEJe/eEG/mfV/YDbHjS3gFBPjws4hwiGkH5U4SBZtc
	 fC08ecLMqdNs4eEv0YzsrsV/EeNfdGsb2hdm7GjGm1sWJ/4Uw9SwtOixzFfQvDe04a
	 b4QS/Xidm+AfAVyIhv7A5KjbdL9DS/rN9QU1Co0ZYLiY5oTygwA6Q12+OnYrbxlRVU
	 Yfc4KKCjKj3sGGgY4JxQZLCocz0wWet8ZfY70lIqAz7bTdKr3nxGl4HChd/c+k0rsj
	 /uWID0f7JaPIA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UsvANPwB c=1 sm=1 tr=0 ts=6696cdef
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=o4XeMJcPDZKKO6PKN20A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
Date: Tue, 16 Jul 2024 20:45:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>, Adam Dinwoodie <adam@dinwoodie.org>,
 Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: v2.46.0-rc0 test failures on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNYE3h7ywKkZcDSOlSLBWX/RqQxjPvBWVB7INVIC67fKforVJmePWxCAD9zhG0VYjRtJbKbq4/y+JBH1sBVECsMLuyyEC5ABCunJTeGmCqYX168UE2yt
 HItN41afZEw/luL91QqI52Zll/haHj8ijr1cSrSSrM+Rp2fzsXf1vOYzFqJNtlsw5eG+dUZMiVrXprRlHV1rX+WM0cqozk6yvW4=


The 'Test Summary Report' for the v2.46.0-rc0 test run, on cygwin, includes:

  ...
  t1460-refs-migrate.sh                            (Wstat: 256 (exited 1) Tests: 30 Failed: 9)
    Failed tests:  8-15, 29
    Non-zero exit status: 1
  ...

Looking at the test output directly, we see:
 
  $ pwd
  /home/ramsay/git
  $ cd t
  $ make clean
  rm -f -r 'chainlinttmp'
  rm -f -r 'trash directory'.*
  rm -f -r valgrind/bin
  rm -f -r 'test-results'
  rm -f .prove
  $ ./t1460-refs-migrate.sh -v -i
  ...
  ok 7 - files -> reftable: migration with worktree fails
  
  expecting success of 1460.8 'files -> reftable: unborn HEAD': 
  			test_when_finished "rm -rf repo" &&
  			git init --ref-format=$from_format repo &&
  			test_migration repo "$to_format"
  		
  Initialized empty Git repository in /home/ramsay/git/t/trash directory.t1460-refs-migrate/repo/.git/
  error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.git/reftable': Permission denied
  migrated refs can be found at '.git/ref_migration.sr9pEF'
  not ok 8 - files -> reftable: unborn HEAD
  #	
  #				test_when_finished "rm -rf repo" &&
  #				git init --ref-format=$from_format repo &&
  #				test_migration repo "$to_format"
  #			
  1..8
  $ 

Note that all of the errors in this test look similar to this one (ie. when
rename()-ing the 'migrated' reftable directory to .git/reftable we get an
'Permission denied' error). So the error message is from line 2672 of refs.c
in the move_files() function.

Let's have a quick look at the test directory:

  $ cd trash\ directory.t1460-refs-migrate/
  $ ls
  err  expect  repo/
  $ cd repo
  $ ls -l .git
  total 7.0K
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 branches/
  -rw-r--r-- 1 ramsay None 86 Jul 16 19:53 config
  -rw-r--r-- 1 ramsay None 73 Jul 16 19:53 description
  -rw-r--r-- 1 ramsay None 25 Jul 16 19:53 HEAD
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 hooks/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 info/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 objects/
  drwx------ 1 ramsay None  0 Jul 16 19:53 ref_migration.sr9pEF/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 refs/

Now try to finish the migration by hand:

  $ mv .git/ref_migration.sr9pEF/reftable .git/reftable

Hmm, note no error; of course, the mv command may well do much more than
the rename() library function, so they are not necessarily equivalent.

  $ ls -l .git
  total 7.0K
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 branches/
  -rw-r--r-- 1 ramsay None 86 Jul 16 19:53 config
  -rw-r--r-- 1 ramsay None 73 Jul 16 19:53 description
  -rw-r--r-- 1 ramsay None 25 Jul 16 19:53 HEAD
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 hooks/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 info/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 objects/
  drwx------ 1 ramsay None  0 Jul 16 19:55 ref_migration.sr9pEF/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 refs/
  drwxr-xr-x 1 ramsay None  0 Jul 16 19:53 reftable/
  $ 
  $ rm -rf .git/ref_migration.sr9pEF/
  $ git branch -v
  fatal: failed to resolve HEAD as a valid ref
  $ ls -l .git/reftable
  total 2.0K
  -rw-r--r-- 1 ramsay None 124 Jul 16 19:53 0x000000000001-0x000000000001-64e987ec.ref
  -rw-r--r-- 1 ramsay None  43 Jul 16 19:53 tables.list
  $ xxd .git/reftable/0x000000000001-0x000000000001-64e987ec.ref 
  00000000: 5245 4654 0100 1000 0000 0000 0000 0001  REFT............
  00000010: 0000 0000 0000 0001 7200 0038 0023 4845  ........r..8.#HE
  00000020: 4144 000f 7265 6673 2f68 6561 6473 2f6d  AD..refs/heads/m
  00000030: 6169 6e00 001c 0001 5245 4654 0100 1000  ain.....REFT....
  00000040: 0000 0000 0000 0001 0000 0000 0000 0001  ................
  00000050: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  00000060: 0000 0000 0000 0000 0000 0000 0000 0000  ................
  00000070: 0000 0000 0000 0000 b6bf f78a            ............
  $ 

So, the HEAD ref was referring to refs/heads/main.

  $ pwd
  /home/ramsay/git/t/trash directory.t1460-refs-migrate/repo
  $ git init --ref-format=reftable
  fatal: attempt to reinitialize repository with different reference storage format
  $ xxd .git/refs/heads 
  00000000: 7468 6973 2072 6570 6f73 6974 6f72 7920  this repository 
  00000010: 7573 6573 2074 6865 2072 6566 7461 626c  uses the reftabl
  00000020: 6520 666f 726d 6174 0a                   e format.
  $ 
  $ git branch -v
  fatal: failed to resolve HEAD as a valid ref
  $ 
 
Hmm, so quite broken :)

Maybe the order of some of the actions in repo_migrate_ref_storage_format() may
need to be re-thought! ;)

The 'man 3 rename' is not very enlightening; 'The conditions for failure depend
on the host operating system.'

Unfortunately, I don't have any (well much) spare time to dig further into
this at the moment, so I thought I should at least report it here for others
to hopefully find a solution.

ATB,
Ramsay Jones

