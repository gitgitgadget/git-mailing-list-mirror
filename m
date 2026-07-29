Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F5A455180
	for <git@vger.kernel.org>; Wed, 29 Jul 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785339114; cv=none; b=LFyY65eKlK4oZChErA9fVJWIOWOhO3IKdj7MXILT3EmcVOHUPMacdvmkdBXdv5ieW1l8tAo08umf0nWoET1XqCVgg1am8YZY55x/M55H0xr8BsopuqYpIy0AOvqII3kgK/XzmURIcKdjDji2SurXj0/SSbB8kOUBn4M/A0HM6ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785339114; c=relaxed/simple;
	bh=vjMu37L2H70ZSfNbo32mk0tCJexTSh+x6ZZXRBRuWzE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dg4OtHIc6mFsfYs8nEgguAABcvzfqNND4bQTK0nR4KwGy31EaHa2ObsdhTvUGz/aVnHE0O1Kxr5LmSLgFPgY5ym0epu23i8myR02v1U7UeH6JztGSRjGbr8G9zJt+9LtJje+8L5/sLHTJFb95dzsitTvWiMJAi9qPwDfMH0HcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hn3nkNtv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lRJZ2do/; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hn3nkNtv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lRJZ2do/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EDC031D0010A;
	Wed, 29 Jul 2026 11:31:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 29 Jul 2026 11:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785339109; x=1785425509; bh=njOjK1lXpP
	QZeoB/sg1KweE+8u1jmD9v3kZvNzpyFsg=; b=hn3nkNtvnke4P97km0jmKcRtPm
	9WW6Dq5q3TaJGrM/JEO93euLt/z3UdQ33gqeeYUGWGRBQR7PUbi2nmxoq5wC11BY
	U6ySs+/YKFlHLUtvWdoejw54tepOUhBnZtLaBERoJhNO1K/cVGkrZDqpFMRUHuNo
	PJ0gAg2BuL4i2o3nkAMtYzxD33qRnwyLghCezKXd6e7wADRas5zLKenazrWLyMUy
	ZOBO1CWOH/3IdeLqikp/CeemoA5W89V5AQGQVRfYQPfXHUNfmSNu9YHIORGiUWrr
	PUmGNUfbEUfwmlphf53RppzLJt7xsqb5Xy16T/46JV6AUt1/vTFHr5OQu1gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785339109; x=1785425509; bh=njOjK1lXpPQZeoB/sg1KweE+8u1jmD9v3kZ
	vNzpyFsg=; b=lRJZ2do/zfOM2RahtOe0LQSEp7FrLiwuTtZdAM3FLuGjj2vjjew
	XjygPiiQhiwedr+mVsRJ4JYi9z/3WLGKeYCj/OIr/a0HbV7gUdvCJ/udcRZp6Ldz
	TCyQUFTQmOpMhk8fcEV1N+lT/Bp046g9qtD/xjRCxw0U1f+RWieB7wdVYNSaen3S
	LPqmHMbwgulvvLaEeZHGt0gehb28sWiUl9zytxHErOBcru3ykCdSEfm2N8toJLw3
	pt1ruJ25n3tTHTmm4ktEH5r/tg4XwtR1XClT7R4YCqQvu/mmbHqmLCpJuvqhy6up
	Ib49eMzhRO0OJpv4sdB6ODVkTCUsVbbyt1g==
X-ME-Sender: <xms:5Rxqan1JT1bkwChf2nOyvga636Xvvgi7677Xak4pocaM3Y4cUwBRqg>
    <xme:5Rxqas9-MTzY3h1FGrr0nlaEa8CBuAd9ZfsTCOa7gO8fJl5-wOlJ8H3ORoOVyv1zF
    laWO9wb6rDntGjleF8nMEQyJYTOeXhzK1dcpaOTzHyxvFw-cPyBDbg>
