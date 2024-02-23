Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B521F600
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726520; cv=none; b=rHOSbQDSL1j8mKbLdNGNTBCA8T+cUhdeRNLQ37HwjL9uqP8k2D8scBAod0TrehWZIgSeZ0JDeBrC5HV7uw7r/v8T4X/rJ3XIURa4f8JZsi/MCZaJYprf4ZuXCwBWXtMtz6HY5bKI/UET/SVObsYCTwFOEJzniBhDXrfimBVV27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726520; c=relaxed/simple;
	bh=uFo0kSZ+gFExMfrqjFv1FD7kCl3uFetrI9DJOjKSpXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HnfIvobkDCK1bQ5yFdEsG0Y2Oc8BMPWwT+EV78CDEDqpIbi32iX73onlfTC1lXpkIDB/dcTBfgehnd82Kx0sk0HlDxBjNCShzTqDMnPX9CI/KOrV84quG6oJDu1YjJRm/Pv3uz7mNZIzLAcr1f+GGz/K+D14Lh6z+cEBfTsm1ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=o5xf57wU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o5xf57wU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E77A91E1AAB;
	Fri, 23 Feb 2024 17:15:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uFo0kSZ+gFExMfrqjFv1FD7kCl3uFetrI9DJOj
	KSpXc=; b=o5xf57wUkuDQboYuPd3kNi/zIXRVGYFpJP+cwMV75xO8YMtKiXGxVd
	md1nAOorKvDydN7WxpL2m6qtmmJwOndZaGOvUwOVb1RYbozyJPMYLdMXeVA7Yq1M
	bWS6XSIX8S2m7u5rFtCun4CC2fTS629AkDAFjVDgXJExH0NTV+fXU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF7761E1AAA;
	Fri, 23 Feb 2024 17:15:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D1BA1E1AA9;
	Fri, 23 Feb 2024 17:15:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation/config/pack.txt: fix broken AsciiDoc
In-Reply-To: <72bb58e5f3b8a5a622394c5ff40426156e122580.1708720255.git.me@ttaylorr.com>
	(Taylor Blau's message of "Fri, 23 Feb 2024 15:30:58 -0500")
References: <72bb58e5f3b8a5a622394c5ff40426156e122580.1708720255.git.me@ttaylorr.com>
Date: Fri, 23 Feb 2024 14:15:16 -0800
Message-ID: <xmqqr0h2su8b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0657EBFA-D299-11EE-80C8-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
> index 9c630863e6..da527377fa 100644
> --- a/Documentation/config/pack.txt
> +++ b/Documentation/config/pack.txt
> @@ -34,11 +34,10 @@ pack.allowPackReuse::
>  	reachability bitmap is available, pack-objects will try to send
>  	parts of all packs in the MIDX.
>  +
> -	If only a single pack bitmap is available, and
> -	`pack.allowPackReuse` is set to "multi", reuse parts of just the
> -	bitmapped packfile. This can reduce memory and CPU usage to
> -	serve fetches, but might result in sending a slightly larger
> -	pack. Defaults to true.
> +If only a single pack bitmap is available, and `pack.allowPackReuse`
> +is set to "multi", reuse parts of just the bitmapped packfile. This
> +can reduce memory and CPU usage to serve fetches, but might result in
> +sending a slightly larger pack. Defaults to true.

Thanks.
