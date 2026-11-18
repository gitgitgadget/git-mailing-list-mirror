Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010982;
	b=owsaF2XuoK6VNxnVbNK07oscallNEjSydsJtUXqelpZfxDeOFzmKw21Ox9uLGeGVD047
	 UQAlqICNHUC1lY8YgMGX2MqJjk0GET7W6dkm95AdMLu5bNtbwQi698kpNInmoVuxAcp1o
	 1HGeXhyWLeXjAVdHbY5ryzz4y0M9kWA9Dbgm0GC7/VCZNx8QBYwVfi3IkY5NZJaWMMTmV
	 o+B1rNSs4PQZaYIwBMgFzL+/51D9NcU5cTSLq1wi9wAstghsDtOfkDUBOL/NEpLVyDJ7E
	 ccXHfv8r2moHjQ4JOCSdBCSwExdwI1bOPBYMgekHooa1PGDWVxBuFxyXU9x7K1nEtTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010982;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=i+wU9jPpper78ZAYf5SuweI8T0/wlXSsbmYVlSAY6K0=;
	b=f8L/txBbYP5MY3lbr7kUiJP3+UZEHmrEkzOIWrHWM0s6T/LfRzgrwNeJch6erCPIlP4q
	 jxGsjJ7xNMg29bpgJ5HtaeIUtpAzprw0d9rsu7jxRadG/QDTDeuTpGGnkmJStLIBW+60f
	 Le7iIzuZM3gGyD9kPfa3htfmO0BVmRnvddQ96nFEO8txIxb5vjNu0MFNjNXZT1sswQFYN
	 BP6bz/tHRU8eLw9E2xY46IJ9D1/PpngyWy4SnG6oto96GKf3emFtVloY/eC1rknQ7mFHy
	 2YQE7Nt2LlILCoHtAjRWZrvZIKANgA8A4izQJHrmYVLpwdeYRgteuzQjESp8pBgkEgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="Gk2/HMM3";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2vuJ3ARJ;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130D606A32C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 14:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9130D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=Gk2/HMM3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2vuJ3ARJ
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF38A14001BC
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 09:09:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 09:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795010976; x=1795097376; bh=i+wU9jPppe
	r78ZAYf5SuweI8T0/wlXSsbmYVlSAY6K0=; b=Gk2/HMM3QENXbpywJ7Z7K8oO5W
	LFzuUyV8BQghZYDm3GgrbL+ZsgY2py7H59b8BFVaUTKz8Lh18Vlnl9Pgla/D/Dzm
	poI+UN2SyRCWrionA6M5ydDZP2slGp1W4EfHs4K6kLDisoTBD3Fz6K+fqW3CVz/5
	+F461eWPGEvm1gV3sNuWOGXIVN3x1JTFqC3WWOVRLscQSSV7RkCRGWqsuXKg5p4r
	dUtDmx/lBDIl8g0TjNr/k8x8zfZeSxkWbk10VX9N8K6C5VmHsBUEHqAQAGnOCFQ3
	epyIOvXooYOK5SQzWQ6r8PonQfpMC/SjAtM0RfMYdUDb0ED+GNqE2EZ2vYdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795010976; x=1795097376; bh=i+wU9jPpper78ZAYf5SuweI8T0/wlXSsbmY
	VlSAY6K0=; b=2vuJ3ARJ4BeC9LUI+woZUmB0NUKNHHGVExmRCHbPTGKkliQoauS
	gObZ/vznKw8AhR498kkHpHM40jMJ/YB2fAJlw1JMSjXuVLbwos91/rbOgEFT35+a
	i2u/iq86EfgpzuGx0Dw9OjR357uuzfdZWfTP0vBUc+CGJZI8o+Fig4nGptUahA7J
	Mjw8rRWEuFC1NU+Z6iCm4G9AUcOxDdkfNzN4bXM++zIoxVnu6WJ5buG2xAXUPIqB
	qNmfiO4hvQWDOY/b8jEOQIAckknp7pw9V9G3x2P81YwhEQiZVzH4I7kQ6EPkB1B2
	YGvyEbP+wordY8b3TeQj0FyXQZ1mDiwKQDQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795010976; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:oZsinKXtJxPPKlCa+t5r6bH2l7k21uKaU/g6x16mc7e0eWs
	c6i5fW97mw/p9vPCTOAv7Z9SrYL3zMYMdeJ8lxVVEiEJ2BvuLLUlqH+qKHrUGDVX
	u8dvwpeZBdjgMdQoqxsyWAfkcWovYzz/wcXn+MEhYtmBDx07d01JaB5d+FYhaQwD
	UZ9THC3ax9Xf2uirIDYqkK5m+mPuDgGVTAlp7pJnAFUtI9d6zZcBpoCJHFtHnilw
	18d88dtJBOZ27HsEFmww8tBBv5SXHqSh7U06jBG4Mv+FQZyacxFHWnjY849Vi7bt
	nfJknBO5kf3936nnsNYxnrv2x7N6bOBTzRRLoMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IXNW0Hlx6gH6vlfBU1hVbdgaqqig0oW4fnVtX25r8Bo=:ws5QMXmiPtidb3ynIn4ltxvk35FjECvC4Rg2n290WAQ=;
