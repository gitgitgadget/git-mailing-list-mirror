Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600289;
	b=i3UZFhj9xFQjrG/g12WQmthUo0zj+0vcfkuZAm1AZ8ABsWe43vgLD8YWY0TSzGodo7N1
	 rY/ieHFbZ1SakdsXMuQchY85mHNsoHDvT5tcxF1sNjpYbg3JWsb5MXOZV8W6pI0Q3UIYc
	 fAr/ntPHfNmcRqTz5VKhZ2zniA4WjM/s9vl94pdOvNplLtFcA+4SmeH/DC2DsNrMC55+3
	 1n1Y/brh7/LzB0ilMq/X198JKYmkiHQlgOIZdT/7Z+K4RODrIgKnaUFuQjk+VO65UY5cj
	 ODa7H8ntTqwrrXdkqFRucuW21aYT6V1pa4Osdwrv7w1KAU1ee4dGT/I7G3EPDiBqLoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600289;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fMZiStBpdCAIDp23j3OJ2YGSht9I0oF3TeoNz0Y27+I=;
	b=N4LChXLRPpsaL2MAvJ45aAwmOHdi3/HHUcfVPzyYcDa2QNDy5qXpRBV5ehPUKULsNvHK
	 KtRu9Pw6peZeKbocW4AW1rXcTcUUJyirQZFlRpDlVYRx59qpW/SwJgk8bi254XjaBOSyL
	 hsAah5c5VMELnsVsG8/SluI7sFSGWSt58dU6omZYOTu/uKB8ls5jntptYpQ8DwR7q2ayI
	 hZFdsTjHRFdJW4aYyYDjA9/6QwKAV2ZGFT03egReRhQDaNOBpaq+roRugwjD9eHyWCNg2
	 8MZ6hRehqhtKBg57ugz05VKoZp2gQWOEbwFIc+E1DYXw16hntA4xAa1HjlGW9er9VJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABgeiCjX;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A666606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A666606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ABgeiCjX
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so32989435e9.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 22:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793600287; x=1794205087; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fMZiStBpdCAIDp23j3OJ2YGSht9I0oF3TeoNz0Y27+I=;
        b=ABgeiCjXo7DbAlnYlNtFY4QUp9/Kw+dmSUG63i3A8wCuSOtMIxhc7inNOL/qzZSlqO
         m7vsj6TLTMAoelcZRN4kxXOQDqFVpZMamUPVGVUtP7Jvww/26fXkNPh4ojg4V9H9WSuF
         t74mAn5AsFXH0Xm7sYKF1aNYNSVbP+PQ1UMNMTxsEKl16kgP5QBQuS8Yn/KXunTgoCxT
         VibboR9Txme2lCTtCEaLI8bXeTvqWj0oCBtBirMVEGRSC+zD0Aaa2UNG+0B4qnGqSsNt
         dvESmXyqqA+l3pX76AFhqX4RI4bC2X4qe/sV9gQRtEXKdB+gSuNbdoh2oFJjpTJb+5SB
         7wug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793600287; x=1794205087;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fMZiStBpdCAIDp23j3OJ2YGSht9I0oF3TeoNz0Y27+I=;
        b=hk95phN6P71xqkYabpy3UPqlcVY6JnZUQDlgnRfOEQx8UrjR8by7Q2wBUMghphbLkh
         FIZNCkfGwPnsH9sJOarLu01L2GBDXNwE8B6lb7M8ECAly4zXF0vcQQdpmx0JQvjkUdwA
         1NohJ0KXTRKrf4Hlq/HaUlwFZztdPagUN5yEPajDjaiQyue7BjbyMD2qrSz+K/xxsvQB
         LSGpzD6+CFzsbsisBAFcoVkDjtASC01z0utBHXJnDFOTDdfQJaEEI2TpRyAIglBUTBYe
         C+cUXfMDKu2PCf9gTP+OiUB27qVDgzjgdnZtVm126KcWjb5+5ZaXsTLWO5/xFYrYMSwz
         kEvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwM4U50Ut83cBLdJ3pkOH6Q4kChM1PX6r8ZxcssCT0JfrHUQNDE8wz8iA/CP/w5kuG6gR8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaZs0JX71DhmuHz0YzQgp6BU9Qh3PMM4THyIP6+XMmSSgYwF7L
	4vMsCgvnGTCO2uMwPddn/JU4e9ySS/BRuPUCce93lWdQIXXRGf/yzQ5P
