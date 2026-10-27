Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793129378;
	b=hexXNgtrzxL3bbtN8M30FGWn93BldJ/dYzRNkc9Wafri1F+3JvaQSIwhqMd/bkvqS1Rd
	 NDeRQJbuhUq0TyUvJbiQaEh6k6iHnhwm1/9EwDdjxYuTQanlwFwtrQcO/AgSlM40hGq30
	 MFK0U9+5pTlYdZHY489LQOI1/Y+CLUZvTsVpZuDlteVEmHbjy1/O7oX9weZrRFM7fFVVz
	 YbAuGvKkg90kt4APR9VG8TPlszdzgJ3AU0w0GpwmIpGeBwEdukHNI7b8sjX4VuOJUpbSO
	 s/H+qM3Cp78OFYEXFy4bpdtTeDYfA34u8GeDrnZ17adv2Sjaui26v0AVIpkD/UaKWOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793129378;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TWxFGQEalhwadFrBHnidI2vxNzEqMlITH/bhRpPcrdE=;
	b=j01+8Jt2anZa2Hf6tYazM59oWD29g3cO0bknX2sBu0BEsdB7c4wpX5CrHrrxlDJoul6P
	 /PmoVv2CRrZpWo8dMM4o+gKFdLMRW1fe52/96g7mXtSTfXi9LjiFn+ue8fWDr5o1feEZd
	 41maBB6oDRBHT/FtuWEgM1or1DPFjv74dHtQsvh8tGHK4XFTgQKkFwwyWTjNlY9LqatTc
	 eXxgX6/1vHbAfv+hetWdZU0ZvWIiEVss+NQOZYZcFD+KvEUS7yazReCT1xhEtlkVDMox8
	 SyW6Rgo6azQ/xljWjJwt+E3WhPzXsG6Bk2SUzD/narsy5QFtm7CCCe6RGyWNZKpgvdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ng0hYqz6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Dq1xiAuh;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7D5606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 19:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F7D5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ng0hYqz6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Dq1xiAuh
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 9E96C1D00133
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:29:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 15:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793129377; x=1793215777; bh=TWxFGQEalh
	wadFrBHnidI2vxNzEqMlITH/bhRpPcrdE=; b=ng0hYqz6eOE6pLsVpRdpdtbjCO
	piYLtoSB7AdSEEogmqwfK2QCN1EKdzTZZcvl6sgpbZWr/CrDMEPdxZhQRT/qUedt
	ysvtMLy89mcr6AHBxDSAEV2qi9TIE56xIhKb+YEFbNDbEjQS+Fe4Ju+5hhXblwEe
	sPIrqAX0Kvj5ufl4yW8IgZhClKInVHeJSbziH+Lji43MLogoUKCIhPaflq0K/qQY
	xYQFvHD20YBo8rG+o41FXpxi8Jidi+5Pt71Jb4ua2J4V4mcA/9wlU9V5MhE2B+2N
	2gbIEJxSIIuui0sBG8trRrTuD9Y7OJ/opryKDNrjyQieJoSaKnnyMMMKB/2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793129377; x=1793215777; bh=TWxFGQEalhwadFrBHnidI2vxNzEqMlITH/b
	hRpPcrdE=; b=Dq1xiAuhKmDimIhAR4yO+TzxRD66dC5q+RnLBrzKWnqWBWRazfs
	G+xXN824h5+LAs77XP7Ge/B5HDjAilRG/VImNaNjyqgrl5yATaG0EUATVm0Uqlr7
	lPjUZ+DhF7yBvN0Civ+CFq47Z/A0L7yYi2whjkMXqJp5tpLaMMk7AH7LABZ2E6/1
	+FOGZLkxQBsFWBtbBXaCPeot4x+0aX5Z8KTmT0qS0f9tQGaaL8kycUynYtZgvtiE
	1+OZbnOc0MwHLaNYRonHXzOVX/hZkuElSHpag0JY1RZS9qYdTCdhvruytHahzQpW
	uIqI1aonrLpf55MioeSUfaiahpa5L1JOpOQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793129377; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XmdzZhnmjNQIm/g3egLFxfScmAq4tt9pN64rOHpIIlvZ9Zm
	SH6P6xOMKhF+t/FPXGPtTpDxMlsOHWoD0x00SRH03hJrHk+zXvuqHRl/GYpq5UaK
	R+phW50KTOjggUJx0Q+UFNq9mHMredPxkTbWRpthJO9qbrpAx0voKxiKYdPLOR0D
	EP1qwMhNwa2k0zATaIM/W5K+CwkBXcuff36OQrGqhHrLjtdFcARPrtw9Gugs4OVB
	0zh0IHi0lCMSj8qyADBSliBSb5pzODhxSBW8DM2kKghuFTEZqHrrO/n2ahfEyCxl
	hEEGHeqWlM5lxHgrl4rpdoPDmTuxumnslYsJBfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:fRNA7d7QedAlE7BGZPfUefXL7Ao3QqrEbIDfq2H8Wtw=:8b6UmySKddJIRHKnSgm4Pyw/BGA6XHsvqRmWlx3pG2k=;
