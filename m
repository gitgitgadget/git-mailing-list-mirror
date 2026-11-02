Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609483;
	b=T8B86qiQ98psJyIymvxZsx0SQkYFwhk0XPFDGa5mXIYVgMpDcQTunpvnNi588JBJQwWZ
	 VjG+Yx8XuJiWJsDjLfLuwRAjSvaV5yiRGBixY+uPxNPgSHOUaYcS9lqt/5MExd/PQifUT
	 TQipnpDHTqBHH1MLQs1G7wGEtDN+jlOte6fwZI5Xz5zuLCEuvxTlh10zHnuUqawPtsJAl
	 vUR556cLO+li7A7ytOSgw2b5v+Zd85wqX5E4QdQjeExn87IBNVYkfAcmUW3qNCa1+oImH
	 QiAoR06XfCiYVls6lfK/Gdt53UToVAwT60tgm6+N2FUVNRs2LGWAghUd3+n8fi/MSLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609483;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ryS/rsUgAefTlxqV0Xq6RKi/LvqsYwwvJ1qdj4AVeiA=;
	b=yq1FbZ8jfgkZF+zChZpZEzSo45rC11ytu1qxf96LM7svS15AJfgXCwcAAReuaY4pIb8c
	 dajxAn+4ZZ4V3Bk4dWozkbOEVzEofZ0xC79ogPLdNwRV9DKSYWABWken9NOiA4OQb+JOT
	 nBT4rIkKzRSPvqpO2mtjdZrX0wWKcuJ+LQfuNp4VBBoZuPcdTWztQaR0yFYQqaKZCAX83
	 kvI0YYRvZbaOZ5PfQQfIM/qhzZndhQlPrnfWK+4yJYUJC49VdvioQwNCa7Bl9MkYtr0Um
	 BuqN7SbIyrwMfPHcH3IgC0zRhQc89LblOk1HDFuBCH6ulZI8BbohWM+9ESKyUKbvlUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cVo7tBIT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uRS89VIU;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F2606A330
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 08:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 488F2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=cVo7tBIT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=uRS89VIU
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9429D7A00CC
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 03:51:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 02 Nov 2026 03:51:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793609482;
	 x=1793695882; bh=ryS/rsUgAefTlxqV0Xq6RKi/LvqsYwwvJ1qdj4AVeiA=; b=
	cVo7tBITh7MHZn17h7oGFg8e/YXfRq79hv1XKz0LTnci5X/7DEMwzMFsU2cePAql
	m3LqqeQgbeZ7rtujwwgeGnxaQgRWc0ZSrQBzZJrmJI3hHEw+rEkPzPMPaMMBC2Ta
	aG1WCW5BDxG41C05BVzUEXAa/S1xJePNzRM/PzT8qn27K85nBRYN9RFYv8J4fYIM
	nj5d7pAdkbqU5exUlovpMyIJfhGdR66FA1s+Pimyfc7M8s1WaKPbNy+PcWr2IvoR
	8rm/pqWMV8DHS7tgoMuKY4eOs4raqY8EFGDsOET09BV0vvVd4USATSBHIzRfY5Za
	CcyhIhG9XhLGvcBanmqsbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793609482; x=
	1793695882; bh=ryS/rsUgAefTlxqV0Xq6RKi/LvqsYwwvJ1qdj4AVeiA=; b=u
	RS89VIUlj3XXwmxuuE+JzA62F83ouBEvwL2RuwJEaRPLO67jE9ovFo15CeGT0v0N
	FadHl6QDE5nT2nBn8l/1uBMvghp/ZFF4vdGM/ytAwf0HfdbNqB1u/k27KQUPGbkM
	mB//CQB4xY0XCWAlgwv+SV3mncHwAoDZaA3OIvuoT3VHo/bC+M5VsqOqb8EFJgs7
	YcZ+gczLrkhpI+v8UKV0r3Oir2W/OjIr7IRokPyUq0uK7sjVOP9obcWPEVfuBEhA
	Jdz3u803/A7gsWRM2HVpqR/wXisn/s/mFXaeEXymEzVTMmlkFi8DYRN2b2v6VDLh
	Y8qaLXLptmiwxVtPDH0/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793609482; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:V9XF+lLqBnTz/Dov58vzwpEnmG/2QK8PVLINxeqeALHW+kd
	G3Qo2QGzFvoF5qX0CtNGDqyaxTGciShKowN5jSVSYsRzp2N2SnR7XZ2D5UCx5x2g
	SUyX1rwB4HWZ16+7JjbSsPFeo7/Ei/WgivZLeI9XDHb7t+fbSO1CG0qGtrEYbGXW
	8xu37jIKHaERDPOz1ZmSLzWDPwylfU4hBKrd0GeHLatPD5aUm4m5rUwYsAC3gL7t
	rghcs9v7NMx+2cLWA0Kd6pry44x1VKLU9VYO/VFXDtnu33Du9zf8hPJ+mOv4KqGs
	1gEOoKDAoRpMsEpXbVgVlvPHqOSmK9WuTNI3MIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:LkjpEj/FwaUt6fKhQZOhSuU23xwP/v+cko1ZDWCd5tE=:vKGJvPb1vaEKSfRykfDyNTab/bwjr6kRwTs+OfTQ71M=;
