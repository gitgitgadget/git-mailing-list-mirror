Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12769DF71
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762300382; cv=none; b=pa4ZjTv/i1XssMEWdWEXktcoiM0fRwU3fednr648VW8dVBqzGix67iR4pgEPgn4FFhaXqRYfq/CyKF67iYpUYqR2TIDZemhO5xAjn/+bVscAWKUzaQvb1XIynxdsLq+EuaxzYoO20Ig+OG4EmlhFbNvZmSHsSpDARK5NdXRfi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762300382; c=relaxed/simple;
	bh=ZuHZjmiP9J1bfZiEsKKxmWOtlvSt6+GzTCdt5RIf6Uw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kgxpkpE/7XO2otjUkfD+koiAuKUC2pJbxk0ZiKIm71xLsvyMhgUGNio9RfK8T5xDb1VW+oUivuPVydjAn0koUCmEP+ceLdR3GmFfmvidhHNNqGK9H0GDav4WusVz1N3lp6sXLDoW9ojVpKJ7DyApn+HC0fka1TvvElGRLDcN5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Gvj5I40e; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Gvj5I40e"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id GQmYv1cxn9u4DGQmZvcP5e; Tue, 04 Nov 2025 23:49:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1762300189; bh=UxCcKsTeQXsJnWSDvonAPSZ3W8KqPMf9iG4fJMgkWX8=;
	h=Date:To:Cc:From:Subject;
	b=Gvj5I40eVUD5R5zqo0CE7UQGwP0AYNzyQNdRNWk+zITHvKH1PPFe+zCdYoZUUnaag
	 /XmWFDvyQF7Z8lOyFdla95fvSME31a0KZuopMJhJSev57zOzm8S2KcpV/AChCH6LLp
	 31SStKegD0bZ7QHeJrec378fhjJPwBSAZdVE4buvNPUYjmhfmWSdiDp8LtNsJhUNOb
	 Lxp36Fz3N/IxvQO9W+6DzTFl56gfLRSGQQ7HamOi8kabC/+Ypk9Jakp84LjEwKLCAi
	 LKH3zjSaQtDdMYeV4lqYaZ1C96lE9FaM1GfECHdCypkUhviAj4heUgYOwBo8hZkOsx
	 HUJNMZ0c/kM/Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=UKJ+Hzfy c=1 sm=1 tr=0 ts=690a911d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8 a=EtC-CzOzkOxthMReZZkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>
Date: Tue, 4 Nov 2025 23:49:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>,
 Patrick Steinhardt <ps@pks.im>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: v2.52.0-rc0 test failure on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBXyQeHBUyYplNT7K84ZyDrMEsmYXcZHJuDdG4+tztbjcjqZ9DnozOEOV+ymbYIDUkMGgMmNAh4O1StW4vC0YDLR2tVnKcB8bsVmvBDGrhLLQmx9BzNK
 fzvGHSzDMrcw8uWUxO5FL945tRkC37xHuJ1ddtO3MBnRTCII7fnJ/zZLXzJQosVMLHi3XsErY4pJdO/fa831XGG2vghCzHHisIE=

Hi Junio,

Just a quick heads up: the rc0 build on cygwin has a flaky test, thus:
  
  $ tail test-out-2-52-rc0 
  Test Summary Report
  -------------------
  t0610-reftable-basics.sh                         (Wstat: 256 (exited 1) Tests: 90 Failed: 1)
    Failed test:  29
    Non-zero exit status: 1
  Files=1024, Tests=32232, 2703 wallclock secs (23.38 usr 60.53 sys + 7886.88 cusr 10419.88 csys = 18390.67 CPU)
  Result: FAIL
  make[1]: *** [Makefile:78: prove] Error 1
  make[1]: Leaving directory '/home/ramsay/git/t'
  make: *** [Makefile:3327: test] Error 2
  $ 
 
