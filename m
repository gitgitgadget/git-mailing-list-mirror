Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F313624A0
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768478047; cv=none; b=WZtQ5JMFDvDjB3om08rT75CRNIf4gFeGqpO1tb15dSiwaQfybJBwzNKc+c6YqQA4UgLMgoyvkv485TYZJMLKgg9myBernMGxTymMh7uUoJeJoBI82tb6o466u69qiJRL/GpMzatPmlw4eNTQnFSOPJNb3yUBKAlijV0zqABuLvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768478047; c=relaxed/simple;
	bh=R1OALunxYCx72nNphf64ED8VzWYP0pRuDJcyb2p9t9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc3+KAQ/wnF6TDJu8lXHXaBsj/Awfk6VYZX2Kh6CLDsEZSLNO6tUNHW9e0LyfTAKUmqTMiR7T0TDuie8JxuqVuyVLRamLl5hlphp2PHV5VbIciJGq7NVUqX7YOi2H8SF+ge2V2OXEqI+3Gucq4OGecxc47IvfJgrAzMqvAO4mgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CfwvpkLA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Szsm/VQs; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CfwvpkLA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Szsm/VQs"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 893DB1D000F7;
	Thu, 15 Jan 2026 06:54:05 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 15 Jan 2026 06:54:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768478045; x=1768564445; bh=Z3eLlDVQMt
	KUQmoIRyJ4HUAPoFwlVrB9LvUSXeDYC8s=; b=CfwvpkLAeW4+ZNN+1tIRHTkhuD
	i7FR4cblAJe6+BWOPJvYoDcf6AYYgjX9dPSr+iMLJVlsaSEL0nmUQ5bheET/Co+0
	TEeUI25sI9n+OkCSpws5PeZYpw4TXuRdoLo+lEOiueH6oPh6YzW6bxQiCfdJzmsC
	uxK1yvmF86UWoXmixnYPVPaLXfCE/YczGHq9G6so8pp1UKnYubRy3EkEqE4/ukd+
	C2P1ZRfydQhZQCidPqKh/dkO7Rf6LaATngR15gZ/pEwpm1ESbiPJ+HyLELFASQT8
	v8A1TW1e2LQ2EKETnL7VX7IzQUqTOE2GdPnz2zpVsXH84fT5EU+7hhgzqyRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768478045; x=1768564445; bh=Z3eLlDVQMtKUQmoIRyJ4HUAPoFwlVrB9LvU
	SXeDYC8s=; b=Szsm/VQsqDF0hl/FsPZAVylndGYSfGJk8vr8srOMp4ajVa6vqmo
	y4yNPOA6FmxCqv9/CuJg1pIw46EYGlRR/Crtt86Gd62ehAIi016+jWNw8lRwnYcF
	ardPiLdfA3lioqk5/2HABJdFkAYK1MbJlB/VcehRL1iaCyEjxMqmcdgZeUtKSTzn
	fAy9u2xG9xnGy81qnG5WBjgDWLio4Tw1FhnzxMDlZLo14mdZ3JNSJaA0mAy/FsVJ
	9RLY3xUKX6z0zwW+L6TeWxrHfeo0mIHjfQyTg/E2NkblxxguuYRuEo6T8bfNc8aT
	wwfXhzlRMv5jeW+NN/DcrZrQzlNMfIz+jCQ==
X-ME-Sender: <xms:XdVoaVzJvwmjfuGLmi9bA9mfK2YAoaEV5y77QtXQ4J1b9tnIj2QSbg>
    <xme:XdVoabQD9bZ65slvA78_ZpGdvCiHkVeJE_erKNhxqJUvG6wwxqwDh1LjeK4OH8DRq
    qF8kSQPgS1bFSdT8hwt-c5V__-eV05VqQP-T3-3fNBWm0hXk4_KeA>
X-ME-Received: <xmr:XdVoac9B371qRvIXdzkc77jsdP8QsfVaAAmGvNchq3mlH0wf2wGBXvxfv-bmpn30qu8yedxc6lRJgVgO5zsaEMgRsVSPN_rLWV8b4OlbnqPF8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesih
    hothgtlhdrtghomh
X-ME-Proxy: <xmx:XdVoaSpI3cHRUtP1l_oaiksU_uI0We37qQwfjwHh4u3faltYzXsdZQ>
    <xmx:XdVoaZnzizY-1g53FDGrqSisjiBVe4t0-LyjGe6kmxvN-OTRFNRvkA>
    <xmx:XdVoaZIZFtPGyqoWMGp4YzFvFcrAI10xI7M3VwdXzD9SXzvU7Zaa5w>
    <xmx:XdVoaezBjsVL_WzZtPwiqEStZO0ACMYtIc1TRzoRjD3sQ-zOyquUPA>
    <xmx:XdVoaZK14I3bg3z-L9rVJGgzXA9kIE7QYOYdVtkcbtR36uANvVsqas5t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jan 2026 06:54:04 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e9f5ce1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Jan 2026 11:54:03 +0000 (UTC)
Date: Thu, 15 Jan 2026 12:54:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] last-modified: rewrite error message when more
 than one revision given
Message-ID: <aWjVWC71rFeTsHLP@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-1-ba3b1860898f@iotcl.com>
 <aWd2SLrBQRBC1e2S@pks.im>
 <87jyxjjejz.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jyxjjejz.fsf@iotcl.com>

On Thu, Jan 15, 2026 at 12:33:36PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Wed, Jan 14, 2026 at 11:24:45AM +0100, Toon Claes wrote:
> >> diff --git a/builtin/last-modified.c b/builtin/last-modified.c
> >> index c80f0535f6..06e3f79aec 100644
> >> --- a/builtin/last-modified.c
> >> +++ b/builtin/last-modified.c
> >> @@ -145,16 +145,20 @@ static int populate_paths_from_revs(struct last_modified *lm)
> >>  		if (obj->item->flags & UNINTERESTING)
> >>  			continue;
> >>  
> >> -		if (num_interesting++)
> >> -			return error(_("last-modified can only operate on one tree at a time"));
> >> +		if (num_interesting++) {
> >> +			ret = error(_("last-modified can only operate on one revision at a time"));
> >
> > Do we maybe want to be a bit more specific and say committish instead of
> > revision?
> 
> I was thinking about mentioning something like "commit-ish" instead, but
> I felt "commit-ish" isn't a commonly used term toward end-users. Looking
> at gitglossary(7), it says "revision" is a "synonym for commit". I'm
> happy to change this message, but I'm not sure s/revision/commit-ish/ is
> the best change for this.

gitglossary(7) also defines commit-ish, but I guess you're right that
revision is the more common term. I'm a bit surprised that it's defined
to be a synonym for a commit, but oh, well.

Patrick
