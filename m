Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB511E519
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 07:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710918727; cv=none; b=XlpullcIRovoQjEtyZwC3k8s7ZZUBDxIA9lh28WLUuXnv0g7pxLo7sb3IQLrPB9B19mvd5+IsWf9DPy7NjKrIZT5/nEQ3082DWrO9PbXRNe+1woOzBDUdCgxaLFXkCWLYpYN9mszcMDKug9uQkVWyWeWP55E/90y4NM+4eDedp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710918727; c=relaxed/simple;
	bh=o86M4vdCMtvQJI4NKx9G4ZTq1u7Nu1xfQvO34i5v0Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myMWl5EUYVbhtcivfnZG+3lX6AASKaPDycUwSgUjxs9dhyXLB9prXtz2HuirTE0afDXGIj4tLK9XhmmQQXu8p1KomhQk7L3F4ci+OLuJH454Mdt5WmCdEcSW/JqqBcKwFTlLrXFhCwqRCorKQdElSzfQq6oD++FcMScWJ48v5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Mf8xAPcO; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mf8xAPcO"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FE731DAF35;
	Wed, 20 Mar 2024 03:12:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=o86M4vdCMtvQJI4NKx9G4ZTq1u7Nu1xfQvO34i
	5v0Hk=; b=Mf8xAPcOmpZ0YTHj93VMWo2ha8C1AqqGfJNZvjiPjbuZ+kDiy2ExWr
	4pIMFXuREg8knEu5ELmnWnhSprKlBD00vKQxTq64o3dnd03y83GCmhk+TCF61243
	fyCCeWAPIXBafn2Z1GiLIMVnpZESTYWVQCCavOh3PvpDjWVIIkxE8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 45A1E1DAF34;
	Wed, 20 Mar 2024 03:12:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9A9D91DAF32;
	Wed, 20 Mar 2024 03:12:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  rsbecker@nexbridge.com,  github@seichter.de,
  sunshine@sunshineco.com
Subject: Re: [PATCH v3 4/4] config.txt: describe handling of whitespace further
In-Reply-To: <e389acbfacd5046a926b87346d41f9c7962e3c23.1710800549.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Mon, 18 Mar 2024 23:24:22 +0100")
References: <cover.1710800549.git.dsimic@manjaro.org>
	<e389acbfacd5046a926b87346d41f9c7962e3c23.1710800549.git.dsimic@manjaro.org>
Date: Wed, 20 Mar 2024 00:12:03 -0700
Message-ID: <xmqqttl1js1o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 27BACFDE-E689-11EE-99CC-25B3960A682E-77302942!pb-smtp2.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

>  A line that defines a value can be continued to the next line by
> +ending it with a `\`; the backslash and the end-of-line are stripped.
> +Leading whitespace characters after 'name =', the remainder of the
>  line after the first comment character '#' or ';', and trailing
> +whitespace characters of the line are discarded unless they are enclosed
> +in double quotes.

Can we directly tighten the "trailing..." part, instead of having to
add an extra long sentence ...

> +The discarding of the trailing whitespace characters
> +applies regardless of the discarding of the portion of the line after
> +the first comment character.

... like this as an attempt to clarify?

    Leading whitespace characters before and after 'name =', and the
    remainder of the line after the first comment character '#' or
    ';', are removed, and then trailing whitespace characters at the
    end of the line are discarded.

By the way, if a run of whitespace characters are enclosed in double
quotes, they cannot be trailing at the end of the line, as the
closing double quote is not a whitespace character, so it is out of
place to talk about quoted string in the context of trailing blank
removal.  The unquoting would want to be discussed separately.

> +Internal whitespace characters within the
> +value are retained verbatim.

Good.

>  
>  Inside double quotes, double quote `"` and backslash `\` characters
>  must be escaped: use `\"` for `"` and `\\` for `\`.

Thanks for working on this topic.
