Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793595376;
	b=TeWEnJqkKxY/otqzEd3E6aOOJWBuF5jVfs/hB9RfY0VT+1uHJZuZzjp4lkLOICHt2Qk0
	 N4FOWRWp5WY2mI5L/Hkw/1WvIx+CUjCbcmr5bDGC12L4ltqD73Qs0CQ7Mbf+qMSD9bqtN
	 deT9rzyQ0otwARxl2z0xoian2vCKEtIzl4pOnMebEcBI+34ovrMlopmG5x13nX83diMLS
	 pNRzpU5bXk5EoIHotJz6qQU1V/l05n2Xoe0VjhWXL5AsOQDm9Vqpobfh8rYybfFdxl6V/
	 3lN0h0CbaQzzzxZxI36a4OochcaDpBlb7q6fS5zTQbom8ml8zBVYmwNZIKSve2lbbPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793595376;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=EkFQQgnkepai+8LsK+mPdq5DrFkTPi+3Q9am8tFONvQ=;
	b=dmI1LenPt+WDLQS6LZHuTdSml7x/GeUy0cmtbQdbgFcV9M8XqFkYDUFvOzRqSiGauuHx
	 HpWrZxfzOiw8lKyHWdEDjfzoIA1JuGosMq5eTnfu/aTsu/asMYQ6z09ZhEXcuQz9+Y444
	 g9zYnMH6X8vlzMX+7sZyJsb3nu4lFdxH73ViQFwUX1kI2Nf5CY5MXsXrVe/jmO4/xlN3g
	 iPLBBqOyEzV6C+jVtPTVaqxN/HqRY+stovoN4PwPNLaDO3hHUF8r8jFdaJ9nHY+9j35Pp
	 Y5x6X7v3oCMUCPmnjXjRz5BSx3qHhJVtJa0CHAkiN9AS9jFtkSN96mh10ccbZkuqQrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXmyNd1k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C47606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34C47606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jXmyNd1k
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eafa528803so562835e0c.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 20:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793595375; cv=none;
        d=google.com; s=arc-20260327;
        b=TAr/wcm0bJkLK3NYXxEhePc6/cAo5HP1UIlgYdSK8FuXQKEOOtq+fCJKRNeG7VZueH
         Lr1R/LwuKE0L/aMuZRCFHsJniWSE7EFUkYuoVmt5xUK5ihuo2WgLF6HMkEhy796JHVEb
         z1zW7FHfE55+WWeWDwMPNivN8xjHqxtTTjCUnN4rcMeoVJWIwu/zq7Tq9oK8AeYhliUI
         BmU21US66AkXt+TtBxg1DkvCA5utQP107JgOc2rU1wSJUBCByYdcJWuTG6ZUvbnPCKN1
         Bicy05cTaEg9arN5XrKtMJLqLSMWq2D1nhu9RD58rx3tl37blsC7ap/J8opKY+v03Ddr
         KzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EkFQQgnkepai+8LsK+mPdq5DrFkTPi+3Q9am8tFONvQ=;
        fh=rhuP7Kz2FMTC+i1B9kCYGx965jT2/JGsFvmgpX4QOhg=;
        b=DAtstgX9IZwqLnnU1zDMoZiDKLdiLfOvsMegNAEFrB3IcOVYMmaUrKhzTJXpDyX9Mq
         KGcWtJAQzB3AZUdH2/phERR6JeJCD0OEy81ymRmlhOsFHMPvI9TDt4OBbVkv8qVD46AX
         7fbC78FkTP35jFZMSUjPZPSKo65Gb4Tg+JE9gQQjtmH+4AW+cWU5ODC9Qnsdywnx0Y9f
         5W+b0LkFEOSUXicwU4A13xqKv6CN8MWUdDAFknjQv2R5HpDf1aCHU3Q59mF6Vd6uJnE+
         OEJW8G0DZxAimnIsIXGz6I7Ke6PbrWjf5Vz830eEpsMq5KLfIhrvY6DgM5CsCc6t76md
         UHBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793595375; x=1794200175; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EkFQQgnkepai+8LsK+mPdq5DrFkTPi+3Q9am8tFONvQ=;
        b=jXmyNd1kTMrserPm0z7VGRRORhJXIzA05lpZkOv4GEraiKVJkvw+CDhgxsXgRcZBMY
         OLx3cbNu0pbkEUDVId90GV70i+BmTVNN7PeMKnPXq1bQMtO2FxOYV88h1CjmG0WcbwVj
         Soh4pq9sB2pRF3ySIbWQGrH6S53KFQxIvtH0BMz3l5O9Xpuhkn/WFnKb0ztUUe4y0ItZ
         nCR+0VCKnmLS6sA7v+ZN+IFFbRzubyStl1avO9WvPb4OTrZyiLtWPePZnj5AGFJg2ZD/
         VUWY7cjrLqYqjl0nf8PL3eWDY5bLRSQqAuaAqCKkf7St7kUZ3j9UfYrkFj7A/+jkk02K
         vA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793595375; x=1794200175;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EkFQQgnkepai+8LsK+mPdq5DrFkTPi+3Q9am8tFONvQ=;
        b=cKp0GUnJPdp/QW6c/4wDhdrIkwqNGThFaKXwAtZh4TGGIyVjeIj+snHRGHLse0wkBO
         MWUP8YgAB5TT13953AfuRqUrerUhlCumixNLWem777uZa9HHFImG7oEqM46BdSE4HpLa
         BDmmoapDJElC5ygqEKKyHsJU83PH3+RraO5YK1+0z16Pltbhc5R8bHgjlEHFtaDMmbKX
         F9319xjae6UHImX/KFJKXjglsWJtH3BVjGIQus72fBfnwGtyLpd6pKoNpgB5Vuw++uRX
         o6SmivMmNOC9XjwKl/rUnZaQ9Ham52GiJe1DgoqFOCrUKgTEr9+LzeAJ3vxoBvHDKZ5J
         nl0g==
