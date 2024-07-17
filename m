Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7E679D2
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721239858; cv=none; b=Lw+O/6t342BezuK5G5CvU7Ff3y6Zh4hNpoqq+jqY5Ix/ZBWDqc68s1ghnXS8h/iiI8EXwF2S+mm39G7Uac0ZWEcoCvY2cP1QhxlHFU0KJKlYF2r/N7WzZpVBp/UGVpW3woMg6qhAqwkf4mEe+x4uytMsmcIS9DsbxJfk0EWPm24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721239858; c=relaxed/simple;
	bh=3tVWgtLLPt09ipA3zKVdB/9EulRB4J+YJ/5ZkGHG+nE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QWxp23rqljQ5GeYJ+PoWlwsq6/E7u76ZI71a6miZU65iBspgWmGHUK8koe4WeseaguibepnqcEhgHThfNO7I4I4ppESp3o7eGMQJaOlmcU2n11C487QAyHj2R91BpIKYox+u26jEqM7pNtMAIPvy+Y/oRWV6bXDYTTqB6H+kPNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=CaOsoEq/; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="CaOsoEq/"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id U975s8AlPH4nFU976sEzJz; Wed, 17 Jul 2024 19:10:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721239853; bh=aDVxbnJNDNUdXtvLuaUm4xvPxZIvXKrZ759+GxhL/9U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CaOsoEq/RNEpLfHUocnwQa5IpfQfXRRIIbdmfqMQIT3Sf7ISvN5oVR5uT0bDoSZOE
	 NRr9O/o/WM7ASKKwUpjKhEq7lFvE/HfZSANgg4J8N+olu64m9Xz+CSLWn521KO1IW8
	 jThRDhvgIXHeutx8hB9TxrJClC3d7YbFlCr4CR6onK7C62HiVVDJVX1BjgjLULIJ17
	 Kjq8xoo7U05VrIGW4R4ATTIxtYIhbBwlSGPx3G9RtfulvjcDeSEiQnDRta24r0klmx
	 /IRhc1YuLGOfhdOM+bxAPrucJe1ERY+mqPwweDRf0tgJ4AElTi4BVuFv4uOnNI/qBV
	 1MGUw4FU0c76w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=f5frB/yM c=1 sm=1 tr=0 ts=6698092d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=7pvHUrw-KBZvzWvVwygA:9 a=QEXdDO2ut3YA:10
 a=q92HNjYiIAC_jH7JDaYf:22
X-AUTH: ramsayjones@:2500
Message-ID: <07a74e5d-f4f0-4bfe-8334-ad6388c10c5c@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 19:10:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: v2.46.0-rc0 test failures on cygwin
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Adam Dinwoodie <adam@dinwoodie.org>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
 <20240717064241.GF547635@coredump.intra.peff.net>
 <xmqq4j8o6pm5.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqq4j8o6pm5.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfLZgjGwQ1EQn3VYBT7DdzVIFMBYjCdClaxKpi5deh2WxRW/g0zUkQkT04FO7y/tfA9c/y90DvfGsVQKQoxmEjk8hNHLWLe8Cb90vOsJ+wE3NH78K5rQE
 sVaDnBfYHTnCHHh1TPwTfHAnWMi2AXFmosq5tbjGHB4bWtWX1tpakBywRHBuoTAXHU1jF8RWKfRaRunHxupjEy0IBxSfgDwx8QM=



On 17/07/2024 15:48, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Tue, Jul 16, 2024 at 08:45:48PM +0100, Ramsay Jones wrote:
>>
>>>   error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.git/reftable': Permission denied
>>>   migrated refs can be found at '.git/ref_migration.sr9pEF'
>>> [...]
>>> Now try to finish the migration by hand:
>>>
>>>   $ mv .git/ref_migration.sr9pEF/reftable .git/reftable
>>>
>>> Hmm, note no error; of course, the mv command may well do much more than
>>> the rename() library function, so they are not necessarily equivalent.
>>
>> This is a shot in the dark, but: could the problem be an open file that
>> cannot be moved? If I run a "ref migrate" on my Linux system in the
>> debugger and stop at move_files(), checking /proc/<pid>/fd shows an open
>> descriptor for .git/ref_migration.WnJ8TS/reftable/tables.list.
> 
> Hmph, I wonder ifthat means the same test should be failing on
> Windows, too?
> 

Since we have not heard anything from Gfw, I had assumed it was cygwin
specific (Gfw uses mingw_rename() not rename() so we should not necessarily
expect it to behave the same).

However, Jeff's patch fixes the problem for me (see other email).

ATB,
Ramsay Jones

