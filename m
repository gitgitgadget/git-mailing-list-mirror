Received: from avasout-ptp-002.plus.net (avasout-ptp-002.plus.net [84.93.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28531E480
	for <git@vger.kernel.org>; Thu, 15 May 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747338812; cv=none; b=f9dPth38usayi+p+PVJenZbScHNGT+mspA/KV51zKM9K005N4IlsUsj293oydBxUJcqlGXVO6uoezSdK1bDdUmqWq81cJOZ9mprhrOzMlWWh32z+cb4bbgfDnBv+TkVQNJ6BCAVKfcLwp2MOO2J8TYcdu3ymC+n0diuXViSAm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747338812; c=relaxed/simple;
	bh=/frqwu2eN/5yr73sf8FOF6qk4ufUVwZKBCCvlPGOEEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pGj7CFNXWapTZj7oLZ7nxnxY6038/IljKWTIifnUN5iGcbLABRT4HWHEeo8k8YJdCJJK/+pZ7pLqZPwYimAdYxxXfOQH0jd97cjhhCRtRA2T4BEEn64MHtfquF3VHIO6XmdaIBG0T0BeE3XbGC6sfhbItSL+wszGVaEimoAuyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=kCG+xlqe; arc=none smtp.client-ip=84.93.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="kCG+xlqe"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id FedpuDr6gJGekFedruOpcy; Thu, 15 May 2025 20:53:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1747338799; bh=xJq0Y/GmMbqevzdGy1rXUiqks3GIKITVE499IRljCYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kCG+xlqepHn2684alVdSIt4w7OWzxyUZkGRCxbEQvor2EW51Ci7UZjYwAJMyOlte5
	 wLs/10FevnkfwOybOFLRhB4PpjOWtMyVO5aDqOaPVmLrVD7SSdKrng1AnuuHMxavzy
	 N9OTk7qHgNHV1ux0evXWAjPY3V1D/bVvEtEa/7d6EsIU1pDb//iPsohclY7DUWsEzH
	 b2MkFCbFu8Df7cIywf9CHgjAsjMgKERNBNAF7BOEzPv3tZ+BDsWpUz6X+1bLMkAX+I
	 3xEIK7MSlKqfrEBGn7nEhFSVfrZyonhe2145KB2qfWKn8td9nlo1R3+m319KQDHgAn
	 WHLI1Cg0AbeBA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=FoOm/Hrq c=1 sm=1 tr=0 ts=6826462f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=PmL3lo4JB5JHZJ8xWO0A:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <411ba125-68f3-4874-9fce-6f9f83eabe8b@ramsayjones.plus.com>
Date: Thu, 15 May 2025 20:53:17 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] meson: correct path to system config/attribute
 files
To: Eli Schwartz <eschwartz@gentoo.org>, Patrick Steinhardt <ps@pks.im>
Cc: 'GIT Mailing-list ' <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-1-ramsay@ramsayjones.plus.com>
 <20250513191739.1513460-4-ramsay@ramsayjones.plus.com>
 <aCQdznsNfaIeSPDI@pks.im>
 <a163d515-2e71-4a42-b843-26d5d2ccdc59@ramsayjones.plus.com>
 <8ca4ebd7-1058-4694-ba50-baf248b45050@gentoo.org>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <8ca4ebd7-1058-4694-ba50-baf248b45050@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfHJIRR63JZkZyPsiT/klm0MprXNCeRMeGZxCO1+TFAFroCMNYMaoTde7nDsFShmkIMz1g+oop1ritwwNl5m8ycn6qHkie4SU8GmQFKoJ00vcWyCi9i5p
 X2jn9+vvJn1VBGi36vRQeF9Co1TZguEHatiDwH0lRyDPPAJFjuhkjjfgl8qwqZQeSJFDxPcAwrg5M2FzAClevj2S0L0+TeCdpP8=



On 15/05/2025 18:51, Eli Schwartz wrote:
> On 5/15/25 12:42 PM, Ramsay Jones wrote:
[snip]
> Well, so-so.
> 
> 
> eschwartz@acleverhostname ~/git/git $ meson configure .
> 
> meson.build:208:0: ERROR: None of values [] are supported by the C
> compiler. Possible values for option "C_std" are ['none', 'c89', 'c99',
> 'c11', 'c17', 'c18', 'c2x', 'c23', 'gnu89', 'gnu99', 'gnu11', 'gnu17',
> 'gnu18', 'gnu2x', 'gnu23']
> 
> 
> But also,
> 
> $ sed -i '/c_std=/d' meson.build && PAGER=cat COLUMNS=80 meson configure .
> 
> WARNING: The source directory instead of the build directory was specified.
> WARNING: Only the default values for the project are printed.
> 
> Core properties:
>   Source dir /home/eschwartz/git/git
> 
> Main project options:
> 
>   Core options       Default Value        Possible Values
> Description
>   --------------     -------------        ---------------
> -----------
>   auto_features      auto                 [enabled, disabled,  Override
> value of
>                                            auto]               all
> 'auto'
>                                                                features
> 
> 
> [...]
> 
> 
> I'm not completely certain why this evaluates as an empty node:
> 
> ```(meson.version().version_compare('>=1.3.0') ? 'gnu99,c11' : 'gnu99')
> ```
> 
> 
> but it (meson configure) is part of the AST interpreter, not the runtime
> one, which I know less about...


Ah, interesting. When it came time to test this patch, I spent about
half an hour trying to get 'meson configure' to tell me about the
project options, because I had a distant memory of having done it
before at one point ... :)

Hmm, maybe it was before commit 13cb20fc46 ("meson: fix compilation with
Visual Studio", 2025-01-22). If I (effectively) revert that commit, then
'meson configure' works fine for me (you don't even need the '.').

TIL. Thanks!

ATB,
Ramsay Jones


