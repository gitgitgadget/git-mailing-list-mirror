Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255A915A864
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 12:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781527008; cv=none; b=tVVDpP5xyUAOl6gM/jiDY4oO5WLeYg1EtSt8XtzxMC83BcZgg+smX40mqkbUHMKkbjg5LsPP8+v/COcaYYFVs0TOstyF1p6f5wqstVVDexaPXsDhhIqJwd0bG8PGWJ/HdlvJGtk6Jm6Q1n/etNSnPR1FwRxKNQuZgX1vUZK3t3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781527008; c=relaxed/simple;
	bh=+gCXIDJXJ5jsOLW1FCy8IKGbVBhecA+2KV8vMdatK6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOI8tgH8GQZhQEGJKtucwdKuofKyAc7ExZ6YJ2RmNpUkuvgEYKe32vYklPmjx+cOnpqMUDPxyduiQ4Q8D3uu/NkWIqVbzr1Gtzn4/3kXfFGEanVnoXLrOvVTpGXnYZ+0pjiA+T5jdQ9PRAa4s5c8CFIaN+vSSTq2b6a/q70YD1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d5oA26cS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g4jXlps0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d5oA26cS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g4jXlps0"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E8E0BEC01FA;
	Mon, 15 Jun 2026 08:36:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 15 Jun 2026 08:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1781527002; x=1781613402; bh=DS1sSDXuYd
	hSu7cRC0HTQu5Tq2EygoDxnqHDV0xgz9s=; b=d5oA26cS1IR1CWyrNitMZjoxFW
	FYcdmE4vi17M4s6h6oGFG9r+3K+VXrylMrXpjgJDz79Yt5pyc8jJUcRqQfoJ9qMU
	4jToktW8rMZjnQV3b1TQiaryVIO0DsJ312JNEVpHYrzL3k5grkUNnhIUHCsGQy5e
	8x0Vb1wp+Kjw+gmlG82NmfdFqHJgdXF7gZyJlfZnnG4XJGQcZx2YQ8re/8Zvz/np
	p/XwWuH04fPw+86m77kTYTTU94pkFFtptXc9XEcGrXVIKHK4timIPMO+0N1uMdV7
	nPYxaMV6AoUjQfbDcaT4S5z02OaA5uEvmEf0qoVzooIQeYbUsY91PU1ZDs+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781527002; x=1781613402; bh=DS1sSDXuYdhSu7cRC0HTQu5Tq2EygoDxnqH
	DV0xgz9s=; b=g4jXlps0s8Vh8C+0obuch3lhb/mbyaOQm6mWTMj+2+tN/iwcrVf
	2WjKJlfPwct6yhDxwen8/WOtSabmXuKTi+/gASvX1wCoyo6jYJoS4yl6g6V/Muku
	fULAYeGLEzQzMfiecZe2GsctyiVEHi1Br8QNykMoVGAQU/pAgqPYJDXL+GEXbhFS
	jLVxxjRO7I9jHu1QzGSyP7UEE5dKlXSvPp7O71BTUtRw9mEcFPF9My5y3TEjJMaI
	aNgu37PJ+rmstX3fgajWppwzRpxEARTrPFXbnenckodi5lWNVBbRTl0hLTzf7o4f
	PcZLwnKsa7Y2s7zDEjtkpF2mJe4M6b32c7A==
X-ME-Sender: <xms:2vEvami68a06mSgV920hUv2ds41ndSvg8Xul9eV7zy7lijR13SAMyw>
    <xme:2vEvatBt2R3Iw0lBv1x-A8gfTfq5n2otuFizQdP_NfVwvZ9hiUqRecUqm-_J0_fIi
    nntDfq_LhS1rcSS0UegBg5VfH2OCZp2-zxfuCyNOAhoB2Xx25rP>
