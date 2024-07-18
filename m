Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3953F186A
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 01:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721265756; cv=none; b=oIaNxaXWWT3ZhwCJIFUzsL69QDZAbRLTjYcZN8Lh6/OlZQDc4ux4Wl/tMw2/x2e8gUYan0jBC6QVQRgeEQrAzCAiv1KZ+zqlmZ7y1PrEHfWQO117D/5N4xRHLTCeJI09et9PPgcTjAWeFEblShZ6IJmFCuxG0RctTV4gmPBZrbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721265756; c=relaxed/simple;
	bh=t5yhdpIjRMe3AfCjqKwYUEx1ML5zKE2IATc9oQSWc2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gz8B7Jrz/MTG/TbldZPEk2e/VtlLUZWYnpaZ5I7BXavCKARxSXrG0KcBr3EUbwWkoCnji0m0JvfeYvjNSrYL5RGOqdMb2TH8b6G9ZgsVeoIZwMvyUiJ9FX/D5JUzC5MNOu7e4yFkWdNCSqyC8OggUrFQMDuLnBFDuliyACHrS/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Z9+gFD8J; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Z9+gFD8J"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UFqos5zfwX9c9UFqps8mfz; Thu, 18 Jul 2024 02:22:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721265752; bh=lu6L/PqJNsRC6c8kTVUaIkebQRiw9XPJs80LIiliL8U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z9+gFD8JsoUHdGQjZxwatv//SOizxagYvz1PsM70fgJ5UQwYpkrUzHQLcDPsKODFU
	 IIceKC/wlqGXPksC24XvT6/s4L0SgouSeqtCbC3UUTUdvjlcfSMiHpPHT6PC0Yocnr
	 ib/gPoTYcZOmiJCwCq8dsS+6mAq83B+CiY3sa/W5hhYpn1HUnOLbeyFqr/G33DUvHi
	 bNgXu43Q+hYellw+0/k/R5vSYUfMvRxfp/FYwv3MasCEIykAk2ER/SLc4EaHmMWpUw
	 RHHZnuOjsdpdiH+NDUrjru2Aq/gbxcHCztcGL8AxOgfXC/6RRvIQk5rvCMQ781um26
	 ZCdzhxnObrWRQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=NPx2+F6g c=1 sm=1 tr=0 ts=66986e58
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=7cjchiuPTnGyAZjgmpIA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <f97198e1-bfcc-4f3c-ad0a-2dd27d4f20cf@ramsayjones.plus.com>
Date: Thu, 18 Jul 2024 02:22:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.46.0-rc0 test failures on cygwin
To: Jeff King <peff@peff.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <adam@dinwoodie.org>, Junio C Hamano <gitster@pobox.com>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net>
 <3e6abe6c-2c15-47f9-89e8-3e8710802562@ramsayjones.plus.com>
 <20240718005723.GA675057@coredump.intra.peff.net>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20240718005723.GA675057@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfJPRQfx3pPIIM9oe/BvSzIeEkDiNr5O/wgAhKCiDrEx0VOoB+fMaNVlfCp2pSODvv27pjg18FS7LKkbs7DMJqz5SJ2l3shW6UXNgZZll6X6X+MRj9KS/
 w/ctPc7bMRhDgLwlzHaWM1VUvVNjS64BMR2TBUw+kZiLfj7lZJk0faU6Z6OzPKOO0wagxqOziLpMRX8E0+GrPlvdVbFpIBMKj2c=



On 18/07/2024 01:57, Jeff King wrote:
> On Wed, Jul 17, 2024 at 07:05:43PM +0100, Ramsay Jones wrote:
[snip]

>> I also don't know the code well enough to answer your question regarding
>> the re-opening of the migrated ref-store, but it doesn't look like it would
>> cause any problems (famous last words).
> 
> Thanks for testing. This is new in the upcoming release, but I think
> it's localized to the "git ref migrate" command. So aside from the
> annoyance of the test failure for you, it is not too urgent. I'm tempted
> to put it off until Patrick has had a chance to weigh in, even if it
> means missing the v2.46 cutoff.

Yes, I think it would be better for Patrick to take a look. I added Adam to
the CC list to keep him in the loop (because he is the cygwin git package
maintainer); he may have a view on the timing issues.

Personally, I would be fine with a post v2.46 fix, but it is not up to me. :)

Thanks.

ATB,
Ramsay Jones

