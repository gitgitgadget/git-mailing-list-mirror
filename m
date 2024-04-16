Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E6612BE9F
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283861; cv=none; b=np3ZCm1VwQaaQkIC+SuovwlTQoWRAaW1A0+KADM+3fu4jiQ3C6zgSkfjvZMCwOHpXcyAPoVa/y62UOxsAMSEJKqIm3pt3a1SCd13Fdf4f1x2pI6VPb5EqciMkL6hPcIeEZvw4Oi7uhkRxD7EV5+AVmkO9zlp1YbYXUdKTclm32c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283861; c=relaxed/simple;
	bh=3WRlHaeDTMkzwNzcoA65QWVTcQrE37rFVemwiDe5LaU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a8WvI2WD+NqFeSPy2SFrIxOEWDrY5SpxhRB7vEfECLpCZKa4PSyZX8tueeucFtGmpP3sdqRfKVDOQ86a42ei42zXA1vtDi+q39RilQoY7+0Sb7y+xKkMgf0Qqp5Ww2AUSHAgnGzhi/YkgTrdc/qm6r1u49QlwjTIYE6SFLGIA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Li7YVMGu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Li7YVMGu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D47BC18612;
	Tue, 16 Apr 2024 12:10:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3WRlHaeDTMkzwNzcoA65QWVTcQrE37rFVemwiD
	e5LaU=; b=Li7YVMGumA1JLuNTOv4CSpM0gXyuqjG+/PcVB70idpA3hv26RV/wDN
	gMmc+bRjKaWIusVUMbYdj4yoMcrwB4Y6ASIYEkXP5K1bmkhiD+RydPWX/EzbeGuy
	byNAQ6TPy2P4nCIlNnDzdFZV4yVjhcSqOhq7k1MiFdhU/u9Fq3GQQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CC6FF18611;
	Tue, 16 Apr 2024 12:10:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 46EEF1860F;
	Tue, 16 Apr 2024 12:10:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  Git List
 <git@vger.kernel.org>,
  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add-patch: response to invalid option
In-Reply-To: <e2e72c39-2975-4307-a356-19e661cafb75@gmail.com> (Phillip Wood's
	message of "Tue, 16 Apr 2024 16:46:59 +0100")
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
	<xmqq5xwhhacm.fsf@gitster.g>
	<64d4ba8e-0dfe-407c-9b32-d02f1ce40393@gmail.com>
	<xmqqr0f5fi2b.fsf@gitster.g>
	<e2e72c39-2975-4307-a356-19e661cafb75@gmail.com>
Date: Tue, 16 Apr 2024 09:10:54 -0700
Message-ID: <xmqq4jc1ffu9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E80D3FA0-FC0B-11EE-8F1E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

>> Ah, OK.  Even though I was the one who stole this feature from
>> elsewhere, I forgot that we had that many commands, and it makes the
>> decision a lot simpler ;-)
>
> Yes, it always surprises me how many there are when the help is printed.
>
>> So the log message may want a bit of rewrite in the title and the
>> introductory part, with a clarification that '?' is what we already
>> had and not what this adds (from Patrick's comment), and there may
>> be other small improvements we want to see that I may have missed,
>> but other than these small-ish points, the basic direction of this
>> patch is good?
>
> I think so.

OK, let me mark the topic as expecting hopefully a final reroll
in the draft "What's cooking" report.

Thanks.
