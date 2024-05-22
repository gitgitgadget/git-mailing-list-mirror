Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6ED51E
	for <git@vger.kernel.org>; Wed, 22 May 2024 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716402529; cv=none; b=OjwLXtnjoMh0tY6okWvH6XpYxIbCGy8oVpQmODOjdvD5jkZtXOEVoO3uD2x0oAN0WDPAJQy2taihIp/DrBLTEulfiFKeGNazsA+VFTdDxKhHHs51ivQ4gIofK3NizHgwp1M6UHKnaFXzavbzDUDePq4T47kIGxSYdOAQkSySta0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716402529; c=relaxed/simple;
	bh=nuzlosjxQexcSMAuzhuxqDdLrL431SV8OvU3trcHPGY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iAQU4zzUd3Hd+HDw2VpIdgOOk3dGbg7f8gNWY/MRzDKauy/oIA7hi7jhI5COvt4R4cvlz8eLsysZwYdmL/7n4YdT8jdYj5BZC1e/3eiRB6Ygy9vcjY0m9JJCT2znAebWqRAgB2tkaUxXOjbdm5Va/AQkGwkrvmn/Q0QM+ao2y9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=axHu/QZE; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="axHu/QZE"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D603B18FEE;
	Wed, 22 May 2024 14:28:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nuzlosjxQexcSMAuzhuxqDdLrL431SV8OvU3tr
	cHPGY=; b=axHu/QZEKrSLu6oYHGUfR0yOBD4qOAxR016F9y7cBj7ty1EB91ZjLQ
	uQVyOFvIwzkuvOyjVld7pmtp+FhTcyD0t0/pJhMMLyK4OSm9jTcw/uQlKYmapBJt
	kYEUCOGREGrlLfFCEqYnTy+SGWUYMgzBwgdpdRmKRUtelxoC/MmHQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C738A18FED;
	Wed, 22 May 2024 14:28:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D78218FEA;
	Wed, 22 May 2024 14:28:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc: note that interactive.singleKey is disabled by
 default
In-Reply-To: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Wed, 22 May 2024 09:34:16 +0200")
References: <3141fe9f7328a97bf3818748421f6ae929120626.1716363167.git.dsimic@manjaro.org>
Date: Wed, 22 May 2024 11:28:45 -0700
Message-ID: <xmqq34q966qq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 202A1CE0-1869-11EF-9CA0-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
> index 5cc26555f19a..067496d77cea 100644
> --- a/Documentation/config/interactive.txt
> +++ b/Documentation/config/interactive.txt
> @@ -5,6 +5,7 @@ interactive.singleKey::
>  	linkgit:git-add[1], linkgit:git-checkout[1],
>  	linkgit:git-restore[1], linkgit:git-commit[1],
>  	linkgit:git-reset[1], and linkgit:git-stash[1].
> +	This is disabled by default.

Hmph, an optional configuration is optional because the lack of it
means the feature behind it does not trigger.

While it makes tons of sense to mention what the default is when
there are more than true or false choices (e.g. "defaults to never,
among possible choices never/local/remote/always"), or if it
defaults to true and the knob is to opt out of it, it feels like it
adds unnecesary noise to say "defaults to off" for a configuration
that is clearly a Boolean.

So I dunno.
