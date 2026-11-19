Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795109616;
	b=ILj4aij8ncWTfH4fnu/xWVBNxtGoVX8VtYBE61ruRtVQrRbrhF66UtponFRenKhHjeJl
	 KvGxp/B2WOks26j3+BJYYe4hHaUwm1sIWstKkTK/0bWOpbo1awSDl0KFjfGMuvZXK9BAg
	 irRceKu4O4nyvBmu2YF7F+Dt+IUJ4thcbJNEM6HYuD+EPPVCFNTcI5bqHZ4bdJvVCV/X1
	 /0gvPcyVSowPUzpQY7D2WhgaYJiz2bqG108wMKr5o6OIgvcFaNTIr/GKwpYVdT8P/LTeh
	 Zm6+zk6roer/i9f9yKWrokaq2Z3JROZPsXfmAVciUAAcArG8m0JX53phuox/RlEQ4Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795109616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=FQEYvXYCrnNqpXxxeEv8N7s0AfvFkJKd0UqdTB4BpoM=;
	b=aWuJW7IT4Cz61uskfMCKYxbzKvhlMVq+CVZrcIqzsSFgb25VrmMpACJQJr8nSLBLLJEc
	 kmU6T6l7kuIi1o+o3SPf3qs/V/a3GrlTziuyDah3S3KPlSwuxWpIypWSi07UuSmRJH9w3
	 bXFZLgSGK7t/LRHCp+fB2EqQRfOHY0GOsgmCgR1dh5L5lVVH/odlNIebbyMg/nCGuzwIf
	 O2skP5s9XTO7/6i+ospkBA2M2z1Pa13A8JEGB2A2lBj9b3CZ1/IevtMWVwe17gCVjvzDa
	 iENfhrshYE9oypwzxi7M1pOpt4PS580LJw1X3fTfQIIa7wXkD8gT6YKZ4FHWk7M6pdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T0mBzL22;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CC1606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 17:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T0mBzL22
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cdb628232d2so19450a12.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 09:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795109615; x=1795714415; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FQEYvXYCrnNqpXxxeEv8N7s0AfvFkJKd0UqdTB4BpoM=;
        b=T0mBzL22hiZrpm4h0//FoElmM3C6pVCxTIwmPSIWgetD9KQkf7pNdLebs5NW1O4FnD
         P+iMSyviOpk8i6qRoFpejdfLyhK5Wt5V6QTYwbMAAEi/nd/7uz1feMjKF+ohO33N8TLt
         hunSGV2J0LT09KWR0hblAH41RtTFqmykLUzGEFL6MKvvH/56BnfE5MlvJmqNNxeyzydD
         6cQAq1hUiP1TGawGZZEXx68886SsXzr36QEQJWvHAF6sPdR2suPej8OZJh/lehBtu5yU
         A9JUek20O/4yAzk1eXPTh2gFb4UwexTDeaPK8qPM9BezmO2xyMbK4yVLRqYvP5NT01j0
         Qxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795109615; x=1795714415;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQEYvXYCrnNqpXxxeEv8N7s0AfvFkJKd0UqdTB4BpoM=;
        b=P4j/IWnx8EduSVjvUFmGEwPpSD/wOoMpB7JIZNIcMcXJfuzV7rqIKuL3VAjq7YZ7X8
         TkOHoxCychwoYyY/P5Dfc3mtiXQ5CrWss0/nwQEWUvsKQiqkAgv0ktaVoKyw66z0Vywm
         Z9OMula1iOTHQTJXfRWpZGE0Vb2lD7UW5R5wG8JGwSo6yFR0RcGN0+Rhgg8ZQAjRlY6t
         ifT3Gf5ujlLPqKCjRQKvbVDuofZLsa8xfq68gMNyIvaBXqKALInJBJ0mhXJZTaPMkbUE
         v3NlGTYnu8U8oR00v8vajF1b7XkM6zpLVostHQ9iQcI9lDqFWMyLuGhtntzD2M/TddFh
         lBRQ==
X-Gm-Message-State: APuU4Z86Se/GEV2jMY7PDjM4g1ec+xO9NeTBCwFhh+B+sjKapOhTLXUW
	K/PbICUbmMjn9jis364DVR3XsyflcSMrOrqos2RtHDa+rlwmfItAOaWnI7MVsg==
