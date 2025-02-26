Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0861A23536A
	for <git@vger.kernel.org>; Wed, 26 Feb 2025 18:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740596283; cv=none; b=vBxum6g1Xnmo41tthHhjLYp8WYdgK3of5InhuiRK6LEKl2YXvYgLcKmwHT7ukZeeEPuqr2UpKIn+joKJABnmpri1Ee5WNmYmgEr+qkRTPO5ZsfO9peiEfndUt0KGI25O2PxRdguaQlDPPMw6bg1fnft2DoTqMroK2pcBv9CtPBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740596283; c=relaxed/simple;
	bh=DGzz1q2ZeJWc6+lL6FY6176CGfZBCwiVTW6c+mzfphc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BPxLASmSvAZ96zNfPioKgGVc3NJJ7upsgFc0TA+pYuAn1/y45xufkN52PoY6ip1FHiQMG/uL2joX0+fNc02ZhZtILv94CLtil0l6Q5KXECFVqv8jSL/DQ2JGsOTZAqlZCc8nPzTPZtSbQcIrZDhSmeyhkNfrWdiESn97kcScjXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=MAUk30VS; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="MAUk30VS"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id nMYStSL93Crh0nMYUte5iZ; Wed, 26 Feb 2025 18:54:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1740596091; bh=7U0o6PC+ps5Vm7si827Qpa8ImKo3Ix9MWYZMhfe/HOU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MAUk30VSMsT3TT5pi/jks6AyMXUTxOrTaO2o0IDHn5InnHiIZtvZAchJnT6onz4ma
	 3J7U4S8NPReSIBAV4a0yq7UTDKGVR93UGBvfTwYUtLuJWVVeSgJFfV8aZuNl6CEGJF
	 lorh14C78PHCwaUsCG8l9EoBPVIwRvJaTRZyEiJkWobzJBbyYz+Dd+ksfRXn/62s2R
	 TyfYNDO+FJO5eCxUxjSDi8h4ftv2CfcHxBhGo8D32md8b0DzAPeVTSYZQ1QRCr/MpO
	 jo51XP5BBN/cMoTZ1fxUw+8KqSmg9fhIRj/7Oj6k+OZe8K6kI/wmP/4vPbasRiv8IW
	 8qhsDxeLVr6UQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=frB/Z04f c=1 sm=1 tr=0 ts=67bf637b
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=fpCqDA9oVa2uUhFjoEYA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <5ecea6cc-0702-47a7-91de-14aa06757d27@ramsayjones.plus.com>
Date: Wed, 26 Feb 2025 18:54:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] builtin/maintenance: introduce "reflog-expire" task
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Markus Gerstel <2025@uxp.de>, Derrick Stolee <stolee@gmail.com>
References: <20250226-pks-maintenance-reflog-expire-v1-0-a1204a814952@pks.im>
 <543e1914-d05c-4053-916d-e8286edecf50@ramsayjones.plus.com>
 <xmqqtt8gbldf.fsf@gitster.g>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <xmqqtt8gbldf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF1B1gUPVND8tV0FqGT5/05hRQdi3ZFWFganRCGPcTGawyExGHLxkvnj72d6CWNTJHXNopo6tPY9sOG6dLajiBcrYKcaEv/c6mPGE3gnvtNMk2TLxquL
 EQG8iwV2hpkTvCt0rQsv+rgZsbKFtYYvCqpmZrF5hC8twhyYh2357wLK7yoPYh5ZpNGqTk/4gCpQIULvDUhyHNxH+HmfHn38q94=



On 26/02/2025 18:40, Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
> 
>> Hmm, I don't know what you have in mind, but just as a data-point, I have
>> never used, and have no inclination to use, git-maintenance. However, I do
>> use git-gc extensively: at least once (times the number of repos fetched
>> which have changes) per day, pretty much every day! :)
> 
> That makes two of us, but everybody knows that we are old fashioned ;-)

true, very true. :)

ATB,
Ramsay Jones



