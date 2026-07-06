Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D43BE17C
	for <git@vger.kernel.org>; Mon,  6 Jul 2026 05:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783317467; cv=none; b=Ff8yAy5ngKdKQSIhkz3XVsW6lSdqBqDLeaae0OB/4TggWG6B8orzvNWnLglB2N3v9kJeHQfVj4L1GnsIpyA342SK53gc8pF09tjEPApBYsKBu71T7fZLO0XkjxDIESKbEW/DTni6JwoJbt7839/zOKsZpBrg/MWnU5mFKwGt7Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783317467; c=relaxed/simple;
	bh=AQ+EgTUZhnM9x0TMP5fFt6+oj8NmmlYk6YsyxFGBVVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPYIJUXpolIfGIgYamL+KK67YcTemueAztWgcU11PWrDzuW7AI/MpxxwBNZSzCd3I1zasp192op9Rcnyjcef7vJAJlO3Idvsm0ipdax5LuwqA7dCxttB6p/JMjWb2U+464G7g0CaZbX2spOPbicK+OEwAv2/IfjgTctcMwMGpEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fgk06h8H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TAXd0GCP; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fgk06h8H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TAXd0GCP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 61EC4EC018C;
	Mon,  6 Jul 2026 01:57:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 01:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783317464; x=1783403864; bh=/DjqaU3UMo
	FA5uRDq+K8K+haj8F3ADrvG8FCP32a4PI=; b=Fgk06h8HROe1bbWK+jcwyxPWls
	10CKVRCPnZ3uc+oBuzkyoC30507mq2wrnmH7dWMnCcY+mP7w2QATdEVTBAUJidGc
	kqsTLBKneBUw6jLY42i7kF6sqPU89SNDzovWS8OTdKdV/Fy6cU4G/f/WQYXrtAKS
	Fp4TPMIQVrKsOKlz2OMRembzSlFXgiUrvWZ7vA2UdbuWPu71BUndL7gBcU+2Z1mN
	J4i/R+EQac851oKvV2sNiQB8CPAKpzh6CiuQCBwHuv4omTG8EBolzrRQHFdvD/qF
	jZB9wUUro7wIh1wdMOXWkEy3oXA5eOKKnA5ARRiOI9THIoNXPl1L1Lo4VBCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783317464; x=1783403864; bh=/DjqaU3UMoFA5uRDq+K8K+haj8F3ADrvG8F
	CP32a4PI=; b=TAXd0GCPd7sfsMm1vs1poFzPvVPghBGhUWrGF7URBOJORYAtI4s
	9D0l2Y7I6sOIeoszBHZ/Y96T8xA0j9D9zIGtL1E5z55KaVb87DOPHKDZkcknWJ/7
	SoLK+oN5rl/MEahvzJkNnHZtqBYdcbMWXHsUNh9xwvW271kr+Awi6WwqTAqUbKLa
	+tZD2jOBX2xrT2u3FUmwld78nU6dsh2eePHd+v7sJGrhAU5DS/g4AtxB+d9mRkRr
	WY6bE41+I8Le8e1DYtX1mF1kOJaVD4pF/Uxs/SI6kCtvfcrMzkaCOVnNUSpUFz7f
	q3B/ghORg3IyX8/5lRU5TtuoyinRhUxke9Q==
X-ME-Sender: <xms:2ENLaqiNmqm3iZcD3GmHPdey2nyz-dDO5WmwTd4Sx8EKgtke--uDRg>
    <xme:2ENLaiABIrxX0BSSwFCg6w1CSpvVJbD-Oh_vVzKPYppoSVjBI2I8SCe_YaRWxlGzF
    GOOrsDGpgZPqc24wroxmSS6EaP7fy2eiFvvL42JZ1jdT2XANTbjpw>
