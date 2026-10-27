Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793139771;
	b=qn8YQULmmsg5TSwtlPxfGH3e/CdGFPCtJa3ZTCrb4/8dx1+epLkfuEoQ9mP4BukaWOA9
	 iGg9Jb/yNJkM0wOoeBppWBQXSJbNvwykw5rI0UZk5OzxHtGNz/vSkpOOpaN00ibFEZnc/
	 FQumEdkNslOGnzff6R4nFCvQmzwdCG0GGbmJyOnEhShWaGbsjIlwGBeX/ViXpsgpPdcHX
	 NnOui+NkiErLO5PbR84xtV8VfPrDd+a7952znrSL3TPYsPPfKKVQVoqloiLE3XIkgSGd6
	 9CjfAa5J2zMp6l5dl4EWFweh1UMKywRaUvdDgkhXgUpKHO+ECrmsIvo0f8W3YcuiOYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793139771;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=20BI1coCmSdMUzIo+8HMviCg9dIvDMY1/hEiqS5HK8w=;
	b=v75hrwEPDrqQvn53z7i+d6ZVIraBmKC/uhQgd+qD152RdWALwyswqB2cskWFuWyBuFsx
	 oNBO8TusxDt1PCKaMCXX64qK7SaIFfqxcRkOfVyyuGE2co5xYO2h1Hmik+b5uG1yrdBTE
	 3b+nV2q01Hahr6OYzwSve5I+sOSD3Lzu/P+suO/JODAI3Z+kBNsRhCAVp4nRr6yxQTfHN
	 t2ESktg6stufMgDIURT8rZm9Xn0gk9mJ2C41J8Q54AkyZ7QI3bswPsgoQcroOlgNM+RC9
	 4ds3er8njVmYaPFC17+Eh/QqFVKCHt5jCUJLPNONZersp7Nw5EDc51XyJiyx+tZipsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pIEvxyQN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="GLwo/TyX";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E9E606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 22:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7E9E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=pIEvxyQN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GLwo/TyX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3C1E17A0166
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 18:22:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 18:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793139769; x=1793226169; bh=20BI1coCmS
	dMUzIo+8HMviCg9dIvDMY1/hEiqS5HK8w=; b=pIEvxyQNk8d7NRfIcWrlaGQY8F
	sRB7euEao0u8GGN6b+sSJMGB2bVC0Xuq9pjS9p3ORJWhvNkSIL66DUcwY57m8692
	UaWruA+Su1kaJV9rCJX2woFCVm1fEw8olnzoamu9PIU7uqJhAKb2j9RKZiLWeeie
	7NHCfXCWbCtg5OH3nUPBrVj6lVgJZlBbB42xvQIYNRs7lX8XbFZm+BK4lIKA3Iiy
	mAOTNsFafvLd6xu1nZUK1mB+a96wWEwmgoYjg+Ujq+aAoZaTTXo/+K9dnuKIUIMX
	tFyDebLhnSneeBo5KdTxKlzyguh6eiJgFWtKrpVArMw+Yqu8+/8Nq3SeKUmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793139769; x=1793226169; bh=20BI1coCmSdMUzIo+8HMviCg9dIvDMY1/hE
	iqS5HK8w=; b=GLwo/TyXurAP816QZUyUAC6l9SnoRVSCG9ZEcZcc0z0eCecoqie
	42bzpEkSDF4kPe13YRUHsreiVnf3dqhYiBGb9WFaFImSQ1D5bOxTOYr4Ve7b3RCk
	QkCQegIvOXzVlZFODO5ZSisDuidCSImfShmxE8Cuhn27iCyGPR2EvnGk7zJx0btl
	dQr59MwzBTqW9TgeMEQe4Z80p3+wIa9lc22k8W5xpLG5Iw9OF9i223si224RGHww
	ZnN4a1Mc9rjSIUvNCiiAHVwkr+JQAIA9p+vtdqyP6bLlcPB7UBZvyS0IBOUKpi/3
	GqM7lPvpj0Io+cBa8Bz+E8Bdo9proe8OX/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793139769; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:GSk9Mz1+w62Q8albmRUdxSEot5MPrfLbjLi+oexBLicMNbC
	RCy5Hl7lUUV76LDbVjQLLVWpGAn1UI6rC6uNyYALDq/jil16G4puel4z1ZmX+5wd
	h61uSgchLu+4YmdLoZyDmt4W/yelxDq+SfmNLisCpLIUzvMT/nU9ZhjYYk0kXG2y
	mCOqu6MqAi4lU/oNZTaLSsfmrdHJYiPqM40Kgj3fqllLevry6i1FYZLP/Hj/HQ4B
	Dn7J2J9iYNGRMnBaGPjTo6cxcpe0cEn8x/uym1uvADxm62sZzhG+yqRu+wAFQAd/
	L58QIv1HGiT/0qiaZ9xEATkSuCW7qnigN45HHsg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+Aw5GmkGeEiSZ2PV2AoxZU8Zzev5PjXiu9F9ofEqkic=:E1iBp7U2zW8yYr7l0wodpuD8FM+p2purW3WodzaOLto=;
