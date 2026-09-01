Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0CC25B08E
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 11:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260909; cv=none; b=L7JWrtdh9MA7GwVSFzBDzGL2bCaLb/U16XX0qGlB6G/TyC/fdaC6VuYC4eVzPpmrVihUv4X272tbzj+l/H31J+Zizll9qZSDseP1E+twP6tJZZV69z1DYse9MB/8tPIOCq2UHK/CpmzINfzHvr8Szydot/LPj7fveA0tk2Fqci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260909; c=relaxed/simple;
	bh=iYhx+zrF8iWrSqfmmcmXCagT/y4K9q4bQk3ZGTKgGKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4wfOsLw1ZSLMZ0npCeXOuDXydzFYwSls9kBAhBkUmmGGjhhyZTmBCdoh1Ga4dlEiSB/fAsByoxGn95NKq+plU4xNZ1jJOYzAQPRbkY4kUGWeDjqFcsuT6ScjXNUy5WTA/1zTatk8f6+xm05gitgXjLx9dQFIfFTomlu6BWjWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nT6nbf80; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YdyChNPJ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nT6nbf80";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YdyChNPJ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 7F2BFEC01A9;
	Tue,  1 Sep 2026 07:08:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 01 Sep 2026 07:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788260906; x=1788347306; bh=B6EWUly2C0
	YoRJkpY4P0dVLCUszc6xTVo8oSUCkgHmw=; b=nT6nbf807roSH4OKo3Dsb8Ts1k
	j2wWiacU+NsQ+5ilG54JhJNjMstE24Ol80IsJv+2rh1aDiPoUCm8t3Xv6irOPED4
	2OmF5o0KCu67vqnjfcHn2hYjqhCsxNToyNk0hbGGFxwucBfWuYb7XtT7W7XUOgGj
	EH9kZe9GoC1VSmZAMgmLijzSTctTUZUAWgAY8HO+xME9niDJ/TZhrfGB9e5cbm2w
	ku2wfDa+Mh5oq9VFoiHKmX/M19f+B3fYyIgR99CNMjXeU+Qemi49gMqNYhxnNeac
	SR9UzV1KKpcf1DWReQofclLtzHGMuGFkR4dhSc/fbXWIzxuBlFAQNZ7KC1pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1788260906; x=1788347306; bh=B6EWUly2C0YoRJkpY4P0dVLCUszc6xTVo8o
	SUCkgHmw=; b=YdyChNPJe2dJZNTHaNfkzCADsWNyuPRpL7krqcKjM0YW5vYPfti
	CvTK733d1x+QfKu3ImvrSPnYQLRhmVC9oMtp5NXM7ixoYrkXQAgLBOCFLGs42Qjf
	c+qw8QAbK+erWzugi+YguKmf1jPNB3vIwurfVCrtgZBAaubu4ax5EXm4Bv4KBSft
	zPIl4naFdw2/VzDH5/+gSBgNcaXCv39YB3jvJAoyxXUYgV+00zXZ55G/mQ3L5seZ
	wOhg9wpTFW5X4pEPR/eVvjw4qSBDY1OD8Nsy+KJLDBeQX59bPB3wJ8lDnW6L4I9d
	hCmrDWefLaNqJ77KPwcCLcxISsA6iFuT/Qg==
X-ME-Sender: <xms:KrKWahie06wxW4U5x7NYFe3deNxtjXTGcUNgdDZTTaSFxWSvpW4aNw>
    <xme:KrKWatfXFfbz1Rt6sIDsIpX7h1x1AvJF8vTWCibRcnFbgLW89tA_0nCZpG5-_W-U6
    T-uwIRypWtII69ZNj92OHJyB6lUodcWcFEyCuMXlalkA0xijCuLnYc>
