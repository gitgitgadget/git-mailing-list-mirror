Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082829;
	b=e1Ps0ohC+GpeswCdHZDKLZm/qy/+bkNWZn3qE6OIOJ8QU/1I3NK2T1PJA+ulqueQ8w79
	 j7PWRFwncKZQ//IVeJjJTZzRzzcIgpgBEihjeZU1/uLAbfVhzrMpcBj+Cpasc3d9xiP9R
	 OTvVtbyo/zXETnG6OhivvWy/LPTf1GQbxK7jaVv2Fuxsdhee6Cc5D2jGnP0IXHQRyjVFE
	 PqlTr2VWF5XT0cX/xaT+nP8UKSEwr9hgtbLoBgz1hf0TiNDttal8JShZKy5J2OTBMSFWQ
	 1uBPsCwSufjdJo2wl6RcItsFIiwmdkTHLpJh3jrxwbyBbDhS1KQv7C9/D4ln7WYgPeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082829;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VEqluHHH2f0/XTJQ3L99iSHo7k5gurryhC75HuVffPY=;
	b=kRYWbkyz0ZMX422xACFrly3epWvKbDG1aFjzo1ipPUIYTMjbonPGJQj2WeXnWZok0NVs
	 7csAqzmmLZEtiy6ljCxzLJOCTasrDn0oL8XtPqq1ho+LrBf9VHDtPAO2DuhsVZdGqER5p
	 INfZRPkEBRtuLrOStfoUXSrYr7ZUGErNNpji5FfrW/Db5yCJ4e4425xQHY1lg+L5IKKU4
	 jRnAI5xiPWtZp2WMvN87Hefto+2ggCtK1LscTt6Hunk8aDw3xu9qf8ewtNW/QCptC/yWc
	 dpH2G+kkeTA8kGbl3mYfFLQHM3JS2RrBod3LlzF+Bl8Qbmo54PViAEmbfC8cPo3PhUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ELF9w52N;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zVLn407u;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F42606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F42606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ELF9w52N;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=zVLn407u
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 1B0FFEC022B
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:07:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 19 Nov 2026 05:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795082828; x=1795169228; bh=VEqluHHH2f
	0/XTJQ3L99iSHo7k5gurryhC75HuVffPY=; b=ELF9w52NwDHLaZyRp98dGkr+Om
	YRRuZOJbbVNAgtWXBJoY87qMY1ijBaP7SZiYckj05sObCm2iTs1TFChQaGjTbwM1
	QvLh3k0G716cyJU395a+Ohyqy1fJk40ywSl0MKSQefVDRxY9buV6uFibc9INdbh9
	KRC1SG3yiQnqIZfqDVRzOL+31ohSFicVxzHaDv1xYjwvcsyyZbNL9djzcw38ZVXR
	LlgOFf+QFDC99OXi/jty+J91IBNx+/zzNa6SxYgAgUQrgqQKtsQgi66NmLzOPKIk
	p3RN6dH/VZxOJmZxANSXI3bz80p/rVM7iVABL1eINNKtkIIXrPZFWt7gmx6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795082828; x=1795169228; bh=VEqluHHH2f0/XTJQ3L99iSHo7k5gurryhC7
	5HuVffPY=; b=zVLn407uZH6m55mJAKmbGO3r+Hv/ZAefuSM5MYsqBkmW0FbApDI
	G7fyJtCuTVNncOYGKl+4gD9W7sPmMUWsJJ6fcczj3LYwpxqEq+C8j9608yjCRpC5
	g5YbsyJ4EQP/seCQQigjz1PtW5zu4FVCKjQYdEkEbae/ucazL8cGV/XvrfbpX/f9
	Z1DW7KR7W/H/M8gHFWh3Q6qgXYCH/xAHOqiA8dp5VDMhJ2K/Kiuh8ozgJ8KGcySU
	nzPBs66FRbP6D1nadCTsObtsPppvmsABF83GOqFS9NMfpp1TnbECXTqtKneTgcYm
	4V5w2T7XvzF+/uIP6+1hNmm5t3fU76Vh4Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795082828; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:VTIz/ambwxofbpbvjaaA7sonbvzL852q/zuQ2JPPnZ/hKo3
	BRglvvJtQ9xqLqD6lbheFatijEpwmOx2qQLDAuD5IuT3stBO0DyaWjegmiYzkBqo
	WsXEuSCiCXoRzpLtXz0tgNcCpfdIFOAunfKGMymoYu61+c+yuQCC150xK1tqIpSD
	/yD9vz1slyjgtn2qZOhn2Zz2p4GzNl4YeuaUW/a9ShBQH1e93OHXUWap/+mMo6Pe
	cGitvvKOtLQOyKGnfbeN4wNhz7WW9b+77iWgKDwnz9Vn5E/1ogkjaVNijv0ONUWd
	GUKqNR8Gy0wGdMFMzGhCGYi5P4Rzmd9RsmhHc8w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:le3SK4d6kk4Rq26MhOYiF7FZhEnC3RnvUlNuCqhYIpI=:xr5KWxKwvWWC/Q0fMTSrbjk91iFZxQH2xWrPiuSXMSg=;
