Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3592F2A
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732145215; cv=none; b=LboKgcd8mDmBT37PqDWFccCLJyji0eBB6uyZFmqVXPR+jytkMOMRlkRdVeCCuznSWR/oAWUuFcPR+OzjCr6568H5IdsL67tol5mo5Zcdj1wEQLOrVhnbrct6uPViu/JNzO2gOwqHdvfgWFp/mrS75tZckvZVQqDme5lTS8XPXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732145215; c=relaxed/simple;
	bh=CWKWKq60zgPQOX+qk7R8CRkQg3n4mIPDWtGLECgItP8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nqoouu4a5iIS9agx7gej00rKF0EtW6Hj7rvUD4UqTU8qtbtaqIsaMXYQoIY+st1B4SAqgDWoECO5DHsj/KZTqFp4TeEkzd2f8Y5Z9n4ipCPqyBn5zCLGzOpE97A2ZXyhpNBk7iZcy/DRANaLlxfGLHjGFUttv1sKKeavOgqtH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=15J5NiKz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="15J5NiKz"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C985254013C;
	Wed, 20 Nov 2024 18:26:52 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 20 Nov 2024 18:26:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732145212; x=1732231612; bh=PlrlEZIAgjgCgw7mBR7bJVY9ZzgUMFht3fL
	9MSqKBcY=; b=15J5NiKz+8B1Du/YCSEAeaCwkVf+jb5cuWYc+OtJcUU9eqM0fPY
	hno+SFdrqzuPFHhPw6PHs2hfw250eRcgPSVer+MJXvniEitfri3SQRHyZo+JNgV8
	Rrb2tck+U1Bg2BzkzCawwsuZYocfWl1r1awGmK1slGQBal3ynqgR9XG14YiAlZD0
	aqr+tTOYkhfKOYS3+gpkr6qsW4X1KfgxBaT6/T1NQZaCy6U1FqR4xu1DR6E4m4HS
	G86mD4I9ejKqqi8eIojJ0MnhmE0Dg9xN0tIh8l/pQgYyUI1/h7LNIVob/aUpKFXz
	WOwsPqOoy7C5Cf616HOdZwOwduMELOIlwzA==
X-ME-Sender: <xms:PHA-Z3VzK0J3_8wxCpQvibBh2Q65akUMelZbeh9dhtfOsrT4fcCsVQ>
    <xme:PHA-Z_liDWTNP--3VXZUIZRE3fAuxd6e7xDQnw8Xm8k482EjLP3apGGqOj_lvFYti
    O9ePFwK7ez55R-LIg>
X-ME-Received: <xmr:PHA-ZzYyi8MRAS3sD7IDPqRNUUQrllrFCAJXxfJNvf0iGe3CYkxJ_0t3CUpynMIJhIjVHG1Bw5-I9VYttshAmSs-s8WhXn1OmkuZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddtlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtohhonhesihhothgtlh
    drtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepthhm
    iiesphhosghogidrtghomhdprhgtphhtthhopehgihhtthgvrhdrshhpihhrohhssehgmh
    grihhlrdgtohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdrohhrgh
    dprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PHA-ZyVRDLSCDB82iJi76lXPPoBBm2LHd8b_9Xt2fo7O3QXq0IPTjg>
    <xmx:PHA-ZxmPhdpz4kUAF90juda9Vdg31olNSD8-Bu6Mk3ese55U8kKOPA>
    <xmx:PHA-Z_f_YCPE9bD2YJlwdZpKY2NpTCZ82n4J7AfxOvbPcoWU2GwbmA>
    <xmx:PHA-Z7F3ltJfw8uctdTieq9xqwU0R_44an_8vtFfzyw6cFaSz585qg>
    <xmx:PHA-ZygFnJH7AFhl6xbZ4nRyZjtxHfV6cuUiSb6RUYcAwHYJkfWko4G1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 18:26:51 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Jeff King <peff@peff.net>,  Todd Zullinger <tmz@pobox.com>,  Elia Pinto
 <gitter.spiros@gmail.com>,  Usman Akinyemi <usmanakinyemi202@gmail.com>,
  Andreas Schwab <schwab@linux-m68k.org>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/1] test-lib: move malloc-debug setup after $PATH setup
In-Reply-To: <87ttc2rp2e.fsf@iotcl.com> (Toon Claes's message of "Wed, 20 Nov
	2024 14:51:21 +0100")
References: <CAPSxiM9UGLVrOh6XR5fn38ginCVKMOc7yQMcm+qsaF3bi+anSw@mail.gmail.com>
	<CAP8UFD2=imvtamewLN+VvKDK83aL7NhGAb=MjvHQ2OwaK-n5UQ@mail.gmail.com>
	<87msi85vc9.fsf@igel.home>
	<CAPSxiM_h2yEZcUPP33q8HHdn6kqq7SbvzNq8eEFda81ZgY6R2w@mail.gmail.com>
	<Zy-IYwjb_RO5NW-s@teonanacatl.net>
	<20241109190012.GA588841@coredump.intra.peff.net>
	<xmqq7c9aihvx.fsf@gitster.g>
	<20241111070134.GA675125@coredump.intra.peff.net>
	<87zfm3iggu.fsf@iotcl.com>
	<20241114012729.GA1148710@coredump.intra.peff.net>
	<20241114013912.GA1155455@coredump.intra.peff.net>
	<87ttc2rp2e.fsf@iotcl.com>
Date: Thu, 21 Nov 2024 08:26:50 +0900
Message-ID: <xmqq4j41ij0l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> Originally, the conditional definition of the setup/teardown functions
>> for malloc checking could be run at any time, because they depended only
>> on command-line options and the system getconf function.
>>
>> [...snip...]
>>
>>  if test -z "$GIT_TEST_CMP"
>>  then
>>  	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
>> -- 
>> 2.47.0.527.gfb211c7f3b
>
> For what it's worth, I've tested this patch and I wanted to quickly
> confirm this works as expected.

Thanks, both.
