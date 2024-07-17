Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBDF469D
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 18:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721241643; cv=none; b=lAij6B18mni/HQWrFG+Tn+98XppqjGO+kSFdJY1AQrPOZKM1uUgsjH/HkRZUt7khuJLYRq6BvjdUsDNlaFeoFQ46ikINDGp6jcPr3oHp/OHnfU1Icv9VmgnDwSlhM9WQo0IQY4dRGENNrqi2S8jjpYu1+OnlkcNUq1ZeQOKK//Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721241643; c=relaxed/simple;
	bh=wPZQS3kDMS4nLkG7EOWprHvQ9lyDC54nl61W9UjAjMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfOeeCzX7HB/Y3QQdXoiwxayn3wLUsG0LVPDbUiOnYAjMPg3KZFSPqLuVVIlm+ZZHfgMw/7hopvhI0vmfxiI97dKXSwm/AQS8wZPfQf6Gl84nicbAmIkMKzvn+wVLeRUQ+5q9qFGmXfWqwCzm+nVJFs3YcqFScH0bfRdZgh0gA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=ND7MDrI0; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="ND7MDrI0"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id U9Zss8ClIH4nFU9ZtsEzQq; Wed, 17 Jul 2024 19:40:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1721241637; bh=3WE+mVyUY0l9Hgn8fcy3TUwsFp0KxCbd2J+xXobQX0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ND7MDrI0a7XuOXkDXpTDZvwbeuIa6uu/mAuJYoOD6UGtcA9M1hza4/mxPjX0U9Qgd
	 prbeNpyBg8ULlIa1JIi7V27ShFg+J7MP3wOK2E1umSue7iKEgciJJLXhk1f7/m3sJf
	 Fg0s0BSN2Hg02hI5CNjDuJp+TRtEX8RmWSS44ieyg+3z5UJPCjGS+Da+ziBjMKuKXS
	 b4dXUK3vOI4Ndp5yvoYVIL02sWYV4bRFHRzLgbGphyvO3Y3KzatiHzcJSR+clU8ywe
	 3e/3EdAiPwdp+ndv6n0OM5qtJULx2XFOY0VmLg7GDIF5eWUssHS/y4b0oRrU8fEtiA
	 Wd7qO/cbdReQA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=f5frB/yM c=1 sm=1 tr=0 ts=66981025
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=EBOSESyhAAAA:8
 a=Vg_4iHZ5JzF9fvDOAEcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <9bdac465-5f43-42de-9cad-e6c43a5a53cc@ramsayjones.plus.com>
Date: Wed, 17 Jul 2024 19:40:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparse: ignore warning from new glibc headers
To: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc: git@vger.kernel.org
References: <a667da3985a0fe943cc0ff6ee8513d731d75a299.1721171853.git.congdanhqx@gmail.com>
 <xmqqikx42c42.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqikx42c42.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBAWvnzXmrHE3IZzttpppcuhAJnsWMCLv7DhkquyKIL1Nz+g267vZyAKC38fVRPE+q+F1vPhHuAmoIrXEMW5ZzY5DGdnkZDn/ohzK17xJXz+6xOFzki8
 ApwTmF7PNioHvuevbOmtBiZ4PdMLIqmO3z12ubs09Yiowj8C48AYHrClU1qhvdHU/NUG4c3xPPa3BcNLJ+7qdW7rR0BZu8/Gx0c=



On 17/07/2024 17:54, Junio C Hamano wrote:
> Đoàn Trần Công Danh <congdanhqx@gmail.com> writes:
> 
>> With at least glibc 2.39, glibc provides a function declaration that
>> matches with this POSIX interface:
>>
>>     int regexec(const regex_t *restrict preg, const char *restrict string,
>>            size_t nmatch, regmatch_t pmatch[restrict], int eflags);
>>
>> such prototype requires variable-length-array for `pmatch'.
>> ...
>> Thus, sparse reports this error:
>>
>>> ../add-patch.c: note: in included file (through ../git-compat-util.h):
>>> /usr/include/regex.h:682:41: error: undefined identifier '__nmatch'
>>> /usr/include/regex.h:682:41: error: bad constant expression type
>>> /usr/include/regex.h:682:41: error: Variable length array is used.

Yes, I noted this about 2 years ago! If memory serves, it was when the
libc6-dev package went from v2.31 to 2.35 (well 2.31-0ubuntu9.9).

As I said at the time, this only affected glibc platforms (so not newlib
on cygwin for example) of a certain vintage, so I just added

  SPARSE_FLAGS += -D__STDC_NO_VLA__

to my config.mak file.

> I get the same with 
> 
> 	$ sparse --version
> 	v0.6.4-66-g0196afe1
> 

I mentioned this problem to Luc on the sparse mailing list[1] and
he produced a patch which 'fixed' the problem in one way, but
caused a different problem[2]. Namely, because git passes -Wvla
to gcc, it now issues the 'used vla' warnings, which gcc does
not because of some '# pragma GCC diagnostic ignored "-Wvla"' which
sparse does not honor! :(

So, his patch was not applied in the end.

ATB,
Ramsay Jones

The sparse mailing list archive can be found at:

   https://lore.kernel.org/linux-sparse

The messages below were from December 2023 (approx. 20/12/2023)

[1] Message-ID: <6f853a6b-9ac3-4bfd-a968-89d43fbcce2a@ramsayjones.plus.com>
[2] Message-ID: <24cb6194-d04d-4c80-bd95-4f7356667884@ramsayjones.plus.com>