X-ME-Received: <xmr:5RxqagOL5yRu7bTOrAjjWeg05PXd0GgtiX6KJaCbF2b62cYHpP8Tqa2CMrvDpCwhT2L7_YUVU7HnCJcLI9IAGQx4VG_lfCw-dQ>
X-ME-Proxy-Cause: dmFkZTFisSXpipwTUNOQ/S0ZTYoT3ILVryVd8zlZv2oUmGnfeDTZVwXkLC7xJgnKcmC9xh
    gLqRKG4KkbUarWVyyK/k/mzdUZ4YXuZ+5wmoQ5aRjgytRTqpbnnmlyrsyC9gPiuy93j8Gf
    1zWOz4GST/p2ytIJjp6qPK4bTmxFW3OW0d7TIS84sIopK1IJexUsvbAzpiDxUMlIAwllpn
    dyRRh7dG9Xf25jv3T6sXH7Jo/Fhj6TgXecxUuBfOE1sto27ihRWsmkhAY61my5LbLhhTAy
    4pNfW4ZTsXMj3KwWP78KPQcfTzRA7l1iPpYu+oWZ0qQMafLSMdH7vqqdayIaf5c/7IzwPm
    poHyvmH09FRbyJIjCQnmOo14RRc0u9JzUsMh8v3zQDhv8dW6QrKfu3Wq4qSQHz9zKyTbpy
    WNPYDsmwzGvpYesQwDGRCXvMzIbwlcbTf40KXvh6uoKVHY9F/qw4h+gRKlPXFzT4QBkJYy
    qgksZRnOBejCpxRC7IpaEocfvm05fZyAGzSfkw2RH9f+UF42xpV5psrJitulQ5/YiABvY8
    mZfXcLftufh9jqUvadh69z+IBFL+kPVq3QutafrbGUnIa0d0NBH93Ntd1pY+b5yqgBmBJ2
    nw/PcG/dvsWUa3U7uuVxkYYCPwgu37G0XCr4KTqb6w4MwpC/DWiUcJa3oz2Q
X-ME-Proxy: <xmx:5RxqaocM4AM-xmZxl_HTPz8sJ-P-qKhpWF9dGPJfmIlP012v7jhWXg>
    <xmx:5RxqanVcMMXlBw5B0oUustDD1OT2Gt1dpaTib-eJLh2DR72jFtqVAA>
    <xmx:5RxqaojVgB4dkMCN7-3MetQSonNYI-KZv2j1ZMCk5yOj9GPDAW_Gog>
    <xmx:5Rxqau9iTNzFqe1VMXLcGQtqVcHEqXmp6cVwXg9igQdyjydzlI2V-A>
    <xmx:5Rxqanu98cOUDc5df7qX5nRJMt7UuZHKrzfyZzo796SSgqrrmU6ku3En>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 11:31:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Nikolaus Schuetz via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Nikolaus Schuetz <nikolauspschuetz@gmail.com>
Subject: Re: [PATCH] merge-base: add tests for --is-ancestor
In-Reply-To: <9a47d529-6195-435b-90a6-e511856f128e@gmail.com> (Phillip Wood's
	message of "Wed, 29 Jul 2026 10:39:11 +0100")
References: <pull.2186.git.1784998828879.gitgitgadget@gmail.com>
	<9a47d529-6195-435b-90a6-e511856f128e@gmail.com>
Date: Wed, 29 Jul 2026 08:31:47 -0700
Message-ID: <xmqqo6fpak2k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Thanks for adding some tests for this option
>
>> diff --git a/t/t6010-merge-base.sh b/t/t6010-merge-base.sh
>> index 44c726ea39..d28d9dab2c 100755
>> --- a/t/t6010-merge-base.sh
>> +++ b/t/t6010-merge-base.sh
>> @@ -305,4 +305,38 @@ test_expect_success 'merge-base --octopus --all for complex tree' '
>>   	test_cmp expected actual
>>   '
>>   
>> +test_expect_success 'setup --is-ancestor' '
>> +	git init is-ancestor &&
>> +	(
>> +		cd is-ancestor &&
>> +		test_commit one &&
>> +		test_commit two &&
>> +		git checkout -b side one &&
>> +		test_commit three
>> +	)
>> +'
>
> Do we really need to create a new repository? None of the existing tests 
> do that - can't we just use the commits created by the first test? 

Good point.  It is often a lot more work to do so when writing these
new tests, and I suspect that is the reason why this new repository
was created, but I do not know whether, in the long run, it is
cheaper and more maintainable to reuse the test history that has been
used by all existing tests above.  The next developer who needs to
tweak the first test has 5 (the number of tests below) extra
constraints if we go that route, but a separate setup means the two
sets of tests are more isolated.

> Having said that, the tests below look good. We could perhaps have a 
> test to check that it fails with one commit or three commits but what 
> you have here is clearly a very useful improvement in our test coverage.

Thanks.
