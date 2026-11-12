Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441694;
	b=xPziV/PJqY4oiIXKShykieOCBR71KzUmf04QNS8aSD5t9onntTXwF6a+lpNUAsxGwC/9
	 O+Pyj6E6EKu9fvHqeWuMvXLtfj7pvVc21Bmq8m6FbrO4AGGp4EAuKyPqnIvvw+mU9wcg/
	 Jq175eqRzod5p696Sp+TM1xjFfe8DKFKNLoeDZakslsAYk9VmQYV59Nh2fvk6y+pSRByL
	 J7zEQlwuyqgd+3kkUtEMSkInn8coAvgDgmEdMxuZIxqSTTbAyomqoXi3mEfjZ61PpLggR
	 D2uaE5/5AFHx5Hi5IK4hlgr1MD8+sljdmQ6ifCRz7SGFw0pJMysqBsaCRvcEdUxFJFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441694;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=B42yqFbc3yOGMfDBg7SIutzMEoo6Zf3/+1MAwTw2q48=;
	b=E6O+OYqdj1nb4yNoNrFwU10Y2nohMmdP8vOjvSywdW9QKgCgVjw0srop6K/5FAlGlxzV
	 BqfIPkwEq7kNlnMupZhjZ29VovJ4NLiA/UzXs6Erp8Z4KSv50It6zJGCm3lBQVBVDFu2k
	 +8ic5t3+OZtSuUuEa6BLspukA91eOlT1ZOWe8aS4sxY5c6Ue6Qs0BkGEtTbEUiuubRHYj
	 OFzm3OFgrx27LxuSq9WUz4rHkCSWN4almQQuiv/SWXXz8bVTfWBisL/Ll2XL5wS7yojLw
	 ac1FDrqRMwmqLsHn/AltNKDVARZHyW9iFuCs5/9IjC78YfY6jWkp+47jRqFTTYeCq2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=HqVihuB+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="0Ot7zWy/";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4A2606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 00:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E4A2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=HqVihuB+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=0Ot7zWy/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8704140006C
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 19:01:32 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Nov 2026 19:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794441692;
	 x=1794528092; bh=B42yqFbc3yOGMfDBg7SIutzMEoo6Zf3/+1MAwTw2q48=; b=
	HqVihuB+wH9lEXCOSBfvHbABn+mrCTekxT9bmwv2rmbOeowMdhGueESeBLM2NCOR
	dqjk7tr+KN5XEWjOLluNL76Xf6LqIqcXrj5NvqFmtb39GSMebptW75ShlsJ7kf78
	apHCATQOt4Tirbh+3uoAIBvoGi9euz5dXqxmdlfWWO+FI+h4/TGKnEK0bC5cHtTD
	ABJoF9xt2unY52pVlgguM/snsJpraiSChw+ZzWF91YWLFCU6v8vefjC/Sh4IpPdH
	0cIDvpN2AX9o99KusWQIgNx2bhB4MT1ow/P5u9UjsucVQr1CTe+DOGBr2otygQ+E
	QSV7cqKTXkryL3V06jAIKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794441692; x=
	1794528092; bh=B42yqFbc3yOGMfDBg7SIutzMEoo6Zf3/+1MAwTw2q48=; b=0
	Ot7zWy/uZ3AoAs25KTwdVjpp1Ye+yRnOMz5UdmW0c34YwKfExLBINTC33eIprdPx
	tIWaD7LJiNRZsYSEVBKDc/H0baPEyzWLrcBmpcjgX923CzdUzIIvroZp0QuhWg9j
	hf5a1WBUpZwfALIYgk7z8fMvZsQ2ZGQrH47CySkbkYmXMw1RqjKOslHw/9gCStK7
	wCKyxMStTweVn40zOKFWi1AUoi1tztVLPP6PXZt+0yssSzbEfjgWuf1/u1UREyvo
	wHsfWevweH5kwvIx2LfrLUHunWHvY+NLHdLjLUMf7eCNvH6TwdqaOKEhJBPxxqNI
	YoKJI7rPue85O4zqdio2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794441692; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:e2GoJx3iB20WnskU0H5gju7CazQxqjxX+xxk8coqWrUy0Kv
	UCnf2oWcZ9lSxondt7rVi528iSSJLTtKUrp2mFdL81YOaImtHVpaS0z60LFsh61q
	6llJk18DgoTY21G3XQrZWouMZb31k8/PnFI7BpOlioCoqORze668shjfeCxo1XMQ
	ulYDgNrQjhBbPxeNgm3MZA+GGih3/EjHQ4JbrcXMH7DIBWWrAgdWpLnLyE80UAMe
	2a7Df8HWxh05er/1io2rKyCOAUM6sJnWUwYNPgq1eFD+veRyhdaJ6HfGrFJrZYlw
	NHLDuhqxo5hHQlP1CgVZqtPelhrGDa/u+xbSpjg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=14;
	hn=cc,content-language,content-transfer-encoding,content-type,
	date,feedback-id,from,in-reply-to,message-id,mime-version,
	references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:b7VB2bVq8WIihoMsaN4hKBjSGThOrPiuwvWDPJ4CCYk=:IqVKZPWngZTcSzJaEOLUOHAPqza2QZps8UICviWSuTk=;
