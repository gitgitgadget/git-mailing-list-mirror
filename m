Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3C11EFFB2
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 22:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751495848; cv=none; b=ii0kF9+Ln/UGnYLlB1DM2uu1RgNZ62iQgtOsDgAg22WDUTUiJc5IZAYvsXa/ixZbAeZa9KnGZCVB/lfJqg2u4bh7EkDSJEK6NrH285Wx7U8nK1VNOnxfbyZauRxVHCM1xVAno/icLHe9kiYZDtWUzzsCfjjMc1mZERzhHMIvDv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751495848; c=relaxed/simple;
	bh=rcwtxBTQTvC6gGKOF37ho/C2LUIH02gdaxDYCTCHezY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilDNRncrFBBThSxcOwNdCvzU0akQpAVHdU3P7pC8VtWzIWuRdBr27kntQH4GtOj87eeS4xph9JVJWmGjhym4ZOVS54AGyWqygvcgpV1NlX4S8/ehy1pF+tgueY6gBKUsORvg9QJ2+YRCrsmPqQPDoCPF0b5eBFV9HJhoxcBRAdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=f6f/7ecp; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="f6f/7ecp"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id X64xuyYTObccrX64zuWw0g; Wed, 02 Jul 2025 23:37:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1751495845; bh=rcwtxBTQTvC6gGKOF37ho/C2LUIH02gdaxDYCTCHezY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=f6f/7ecpTFdsFAgAZG5grc+EhDfl8SGFVXvMBGehVoyxh8RkSmGROcj/crCFH/fAm
	 Fruk3klwRfdGmtIcU1sjqqN7kuzNlXqLrhynLhWpF0meOLIkO8syup7iiVU0u9N6tn
	 ecQjAXhtDkaRXHY1l8OZ3gCeOp0Ozr4UdwSQTEmQJsQTEM2j6Thdz0vR6bn23uRgcV
	 DfapMC/RAAqhnYaKpNj3JMhSqC5RreDqfXIA8rtimR8HpFc+4Xhv4g+9waQXLE+lqB
	 6njEG0ZZpdKY5WfpwnOoCSijxQxsFdwRg8O+StkVIpcg8SfKe5krH4rwTpEhWdZh/X
	 0tqhan/Ld/7uQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T54vTOKQ c=1 sm=1 tr=0 ts=6865b4a5
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=6I5d2MoRAAAA:8 a=t0GH1tZww8coZ9w2IOwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <1993f24d-4433-427a-a834-360f6a9a963a@ramsayjones.plus.com>
Date: Wed, 2 Jul 2025 23:37:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: build is broken on FreeBSD if libsysinfo is installed
To: Renato Botelho <garga@FreeBSD.org>, Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>
References: <f32292e0-4c99-47d0-8eac-21dbc5aca302@FreeBSD.org>
 <9dce7213-0b8c-4636-ab37-4c26081aedf4@FreeBSD.org>
 <d3b912ca-ba5a-4b56-81d1-0e8a10055d83@ramsayjones.plus.com>
 <818958f6-7387-48f8-a0a8-c050af212069@FreeBSD.org>
 <xmqq34beed0q.fsf@gitster.g>
 <39e370f3-5113-4feb-8a19-2cbdba6c17ce@FreeBSD.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <39e370f3-5113-4feb-8a19-2cbdba6c17ce@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGm/kFEmsrjRlZUgCEm0GOZv4blEdWOUgU4kMiOBRomCtXCqPx2SFjYjBVVv2TbdPEOqTNL7GUTisln1zsUotHzaT0cA92C7FSSexwxHXLwnxtysyWSM
 li6siLBypORYGBQemdn3H3IOib/R++fzgqwTqeldM4co0mKozYoAiSrxlkP3KA34cjJmzLWoqI5Kqele1b0zrVOim67tRD+r8gc=



On 02/07/2025 20:48, Renato Botelho wrote:
> On 02/07/25 14:08, Junio C Hamano wrote:
>> Renato Botelho <garga@FreeBSD.org> writes:
>>
>>>> I very quickly knocked up a patch to do the last option above (I
>>>> moved
>>>> the setting of HAVE_SYSINFO down the file rather that HAVE_BSD_SYSCTL
>>>> up. I guess it doesn't matter, but I gave it *no* thought!).
>>>> The patch is below. (I didn't write a commit message ;) ).
>>>> Does this work for you?
>>>
>>> Your patch works just fine for FreeBSD.  I tried it with libsysinfo
>>> installed and it just ignored it, as expected.
>>>
>>> I didn't test meson build since FreeBSD ports is based on autotools yet.
>>>
>>> BTW, should I start moving the port to meson?  Is it the default build
>>> method now?  Is there a plan to remove autotools?
>>>
>>> Thank you!
>>
>> So we have a bit of loose end that needs a finishing touch, but
>> otherwise we are good to go?
> From my side, yes.

OK, I will write a commit message and submit the patch to the list
some time soon (I'm a little busy atm, sorry!).

ATB,
Ramsay Jones



