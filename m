Received: from avasout-peh-001.plus.net (avasout-peh-001.plus.net [212.159.14.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D422248BE
	for <git@vger.kernel.org>; Mon,  7 Jul 2025 16:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907277; cv=none; b=StGNwX90No4uQ2X+mhs00ImsFZJMEGtfxU8XArbVBj67pWzngD1tm1P0RRH33Poxk/eA8aJRURZ+m1XhshZhxsnP9CVo5/ZJNizSLZw0nqCCv8BmXzMTxA4JEMWFGjjSmu1eYEZsvPghgcQh0dDI4FlZCNICEzwoLSnBHLjKb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907277; c=relaxed/simple;
	bh=ewp+KOlqCTv9XcKiWiVFzXH9Mn6R3xHhwkoXWoZPY9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h54cU+81Rwi5IWOlQ9vJKPxRby7QnTR8hTDGNi0mq1X5ZUY1+pQvP6LLXP3uy/2BgUfkE4KwfNoHf8ZrjeGLU5K0Zf2O54hL+3se/ASmbJlWqn7DOERwNzK0HKgB7pRPoTyX5quTQuc/x8LTiS4rCxajMQ6m5yItT0QkeiyUAg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=DsXLejFG; arc=none smtp.client-ip=212.159.14.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="DsXLejFG"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id Yp3qu4rkr7HMwYp3ruSrII; Mon, 07 Jul 2025 17:51:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751907085; bh=ZjY2UaHZtF33umVwdzSzEe79sJ1ndX43HYfR9JM51y0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=DsXLejFGTM+XYP/y0QbWmqh0StP7htCn/eeB3kf2sXChHp1cpzdc85TwuPeRHofaT
	 icrwQEsDhhAj6T0ijb4mS4JfmyPEb7ytX1VsL6lZLC2SvUEUenMnoqoTO/rY3s6vCK
	 C6cT4MAWyFR147/DxjiH8swyqzyfINU7Y4JimHKOh6IFDCmbTy5AvNdt8dZ08VtoWT
	 Y8GHdBd53T+NnDJFa1o4IWIIxm1RDWWGBKE2Y93sqhELhNm+ZIgjdardx/oTp4lBSP
	 pmOEp1l+0uVLCADwm6VYQ4OymXlE2PEREg86HrYzX5rjAQJ6oUz9ZwjARFtFGtPpg5
	 y6Nzn2G5JQ6DA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=ZNB0mm7b c=1 sm=1 tr=0 ts=686bfb0d
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=BCjA09oAAAAA:8 a=FaduoGd_yjwJ_Q1EiYwA:9 a=QEXdDO2ut3YA:10
 a=jYKBPJSq9nmHKCndOPe9:22
X-AUTH: ramsayjones@:2500
Message-ID: <ba0a3469-3a4d-44f4-b1b8-d9c1a825cb94@ramsayjones.plus.com>
Date: Mon, 7 Jul 2025 17:51:22 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] build: fix FreeBSD build when sysinfo compat library
 installed
To: Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
 Renato Botelho <garga@freebsd.org>, Eli Schwartz <eschwartz@gentoo.org>
References: <e6a80163-47ef-436b-98a6-2ac39c477080@ramsayjones.plus.com>
 <CAPig+cTybBgkwFEsMVNNu2o1w9T5qnhau4chvGU2opEPJO78zg@mail.gmail.com>
 <xmqqzfdg3t78.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqzfdg3t78.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfAUEm1jRLWvvF212km1E4SDon0UY3meb3QyChLLYR7SvHQF+Ma28QO1dKuUZzGRPyk/SbIfZqQLvHuk7hq2FmTceIxxD+pI0pwMCgdH2GJH1/Z1X3X6D
 EGJQLwoaIguazGVqtJfTxVlZVnPi4dJgTqb/WfSAYolK3kqpF3osYQoRosOof6C9u/SH0SnDnVcn5UnNUVNvRRNRlbc9vtfGGOo=



On 07/07/2025 16:40, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>>     need to link a separate library (-lsysinfo). (This would require
>>>     a similar change to meson.build).
>>>
>>>   - change the order of the preprocessor conditionals in the total_ram()
>>>     function in 'builtin/gc.c', so that the *BSD sysctl() function
>>>     (in the HAVE_BSD_SYSCTL block) takes priority over the sysinfo()
>>>     function (in the HAVE_SYSINFO block).
>>>
>>>   - suppress the setting of HAVE_SYSINFO when HAVE_BSD_SYSCTL has been
>>>     defined (in both configure.ac and meson.build).
>>> ...
>>> The second solution would only be required by the autoconf and meson
>>> build systems, the Makefile already sets the build variables to the
>>> required values (since they are not 'auto-detected').
>> ...
>> The final solution is almost certainly good enough (and is definitely
>> simple), although the second solution has the benefit that it "fixes"
>> the problem once and for all even if someone defines both
>> HAVE_BSD_SYSCTL and HAVE_SYSINFO (say, in config.mak), assuming I'm
>> understanding correctly.
> 
> Yeah, I think I agree with this assessment.

[Sorry for the late reply - real life keeps getting in the way!]

Yep, I thought about including this fix *in addition to* the solution
implemented in this patch, but decided that the chances that anyone would
set both in a Makefile build was practically zero. (famous last words ;) ).

Of course, practically zero is not zero, so we could do this in a
follow-up patch if we wanted to take a more conservative approach.
(Carlos has a series in progress which would conflict with such a
patch - but the conflict resolution would be simple).

>>> In order to fix the FreeBSD build, move the sysinfo() check after the
>>> determination of the HAVE_BSD_SYSCTL build variable, suppressing the
>>> setting of HAVE_SYSINFO if HAVE_BSD_SYSCTL is defined. Apply this logic
>>> to both the configure.ac and meson.build file.
>>
>> Nicely described. I wasn't really following along with the discussion,
>> but this commit message summarizes the situation well, so I can
>> understand the reason for the change and (I hope) the implications.
> 
> Agreed.  Thanks, all.

Thanks!

Let me know if you would like that follow-up patch.

ATB,
Ramsay Jones



