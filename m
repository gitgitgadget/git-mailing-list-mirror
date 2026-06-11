Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54935893
	for <git@vger.kernel.org>; Thu, 11 Jun 2026 06:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158320; cv=none; b=l5/qcVo3XYYazND+HI2TZwfWzapVToJYsopgDKupsLcW4BiKj7PHy+dHfGj3B6QIeDYEY54jH3OX+GCLR88sjlRk3dmIJtHk4uH6QLIv8XvOxJXA/iTaIxPSbhhjQ+BrhUnnNBfFIsVlWKMdPANVA5YfbdftcMBWRg74p7xmSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158320; c=relaxed/simple;
	bh=OMw131CIDdA9xfbQWDD/FgpUHFaSmfJ88GbJ4S5fl30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kOPOGEvtIHcTmMqoLDlmCKd9Gw4Do2oqvNWGxnPFDndMHScjyQlXQM1vcd6pt8mZRCA7KuBgVUQGl1Fu/q1Nwy8Wlsh6pGxy318r5+eVNujo/w0b4kBoWVhWbNqu6Z9Aj8OT+yUe/LJr0Qc1awf2viYLC9y6x/q2/KOuBfN3s9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cra1LWRb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cra1LWRb"
Received: (qmail 106103 invoked by uid 106); 11 Jun 2026 06:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OMw131CIDdA9xfbQWDD/FgpUHFaSmfJ88GbJ4S5fl30=; b=cra1LWRbDMGGWoSZBQYD3EQ62W6pS3G4FOxwSt/JrwbwS4NK/wV/Zln8uY0sVTOHY6rp4ufHLTaYlEITYuNrgnsV/yRaKo/u1ggwDG8fwhofzoPN0LVw6oNk0ifE7v4ce1Ln5wmfgscTzSJYAsuKs0FGbj2J1Aj2KMAcyUAWxaDsDUjaoDUXt/j8AirLINHIHxVIx5HohxwL8KOQT5XK3Q7wOjwkdqucsjmDQS1bauxax1Zv4+K5tjyg7i2T1f8LoMRbXtElLthc2CT4kgA9dgJ2NMrQre050eKXPrM6l6c77owi1A6tay0nmlCoBEa+ELL9h+xsqKx/3fJcn4fZ0A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Jun 2026 06:11:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 313533 invoked by uid 111); 11 Jun 2026 06:12:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Jun 2026 02:12:01 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 11 Jun 2026 02:11:56 -0400
From: Jeff King <peff@peff.net>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] doc: git-config: escape erroneous highlight markup
Message-ID: <20260611061156.GC2187173@coredump.intra.peff.net>
References: <20260610185148.23920-1-taahol@utu.fi>
 <20260610225513.6269-1-taahol@utu.fi>
 <20260610225513.6269-4-taahol@utu.fi>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260610225513.6269-4-taahol@utu.fi>

On Thu, Jun 11, 2026 at 01:55:13AM +0300, Tuomas Ahola wrote:

> Paired octothorpes are used in AsciiDoc to mark highlighted text,
> <mark> being the equivalent HTML tag.  To use the symbol as a literal
> character, it can be escaped with a backslash.
> 
> Do so in git-config.adoc.

I think this works OK, but in general I think most uses of backslash for
metacharacters should consider using literal backticks. That shields it
from the special meaning for asciidoc, but also will render it
differently for the user (usually with a typewriter font, which becomes
bold in roff output).

Though curiously the case of `#` in git-fast-import seems not to get
marked as <code> in the html output (even though the nearby `LF` does).
I wonder if there is some special treatment of `#` or something.

>  If _<message>_ begins with one or more whitespaces followed
> -by "#", it is used as-is.  If it begins with "#", a space is
> +by "\#", it is used as-is.  If it begins with "\#", a space is
>  prepended before it is used.  Otherwise, a string " # " (a
>  space followed by a hash followed by a space) is prepended

I saw the comment on round 1 about this second "#" on the line. But
while we are here, should we be doing the one in the context, too?

-Peff