Initially, while investigating the failure, I was running the test by hand and it
didn't fail ... So, I tried a stess test, like so: 
  
  $ cd t
  $ ./t0610-reftable-basics.sh --run=29 --stress-limit=10
  FAIL  3.1
  OK    7.1
  OK   19.1
  OK   18.1
  OK    2.1
  OK    6.1
  OK    9.1
  OK    0.1
  OK   21.1
  OK    8.1
  OK    4.1
  OK   10.1
  OK   12.1
  OK   26.1
  OK   29.1
  OK   17.1
  OK    1.1
  OK   23.1
  OK    5.1
  OK   11.1
  OK   27.1
  OK   16.1
  OK   14.1
  OK   30.1
  OK   15.1
  OK   25.1
  OK   31.1
  OK   22.1
  OK   24.1
  OK   20.1
  OK   28.1
  OK   13.1
  Log(s) of failed test run(s):
  Contents of '/home/ramsay/git/t/test-results/t0610-reftable-basics.stress-3.out':
  Initialized empty Git repository in /home/ramsay/git/t/trash directory.t0610-reftable-basics.stress-3/.git/
  ok 1 # skip pack-refs does not crash with -h (--run)
  
  ok 2 # skip init: creates basic reftable structures (--run)
  
  ...
 
  ok 27 # skip clone: can clone reffiles into reftable repository (--run)
  
  ok 28 # skip clone: can clone reftable into reffiles repository (--run)
  
  expecting success of 0610.29 'ref transaction: corrupted tables cause failure': 
  	test_when_finished "rm -rf repo" &&
  	git init repo &&
  	(
  		cd repo &&
  		test_commit file1 &&
  		for f in .git/reftable/*.ref
  		do
  			: >"$f" || return 1
  		done &&
  		test_must_fail git update-ref refs/heads/main HEAD
  	)
  
  ++ test_when_finished 'rm -rf repo'
  ++ test 0 = 0
  ++ test_cleanup='{ rm -rf repo
  		} && (exit "$eval_ret"); eval_ret=$?; :'
  ++ git init repo
  Initialized empty Git repository in /home/ramsay/git/t/trash directory.t0610-reftable-basics.stress-3/repo/.git/
  ++ cd repo
  ++ test_commit file1
  ++ local notick=
  ++ local echo=echo
  ++ local append=
  ++ local author=
  ++ local signoff=
  ++ local indir=
  ++ local tag=light
  ++ test 1 '!=' 0
  ++ case "$1" in
  ++ break
  ++ indir=
  ++ local file=file1.t
  ++ test -n ''
  ++ echo file1
  ++ git add -- file1.t
  ++ test -z ''
  ++ test_tick
  ++ test -z ''
  ++ test_tick=1112911993
  ++ GIT_COMMITTER_DATE='1112911993 -0700'
  ++ GIT_AUTHOR_DATE='1112911993 -0700'
  ++ export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
  ++ git commit -m file1
  [main (root-commit) 69af168] file1
   Author: A U Thor <author@example.com>
   1 file changed, 1 insertion(+)
   create mode 100644 file1.t
  ++ case "$tag" in
  ++ git tag file1
  ++ for f in .git/reftable/*.ref
  ++ :
  ./test-lib.sh: line 1017: .git/reftable/0x000000000001-0x000000000002-3b7f1804.ref: Permission denied
  error: last command exited with $?=1
  not ok 29 - ref transaction: corrupted tables cause failure
  #	
  #		test_when_finished "rm -rf repo" &&
  #		git init repo &&
  #		(
  #			cd repo &&
  #			test_commit file1 &&
  #			for f in .git/reftable/*.ref
  #			do
  #				: >"$f" || return 1
  #			done &&
  #			test_must_fail git update-ref refs/heads/main HEAD
  #		)
  #	
  1..29
  $ 

Note the 'Permission denied' error when attempting to corrupt (empty)
the '*.ref' tables. (Also, this shows 1 error in 32 parallel attempts).

However, the 'trash' directory shows that the file permissions are set
such that I should be able to corrupt them:
  
  $ cd trash\ directory.t0610-reftable-basics.stress-failed/
  $ cd repo
  $ ls -l .git/reftable
  total 3.0K
  -rw-r--r-- 1 ramsay None 296 Nov  4 17:56 0x000000000001-0x000000000002-3b7f1804.ref
  -rw-r--r-- 1 ramsay None 139 Nov  4 17:56 0x000000000003-0x000000000003-66444a41.ref
  -rw-r--r-- 1 ramsay None  86 Nov  4 17:56 tables.list
  $ 

Indeed, I can do just that:
  
  $ : >.git/reftable/0x000000000001-0x000000000002-3b7f1804.ref 
  $ ls -l .git/reftable
  total 2.0K
  -rw-r--r-- 1 ramsay None   0 Nov  4 18:54 0x000000000001-0x000000000002-3b7f1804.ref
  -rw-r--r-- 1 ramsay None 139 Nov  4 17:56 0x000000000003-0x000000000003-66444a41.ref
  -rw-r--r-- 1 ramsay None  86 Nov  4 17:56 tables.list
  $ git update-ref refs/heads/main HEAD
  fatal: HEAD: not a valid SHA1
  $ 
 
So, this appears to be a timing issue (a bit difficult to think how it
actually could be, but ...), so maybe try:
 
  $ cd ../..
  $ vim t0610-reftable-basics.sh
  $ git diff
  diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
  index 3ea5d51532..4fc5cbca99 100755
  --- a/t/t0610-reftable-basics.sh
  +++ b/t/t0610-reftable-basics.sh
  @@ -205,6 +205,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
          (
                  cd repo &&
                  test_commit file1 &&
  +               sleep 1 &&
                  for f in .git/reftable/*.ref
                  do
                          : >"$f" || return 1
  $ ./t0610-reftable-basics.sh --run=29 --stress-limit=10
  OK    0.1
  OK   13.1
  OK    4.1
  OK    1.1
  OK    2.1
  OK    3.1
  OK   10.1
  OK    8.1
  OK   26.1
  OK   21.1
  OK    7.1
  OK   19.1
  OK    9.1
  OK    5.1
  OK   14.1
  OK   22.1
  OK   11.1
  OK   27.1
  OK   17.1
  OK   29.1
  OK    6.1
  OK   30.1
  OK   15.1
  OK   23.1
  OK   12.1
  OK   24.1
  OK   25.1
  OK   16.1
  OK   18.1
  OK   28.1
  OK   31.1
  OK   20.1
  OK    0.2
  OK   13.2
  OK    4.2
  OK   10.2
  OK    2.2
  OK    3.2
  OK    1.2
  OK   22.2
  OK    8.2
  OK   21.2
  OK   19.2
  OK    5.2
  OK    9.2
  OK    7.2
  OK   26.2
  OK   11.2
  OK   14.2
  OK   25.2
  OK   28.2
  OK   15.2
  OK   17.2
  OK   27.2
  OK    6.2
  OK   18.2
  OK   30.2
  OK   31.2
  OK   29.2
  OK   20.2
  OK   16.2
  OK   12.2
  OK   23.2
  OK   24.2
  OK   13.3
  OK    4.3
  OK    0.3
  OK    3.3
  OK   10.3
  OK    2.3
  OK    1.3
  OK    8.3
  OK   22.3
  OK   19.3
  OK    5.3
  OK   14.3
  OK   26.3
  OK    7.3
  OK   25.3
  OK   15.3
  OK   28.3
  OK   21.3
  OK    9.3
  OK   11.3
  OK   12.3
  OK   23.3
  OK   16.3
  OK   17.3
  OK   18.3
  OK   29.3
  OK    6.3
  OK   30.3
  OK   27.3
  OK   24.3
  OK   31.3
  OK   20.3
  $ 
 
[I hit ctrl-c here]

So, not really an answer, but I have noted several times over the years
that cygwin seems to delay setting some file attributes until after the
process has exited ... [yeah, I don't see how either! ;) ].

I noted the above last night and, unfortunately, I haven't had any
time to look into this tonight. (hopefully tomorrow).

[I haven't tried bisecting because, well ... flaky test! ;) ]

ATB,
Ramsay Jones

