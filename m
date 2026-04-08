Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAF3537DF
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775667700; cv=pass; b=cZ3ftomuaDmUqL0EL0t2fi/Tlj3hXVURUEPSKmMXIqHmwhbJIR01u0qi4ZBPFGOYZfWvu0w/e8XFMueI+pAwD3DNn8g8vwUz65KtXvB9Wtpfb1fwpgnq0cV8Kyv6IhIjEazUDaquzVaZXfu3jDg7JsNluFKrHMg6Y2BRjzwkHys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775667700; c=relaxed/simple;
	bh=ahWxAYi/o84w7J1m0TFYvrNGoViWS4b7PkVneQEty5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=P7dPiVdJ2P/CJH3IKFrUjRaHChjtldQYS//4WeUEvsmd+bPZUmnAZOtzmKWtPPC0Ed7Sb+aptGexPRSY0mZE1VI507zRy8Uq//drlxHx9v3u8zw9YELrBC3LW0Kbgn35qLPlMhh2c+uyNmGmNbVny1fXtH7uK9+gImDeAagSC18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bcTd46zO; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bcTd46zO"
ARC-Seal: i=1; a=rsa-sha256; t=1775667691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PJjFYniEDWQtXOwq2/4kGWNq54mPM63qu4dPxUwvFYRjRUh+DWjIGB8kmXCXtiB84eSx9TNNlfTh6FZTOLmIkDslaarwdhfCcsq50f27MST7FfBU3ejlHx+uIzyL8N1epkqlJtPGhNNnda3sjOIPKL4foVWpicUF741oXqBT9kU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775667691; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ExC75DTdOE39DWXVuH5eGnF6wwXTU4Nlt2b5T8dn/uI=; 
	b=KjcpBoHYZwBaRn1wcgm2Dbi7wKt46AsxDiQ7ZFgKnrAXYlHQrJEE3RV7iAcmWXnRfFSiu/Y67uqSc4EgPDE0Q9RekRWPkwaT8Lodn6Ha2CLoAx5+rhqAHT9Ol2CeQZuInQ323JBOhghRCY/s5sYvNuOLGP0JyZyRFpAUZO55SEM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775667691;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=ExC75DTdOE39DWXVuH5eGnF6wwXTU4Nlt2b5T8dn/uI=;
	b=bcTd46zO15A5fSXqoaO7kQzVegS4t2xuPDNIVtjoDqi2niOPvcO1IvRUkwdhtbQJ
	OgY+TZYcIpbURHukk7IKFzvPo87bl3fHxsYoMEVqoS+zEq/Vrm/bIvjzXfEiX6qZA+f
	1m11vzffX9CWtGmCiI2HJ7S7tgvH0bHYPe8hFJ/A=
Received: by mx.zohomail.com with SMTPS id 1775667688900486.5350672964074;
	Wed, 8 Apr 2026 10:01:28 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, rsbecker@nexbridge.com, git@vger.kernel.org
Subject: Re: Help needed on 2.54.0-rc0 t5301.13 looping.
In-Reply-To: <xmqqcy091jht.fsf@gitster.g>
References: <00f501dcc6e7$8ef295c0$acd7c140$@nexbridge.com>
 <20260408052031.GB1324339@coredump.intra.peff.net>
 <20260408054347.GA2284358@coredump.intra.peff.net>
 <871pgp3byq.fsf@collabora.com> <xmqqcy091jht.fsf@gitster.g>
Date: Wed, 08 Apr 2026 20:01:25 +0300
Message-ID: <87v7e11j4q.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Wed, 08 Apr 2026, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
>
>> Thanks Peff for the in-depth analysis, fix and test.
>> It is very much appreciated. I missed this case.
>>
>> I agree with your assesement: this must be fixed regardless if it also
>> fixes Randall's case or not (might be a separate root cause).
>>
>> I would proceed like this (obviously crediting you for the fix & test):
>>
>> If it fixes Randall's case:
>>    send a standalone bug-fix patch, then integrate the test into the
>>    parallel series.
>> else
>>    integrate both the fix and the test into the parallel series.
>>
>> @Randall please let us know if the fix proposed by Peff in the other
>> response works for you.
>
> It sounds sensible, but a standalone fix early before 2.54 final, as
> the problem and the fix shown by Peff here looked correct, without
> waiting for NonStop may be simpler to work with.  Then, rebuild
> parallel series on top of the 'master' that has the fix applied,
> perhaps?

Yes, that is the path forward now that Randall also confirmed the fix
works on NonStop (btw thank you Randall). :)

Just waiting for Peff to tell me if he wants to send it himself.
