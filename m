Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647D15DBB7
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776897; cv=none; b=ElO2koRNQpoUYAdcVJO9S9lFkxlfCr9LEvO3/IAp+ZNVk4AsKGgsNXp+9hY2KjAUOw8CRX1UhNiQdA/m6IfgKnFLqQPs0z67Lu2zfBUvXN50ytOBFN7BD5GSSm4FaCuNSz37F1obDMh1VuOPXsDpQWbeg41F5zexE2dz1IrV3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776897; c=relaxed/simple;
	bh=g1YgUFB3QxBEy7Xl5Dm+ovOX7EYdmfayQQZlsrX7NUQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZlP+ns4JxAZCr5p3PnupIpzIsYF1k0QfCcCctLPUXePIRyhotZ+VEhMKSuVzvmxz4YmY4gsq3Kz5gLAsXcihLEq/0qCOMMPNH4rZjAe1YsEAohirVk4xByTpF1Z4SbzJOEXb7ScCIZaQ40hTSQ6VW82YSTRxEI7ytG2i4bYIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Pky+yEJn; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Pky+yEJn"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4BF6B30917;
	Wed, 10 Apr 2024 15:21:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g1YgUFB3QxBEy7Xl5Dm+ovOX7EYdmfayQQZlsr
	X7NUQ=; b=Pky+yEJn6/nr/pAIK3qkhi0g8V9aatCH1lU56v7M6MukOFbzGvEjqS
	U+nT/LNd9Vhe8eZyPuP5fiE7KBEyeJ8XDAV6ydYnUVaeuykf6E73hNJOcPRQmkyP
	bRUGKQawOObMDI5qsxiMCN8+oiGtvk2g2ICS5uid/PvfY1aZX18g4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4481E30916;
	Wed, 10 Apr 2024 15:21:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C9F8F30915;
	Wed, 10 Apr 2024 15:21:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Chris Torek
 <chris.torek@gmail.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 8/8] fast-import: make comments more precise
In-Reply-To: <5e02d887bc93a4212499c3bd13b36c401cc19081.1712741871.git.thalia@archibald.dev>
	(Thalia Archibald's message of "Wed, 10 Apr 2024 09:56:18 +0000")
References: <20240322000304.76810-1-thalia@archibald.dev>
	<cover.1711960552.git.thalia@archibald.dev>
	<cover.1712741870.git.thalia@archibald.dev>
	<5e02d887bc93a4212499c3bd13b36c401cc19081.1712741871.git.thalia@archibald.dev>
Date: Wed, 10 Apr 2024 12:21:30 -0700
Message-ID: <xmqqr0fdrpl1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 89AED720-F76F-11EE-AE53-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Thalia Archibald <thalia@archibald.dev> writes:

> The former is somewhat imprecise. The latter became out of sync with the
> behavior in e814c39c2f (fast-import: refactor parsing of spaces,
> 2014-06-18).
>
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Thanks for being careful.  Looking good.

>
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 98096b6fa7..fd23a00150 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2210,7 +2210,7 @@ static int parse_mapped_oid_hex(const char *hex, struct object_id *oid, const ch
>   *
>   *   idnum ::= ':' bigint;
>   *
> - * Return the first character after the value in *endptr.
> + * Update *endptr to point to the first character after the value.
>   *
>   * Complain if the following character is not what is expected,
>   * either a space or end of the string.
> @@ -2243,8 +2243,8 @@ static uintmax_t parse_mark_ref_eol(const char *p)
>  }
>  
>  /*
> - * Parse the mark reference, demanding a trailing space.  Return a
> - * pointer to the space.
> + * Parse the mark reference, demanding a trailing space. Update *p to
> + * point to the first character after the space.
>   */
>  static uintmax_t parse_mark_ref_space(const char **p)
>  {
