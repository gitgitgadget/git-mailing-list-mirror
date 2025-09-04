Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40CD2C11D0
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988425; cv=none; b=DhB+nMZOlhguMXqt+eL5mrz95LKp6eTTWCKJTazN1UM6Aqpx3l7hdXR6nz29jc9qtkj4HSCCPNPteAYbB8wyOBCo7EXypg9YwVEeRvSRQXcpbSXz55uzgVif9tONffvwdL+g5DqMND9fyRizvBGgSq3rKaoAYDnv5FNjfQCwPog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988425; c=relaxed/simple;
	bh=NFsNfhSwYTpWQtkDitbBYZHy1AGmKEOdXAFAtjpxV8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Gm9iUwhuHZKvutC1ssZGzZNRE29mbFoJlNj3XEnVU7+4ttqezs/jpaxW/Q4s8hAqp3domvuEszSqDrElO5uyf62QNxFee8+qZKi24YjVSS80V/PGhvM0EQdqrc9FCT2u4ElKug47OtN9xaQgXHab/MqjQVUk0MVv3bNk8hsOmLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nny5cLsz; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nny5cLsz"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7f8ea864d81so120085885a.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2025 05:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756988422; x=1757593222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wY1b1MTR3yByRAv7lZ23hyJQpbj/8AgEeINm/7eygNQ=;
        b=Nny5cLszGboKWwSsDFpWyuZLZHahxm2cbaosKY+6DdFKgdfAY0XINTsoAsa4cmeJTx
         qVJqiH4TZB0cfS4rXRh7lZDvLPu5D9bA8NAggW7gw5Da/N9Es7ktjpejEMZVCtaPD/zi
         aO8MZJJwLQPi5UHorlWCttdnRdqhsLnY/1E+Mv+37pohhtdXmqpLZx8tovxuBb9F3NdH
         xOGVCw2jyXLrDNP2GpOd1SzKoqrZX17hZMc9NNdFS2sRvVFi17/KWstvEaooaLyjOVb8
         TjkGyWVbp4QUFiHpTUCdsFx31+8E1t7ft38nsdQjI9HtQSTV6uhq75d/zhV2ePjU1vws
         bp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756988422; x=1757593222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wY1b1MTR3yByRAv7lZ23hyJQpbj/8AgEeINm/7eygNQ=;
        b=GnR4arWZ9Wl7LQDPUJnbg+Ot5PT2dWTbMlNNBprr/1mEcZ3CGIbvp8GRqSwBBzf1jF
         PX6lE18RnXm/eFzb6VYYp2aiRtP2g4LhWxsZimkymYEdBoDjSsstxAv40nlvHNaCim3Z
         TuHC3bwK2TgxgRhzxSwu6UitDGpn9oCwiaZQZx1RzwG+GKCMNRJR5OBUbtBoT4xD3AUT
         Gv7TRy+4EcsmsiHRFcJIbLnDeSoLtu6i2ijLnjJTA5n6Gh6lSAiJvS3QYvOyjeotqrfM
         wYs02IV47Nkt3VWpicGg7HFeeC+3cV/Dv7D4DQ6TsYNiEfZA6T2hUJju9s0xhIDuyrLc
         5M9g==
X-Forwarded-Encrypted: i=1; AJvYcCXyQkhlUSxL2qp7k/U4F2XRU6+qIYNqfcKlokqCxPUWWYbj1m2fiLMwvKGE0FeG9OhyAv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu9/TW5+F8/xlS38wimbAKQLLRIMmT8D4fP7nv/HD5TMJEAfmY
	X5dCjMttkpEuAyC9wkiF4iLeQ0/Q4rn5DB+6ioBxJw80RAOR2fmOAznR
X-Gm-Gg: ASbGnctY/6lltYxj20BDtzNts/6cybJPsuhevamsM/Lb1m9Z8b50dCGCHcIhLZhoLaQ
	9WY5CtlXZ7KBzxI6s/+SpwjYb9HdYaS+o4TDIYZ7q++/V9g6tAQz4JksNdmS9+ItyW45oAPpNon
	Ql1mXvNMi/gcMJTo5Ns2zg5/TvappjqdagEtQFSzq3PX+kttnS7hApK4A6AtWbtHw2AeoavPsQu
	zpfQgYKtCfSz9vTemu9tEeaTcwnO2DJEp7Wo8naSFt/8B3sMV5Z7AGfD4WLWKmnQITmszevqSgo
	IP+s3Fb507SdyE2m15GoY7DMvfxCr4iiPoyBWe8VQs99xpPNVfYHAU05WbAL3U+Xm2axah4RJpT
	gwwwxrbQJqM3pw6SPntsZC3kDeBmc+x//UPaS12d9J9V8HA==
X-Google-Smtp-Source: AGHT+IGgOYOfD9v7LpcZTE1eePrlT6cpPpyc41DNatDAjUZ3L3gMwuGd83SM12kZtMRffBmE7OHzfw==
X-Received: by 2002:a05:620a:aa0a:b0:800:c495:48b1 with SMTP id af79cd13be357-800c4954b2amr1848408085a.61.1756988422335;
        Thu, 04 Sep 2025 05:20:22 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7a37c6sm27961601cf.47.2025.09.04.05.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 05:20:21 -0700 (PDT)
Message-ID: <7713256d-e258-4356-b303-128fdb417972@gmail.com>
Date: Thu, 4 Sep 2025 08:19:59 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?=
 <dilyan.palauzov@aegee.org>, git <git@vger.kernel.org>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
 <2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/2025 5:41 AM, Kristoffer Haugsbakk wrote:
> On Thu, Sep 4, 2025, at 11:33, Дилян Палаузов wrote:
>> • add a git command to download all locally missing history, including 
>> for treeless clones and blobless clones
> 
> This sounds like git-backfill(1).

Indeed, 'git backfill' is intended to assist with downloading the blobs
that were not selected in a blobless partial clone. 
> I’ve never used blob/treeless.

I don't believe that 'git backfill' is optimized for treeless clones.
Treeless clones are not intended for "refilling" as downloading missing
trees is particularly expensive.

...

And regarding the original thought for "we should have an option for
doing blobless clones by default" the current way to do that is to use
'scalar clone' which is shipped with Git already.

When Scalar was originally contributed to Git, it was partly to enable
users to opt-in to a version of 'git clone' that changes behavior with
best practices and advanced features as they are developed. This is in
contrast to 'git clone' which needs to remain backwards compatible, so
any new features need to be selected with an option or config setting.

But there was always the possibility that the feedback from having
'scalar clone' available could lead to a future builtin of the form
'git big-clone' that adds similar optimizations for large repos. (My
opinion is that 'scalar clone' _is_ this 'git big-clone' but maybe it
is not discoverable enough.)

Thanks,
-Stolee

