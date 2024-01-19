Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03182802
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705624322; cv=none; b=EpFHOkD0g+uhmwUzPtoOvkhW1Oj6BLaKIXRRcaoH8/VHN7ivsZkMbTCvhruTOe3a3nXrrHVb3cUbwTHU8QRYCwLAfyS0nXQKf7lhxqnE8zp7/4XvDpBzpR5e2oIgmcfWJghlX84sLRopRhwRqePCnrzyEssf+aNPsWQoegrzMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705624322; c=relaxed/simple;
	bh=6ljRiagPGVM4BnSVfKlFwyk9IT7DMNU9f4gxzqyEfwM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gk20gQmuIzzm9o7Q47sKApopCC3Fl6p5WsCKrSQIh3+gbJjdOHL9GjENSikU8WoF0sFoLcr38iSXSyz9TnOW1lgNUbMAB2sY+dzKeEyxxpTnyonvuU1SCw1n+BnVK+0GXD06rrBm5NUlyJe60bg4KZG39u53JawJc3uhOzHUnwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wvkZjCcd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wvkZjCcd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9FF181CE6AB;
	Thu, 18 Jan 2024 19:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=6ljRiagPGVM4BnSVfKlFwyk9IT7DMNU9f4gxzq
	yEfwM=; b=wvkZjCcddX3K8UgM/RrgvyhRoIzxQh0j0AzlD1b2gnENUgZ0mIlpbs
	WY2OFl38zweCZM8qxhx6d05HCZs68iqcsY9ZiAMkQtp2yT/Q+Ugr30wmx+u2Ec+I
	nT2PQMZnfEf+OFB1ucJ4zKvgpMttqSU3oy5dkvGfyFvrIvTqDMS4w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9614D1CE6AA;
	Thu, 18 Jan 2024 19:31:55 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EDE611CE6A9;
	Thu, 18 Jan 2024 19:31:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 04/10] trailer: delete obsolete formatting functions
In-Reply-To: <8d86461475765ac04ad0ed207e46598eb90a45ba.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:20
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<8d86461475765ac04ad0ed207e46598eb90a45ba.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 16:31:53 -0800
Message-ID: <xmqq7ck6noxy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 25A90D3E-B662-11EE-81E7-25B3960A682E-77302942!pb-smtp2.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  trailer.c | 79 -------------------------------------------------------
>  1 file changed, 79 deletions(-)

OK, these unused functions are the reason why 03/10 weren't removing
as many lines as I would have expected from the refactoring.

Looking good.