X-ME-Sender: <xms:TMr-aiuHYHI_51-1YE0qs78oRih_KDs-oQXS79YSJ1gocDouu_HGrw>
    <xme:TMr-atfOwSr8acJfvz16kuCO9krreTfEM-LaYex5-m-JHOPPwnmimcAwk5cHSISoZ
    8_N7gCA04JjYUQQoOAhbOuvyWuT1uMdZ1wmVMSv0NFjYp4xpHZMh98>
X-ME-Received: <xmr:TMr-arYx16goP8L-KhZ5-nBuouIYNVj_N5JQnq3gC3Mlh9gD4NLCDqKksUyQUcpqlwyYeYo>
X-ME-Proxy-Cause: dmFkZTECyeg1aWG7hrj0fCMNc8UDPOKzhyaLoCRfwNP3zaEvaYdhwD6/HfMyHp4C3FVlPp
    lnTV9aBajPfZk4yjQLeXJ5NyDQMh/QKZoegir0uXvHhrKB0WgCA9KwNwM1r90uxKKNsx6w
    q8dqOIO3afhS3HFKfE1huX2NTWNnhMIR4zww624l1pgQie+sGu3DJAPtONpCdmlJK3f3a9
    2qFRcSZbagzinmhkR5sQjzipC0iOPLVfwsgqG1R3n6ZHq0lnDpSmiVmDoC7+r74NNxzqRL
    mDaoMSvLwAw5Qpky8uFadR0DPeFKOU1dV3Uzk2XzqPsrFfFS90cwYg0i1WmFuAyJFHc5CS
    +H64amU/Wi3jWbhzcSWl4xIF5amzEoZfUMNatoYwKk5xi0QSjARJsTwfPyfiHrdKId3fvd
    Gbt7dTZ0NIvJJUx1753oFUeTSr4+qLqH/Mdl3UU6tWmucoRh5a/P6t4Blpbf1S3zGD5KjL
    2jUEsQt8ODft3LDswY0EKS6vFZpVWaUHAxkHnZyvRTxMVZHtIfKrrhU01yPwiUqE6/t+GN
    CceSx79FFot9tWvJZXNFiR+fvCgP96z9hnobL1EbD12elULgeDxVrW64M/dZX6FljLv4pU
    Vevj3aSa8yDLz3WmXrjatKlXxtG5nNcmFZ0RPTouYRJO6if0KHS81ybdgBZQ
