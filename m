Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE8911CA0
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387805; cv=none; b=UJYgUbHQAEeRNEozmipQS/aLrvMO5QgQ9HaBrHzX1DlSCxy6MiuTyW/FehKT2EnDQlagOEgRN8evu7aBiTeLWHe1FtseFXE8pFC5Na+CM9phHd7q5Mr3Uc+/bIir1jGK4EpDjbdZf27k3+R2rHUANJehmV36q7paNcZVWrKBrI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387805; c=relaxed/simple;
	bh=rUhlviApOHksDwPEJT/8TtR8SC/CGB0UHoy1B+nuSW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fsh2nGp4Q0YGjpso/EPeBAM6O9agDxDGBA3rQbw06jg0SRXXd72BGpPy6GpW1CZbNr8LXav8nuigA8+QEYczXhy/lV8ez2as9pk4qeaftlmY/Q4AA+l2AltdqjMDDUr8nZL/4IReTyM2cvmTAuY2yg6ScJCTcq6WYpa8kc60M08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZMOhLPaY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZMOhLPaY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 30EF81DD3ED;
	Wed, 17 Apr 2024 17:03:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rUhlviApOHksDwPEJT/8TtR8SC/CGB0UHoy1B+
	nuSW8=; b=ZMOhLPaYnURLOFeUPuv7ExWrDMxn3JNq2iMEhD+/NON3w150x/rwo2
	qfEj0A/hv4G3QSO+RAExMGLPpTHcfetvKWaZzMhcZzPMig+rQHt0wsjZXpgfpgK+
	hOjLnDvbWo7tl6rnIXEaqz4LXn1LagAshXXxiGHJUq08mRVtea0Ak=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28D661DD3EC;
	Wed, 17 Apr 2024 17:03:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 812F31DD3EB;
	Wed, 17 Apr 2024 17:03:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/4] format-patch: new --resend option for adding
 "RESEND" to patch subjects
In-Reply-To: <c2cb9268c29ae4a5cac34383b7443763@manjaro.org> (Dragan Simic's
	message of "Wed, 17 Apr 2024 19:34:09 +0200")
References: <cover.1713324598.git.dsimic@manjaro.org>
	<1d9c6ce3df714211889453c245485d46b43edff6.1713324598.git.dsimic@manjaro.org>
	<154b085c-3e92-4eb6-b6a6-97aa02f8f07d@gmail.com>
	<xmqq7cgwau1v.fsf@gitster.g>
	<c2cb9268c29ae4a5cac34383b7443763@manjaro.org>
Date: Wed, 17 Apr 2024 14:03:16 -0700
Message-ID: <xmqqle5b66sr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E9DB40FA-FCFD-11EE-89E9-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> With all due respect, "--rfc=WIP" looks like a kludge, simply
> because "--rfc" should, IIUC, be some kind of a fixed shorthand.

I wouldn't use "should" there.  In any case, we are not going to add
unbounded number of --wip, --resend, etc., on top of what we have
already.  Introducing --something={WIP,RESEND,RFC,HACK,...} and
deprecating --rfc is not something I would object to, though.

Thanks.
