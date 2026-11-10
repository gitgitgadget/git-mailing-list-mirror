Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344277;
	b=ktb/+gPTYJ+gEDcfwDJc81kZ4f/7pAkjDiDU3EUzDZMAOtDnDBGfvtGFvhevJihWoBvw
	 oCN6XEY2gXfNAXY6CS03IntWStmHtsOvPLigr/LJvkAR9WBROmPf6KyXOpjMdOFeSEOdn
	 jRC620CeTo38QqfbMhaqzbmThoy+1/zO1ZBO2QWZPHyjhachvXS5PAOTjbTOoSKwCikYJ
	 OY9ImvcI+emrt70G9jbSlVHbnuQ4gQiCqv4fY4JUqo0G2fW7Y8/NWWy+3DsbHiGKMDGWJ
	 mBrDRArDEseIrTzMlL7uuWYSG094uRqWqF/ASG3rImDE1HSBVpGvYgNXFB+xm/RuxiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=tZtyQNWa+s9kOWS2kddms7TMV1OUEE/BA1VB6au7VhM=;
	b=zp/aVxdKbbLXpY+IzM4DqSEM7JwHiF8XmJEc4jEh/bGe7WlN21SN25upp6dT69cDYlKL
	 8zxNFLGLXSrlxfgD0At4GwNRsddwgYYWhHWJzNGz//gR9PhmaIxXGYd65/iGGza/dzpUy
	 2hdQpuhinigGLc+YWbYJ8POb5yHSePuVUmImXGC+RoJ9BLaO1DeFZYnDq3WOz/xBlnFI+
	 ngp+2jnjS7z2mhjbZhi6t/9KN7kn5YH9Qd4pPEIfdS9guiNF+KLKn4ETfJ4kiqCev7RAD
	 9y1jNnDCu5XceK6DYSH8MwoNOPnRMZyPd905Cp3fA3ggPh9zTKjzBsTbRHe1atEZ0KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bPkgN2/G";
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF0B606A326
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBF0B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bPkgN2/G
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d2e43ff4b4so1700632137.0
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794344276; x=1794949076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZtyQNWa+s9kOWS2kddms7TMV1OUEE/BA1VB6au7VhM=;
        b=bPkgN2/GQQD9khuPDr4nks1ypexO8TFguNG8s+BcMr729G59LhsIsoezDp/mK4xfgn
         Bevw9D62gRFrNmq/GJw8npWMiE3y/dwq82xHs6GWkWr1uWfiYSz8OdaE2PYzDkHJQzsY
         R8+dX+lzvciGuVp6skVIx4rqZ9OeZqi6V1vafmlA8SoRiq4zg1ZwdPRQUFsE064SKjSK
         gKBmnbv7ey5VaOq9b7fqvA1wv0Wh4tt2lnKVB/1pweaKfPMwtq0r9L95f/DB5i5ScPVn
         SeNG2XRJgzTQsgkjOgEQOL5wgtysEoRmIquCwvRDC2btASL9yG+rDMoDemAqAIwXZNol
         hdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344276; x=1794949076;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tZtyQNWa+s9kOWS2kddms7TMV1OUEE/BA1VB6au7VhM=;
        b=Mq0xxAZKXVb1cegqAgOidWRbRI5gceJvKWB8+GU2/hSx/Pz/NgUHJRxq4P9wu3FF73
         vMG/WU/Kj9ovXG5qYUwADHgeAPBvyTFRSvbfsB1NuGe8JN/yTFWhfkXKY22nOCKvno6/
         VQPQ59G+iAWYdhsuRyvVemT7sYvg917/bs1iWZPKpoasPXXwH2MaF35sEPZrVzhAIhGr
         mbSDFcgv5lO6cTu5ShmwX7Znr0lG7Cg67wHCiH/mjffAly1NntJYv1Srtj1CEyI/sR/M
         C5t7yjy/PiwAyZrOoV83N2/U1N+jaxinICSb2VtTLwotYY1ZCQ4BJP6lyJGrR03pPmnR
         jOOw==
X-Forwarded-Encrypted: i=1; AL+hErGtJf/oseEtuOgQTemZCjwKSKGzTXC3S+6gz5aBApVXn3ZyljUUynrX5KhVTs05PQYE6RY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oKZEhKI7hSuGXUfUap75sj5amm5gfXDGMvkvPzSj35tP0zdrC
	1QBKtyRPiCgOnEasXexhNcRv9HvsjDDg6XMlk5d1iKnr8slRt+GpLSHt
