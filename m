Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D9B3E44E6
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 06:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783320241; cv=none; b=dMgMIHV3u3FbbzT3IjxsS83U7MpAGxaXiCoY8LN30EPCAI5+CkLczCrleK65sCczHx1bRkAnxRGe9Ut16ALOsmu3s1dqUJXskUXlcqSF7P1GfYdPyn18u2WqQqvWQKGFYcd9mpAc2uoAjUfuvLnPMeE+UnaLNZx85fjz6P+cU/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783320241; c=relaxed/simple;
	bh=8gnsQzl91xbF3b7+emlOxmrLzIEdboRf7YRQqigWUT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT+VIJx8N43RpyD/NCSzHElxMdZH9EIbDyGLkbILTFV8UW22ZESvhQO3BgUzY+B1VeSk8RKepOlGHuhDccVXBs5YAQZxlTfN6i5NWwd0PnJ90/XrYeLDrJ8vieLlxo5c2E10g59LfO3i67019WT/TFoYn9FwiMCq0SBpwf8XONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZE2SCRCE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InuIdDqa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZE2SCRCE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InuIdDqa"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B0FE17A00F0;
	Mon,  6 Jul 2026 02:43:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 02:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783320229;
	 x=1783406629; bh=7VD4+OdkQahnlNuj7HCokquk5PiRq6JwtoBy547VVEU=; b=
	ZE2SCRCEcSsbXe57MFn1MFak3XdR6x+yomevL6yyM2LCN9+uzjAv1Wbxu6aJRK+n
	n2WR50j5kypBeV9Qr9I9YIEwjAbtMo/cqC+Flixe7AOHsb0gPGzpI64ZqO+5tGbi
	qNepbTygyUwRXSG2ANN3gxed+v7xzU6N1ISTY/EWn8N9VDef99GMBnkchcoTzv4M
	rlqz5LBZVmBzsoBSwmctSCGhNNKNrt8rwrO0LBe9/BjLHTL5iiY88G2jGDm0voWQ
	m58BCjavTKWnpUtGXq/k+n1EnVHegtEx+JkoYNa8kE5cbtXnxUo2GU1WLTIlioxL
	FPHH924LORIe+E7YDiZEXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783320229; x=
	1783406629; bh=7VD4+OdkQahnlNuj7HCokquk5PiRq6JwtoBy547VVEU=; b=I
	nuIdDqab3VhG03HXRhQx9chWTyX3uyr+dsK2FeJ8W0QXYmC5/JC7UA4uAJvAhJi3
	GHSnYzS8cK7lY8OUsPzwz4T908PDBpbErBzki14NVNOW3A/zdQuv7AFn/zn0T0No
	OSNOdrla8GA6RQf7wKNKnN8EIJpnMW7Itd5/tsTNsUHukwmub23ltxlLNwXlyzQb
	cI19H8niN710h69T/nzgJ9WFINudKjUNUEVzQUGWswlLDuLBHODq34AHXph/lM47
	jYW6daKbeWwqso7ugcBQuk/CXbsXNz6B6GnmmvRgSzJ1rPGMalhhhm/vJ9DeOnYo
	GNz5/CUyrjGGPyzX/XVjA==
X-ME-Sender: <xms:pU5Lag1AbOe0KCQjTtXRh54Yvw0Ib0zpRgTsp-Zru8jl9eOSkIYW9w>
    <xme:pU5LakZjjAABJCiPicUGwZjrIPKwWqrD5HnTJDuwEeB8WhE-TKMre9wwXOpoqgXsl
    3f2xU9eQLjtOyePP0jIEoKZaYG4dk4HYjx2dU0dD1nXIo1XygBmFA>
