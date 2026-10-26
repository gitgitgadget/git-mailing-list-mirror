Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029462;
	b=zoz6VBZPtAScxshHwQS4t3qfvyadoDF5YeG+bSxUXhoVf3SooPq3FmpuEM3KkD7OHSKe
	 bIqHUFLX0DMQ8GcfPvMtL7d4upTtEuZ3pIYs4v4cwXDLWKaQ9penzdUQPhhnl4SxYWiYB
	 NrV/fnfN1ODRyIPATnkuW5SyN7t1NFpJSTcsWmzCOvzWuZklDdpCYPmFIs4iyM7EENxEm
	 /hkjelCW1l+RR/xKHVQAcuOCFDSOsD7k9wIs4fxb2ChhySVAB0qVo3f7yOWO35Fm0JIsQ
	 Hs3QCM0vBgT4/N1uPHJhfvtD4/elTUsOqPlnLIMn2DJ0zbdm1zbifCtHDwno8PSJxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029462;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=DduWMyMx1OQY2hry17EEwHnjZHFlszU+gVSuHQAXf/Y=;
	b=xVZegJJDGtTYem40eW74QHpSXjZBGUbWPCz4uwu6BhCWWz5eqJojXx3qLg8E+9Inskk1
	 TxKoX2MtfRlhOVBty1zc+WjbQ/OK5RGVPxMznKMNSKO9/S/nZySKVV2LK3550eZNB5j34
	 HYSlLMxRR4erkdU161WxYd0lo0PI/2wjO1HctTTRkg9Cqz7i3/5KGkHqSYvcKPQC2Lpdt
	 bwEx/480AcpLzLsI8Ilw9VeioioQTrLDW0jTAZ2eG15OiLp2ZNhqCJI00ICK0WEjKwq71
	 whQne3AZ6JBZVPDvEpCcdsFVAMykh/k/Roqu9jj3F3ZPK3Rmsk9driLoQGcMXI9YsUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QoyKZUUe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JqPoqw64;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A245A606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 15:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A245A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=QoyKZUUe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=JqPoqw64
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB4DE7A03CF
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 11:44:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 26 Oct 2026 11:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793029460; x=1793115860; bh=DduWMyMx1O
	QY2hry17EEwHnjZHFlszU+gVSuHQAXf/Y=; b=QoyKZUUeZ8Vs6g8GCe66A7RPcU
	8UPKkKpmf8O8yWW2+t1OnVACV8cBqy/Bv+uURlLWjSJTPH+6FhZOVnJrKWQ8PXL9
	3qnzwxGzIgXU/kDnheZygmkb3a3duHrNeGKBXpb8cSByo0tIss2VMtujnlIVyo3q
	o8BCp01SIRg/UA1OnbK9efHpFnhemDokuYtTr3Wnrgp/W8ww/0dTXdCxxjN6jgcM
	iA6ZKoLlIfsUVkpSEm+McLUPZPXLBjn7kkTCrffOPUtEJOsRC3jPIlR1sNRtiwNc
	H/wITYsvOVPXN4CE2/kdVUubkPB4Z5BQudEttOQmA37jPPfqpc7ymfq3eW6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793029460; x=1793115860; bh=DduWMyMx1OQY2hry17EEwHnjZHFlszU+gVS
	uHQAXf/Y=; b=JqPoqw64nI+KAzrovfZNO8qdgbjVMOfmVFSAaI4VlkRxGMLXIXS
	sOtdhEKaDVEyTxRPxaONW7VbyoC5NHWsfWthzsvsNoMiEiy98GjMMc4GW/BXD0Ju
	B/4MUvop2CsFRr27618EanhNbHJM9jpTDc/XKMQ5ysoCOjoXBsk81mNohYDR31qC
	h7SEOFh+tfkS2OOq+ji5fploHH0A3p0hnQ0Pp559MxPs1XS5jch32tg/+ygnNJyr
	MqU4V5ZVT+PV71prsgXXcY/LA7IKIGyUzlLdpvF6SaKfY/1OEqZfQfTA95QGYc3N
	SV81hiwZrb2jmXLRixfAd1AyOArqYfAJo7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793029460; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JOZWY0rQGhnVSo7ygCaJvgq6Yq9J9Yl0w58CUONi+tOsOgN
	sKtBuiDi02K2M4lUzRABxBibLLSEi9ZcRMcyzyVwC91QE3DX9U7LEMkrNromiifs
	heh2QrklwvuA/DPgzf6DeoOLVd9ocyxICcXGqh0XcAAFBif+ELwEr8J2Vm3yarKP
	h2UWCiGL0Wk9z/DfzP0usn8jjcktT+muayNl9xrNsvl/BIUL6jWISXSlp+OQrbJY
	vl1jMVNImczDQcYZjCUZcouDNXdDL9fLo2OU9erZx7oTDY9geXe0B0XcYF8XkRHp
	FQ4PB6YugWs6YdTHB22fSIzfWFIlMtJH4L3UMMw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:M34jjbjltmb5nAdWH7BjONaUfwns2frnFSPezN9IOJQ=:9JkvAwq+CuOIks00b+RwWa/WS6DC0yHOFBKisGVY8PI=;
X-ME-Sender: <xms:VHXfag2PW3QYziuIZXPVPQYsFyonmNbPybvLoO6Q3uxVoc1rjTtIlQ>
    <xme:VHXfauzX7uoUywQ-mth9dZty5xzBF03jin84SRSa2sGDBv3g2IcHdXPfgnmWSDLG2
    6EuqlCy3_vIMv0x-l_XzVyjGauCHLNObRy3YsClarAXWoBaun9NDotp>