X-Gm-Gg: AYBFou3UDsOFlyt48aQF/EIflw80X/euo25Yp//BZw51awensG8pH+pVLzLXWm7Q9dx
	AAeMmBU8M+yQ00RpQO14WFUTGBpL5eS2VWXUpqA49DwL2Lsfx0mlW+f1Bu9S9H4yT0yj/wYTWjW
	Kz03N4XLNfcben1bzCjmHFZ1VW5wkT0+NO7wB/9c+SzoufCOWQpolbzCz+aFm54D9NrxZhpz/gK
	3Ooz4qP+eYHK0QZ1wbTf8bRe5q8KZFaG0KLBgzhxVeGsM1qwCbbMZfTFhAwHwLuMHqfS9xy4STT
	NDYX+NF/H1BDKWsP2EcckQzDB+K0ELKdKjplQbJWXWzYRP+8ZjnyJ5bzd1zDWhHTTqgNxbORGPg
	HIzvuZb/7hBaxSGnud4rkrTsceJdNqpI3m+4uTMVaC3cT3eNB+rp5TuGFeJAyW/myAP+g5cu5M5
	5VcfALDSKZZ83uIsGY2NcQ6mcreh3MBSlwuWwmX2R4ruXTdGQ/ZJQ6qujCZgZ6PpGnLNiTD5xA2
	EpwR+0ezo3+3fNdcer06bWOrdEJ9PGMzZR6/kMcdF/uEVCU+5NIzrRZvrVz+uC8qwFMbhITPXI9
	WZZqLhLrxLNe9LcbRMfkZ9gx9B9igyMwlJswWnUCLoqqKLJxi8FTq6PeX9KNAmMsEXnPB4SrEnb
	WXYf3rEk3gEc=
X-Received: by 2002:a05:600c:c87:b0:4a1:efbe:529c with SMTP id 5b1f17b1804b1-4ac17567fe1mr216693125e9.12.1793600287177;
        Sun, 01 Nov 2026 22:18:07 -0800 (PST)
Received: from localhost (20014C4D41FE0C003B555A42F26DD69C.dsl.pool.telekom.hu. [2001:4c4d:41fe:c00:3b55:5a42:f26d:d69c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf751c2d2sm272956595e9.15.2026.11.01.22.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 22:18:06 -0800 (PST)
Date: Mon, 2 Nov 2026 07:17:57 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Tuomas Ahola <taahol@utu.fi>, Linus Torvalds <torvalds@kernel.org>,
	git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] describe: count the distance correctly when commit dates
 are skewed
Message-ID: <augrFe35Zci2mG+j@szeder.dev>
References: <20261031065525.19883-2-torvalds@kernel.org>
 <20261031123149.yxap3%taahol@utu.fi>
 <xmqqa4nt2wch.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa4nt2wch.fsf@gitster.g>

On Sat, Oct 31, 2026 at 06:07:10PM -0700, Junio C Hamano wrote:
> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Linus Torvalds <torvalds@kernel.org> wrote:
> >
> >> +test_expect_success 'setup: describe a tag dated before its parent' '
> >> +	git init skew &&
> >> +	(
> >> +		cd skew &&
> >> +		git config core.commitGraph true &&
> >> +		test_commit --date "2020-01-01 18:00" base &&
> >> +		test_commit --date "2020-01-01 18:01" o &&
> >> +		test_commit --annotate --date "2020-01-01 17:01" T &&
> >> +		git checkout -b side o &&
> >> +		test_commit --date "2020-01-01 18:02" B &&
> >> +		git checkout main &&
> >> +		GIT_COMMITTER_DATE="2020-01-01 18:03" git merge --no-ff -m x side &&
> >> +		git commit-graph write --reachable
> >> +	)
> >> +'
> >
> > Just a clueless rewrite of the above.  I had quite fun writing it, so why not
> > to share... it works and might even offer some not-completely-bogus food for
> > thought.
> >
> > 	git init skew &&
> > 	(
> > 		cd skew &&
> > 		test_config core.commitGraph true &&
> 
> Doesn't this barf when it tries to register a clean-up action from
> inside a subshell?

In both cases this is a freshly initialized repository, and the commit
graph has been enabled by default for a long time, so why do we need
to set this config in the first place?

