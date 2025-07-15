Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DB584D08
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 19:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752606161; cv=none; b=NRH2xEqz4hbTVd4NElNQOqT0mS/apr9+T9hoHOA7RNqzi8dpuijvjFR3aiKHyFeziqsfe5Uv8kdcExYx6rfc3K3qJN27iu+Mfqrywu7wd7wnVinxmxhKHX5Mgq4usM6GZQPAkwffhAM1zBpDnmluilxAIAN0D7Smwo0lug36TJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752606161; c=relaxed/simple;
	bh=xL0PERcv4dT70A5bySYROOkbcgvgOU6DeDm640foBMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J0rwGXwK1khRUJc4AV3MBzCO7vw/oYfbgjFv0f8B+sPuB4kixpVvEPmccuwCS2GNrQ9nMotv6bufoznUJNdMCM5fluhPtn7qdjWQTOWH/Glk/2Wuqj4PkJO4CEaZocNGCuhbR+HhPbCYuDYd+o1MdzzjNvurV+TpO/pnxDTrl/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc; spf=pass smtp.mailfrom=breakpoint.cc; dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=IsCWh945; dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b=lR979G57; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=breakpoint.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="IsCWh945";
	dkim=permerror (0-bit key) header.d=breakpoint.cc header.i=@breakpoint.cc header.b="lR979G57"
Date: Tue, 15 Jul 2025 21:02:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025; t=1752606151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsXDNl6Q4NvuWFTQtcAHQcV7a27BbV1Bw6N/Nodrf5k=;
	b=IsCWh9451ZLxmK1zN3zsRrssbxaPY5pNFlbwbokXITDEqbYZH/fKSyo7Bffs0ChYNhUPXF
	PViQtg2cKSsUzSF9zcPq1IZaof69rTWR95N7IMvV5NDfdGrMYv0P1Ien46sO0HhbzCuFcy
	2QSk36dUe298M+Tt24GOnmfApOijrOJGaOuDSNAF4eXhF820JE/BEkw6Y1agbdx4nH8YL1
	7i6viJ7840tltLxtj2M2HOpol26CnAfFIx27G2/5HMIVFvSIE/PP5B8iTsSNsVNkGPAfLh
	p5r4dQkRHFBgKybesN/zZKIbHgWecajm2KNjbSCZzt1NAR+nx7nowdbmK1clHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=breakpoint.cc;
	s=2025e; t=1752606151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsXDNl6Q4NvuWFTQtcAHQcV7a27BbV1Bw6N/Nodrf5k=;
	b=lR979G57wJ9cJSd4vcDVFRj7Cd/6TmuWvrR72yOVO6aJWL3rU9MWjKwwVpDXPWJA3vo6LK
	OWHoVWMsdBupHiCg==
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 5/6] bswap.h: Remove optimized x86 version of
 bswap32/64
Message-ID: <20250715190229.ed-A7kgh@breakpoint.cc>
References: <20250611221444.1567638-1-sebastian@breakpoint.cc>
 <20250611221444.1567638-6-sebastian@breakpoint.cc>
 <e00dff7e-1920-45b6-85d2-49e6a1218882@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e00dff7e-1920-45b6-85d2-49e6a1218882@app.fastmail.com>

On 2025-06-26 17:55:43 [+0200], Kristoffer Haugsbakk wrote:
> On Thu, Jun 12, 2025, at 00:14, Sebastian Andrzej Siewior wrote:
> > On x86 the bswap32/64 macro is implemenated based on the x86 opcode wich
> 
> s/implemenated/implemented/
> 
> s/wich/which/
> 
> > performs the required shifting in just one opcode.
> > The other CPUs fallback to the generic shifting as implemented by
> > default_swab32() and default_bswap64() if needed.
> >
> > I've been looking at how good a compiler is at recognizing the default
> > shift and emitting an optimized operation:
> > - x86, arm64 msvc v19.20
> >   default_swab32() optimized
> >   default_bswap64() shifts
> >   _byteswap_uint64() otimized
> >
> > - x86, arm64 msvc v19.37
> >   default_swab32() optimized
> >   default_bswap64() optimized
> >   _byteswap_uint64() otimized
> 
> Is it supposed to say `otimized` twice?

Nope. Fixed. Thank you.

Sebastian
