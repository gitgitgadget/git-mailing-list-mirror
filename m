Received: from bsmtp1.bon.at (bsmtp1.bon.at [213.33.87.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C654C433A8
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 18:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248144; cv=none; b=donwoKzQZvCHKPEMo0jIY6GZrJuq56J5jyMiJAXRudz4gbj8s0/rvv2BcfPSCaFVVSim6Y3PkWmbAkGYLp0xv9mmm6+SjZew4fLXUzqEQ+S0QI75cQ2RDuTUtWf5DTb4Nqf7saH8A4XQg+GTSGLpuxNfGZ4i8dzx7Omc91lgCp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248144; c=relaxed/simple;
	bh=ZH/4zVTqoJ34fPontz48ubNvoT1X+N79FB6/b+q8nBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VZbrr0SzIp1F29wvmLf2aJIwlk7bJjSJ+x49JZ4TGsm6Oj6ASHMFo29/jNzXO5P9sq/0ZFJcUYhJ8V4oxUvRyc+YdByiY51y34EvbPkVM3zsAOgtqRa+bwVL2xM2rD19EGTL2P0rVw6H46VIKLmhD0qFrBex3HRTWpTbUoije7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.112] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4Z0ZtG2RV6zRq1R;
	Sat, 22 Feb 2025 19:15:34 +0100 (CET)
Message-ID: <85d3318f-5e5b-48c5-8ba0-27465a2e733f@kdbg.org>
Date: Sat, 22 Feb 2025 19:15:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] userdiff: extend Bash pattern to cover more shell
 function forms
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Moumita <dhar61595@gmail.com>
References: <20250211114611.9334-1-dhar61595@gmail.com>
 <20250218153537.16320-1-dhar61595@gmail.com>
 <20250218153537.16320-2-dhar61595@gmail.com> <xmqqy0y3jbjk.fsf@gitster.g>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqy0y3jbjk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 18.02.25 um 20:30 schrieb Junio C Hamano:
> Moumita <dhar61595@gmail.com> writes:
>>  	 /* -- */
>> -	 /* Characters not in the default $IFS value */
>> -	 "[^ \t]+"),
> 
> We used to pretty-much use "a run of non-whitespace characters is a
> token".  Now we are a bit more picky.
> 
> Which may or may not be good, but it is hard to tell if it is an
> improvement.

It is only a stand-in, because every built-in userdiff driver must have
a word pattern. See the old thread here:
https://lore.kernel.org/git/373640ea4d95f3b279b9d460d9a8889b4030b4e9.camel@engmark.name/

-- Hannes

