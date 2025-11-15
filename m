Received: from avasout-ptp-001.plus.net (avasout-ptp-001.plus.net [84.93.230.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A52F5B
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763218702; cv=none; b=jKZ3gXRHZXX9KNimMJYd5i0wyKVj0NwehLmUJUBcLkZwOb3T++E6PpvF+JZ5iK8qMV4P5XB1sVaE63bIl7PJUWeX2kEfYiknQ2DfwviLo6wfz7WGcQrcYLpJm8K96IU4w7Q3uKG1vxPBwWdQwGmRogYhJR+AwfjI3Iurge8RJ+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763218702; c=relaxed/simple;
	bh=nu66D84WZrdkrXP0vT+xOLCl4vUzcL86MGzl5EDjxD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/pB3/U1YQegA4A1iqbXacTN5VD7DHtfyVd5ps6nA9irhkpd+WHCSWmkdRyxy6i1kXfFElwkedegPOw7a/gRmn+XQopJjoHGKLWf9QuhXjfUQUOYIW5zSV6/ycY1kN198i28qR1Ecfv504DG+V6pvFhHX41yMi58dRw0TGB9W0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=i/yfdXPG; arc=none smtp.client-ip=84.93.230.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="i/yfdXPG"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id KHgBvzZUZXnJ6KHgDvZUIy; Sat, 15 Nov 2025 14:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1763218509; bh=XOUnAdWVSJWNNbO5Qnv9y0qd9dN9mwzj4ChHGdXf8jo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=i/yfdXPGZgD943/982CuKbPECydhYu4TDH+6vRSk3AdHt/zHV7zDhXCgsw/Tf51YA
	 0DFy0ZhGWWfkaqesV1/Pe8z5A85R0PbAmMHqM+GNQTqsmQmXcNpk3OOMIc3u/Gssg2
	 ISe9S2UN/hqso91/FcY1kisXsWhtUrZIFJi/DHjckUqPGDA3EWKxash0puck1d5TC3
	 +z6kvc4IGO4ZValqhLKLY3ZqwJyQXgna7waTsorIR5mFDi2wTI8CaJLIIqq+Rs7F1/
	 hUWf1hVwDr4IcvjKXgBdIUfqWSLwIKoVqmMjdfuO6jNi7Hcfp/w06U3t8f9GGyo9eu
	 0M0s6eP2ea7hA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=U40xDvru c=1 sm=1 tr=0 ts=6918944d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=pGLkceISAAAA:8 a=U3HPH2VjuiONbbP2sr8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <a30ad114-61c2-4eed-a24e-033b3b9d6d0c@ramsayjones.plus.com>
Date: Sat, 15 Nov 2025 14:55:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/10] doc: define unambiguous type mappings across C
 and Rust
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>, Chris Torek
 <chris.torek@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <23b7fd8a-2b50-4da3-bc8a-3727ee99654f@ramsayjones.plus.com>
 <5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <5A740EE4-D545-4828-8D38-E0E5E9F87A3E@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfJpgmbLMEhQdlcc+hJuo2C7HQyF44fOAxE24JJpmKUAjchWXXq639G/e6D5bDO5BSR6FEOIlHFMERE1Alc9fRsEuEbyaAWJBfjfH6jGNGHaZsRKMTzl3
 133wPoIoGaEZMWm0YGzsLbCSGF+K/gvuAydu4kF0cQCKk0xkvizEnIfcYFPt1EM+oGy0XeBahHUiMryaaHeV0zzbXqWKzr1Uod0=



On 15/11/2025 3:41 am, Ben Knoble wrote:
> 
>> Le 14 nov. 2025 à 22:09, Ramsay Jones <ramsay@ramsayjones.plus.com> a écrit :
>>
>> ﻿
>>
>>> On 14/11/2025 10:36 pm, Ezekiel Newren via GitGitGadget wrote:
>>> From: Ezekiel Newren <ezekielnewren@gmail.com>
>>>
>>> Document other nuances when crossing the FFI boundary. Other language
>>> mappings may be added in the future.
>>>
>>> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
>>> ---
>>> Documentation/Makefile                        |   1 +
>>> Documentation/technical/meson.build           |   1 +
>>> .../technical/unambiguous-types.adoc          | 224 ++++++++++++++++++
>>> 3 files changed, 226 insertions(+)
>>> create mode 100644 Documentation/technical/unambiguous-types.adoc
>>>
>> [snip]
>>
>>> +== Character types
>>> +
>>> +This is where C and Rust don't have a clean one-to-one mapping.
>>> +
>>> +A C `char` and a Rust `u8` share the same bit width, so any C struct containing
>>> +a `char` will have the same size as the corresponding Rust struct using `u8`.
>>> +In that sense, such structs are safe to pass over the FFI boundary, because
>>> +their fields will be laid out identically. However, beyond bit width, C `char`
>>> +has additional semantics and platform-dependent behavior that can cause
>>> +problems, as discussed below.
>>> +
>>> +C comparison problem: While the sign of `char` is implementation defined, it's
>>> +also signless (neither signed nor unsigned). When building with
>>
>> Hmm, this sets my teeth on edge. The C char type is not 'signless' (whatever that is
>> supposed to mean), it's 'sign-ness' is implementation-defined behaviour. This means
>> that it is 'unspecified behavior where each implementation documents how the choice
>> is made'. In particular, it has to document:
>>
>>  "Which of signed char or unsigned char has the same range, representation, and
>>   behavior as "plain" char (6.2.5, 6.3.1.1)."
>>
>> (it is still a distinct type, however). Note that some compilers even allow you to
>> specify which you want for a given compilation! (see gcc options -f[un]signed-char
>> and their inverse 'no' options!)
>>
>>
>> ATB,
>> Ramsay Jones
> 
> This was discussed briefly in replies to v2’s 2/10, where Ezekiel said that DEVELOPER=1 warned about sign issues whether char was compared to int or unsigned. [From mobile I cannot reliably paste the message ID or link and preserve a plain-text email, apologies for the oblique reference.]

Err... sorry, but I don't see how this comment relates to my email. puzzled! ;)

ATB,
Ramsay Jones