X-ME-Sender: <xms:3AH1alHy9KkeWbJ81gtlFOpIATq6fZ2M2q9ageod1t-_H5A6IGHjVw>
    <xme:3AH1ahPZ2Co-p6NedULHBPf86zVn_EJS8K9E8_trsEIoIY3JxToWx3Vy5Wnc_3lE-
    kWri6T28VCc0QnUAPs_AB7kMYmTanavAWtzgJ0aEoNu5Zy1snMJBJTX>
X-ME-Received: <xmr:3AH1avcR8kvU1qflZTzaRhytMUgVEylt6TMD5eXVP_27xCIXQvGQNMPhTIx7XdzMaB13wYtxdcKr1sw7I2u7XeXvpi0ymt-fdvN6yhpH36IrbTbydg>
X-ME-Proxy-Cause: dmFkZTGPK//ZTvd1lJzRp9YGATRPunJRR1Vgi4UosVMn/8fD8Q5KHoHuugQ6qmD1GbURqx
    jJq/6XbDIZjr4gfVIOr+c0i+N6fYS9z0NFpFUfF4BYLFbxqDCFAwLrKDusO4/02WUCkGcz
    nm9zSLvuJv8szw+nqmCQqc8HqXmxOX8mn9XUDAXqzZncGPCdd+2+sF5YunENJ2ro0ta/kj
    lfq6jY3QN2GHZHc5TgNJGJT8G0DlOmebrD2zUT7HgJQVlI9QaovREA00pDnfOH/xNI+utm
    T3nbIPcu2aEl9wPJwYZlQcfHnuY+bx9rOMBj1EbhYNIsIiiXirxV3WUZxAUgJiGi/uBaVI
    UPYTO+Qqi6Hs804awaf8fdEMgAvJwo14Zr1s8UjaXnKv2BrDHMQ4ZArWBTm2odNZV3fqrx
    ERhBTlfYbX3reQELllo8E2/jQc7j6dxPVO8MgSQ4yiqe5GLY9V4/eioXUUAbhWfYLHZoCC
    EYFAvpKmh0apKMASTciFk3yWZEWuSI6aLCBANdHOt0nf3CPe+eRUwGFblwdHdR6Bx6EUNw
    veZ19GBezV7tIwcTgd21FBX2R/LT0Ka2SRZtqbQwj1DZZk+TVM4fyhtT+NqVJ7kvOQzv27
    6qNyJquPb189FdqVUVJTkl3gPcwnPkUb3O7IO1f+SnUp/Eyv1P8J0fEBSH+Q
X-ME-Proxy: <xmx:3AH1amu6ihmm35lB7wxFzMEd94RRHUn9FxE1M0y7oP9X3e1UApwuKA>
    <xmx:3AH1aok-R13_YE9TGZ7ciWpp0kWDssQRBH-Z8I8kHGmF4qVwIb4vOQ>
    <xmx:3AH1agwQzTFdc9hfQHxF8OeuH-9aj-S-jCyjCNLn_IZdYQKIgeo2kg>
    <xmx:3AH1aiPlA_oaY1551mrFmvmg7BTWhwJHbDqsNnr7RiWDLpyskoxWEQ>
    <xmx:3AH1al8wJ_Qy4ZU9ssePnDk6usjy5gQff0magq199MBDqJnh057OTPnm>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 19:01:32 -0500 (EST)
Message-ID: <03a0b42a-08f8-4b9e-9dd9-9caf3fc5f7e6@jvns.ca>
Date: Wed, 11 Nov 2026 19:01:31 -0500
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
Subject: Re: [PATCH v5] doc: checkout: rewrite detached HEAD state explanation
To: Junio C Hamano <gitster@pobox.com>,
 Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
 <pull.2250.v5.git.1794432869488.gitgitgadget@gmail.com>
 <xmqqqzgrklkh.fsf@gitster.g>
Content-Language: en-US
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqqzgrklkh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-11-11 6:14 p.m., Junio C Hamano wrote:
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +current branch. Internally in Git, `HEAD` can either be stored as:
> I am not sure if I am the only one who finds this phrasing awkward.
>
> It is not like HEAD is stored (in somewhere) as something.  Rather,
> HEAD *is* the container.  Its implementation may be a file on the
> filesystem in reffiles backend, or a record in the reftable
> database.  In either case, HEAD stores the refname of the current
> branch, or the object name of the current commit the HEAD is
> detached at.
>
> So, from that point of view, I would understand it better if the
> above said
>
>      Internally in Git, `HEAD` can store either ... (branch name or
>      commit object name) ...
>
> or something.
I think it does read better that way, I'll change it to that.
>> diff --git a/advice.c b/advice.c
>> index 401d047391..8d2c1ff1ee 100644
>> --- a/advice.c
>> +++ b/advice.c
>> @@ -291,6 +291,7 @@ void detach_advice(const char *new_name)
>>   	"\n"
>>   	"  git switch -\n"
>>   	"\n"
>> +	"Run `git help detached-head` to learn more.\n"
> Shouldn't we be using a normal single quote instead of backtick?

Seems reasonable, I'll change it.

Will send a new version with those two things tomorrow if there's 
nothing else.