X-ME-Sender: <xms:Ck_oaqCnOJ1he0L5Ye7zQSpsNNyOO_shEOIo7BXKzx-tIxbMXWwEtQ>
    <xme:Ck_oarjfZ4J5kOuPGsxCdw3oFYIRRSuhOZTEwIVpbq-Y4wAbUv2SuTkrJdgkN_Pwz
    cGUNdmxNxpRqNB1EIcH1dA1GN5_R4Ji668GLAVq7QQpmTxq6fhrKlo>
X-ME-Received: <xmr:Ck_oaimfwxTsmS5v2SNzrHMIwEh8Q7cVehfu7XJssNCn8vwVzw1ZjkqQLfrGARcSTYGKxc-vMtPeR4aMuVOBpEJopNLQYd3PpuJx>
X-ME-Proxy-Cause: dmFkZTFEdevR4fO+3/Fg8v9WQBYRThYV+wmjqS9jJbdbM23mMB9N3ijVWacML7rwXU61gl
    +7feDOY2d2p+xp1Rc5R78Vci66OQSwX5TfbxRT1Ki/D78QtaImFZpL2zXG42ekrW1Eu2Qy
    mduomghEWyNnsfW6M0RhMOt95TMftCsbayCnEgwjCRKpV6TJRIp0rNqu0f+7EUOvnnCEIY
    Y+WNh9rw0EcRZQ2Do/O7UL4kdCCq57JUqnH7oyNQ4TmjFsOJYU4hq6TIe41m4w1fJyH5rC
    vKZkmrGwsKqkIMCfsJEIC20WPLIVusjAW0uGxycaVIoVacLo4+MiczHhD+7/OmHLqp4xRx
    qfFW59IqoAt4vqTdgc+vTDMYlXss/uWoZ0htUteIez/gEl0KGgxJf4Dr54u/VVsPZ6a7mf
    m0YGRgCjE3rBFcyxs4UM1JRof55FIuxtqTbJavWdeUDNzPEXFqPZgPBQCyYusuHbEONZao
    8PATckElZuJqiTEoPRUOQ8iljMTrtliIb46jgK6YVM+ENMIZw4TBPBPsdhMcxgi0sSNtID
    0+v4N+jCRMwHRs26Wajqu3Hh2lliygmPeZotB/R+ZxLGreEQpegXQRVe1AZLIwBpdobDTq
    M4wUDAfw9vWsYYXGrBPrBQNY4TVGYsgngEc/j+Oey1+lnmDev/XjfJ8idLag
X-ME-Proxy: <xmx:Ck_oanqoNbn030jERfpksnSTq24HuQyKV63HfF0U2UPCUonlXcEt5Q>
    <xmx:Ck_oarGN79qj0D7s6glGVsitx14PsZEFGF6GPIL4obtcyFchzoKRsA>
    <xmx:Ck_oajyoDt2XUMRnmAqXqNpx-m3wwUrQoDxx25KlrxweqdnAGz1i1g>
    <xmx:Ck_oagqdnvEFxNKS13r0oPHvmaJGhkCjFXUy-AgcL7vd0YLFJQaD9A>
    <xmx:Ck_oakZ8gGgX0rgjwWZAL5QDcf0AZw8D0_caIF2_o-XNcIn6T9bepHFQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 03:51:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: kristofferhaugsbakk@fastmail.com,  Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
In-Reply-To: <xmqqse40ei5f.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	26 Aug 2026 13:33:32 -0700")
References: <CV_format-rev_three_more_opts.b80@msgid.xyz>
	<V2_CV_format-rev_three_more_opts.bd3@msgid.xyz>
	<xmqqse40ei5f.fsf@gitster.g>
Date: Mon, 02 Nov 2026 00:51:20 -0800
Message-ID: <xmqqo6c7mx9z.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> kristofferhaugsbakk@fastmail.com writes:
>
>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>
>> Topic name (applied): kh/format-rev-more-options
>>
>> Topic summary: Add three more options for controlling the formatting. Also
>> do some minor refactoring and text fixes as preparatory steps.
>>
>> § Changes in v2
>>
>> See the patch notes for details.
>>
>> • Use designated initializer syntax. That’s more readable since you pair
>>   the field with the value and you can omit zero-value fields.
>>
>>   https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
>> • Fix useless `BUG` placements https://lore.kernel.org/git/xmqqfr0hswxm.fsf@gitster.g/
>> • Add preliminary patch “place BUG calls first in callback” for existing
>>   `BUG` statement placement
>>   • Based on the previous point
>> • Patch “learn --abbrev, --color, and --date”: test a few more options
>
> Nobody is interested in reviewing these patches?  They looked more
> or less OKish to me, but I am not the best person to review this
> series, as I do not see much point in this experimental command.
> It would be nice to see reviews from those who are more invested
> in seeing the command work better than I am.

Second call.  Anybody?

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.

Thanks.
