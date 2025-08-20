Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF4B3314A5
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 21:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755725697; cv=none; b=G3i+Euo4910pPyQAbenSzgBeOxZgvwNgW1rqHsm8zhnj0k402ENLd3+VJcnppH1JKS++ANGsME1RbIEPIDF7d40i03JkcRHfoukxhMfR0/AG9xKOvNu5wVkdGdchLleK38EywvmA8SOoyvvVkvV5q5w+/HOKVrD9vIfcN9F+Dbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755725697; c=relaxed/simple;
	bh=r3+D1B1/K2gNIt0BmpTdveNZEQ4cz2+fn8cics9ANQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r0Td7GwZs5L5DgdYWRT2m7CcCI2/raxr/rZxfEKcbfnQ2RpYujyzluFQQEUyQqDwo4dOfjn/5uag1qOrNWUuofCH3dfBYVSZJ+l3sE6qG7ddqHm7jDs5e3CAu5LCa9TtgVs+pdyRDTbrzIkx2naqU6UNs12f/PfM2Vo4s8kYBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WXFVpnTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UEYGT5Bj; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WXFVpnTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UEYGT5Bj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA0DE7A01E6;
	Wed, 20 Aug 2025 17:34:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 20 Aug 2025 17:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755725694; x=1755812094; bh=lWzFhrPjsc
	pa0FtcRrHrD0QveaK0fw1bqE7UBi43uiA=; b=WXFVpnTBQcUxdqBsSz3sKuTsxV
	I9GicyRIq2N0yjrTWfGeoVB47rpQQyYA34sUe5bc+YEopt0gTDHtqnsGzx+2fCO0
	Mdty3Qrg3lzc2QUh4XEzX9Ttf+4nFx4qMX6b7ysM6UZ4U7BVb898cb4RkkC5Ncmr
	Q5uZ2kDoNWjZGOoqnWhQVeAdjwU/lBs9bE2Wti5uxEwFH+8kXNgNdt3Hd3zhJ+2F
	eD3sY7EZ/8GrmMPbUzky7Lj82wlef4ouboJRFV2ldjJP4F7qd7RF7DrZS4qBq2vh
	Jowj6hWHKRRev8bWwiVdyqbRkwjhYNtZMOwqW+w9ylh4ijvOLGwYInmPnsuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755725694; x=1755812094; bh=lWzFhrPjscpa0FtcRrHrD0QveaK0fw1bqE7
	UBi43uiA=; b=UEYGT5BjGPBlv4Ba/Bdt+aFGAq9kFXx2cSMRXlRqpzD9yv9DHtr
	+eNnsw3LGdZeL0s73Uwjeii39rx/GZtepwpG7Y91Ktgadokxix1hPZIhXwIB1rue
	zhl9w4N5SGOsT08Bf8sH5aGvN9jsM4AV5pfxMGzYrmuSVpuJlDLHOq6Nrqt9Xedl
	yhHqYeKhqYU7lyEkVn0lpcg0Bo7FlkyklKVjY/fdKXvW9rJ4im2+PAuUb/o+6YBJ
	41NWX3nBCRlUGG+bM/KbkAQQpEvRPyu6XcvEgpuPKwn200/4fFOqvxGXwCg7acj8
	69rymjXVos6eyljbPfamjfODOijUhgjajoA==
X-ME-Sender: <xms:fT-maCcFQlnXKbnGlYcvV4Hw7atRyofZyObOuuvUq1AwhS1nlgdZaA>
    <xme:fT-maFpx8pAK3S9BzdqjE2f7L5cvJBG_1Wi68EbXBrvV5q7pdqSd7Bioyaazg2mFN
    TtDAHILS85OhL0Hmw>
X-ME-Received: <xmr:fT-maDFtn2K_tFMMHoxDdb5N4LIH_TueOk9AXknWeMBN0BRSGO9v02vpEJaIqHXx-Xn1ptBIhHWkIm1PPhztc4OgNTNE7FYP2547Oww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmh
    honhgrkhhovhesihhsphhrrghsrdhruhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fT-maFuXEumI6tCgZB1IeL9XDum_My4_0Z48KYZiTczn715BjyX3Sg>
    <xmx:fT-maFUa933MOYQRXltYh3HWaseckU5CEpdNndyc9uiWmZDvTn1gkw>
    <xmx:fT-maBEnTUNIeEUD4y0apELCBQtonvVHYUSpJvlb93w8PYeN8TK7wA>
    <xmx:fT-maH0SQECRrOc1f81YT7adYmS9lPy8XVp-QHH-HwX5xR22nRPa3A>
    <xmx:fj-maMJdkrGob8m85FWiFB5cpfIha0yHSR_oNiwyOE14s8IHzGc4a8F2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 17:34:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] xdiff: optimize xdl_hash_record_verbatim
In-Reply-To: <0379ba2d-837b-761e-9d5a-d65ca9d051d6@ispras.ru> (Alexander
	Monakov's message of "Tue, 12 Aug 2025 20:56:37 +0300 (MSK)")
References: <20250728190520.10962-1-amonakov@ispras.ru>
	<20250728190520.10962-3-amonakov@ispras.ru>
	<aedb1be1-3151-421e-94ce-27bc77d80b83@gmail.com>
	<353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru>
	<5cf47722-7073-4761-8698-090af840d0c4@gmail.com>
	<c2fe3b69-8436-af46-c47d-dde5bb037227@ispras.ru>
	<0379ba2d-837b-761e-9d5a-d65ca9d051d6@ispras.ru>
Date: Wed, 20 Aug 2025 14:34:52 -0700
Message-ID: <xmqq7byx8yo3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Monakov <amonakov@ispras.ru> writes:

>> On Mon, 11 Aug 2025, Phillip Wood wrote:
>> 
>> > > That's what the 'cycles' column in the table gives (6.21/5.8 = 1.070...)
>> > 
>> > It would be helpful to add a column with those calculations in it rather than
>> > forcing the reader to calculate the speed up for themselves.
>> 
>> Ok, will change it to
>> 
>> version | speedup over (A) | cycles, bn | instructions, bn
>> ----------------------------------------------------------
>> A                            6.38         11.3
>> B         1.027              6.21         10.89
>> C         1.1                5.80          9.95
>> D         1.094              5.83          8.74
>> ----------------------------------------------------------
>
> On my Skylake:
>
> version | speedup over (A) | cycles, bn | instructions, bn
> ----------------------------------------------------------
> A                            5.77         10.96
> B         1.076              5.36         10.60
> C         1.12               5.16          9.66
> ----------------------------------------------------------
>
> A is today's master, B and C are patch 1 and 1+2 like before.

The thread has gone quiet.  I assume everybody is happy with the
result?  Can we have a hopefully final v2 iteration of these
patches, to address the updated to the table (this thread), to
squelch the __asm__() issue [*asm*], and a reword you mentioned
[*reword*] against Phillip's review?

Thanks.


*asm*
https://lore.kernel.org/git/3405f274-cef1-b361-7424-840dc55b48a1@ispras.ru/

*reword*
https://lore.kernel.org/git/353c7865-d9b5-2a1c-4d71-cd1136581f01@ispras.ru/
