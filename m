Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7F12DCC08
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748013938; cv=none; b=b/VLJ9mLimwJ+2xXxSp0aC3dyhwsN+guvWGR2NXsEX95qhnqX68hCxvX1nsuAmdUi6Cn8cwUDWr0WumzgC8gk02KIIRHV1jy9IN9fUisigyCEbL/GZFFs5nYE27zCnfmpGUI1l/ME6ai8jr9sl7oWJPP7kBpEqTC3+vXbPOwEso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748013938; c=relaxed/simple;
	bh=Rc2OIx5XyyOxSGJ4DpYBVI9ccUbz6dkaOsbWzF9f7as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DHniueH+vseQHEDUpGq8GVJ72plRGAGfSkCbdr7GaIqVh4unor+KDmHD+NNnQHib8cnrYH9GvD6aCc/RMqHlloAYjqr0nXKJWqo1H8qzhSStIG0kDSDzBoJvPMNnmvRwJuojJoHwoV+GwmxTKGrWYN1nlr9mUwAX7eRShwMnTtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=lUxczKjs; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="lUxczKjs"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4767e969b94so160545391cf.2
        for <git@vger.kernel.org>; Fri, 23 May 2025 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748013934; x=1748618734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qZ7hGYbydjb/OLo2lGv12l2ar+fvdBPmWEGMXUqgnE=;
        b=lUxczKjsbkK6rTknlkVMKkDYJIUoNFDwWxpjFY7i/P8l5LMbvj0cI9PxaNPNmIs+qA
         ZSZ8ASvvlT4C2pkVZrvmYIQv+V0jowKIQZ4B2REhjkeYumadZULMXm9tu51KV4Twjja7
         fTQiw6f3pf3Wu+D3z82PYTciu1rymPYsVTsS4iMReWtTKzoyecNLN7DRV/6WrXYbchkt
         zJQb0Imt/HTgyRObnEuDW9CA4G6kV7WpvSOmsmT9gLRuCcvmkRnG9l6RtOA+utGpb/RN
         B0yLnsAXYDSXoDI3KisDnQJtT6LsQdJGrTxe+l+/9IHiKy/7OJthPDsFOZz9UeDnlQqT
         sjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748013934; x=1748618734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qZ7hGYbydjb/OLo2lGv12l2ar+fvdBPmWEGMXUqgnE=;
        b=V+cEuUPM5qzcP+rbY0g6GPoCY59Cn8OSuA21ANK/A/8Snbm73YxE5ZPXUvnrpjkrTF
         SzcjNh5Djsx+/ZyjlkPN57mOVLMie+gcO0sti4fuVDVMitkCEsnE0Tkc0kPUNupPfzmi
         dKy8zRv1DINuKLhRTY3VA/Bu/5X0fURwMj/tDRNKW2G4GbLptI9sk3ktx32bgY0rsrBp
         XJqBlWtwNl+t36mzjVxgCWJD51wXDPTzz862Pu5NnawlSa4i2D6gFr7X40dhth6ahV1R
         6C9ySR4li/xRfi4eKBmH4vKuahOzY0BWP2gyQ3pEMqofMsDKS7pv99kubB0tE39u9MHx
         DnmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkW6yYWj17TzEjouwmyUT7Ojtm4a/kIZGCDUz7Xdre4FiyCtX9um7xJVFJB7sIVShRQRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzetC7UdPwHK0HJo5zt3t/3yOX/e3EMHhhysH0bqaBfIPUtgxbP
	2cUBlcgf9iuauULrgHsZVJOjBE5W3Fe+7r5eLSmHaGdg8YpXeGd22mekFfIpUJMd4lU=
