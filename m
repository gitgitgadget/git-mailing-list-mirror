Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108377;
	b=wCtDOUy0D4awPImNqzF7e1TWvo3++24mwxqsWc0Rr2bnhs/696PtBgPqjARHNh5Po7kw
	 zWFHqN3amUhPjzndru9RkBDItnzo+V0agLgbaXQn5obvTMLF8ubWrSTGe6ftbW3caxpcy
	 Wg+3nC/1x6AHdF3sm/4TUQ7uIXr4fvpGTSJ5h+OUu02ZPhJm1pkLIbIgmIhUzQoQQyGYr
	 4Ms6sBDUeOTQQUbYsryZ0M2iTXm/vXv0g0ee3kisG2nUS5x69l9WgsJU4yWdPe8Eqsa0b
	 DwJtFyOUwEQeXm2W3e5hccCAcEg9yg9XIQYQVFLgmMgAPD4DecgJPRt0XNqrOxQP+QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=J/xzTUpXbR/4Dq94rVUFZesmbiQBUTr4Ii6RvX0loRY=;
	b=2GKVkX6voj+Dpn6ChCKnnUzJdmjVBQm6bPsyTD4bAQew8yYQu9ZIx5ZWPCrKWbi/bS2G
	 Pv7nUFN2+6vgzCpBzrYPFKaGWBC758qe+lKGp/PBY475qO6Q7gtYa4bakfZiQy1hoQ05m
	 AXsCxLrynXrfYmHaHlCgf/YukLkKHguQy1S7ZnYLu7XhLTnSIjAj0l9s/zByh2C1Lzzf/
	 oj++j6yyo37PlVAnOUt/z0IElVwM6xZx7iSbcmKZ4n6xpZjn5sAS85QhmiSTk7JXBH5//
	 b5Fn+PyHb+amZdT8UnYPM2Sphl3JNShrAHx1boA3+byg9tt9DJ+bcH93fSzUGX8X+eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSije2gs;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B3606A61D
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:12:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B9B3606A61D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QSije2gs
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1b244fb7fffso2534876c88.1
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108376; x=1795713176; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/xzTUpXbR/4Dq94rVUFZesmbiQBUTr4Ii6RvX0loRY=;
        b=QSije2gstIp+LiSHTj8hzzdcpKtPbR5kPJ5cDF6wG9KO0Kmje218x97nJYv+Ye4vP/
         /DwdezRExBk6miXsk89cwF9CLQZj/VGV1b0z6GXXy4mm9aFk6a8s1vCc0a2pLKeDhQ1T
         uIVahtvCO3Cqs8W4ikPetAzLRTPvlFp1H8Rvx6tqhBbRh67+vm/GNUr9HTJVd9hbK00I
         5nytyiUe7rDbfp4opwBrKpKUoelWdNAjYddIwMqKBghlZWmy4s5XoT+xBOg7qs9CTAna
         P5PNOzpMjFBnO2Ul3fKPx2AMtCMssYqH++9n+m0EMnuARJz3toYSuMOS8D46mjk+uWOJ
         00iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108376; x=1795713176;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J/xzTUpXbR/4Dq94rVUFZesmbiQBUTr4Ii6RvX0loRY=;
        b=vxaPtQ4p2YOkeaKde+mVyKn6eCXX30xTLZpxHu3cgnu6XtPMqCkmYYS3K7FGnO8xEH
         FVcjFPpqlJ2Ehke4au1ncqkqqQsLyZxGgBHIqQlbUbwRWw9kL18ZaHdHeAP9Zpaj8ZM/
         Ff3j3bxGxHSXv27qmBA/JCCY+nlcfkBygUSyCQlj/c2d0Npt0doBYqxrPA1L/Z5de8Qs
         p+Q9LLls2lzATTpcW8ah/9QF6LYij8jC3ShdYNK+Z7u6vetzybd+2Y/aAykuFMbo6y2j
         6R5edXtxZ5y7yOFXQ+CX/GATcvUghaAuZj+kLS1CDKtg/rlwbmIZsqPpO9Ob+LYAodEg
         +q7g==
X-Gm-Message-State: APuU4Z8VUa/7OI8z6ivAXvDNoLeKNnxvFrIrvzvwpDIjtHR6P2Vrj6o7
	ofEGFZPI+ldxobmaykS3LAxnZWrHQed0yEz/LAAz1hvObuxh1TR/55thxcrTaA==
