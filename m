Received: from taslin.fdn.fr (taslin.fdn.fr [80.67.169.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA11A38C9
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 10:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.67.169.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711189542; cv=none; b=t8ENJyxpEyNoSGbqgZ3E6O/T583AdMYSw5/zWGLdBGCzGz1NWYefOzI28k1Yzd0unzF2m97qo3UVEe0inUNILYV5x7e/5ZKaKmVQq53uqQhpsAH1GBum5RsLKrH10giS/t5PVVBMnlZOc4lUxkqE/oA/jnsLQOxGdeI9hX4NE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711189542; c=relaxed/simple;
	bh=J0qejDcCocS23jn40qbIvQZ6WTuf5z/droaJxyQTvcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdvsNuEsDj9rp4tFC8nvVDMhxRQLtW3s8GcNxfxCVPGTgJrrjCHSSy9ZvrXz1d0+wL2EnUskcG/pMfJ6z2+nEgyiOcGbHxIl/q/gfADaLL2/YAqvxTDiXcWyKXqqZKAXFIFxkm8LTeQJkzkZ9Y3+A2F1ttDH5QQZzKQHew4RRMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name; spf=pass smtp.mailfrom=max.gautier.name; dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b=EB11DHtp; arc=none smtp.client-ip=80.67.169.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=max.gautier.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=max.gautier.name header.i=@max.gautier.name header.b="EB11DHtp"
Received: from localhost (reverse-238.fdn.fr [80.67.176.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by taslin.fdn.fr (Postfix) with ESMTPSA id 59FBC60387;
	Sat, 23 Mar 2024 11:25:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=max.gautier.name;
	s=fdn; t=1711189537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Acf+QihEaH4Kz9XnpREq6LM58c6wr2RC8rzoON/8oQs=;
	b=EB11DHtpybKpHsWumAiEqn8Wi88S+bvrHYYFqS5c98xIH/7M2EGg8iAtrKox2TaOBzITQr
	ELRaZhV9tsUtXSQWee4axMjarsnxv04KLenEPSUBpReFce6TjG0y9zOAM+/si5U0GmMgJh
	CuKVkQyZXhIVacphteVmJ4G6vS7oxP/Y+2/+wAlrIRHMgUczLWwqKYJ1MJ+DudPVlMPSQj
	RSfiVSWf6lcV0c1kdSg+mJ1oD7QFPFxzI7ZglPVbqnrcFEzenwZgqZ9yn+CNjG1JXvEfKG
	gtCx3+0JUxfMhdpzJR/gdBPcc+TkFuBIbO/roXA4e2RDGpgbXcGWjl6swpTcNA==
Date: Sat, 23 Mar 2024 11:25:37 +0100
From: Max Gautier <mg@max.gautier.name>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, =?iso-8859-1?B?TOluYe9j?= Huard <lenaic@lhuard.fr>,
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 3/6] maintenance: simplify systemctl calls
Message-ID: <Zf6uISqdCn9Ld4ir@framework>
References: <20240322221327.12204-1-mg@max.gautier.name>
 <20240322221327.12204-4-mg@max.gautier.name>
 <CAPig+cTeXMw8pTS9on_CSJraPDYKSLaFd82LEtWjFgOBzH4=yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cTeXMw8pTS9on_CSJraPDYKSLaFd82LEtWjFgOBzH4=yg@mail.gmail.com>

On Fri, Mar 22, 2024 at 07:09:18PM -0400, Eric Sunshine wrote:
> On Fri, Mar 22, 2024 at 6:13 PM Max Gautier <mg@max.gautier.name> wrote:
> > The systemctl invocation to enable or disable the git maintenance timers
> > is needlessly complicated:
> > - systemctl does not mind at all enabling already enabled units, nor
> >   disabling already disabled units.
> 
> Has systemctl behavior changed...
> 
> > Use only one systemctl invocation per `git maintenance start/stop`.
> > Transparently pass its status and output.
> > Add the --force option to override conflicting symlinks to previous
> > instances of our units files which lived in $XDG_CONFIG_HOME.
> >
> > Signed-off-by: Max Gautier <mg@max.gautier.name>
> > ---
> > diff --git a/builtin/gc.c b/builtin/gc.c
> > @@ -2303,70 +2303,35 @@ static int is_systemd_timer_available(void)
> > -        * Disabling the systemd unit while it is already disabled makes
> > -        * systemctl print an error.
> > -        * Let's ignore it since it means we already are in the expected state:
> > -        * the unit is disabled.
> 
> ... since this and...
> 
> > -                * Disabling an already disabled systemd unit makes
> > -                * systemctl fail.
> > -                * Let's ignore this failure.
> 
> ... this were written?
> 
> If so, do we still need to worry about older systems in which
> systemctl prints errors and/or fails outright?

I tried the following on systemd source
$ git log -L :do_unit_file_disable:src/shared/install.c
$ git log -L :unit_file_disable:src/shared/install.c`
$ git log --grep 'already disabled'
$ git log --grep 're disable'
$ git log --grep 'disabled unit'
$ git log --grep 'systemctl disable'

That yields nothing indicating a change (in the commit messages, I
didn't look at the code in detail) when disabling already disabled
units, and testing on systemd 255 disable already disabled units (normal
and templated, same thing) without complaining or an error status.
Nothing relevant I could find on github in the issues or PRs either.

systemctl does error out or print warnings in other conditions, like
missing [Install] section, but that's not something we should ignore.

Philip Wood asked that question here in the original thread:

> What is the exit code of systemctl if a unit is already enabled and we 
> try to enbale it again (and the same for disabling a disabled unit)?
https://lore.kernel.org/git/3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com/

But I can't find a follow-up email from Lénaïc, and searching for
"disabled" in the whole thread only yield the comment I'm removing.  Not
sure if Lénaïc still follows the list, but maybe he can comment on that
?
To me it looks like it was not necessary to begin with, but I might have 
just missed the discussion about it.

Adding Phillip to the discussion as well.

-- 
Max Gautier