X-Gm-Gg: ASbGncuusUQv9dM4KUeJ4V13jA2P2Z+BXIvdNNnl4lXgPAYhkVVpTRUD98SJ46e3yeT
	1C3Ruy1oUOUkyJoEVQlt9gFJwA+YTemsZDvK3Dmhz9dH4vga1eq6Gdpi6gSTJ0BClIW+d8EwKpj
	dTsL7hkumwMTX2dIFCDRF95EeIpMkxJSR+HfEXWpynt5T6Ez5jWpVTjSUuoY/0UzzFe/jVbBlHS
	keAQDhuUgvRlAeXy3W9SOY03YM3xEkrFDcFmht91sBF9Mck20HsopsAfXhvZXwvDb6Hd263t7vv
	GiTpVA5u8yR/OcZwYP6gX81NrZu0dX1Q/6DeaZ57L5Dtf5mbhEgS65I7MnwaBwi7lC1PU0kGwrQ
	UXSVhVbOYmdn383S1PBgGKGM=
X-Google-Smtp-Source: AGHT+IELEFUfyUiFDVx5J3CCxpXJsBon/5sKf678E0e4LyAKSx8P6jFTx7lKXfziGPKsNEqLy+JRWA==
X-Received: by 2002:a05:622a:610f:b0:48b:5789:34ac with SMTP id d75a77b69052e-494b075afc0mr414684341cf.3.1748013933919;
        Fri, 23 May 2025 08:25:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-494ae3ccfd5sm114237981cf.2.2025.05.23.08.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 08:25:33 -0700 (PDT)
Date: Fri, 23 May 2025 11:25:32 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>,
	Fernando Gouveia Lima <fernandolimabusiness@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	stolee@gmail.com, peff@peff.net
Subject: Re: [Newcomer PATCH] log-tree.c: Supress Wsign-compare-warning
Message-ID: <aDCTbF3Vm+Ob3Osh@nand.local>
References: <20250521202409.26879-1-fernandolimabusiness@gmail.com>
 <xmqqsekx8yef.fsf@gitster.g>
 <aDCQWr3MBX4L7sbA@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aDCQWr3MBX4L7sbA@pks.im>

On Fri, May 23, 2025 at 05:12:26PM +0200, Patrick Steinhardt wrote:
> On Wed, May 21, 2025 at 02:08:40PM -0700, Junio C Hamano wrote:
> > Fernando Gouveia Lima fernandolimabusiness@gmail.com writes:
> > Quite honestly, -Wsign-compare is mostly garbage [*] and I wish we
> > did not add it to the developer settings.  A more effective way to
> > squelch them is not by sprinkling the casts like this, but to remove
> > it from config.mak.dev ;-)
> >
> > https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/
>
> I'm still not of the opinion that it is garbage. We have tons of
> locations where we mismatch integer types only because we never got a
> warning from the compiler, and these have caused multiple stack
> overflows in the past. The signal-to-noise ratio is high, that much is
> certainly true. But if it helps us to avoid security issues in the
> future I think that is acceptable.
>
> I do agree though this not a good project for newcomers, as fixing those
> bugs is quite intricate overall. So we should definitely remove this
> project from the microprojects page.

Agreed with the latter point.

> And in case I'm the only one who thinks that the warning has merit I'm
> also happy to be overruled and have it be removed from our developer
> settings.

Between the two of you, I tend to agree more with Junio's assessment
that the output of -Wsign-compare is generally not useful.

I don't think it's *entirely* useless, and your patches squelching its
various warnings has shown that to be the case. But having merged in
those patches to GitHub's private fork (and thus dealt with all of the
-Wsign-compare warnings that are unique to GitHub's fork), I generally
found that the warnings were not legitimate issues or downright wrong.

And indeed, merging those patches in required a fair amount of work
prior to the merge in order to get rid of those warnings. Having done
that work along with Elijah (whose perspective on this I'd be curious to
hear), I am not convinced that it made the code any better or more
secure.

I don't agree with everything in Dan Carpenter's post above there, but
I share their general sentiment. I don't feel so strongly about it
currently as to suggest we rip it out of our config.mak.dev, but I do
think it would be worth at least discussing what benefits and drawbacks
it has.

If there are a reasonable number of genuine overflow bugs or similar
that -Wsign-compare helped us find, then that's good. But if the vast
majority of the warnings are false positives, then -Wsign-compare is at
best an impediment to work around, and at worst may cause us to make a
signed-ness mistake. In that case I would feel more strongly about
removing it.

Fernando -- like Junio mentioned above, none of this is your fault
whatsoever ;-). Welcome indeed.

Thanks,
Taylor
