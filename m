Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334C1F03D7
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842842; cv=none; b=hyRvflX/6VeogyEctxmKm1alnJ9/3G8g8gmMs4AruEh5hfFCaLy8DVyYLidLf3gR3V8Gs850L0YR6GODFK3AF8xw//gK/JDYlVaPrkbBtxqNyupz+Mu/Nmq879eZZn0ohBBdrazV495Elblsb+cXGEDN1b04JePPobRK11kESk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842842; c=relaxed/simple;
	bh=GS5SEh5SmioJBKxonHDPTGhmHbs70dOLGzS8QesqY78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3Xvte99cZFFR3/A7AjQsHDsMy7NXiWxhYsYX+X4AvbqaCMLdNP7DMf4t0qsXNAyD2Ls2/dfGmoXucC2hW3okSZf4J9fseVh5gIGL8VWw2KmelzyYzski5PB4yZOkTOdGzjhzvjbtbeToFfOw7/lkrfzDwg4YUeIvR7S9FMb/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=AsVSIz15; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="AsVSIz15"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id hsm6vdeaTENzvhsm8v0lbX; Mon, 19 Jan 2026 17:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1768842648; bh=7bGthu381o9q+kI7We7FCzoigU+5f2SqqQ8sqF05Yag=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AsVSIz15tLiuEOQh6PWEG6gERCD5WtCAVixRFjJl6nGbX4pReFBiMZT9+kgOPsjkx
	 Y2mT4K478GU/OfeD31GkFl3BKas2ia0VhiKfvJFwwi9yjLSl7i5p5OxcyDof+Qui5M
	 er7Akx4IoGiySp860Y9GOx0S1s03QbfISE2E0u/XBN2UUycK358h6ieAMnlhYMs6M3
	 P0eIUpfrhgsfKU/LmJzW1k7OShsQxiBEO5xhM9veTu7/Vu8rKbZfg5igGO50XLWdRQ
	 d2s36cIM+2+9tucg88uRdPN7IuaACpGRRIxOJDuHErcNFiuHZBfTmyK2nHjuHBC7dQ
	 ZVFmmHFsxxb5Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=doN4CEg4 c=1 sm=1 tr=0 ts=696e6598
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8 a=yYNHE5MykbLbUTAhWGoA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <f4599b1e-78df-44f3-a9b8-ed28411e169c@ramsayjones.plus.com>
Date: Mon, 19 Jan 2026 17:10:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] t0610-reftable-basics: mitigate a flaky test on
 cygwin
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>
References: <f46e023b-1925-41b2-9842-42e7cb727056@ramsayjones.plus.com>
 <aW3UO3ff9aNc7HQz@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aW3UO3ff9aNc7HQz@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKWZVG0LW2KDoghz3HHe8tSJhSpzdJa8+Agv/LMeOZrCwAzDlOoQ7MZYP9MxRIoytyqbBqGzhkJ/OlTwopzc+azZjMnnOr8iL6h/9vRG+U9ufk6C08rL
 DRZe0WZ0nY32EEfrd4cyxkuPwbdAPTcKZWYePrD4hrBj0vU6EJaVr6dMJAv7mILKLfdlrSBiCbQvkL7/IIwdZ1+gtKO6Y1r8pYI=



On 19/01/2026 6:50 am, Patrick Steinhardt wrote:
> On Fri, Jan 16, 2026 at 08:39:56PM +0000, Ramsay Jones wrote:
>>
>> Test #29 ('ref transaction: corrupted tables cause failure') started to
>> fail intermittently for me (from v2.52.0-rc0) when running the testsuite
>> with '-j8'. (Also, having moved to a new laptop and windows 11, rather
>> than windows 10). If the test is run by hand, or without any parallelism,
>> then it passes without issue.
>>
>> When the test fails (e.g. 1 out of 32 parallel runs) the cause is due to
>> a permission error while corrupting a table file:
>>
>>   ./test-lib.sh: line 1010: .git/reftable/0x000000000001-0x000000000002-d89bb8ee.ref: Permission denied
> 
> This rings a bell. I remember that we discussed a case at some point in
> time where a redirect converted to `test-tool truncate` fixed a flake on
> Cygwin.

Indeed, the mail thread starts at:

  https://lore.kernel.org/git/f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com/

>> This corruption is done in a shell loop, directly after a 'test_commit',
>> which uses an ': >"$f"' expression to truncate the file. Adding a sleep
>> of one second after the 'test_commit' and before the shell loop fixes
>> the test (it is not clear why). Replacing the redirection shell expression
>> with a 'test-tool truncate "$f" 0' invocation also provides a fix, which
>> could simply be another way to change the timing sufficiently to win the
>> race.
>>
>> During a debug session, I tried looking at the strace output for the
>> shell redirection:
>>
>>   $ rm /tmp/hello; echo hello >/tmp/hello; ls -l /tmp/hello
>>   -rw-r--r-- 1 ramsay None 6 Nov 10 17:25 /tmp/hello
>>   $
>>
>>   $ strace -o zzz bash -c ': >/tmp/hello'
>>   $
>>
>> Similarly, for the test-tool solution:
>>
>>   $ strace -o xxx ./t/helper/test-tool truncate /tmp/hello 0
>>   $
>>
>> When comparing the output, the differences seemed to be what you would
>> expect and, if anything, the shell redirect probably would have taken
>> longer than the test-tool solution (many fcntl() calls to dup the stdout
>> to the <fd>).  The call to the win32 api NtCreateFile() was identical,
>> apart from the first (FileHandle) parameter, of course.
> 
> Too bad. I stil wonder whether it is the extra process that we spawn
> that ends up fixing the issue.

Well, a 'sleep 1' before the shell loop also fixes the issue. I hate to
mention the 'windows delays updating some file attributes until after the
process has exited' conspiracy theory, but ... :) (yeah, I just don't
think that is possible, except ...)

>> In order to fix this flaky test on cygwin, despite not knowing why it
>> works, replace the shell redirection with the above 'test-tool truncate'
>> invocation.
>>
>> Helped-by: Patrick Steinhardt <ps@pks.im>
> 
> Oh, so is this the exact case that we were talking about? If so, it
> might make sense to link to the mail thread so that folks can also read
> a bit into our discussion around this.

Indeed! I thought about referencing the email thread, but I decided that it
didn't really offer any more supporting evidence than the commit message
(in fact less - it doesn't mention the 'strace' scan).

I can add that (again [1]), if you think it's worth it, but I just re-read
the email thread and I'm not convinced it offers much extra value. So, I would
rather not re-roll, but I will if you think it worth it. Let me know.

[1] https://lore.kernel.org/git/f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com/

>> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> ---
>>  t/t0610-reftable-basics.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
>> index 6575528f21..e19e036898 100755
>> --- a/t/t0610-reftable-basics.sh
>> +++ b/t/t0610-reftable-basics.sh
>> @@ -207,7 +207,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
>>  		test_commit file1 &&
>>  		for f in .git/reftable/*.ref
>>  		do
>> -			: >"$f" || return 1
>> +			test-tool truncate "$f" 0 || return 1
>>  		done &&
>>  		test_must_fail git update-ref refs/heads/main HEAD
>>  	)
> 
> In any case, if it seems to reliably fix the issue I'd say we just merge
> it. It's unfortunate that we haven't been able to figure out the root
> cause, but so be it.

Agreed!

Thanks!

ATB,
Ramsay Jones