X-ME-Sender: <xms:ofvgat92hKogRKD7vtB3hI-FITiE3i8s7_TBLOVnDRHQ229fIMyd-A>
    <xme:ofvgapLumEaqgM8jvupBECihhtx_ppATr13AwaYIilWEkwT_S6fJV7fSjv4njRvcQ
    qQsRNIscn4jFfFd6VatXqHPV6j_7j6k6H7v3kgNCQQVVyD5DhLn5go>
X-ME-Received: <xmr:ofvgaobIijQO7V8yjhVcyqNQo3WkbcDii1IZN_5DPjJ9nhte8q9ZVihRRgeYkE1De5yWo5c59O6p5obf46RFUXJYbyR2ovvgbwQo>
X-ME-Proxy-Cause: dmFkZTF068a0Q+cBs/k5GO3vkfgeBRxKYhn0Fv4DoYbH0Epz2JphfDcn62DYSQm7xdfJQR
    fp+1dwtxhXHt5K7Ltb9v8B6Ta7aEHyTqtcfavSp7DaZOcBywFiZZBffoNdlPupMU+r0a3G
    Aal+Ovc5V17xz628OGHCEnLfxsuZnm/nlvZCKubg+dsxykKzkYEER8aBi7OPh85LrfsiWb
    wmSTPdsWVDFdN4/LTjzSIxrTYggPAeImlYj0Yffx1wvaHnIMOzod97e8a+OKU2HK2bgZ6T
    ONrxZRh4H0tMilH1u/jzRT7cW8kU587RBez7zLaRFBSLAd9SN5Eez11IYh2KC1jpTmposg
    kp84KfhQU8QvIRerZOUDiqkdd3G6kGtZ9FfA+bbYurojhfslU0xJi0IgoWScB/3zcbht9d
    C3FKbbqFLymrKbbOcXazpfKn651VgconyiYThVnWhVjrCLUWOVJ9fo3qM8Dbf2LJZUV6F+
    2K/CoYqsnk9Wix8TMye4M9ifmkXB7aJSUHhDe6vUauCI3E9wXljm9pAdNzhqmJ9vQaRMXw
    q1aX9NWfOL+3Zlg6zZ7kl/UtK4K0ZNXYc3WRRkqIy8XYA6GqJN3AIi40XVNfgReVlIc+rz
    0z0dmSHjwOOogphEGBlLuFHb9N8SKDrm17jEQc1HufaH53dNdhYVlQrr08ew
X-ME-Proxy: <xmx:ofvgarJIkgdVaNJp2Rqb71B2woJVD5WtSJEkSyDc4tc29b3R0wK3og>
    <xmx:ofvgamBbEnGqlNUXjSTXhICPoDTAnEvuSEX654cyu59SJPm6XQ4Zyw>
    <xmx:ofvgagqp-in4Tt-PvVGWu7MCCd3X4Ec3bFHg-OtHagTEpnzi6xLqjA>
    <xmx:ofvgahj_owI_9wH8JCex1RRnrGfvG42-eSnB1IjZDpnSF2balJFiug>
    <xmx:ofvgalLD-QngmQx3ZNZuTxvF1R1jAm4LTuONeF6ZLrjuDSy-rSVCJPe->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 15:29:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tilak Raaz <raaztilak07@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t7104: use test_path_is_file instead of test -f
In-Reply-To: <CABB4Jh3QD5-4d8+cSgVj+WbP3Uj+FHqL4kS_4uP5anepTEQCQQ@mail.gmail.com>
	(Tilak Raaz's message of "Tue, 27 Oct 2026 08:46:04 +0530")
References: <20261026164536.50520-1-raaztilak07@gmail.com>
	<xmqq7bj4p3ax.fsf@gitster.g>
	<CABB4Jh3QD5-4d8+cSgVj+WbP3Uj+FHqL4kS_4uP5anepTEQCQQ@mail.gmail.com>
Date: Tue, 27 Oct 2026 12:29:35 -0700
Message-ID: <xmqq8q3jj61s.fsf@gitster.g>
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

Tilak Raaz <raaztilak07@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> This makes sense but what is GSoC doing in the patch title?  Has the
>> program already been announced for 2027?
>
> Not yet.I added the prefix while preparing to apply for GSoC 2027,
> which was premature.

OK, that is fine and makes your patches more informative.

My question was not rhetorical, complaining about the use of the
mark.  I knew (and confirmed later with the people who run the
program at Google) that the announcement would not be made until
December, and wanted to know if there is public information that
says otherwise.

Thanks.
