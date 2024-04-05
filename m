Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D2B172BD4
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345778; cv=none; b=uNi9tgRBo9ZcXsyp08RJqyRFn8UUhRKyOG+Fl6awu+Bs0sYJxJllXAU38dIxb7Vcyqa9OEkZeWeZWE86vpJw1L4rB3wII36I0j3nzdikRgWUarBrxgmmdVyVkDz8kydRSp/i/Sc2Ts/TmFjImpQRNJuaBp42Mpop3vdin7Txooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345778; c=relaxed/simple;
	bh=nVA9ev9it3qBQEbrC6EKl3lLb8y/kHpZCu07KpeAdeo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u3JanD7UXAZY26P6hh5ofdFcvDG0myzfa2p8F8FZ1zLLyKbEYO1MevmSOu1TqjKICccjkmY4nIyewZgXtz3CdaB0mqh2EyYa4wMyAeFS7oIUNLBWi6m8lPpn2G/ddGbnVXHt+xeROKpkdev/N+VF2Tai9tb+HiKFkdY3lpERnMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=i7YUQHTx; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i7YUQHTx"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1649426057;
	Fri,  5 Apr 2024 15:36:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nVA9ev9it3qBQEbrC6EKl3lLb8y/kHpZCu07Kp
	eAdeo=; b=i7YUQHTx1SuMOZB67knz0fPCecSXyS/YskZCtbmUF0YMTJgcnkq7o3
	tFY9nDqy5EFHOjLOCIRL6NqMAViMM8pnP4viBuE82m0UjOeb+1/TQlCCgsR36NVH
	GvIf9NA3R3hTgy1Aq46yb0xpdYWvR419W2Zez1PhGWLDSt7QiXJ2A=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E3BF26056;
	Fri,  5 Apr 2024 15:36:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 94A1126055;
	Fri,  5 Apr 2024 15:36:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] CodingGuidelines: quote assigned value with "local" and
 "export"
In-Reply-To: <20240405174859.GE2529133@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 5 Apr 2024 13:48:59 -0400")
References: <cover.1712235356.git.ps@pks.im>
	<c2c2747ff57f68ccad8b509af037e1fc4a524fa1.1712235356.git.ps@pks.im>
	<xmqqmsq7yezc.fsf@gitster.g> <xmqqbk6nyej1.fsf_-_@gitster.g>
	<20240405174859.GE2529133@coredump.intra.peff.net>
Date: Fri, 05 Apr 2024 12:36:05 -0700
Message-ID: <xmqqr0fjtxei.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF0728AE-F383-11EE-BE26-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>> + - Some versions of dash has broken variable assignment when prefixed
>> +   with "local", "export", and "readonly", in that the value to be
>> +   assigned goes through field splitting at $IFS unless quoted.  
>> +
>> +   DO NOT write:
>> +
>> +     local variable=$value           ;# wrong
>> +     export variable=$(command args) ;# wrong
>> +
>> +   and instead write:
>> +
>> +     local variable="$value"
>> +     export variable="$(command args)"
>
> I think that is a good rule for "local", but I thought we did not allow
> "export foo=bar" at all, and required:
>
>   foo=bar
>   export foo
>
> If that was only because of this bug, it would be nice to loosen the
> rules a bit.

That rule in Documentation/CodingGuidelines predates the discovery
of this bug.  I have this vague feeling that it was for the shell on
old Solaris, which would not matter to us anymore, but I do not
remember.

As we are not showing "readonly" in the "DO NOT/DO" example above,
we should probably drop the "export" example and discuss it
separately and decide if it makes sense to loosen the "export var"
vs "export var=val" rule.

Thanks.
