Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C24A3E
	for <git@vger.kernel.org>; Fri, 19 Jul 2024 02:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354612; cv=none; b=j5wSoPfT5upMYKFVCURD2E90xkM3s/yOWE1JKY3HCBYaRzgkDKy/1PiWzZQJA2sE1miviTWezftwQAclf90D0CjBHVam11nbB9NWPe1fmXMXzt1gxOHMU9ZU8OlHToErmEr+snDXdN0R1K0j7ARSkVFheeNJMyrncfWw0MTRTRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354612; c=relaxed/simple;
	bh=yT6XSVgLeR+pEXP6Y9FPFmnIwaMY02tceWC/J8C6bx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4L0pbhqte4l1HFOMWb211Lt7086cclAqJsI1RNE8W5fJ8gFcASC7zIullxOIVAJ09aYuA9WjWExRiDQgmlfSDQxBX2gj2aAdZeXdYava63R48U193ztqFRQK/hHFS4cKAAb5f9fky23Opc4vrrbD5idxk4oEcd7bvkD4kcMGSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=nMqNSX+l; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="nMqNSX+l"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id UcxrspAq4ItnuUcxssLiWm; Fri, 19 Jul 2024 03:03:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721354600; bh=A6SKFFMXMWnZO2UxxXQouVsU66+YoQzQSTi5xQ7gvwQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nMqNSX+l3lGbh9hHaMxZPJW6eyk6KvClvBoZwcyMQMCCEhEg7Gz4Ol4dj1pn3r+5E
	 Bpw0lqSdxLxxgZMaolPFGLfD0qttqbQ3gIndjv3Ozn0dyQAk5LTOpl/erL3jp7TrO9
	 m5MWdKNIwlQqXI0luS9CoySDf38jcauKCzfxgmShbAv+etSzocO3gdxdEJxvIpS9YG
	 RnRBG4xNyqI0I2aIKCHqWHQuHAgAehpHxphqN8FtThnp6CRtnHHu4n+U3HyMPDetzW
	 O/L2OgMvh51oDOdZUP72U2LCjH8brO0s7zZjsd2GA+o0YBDsc9rG553aFIdNKhDtWy
	 FtJmrZrqzKXCQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=XMWTShhE c=1 sm=1 tr=0 ts=6699c968
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=50FLPVwPNTzhwHH8bMEA:9 a=QEXdDO2ut3YA:10
 a=2GC76e-iCmnkUS7db7cF:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <28fd393a-2d8a-4019-95bc-d1a2e409cf53@ramsayjones.plus.com>
Date: Fri, 19 Jul 2024 03:03:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
 git@vger.kernel.org
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
 <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
 <xmqqr0br26ok.fsf@gitster.g>
 <8dd1a2c7-5b9f-4e2f-9c5a-d5d5758714e2@ramsayjones.plus.com>
 <0e2c66ce-d870-4a03-a26e-a928183b9b2b@ramsayjones.plus.com>
 <xmqq5xt33a10.fsf@gitster.g>
 <a1a771b5-f8fb-40e3-bae0-6307abbce58a@ramsayjones.plus.com>
 <xmqqplrb1f2p.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqplrb1f2p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGK94XkZ68zJTH6vb3OyxjbFyZJZld2PSjVO0bzkHTwwgTS6wXYpTtYLCpnXfq2DJIoV6fdL2n42A2MclmDteCsqAy8pvQBrEh9nflDA7bHqE6BUDYU4
 GrKFr2MjlGTMzVMdojCqmXZSeBw/m3iTOhLq4m8HA4kBnhBU9B93Fwr89N9zxZ9SnIL6JUF36h75K+uOzUJWema6LB9ivRSkvq4=



On 18/07/2024 05:47, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> On 17/07/2024 23:53, Junio C Hamano wrote:
>> [snip]
>>> That's OK.  So in short, with a separate SP_EXTRA_FLAGS with "-Wno-vla",
>>> Luc's patch is a sufficient fix without any downsides, no?
>>>
>>
>> Yes, assuming you're only concerned with 'make sparse' usage.
> 
> Is there anything else in the context of this project I should be
> concerned with, wrt sparse and recent </usr/include/regex.h> that
> uses vla in prototype parameters?

No, I don't think so. At the time I remember looking around for more
uses of VLA's in the glibc header files and finding nothing of concern:

  $ find /usr/include -iname '*.h' |
  > xargs grep -n __STDC_NO_VLA__
  /usr/include/regex.h:527:	&& !defined __STDC_NO_VLA__)
  /usr/include/brotli/port.h:251:    !defined(__STDC_NO_VLA__) && !defined(__cplusplus) &&         \
  $ 

The <regex.h> header has only a single use of the _REGEX_NELTS macro
in the declaration of the regexec() function.

The <brotli/port.h> header defines an BROTLI_ARRAY_PARAM macro, but does
not use it in the header file. It is available for use in your own source
file, but ...

I suppose it is possible that other headers use VLA's in their declarations
and are not protected by __STDC_NO_VLA__, but that seems unlikely. The headers
that we actually use (for the symbols we use), can't include any VLA's or gcc
would complain (via -Wvla).

Also, it seems <regex.h> is the only header that suppresses -Wvla:

  $ find /usr/include -iname '*.h' |
  > xargs grep -n '\-Wvla'
  /usr/include/regex.h:536:# pragma GCC diagnostic ignored "-Wvla"
  $ 


ATB,
Ramsay Jones