X-ME-Received: <xmr:pU5LagL49PsSmzeWsEPhSCPWJ9SMJDkJzJgs_AdMxVxz68JaJsHhVvTHUNRpXkpdtwoogohc35GuHP2EgljeUXHah0GmiaGQuBFvLWoOIH0>
X-ME-Proxy-Cause: dmFkZTFVp9Hh2Hs5TF+3oNY6TisJOJvd52na01mR2IKuR7Kp1VLRT3oibysM9ZecsM9Qcf
    R7j/wuD3UShFQlgzsNCryuCMQLruPzP2TJZTvNlULrjXdrPtjpDbtpOzcfKw4IkVOHt8Mr
    lcPGuLLAq/iWEAVQNkzEsQWR7cFHOatg2sAla3V9E+90o14I19WL+n7P6lFB00YLtrKl1N
    aEwsErMgwCqLv/0idDjq9/itLUdgZDOf/qarI152ArfGAJZDsfHqAZXLJoZx1UOkq69r/Y
    qA6Ncv+vergPz5xEH6MVFBSYrqmLme3t0N2Iepn6n/PmcKs8pr9Dw4ASvMyWk+0DDu9FWg
    od2dCbT9mK82h/9FTyJm0ux96swJKTFZmB469AiuzJoomrK6pwoLiKaFV4P9e/uvHDVwje
    dnmP8LPycavbiaDuhRcm8HB2vSGbsaR7SeCww96lB2YVg8C8RehFraxa6BRjSRwxAobgNj
    AGTgFpp5KfDS6jg3Zrbwex0r4U5M7TM/dXoOEoII1EQxHrIgCiVRqAomSoqH9JneNP9Fv8
    Ie79esUSZE1D3Yh2WnHn2HGUitRSYD/G7PK1vWxQSWo892Xo6OThylj0brNwZ5+KOrMH3N
    TjfKjLqgyARpVS6wgIhOeoxJ5xI6f6u68rTEs626SqtN2GxgQQwahoHB8BjA
X-ME-Proxy: <xmx:pU5LarGDJ0u9dXytr5SUGJ0O9PJkDYgLhBpt7NHxWo4ljfbapYfeaQ>
    <xmx:pU5LavuOWHPNOs8UZee611lvQZ4vHyQhSVFxMxGJeixABRoqdfO3Gw>
    <xmx:pU5LaitnXCWJ_EztnqrG1gOHnAc_BIiaD8hzi0cJRqESKAez2MSRaA>
    <xmx:pU5LalBr8D3MUvy1q3deep4s28jwyV8_D1M09eh6GyGdGdoX_38KwA>
    <xmx:pU5Lal9KV6zssolS8xEXNaeJKSx2MFNBd0gLxTb_1mh6OSjCy6Sf_12N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 02:43:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9c5526a1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 06:43:46 +0000 (UTC)
Date: Mon, 6 Jul 2026 08:43:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <aktOn-3K41Uhl9cr@pks.im>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
 <CALnO6CDAG4e4A_Qn-3QVe0s4D9xB333Sp0QRntNATwMygNXmQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CDAG4e4A_Qn-3QVe0s4D9xB333Sp0QRntNATwMygNXmQg@mail.gmail.com>

On Fri, Jul 03, 2026 at 11:46:14AM -0400, D. Ben Knoble wrote:
> [with apologies for the delay; I wasn't paying attention to "What's
> cooking" to notice that this was waiting on my response.]
> 
> On Mon, Jun 22, 2026 at 4:13 AM Patrick Steinhardt <ps@pks.im> wrote:
> > On Sun, Jun 21, 2026 at 01:49:34PM -0400, Jeff King wrote:
> > > But that's all outside the scope of your patch here.
> >
> > Kind of, I guess. If we figure that this mechanism is still subtly broken
> > then I'd argue that it doesn't make sense to expose the option via
> > Meson.
> 
> This bit addressed more down-thread, so I'll reply there.
> 
> To summarize: If we're all leaning in the direction of a run-time flag
> instead, I can noodle in that direction. That certainly involves a bit
> more surgery than just giving Meson access to the option, but the
> dynamism may be nice. I'm not too sure how we'd write a test case for
> it, though.

I don't think we'd necessarily need a way to detect this. Our current
build default is to have this disabled, so I'd keep it this way, but
automatically compile nsec-support into Git if available. And then we
provide a way for users to opt-in to the new behaviour via the config.

An automated test would of course be nice to have so that we know to
enable this in cases where we can determine that it works. But with the
above we'd already make the feature more accessible than it currently
is, because I'd expect that most distros simply don't enable the build
toggle at all.

Patrick