X-ME-Sender: <xms:OSThale8tfRcRZEM_v3VVtEbHWQ2vM1jT1BfqmRNGDlHfk2JVz0kDA>
    <xme:OSThaiRWNBkB3UPEeZIUcK9ar0ycZMk-Vtfnlnv9UnghhVHEpRPqp4-1JkEltPd-d
    1R46HJrNkPugbGCZFn9y-M-k29b14Er-imvFg2x7Z9iQztmG9AdXeA>
X-ME-Received: <xmr:OSThakvDafWcANOOZCaBDbl8Dim6LRwbPZo5Xgi6CFI3vsr2uNJ7HBP6-RSUzcHtf9AJ-ZNXgABw9xJSj-qtV5lMWdd01CcdHoiU>
X-ME-Proxy-Cause: dmFkZTGS/d769ZeekagL0l73fhIgmv6sq718LOtOYe8T3284ti2SjllX6lRYsDGQkt4eEb
    foHGp2xtDpViMlqmAfQGBpIXF2uwo2hrVrz2UDOfeSPMYfquPCrrRzkmhM65L7FENZ43UF
    udOeQ+YldKH6NUI6aAUovW943eaUx3UXfJV/UpqTMu34mBCXsSX8PWpB00dr5a+O4E7Ixi
    NyyVgF0MIzWoUoYk1IxUUAs6mRgruo7ZQkpep6wXK+sVHeNXpn+NJ+tYUAnauOqvi6Rvqb
    f7txmdiomjlv8xGzAbs1RPHb7RloX1sCD1j124/JRZjKOFQoFDzuyE/BVH7kQVPXpDJ/kt
    9jlNs/dtA8s7m3LXL8k5KKoERLmTYO+XzZH5E1P+M3A9OC3Y1WkPc4tc4nBeJK7zUyNZBN
    nGkg3mOX+reJdmHiphc1p9ScEzpqkRd86kLPu9yg2jwmoFsE3flZn/tl1nxs7pV80cgrb+
    /GXxBUBYk7C20z6bEZdE1CMta3CI6a6gwWqDvVUnrAqBZqADzu+fzsR0+2pPYuAUyjUrBr
    wJ23aTEr4fyog/CR5bcIyU9Y0XL6fw829JBqPDwUkrGXK6KoVXZeW1TL1LJG31imfwb6EO
    97dO80KVIMJQBavrQJmmxfKZV0Or7quOjbxHynU85j45dKW6weSGQ1qrQcOg
X-ME-Proxy: <xmx:OSTharemigu5Fl31dpLoaHGQYscL0z1snCHZO7LITutlkGLBXWaN9w>
    <xmx:OSThamb0wwZbMjciN68oDiyRYYdw8naFZRbz96i_WXEYPmUwtOuVMQ>
    <xmx:OSThalaxwpEA2YwJMvpVi9jmH_Er45Z9fTGSbmWi5wpSLzQ5U_zPnQ>
    <xmx:OSThajIWRI34npa5s164fl9ZwuIVTqtHGAjPLKr1YKQWHIrn_Hgu2A>
    <xmx:OSThakDC36XEdPk9NlGa2RakwFITZ3GMjVLWHt5ALvqj03YqsPxOkAgS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 18:22:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Venkat Ragavan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
  Karthik Nayak <karthik.188@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,
  Harald Nordgren <haraldnordgren@gmail.com>,
  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Venkat Ragavan <mail2venkat21@gmail.com>
Subject: Re: [PATCH] refs: fix loose-ref seeking across directory boundaries
In-Reply-To: <pull.2258.git.1792067455341.gitgitgadget@gmail.com> (Venkat
	Ragavan via GitGitGadget's message of "Thu, 15 Oct 2026 12:30:55
	+0000")
References: <pull.2258.git.1792067455341.gitgitgadget@gmail.com>
Date: Tue, 27 Oct 2026 15:22:48 -0700
Message-ID: <xmqqzevyg4w7.fsf@gitster.g>
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

"Venkat Ragavan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Venkat Ragavan S <mail2venkat21@gmail.com>
>
> When seeking through loose refs, cache_ref_iterator_seek() compares
> each directory component without its trailing slash. This can confuse
> a directory with a similarly named ref that sorts before it.
> ...
> Add regression tests for shared-prefix names, missing nested markers,
> and markers beyond the end of the ref listing, using loose, packed,
> and mixed refs.
>
> Signed-off-by: Venkat Ragavan S <mail2venkat21@gmail.com>
> ---
>     refs: fix loose-ref seeking across directory boundaries

I overlooked this topic, but re-reading the discussion, aside from a
test that confused a reader, it seems the topic was already ready to
go?

Any objections to the idea of making the topic ready for 'next'?

Thanks.