X-ME-Sender: <xms:oLH9ahYpkFDGy2QijXyUbQ7gM8ds3elltm-F-QskazFX-DK6PBD-JQ>
    <xme:oLH9avYCwine3lvXDhi-4GgjG8ie3lq7zApt3RLWgaPE-74VcoXBgBO-oLMyMSOua
    T3ICO5Bar4Fe_fh88KLWYWsDOWb_P9KhUk7hVFXNagF8tO-FgbGp6gy>
X-ME-Received: <xmr:oLH9ao9U9pK3J192OWAKo0dyOyFAFtivujC6tg0kAUtV2WTj42IvIw>
X-ME-Proxy-Cause: dmFkZTFsrC4MSWBx2mcWpJjRJPLVF1LbLQZCExV445qIVEvfKJdoe+2xVDv3P6exT1yK6w
    7Rz/fUovii6KMluWnVWPBlB2epOZI6VG6Ctjea6mFWZowW4QGsULOmEA0Q7GaSsqGpT1UL
    2V3fUuASn689fLnegZBkqa1CZeJ7gj9NRDgJ9I2/icDlQGbADcAFM4CWy9ckHR6zoAwxjL
    WoK11eljKgpywoaBBKb2kD0hD23umZBjHAeLdu7PxPypXyx3atJ9dpTdmEgxL2CUcnntyQ
    LaIqvxeKO+dauUSFJgyO7Ww8M/pXe1RaARMN/4wPlCGWAV6iCoMtahAwEpXMNPx5KJx/No
    UPhP1m6gRbD6CDT/H20kMo3Pd4gc0PzwJkoRporDIGrDEKU+SaPA75IJeKcx43733OGxNi
    N2Hxbt6n5Ztj9q4TOnSkm6FucwNw0u6D8DyHbwiKurcZ8Yg1bW8ZAR5gnkq4lymDGSznOW
    e0LQ5eWp2DpdFKfyecZvVsCSbol6vO0MrtdMZd2yX5SKK43hMWNtjKT/EZ0lZBIfCyjveI
    8fbM5XrQyVppeqgXT/awpfSjdT0vZzwsOY75dYuU+sdf8dfhzdEy/pOybN2Ovu6ZZWhKut
    +iZfiUQJ6Q7cjTEtvwOWr+Pdtt3WCHlvKEDcZ8s/PjO+zfZTncEuhkdYe+sw
X-ME-Proxy: <xmx:oLH9auiIzrGJmLmg8EnOr0Fe0xmX134TACy-yRCtVB_B17jqi_LTcw>
    <xmx:oLH9aofwEVcjTUgbVZsG4MAjfoZRfhitNcXVjQHbLcHtgUdB0M4Mjg>
    <xmx:oLH9aloBx030IBXaJGkXOaxWiTUD7fjnqGCogeBtXJ2aHirJAaWQNw>
    <xmx:oLH9atCC1btpaHjY7uat4IJGTV-o6bllEeA_gXbJCvEjM2Lde6FM0Q>
    <xmx:oLH9arLoYhr8Yz07xjlugEVFfXSwBvK_-VuQdywtcRICIzb39ZUjys6C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 09:09:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7aff497 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 14:09:33 +0000 (UTC)
Date: Wed, 18 Nov 2026 15:09:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 12/12] builtin/rerere: introduce proper usage strings
 for subcommands
Message-ID: <av2xijhHfFBANEHO@pks.im>
References: <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <20261111-pks-rerere-subcommands-v4-12-df0c8bf79e16@pks.im>
 <xmqqo6bogrvc.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo6bogrvc.fsf@gitster.g>

On Mon, Nov 16, 2026 at 05:37:43PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
> > index 4e6ab9a27c9..e04e9ef3ef8 100644
> > --- a/Documentation/git-rerere.adoc
> > +++ b/Documentation/git-rerere.adoc
> > @@ -8,7 +8,13 @@ git-rerere - Reuse recorded resolution of conflicted merges
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
> > +'git rerere' [--[no-]rerere-autoupdate]
> > +'git rerere' clear
> > +'git rerere' diff
> > +'git rerere' forget <pathspec>...
> > +'git rerere' gc
> > +'git rerere' remaining
> > +'git rerere' status
> >  
> >  DESCRIPTION
> >  -----------
> 
> The above is consistent with [9/12] where we saw that the command
> barfs if you say 'git rerere diff blurb'.
> 
> Yet, the documentation contradicts with the behaviour.
> 
>     'diff'::
> 
>     Display diffs for the current state of the resolution.  It is
>     useful for tracking what has changed while the user is resolving
>     conflicts.  Additional arguments are passed directly to the system
>     'diff' command installed in PATH.
> 
> We do not take additional arguments.  We do not pass anything to the
> system `diff` command installed in PATH.  It was a behaviour change
> left undocumented ever since 658f365027 (Make git-rerere a builtin,
> 2006-12-20) was done.

Huh, interesting indeed. I'll include another patch to fix that while
we're here already.

Patrick