X-ME-Received: <xmr:KrKWaucY6gec0GcSroInfjQrYrmTbs8j-q_OS_Zivh8RpiwsxrPANA>
X-ME-Proxy-Cause: dmFkZTEfVznDsdXOjA2Jk2ajIu2r7QYFmJRGL74iZSKFsYcorc349ciRO788IubFYGaKlY
    VoOLAuTQ4ATw3fbcIM4CAJSZHiicLf6eQQbP9QRd8GgG1So+HFn/cJTVIuT8EIlP+rjgio
    Z/WzfuUGUDkOk63NcCHvOITCPGgpmEpI+deFE7eWdxZ9H1Zms53qcIzE0VXgCC52BfdvT4
    tw7o/sY7E/H6KfUUDaiIyvlgLpzkry1EVoSKHGH5FGX7MWl4SUCSruVyB/oV4T2onq8QF9
    KLL/kaPxqHEjpmHjBZjQQ6zc0RWqAhucRPEWRt9Ic0cJBRyHnZboHK1EkRRv/y2BcwxGt7
    NlDjrDt5pBCCPydJ1FvfPejDxNzihZQpN3N+aBaTqR+ASk7JcvFMgnuVsIxMrgLfBXwwSg
    KhJFMWSC0m5Hl3h578ifDe40njyAtYd0wrpI0yahsA2tQjI03M2evtMUB4k7qRI2Jq4iYH
    vhzntCPFJhTCTKCDMN+zOnmlgikknZ2OjNipWwZNUKiVfWDHj7DL041n5d0qTkfTzRAhEc
    5OuCSf1GtkQzgM8VRurHCbEb6LeTvD+c2ekadB8V4/WbnT11ViqHUxOH+jKKmQtX1jvnE7
    vT/tEBEqULy5d0rQP3Mn9x31zY/BUUWvc48pahDD65Df9hOIag5xgKv4Xgdg
X-ME-Proxy: <xmx:KrKWav-nyuBAgzubf_0tmh4hzySDG4-nPzqLD-iWumFeyaDU0xccMw>
    <xmx:KrKWaikdrjSTZYlbkPaPnBnf36XnueTvSphSY4aPiUori-oSyxG9sw>
    <xmx:KrKWap_BslZvYgtoDsm8cJga7g_NSxVAC67OWs9Zq-ek2e1vjjd-lQ>
    <xmx:KrKWaolUeFLroT5HzP0vH-h81l36xj9DbxsLwWiOFB4TGSc-tyom8A>
    <xmx:KrKWakJIPqf76aJ-RKwN7K254BrsCsR4dufBtaHjebkLVMpiHXeIYdEd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 07:08:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc17a3a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Sep 2026 11:08:33 +0000 (UTC)
Date: Tue, 1 Sep 2026 13:08:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Nicolas Le Cam <niko.lecam@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] revision: hang on to "freed" argv elements
Message-ID: <apayIuf9kXQcQPvS@pks.im>
References: <20260830215555.2660035-1-niko.lecam@gmail.com>
 <20260901062815.GC1075462@coredump.intra.peff.net>
 <apaSDqIEyc82Q_zE@pks.im>
 <20260901092120.GA2979683@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901092120.GA2979683@coredump.intra.peff.net>

On Tue, Sep 01, 2026 at 05:21:20AM -0400, Jeff King wrote:
> On Tue, Sep 01, 2026 at 10:51:26AM +0200, Patrick Steinhardt wrote:
[snip]
> > > +static void mark_argv_for_free(struct rev_info *revs, const char *str)
> > > +{
> > > +	if (!str)
> > > +		return;
> > > +	strvec_push_nodup(&revs->argv_to_free, (char *)str);
> > > +}
> > 
> > Hm. Doesn't this mean that we take ownership of the string and then
> > eventually try to release it when releasing the vector? I wonder whether
> > this could introduce subtle lifetime issues where the caller passes a
> > non-heap-allocated string.
> 
> Yes, that's exactly the point. We are replacing a call to free() with
> one that passes ownership to a strvec which later frees it. If somebody
> is passing a non-heap string along with free_removed_argv_elements, then
> everything was already broken.

Fair.

> > I don't think it's that bad when seeing where we use these. But I feel
> > like hiding this fact by marking the parameter as `const` is a bit of a
> > weird design choice. I'd much rather prefer we force this onto the
> > callers so that they are aware of this, but I haven't seen the end
> > result of that. So maybe it's just too ugly.
> 
> You can see the effect already in the diff. In the preimage all of the
> callers had to cast away const-ness in order to pass the string to
> free(). We could keep doing that here, but since this function has
> exactly one purpose (to free the string we pass it) it seems like a nice
> syntactic convenience to push the cast in here.

Okay, fair enough.

> Though you may want to look at the "2/1" I sent, which pushes the check
> for free_removed_argv_elements into this function. And then the cast and
> that check are side-by-side.

Makes sense, thanks!

Patrick
