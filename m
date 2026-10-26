Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793034483;
	b=IKHCXqhV5DiD+R5N6bWGlmrBR+wTcXvJifbWzMogphwQxzsOtYWqLGjCUba59z4PbQrY
	 MdVSRrs2/vp5UchNxEdXcW6aD/fAIN8wmdpIy0N4+RV8DMaMdNVY7XE8sbPkZVl9XAUS+
	 Dxd7seWMokmjUrTE3Y29Xz2QA73M4FJZfQFBCEXYQd2PrUrY2pUZQ/tqye8VUFhj+9vjj
	 p+23JoA335gAvglSqjzV25BTz2+54jIcFwACTBbJLoyp65yR3Flt3GBqeo/PeViGSQSYO
	 aTTw1eSyWNv1KI1i/m//8kIDdSZYBN7nTmGWIYK2KCGgsRvG/PKmY95kYZTl3DKNbhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793034483;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=q/YTcVF2Tik2sZBhMw24ooITSfBugkF/PRuBQEqRxM8=;
	b=RgK57ljyWxWX4L8zWHzPqNI6WvEocfp5oJGVqguo9F/kdnD4u4bZXyfmU0cW8MHw86Bu
	 RCYvQrcPcZz/Apr6QSfEFwor8lT/M9IQJ/iGBwZKlUAWyp0JQlkc78pSfTELFCTtECToX
	 P6semmr3RhjGFuHCIj3ed/KYR4HmZr/oSrUoVSFyHmHLy53+lh26xy8kuxLu6qXmO6Boj
	 jugNZ92F1cwfnUvinlPRZdmFoBlSR9sVlRzkcEFSVJnfRvptGV7CnJhXzGNEY+FatEPnG
	 uRgpJRq3CUN7EOyMa78Jpxf212B4ZdImpGygg0xQO7/htHWD5y8rJUssd7Th6aDM2JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DOWKZgRQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PlXyU20q;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E2F606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 17:08:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E2F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=DOWKZgRQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=PlXyU20q
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6AF2B7A0412
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 13:08:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 13:08:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793034482; x=1793120882; bh=q/YTcVF2Ti
	k2sZBhMw24ooITSfBugkF/PRuBQEqRxM8=; b=DOWKZgRQizpWA1FtfD1lUOFZdC
	F+X4MIy9I4ZXETHkC4UV3DTUaDYplRhCp6he+CBSuOSI8pW0H95VzD6lhvB9nH0v
	kpGZNOHH+eq+wmAyOHGsPeJSSO9o1GmdbGyu4dBpvhflaZzd4JgQoezy4Jxr7hPF
	wszgtautAVg4xrcch/+vtLAYZJj5MxPWvk73N5ADIryeqdCGlelT3CryLeJ6k6Mk
	FMYLQGKUxgaatToVKXjMz4EktsdXuFNHQyQE8DR9IeRNl1uqVh0kz6zsUnmJqEl9
	D/HGGf1KvPiIuJMDc9ZeOBCvKuar+u++Um79xoH7NbdmTRymsZhZa10G7tRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793034482; x=1793120882; bh=q/YTcVF2Tik2sZBhMw24ooITSfBugkF/PRu
	BQEqRxM8=; b=PlXyU20qTINHi9b/mo/c9/IYKnKGJhuNNCbrO7CFQqE2OzvCl0B
	b6S1k5s6mQc1X7Wi9oQeD6Avy3gndwmL/DfT80ZceYV7ohXDGYSwsAWGGF6ymzpc
	IW9yfvaUFC9+Fjb5waeENuQExdVQfDY2DmpFmvLbYTUxImJ3zPMa4lt6yQ0DxUL2
	bKfJ0qtKRlnRCDcOLgcAGw/DbcVNP9876fpxYKoy+0TUer9nlta9byylJVxMZOpV
	y7qTP5VoMVU1YbnMG8fzk0kMHI2WAJi+4PkCsVdciYHoSkvspa84vfLLWJ+jGnO8
	J1qEF/k29Dg76hyrHVMG8DoyFUOsYGdN2ug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793034482; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:c2wNTK9tYMl9VTXTu7OP4MRlVL24HrkeMHzFriWsjdL76Cd
	N0bJInaKPsoaJsQVwTw5tEUy+PCE/+NzX4VNwQ7E3HYbm4/jIYxPVAuE+UOSfze9
	BX7Wk4feOsirbNPC45dLf0E8Nyqw0Z4vLagn7FSFdb2UkezpMgru/RyxFu8bdVsR
	l8z9/HcLhnmMGEJ95PJ0iz9Mf1Q6fWvljVZIBit6Rgshnl7/8YqUxtjyslCL++Rd
	RCKG3cDoLVCZXl8dEMAag6jB8wTn61WA6/FIJazk4QhjJcg0BJAalBq5qeM3v9Ld
	6aLyiygeJXJ2FFGvw477o84vs8AhZjhhDpwV/0Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5JxSW5SOQizliblbO/0wjrIb/8uSLKXi6kZtD+12k6g=:567AP7nt+TatfbFJiu5ua1lDppjpgH7fbNhmwo/OdYo=;