X-ME-Received: <xmr:2ENLanFI596An0O97auFva3GzVl9nuk8qrjAruKCErVibgJ88xYUyKsXjL2psA6LR5tqoR3ng0mpSpY0G-R6zzSIcK-MBxo0_dYHYD7ldqM>
X-ME-Proxy-Cause: dmFkZTFieY/5t03mFmW0kMrzxbCkgoTnxfyF6w1DY0yJxTxaQpPdLlH0dNHPbWVDCebm8e
    Lx8NY1eErYNp7JyYenERgFVGZjUYJn7+cMms+r+d5zHhuGR1jqIgq9HpXNWJvE697s1V7B
    Dv9PV9nBomXQ7r8j6DKLL0HbFm7bevMpQ5o3LoLkdTvnh4175bdMKSY6idcpDI1ukTJpOk
    nK3AcZSwl8YYf068DsbqtQKSOCqC2OLfBRsg1vFrWVP8EHyfLKSxMjJC7e1Fs83djNK+wx
    FAZbMFXnv8kqI0L/Le0ADLffh26562rlg5dq2VMjSyoaA7fCzWLDzzHr+0QgNqlXlz4xFQ
    YDgnTtYeyWoMWAglRF7N8aAa0Y/Vg3GVScKCWCLYkShmfT4jrhcYfJQnYNurNI70uQX1wY
    F/UOwlIG4Tg+o0/LdsF+NBfWY2rpvL9g+c7zTBYAjB13vBX+3YqqouZ+phI2j2y+MXCO+W
    Bx9lRXnl4mNHyNIP9715e3T6rRyUbii+puU+QrIh+q1SrHMvjs9iqIeBh4NiCY3n99EL3u
    0AFreVMSDZ2oaHZJXuP+X2lpp7D0jLTdgIaJe0EqKjHr5d9NLmt5d3LgnMkxv9AOBSRTqc
    zFgcJx2bDsqvcfKj0dA9Z2PBmkBk1D5w8nzLTPGr8UoXvqan9jfcoTk8oN0g
X-ME-Proxy: <xmx:2ENLaiJs21JbYcTTrVkUCZwlFNRAXZ4Bf-lHsx8Ly0TFNPceFXuoYg>
    <xmx:2ENLajnMLEPrPmW907ddGFiFej2f5Fw3TrudE-_Q1KkOKbOijuuVCw>
    <xmx:2ENLaiR4sNrQey8BbZAH-RXFWueczs1rbWdyMxbFq7jD3pi37WQTVg>
    <xmx:2ENLatKSLip9A5LfYFGfsnvADkpu3Ix99GMmI191m68SNFs9fislkg>
    <xmx:2ENLaoR-dFq45hKq4KAq8EOhqHZQvZ1kfQh7Htv6WFN8ZCGVjmuuZ3pj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:57:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f7d3f809 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jul 2026 05:57:40 +0000 (UTC)
Date: Mon, 6 Jul 2026 07:57:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <aktD0fioUvyebhOY@pks.im>
References: <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
 <akTS_rPV7JaGHKRq@pks.im>
 <20260701084733.GA814472@coredump.intra.peff.net>
 <akTXYoY7mSQUM33P@pks.im>
 <20260702085821.GC481298@coredump.intra.peff.net>
 <akY4u02vdBkVqs7m@pks.im>
 <xmqqjyrbhkf8.fsf@gitster.g>
 <20260706003429.GD2301945@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706003429.GD2301945@coredump.intra.peff.net>

On Sun, Jul 05, 2026 at 08:34:29PM -0400, Jeff King wrote:
> On Fri, Jul 03, 2026 at 01:45:15PM -0700, Junio C Hamano wrote:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> > >> Likewise I find the dual clang/gcc jobs to be overkill. Compiling with
> > >> both is useful, as they have different warnings. But have we ever seen a
> > >> case where running the tests showed a different result with different
> > >> compilers?
> > >
> > > Not that I'd know of. As you say, I think it makes sense to use
> > > different compilers in general. But I don't really think we need to have
> > > this as a full "compiler x tests" matrix.
> > 
> > Very true.  Different configurations with TEST-vars are great
> > combination to test, but we are not in the business of hunting bugs
> > in clang/gcc so we long as they compile (instead of warning "hey,
> > that construct gives you undefined behaviour"), we shouldn't have to
> > run the test suite with the same configuration for both.
> 
> I don't care about finding bugs in clang vs gcc. I'm more concerned with
> a case where we have undefined behavior, both compile it fine, but the
> bad behavior is revealed in the tests only by one of them.
> 
> I can think offhand of only one case where I saw that happen[1]. IIRC it
> had to do with integer sizes being passed to a variadic function. But it
> also changed behavior within the same compiler using different
> optimization levels. So it feels like kind of a scattershot way of
> trying to flush out UB, and we are probably better off with UBSan and
> friends.

Yes, I just wanted to say that UBSan is definitely the better way to go
in this context. I have no idea of course whether it would have catched
the mentioned issue, though.

And even so, we'd have at least one job that runs all tests with either
of the compilers, so we'd still notice issues like that.

Patrick
