Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481F922F06
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 18:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705516436; cv=none; b=gMNETpc/3vXWqxurjk5XzW/xtFobDAhyGhBpdF4wrww5OTtsgLEvmBQU5odJUJx5VKtB60Ph4K2J9fNkLFKL9gN/vmTxDbmEFDX02EgPMhcPuK7RLUcJV9lF5baPbYDJysjL9jFza7WTyme1ie8ZSHfOMk1yLAOZYBCUoLM/gwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705516436; c=relaxed/simple;
	bh=TN4mt3vXtNA54XTifpS7nU3qxAig05sgomL0oHAy9NU=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=Qme637EpqF0+1/W6WVP0pAfj1Bz2XiN2vxjdNP2sA8jHcUreqGYsbS7HgifMHA0g3u114890T3vDDLrbHiTg/pBCdhYN/tmM9qxnG8goyATOh7fE6je9Zkrgde8Xb7Rap9MVQvLqQzjFpuiBYWSzGELM4nRrC+jQQ4MScoeOPDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QuDLqK99; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QuDLqK99"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 870C72E934;
	Wed, 17 Jan 2024 13:33:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TN4mt3vXtNA54XTifpS7nU3qxAig05sgomL0oH
	Ay9NU=; b=QuDLqK99gD9FsH/7Ww4oQ3nxDfq2gafI8QkTZ5EFqogwd7l4SoshrW
	KuEWWSPHWCg5yX9OOueWOkLL76hkOZivSzv01f+F8WfXCDnoqSbXA1997HMEDt69
	fj6uuJUvVxZYjLQxBGpYdLYuR4T3dYQoTGkfhS1GGjCY5nT7MsVOQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E3702E933;
	Wed, 17 Jan 2024 13:33:54 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73EDF2E931;
	Wed, 17 Jan 2024 13:33:51 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mi.al.lohmann@gmail.com>
Cc: git@vger.kernel.org,  j6t@kdbg.org,  newren@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: Full disclosure
In-Reply-To: <20240117091905.14354-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Wed, 17 Jan 2024 10:19:05 +0100")
References: <20240117081405.14012-2-mi.al.lohmann@gmail.com>
	<20240117091905.14354-1-mi.al.lohmann@gmail.com>
Date: Wed, 17 Jan 2024 10:33:49 -0800
Message-ID: <xmqq7ck7x10y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F614D31A-B566-11EE-9CCE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Michael Lohmann <mi.al.lohmann@gmail.com> writes:

> Just as a disclosure: I was told that my contributions are not welcome [1]
> (even though I have to say that I don't fully agree with the reasoning), but I
> did not want to leave these patches alone.

Rereading the message I agree that the message came out in a wrong
way that I did not intend.  It is sure that I do not want to see
certain attitude and behaviour in the patches in our contributors,
but that is totally different from "contribution from a specific
contributor is not welcome".  The phrasing was making of my
incompetence in communication skills, not from malice.

So I am sorry that I wrote something that it is fair to read as
saying "you are unwelcome".  I didn't mean it that way.

