Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124662C21E6
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783787111; cv=none; b=h7FecVZuYNc5rPF3SeIiNFPv6YNKIMO+gqSmo2C4ih22BMwWkK4hOgwI4RdB1CX/e4yeNFkX8kxvvifo3KbrTt6obutjNGR2Z06kuGIc2JVZgL1bD8H9007Faty0dK0AWV+Zs5iCa1f40s04g9tzMtGfYs4WKnuW8eeC8Rq7Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783787111; c=relaxed/simple;
	bh=YwiUMF4ApS6DDqdm15tkOEpb8E8luRRfZKkShy+3XSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVHyJzkEznwbtvtammo0LlY0cpWjAaq2iUWNYllREWh/3xwtM12+qQFXAfiAIycC6CT4ZY0/7md2POsNwWlsaOhOuIwZuCWBYELtyJOBpkIViY4KEggLz45yBA5wsfkeaFGYRW7B3T6Z2XwC4wW8vgCUunET40N+/CNqdufzQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=MAGsNSdq; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="MAGsNSdq"
Date: Sat, 11 Jul 2026 18:25:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1783787107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gxjyXjtewAdsqoYmEr/bBfkWne2OSrz5xlf77vaYfn0=;
	b=MAGsNSdqmE3gUnDcrvtd9o+r2LbeSQL8YZfNCzIRl4Vr7RyGhsqHdyDx57D1zw/vYpgwlF
	ttXZIhASLdB02x15ieMgV/NOHZoGmWv0Hn+n+t2oBe7Yklv8KvSXbeFmT/p7ByxN+MF696
	qlZjnNy7bFT30Qq+wVixmb3yuHCp604kI4GgROaubvpybiu4igbEorN13bHRUG3JDKPMKz
	Wy3QTM/wKUWcSwEpnU+nQvwjSsplml5SB1NM5x9dVcq8KzrNZUUT1Cep8uwyBrBYLzjus2
	6+cAKrN6aTnrHpvPA/CvO7USqhtLnUiXdzcarWK0ED0onuWX86M1Eyw8t494Jg==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org, ayu.chandekar@gmail.com, 
	chandrapratap3519@gmail.com, christian.couder@gmail.com, gitster@pobox.com, 
	jltobler@gmail.com, karthik.188@gmail.com, krka@spotify.com, peff@peff.net, 
	phillip.wood@dunelm.org.uk, siddharthasthana31@gmail.com, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v9 0/4] graph: indent visual roots in graph
Message-ID: <alJpjTXfZmYQccwk@exploit>
References: <20260710-ps-pre-commit-indent-v8-0-d3b636463bf4@gmail.com>
 <20260711-ps-pre-commit-indent-v9-0-eab6676e82f7@gmail.com>
 <alJOgYmAfGg37hsB@exploit>
 <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJVUU76PUXR4.2BYRTA8SEEBVC@gmail.com>
X-Spamd-Bar: -

On Sat, Jul 11, 2026 at 05:41:58PM +0200, Pablo Sabater wrote:
> I think that this solves an ambiguity so it should be the default option
> and someone who doesn't want the indentation has to explicitly unset it
> maybe with something like '--no-graph-indent'.

The reason I prefer the current way of printing as the default is
because the ambiguity arises only when each commit occupies exactly one
line. In any other case we can clearly see the edges connecting the
vertices. I'd rather have --oneline imply what would be --graph-indent
instead of having to pass --no-graph-indent on any other format
different from --oneline or --format=reference.

> Apart from having an option to disable indentation.
> 
> We could have the cascading to have a limit or make it zig-zag:
> 
> instead of:
> 
> A
>   B
>     C
>       D
> 
> We could do:
> 
> A
>   B
> C
>   D
> 
> This would have its own edge cases like:
> 
> A
>   B
> C <- if we zig-zag here C and D become ambiguous, currently we are
> D    indenting only the last commits (visual roots) here we would have
> D    to chose between continuing cascading or indenting the first of D.
> 
> I'm not so sure if I like the zig-zag solution because we need to think again
> if it causes an ambiguity, but I wanted to mention it.
> 
> I think we need some more opinions about the design.

I don't dislike the the current solution but I can see it degenerating
if someone contributes a lot of one-patch series.

Maybe you could indent commits that are both head and tail up to two
levels and then on the third go back to the beginning of the line. That
way you kind of have a zig-zag but without ambiguity. You'd only have to
add a counter to keep track of the level of indentation.