X-ME-Received: <xmr:2vEvaruXRd7ICq2PD5e_wzz4AFX5w3U8r7hjSr216hdmCDErLBQv4dXocPYoZynwvRcdtUO4h3YjwkjhSJQe659BXfCX87zcruE7_lsEDw>
X-ME-Proxy-Cause: dmFkZTGdrVSbvEDAk+RYsdA6XKO8+ZgDA4e0H/iW88R9UuUpcbM/o/6HLM8SPOIwO27Com
    d79E1MQqFJT9NcVqQ1KyVTIxGITVMO9QG5X5xzIWYt5rKBZywS7XNAMViCuFiNsK7cki+r
    PeEjORhThduo9t93dx7jutMto8jOapfIXJFw7KApVFQi3QndWgzicK+0oHNn/N44eMUQV8
    1ianTktF4CXCLRCP2DJ5Be+6U25YFXKZrm+VKvGfmsAtSt0CxhjY5KQTk9aiQPSp2Sfd4u
    k8kdZcB0lK1jB+RQnzjGcM6gdhBz71CLrw/yVyw0aQyjk2IPmS/FgRdfZ0JzCBaYBS6xqu
    W4qH4XpiB8D/KdKKBdIiS8XdtdGHvtbXWxQG61xDnCVg5++7EPdlpTxLGG9EpANxnrAHcm
    o9Hr96JkiipTlP8I5eBpLhMQ7aLqgW6dMry4wu+CFKOeiaI2oKqXTjlHh9YQZV0mIXVEbM
    uzB1pF+HL/lPnWrAq3HLD2bg7y6LESsUZvAEwyVvrFAAcvHycj/g28kJHEiuuBR5GV5YYc
    GlTyv3pv0ydxxp9c0Ub4M6GYX5D80dPMKqG+QVSJmbrfchMQw30zc2RlE8pDg1899KA0wb
    SiaK1AfwtDzz+ZeeMga/YwSYlTbccupDvbOOK96arqu8tC9vHCzL5NuGhiDg
X-ME-Proxy: <xmx:2vEvaqblMVxTn4WK0WpnV6e8LtPcviCUOglqTY9T00FosZTRbhNTsw>
    <xmx:2vEvamVpYKiPOucYIwelznDNmnzL99w7ZWYKq6k3QR91eywu-jKzEQ>
    <xmx:2vEvam6JcawOH0OGTGkPnjxBODVZtECny3poqN_RiBqNYzG4H7ba6w>
    <xmx:2vEvapgKzV6bILORp1JCgdcgYYFv2cg4NIsvn2xz6u5N9Mf_OgbqEg>
    <xmx:2vEvauQbeLfMs325p5mzgLzDbSE6x3MGLEEtp_IgR-WcHqdOg8DFZeaq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jun 2026 08:36:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6873ed95 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 15 Jun 2026 12:36:40 +0000 (UTC)
Date: Mon, 15 Jun 2026 14:36:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/9] setup: stop applying repository format twice
Message-ID: <ai_x1eKiSC9LZM6v@pks.im>
References: <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-0-56c864b01c43@pks.im>
 <20260610-b4-pks-refs-avoid-chdir-notify-reparent-v1-2-56c864b01c43@pks.im>
 <CAOLa=ZQC7YCBxjxkbm8qcWqpNFgAKNpvw9B6t=+XnX4bbkGq0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQC7YCBxjxkbm8qcWqpNFgAKNpvw9B6t=+XnX4bbkGq0Q@mail.gmail.com>

On Fri, Jun 12, 2026 at 02:00:20AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When discovering the repository in "setup.c" we apply the final
> > repository format multiple times:
> >
> >   - Once via `repository_format_configure()`, where we configure the
> >     repository format for both `struct repository_format` and `struct
> >     repository`.
> >
> >   - And once via `apply_repository_format()`, where we then apply the
> >     `struct repository_format` to the `struct repository` again.
> >
> 
> Okay so we're talking applying the repository format to the `struct
> repository` specifically.
> 
> > As the format will be applied to the repository when applying the format
> > it's thus somewhat unnecessary to also apply it to the repository when
> > adapting the discovered format.
> 
> This was a bit confusing to read at first. Okay since we already apply
> the format in the second step, the first is not necessary.

I agree. I'll rephrase this a bit.

Patrick
