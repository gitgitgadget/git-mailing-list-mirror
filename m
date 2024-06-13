Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DC2811FE
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 23:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718320694; cv=none; b=lHbmyzF42KeZ4KQeWZ6sKPqiMS2FA0z/i+6MjWE635+xMkeFbyKKp8XBY8njuIYreBQHsICbql0fmsyEguEWRvRRQUzbGmLeFuiaHKFDOs4oUTiBbz4Mnwkas+Q0gC8HbwhbeDIfnXr3eQmkXEk46IPCZw+kb5y3L3POo6qtKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718320694; c=relaxed/simple;
	bh=QSobSG+qn3KBbduYZOJoz5w9j8og9dhr+k6DBuMRPpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwQsf108xzuFzMbGNBYyBVSnurWGDOFApvJQqHYLROfPVcnTH4nWWo94JpX1tgd3dSC2XIgGZqBLTzqTyQcvrUhWwXZZghQSZ+7TEww+nc+tCIay5JkTTjwqrvx8F/MAjmZz5Ebg23ZAqecXbBs2fglciT6l7hlRgSnz8209fW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=QSJzZwAf; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="QSJzZwAf"
Received: from [10.0.2.15] ([51.6.185.229])
	by smtp with ESMTPA
	id HtelsISnadfdlHtemsIjIx; Fri, 14 Jun 2024 00:15:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1718320501; bh=t01ItuV7amPl/0A1siMnbgHRca2gNtJmjkpk3v0e7fM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=QSJzZwAfccxjA5K8MNjglfNbz03ginx6qMGjqCtxeHkZyYPWE9PCvBoofQp84T4IK
	 9GA1cO/3xzCeymDVVDuo9BuO+dEgA5MZuoagRXxjkM0DNRtHmayCqRe14wR34qf5iP
	 YOishVtcBF6JgL0Fo4UcvWhsc/gieAEPiqlZ1ZDyhMF5u+nnoaCg7Tc4it0Ayd2Rsw
	 WaFHxrJWJJbXUfo1nEfyl6LkfkJEggWKf/Kzzez+53fggguONGE4fNWN5YKHVCmqIk
	 GWOJ27Pem487lwcqR0atFhQWfVush9wmlE6V5QDPMA/Qd1hHqKi4obursN+/O0PYNb
	 roiNb/MdTKatQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=DtP1+3/+ c=1 sm=1 tr=0 ts=666b7d75
 a=7htyVA9VkOexEuxjfJyH6w==:117 a=7htyVA9VkOexEuxjfJyH6w==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=Zonxl2ovAxeDah0vPicA:9 a=QEXdDO2ut3YA:10
 a=dmR7ekUwijcA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Message-ID: <b69449d0-46f4-448e-b80e-002a8b5c4e1f@ramsayjones.plus.com>
Date: Fri, 14 Jun 2024 00:14:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/20] Introduce `USE_THE_REPOSITORY_VARIABLE` macro
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <cover.1718106284.git.ps@pks.im> <cover.1718259125.git.ps@pks.im>
 <xmqqcyoklo26.fsf@gitster.g> <xmqqfrtgk7ah.fsf@gitster.g>
Content-Language: en-GB
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqfrtgk7ah.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfFQORb0pLnFntEFdo8pKB7sfQPg7jEYXnuQdzLPLoXRtGp2TY/gB97qCtU9hCVMY01HeGB6ym6bncUXPLW+z0ZFFTjyVUKHATJtN3EYdIUcApv0nh0bL
 dohzEZngSFzZnesDzyyUBCJ2zFqwITVseq7r8bkR8FFTLraLWPxd+9p/TD6Yc8/wh6zq/BHy0dOBNw==



On 13/06/2024 19:48, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>>> this is the second version of my patch series that introduce a new
>>> `USE_THE_REPOSITORY_VARIABLE` macro. If undefined, then declarations
>>> like `the_repository`, `the_hash_algo` and a subset of functions that
>>> implicitly depend on either of these are hidden away.
>>
>> ;-)
> 
> Two things.
> 
> (1) This stupid change was needed to please "make sparse", or we'd
>     get this:
> 
>     repository.c:21:19: error: symbol 'the_repository' was not declared. Should it be static?
>     gmake: *** [Makefile:3259: repository.sp] Error 1
> 
>  repository.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git c/repository.c w/repository.c
> index 95d10cc4a0..22ef85b0b3 100644
> --- c/repository.c
> +++ w/repository.c
> @@ -18,6 +18,8 @@
>  
>  /* The main repository */
>  static struct repository the_repo;
> +
> +extern struct repository *the_repository;
>  struct repository *the_repository = &the_repo;
>  

Hmm, odd; isn't the declaration of 'the_repository' from
the "repository.h" header file visible at this point?

puzzled.

ATB,
Ramsay Jones


