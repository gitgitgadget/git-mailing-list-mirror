Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5846A1BC5C
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 13:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760535426; cv=none; b=XbsNYqy0cWyfOCPJ4RqgMPCv5KZlBTnTYeRN4IIMvZmG1tUVEzXzaKwS3xGQP50PL8s/v8VANIuttzNyCnmCdeUozy/bQD4bYDKehsA/kB238ZiLq+Ao21ccAQZtsvE/EOyuJMBN/K7SD7j4q1VjF+qGJt4Es4VFrpgra7G+xUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760535426; c=relaxed/simple;
	bh=BUDvRuLKG6tPth0Yr3p6OuBfkZp8qaCUnDYvBfzaecw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hKYoPW2EccAkjw1yqrvrmJiUKLZj8EXy+Ti79C87nqNIo2Vjl4TQotY99xB/1Xycn+fVJ4AR79JvaZTAFY/o4MJkWN2UlzF7QM78YFGeMYR9Bly+Mb4dZawlxX4G8N8Lst9WBMJUQVRenK5SMZS/X1JSi9C2r7ZamXiRfmG0eHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ajHqzKlS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+2jhyFa; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ajHqzKlS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+2jhyFa"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 681FC14001C0;
	Wed, 15 Oct 2025 09:37:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 15 Oct 2025 09:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760535423; x=1760621823; bh=h9ob8kekCk
	7RkavC/xBIv9R7xe7ZbP/dN/54mlrNX0A=; b=ajHqzKlS/q1o58EeLpEH62MS8o
	zDAeTtDrPNi181jH4wr4D0Q2C1mTeY3eDLNspTcwblHgLEZEbGwvq7kFy/HV8Fp8
	bMVHtASi1E7sQT9x7BUSE6vlcxjoyoBNHKfoC2CduFscOl55wPZmguAZTP1q5DlN
	t1qsoQXhZWvXxiIjPrSzTJyq5sN7GrIydcIdw91yvj3oj1+q2xMe/k1ulS5hQflr
	e7T/ORYcPfvnTtfSyLGY/N2hmIVrzvKOQROoM4J4W6O4ayReHk3LGKn1xKIaVVXu
	sdoo2+bKRZ9MK6ovMK24MVh9A5vLu46HphVPJhyPD+xffEYPlAIrhu6bHTOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760535423; x=1760621823; bh=h9ob8kekCk7RkavC/xBIv9R7xe7ZbP/dN/5
	4mlrNX0A=; b=m+2jhyFaYOo0Ju99b5/WfJoYX0NblJEA4Oaw1eVc8DBp0Veccjf
	OgFeyGhYo6nqJJat9o6yhK/VsfDNPen0WwyjHnqizs1xL8AO17p0tZdu20FBOAy7
	1McjVyyUfLCD6pifyhWmYbHdR+SNorIrxVjS1s1uI5mm1xKsStpS4Espx3JSBqwf
	tPB+b98yNQSt9oDOeMKvC1SCqOx54dKuCMnMb0o4wgQq+J1i2ujQOkh4WwfIUgfc
	ON8XRsIvcsKZCflAmlJaEKlAgNFE+dw2dYInV+23XzDWN+MnngTrPKdNQgDcNOTH
	Emn70IRiTGP0AVbRseQPQ3LMCVhdzTtG8Fg==
X-ME-Sender: <xms:f6PvaDwPd1UuLVnOfrCjXVMKnetAc6IKtR3ZdqXYBILa8rX4Qdmcmw>
    <xme:f6PvaCQl4NGN3QqZbk5FLMPDykRntUcFGWJ_qF5cuQSekioDhfX58-tiZHh-mbHrN
    APxDQ_u71peTKJIDWypGN2b1mJTjam331FLn35VjwouAjgDr1jV7Q>
X-ME-Received: <xmr:f6PvaCU26KDzZ_47Vrxng2TMywETzxl9T7hng5CepRMRHJFqUbLcmxx8IPHSsZG3Rkg84J-ccba99uVIX868N5WfDVFQLodfJmuh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepohhkhhhuohhmohhnrghjrgihihehgeesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:f6PvaMZZwPwsFMfHPGfVItvOnnT7MlEgoWO5iolCGPwtCf1-NUGGUQ>
    <xmx:f6PvaA1TV5LuKzFstG5eaaUuUw4FlLFuF252zqZZIAO5mm_qOxLI0w>
    <xmx:f6PvaGhYXui81HCbQgr55s2YMKWC0yK-ucGzW4UN1Qn1hr_3C3Hsug>
    <xmx:f6PvaMYnZOvwHvLpmdW5PhepkqEyOmzRTZvFF4fSnOEzsyLavi6IFA>
    <xmx:f6PvaHkrt-QS_xBEPAVQ6_OB9rfdbo9lY-T1TZisjeSNcijVtzTRnkAb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Oct 2025 09:37:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] [PATCH] [Outreachy] builtin/patch-id.c: clarify SHA1
 usage for patch IDs
In-Reply-To: <aO7Tgj4OJVLhFASW@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 14 Oct 2025 22:49:38 +0000")
References: <20251013174658.236940-1-okhuomonajayi54@gmail.com>
	<aO6-LBqhW87GWD-5@fruit.crustytoothpaste.net>
	<xmqqjz0xw20h.fsf@gitster.g>
	<aO7Tgj4OJVLhFASW@fruit.crustytoothpaste.net>
Date: Wed, 15 Oct 2025 06:37:01 -0700
Message-ID: <xmqqbjm8waki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> Given that context, I think allowing the specification of an algorithm
> would allow people to say, "Yes, I am in a SHA-256 repository, but I
> want SHA-1," or vice versa, which would work with your use case better.

That is sensible.

In short, the automatic choice is to use the repository's hash
inside a repository, or use the then-default algorithm (which comes
from the preimage of the patch we discussed in this thread) outside
a repository.  We want a "Use this hash algorithm, ignoring the
automatic choice" command line option that overrides it.

If we were to do configuration variables, we may need two.  One to
replace only the fallback part (i.e. outside a repository, instead
of using whatever then-current algorithm, use this one), and the
other to act as if the above command line option is always given.

But as always, starting with only a command line option would be a
prudent way forward.

Thanks.