X-Gm-Gg: AZFdTZeTbv82D6x8t//iY+T+10+yfVukiiD49BRze21y3v3YiXypfdEOOULkcKUrNR9
	B8KtR0gU29X85Mvcwmla+U9mLvGzJvAxGh9u/pqqpse5o+ukkvHcDW43kfMtjPIzw/Gw0bd2FjK
	jxuM2BWQRYKvjir6xgAQpLRsZd9rbptTPuD+M/9qD2XnOPQKcyQz52QqzqiMIpFws0qTG+y340Q
	Xg65e/1cTmHnVbQcGLc8C6cc64HXfTZA7nwwaf2rxCRZek27D3pGOjJe/Qc/Mj6Xr0ROszEUT3n
	Q+OrXVlDjU9L28cstkOqnSoJUDboaIC8yOAjtB0tIeSiw/68kxHCezezMBMZltHkYRgxXRQWde6
	Ka91JwmUzRhTF0hZItI951j3bKoLTmf+z87Hznmw2tRPa52gYg07GpnPisHIPCps5V8Q87M+swt
	haC+8idwJS543LtjAwcmXtqoH7fORwwCniHL+Wt9bB7E0BVPlu0KcFOtw/aeqVxhzKntlJBMk/Z
	gCUMPTd6KD9zktcSOk6Uq25kE4ZYL5WPtiGUabOtB2EwPAyeMzHlbWM1OyDKDuT4UepDDuh2tyM
	H9ILcgt+P1Ft5uxugZ+01Cf9WarVyzMfJtaVpJ5K7K5idGOsOeVng0hmjswW1A==
X-Received: by 2002:a17:90b:3e81:b0:3ad:6090:a190 with SMTP id 98e67ed59e1d1-3b41c9559f5mr56549a91.41.1795109615338;
        Thu, 19 Nov 2026 09:33:35 -0800 (PST)
Received: from [192.168.0.11] ([106.51.27.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40a878d50sm2716658a91.11.2026.11.19.09.33.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 09:33:35 -0800 (PST)
Message-ID: <2bcce580-f5ed-47e9-bd3e-1e238eb90d5c@gmail.com>
Date: Thu, 19 Nov 2026 23:03:32 +0530
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
Subject: Re: [PATCH v2] test-lib: run EXPENSIVE tests one at a time
To: Git mailing list <git@vger.kernel.org>
Cc: Patrick Steinhardt <ps@pks.im>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
 <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261119-ks-ci-long-test-hang-fix-v2-1-37011c08380d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/19/26 22:59, Kaartic Sivaraam wrote:
> Changes in v2:
> - Corrected commit messages as per Patrick's suggestions
> - Tweaked the shell function comment to avoid mentioning 'prove --jobs'
> - Made the owner and waiting variables local within acquire_expensive_lock_
> 
> Link to v1: https://patch.msgid.link/20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com

I thought b4 would've included it by itself. Anyways, here's the range-diff:

1:  f0664ff4ee ! 1:  fbf773f39a test-lib: run EXPENSIVE tests one at a time
     @@ Metadata
       ## Commit message ##
          test-lib: run EXPENSIVE tests one at a time

     -    Recently, we've acquired quite a few expensive test in our 
test suite.
     +    Recently, we've acquired quite a few expensive tests in our 
test suite.
          For instance, these commits add several tests that require
     -    multi-gigabytes:
     +    multi-gigabytes of memory:

            - 9048b48fb (t1600-index: add expensive tests for over-long
              tree paths, 2026-10-16) added tests to t1600
     @@ t/test-lib.sh: fail_117 () {
       	return 117
       }

     -+# EXPENSIVE tests can need many gigabytes of memory or disk, so 
two of
     -+# them running at the same time under "prove --jobs" can exhaust the
     -+# machine. Allow only one at a time across all test scripts that 
share
     ++# EXPENSIVE tests may need many gigabytes of memory or disk, so 
two of
     ++# them running at the same time can exhaust the machine.
     ++#
     ++# Allow only one at a time across all test scripts that share
      +# this TEST_OUTPUT_DIRECTORY.
      +expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
      +have_expensive_lock_=
      +
      +acquire_expensive_lock_ () {
     ++	local owner waited=
      +	mkdir -p "$TEST_RESULTS_DIR" || return 1
      +	while ! mkdir "$expensive_lock_" 2>/dev/null
      +	do
     @@ t/test-lib.sh: fail_117 () {
      +			rm -rf "$expensive_lock_"
      +			continue
      +		fi
     -+		if test -z "$expensive_lock_waited_"
     ++		if test -z "$waited"
      +		then
      +			say >&3 "waiting for another EXPENSIVE test to finish"
     -+			expensive_lock_waited_=t
     ++			waited=t
      +		fi
      +		sleep 1
      +	done
     -+	expensive_lock_waited_=
      +	echo $$ >"$expensive_lock_/pid"
      +	have_expensive_lock_=t
      +}

-- 
Sivaraam