X-Gm-Gg: AYBFou3PxI7oulzCnxu5mOzdxvqZjKvL6jsMUZ6rTHU1HLMkFRUsA4zBoDUMBF+Az19
	apcsFxDI6uZkk6EDu/LrIL9WebXhaVWM/nKXJwsLOtQ5ZLLUtyXsd0Ap37KK4ZLBhegGYOqO3Gf
	SK9hTvGh4QMdYA5yENJX5xnBPHxzDzjrnVKqpX1sY/SVb74e/gzZx52KNpM2JD3ZyxfjVsWYK6Q
	VFATiAS6YdK1pExV3/h1Tgpxg7DnxxNvye8AllIeVi4sMvBfEnbyQCmfhFUJCcAvuYkwCI15M4z
	aM8d04CqiNh8he5FMtgdiW17PZMUc3o0qzRpzDyqlhROR9a18JfeIT5LpLXObrebKbVT5FJzmEy
	lGPS4G2ILENMAMIcHH2ytAeLzOZpz7Ibw3g4DtDKXwTQdfMkPhfpXOwpX+CpNHGB7Hbr0N/UlME
	Zac0eh1ekfnOnxNdjhwuEAR4AtG90HgYuAjB4//4yqYcWdXTf99tsYfna+aE4alTEO0GPzzGd6b
	w+k4MHh/692g/U6G9o0gSt+siwn0U+EgHG9etPkdmgD1Llf2WM7/5osn8b8J4kszsgQPEtfry91
	KZ95vqihPbd6Oyrp4SB7+9T7mZcZSJ54WVWyJJ39
X-Received: by 2002:a05:7022:b058:10b0:1b5:330f:6209 with SMTP id a92af1059eb24-1b5568a32damr254780c88.20.1795108376379;
        Thu, 19 Nov 2026 09:12:56 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5567e495bsm788704c88.4.2026.11.19.09.12.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 09:12:56 -0800 (PST)
Message-ID: <3229c599-bdae-46ef-bcad-9557965b4b43@gmail.com>
Date: Thu, 19 Nov 2026 22:42:53 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test-lib: run EXPENSIVE tests one at a time
To: Patrick Steinhardt <ps@pks.im>
Cc: Git mailing list <git@vger.kernel.org>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
 <av7KRbOGWeV-Qof1@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <av7KRbOGWeV-Qof1@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 15:37, Patrick Steinhardt wrote:
> On Thu, Nov 19, 2026 at 01:10:31PM +0530, Kaartic Sivaraam wrote:
>> Recently, we've acquired quite a few expensive test in our test suite.
> 
> s/test/tests/

Corrected it.

> 
>> For instance, these commits add several tests that require
>> multi-gigabytes:
> 
> Multi-gigabytes what?
>

Fixed it!
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index c56654b7c5..4d29172c9d 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1089,6 +1090,42 @@ fail_117 () {
>>   	return 117
>>   }
>>   
>> +# EXPENSIVE tests can need many gigabytes of memory or disk, so two of
> 
> s/can/may/
> 

Done.

>> +# them running at the same time under "prove --jobs" can exhaust the
> 
> I wouldn't single out `prove --jobs` here, as we know to run
> concurrently without prove either via our plain Makefile or via Meson.
>

Makes sense. Will remove the part mentioning 'prove --jobs' specifically.

>> +# machine. Allow only one at a time across all test scripts that share
>> +# this TEST_OUTPUT_DIRECTORY.
>> +expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
>> +have_expensive_lock_=
>> +
>> +acquire_expensive_lock_ () {
>> +	mkdir -p "$TEST_RESULTS_DIR" || return 1
>> +	while ! mkdir "$expensive_lock_" 2>/dev/null
>> +	do
>> +		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
>> +		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
>> +		then
>> +			# The holder was killed without releasing the lock.
>> +			rm -rf "$expensive_lock_"
>> +			continue
> 
> Okay, if the previous owner does not exist anymore we prune the lock.
> Two racing processes which try to acquire the lock may race in a way
> that the "/pid" file does not exist anymore because the other process
> has already deleted it. But you protect against that by checking whether
> we have been able to read a PID in the first place via `test -n`.

Indeed. There might still be a race in the case when two racing 
processes (A and B) both see the same dead PID before either acts. A 
would have deleted the lock, created a new one, written its PID. B which 
still holds the stale PID would proceed to delete the lock which is 
actually the live lock held by A, create a new one and write its PID. 
This might happen if a holder was SIGKILLed and two or more scripts were 
waiting at that exact moment, so it's rare. So, I wouldn't complicate 
the code to handle this. In the worst case, we'd have 2 expensive test 
cases running in place of the one we intend.

> 
>> +		fi
>> +		if test -z "$expensive_lock_waited_"
>> +		then
>> +			say >&3 "waiting for another EXPENSIVE test to finish"
> 
> Hmm. So file descriptor 3 points to stderr or to the test output file.
> And if I remember correctly, we're indeed free to write to stderr
> whatever data we want without breaking the TAP format?
> 

Yep. With no '--verbose' or '--verbose-log' flags this message would 
just go to /dev/null. I suppose that will only happen when someone runs 
this manually. So, hopefully that's fine.

>> +			expensive_lock_waited_=t
>> +		fi
>> +		sleep 1
>> +	done
>> +	expensive_lock_waited_=
> 
> Should this be declared as a local variable?
>

Sure. Will make 'owner' local too.

> Overall this is a rather pragmatic approach to solve the issue. I was
> thinking whether it would make sense to distinguish e.g. EXPENISVE_MEM
> from EXPENSIVE_DISK, and have different locks for each of those. But I
> doubt adding this kind of complexity would really be worth it in the
> end.
> 

Got it. Thank you for sharing your thoughts!

> So I'm fine with the approach. Onward to green pipelines again! Well,
> until the next thing breaks next week...
> 

Totally. It feels is like we're constantly fire-fighting in the CI these 
days ...

-- 
Sivaraam

