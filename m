Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D02BB04
	for <git@vger.kernel.org>; Sat, 24 May 2025 01:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748049002; cv=none; b=vEZ0pO0g5Rkw48Qx52Q4Es7Iy/nBChKPKIHWOeVkc/nmGhAKh3jnb4S/OASNrSCd12actSNAfdiSyYuwELRBJOirMx+4VZmjq4/s+ybbZ/LKfuVgeaciVUYH9NwVPLAHpTQfeebA7Qnjr5skoc6eOveraw2NrYFjjZAzqnSU5UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748049002; c=relaxed/simple;
	bh=/cebLeaPbinQFCibI3t4TnUmQrq1YHafLvxqgNIZFvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MuAEsIcUCxxsGttenjJRi8kpo/ZzbFqGm0a+t9YXuSq979YJiCed4R90PhTm6qcEWRYH1xhXtY+eAcGPewOyxS0s1+3cPLbPvq/ArFNEhwGf0b4xwJndUuVuVkXrYDGbQAEdvO+7Ey2SD7lNaQoQkKADstPkHgaF03vibZaOToE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=TiezFP9A; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="TiezFP9A"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id IdOXuWtxNJGekIdOZuRif5; Sat, 24 May 2025 02:09:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1748048991; bh=dex2artp8qPAUmgAp341KqSWKUd2PmIqsuwoF5t7OQQ=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=TiezFP9AxNBitR0CDWsAJ8NaQAQBvxHwNroWVkCuhVv0OVJqJa8bTIe5tPLHpp4ZU
	 qDO3Oc8uVtwEhgv40arwExNGbZdBBLZJ/KzrsbZrDyn0Fzho8YmgjZB0I+84h7tIOe
	 Rz1Hxs2lHuDZxS+RP1t++cLdq4cFYHrarSaHhl//JU7btwzsUqcUqbg3RTB/5C4PDI
	 pOemsE3QYyFyBWOKZ5Ka5/wtR8bGUjIxdYxq+bUpSEMPW6OJYxzcKu81A79WrZGkBy
	 mhcjBtKdhmgEUB2maw8cqCLxni3IORls3GJQp4KRk0Hn3x5gJBRZ/KGfthrJ/n3gL8
	 PPY9sbyo6Nsew==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=68311c5f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=_iaoyVl6bAvNuWW_VsQA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <b8a94020-0a7c-4d3b-92bc-a8a80b8d7af0@ramsayjones.plus.com>
Date: Sat, 24 May 2025 02:09:49 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-4-sandals@crustytoothpaste.net>
 <2e8e7eb0-f526-49cb-8f75-379fa7ef6446@ramsayjones.plus.com>
 <aDEDGfyvkTFyf0I8@tapette.crustytoothpaste.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <aDEDGfyvkTFyf0I8@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfEYGCyfTpWG2kipueYvdqlzX2pNmgw5kRFpSsC9aE1p8swMK07u1XktAAQjFc30+HwKp8Ut7Ff6e/kNrXtShMmyfADMSKn3qK5SH2pgtaPqL3QI0EFyq
 LNsL2EM5opiO0HOTAMGmXZOyElMcn8BgtfSimZNpPrNo1xoD1/X4tXuom/q0KBfkrFKOMF0LML9bncIXoYrUFvmSuY8BNYHpWzY=



On 24/05/2025 00:22, brian m. carlson wrote:
> On 2025-05-22 at 21:53:27, Ramsay Jones wrote:
>>
>>
>> On 22/05/2025 19:55, brian m. carlson wrote:
>>> diff --git a/reflog-walk.h b/reflog-walk.h
>>> index 989583dc55..8f0640f662 100644
>>> --- a/reflog-walk.h
>>> +++ b/reflog-walk.h
>>> @@ -1,9 +1,24 @@
>>>  #ifndef REFLOG_WALK_H
>>>  #define REFLOG_WALK_H
>>>  
>>> +#include "git-compat-util.h"
>>
>> Why? 'git-compat-util.h' must be #include-d in any compilation
>> unit before 'reflog-walk.h', so ...
> 
> One of the CI jobs fails if we don't include `hash.h` for `struct
> object_id`.  I don't remember which one.  The rule is that we always
> include that header before any other header, so that's what I did here.
> It is also needed for `timestamp_t`.

The rule refers to '*.c' files not '*.h' files. ie. we #include
'git-compat-util.h' at the beginning of all C files, so at the
start of all compilation units (well Documentation/CodingGuidelines
has some exceptions, but ...).

So, at this point, 'git-compat-util.h' will already have been seen
by the compiler (so it won't cause any problem, but equally it is
not needed). In order to determine if the header can stand alone
you should just need to:

    $ make reflog-walk.hco

[That is what the hdr-check target is for].

So, yes, include 'hash.h' to make the header file stand alone,
but 'git-compat-util.h' should not be needed.

Thanks.

ATB,
Ramsay Jones


