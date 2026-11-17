Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794956514;
	b=3sgl8gttcGwnRZr//66k6qLnF5R6yFVkzd+P8lFO180fDQMvDT8rGNwNor1/SeYGVv6H
	 iyoRO3PGc6P5NIFaF/VQ9dnR5Rc89qcqamCCLxtxoCRYLEwS6ZoJocuNkJCglVrn3Aak3
	 OBMUnrti7jgUyDLRJGzuc/10sgjjCauisE8e8X2g7kYZKVctNks6EXLdt2cYMmZ6w7MFg
	 00dvY6NaioX/eCKP8ZCjSntzSnpo4tJrWeS1nBzENJgC9H36b1Sn13VkErv7xj95k07EL
	 BgVOud/3/PNSsCTi2t+jT4KtoLUBS3B93HMnaK+e7EYxFjfV8Veve2L4bu1lewF2ubw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956514;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NI9o7yLyU8t2isFYNvb5aOlHxy+SQ4u67tOLzaNWioY=;
	b=fWiM8zIs6ntMZoUGqqb5YF6YeKG0fwuo/Hh9iSIflp4fGaIBAPlll6Ef82Fo3Qjl758/
	 rH+kxTDoZdFzeJ0CN0sJ+Mj18j64YmIFs8RmGPA8HZTqj1atQoIIHB2VLMMV7SVkGmwV9
	 M75mn2suY18JEQNxwZkc748ZVpRa5Z6BaydOV3Q4pZWpR9iE89MRFPWznUQB1nFqmlClG
	 e3DgXna6cyxzxzyzI/drclJjlHtoSNvuWMDzGjn2u4TzVO6Pp4ai4xEde2/9eKPolG9ml
	 jqpPqhl+TfGeDf3sMZxViLzHD3tRcovkd5ih5er6J1YGtvmMPOvXdpcp479jELL/bPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kv4yT2c2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kIf7iEN+;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA38606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 23:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DA38606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kv4yT2c2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=kIf7iEN+
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4E7C47A0223
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:01:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 17 Nov 2026 18:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794956512; x=1795042912; bh=NI9o7yLyU8
	t2isFYNvb5aOlHxy+SQ4u67tOLzaNWioY=; b=kv4yT2c2L0kgCPrpFmNnT3fm6d
	NXkIPOv2/GleEPBlTlHWneshh5lTH64cyH9vK9dX8kU2ijdlQtR468W5lc2ooDOJ
	fBJ2DYZAnhy2RuHPUoatB6tdV1jSoLD9zSEy8Igv7ifTQCZ+7tA9tdsWoYS5KVSL
	cZCuJGrxh5S1T/HlPkCDTguFebcU8UzpjZ06LabfLCiKw6Il+3P7YBfHuplpw80z
	G+l539z0Y0sm/7D26pmNMQU+dRQBsQfvfzQwiPWhK4jbJOyqEZ/Ri9owjxjuOJAa
	zaNfI8iPbmyoHz9aX1ho6I6y36Q0TscUiY2AyvgFhzkc9hyoSShFV0O0uPag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794956512; x=1795042912; bh=NI9o7yLyU8t2isFYNvb5aOlHxy+SQ4u67tO
	LzaNWioY=; b=kIf7iEN+3MYs/8ZhhCf3zGdcBczvauQEB5zqIAXX9PaqqaSKLQm
	JTghcotfW5HzILDzir8fbVKcJT0mxP0Yl1e7GR4NtJqWn3NbhMLBFHsBbr1b3MWk
	Ivxblotu8adNnnOaFmNfQRDJLJIP/l6tD0fPUmVg7YnrKrUx1ZBFZIVf+Dfqn7OU
	4zbX3h4kqtf7V5ADmM+zkTaSpnQfvuZOznaTaPZfz6oKoDX7S4CYyTw7OQ7lfqwA
	joglSJ3NlxMuc9JmSKI3jyqLxZLhat07NfToAGKLj+FciU44pOrc1VQIYMJNEQTw
	jFEqAL78roqzXVaFsN4qKVc6gTnmtVwRjhg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794956512; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kxe+peA2Y0UoBCv4ahjSTXrTJdAL/CJ8lXTjbT7ywLVbGGa
	Bvmlx77YEXChSeHvokLWElG3aWetHLDLQVOHOrELlFc5HUrnjzOSkYClAzWsML0N
	ApfaryqIL6q2cXabggtXSOI1FtShlSbshCtfjSYQxr6VvIqFJkWlKtd2b42Pd+3v
	Kn32wdi+VM0SGq0UsM13L6zB7QLYH0Cg+gA9XUvfREFvJAkdrpFLFLPik2M0t+DN
	/haNXWfPZebuK8OhxYS6TnQBkBIDhx9wAKz+E31Gv4Vbtg0ToXxOksfkHkgC6KL2
	deDsIBnVaqx/8N87cWA6VE9feo0On/XQCErKz+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:julB+eXt5pEZQnkDLMI4ihSGgsZmCdIXY1TZguRkTKA=:NI9o7yLyU8t2isFYNvb5aOlHxy+SQ4u67tOLzaNWioY=;
