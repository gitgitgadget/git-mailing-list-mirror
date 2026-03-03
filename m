Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E026D4F9
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772571016; cv=none; b=hCH/tuBKyivHuwun5vEXlpzjL1Qtky5Km678yUyEPFvWP8H/Wyz8woRv+5lrzg7yTUrc8XxksJteFW/m6NyfFPwpDAexFh12Trx0dYs51wr3ex++DCHAsb/yEVnSSYR7n41G1QVKui2fXWKzqlhwk+QjPxoEmw3+DkHJlJzrEFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772571016; c=relaxed/simple;
	bh=CdWndIKedgMsB7uN8vHEyaP/S8xll0VFBktWpk+CWTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jd+x0tX7V4bHxXIhURsd+/ZVEIEIkkwkwtoDPaKRLW/XluKnd15WYQuAMR53RGiqHpJ+g6DoNDfYzQwo37cEw8VHm1GFr4QMH13vn3/bBg+/N5pe+7JfjIqDZLxenc3SnXA7IhdoMZtrQK2ZZmN2hXXYLY8VjAUHDq9BUSusN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=OlZNCUtv; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="OlZNCUtv"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id xWdyvVgUVWlIOxWdzvLviT; Tue, 03 Mar 2026 20:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1772570824; bh=pkKw3kXuHTJVo8UiuhW7nIauhPp/ukOosGFYPn8xPtE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OlZNCUtv5Ox6B5NtX1In42Mh8osVCwZei5KgExjk6cZdDwACn5pIAW1Kp+Lac8Phn
	 Uwe5hKU1aEzzAXA0dlYI/OjotQlzUj6/xMckNO49+pRHK7eAJCZAN644s/ouTNjAHK
	 HA3aBNAGzrOzLc9t/Igzhe0RJrSnC6/ZObLJfDcIEL4n3I3IbReRcUai6ycRHJlm3n
	 FaN05sW1op36yIO2B5sqx8GEOlYN++khJBZ7eCBs7GIs7FjBzSiiXvokiVt/3TVeLr
	 qFIJpb7FewK7UTBvMXGbIG1dAZczkHoLqFMxYmLWqHDPWHDP0t8aKumq1OSHrZGdAh
	 FZYRcgTm08NyQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=atcRCjZV c=1 sm=1 tr=0 ts=69a748c8
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=LPMzWrbQItpxuvcWF6YA:9
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <2e62dc94-b821-4815-8dd2-f806580d2027@ramsayjones.plus.com>
Date: Tue, 3 Mar 2026 20:47:02 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] submodule: fetch missing objects from default remote
To: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>, git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
 <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20260303200906.4118348-1-nasser.grainawi@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfCcgnAvq9szr53yxWvry+PsOaTkMUCjbyPsM3wa/52ZiMMRMGlDm4M/qqahKQM/7d23HNimCA+0D8wUv8sP0N+K6nUsu50gCovITOaHYmEYf5mKmUFV+
 8Ij/tN3UR8iHpLKDvnCxygUJYkwo2eIhCR6FidTz3CkLYXv/ZpnsOJVtPlpSJL0WhDY2F8ibK8gObrvbwSiXMpHUHOBNmvEwK9Y=



On 03/03/2026 8:09 pm, Nasser Grainawi wrote:
> When be76c21282 (fetch: ensure submodule objects fetched, 2018-12-06)
> added support for fetching a missing submodule object by id, it
> hardcoded the remote name as "origin" and deferred anything more
> complicated for a later patch. Implement the NEEDSWORK item to remove
> the hardcoded assumption by adding and using a submodule helper subcmd
> 'get-default-remote'. Fixing this lets 'git fetch --recurse-submodules'
> succeed when the fetched commit(s) in the superproject trigger a
> submodule fetch, and that submodule's default remote name is not
> "origin".
> 
> Add non-"origin" remote tests to t5526-fetch-submodules.sh and
> t5572-pull-submodule.sh demonstrating this works as expected and add
> dedicated tests for get-default-remote.
> 
> Signed-off-by: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> Fixes for test_when_finished usage within a subshell.
> 

The 't5526-fetch-submodules.sh' test failed for me tonight. Having seen an
earlier email about the test_when_finished failures I wasn't too surprised
but, once I looked at the failure, it was obviously not the cause of this
failure. Indeed, when I ran the test by hand, it passed ... :)

It seems the 'seen' branch (@764d09c9ce) has this v5 version of the patch
and (in this test anyway) has some flakiness:

  $ cd t
  $ ./t5526-fetch-submodules.sh --stress >out 2>&1
  $ cat out
  FAIL  4.1
  FAIL  3.1
  FAIL  5.1
  OK    0.1 
  OK    1.1
  OK    6.1 
  OK    7.1
  OK    2.1 
  Log(s) of failed test run(s):
  Contents of '/home/ramsay/git/t/test-results/t5526-fetch-submodules.stress-3.out':
  Initialized empty Git repository in /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-3/.git/
  expecting success of 5526.1 'setup': 

  ...

  expecting success of 5526.44 'fetch new submodule commits on-demand outside standard refspec with custom remote name':

  ...

  + diff -u expect_fetch_custom actual_fetch_warnings_removed
  --- expect_fetch_custom 2026-03-03 20:35:13.949600802 +0000
  +++ actual_fetch_warnings_removed       2026-03-03 20:35:14.150601532 +0000
  @@ -4,9 +4,9 @@
   Fetching submodule sub1/subdir/deepsubmodule
   Fetching submodule submodule
   Fetching submodule submodule/subdir/deepsubmodule
  -From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-5/./sub1
  - * branch            43c17d99ab9d4fcabf7107e36660b27113b54663 -> FETCH_HEAD
  -Fetching submodule sub1/subdir/deepsubmodule
   From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-5/submodule
    * branch            e38933e027ee8a2000f603124aa899302a09a51f -> FETCH_HEAD
   Fetching submodule submodule/subdir/deepsubmodule
  +From /home/ramsay/git/t/trash directory.t5526-fetch-submodules.stress-5/./sub1
  + * branch            43c17d99ab9d4fcabf7107e36660b27113b54663 -> FETCH_HEAD
  +Fetching submodule sub1/subdir/deepsubmodule
  error: last command exited with $?=1
  not ok 44 - fetch new submodule commits on-demand outside standard refspec with custom remote name

  ...

  $ 

From which I guess that the order of the output is somewhat unpredictable.

Also, other test files in that patch didn't fail for me with 'make test', but it
could be possible that they are also flaky. I didn't look.

Thanks.

ATB,
Ramsay Jones



