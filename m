Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527288;
	b=WAMl/QmQxYWN1TlQuG1VHdx18cjNxuJOBeeoLEuwNwhFkJh4cyjLWQibXO7+MLm17ic0
	 +dAvbTELTB4h3Xf01UMh1r9DynXaUIpzmsptCBEEHz7Y+0qRGX/OHo5kPjh52IS2PSi8D
	 rtN34k+fcpCYVawAz3aGOQeUOeLWX3ma0OYZnmJTEVb2Jd8jcADv1/rg/zgdCZNIOPAWj
	 2aBG54k9N8BLkk/jeov/hZKlNwUCY+++LvnO0rKThILWtSgQLFriGNKUgX8ILSNYVEXl0
	 Qloy1ISnfWWXeRBwTSFJmsKhKZpCsvXQRZkaiPJo5aKOJtan1s8xQ/n2+IQDoNFJ4sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=7Rj4ztL6KFNV1sKJ6EMuubW1KAo4jZQWARCFzo54Pkk=;
	b=k2unYVotXhmkyuPzn4mtlwlSzNHEJRd451hrqAcCUEdpp6Mvsc+kaKyKBj1osRbE7BOu
	 0r5YJfo7GO77JFNPc4X9pHgv5Bwysp4NpNJU8Kpy6k/mRUi23Nf/K4Vg7lFvuoAgv9ELG
	 zd+y2pAESHNH3UtaOuLtFsvgo23+WI8Ct6h+JiIuOgbNfc6FqM7oBIoGhuzmWkLx/w0zv
	 FRrXm0Q4zheVHldkIf8m+PVK/67w3O+0wfgXcDq/P1PFnsfIrqbnW4BQsyDwjhLkGA6Gx
	 1hSzLtJcl2GVxSRoUrqE02AVPN0OJlLdR/biykFg4gPNKAu46qXUmD76K6Q99lI91yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifi3mQH0;
	arc=none smtp.remote-ip=209.85.210.41
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19DC606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 13:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C19DC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ifi3mQH0
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-862df509d48so3555959a34.0
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 05:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795527286; x=1796132086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Rj4ztL6KFNV1sKJ6EMuubW1KAo4jZQWARCFzo54Pkk=;
        b=ifi3mQH0JhEQnTOgK3ymBOrqVawrIMAHUnYHea145DCBr+DKDWtEuX0q+jxAxqZsuV
         ya4vzN44FO/WSCTyxhBrd1E1dNmJuRbWh/pTaBmL5Ii9Mgpf+XJPmZZIfsdpuvxyLKXE
         AYIFASGnOKrwqF4gS7o7UMK+HtCqljmy4kp/Z70mE1qpOGRLWgj24pYpis08Zjg6KVow
         YsW45q/OUWz3hzZhdggG6ggc5hoPlQ7DkLUICQ9rKAEcYbfo57hOtP7hqZhdZX1SNDeo
         4CZbJ4Yt8VDXe76eRvxI3QaNvV9Bwtl2UL+CeKgC008+2vxIXmzY8eid3lfpXjXV8zj1
         w9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527286; x=1796132086;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Rj4ztL6KFNV1sKJ6EMuubW1KAo4jZQWARCFzo54Pkk=;
        b=Y0SiNZUE9kioVv4WTUJ91nuA4aSUo4+d1Hh2JPA3cOYFdlKkzI8z+YIx9HM8DZ/bzF
         tlHer8aWTM765K/NWrIqa+AcpYR/ijnMQUZ4ymPxdwIX1dmqJjBv9Lh6fvLQZSWdhdPd
         ZWraZNPuNIWEDaBBJEU96/CGbJF1CysLJ5u9B7C2ruSdMo5Up8w1Vc/sDwWHABWJWMR5
         wL53b8X9zpvd5kiPb6qEe5xI+N+wBKAcwQH1nCDik8sPuxXABQ0L8e9g4L28uGFSfd8M
         TIluBkZQ/Psum31dOfDRjPAJ9x9MRybNfxGkZ8oPobI8bAOtzacdg5l2MTnqCiQ4JHNd
         YAIA==
X-Gm-Message-State: APuU4Z887VKmPDGiYHz9AUb6/TMp+50HDC2Tz7WhNmyV8j1PcMEEGY9x
	3neszXnhy4wj7uIyyg6L5c+NvgGAQAXt64JwHCvJt4KqG9KdFf35uJppZ/XMOg==
