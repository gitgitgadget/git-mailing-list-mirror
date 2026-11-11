Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394937;
	b=QTyRMKOcWmvHkbPiQgBikzFtTIRd3yiBGke9o0MUFI0HQCvmyIauAxhLNDrDq/XUUQGw
	 h3RU40Pe/5/Qcd8ProPLs2zm6hzL5PEbJfsdE29FK8gozw3ljrCsxSFRlVkLgGiA3ymHM
	 H0EIme4KECTkyw768Di+VOUoptHS1+o4zS756ElkCFKE7cRT5jsmWN+32dVyVXoam1ENB
	 WUX4hysUhhiMIGG9wRsUIlEKH7bGfgM4JdnTKWwoLvcImFCYqjbSMzpwtTeLI473CFMcZ
	 voR2uznRbkiG3VHHncqTyl8XLRZ++6BhtkGAPnoOAu92JWVRr3C+6ghxCNtQzqpBrag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394937;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=5Sln4P4f3ImXVMlgB309g92MGczoRztHYHsqYQ82IcE=;
	b=MbHTsD4kVE3CkmTHdhVlMsPnA9H4QEbb9Xhb/bM5QFMLFXZO3kWBJfzBAjqv4mO87a8/
	 j8OxJJr67aKILkmFJVWHi41wDnsXQMOIEerzK5o7mhDgakklkliBV1RJ12Cu/NvFywg4q
	 T7OQow2C2dAfEWNbzSk5anFahg2oqoFppTz4b6sThjKd/wJEQ5jkBahmwYgvCjP/dKk/w
	 SV/3Zv6r0xoKj7/3tX4yvNyOAPeajxMj9mra3PUAHa0JwlNnbahIKW5uvMLH6bRsC1MfB
	 b9xRghCxXsw1W39lESoRLMdtf70zbISDyAP2XmmklknJRhEPgQjMp4TpNQSyhm5Y/mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=VrXCgxXI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="jFc3bIP/";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390DA606A32D
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 11:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 390DA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=VrXCgxXI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jFc3bIP/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 28F1714000A7
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 06:02:16 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 06:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794394936; x=1794481336; bh=5Sln4P4f3I
	mXVMlgB309g92MGczoRztHYHsqYQ82IcE=; b=VrXCgxXIpMCim6I97haAa9Hn4s
	H/qKDaFbAu1H7zil2Z9CKQQ03jEE+39RSF9g2eU0ytBo9peThQEp3e3+UzzgoADl
	Zd9Ihk+UEKVOm0ykDwSZQcIWjSGv8asH/D5z+M1wxu7++O62ZlO1DCV3ijxdNRu2
	6otByjNXuID5S6vjHSJLnr2zuejj9Og4/76Lq/CUU0QbK7y1m7VpruJx9T1LAveR
	COTKSL0PXnEJU4RNzdPHkENEQpGE5SvTFsJqLZ7sZZvEq77xETneeD5Dyu8vudaB
	BNUFoztChhxMKXapdd7ywP/Hst2d4lGJeQj1/186VT7LOQ0sbteUZxWzQpcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794394936; x=1794481336; bh=5Sln4P4f3ImXVMlgB309g92MGczoRztHYHs
	qYQ82IcE=; b=jFc3bIP/iUhqSxw6HMLLhvhIiuZ4B7mB9paORaIfUpncwK2r6qs
	6SMsXE4UqPjCRztHSACiDwBGGcw5jVTaCDTRsvwQdrHPR4XV1OhZRyex0XQxmLFI
	LqWYOAQI1JWyuK3mT+JwY9yTdfG0+9G5zCq0plxryee6bKY9uK1eqLyukOYu9ESU
	+SznVynQ0RtN/X6eWUg0O1Mwi9TNEWc958XdHklkZ7cF045qVhe0cf4kpURuHsHP
	7DuGJO6ixeUwhfW2zrpuXRzEK6QURtw0GlYe0GnSfr/L3aN8ZYPbhOw9wVSYJ860
	OGQuDLWt+mwvuNqX+KO6DfPF7D0Ve73bVIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394936; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:pALnL983zBDyd3mqOtk/Ss43agPdVCcmzWulkaA9Y5nbbKw
	fxS+ajuQAJh/hnctejOm6+zZOHV6R+Eg8tJpB8/KDwSwWJqZEyGKEY3+R5mqwnGU
	DMOCaUAaUJ7UiqG5uiJ902Ag/pEMx1RiRFRgPCYVzOx8z+1azHVblqH7EyPhVtF4
	2PVvznYmqkGMahRUMqFCjXAlpUQdC6elpqCFdVRcPIve+8MdoULEA5SRGQj2GP2b
	Amk9JwnLEdpHwzlJudxMYyTPqqou/OV95rIDf4VhWIq7zaJTbfmL1SkIoL9u/gdz
	FAZJS1YX2V9AcV6NLK/9DxjvAqXZwfcwfrRGQYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:WQu9k8rbj6A3IY+a4PGHGw3vmXYtWT6wXx44lVLFP08=:Ql38tcRHccIc65R0HdC9izpV4E8RJ/Wf7ZGxiQXAr5A=;