X-ME-Received: <xmr:VHXfaitSA5zRSIksq9QTFcqTOSBNh53hoeWn-Qu-1EVYdZF9lW15lF0c9FlmeicDEm1b37CTKrILDf7i8eQbGtrtRk6vEAOEFw8_>
X-ME-Proxy-Cause: dmFkZTF7gE4KeFED0PKUInNGFXZZlu2//gdwypoUvl0PouX/o5OxqAkqWQEVb4vEIMAgBN
    LaGYtX37E2bpqAbwUEqM9LcuC6qFqEufPiZetWkT4vWU/VmN5SAH/I5ytglcAlJS2FAC5u
    OgYZorDzX2kPuvx1XhAMIHrm1wxL803tphd9Q5fT7JZoODaiAZVMaiY6moaDvBzf64Mynh
    qd205/4gOHMSSa71Vri4owuzsgmgsws4JAg99lekxx0n0sf5AoQJrGJAYm4SipecdtzDzs
    ti0HpwTB3aGT778mpF9dKD6GbUghZCOe1D+tEx+FsEMdVmlkOEnx8ms+A2YPSQQNwIJJkf
    ywHFJ/Mhw7YBOvLm+pZYA3qBqdWtdXLA8KK9frQXIrkaUPvNJu6wBWzIf9GomuYNpCxrB6
    V05PMxRs6BKaNcQ4pkX6cZrtIO+zdwCR1UZDY3GAzcKsbhxUSJnMlufoNePQnWqJXwjq//
    t2WDu/C0g2bLAV/rFs2jPBhEmdTaq0gt5ynfuc3pthrzLVt5z/u97+jVEo5JdZaSb7KwaZ
    8FfocUAXlVP3+X0tIA3TeNE0Jwyov3JtL0zFhZsCoQ860Uvf6EjtBzk4fk6jBWw3n1u1kr
    uJYZZr+PoNjWBmP6fwONLgw9/2qSMS7+igkBbE4MGHpuBFlWs3kgwfQec7ow
X-ME-Proxy: <xmx:VHXfagwOzlYgWf_C4tG4M1z8-zkapDAgfUncv3GordU_ca3VbKa3KA>
    <xmx:VHXfalCS4NecN-OGGmZGRccjsePO2XsZ6jFIK_AoK_kKLIYVJtXOoQ>
    <xmx:VHXfaudKAn_fk1tQHjup2YCZ4h7tqAqRPYyjvDpp_HyJNH1JSmKVnQ>
    <xmx:VHXfavnkQZCCMjGAQJlBiTX4Unu3EGW0l9ms3-4CGIjAvHAI_xzg5w>
    <xmx:VHXfanY66k_ESd1MlaLpvcO_-JiKF6254XlKhKHS_-I_Te2cIGkQuuON>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 11:44:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 0/5] fetch: avoid fetching every branch of a new
 remote in a shallow repo
In-Reply-To: <101723fc-d392-4000-b224-345c610b2aaa@gmail.com> (Phillip Wood's
	message of "Mon, 26 Oct 2026 09:43:07 +0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<xmqqcxt02eoa.fsf@gitster.g>
	<101723fc-d392-4000-b224-345c610b2aaa@gmail.com>
Date: Mon, 26 Oct 2026 08:44:18 -0700
Message-ID: <xmqqh5i8tqjx.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've just read through the commit messages and documentation changes and 
> I think it is a mistake to use a single config variable to configure 
> where fetched refs are stored and which refs are fetched. The problem 
> this series tries to solve is that the default refspec fetches all the 
> branches from the remote and it's not possible to use that mapping and 
> also restrict which branches are fetched. To fix that it introduces a 
> new config setting to configure where the refs are stored which is good, 
> but it then uses the presence of that setting to implicitly configure 
> the default set of refs to fetch. To me that repeats the mistake of the 
> existing fetch config.
>
> It would be much more flexible if we had a separate config setting 
> (maybe remote.<name>.fetchRefs) to describe which refs are fetched.

Good point.

When I wrote the refmap feature (without configuration variable)
long time ago, one of the goals was to allow me to say

    $ git fetch cabal \
        --refmap="+refs/heads/*:refs/remotes/cabal/*" \
	maint master next

That is, "here is the place I grab from there are stored" and
"maint master next are the things I grab from there" are specified
separately.  With the configuration variable added in this series,

    $ git config set remote.cabal.refmap "+refs/heads/*:refs/remotes/cabal/*"
    $ git fetch cabal master next seen

should become possible with the same behaviour.  I am not sure
offhand if this series does that, but I would consider it a bug if
it does not.

In any case, this series, since it lacks the separate setting, takes
the lack of "what to fetch" on the command line (and perhaps lack of
remote.cabal.fetch???) as a sign to trigger this new feature to
guess what to fetch based on what is tracked by the local branches.

For now, as this "what is tracked by the local branches" is the only
kind of smart that was designed to decide what to fetch, it may be OK
to use "you gave me nothing to specify what to fetch, so I'll guess
using the smart".  But when we introduce more kinds of smart later,
this becomes a problem.  So I do agree with you that we should have
something to specifically say "when I do not explicitly give you
what to fetch, decide based on what local branches track".

> That 
> setting could accept something like "*@{upstream}" to "mean fetch the 
> upstream branches of my local branches that live on this remote" which 
> would cover what this series wants. I think it would be useful to 
> support "+" and "^" prefixes on the refs to fetch as well, so that the 
> refmap config controls the mapping and the "what to fetch" config 
> handles negation and forced updates on a per-ref basis.

The reasoning here is slightly wrong.  "^" (not) may be good thing
to consider as it is to decide what to fetch, but "+" (overwrite)
should be on the refmap side, i.e., where to store.  If you are not
storing, then "overwrite what I have with non-fast-forward" becomes
a nonsense request, and that is why it does not belong to "what to
fetch".