X-Gm-Gg: AZFdTZeeHZkYnrfsBOMOZH1wiqpqNJZwlEL/KrWkJz3kV0Zh8JL5IGf0EXYJXgpz306
	RiIf87yASFEmYFEb/GoG0O+5IGSn4MdRFvwgEFhHaAB69vupDl0FObT2PU2FKoToYcrGJCqiWuk
	qSu5vzPTPlSy6CDMk5VvAWv18QgTxebD9tSNRjdQVyPvIDOKb0RVU5XtF9Mtv+4VuiZ2AFwL0d7
	pAykFH6mKABkER3IZAAi/PBmqpNfjX8ciDDTmOj5zovQ2cZ+Tkla9DPOuU+pmouqrpQi5Vw618P
	G0XDU0Pwy535fo4K62HaPrDzT8jLXDNDDjejR0JDIPvnYV8nddYKVYpLECuPrZCtQHalbmx6SM2
	4VN61ZN8S5OpztishuhO2B2zmSfjFhh9aBwZCI2718M6BUs30I8hF7MHi6/y09qoOV7va1nriXg
	sEHkR7gIxjpTYXDa4DiXyvnLJkE6BT9um6m9dWur2bk72zyWqp0316OEPUsqcMRQGq0vPPLA+K1
	55IPGc5nKmK4U51heMdmmAQ6qSDF994pOvtB2vOZApHlJ8zttsyz+0PCygCV6M29TWj99B/kvKd
	ktaak6ZUEqAd96KN0fTUIpMmgDgje8uL8Fwv44nQlV4LhcfjV+MvHEYYr6rtmfCX26oSLQ5Ny/O
	iJAO1UIRB
X-Received: by 2002:a05:6830:82ee:b0:85b:895:a015 with SMTP id 46e09a7af769-86309065b5amr11885272a34.4.1795527286463;
        Tue, 24 Nov 2026 05:34:46 -0800 (PST)
Received: from ?IPV6:2406:7400:12b:ed80:5733:c0bd:f78e:9668? ([2406:7400:12b:ed80:5733:c0bd:f78e:9668])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-863169105c2sm11479791a34.21.2026.11.24.05.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 05:34:46 -0800 (PST)
Message-ID: <781ae43f-7831-4aa7-a7a0-aee069950eac@gmail.com>
Date: Tue, 24 Nov 2026 19:04:41 +0530
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
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
 <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
 <xmqqpkw0rp8i.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqpkw0rp8i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 11:58, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> Recently, we've acquired quite a few expensive tests in our test suite.
>> For instance, these commits add several tests that require
>> multi-gigabytes of memory:
>>
>>    - 9048b48fb (t1600-index: add expensive tests for over-long
>>      tree paths, 2026-10-16) added tests to t1600
> 
> No such commit X-<.  Perhaps 89048b48fb (t1600-index: add expensive
> tests for over-long tree paths, 2026-10-16).
>

Indeed. Sorry about the paste-error.

>>    - 288266c11d (xdiff: use size_t for merge buffer size computations,
>>      2026-10-16) added tests to t4300
>>
>>    - 55c54fd375 (apply: reject binary patches greater than MAX_APPLY_SIZE,
>>      2026-03-25), added tests to t4141
> 
> Inconsistent use of "," after the (close parentheses).
> 

Good catch. I've fixed it.