X-ME-Sender: <xms:OEv0avZ_4ISQrcI57tLm_9YHye_WGUeGO0vPbCKEQRqdZTnNF4bAUA>
    <xme:OEv0alZAhPStCZ08Q-2467wTWUl8k4t7QQEVM9tljDl3MH8gI9DVLXsmCAqJB3KXZ
    uq-5damT39uHhzDirCaod7kHA_nJt7KMUm5FfgICth1rKeo0mzdOOk>
X-ME-Received: <xmr:OEv0am-2Tj9tbYz15v5z9WkoxR3rZNyLbm6MYTAWr3rlPgeqMOtN7IOwUZs7JrTrXTH1bg>
X-ME-Proxy-Cause: dmFkZTEG99pfFHB+545wx6op22ZZ2Glgh5KN9i2WIPtTTq/X8GC4RaeerKp+yV2MZOPyzO
    jD8dzL9KcTzqx86KNkjvU3EUMIKBAQetyZcwjm6DmZotMho3en9223kknmWtL5wwCdz3/1
    Sy3JlmvcknFRQfju/+C+w9ZLepRxZWakvCMRRkWVtnPslJZdcBdz5r3U5aoF4nPJDFf3/K
    m0hdH0eD1wbK4DFmmcRRBYqvzvEUoCphMiFeeEqMjpNUgPnzHmCgUOY/oA2UTvzNB1uLzr
    dRtNAqLrIMMXvb1lpHkBeRkG2hpl+swff9IRBEOKEylnKLziGRR7bORC5ZH1rJZ8OIazgr
    y7gM9LXIVo5H9sMv+wU4BqpgBMVu4w3hKzudwO0/y5/h9paZLxHOyJLP2VCM3F/h6o8OAD
    8aFgywYCqpL6C0qAP9iMyLvyV7Anc47UoL2AZeak1zNwfxIsf4vg/3JDLxA5SoEptBLSNZ
    1FExOX8J/jDS6e1gQ1GFpuSZCjV/FNRXvbH68M6O9zW+77NRVnKUIPSITou7Gxwkka5HJ0
    THk23UERDFEaCmRdXQLhnLKaxsmwJkznN6c9WrRcEceay/2nHoLTWrNa/8nkVHG4g4oluP
    07kwGXFZx4RC48zYWWq7HCxJKTcL5Hdy4VqtCbsFUYflMNVJ8DJW6u3m1tFw
X-ME-Proxy: <xmx:OEv0akh13_URPcLfiFoVUwoeyt7U69ReGwxNW-ecLlyhH_Q1LwN3EQ>
    <xmx:OEv0amfVJK-JXAki3M51R_LMqT5WTPyqjbsbrQrWuEMEokfoiELzvw>
    <xmx:OEv0arq08wVzxJZxiCgfNKR_-TahE5KTFKqgcKUG7bV23mYBp_Rc1A>
    <xmx:OEv0arAihuwAK14CAe5l2SrjFn7g0fva_eF_1UaZhYjgS925rbvDQw>
    <xmx:OEv0amedPRFNoPmMPzOl403qy_17dCKxE_YC9a1sl4oXMd7AwY-k9xvb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 06:02:15 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00b20ef0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 11:02:13 +0000 (UTC)
Date: Wed, 11 Nov 2026 12:02:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 02/12] rerere: convert flags into an enum
Message-ID: <avRLM38NKe81u9fg@pks.im>
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
 <20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
 <xmqqqzgxlxrq.fsf@gitster.g>
 <avFxCywngxJgwylf@pks.im>
 <xmqqld7210a2.fsf@gitster.g>
 <xmqqik25zuku.fsf@gitster.g>
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
In-Reply-To: <xmqqik25zuku.fsf@gitster.g>

On Mon, Nov 09, 2026 at 11:13:53AM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >>> What BOTH versions lack is an explanation why RERERE_NOAUTOUPDATE is
> >>> needed in the first place.  In other words, "How is it different
> >>> from the lack of RERERE_AUTOUPDATE bit?" is not answered here.  And
> >>> I think that is a lot more important thing to clarify.
> >>
> >> Heh, in this case _I_ thought that it's implicitly clear from the
> >> comment of `RERERE_AUTOUPDATE`: it overrides "rerere.autoUpdate". I
> >> figured that updating these comments would cause some discussions, and
> >> that's exactly why I didn't dare to update them at all in v1 :)
> >
> > ;-)
> 
> The command line can give us not two (which could be represented
> with a single bit) but three choices, (0) the command line has no
> preference on --[no-]autoupdate and follow the configured default,
> (1) --autoupdate, or (2) --no-autoupdate, and that is exactly why we
> have these two independent-looking bits.
> 
> But two bits can express another combination (i.e., both bits on),
> which probably is invalid.  The underlying OPT_UYN() calls
> parse_opt_tertiary() which only chooses between 1 and 2 so we should
> be safe on the setting side, but I offhand do not remember if we
> detect when both bits are on and BUG() out where we consume the
> value.

We have this bit in `rerere_cache_setup()`:

	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
		cache->autoupdate = !!(flags & RERERE_AUTOUPDATE);

So `RERERE_AUTOUPDATE` takes precedence over `RERERE_NOAUTOUPDATE`, but
all callers know to only pass one of these flags. I agree though that we
should detect this misuse and complain about it, it's certainly not
obvious at all.

Patrick