X-Forwarded-Encrypted: i=1; AKwUvBwiUUcFc/C7+6Aea793WmJRYGBjDJsJSh+YykQb69ElBpSwGFtMcwbORnNY0dTtFqfXkuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4j0NaRDhzOc+vUwO2jm3+9BdHsjyp3bzIMeQBxbtnPr7fGMEc
	O00px2ZAtbMv1HI73qoCkleskm4A7bO/9Lg13zNctBbiE8i9k4P5lKXwLcEB5ha6xJRPmM+njOe
	XOcwJ6HcWS26Vs/YvIyH0mckwDDzVHSM=
X-Gm-Gg: AYBFou1KNYEq2PkcmN5TCeUcPwZ2kzJixrtfZ6nTPs+lQCA8sy1+KtfLjETHUmdfhLt
	LIkpljs4gJx7nHejV1ZklecSHjUn7VsrB+jfdKLtKIMHFw+NFQpu2vf3SqG5yNLfmefDYw5I/1U
	Q04owLx1ETl50h2jBkSmbk2Zod74hdjJUuialnyOhKFd2XNjsoNEtQgEERp6yoR8vykdZCTezAp
	4HPdqvUXtp5U4Eqo/C/jutEGjkrtaEZ1/esfmuT5PEwGWq71tJ/N3js+7zTVRociQApc12e+edi
	QEsydHcFDe0Mwg/dCoi6EGN+Ngm1Skldzg+/KTApsTDyV5RiNXwsPEYzQsSL562sUDJZnWS2Nw4
	vCtwW1EHYhV9p8EmdwRR0Zg7k5U/xQ13K2jBqR8i31oKZY0opIddzK0xYfPwXRYqm+X+ru3CrZe
	65As9tQVerALRc848+6RJj2SbE
X-Received: by 2002:a05:6102:4194:b0:7c0:1d48:b2a2 with SMTP id
 ada2fe7eead31-7d07278d8eamr3135327137.31.1793595375019; Sun, 01 Nov 2026
 20:56:15 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2280.v2.git.1793350341743.gitgitgadget@gmail.com> <20261102024623.24897-1-herroyalpriestess@gmail.com>
In-Reply-To: <20261102024623.24897-1-herroyalpriestess@gmail.com>
From: Shashank S <shashu8660@gmail.com>
Date: Mon, 2 Nov 2026 10:26:04 +0530
X-Gm-Features: AclHuK_IYs1gRadL5oKCRP6QNA3AoVx6kAGdOysBhVPT96AvKty5huEHWF8KS7A
Message-ID: <CANHmUQS15GGDOXm-WZ9M-UyKf2N0K+VixowL_heNKW0vjE0vJw@mail.gmail.com>
Subject: Re: [PATCH v2] test-chmtime: use parse_options() to parse
 command-line flags
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com, 
	kaartic.sivaraam@gmail.com, gitgitgadget@gmail.com, 
	siddharthasthana31@gmail.com, usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 08:17, Cynthia Uche <herroyalpriestess@gmail.com> wrote:

Hi Cynthia,

Thank you so much for taking the time to test and review this

>
> Hi Shashank
> No test covers this. With that argument set to 0, t0082 still passed
> 3 of 3, while "test-tool chmtime --get -86400 file" failed with
> "unknown switch `8'" (exit 129). Could you add a test like this one?
> It passes with v2 and fails without the flag:
>
>   test_expect_success 'negative offset is not taken as an option' '
>         test-tool chmtime =1000000000 file &&
>         test-tool chmtime --get -86400 file >actual &&
>         echo 999913600 >expect &&
>         test_cmp expect actual
>   '
>
This is an excellent catch. Adding a dedicated test to prevent a
regression here is a great idea, and I appreciate you providing the
snippet. I will include this test in the v3 iteration.

> Compared with the base build, I also saw three changes that the
> commit message does not mention:
>
>   - "+0 --get f": base tried to stat "--get"; v2 accepts the flag
>     after the timespec and prints the mtime.
>   - "-g -v f": base tried to stat "-v" [and still printed the mtime]
>     and exited 0; v2 dies (exit 128).
>   - usage errors exit with 129 instead of 1.
>
> Could you mention them in the commit message, or let me know if any
> of them is not intended?
>
All of these behavioral shifts are intended! Since `parse_options()`
handles arguments independent of their position and uses standard
error codes (129 for usage, 128 for `die`), the tool now behaves much
more like a standard Git command. You are completely right that I
should document these side-effects explicitly in the commit message.

I will add a breakdown of these behavioral improvements to the commit
message in v3. Thanks again for the meticulous review!

Shashank S Mogaveera