X-ME-Proxy: <xmx:TMr-aoX36wkERerUXOHz76FJ97OSL5zbK8nBMbgQg-pjJmh7Y3tAoQ>
    <xmx:TMr-alhfPKgVVwz8y97XI_Nnog49x-RxG0Smf68r0kSo1AM8WTVsOg>
    <xmx:TMr-auWTFbKSeINdAqUVLyS82PmJ3hEd8B7RjgrWZT0jRw4e0iZIzA>
    <xmx:TMr-akNpwP4NL0UR8vOeEYZAJgsRF03YPXHh02fSOrpFVHiIVy8vdw>
    <xmx:TMr-ate8zuC3F3fCEbmIu51-wWE1wkOBvcO-dV_JRrjV-_4y18Ppd9Jy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 05:07:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 34e7725b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 10:07:05 +0000 (UTC)
Date: Thu, 19 Nov 2026 11:07:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] test-lib: run EXPENSIVE tests one at a time
Message-ID: <av7KRbOGWeV-Qof1@pks.im>
References: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-ks-ci-long-test-hang-fix-v1-1-45c2fff6d9f0@gmail.com>

On Thu, Nov 19, 2026 at 01:10:31PM +0530, Kaartic Sivaraam wrote:
> Recently, we've acquired quite a few expensive test in our test suite.

s/test/tests/

> For instance, these commits add several tests that require
> multi-gigabytes:

Multi-gigabytes what?

[snip]
> In recent times, we've been noticing the sanitizer jobs (linux-leaks,
> linux-reftable-leaks, linux-asan-ubsan) hang and fail with timeout in
> our GitLab CI runners. On some digging, it turns out that this is
> because of multiple memory hungry tests running in parallel.

Yeah, our pipelines are currently a mess because of this, so I'd be
really happy to have this resolved soonish.

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index c56654b7c5..4d29172c9d 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1089,6 +1090,42 @@ fail_117 () {
>  	return 117
>  }
>  
> +# EXPENSIVE tests can need many gigabytes of memory or disk, so two of

s/can/may/

> +# them running at the same time under "prove --jobs" can exhaust the

I wouldn't single out `prove --jobs` here, as we know to run
concurrently without prove either via our plain Makefile or via Meson.

> +# machine. Allow only one at a time across all test scripts that share
> +# this TEST_OUTPUT_DIRECTORY.
> +expensive_lock_="$TEST_RESULTS_DIR/expensive.lock"
> +have_expensive_lock_=
> +
> +acquire_expensive_lock_ () {
> +	mkdir -p "$TEST_RESULTS_DIR" || return 1
> +	while ! mkdir "$expensive_lock_" 2>/dev/null
> +	do
> +		owner=$(cat "$expensive_lock_/pid" 2>/dev/null)
> +		if test -n "$owner" && ! kill -0 "$owner" 2>/dev/null
> +		then
> +			# The holder was killed without releasing the lock.
> +			rm -rf "$expensive_lock_"
> +			continue

Okay, if the previous owner does not exist anymore we prune the lock.
Two racing processes which try to acquire the lock may race in a way
that the "/pid" file does not exist anymore because the other process
has already deleted it. But you protect against that by checking whether
we have been able to read a PID in the first place via `test -n`.

> +		fi
> +		if test -z "$expensive_lock_waited_"
> +		then
> +			say >&3 "waiting for another EXPENSIVE test to finish"

Hmm. So file descriptor 3 points to stderr or to the test output file.
And if I remember correctly, we're indeed free to write to stderr
whatever data we want without breaking the TAP format?

> +			expensive_lock_waited_=t
> +		fi
> +		sleep 1
> +	done
> +	expensive_lock_waited_=

Should this be declared as a local variable?

Overall this is a rather pragmatic approach to solve the issue. I was
thinking whether it would make sense to distinguish e.g. EXPENISVE_MEM
from EXPENSIVE_DISK, and have different locks for each of those. But I
doubt adding this kind of complexity would really be worth it in the
end.

So I'm fine with the approach. Onward to green pipelines again! Well,
until the next thing breaks next week...

Thanks!

Patrick