X-Gm-Gg: AYBFou1EM8EUDz2I/4k8pBmb7YBGLKNNqS3FDnlD7McswB1N27e9uHqNhTfCHjxaZK1
	ZJ/36UCK0Y0S59LbTGtuAW2YRJadQBSdi3LCpapp8mqfS1Ist1/xXm59U0YJHLOExdVYzwOYbt5
	rRVPZuokNpCPlqYnyhLiA5LvP0M0zk/GyKvM7oeYKrVeybUG2M7O5nBDc3Aqek/BVrvJEm12Ily
	UqIuYBpu7kYEx4w1KZ3a0I+c0wa7ynayRGdwQb3VOTwBfghFJJfbQCG6nc0TTQXegR3L1j4tYTx
	jUk1Ec8SsUEYZjlulx/qlECBTTQlNU+/zUkIcYv/UpaMkusbUsFYFNPPZpXZL35FsPQtWZEwE14
	SWW10FG0ft9fD616yjI8q/GqyI1Daz1AXRY1IQlnHp8LUuVjtMGoIhHp8Cz7BfaQ/ltY63XY5Np
	lIXt4R+9TxD7JR8pZnjnbAicMSfLg7g2L9mk9TMW11ggHOIS005y2kRac50CXJPJIrqODRdoxvg
	6HjyZvHthWiuvewEejVnumQ5aqgh1k5q1nXtQLxkR7IZoohTteNR7cC44dng8vKs7d8+hWjfFya
	g0qt2JKSkma3Ma6WrUUxaBcMOdB7fzdBCEVKs5/RGDagMoIDD55o4vWWsgT5ITa2iHkFQZPf2gw
	0iiKS1Q//2RxMSvlrWvYid4YbznfPoA5xjnRVf6Dvyw+mdGvJOywgjouuAjZWJA5ptHZgzbXC00
	rJ6g/ZjnXh3Lw0HKc0kOgyWMPQFvewbDziVgPR6PX2nv/d+2h/tr7fNOw=
X-Received: by 2002:a05:6102:5086:b0:7cb:bb7b:77e4 with SMTP id ada2fe7eead31-7d4fb23be1fmr42952137.3.1794344275771;
        Tue, 10 Nov 2026 12:57:55 -0800 (PST)
Received: from [192.168.1.109] ([136.61.86.144])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm2716739137.0.2026.11.10.12.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 12:57:55 -0800 (PST)
Message-ID: <dd253dfe-446e-4f2d-bd00-95ebc529cbc1@gmail.com>
Date: Tue, 10 Nov 2026 15:57:54 -0500
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
Subject: Re: [PATCH 0/3] Make orphaned commit checks configurable
To: Wyatt Holden via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, wyattj.holden@gmail.com
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/2026 2:11 PM, Wyatt Holden via GitGitGadget wrote:
> Hi there - my name's Wyatt Holden and I'm a Software Engineer at Microsoft
> :) I've been working with Derrick Stolee over the past few weeks on
> optimizing git in the Office mono-repo. We found some issues around slow
> checkouts on mono-repos in an automated environment:

Welcome, Wyatt! (I was prepared for your series.) 
> When leaving a detached HEAD, git checkout and git switch
> call orphaned_commit_warning() to warn about commits that are not reachable
> from any existing ref or the destination HEAD. This requires enumerating
> refs and walking commit history, which can be expensive in large
> repositories.
> 
> In an internal mono-repo, Trace2 showed tree unpacking finishing
> approximately 12 seconds into checkout, but the process continuing for
> roughly another 193 seconds. A stack dump captured the main thread inside
>  orphaned_commit_warning(), enumerating loose refs and opening ref files.
> Running checkout with --quiet, which bypasses this routine, reduced the
> observed runtime to approximately 14 seconds. However, --quiet also
> suppresses unrelated output.

This example shows a significant pain caused by this check, but we also
want to be able to see progress indicators over time in our logs, so
using --quiet isn't preferred, long term.

> This three-commit series adds a targeted opt-out, advertises it when the
> check is slow, and enables it in Scalar:

I did some pre-review with Wyatt (but found one nitpick in my on-list
re-review) so I'm biased. Further bias: I recommended that he follow
the model of the status.aheadBehind config [1] and advice.statusAheadBehind
[2] patches as prior art.

[1] https://lore.kernel.org/git/2f0f2a2df9410947b985d83a924d2549d62bb65f.1560889284.git.gitgitgadget@gmail.com/

[2] https://lore.kernel.org/git/c1056545b617b89e881f5991beb2fe0d860de740.1560889284.git.gitgitgadget@gmail.com/

And also I added status.aheadBehind to Scalar's recommended config in
its very first version [3]. Wyatt has updated the Scalar config docs
that justify the recommendation, which was introduced only recently [4].

[3] https://lore.kernel.org/git/4439ab4de0bc3f48a6bdcf4b5165b16fad792ebd.1638538470.git.gitgitgadget@gmail.com/

[4] https://lore.kernel.org/git/f062b0e0773b9d168c031bb1f35538665394a077.1765552528.git.gitgitgadget@gmail.com/

So I give my support publicly for Wyatt's updates.

Thanks,
-Stolee

