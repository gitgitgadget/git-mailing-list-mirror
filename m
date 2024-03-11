Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0F343AAB
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 21:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192724; cv=none; b=PYfmpHqhqWY2JhE45F6zLaI/wPYjD76Wv+ioutN3dzV3T7wQJwAQxniwUhUiZwS/ZEHv/1r+NXAVeJhDxnnzLFWMoySNh14eVDivwbXjdr/TAiSCEjgaU5tYePFiQ8pNK3K/qqAqPAkmPKNfvw+7zO4sOgeO3PrySxRbOdI5xpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192724; c=relaxed/simple;
	bh=Yb8Rf7EClx0uVdgt/WTT8GfO06zIwFZPWteYp2loMj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DuN1zab5o8EaLu3mPTR/uLM2Mj7pUid5vc11HFCsxlG9+kxUtSW88YFmqUuBdxdNjEtBD+ayUbRe11MJlsOXL+tFDbU4xSjuH2Qsg8Dl5Pqv5710pWEwfSIz9n+hokg847UlBS3eZiXqxpCvA6gxZQINd9STv3fOSkKOTSFiZ8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=U7Q7z6VO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="U7Q7z6VO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D75441EFD29;
	Mon, 11 Mar 2024 17:32:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Yb8Rf7EClx0uVdgt/WTT8GfO06zIwFZPWteYp2
	loMj4=; b=U7Q7z6VOROrLPJh6NrBRU/NByAmoSaeHA22u+2p6ae96mgdVz5NVcO
	C+3URibYcY9erAIHLotnxg1IEnu1We5tq9OG81biiXZF6AKvUPXeceV/R8nyHkNk
	w2QpDKaE4RfAHwHH2b4y25nDhMehM3muSuLjCP2vXR56RK4Zwo9Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 932611EFD28;
	Mon, 11 Mar 2024 17:32:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0D161EFD27;
	Mon, 11 Mar 2024 17:31:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Ralph Seichter <github@seichter.de>,  Ralph Seichter via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  rsbecker@nexbridge.com
Subject: Re: [PATCH v2] config: add --comment option to add a comment
In-Reply-To: <349b8a67931a2fddfff35db393023bf0@manjaro.org> (Dragan Simic's
	message of "Mon, 11 Mar 2024 20:04:34 +0100")
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com>
	<pull.1681.v2.git.1709824540636.gitgitgadget@gmail.com>
	<xmqqy1apudvv.fsf@gitster.g>
	<5eff951e815e2fdab3834c4aa4160ed8@manjaro.org>
	<ba6d65ca-8ae2-4d93-a5a5-e0b60768c302@seichter.de>
	<265e5b2d352c34dfe0625904b3356000@manjaro.org>
	<277b3187-f793-4782-aa18-50bc15febe9a@seichter.de>
	<349b8a67931a2fddfff35db393023bf0@manjaro.org>
Date: Mon, 11 Mar 2024 14:31:58 -0700
Message-ID: <xmqq7ci8pi9d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CB289800-DFEE-11EE-8455-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> However, I think there should be some way to allow the users to choose
> the kind of spacing between the automatically added comments and their
> respective values.  Yes, readability may be subjective, but I think
> that the users should be allowed some kind of choice.

As to the whitespace _before_ the '#', we can just pick one and
leave the choice to users' editor, which they have to resort to
anyway for even trivial things like fixing typos.  I am fine to
defer the choice between HT and SP to Ralph as the person in the
driver seat,

As to the whitespace _after_ the '#', I would say we have obligation
to the users to be consistent with other codepaths that we already
write our own comments.  "# " is the only sensible choice of the
default there, and we can allow other styles as I outlined in a
separate message if we wanted to.
