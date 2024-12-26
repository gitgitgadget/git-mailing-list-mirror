Received: from mout1.freenet.de (mout1.freenet.de [195.4.92.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9D413CA8A
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 09:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735203866; cv=none; b=VlFaOGPrty/XXSOqw2RZRANqkDrTm6lglrvr56WUoJ4l0T6e3EPPQsrXhkYSy8l7kgPz/Wxb5qI17cYOKYYOGiy9bDIj6M3rBjlgn4Ql5/3MPI0I0ezAXuSaaCWNGKCEHcndOW1lTyoFP7d3Zm3Y92dvXDoOB9ipwV91elQZhJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735203866; c=relaxed/simple;
	bh=YWd+x8Qs/QQK3BydPCuKh2MDxMxytbarBJvGW0ublE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uu1wrQis0BlzY+YEUV9ooF/OYw/HnxFzjjSbnxW5VB778c4K9J6LpejEZo3HxdcmloshH5Z/KWiI6a0AQBvCiKMmakq132jVgTEPxL612z+9yqQ5PVhh2jN5d6X5IA6S+aaHGkZtgelK/5eJacHwnPpW9HrfTRzDI8xqhoCMbDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=QtjoyTcB; arc=none smtp.client-ip=195.4.92.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="QtjoyTcB"
Received: from [195.4.92.124] (helo=sub5.freenet.de)
	by mout1.freenet.de with esmtpa (ID soekkle@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1tQji1-00CU2w-Sd; Thu, 26 Dec 2024 09:59:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N8oKhh76u8dpTnlJL+3dha34OSZ88SyMzjYHl1c9AjY=; b=QtjoyTcBMuWUBbBzgfo0OGzEfi
	vwt5xd6kKZQwrTnVF8cAli9uaL4zIuNggNtUpz17T1xuG7X5pX44ibEHHOxU9P6fCOt3gu4qKj6rc
	0r33vzV8FMuJUCI5usyfK0NAWckywr/wSyQ9g45CPd78+JtH5fm3QKRa3ud53OuvqRJsLkcnde68E
	1zAuFT0TTJeOez8myUg7jOqAJea2xYJ15TQ+2Jx8w9M/cV5qnagnfvYTLzuon1stIt6DqvWMJbDtQ
	we7dkwtTYR8CL9nLsTdy+qlQ2WmVpK8zaSh+4K6ud/QV/HrPEklNha6fvtDVChtqqbAhcmAeQcfER
	7/kQt36g==;
Received: from p200300e2e705fb00dacb8afffee0ca63.dip0.t-ipconnect.de ([2003:e2:e705:fb00:dacb:8aff:fee0:ca63]:34036)
	by sub5.freenet.de with esmtpsa (ID soekkle@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.94.2 #2)
	id 1tQji1-005hBZ-Jm; Thu, 26 Dec 2024 09:59:09 +0100
Message-ID: <c2381e2e-ff13-4549-ba42-75f77775c99f@freenet.de>
Date: Thu, 26 Dec 2024 09:59:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Fixes typemissmatch warinigs from msvc
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <20241223110407.3308-1-soekkle@freenet.de>
 <xmqqmsgm1hku.fsf@gitster.g> <xmqqikra1gux.fsf@gitster.g>
Content-Language: de-DE
From: =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Autocrypt: addr=soekkle@freenet.de; keydata=
 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
In-Reply-To: <xmqqikra1gux.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1735203549AE335CC482C1O
X-Originated-At: 2003:e2:e705:fb00:dacb:8aff:fee0:ca63!34036
X-Scan-TS: Thu, 26 Dec 2024 09:59:09 +0100

Hi Junio,

I think I undersand your first mail correct, that this is only a code 
quality change and not a bug in the code. And so it isn't critical for 
git 2.48.
In the future I will send some more commits for warings from msvc in 
git. MSVC print more the 1000 warings.

Best regards,

Sören Krecker


Am 23.12.24 um 17:52 schrieb Junio C Hamano:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Sören Krecker <soekkle@freenet.de> writes:
>>
>>> A smale series of patches to fix some typemissmatch warings from msvc 14.30.
>>> Most of the missmatches a 64 to 32 bit conversion on a 64 bit Windows platform.
>>
>> Thanks for the patches.
>>
>> I'll welcome other people to take a look, if they are inclined, but
>> it is not something I'd want to look at during a pre-release freeze.
>> Nobody sane would be running "git add -p" on a patch that exceeds
>> 2GB, for example, so the only practical thing they fix are compiler
>> warnings.  They are worth fixing eventually, but not all that
>> urgent.
>>
>> Thanks, again.
> 
> Oops, sorry, this didn't come out quite right.  I didn't mean to say
> that this contribution is unwelcome.  I'll get to it eventually
> (like, after the upcoming release), but please do not expect them to
> be merged before the upcoming release.
> 