>> +# EXPENSIVE tests may need many gigabytes of memory or disk, so two of
>> +# them running at the same time can exhaust the machine.
>> +#
>> +# Allow only one at a time across all test scripts that share
>> +# this TEST_OUTPUT_DIRECTORY.
>> +expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
>> +have_expensive_lock_=
>> +
>> +acquire_expensive_lock_ () {
>> +	local owner waited=
>> +	mkdir -p "$TEST_RESULTS_DIR" || return 1
>> +	while ! mkdir "$expensive_lock_" 2>/dev/null
>> +	do
>> +		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
>> +		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
>> +		then
>> +			# The holder was killed without releasing the lock.
>> +			rm -rf "$expensive_lock_"
>> +			continue
>> +		fi
>> +		if test -z "$waited"
>> +		then
>> +			say >&3 "waiting for another EXPENSIVE test to finish"
>> +			waited=t
>> +		fi
>> +		sleep 1
>> +	done
>> +	echo $$ >"$expensive_lock_/pid"
>> +	have_expensive_lock_=t
>> +}
> 
> Hmph, is the above safe when multiple processes are working with
> expensive tests during normal (i.e., not involving SIGKILL)
> operation, or does it still have TOCTOU race on the lock file?
> 
>   * T1 holds $expensive_lock_, finishes its last EXPENSIVE test,
>     calls release_expensive_lock_ (rm -rf "$expensive_lock_"), and
>     exits.
> 
>   * Waiter T2 read owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
>     (obtaining T1's PID) just before T1 removed the directory.
> 
>   * Waiter T3 runs mkdir "$expensive_lock_", succeeds, writes T3's
>     PID to pid, and begins its EXPENSIVE test.
> 
>   * T2 now checks test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
>     against T1's exited PID, finds that T1 is gone, runs rm -rf
>     "$expensive_lock_", which deletes T3's active lock.  It loops,
>     succeeds on mkdir "$expensive_lock_", and runs its EXPENSIVE test
>     concurrently with T3.
> 

Indeed. That is possible. I think we could tackle this by re-verifying 
the owner before the removal of the leftover lockfile. Additionally 
wrapping it within an additional break lock will help us to avoid the 
race where two waiter threads T2 and T3 both read T1's pid just before 
T1 removes it. Without the break lock, both would proceed to run the 
expensive test.

Something like this on top:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 193bf06aea..a769e10303 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1104,10 +1104,18 @@ acquire_expensive_lock_ () {
  	while ! mkdir "$expensive_lock_" 2>/dev/null
  	do
  		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
-		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
+		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null &&
+		   mkdir "$expensive_lock_.break" 2>/dev/null
  		then
  			# The holder was killed without releasing the lock.
-			rm -rf "$expensive_lock_"
+			#
+			# Another waiter may have taken it over since we
+			# looked, so only remove it if it is still the same.
+			if test "$(cat "$expensive_lock_/pid" 2>/dev/null)" = "$owner"
+			then
+				rm -rf "$expensive_lock_"
+			fi
+			rmdir "$expensive_lock_.break" 2>/dev/null
  			continue
  		fi
  		if test -z "$waited"

> Also, between the time you successfully mkdir the lock directory and
> the time you leave this function, you can be killed by a signal with
> INT, TERM, or HUP, for which t/test-lib.sh installs a hander to call
> exit, and there is a "trap die EXIT".
> 
> You may manage to create $expensive_lock_ directory, open pid file
> for writing, and then get killed before you echo $$ to the pid file
> or assign 't' to have_expensive_lock_ variable.
> 
> When your die handler calls release_expensive_lock_, you would leave
> with the directory behind and exit.  You may not have pid file, or
> the pid file may be empty.  The waiting processes will not run the
> kill -0 "$owner" part (because they do not know who you are that held
> the lock and left before writing $$ in pid), the waiters will wait
> for the mkdir to successfully create the directory that already
> exists and nobody will ever remove, no?
>

That's a good catch. I suppose setting the have_expensive_lock_ variable 
before writing the pid to the file, the issue should be sufficiently 
averted. That's because release_expensive_lock_ would proceed with 
removal of the directory even if we fail to write the pid file.

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 193bf06aea..a769e10303 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1117,8 +1125,8 @@ acquire_expensive_lock_ () {
  		fi
  		sleep 1
  	done
-	echo $$ >"$expensive_lock_/pid"
  	have_expensive_lock_=t
+	echo $$ >"$expensive_lock_/pid"
  }

Of course, even with these the code is not foolproof and would miss the 
following cases:

   - kill -9 before the pid is written: a holder killed after creating
     the lock but before writing its pid leaves a lock that nobody treats
     as stale, so every waiter hangs.

   - Signal before the flag is set: an INT, TERM or HUP landing in the
     microseconds between creating the lock and setting the flag does the
     same thing.

I'm not sure if we need to go down the rabbit hold of fixing those too 
without actually facing those issues. I suppose it may be better to get 
the jobs running with a version of the patch that includes the above 
changes and look into further changes as we notice any more issues. I 
would love to hear your thoughts.

> Between the TOCTOU race allowing multiple processes entering the
> expensive region and deadlocking denying everybody from entering the
> expensive region, the latter is far worse, of course.
>

Indeed.

-- Sivaraam

