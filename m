Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EEC186E58
	for <git@vger.kernel.org>; Thu,  6 Nov 2025 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762461109; cv=none; b=q9uUVDzR6FSNHiiZZMAlJ3CkzkEMCZRw/6JXltSJfoN8XGQC6qFk80wb5iDq7nA3HJvH7CtTIfW/P6lswiRzuiv4xLCx0vNzpzDFQSf32y8HIDD9Xg/MivYcF6NssOsoZ/XdQsH0GJ75LZBPGXFQG9cpcGat81QCDcEwOjbotHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762461109; c=relaxed/simple;
	bh=349Vsix+4Tkowp0SUGEMLV+GsI9K62V0GVAsHLBNO9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N/Qz76f8CN+ZKrQrR7NbPobNEvNeJTD5lFUa2ajhbyHtS26mU8y/vAcvxh09SrVQMS6Ri5S2ds9axhOiby6gYN72riq591y10AtjiUuIR/xriu5U0pP3QHnk24Tvv3rAEp34kl3/gQiVWn0k+wysxluLgga5EUg4c79AZzZ7SYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jh+JNnbr; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jh+JNnbr"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id H6axvHCfDYuioH6ayvIPYu; Thu, 06 Nov 2025 20:28:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1762460917; bh=jACIO+SYZsdfEbSAKOzqEZ/cdGf+zM92ldObd2xrYdo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jh+JNnbrTfXrGoLWNePsgJhH0DsTcJ/cfG4+OFMTeKf/4Mne+bmsOwjadpl/+PnVR
	 V8ttYkEh3+WIeYkTN+X41gKg+4yK14ghUFW2VP2GqxNIcMzYkRmRQDWyDsubx9i0JV
	 b5PMkuSKUtQsR8OouheS/9AUhaTFrrDQWQsX/3ZqQaHNAJH0BUf5CJuKW3FoZDuTro
	 i38n4zGWJ1lzHwswj1olO4WWh+sCY/EaKonZfwcxPnclF0T32A9eqjFSB+TVf+N8+g
	 Qf9zAWJ24VZRisDErJSwMR/octMNrCyJa7KogKrJsrQrBDShjdK4woPtfba1VGAZYV
	 74nqEGKZjjTjw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=HMRgFZtv c=1 sm=1 tr=0 ts=690d04f5
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=xXvk1ejdXSZGQVglDr4A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <a8a03a31-8e06-4b72-b847-b59548156e60@ramsayjones.plus.com>
Date: Thu, 6 Nov 2025 20:28:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.52.0-rc0 test failure on cygwin
To: Patrick Steinhardt <ps@pks.im>
Cc: GIT Mailing-list <git@vger.kernel.org>, Junio C Hamano
 <gitster@pobox.com>, Adam Dinwoodie <git@dinwoodie.org>
References: <f22c95ad-43c8-41de-8315-e707224e830b@ramsayjones.plus.com>
 <aQx-RnNX28BPU2cS@pks.im>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aQx-RnNX28BPU2cS@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGq9eZuzTqnOBBfgYDhbhfdmtP9uqN1A+0rL3jP1UKkOXBbosU1ZiLz9EIzHOdYGee9NosFp0/pVv95nJJFsumJsLHJi5wskmWrNCWgBVLW3AHPCf6gH
 6RWPhauV5Zt5cK/BO1XjF00b0M5EuS/lkPMdEhC4WBPjPcr1LjEmdxs7cT/bUTf0M66+nF9rX27OhZLZxTBQpNUr8AXmpPb+9Qc=



On 06/11/2025 10:53 am, Patrick Steinhardt wrote:
> On Tue, Nov 04, 2025 at 11:49:46PM +0000, Ramsay Jones wrote:
>> Just a quick heads up: the rc0 build on cygwin has a flaky test, thus:
>>   
>>   $ tail test-out-2-52-rc0 
>>   Test Summary Report
>>   -------------------
>>   t0610-reftable-basics.sh                         (Wstat: 256 (exited 1) Tests: 90 Failed: 1)
>>     Failed test:  29
>>     Non-zero exit status: 1
>>   Files=1024, Tests=32232, 2703 wallclock secs (23.38 usr 60.53 sys + 7886.88 cusr 10419.88 csys = 18390.67 CPU)
>>   Result: FAIL
>>   make[1]: *** [Makefile:78: prove] Error 1
>>   make[1]: Leaving directory '/home/ramsay/git/t'
>>   make: *** [Makefile:3327: test] Error 2
>>   $ 
>>  
>> Initially, while investigating the failure, I was running the test by hand and it
>> didn't fail ... So, I tried a stess test, like so: 
> 
> Interesting. My first hunch is that the root cause is auto-maintenance.
> git-maintenance(1) spawns `git pack-refs --auto`, and that process will
> open the stack so that it can verify whether it needs to be packed or
> not. And Windows being Windows, the file being open may mean that it
> cannot be written by another process at the same point in time.
> 
> In any case, I was able to reproduce the issue. But disabling auto
> maintenance with the following patch does not fix the flake.
> 
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 3ea5d51532..52bbf4fe57 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -204,6 +204,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
>  	git init repo &&
>  	(
>  		cd repo &&
> +		git config set maintenance.auto false &&
>  		test_commit file1 &&
>  		for f in .git/reftable/*.ref
>  		do
> 

Thanks for looking into this - yesterday was unexpectedly busy, so I didn't
have time to look at this myself. :(

I also thought, briefly, about 'git maintenance' since the error seems
to happen in parallel heavy workloads. You probably didn't notice that
the test finished in 45min, because I ran the test with '-j8'. I have
recently replaced my win10 laptop. On my old laptop, the non-parallel
test run used to take 6+ hours. With my new laptop it is 4+ hours, so
it is still a long time to wait. However, the 'meson test', which by
default runs the tests in parallel, was much faster (about 80-90min).
So, it was worth a try... At the moment the parallel tests hang about
half of the time (prove hangs right at the very end!), so I am still
experimenting.

[snip]

> I wonder whether the issue is surfaced because we use the shell to
> truncate the file. If you instead use `file-tool truncate 0` for example
> then I cannot reproduce the flake anymore:
> 
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 3ea5d51532..1058f83993 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -207,7 +207,7 @@ test_expect_success 'ref transaction: corrupted tables cause failure' '
>  		test_commit file1 &&
>  		for f in .git/reftable/*.ref
>  		do
> -			: >"$f" || return 1
> +			test-tool truncate "$f" 0 || return 1
>  		done &&
>  		test_must_fail git update-ref refs/heads/main HEAD
>  	)
> 
> But this may very well just be due to timing again -- spawning the
> process will be slower than using shell redirection to trim the file.

I tried this patch tonight, letting:

    $ ./t0610-reftable-basics.sh --run=29 --stress-limit=10

finish, which it did without failure. So that's 32 * 10 successful runs.

(I had expected 16 * 10 yesterday, ie 2 * cores * 10, but this laptop
has 8 cores 16 threads, so 'getconf _NPROCESSORS_ONLN' returns 16 not 8).

> 
> All of this is quite curious. I don't really have any better idea than
> to use something like the above patch. It's ugly, doubly so because I
> don't understand either the root cause nor why the patch properly fixes
> it. So I'd be grateful if anyone were to enlighten me :)

Me too! :)

> I have verified that the flake already exists in Git 2.51, so at least
> it's not a regression in the current release cycle.
OK, that's good to know.

Despite the mystery, I think a patch based on the above would be
the best solution for now. (Assuming nobody has a better idea).

Thanks.

ATB,
Ramsay Jones