X-ME-Sender: <xms:8ojfans08EaDqqX9E2NhObSSiHazmvdif1LXQ34M5ylJZ4iVTbIHEA>
    <xme:8ojfavXA_Sl4YWa016qpbLxOGQTbgK1GeQRakZpp-5ItWKEqzG4o491vt00ujtEAE
    Ig2qUMgeutXmMoUAo8TQYzPmU-Vbs2BXJP8VoJsUHbXZ4vy7m6Bm-ZG>
X-ME-Received: <xmr:8ojfajHZVdcaIapZX0lH_bEC0mhm7d-pwViLkpw5RHUyDLGZtonocmd5TB3em87B7wih98_1kpA_aPoZcHQEjiLj0WAkTjxQgwMs>
X-ME-Proxy-Cause: dmFkZTEVgqpLzp3un9eOcP5jvOqiJsOC82h6nzes/HeIsDMvmdphE2Q0zF6DmzJB59QQCR
    ukKW4va4jmfw5UN4ZATtK7A6uzCZ6uxiXRChVIILwo3bgNqEBAItucOW2mvWa4aMrsDSEf
    HoMym5kHkLQbJZyo17d6WG0KPrCSNWcU0hi9wdQO1wcOAzvVQHpSaMb1rS1ekSsHVdZo64
    odMYUZBETgxczo2zevlQzc7252Wlz4T6tS8pbXmpyEE9MTlEP1Dkf8vPSEdrmP25DqwbiH
    UWpsdiHIvn2QU4rsYUhHlVexRk9ZzLQvyvYqV7Xi5ou7Mi66w1PlReb6rBWYulpyfmPUj5
    TtAMllVYGDtcnfT8So48xlJhLbr5MaTbKFryy7I+Pcn1wMqQtRNgfNuUkB39ylYvXSfWGI
    /qRTKFZ1VSJ+oPzGvf7LLLbeNuOg/kIxP6exEeBMd/h4XtJm/iJNS+uy+D0VZb56KHv6sw
    3F31j4vPqfT6ERQHFxwpJrDrgeA0VngENC9vZSjxL4FMVfDbfe5ylg9sNSMPpUF04M6FpY
    U0leMGZr0G2Y4rBdW+CnqjYKMH4aoSFrp3iunjfyAMX53gFcsnf1pInjiQ715E52AP/oV0
    duRfn19zs5ErPmT04xfjP0un+gTDW8mJljZxDXyquohKarF6n4pcftrGgNvg
X-ME-Proxy: <xmx:8ojfah2qfA1kZKT2ow3hhzpnSTtnssuOswttecFPkG3fbDUncx_zEQ>
    <xmx:8ojfalM5vOyVCHOe8OWQc82hmyVePaAQUuziZ-2ndybIPTj9DaHyIQ>
    <xmx:8ojfag5UJb4D1_Qso1w3E9mqESTzPAhBExtir-wxb0r5ufkuhxpxRw>
    <xmx:8ojfav2linY1SNqdgg0EwV074rAMNcQ-6b5TP1aCnYULj8kANgA1_A>
    <xmx:8ojfagWZIxkHUF1ol1RHdhiu89ThDMWxfYK9cOK5S7tH-CxpaVPpHS1s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 13:08:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Julia Evans
 <julia@jvns.ca>
Subject: Re: [PATCH] glossary: use "object ID" as the canonical term
In-Reply-To: <pull.2282.git.1793019999896.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 26 Oct 2026 13:06:39 +0000")
References: <pull.2282.git.1793019999896.gitgitgadget@gmail.com>
Date: Mon, 26 Oct 2026 10:08:00 -0700
Message-ID: <xmqqecdcs83z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Currently in the glossary "object name" is used as the canonical term to
> refer to an object's SHA-1 (or SHA-256) identifier. However, in several
> places in the documentation, "object name" is used with a different
> meaning, for example:

These other places should be fixed, IMHO, though.

>
> from git-rev-parse.adoc:
>     Usually the object names are output in SHA-1 form (with possible
>     ^ prefix); this option makes them output in a form as close to the
>     original input as possible.
>
> from gitrevisions.adoc:
>     Here are various ways to spell object names.
>     (lists <refname>, HEAD, etc)

You can use <refname>, HEAD, etc., where the command takes object
names.  It exactly refers to those 40 hexadecimal digits to identify
objects.

I'll reject this.

