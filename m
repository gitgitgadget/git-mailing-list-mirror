Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111714D28A
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 21:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720475958; cv=none; b=hRj0kwETzhBL4Gm01IPNFlwR7hQBA/J+ZJS85L4ZoDzrj6LPI/+Fayq0p8sLdNsbZyc5EB9nc+6SloOp7pfca12Au45umwSg56rYyjOkWAD7QtMGoBweKab5OcMWwzuDdh3SaxwwC8NjfSMAx95YLwb7QNcsn2xHI2u90A2c6gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720475958; c=relaxed/simple;
	bh=jCVjZh3qjhyA72O8x8CHFefWyahQRRt9I7RCnPQG0Ss=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=cQ95cdJHvKY+x1UT267iodGGBhsULP8Wn3sd0pID4FsF9kMBUBMMCc6uckhbwIrRh+8OHNj3dVQF4SxD+306cwHYtSQXq3D3paQtKlvi8p//sAPBOPp0nPUZDCiMOg+4ogL6zfIokIv5/XM2KV20CAUcs2PwAVxR6T/ja6ONfwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6WffPp2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6WffPp2"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70b09c2ade6so2183616b3a.3
        for <git@vger.kernel.org>; Mon, 08 Jul 2024 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720475957; x=1721080757; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCVjZh3qjhyA72O8x8CHFefWyahQRRt9I7RCnPQG0Ss=;
        b=P6WffPp2fofM7iNh9ieQE3Yybg9hTjRF5PF4De3xlQTm70nd9XnfCq8REwbRyBeq49
         EtrmP6a4XIruUZfW1JuqckEX066cu92U7ELoN9J8KK/19toAbA7ofzTVE3Nv48YE0YeD
         LUHsJdHCX/YRdjgCamNr9Fqoo2/lEnFKApe9oEV2CVZ0OksTvWnbtMZWmLHnDm4xBz1L
         Vxu0fL5jgpcXeGqqZ0bwXN8m4kU8ohi+6mAiTG8OYp+wRegnXQt3JhnyvPQyy6zE7ami
         WBwv8pcOYAd+XAwkXASuK+3Q2KCuwi2L2dVo6GieKNSEtSs9aXGamWo5v9IA56yc7pbd
         Mi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720475957; x=1721080757;
        h=in-reply-to:references:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jCVjZh3qjhyA72O8x8CHFefWyahQRRt9I7RCnPQG0Ss=;
        b=b94ORnATWWOiQPsrEzSlPvECm709mEe8OGMQbByRHEGyeNJvHTzgM1aFkumzxorHlK
         Hh3pAHVf+0xtUsfm0BL1TVcM8osPdlqELTTATzrYuf+07T/2M4wDPohAjsxGmXP4l7Hs
         8zG7gjDvGZAszi2as82qTbpnJWNzkHNMpNQ+SHpGM4mn5LjV7n6yRetlC9mYWdneZzi9
         LD7vyxsicuJ6aMq6UyM973moZSmrvprcavUkbnDNrxJ7z5N1MQSx0N+gUwjJloOMY9Rl
         /zfEBS3h7IA4kSYvrJv/ghzKfIAopn0XnBATqcE3c6tDK9u1ctue2PhYNHPr9fht1R5e
         9iiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrAYx6zo4+F1ZfY/TE3pBvNvyB9sM2i19fQnv3sUA1kEK9RTBV4Y6da9p0ULAEAbwm9Qo/mQG2pYsTu0ad9CQyRsHB
X-Gm-Message-State: AOJu0YyfBTTxtBTPJsY7sCIO7dLvWeI5AuJTctKwdDd+6HoxbpUD6HkL
	v64FexgPr/uAi8ZiCOni1KotpVi3mV7WEcqsIPLq0syYkgYuHNUG
X-Google-Smtp-Source: AGHT+IGRy8DP1oqz/MB3NzcFOm0SHx5VbqM6DFJmVG/IvOTQAyp/CfraAWQ6SWfc5tmFjQN9Nh+AMQ==
X-Received: by 2002:a05:6a00:1797:b0:706:759a:70bf with SMTP id d2e1a72fcca58-70b435686b8mr1066500b3a.13.1720475956545;
        Mon, 08 Jul 2024 14:59:16 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:b1ca:de8:cd9e:bf98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b439b5689sm355620b3a.187.2024.07.08.14.59.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 14:59:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Jul 2024 03:29:11 +0530
Message-Id: <D2KHTOXCNFOI.Y1UIN4IT8APB@gmail.com>
Subject: Re: [PATCH 6/6] t-strbuf: use TEST_RUN
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Josh Steadmon" <steadmon@google.com>, "Ghanshyam Thakkar"
 <shyamthakkar001@gmail.com>, =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Git List" <git@vger.kernel.org>, "Phillip Wood"
 <phillip.wood@dunelm.org.uk>, "Phillip Wood" <phillip.wood123@gmail.com>
References: <85b6b8a9-ee5f-42ab-bcbc-49976b30ef33@web.de>
 <1bf053ae-957e-4e9a-90f0-11cc76848ce9@web.de>
 <bh5ectgtwdaeltflggzwnwhobewvcqqelforr4sfcmq47rnnrl@mzspptlhpofx>
 <D2F8BS39IFC4.WJ9TNK3IDFBV@gmail.com>
 <tswyfparvchgi7qxrjxbx4eb7cohypzekjqzbnkbffsesaiazs@vtewtz7o6twi>
In-Reply-To: <tswyfparvchgi7qxrjxbx4eb7cohypzekjqzbnkbffsesaiazs@vtewtz7o6twi>

Josh Steadmon <steadmon@google.com> wrote:
> On 2024.07.02 22:59, Ghanshyam Thakkar wrote:
> > Josh Steadmon <steadmon@google.com> wrote:
> > > I think this commit in particular shows how TEST_RUN() is more
> > > convenient than TEST(). (Although, arguably we shouldn't have allowed
> > > the setup() + callback situation to start with.)
> >=20
> > Could you expand a bit on why the setup() + callback thing shouldn't be
> > allowed? I think it is a nice way of avoiding boilerplate and having
> > independent state.
>
> It's a matter of taste rather than strict principles, I suppose, but I
> think that test cases should focus on being readable rather than
> avoiding duplication. Production code can follow a Don't Repeat Yourself
> philosophy, but when a test breaks, it's better to be able to look at
> only the failing test and quickly see what's wrong, rather than having
> to work out which functions call which callbacks and what gets verified
> where. Also, since we don't have tests for our tests, it's important
> that the tests are easy for people to manually verify them.

Makes sense. But the manner in which callbacks are used in these tests,
which usually only initialize a certain datastructure and then release them=
 at
the end, I fail to see them as more harder to manually verify. But it is
very easy to stretch the line and perhaps do more than initialization in
the setup(), so I can see how disallowing them would get rid of the need of
judging every time wether they are readable or not. Maybe a 'best
practices' document would help in that regard?=20

> I also agree with Ren=C3=A9's point about the test cases matching real-wo=
rld
> API usage.
>
> I do agree that having separate functions improves isolation, but
> hopefully we can encourage test authors to define local variables in
> their TEST_RUN blocks.

Makes sense.

Thanks.
