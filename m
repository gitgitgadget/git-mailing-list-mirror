Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA1C6BFD5
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716332783; cv=none; b=He4fHfwjSqShqfOSI0tUTMLbSSou582kixVVRebOU76X93IHCDFApmyh9KxLa9tysvoe31gpkCehUDgUX0TOyo2roS0LWR7alO2ZO3KAM+un4TmAltp7YcJLVw+xx5mr65jZmbw4flz8hol3vF4zx8rXYz/D4H/z2DEdgiqnMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716332783; c=relaxed/simple;
	bh=jkxWdExQogcLewBFhitSwjRsfoS/KSIeNdBBkzcBl9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9ZcGEfGRUDU3BKWAE2yu2L2nIFRCcnV/vlJhv7PApV6uqILEloksmCoe0+68TwpGsArnPLACIfXTkZLDrTtKlj7IosqriQ1yiiPoo08iRLPs2dXH+vqHICzJph7RWAMsH67jrRl7n29j0HDBXxBU3Si5YvU0/9V5RUDlOGIQ50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q5RYRNK1; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5RYRNK1"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 138A5324BE;
	Tue, 21 May 2024 19:06:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jkxWdExQogcLewBFhitSwjRsfoS/KSIeNdBBkz
	cBl9w=; b=Q5RYRNK1e8ZHAmhNQbKzVjsGgwIJD0sw4M5jJuNBlf2IHByNpIudvw
	83yjF0itjL3/gnUVFuFp9quWaZPiotBkRakFPJLrTdk10pztKd/vcedk+ot9tBW5
	D5iad5iYaab+3g3wFCRxgMg9bMc98gcsPXsZ1mxJbuKPm8AA18uD0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0CBD1324BD;
	Tue, 21 May 2024 19:06:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A950D324BC;
	Tue, 21 May 2024 19:06:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Git
 List <git@vger.kernel.org>
Subject: Re: Re* [PATCH] add-patch: response to unknown command
In-Reply-To: <Zk0fvOpOapsAkWSd@nand.local> (Taylor Blau's message of "Tue, 21
	May 2024 18:27:08 -0400")
References: <1dbe4c61-d75f-45d9-95d2-ac8acae22c56@gmail.com>
	<ZkxHLE_8OpYvmViY@tanuki> <xmqqr0dvb1sh.fsf_-_@gitster.g>
	<Zk0fvOpOapsAkWSd@nand.local>
Date: Tue, 21 May 2024 16:06:17 -0700
Message-ID: <xmqqr0duix3q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BB6B05DC-17C6-11EF-A981-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>>
>> I share your doubt.  If what the user said (e.g. "ues") when they
>> wanted to say "yes", I find "You said 'u', which I do not understand"
>> more confusiong than "You said 'ues', which I do not understand".
>
> Same here. The below patch provides compelling reasoning and has my:
>
>   Acked-by: Taylor Blau <me@ttaylorr.com>

Heh, this breaks '/' command hence t3701.45 as it takes an argument
hence not limited to a single letter.  I wonder how singlekey folks
invoke that feature, though ;-)
