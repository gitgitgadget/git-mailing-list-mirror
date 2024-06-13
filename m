Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8DC139D04
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 23:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718322946; cv=none; b=KK+ok5d/UQ09w7giLYAwcnp0R2ROR4IJP3oyGRsZ6WeF4fS7uoyaxPb6KwADmTHPK1fSKNyu5T3gIRTQXwSjyoZHyL+mF9ws0jWCIgvVHbgfRrTVBzfTvtAmpJvp5duzILd9/+nfebSfU4KwRHYaDaexlblc84HCFmKiT61aAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718322946; c=relaxed/simple;
	bh=zpjlWJwXE4QROh0kj9IPhtXQXd4ozc2a/iuFdodEUuQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r4HY0K+c38EJb8+hLMFlM83H12J3/sGjFqm/wx3KnFUSW+NtJ22uZR6u1VcTZYXkt2XKeGk5HHyWiUC0KbalBtmGQjj5627tu14v99m/tWmKbXAHbvKcJ0ubSof8GVo2/KFjPaDzvblEU9U0Gj5FqBsJ0K2BheXs4So6lai0qgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=RUrMPY5e; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="RUrMPY5e"
Received: from [10.0.2.15] ([51.6.185.229])
	by smtp with ESMTPA
	id HuI6sIVKIdfdlHuI7sIjwT; Fri, 14 Jun 2024 00:55:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1718322940; bh=xOBTipOWBsf/3gXHAveEqOlkJcnxmoUysfSCjsVsaYM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RUrMPY5eX6o7xcbYy23RMycJCb69n7pMaBcmpDodQxDDnsuv/doTDH/6zAIuS8Jff
	 v/9V2YASU4on5w5s3/Fpf5ooe0D2HZ5IID+RIwj0+GAtO2ntuq6u9kRvmvjwapl4H7
	 SiJiB9t3fPvX9nxyYp5w2sa5pifopVyEjMWTmlQlmVs+sB4wNFOpuL6XC96y0r1CNr
	 vnvXbwHr3kQrqIciOSk0RsZM8DGr9/O4izLGLb82ufJOaOTzoKGKHVpnQY+s5yO0CX
	 s8MaaxV+xU49+xgf2woewej74CzkIcV3xM/xlMgtdcnv5oiMfJ8oh17vQS65j0HxEs
	 qjwH55uK8SzbQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DtP1+3/+ c=1 sm=1 tr=0 ts=666b86fc
 a=7htyVA9VkOexEuxjfJyH6w==:117 a=7htyVA9VkOexEuxjfJyH6w==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=xoVt_Sx5ql3gxYh7dzsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <9d085d3f-5fdf-4a28-b31c-458ba68ebcd4@ramsayjones.plus.com>
Date: Fri, 14 Jun 2024 00:55:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
 <xmqqcyoklo26.fsf@gitster.g> <xmqqfrtgk7ah.fsf@gitster.g>
 <b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
 <CAPc5daUpzc+FDTH4-ajjf6ctnchE5Z6mHVvpm0qnbPLup18ykg@mail.gmail.com>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CAPc5daUpzc+FDTH4-ajjf6ctnchE5Z6mHVvpm0qnbPLup18ykg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfA3RSSUwopHMuw5zSp1FPU6I5fIL3I6+DwrFNdRb9fFtvSbK5LPNJFaP6FRDjfPSAlR/e1BK7pfiZ2bP0i9/nh5utEQvrhujRK0TibNpt6ujNBbHhj62
 ivONIC6UP07HNtiZBgki0w4jd8IkvBckiH4K067JBCQKC5+jxilomAtP69KaeViWyNn7kyDBAF07hA==



On 14/06/2024 00:18, Junio C Hamano wrote:
> On Thu, Jun 13, 2024 at 4:15 PM Ramsay Jones
> <ramsay@ramsayjones.plus.com> wrote:
>>
>> Hmm, odd; isn't the declaration of 'the_repository' from
>> the "repository.h" header file visible at this point?
> 
> No. The declaration is guarded with USE_THE_REPOSITORY_VARIABLE CPP macro
> in the header, and repository.c does not define it.
> 

Ah, OK. I haven't been following too closely and didn't
notice that the declaration in the header file was now
conditional. :(

But that does beg the question - why is repository.c not
defining the USE_THE_REPOSITORY_VARIABLE?

ATB,
Ramsay Jones