X-ME-Sender: <xms:4Nz8atTUPvNoHb4nMMQdItASOPI0ZP8HN_eJk-GjP9Lwvoi3r-i2_Q>
    <xme:4Nz8atr8kyvtsrsobRDQfB3jR5fT7z2TM_CU741FlEqbrOCYkzHCxSnAdMD-mDOTL
    Lj-wN9hF3lZTGeHVRrEFimTRz9MEF6WZrjc_ipB55jL7OEjuOJQqYc>
X-ME-Received: <xmr:4Nz8arIXOUtNju-D0byvxjU3GkQ8NtL9d6AbvheBrHaJXhwu6zmZzxvhAsagkvZU25dF_Arz8Q5KEOf6qWxOFhIke3Cutag4712f>
X-ME-Proxy-Cause: dmFkZTEb+Uo3FrdZdEl9Jf7jVl9Bby5c3XXXv5SoWVQB1DULetpmRah20sEioSEx47xZLC
    eBdU1UICTMu9QL2rRAStOCYomCNQM5iDJIZK4jz6eW/KAaYkwBJeYXvVorO+cfWkTKk6EV
    44xQg1G/0XysxSiS1Y3HmzHtd73WO2ztNgKr4sX0IDT6BHv8AX/qwZVd/tR8X/SVoW0eo5
    0m5lGSulEOOnGO2Ah6wgpG0SZtbnK9UBuyzih+rZQ6iLaQsiblXZNGY9TBA00FVhcUfqaT
    8Sbi598ocHE7bWWsG6x1xp+czNYhwtrRr2TLIUK2GeEEEYZ6g09x9CNItsa5qrwPNjvGaz
    VbEvEHMUq+S5b9J2LCDCjzgIh9P+r1SukgcEWNgZeEmneasOQCjS86RF1nxIT5PryWsInE
    SzWc3aOado4ZYAU8bEzfoV5210N8AGJhoEs4fgaiNKgUJpsyyd5LFbO8OE8u9tesynuLHZ
    5kbwgj4tI0ZF8dKSJtI5rKQ0eLWzR2iJFUfxc7HgxTw4UNTvn+qkReLfKxSZgRolYL95v7
    VATrkfFxTHCwInG9yrAD20htfoNvbDKHHZtPmozy4Fh+YV5FVSPl+SnvPoYihMugGWppuY
    /iGZJjoC7rmTevK//6Yz3JwNdd/dbx0Y7agv1M+f1iTHVyirpPwt8AK/3kGA
X-ME-Proxy: <xmx:4Nz8agotUgzTG7_fUQn3qS4VPU7wuF3dyhdizE-AU_6ybi6toENh7g>
    <xmx:4Nz8ajzmwXk4NfX6x1xF-d9YYT3YPI53EhmSYjC8a3ahW9qQk7NMjw>
    <xmx:4Nz8akNJtVdKZdXrczUxCxf_AwXY128UujWh2cf2Ai7iLTDNRmdLpg>
    <xmx:4Nz8ao6r_zFntpbs5I5PxfBc3d22pt_HakH5xolT-dIY6o4wM87khA>
    <xmx:4Nz8anB-KZ0QkPUO5xZQs9aLLb5EE2tfItiXn_km6o97yl-arpzsuhA0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 18:01:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 5/5] notes: avoid truncating the size of concatenated
 notes
In-Reply-To: <04f320d1de82902c174ff300426815125e1054c9.1794914210.git.gitter.spiros@gmail.com>
	(Elia Pinto's message of "Tue, 17 Nov 2026 12:38:58 +0100")
References: <cover.1793355390.git.gitter.spiros@gmail.com>
	<cover.1794914210.git.gitter.spiros@gmail.com>
	<04f320d1de82902c174ff300426815125e1054c9.1794914210.git.gitter.spiros@gmail.com>
Date: Tue, 17 Nov 2026 15:01:51 -0800
Message-ID: <xmqqjymbawps.fsf@gitster.g>
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

Elia Pinto <gitter.spiros@gmail.com> writes:

> Compute the size as a size_t with st_add3(), and go through
> cast_size_t_to_ulong() when passing it to odb_write_object(), whose
> length parameter is still an "unsigned long". That makes us die on such
> platforms instead of writing a truncated blob, until the write API
> learns about size_t, too.

Nice to see use of st_addN() family of functions while we convert
ulong to size_t.

Looking good.
