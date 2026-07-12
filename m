Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E639A061
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783863368; cv=none; b=eumuH2cwS37TJLpvTCWOBosxFqGfv3C5x9e3qD2AalJ5sqRlOuhHD11eb/ft+dIpXFULQqLLye6IuQheOkP50wydc7ZBoYprKspzRHnitsQCnLhWDuILipxYFgZFTmrW9jlbVxC9zCYe9vQJ+AXQQ7iWW2TC0KfmfijZabdLk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783863368; c=relaxed/simple;
	bh=CGCnA+ftoI31W3/3U8tdzCcWaUyIDFGeSjtfLmmv+3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMrnF9FwHlccmUoB9uc5snJk4LR1RvTEMRrhVmK6RJnc4uFELV8KJlTh0OE0uNOowzbLDsN3VzTkgfYJs/gMcZMDpoKQCdfNGR1XxmfTtvyCNfbjx4upc+5s+arvQ5dhzGYSF561szKxcTVXgJyhwEfBj1FNftrXqPx1ZC103WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Tku6xgdh; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Tku6xgdh"
Received: from [10.0.2.15] ([195.99.11.174])
	by smtp with ESMTPA
	id iuLbwOmhp9RfhiuLcw8O31; Sun, 12 Jul 2026 14:35:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1783863357; bh=NXAKNH3uEP+GQSksn+iJyXE1Tn+1vDKFotSrVqtxNJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tku6xgdhPMgU5LYHiqmhdYrelXQKeSTnNQZu6VsOh8iTWEGWswXZhIwy2xlQ4hpIV
	 j2UH38XDXxmZQvRjR7XgSZXlY6ecnAOIorDkvcLN9ITJXMqvsCZCNb0Bd3hFcr6mg5
	 5oF7GOUWukyqrjjQrg27sht1jxWZNsgoPiGMMktgQsj9tN/ZR3lnqdlSflxt6UPUn3
	 6F6Rhw1HvMSfcXJXOc9vdghHGCozjrEFs5xyI2xJPtDljHdzhUM7bivSHd5HAsxXqN
	 e0TZeEAk+QEZRxBDWS/Mg5A4nyEgO2PNaA3xrGeTdAau1VwbpgNiJigSMssDO4SXoE
	 wEqUJTCJz3ZWA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=S5R6w5sP c=1 sm=1 tr=0 ts=6a53983d
 a=rWEfxJwGD0TuYe46u5FB7A==:117 a=rWEfxJwGD0TuYe46u5FB7A==:17
 a=IkcTkHD0fZMA:10 a=jE0bcUDjuPr2hFfo9tkA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <94e744f1-12b1-4ba4-8f9b-266c1642b5ff@ramsayjones.plus.com>
Date: Sun, 12 Jul 2026 14:35:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Makefile: fix up lib directory move
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>, GIT Mailing-list <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
References: <0c94331b-7eb1-4116-afa5-811082ad5854@ramsayjones.plus.com>
 <ef422523-1c50-ec79-e89a-f43f02ba1ca7@gmx.de>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <ef422523-1c50-ec79-e89a-f43f02ba1ca7@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFLRcKHR3Eqf3qY0SMPa8Bp+VmMF/sBExtgDY/x5RdFxYztZz5l+adrTPCvZjyGXp9ZxFvNacy0kUlvgMQ+K0EyytjOQPLY9ZrliHxDK6aw5ruvXpI6u
 byyLYcxl3+Je2m/2T8JzD3szbXGWLa0JVS2ZH4USBytiDdIi00TQ3AhUrFblhnVC+PEJzK8V8/f/9hUd+p5rQJCmvq5zZ+x/bRE=



On 12/07/2026 11:15 am, Johannes Schindelin wrote:
> Hi Ramsay,
> 
> On Fri, 10 Jul 2026, Ramsay Jones wrote:
> 
>> Commit 9759608622 ("Move libgit.a sources into separate "lib/" directory",
> 
> It's not your fault, but this commit is no longer reachable from any
> official branch.

Ah, yes, sorry about that! :(

I wrote this patch first, on Linux, when 'easing' myself back after the v2.55.0
release. Then I found the cygwin failures ... :) When I eventually sent the cygwin
email, some days later, I just tacked this on without thinking.

[Usually I send these kind of 'patches' within hours of the branch being published, so
that commit IDs are still 'fresh'. However, even such a small window is no guarantee,
of course! :) ]

> 
> Maybe a more stable way to refer to this right now would be to name the
> topic: `ps/libgit-in-subdir`.

Indeed. ;)

>> 2026-06-22) moved some files into a lib directory, but forgot to update
>> a sparse dependency in the Makefile, resulting in a sparse error:
>>
>>       SP lib/pack-revindex.c
>>   lib/pack-revindex.c:78:17: error: memset with byte count of 262144
>>   make: *** [Makefile:3446: lib/pack-revindex.sp] Error 1
>>
>> Add the missing 'lib/' prefix to the pack-revindex.sp path.
> 
> That reasoning and that patch make sense to me. Thank you!
> 

Thanks!

ATB,
Ramsay Jones


